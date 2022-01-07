package com.sdr.simpada.simpada;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugins.GeneratedPluginRegistrant;
import io.flutter.plugin.common.MethodChannel;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;


import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.os.Bundle;
import android.os.IBinder;
import android.os.RemoteException;
import android.util.Base64;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.Window;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.RelativeLayout;
import android.widget.Toast;

import androidx.annotation.RequiresApi;

import com.vfi.smartpos.deviceservice.aidl.IDeviceService;
import com.vfi.smartpos.deviceservice.aidl.IPrinter;
import com.vfi.smartpos.deviceservice.aidl.PrinterConfig;
import com.vfi.smartpos.deviceservice.aidl.PrinterListener;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Map;

import javax.microedition.khronos.opengles.GL;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.pac.print/edc";

    private static final int INTENT_PORT_SETTINGS = 0;
    private static final int REQUEST_ENABLE_BT = 1;
    private int mPrinterId = 0;//, iTry=0,
    //private int iTryConnect = 0, maxConnect = 3;
    int error_code = 0;
    String error_msg = "";
    boolean isSetting = false;
    int jumlahPrinter = 0;
    int tryPrint = 0, tryConnect = 0;
    int a920char = 32;
    private String serialnumber = null;
    // Context ctx;
    public static IPrinter printer;
    boolean printerSvcCall = false;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if (call.method.equals("connect")) {
                        initPrinter();
                        result.success(printerSvcCall);
                    }else{
                        String payload = call.method;
                        printData(payload);
                        result.success(error_code);
                    }

                });
    }

    private ServiceConnection conn = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            IDeviceService idevice = IDeviceService.Stub.asInterface(service);
            try {
                printer = idevice.getPrinter();
                System.out.println("success get printer connection status");
            } catch (RemoteException e) {
                e.printStackTrace();
            }

        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            System.out.println("success get printer disconnection status");
        }
    };

    private void initPrinter() {
        //connect printer
        Intent intentLib = new Intent();

        try {
            if (printerSvcCall == false) {
                ComponentName componentName = new ComponentName("com.vfi.smartpos.deviceservice",
                        "com.verifone.smartpos.service.VerifoneDeviceService");
                intentLib.setComponent(componentName);
                boolean isSucc = bindService(intentLib, conn, Context.BIND_AUTO_CREATE);
                System.out.println("printer status "+ Boolean.toString(isSucc));
                if (isSucc) {
                    printerSvcCall = true;
                }
            }

        } catch (Exception err) {
            err.printStackTrace();
        }
    }

    private void printData(String payload) {
        JSONObject json = null;
//        JSONObject jsons = null;

        try {
            Bundle format = new Bundle();

            json = new JSONObject(payload);
//            jsons = new JSONObject(payload);
            JSONArray items = json.getJSONArray("items");
//            JSONArray item = jsons.getJSONArray("item");

            try {
                //base64 load photo
                byte[] decodedString = Base64.decode(getIntent().getStringExtra("logo"), Base64.DEFAULT);
                Bitmap decodedByteLogo = BitmapFactory.decodeByteArray(decodedString, 0, decodedString.length);

                Bundle fmtImage = new Bundle();
                ByteArrayOutputStream stream = new ByteArrayOutputStream();
                decodedByteLogo.compress(Bitmap.CompressFormat.PNG, 100, stream);
                byte[] byteArray = stream.toByteArray();
                decodedByteLogo.recycle();

                fmtImage.putInt("width", decodedByteLogo.getWidth());  // bigger then actual, will print the actual
                fmtImage.putInt("height", decodedByteLogo.getHeight()); // bigger then actual, will print the actual
                printer.addImage(fmtImage, byteArray);

                Log.d("resi_logo", "Logo add to print");
            } catch (Exception err) {
                Log.d("resi_logo", err.toString());
            }

            //HEADER DATA ------------------------------------------------------------------------------------ 2
            try{
                format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_DH_24_48_IN_BOLD);
                format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.CENTER);
                printer.addText(format, json.getString("header"));
                printer.feedLine(1);

            } catch (Exception err) {
                // Log.d("errorFormatting", err.toString());
            }
            //HEADER DATA ------------------------------------------------------------------------------------

            //TITLE DATA ------------------------------------------------------------------------------------ 3
            try{
                format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_DH_24_48_IN_BOLD);
                format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.CENTER);
                printer.addText(format, json.getString("kode"));
                printer.feedLine(1);

            } catch (Exception err) {
                // Log.d("errorFormatting", err.toString());
            }
            //TITLE DATA ------------------------------------------------------------------------------------



            //INFO DATA ------------------------------------------------------------------------------------ 4
            try{
                format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_24_24);
                format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.CENTER);
                printer.addText(format, json.getString("info"));
                printer.feedLine(1);

            } catch (Exception err) {
                // Log.d("errorFormatting", err.toString());
            }
            //INFO DATA ------------------------------------------------------------------------------------



            //KATEGORI KENDARAAN DATA ------------------------------------------------------------------------------------ 5
            try{
                format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_24_24);
                format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.CENTER);
                printer.addText(format, json.getString("tanggal"));
                printer.feedLine(1);
            } catch (Exception err) {
                // Log.d("errorFormatting", err.toString());
            }
            try{
                for(int i = 0; i < items.length(); i++){
                    format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_24_24);
                    format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.LEFT);
                    printer.addText(format, items.getString(i));
                    printer.feedLine(1);
                }
            }catch (Exception err) {
                // Log.d("errorFormatting", err.toString());
            }
            try{
                format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_24_24);
                format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.CENTER);
                printer.addText(format, json.getString("line"));
                printer.feedLine(1);
            } catch (Exception err) {
                // Log.d("errorFormatting", err.toString());
            }

            //NO PLAT DATA ------------------------------------------------------------------------------------ 5
            try{
                format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_DH_24_48_IN_BOLD);
                format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.CENTER);
                printer.addText(format, json.getString("info2"));
                printer.feedLine(1);
            } catch (Exception err) {
                // Log.d("errorFormatting", err.toString());
            }
            //NO PLAT DATA ------------------------------------------------------------------------------------ 5
            try{
                format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_24_24);
                format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.CENTER);
                printer.addText(format, json.getString("periode"));
                printer.feedLine(1);
            } catch (Exception err) {
                // Log.d("errorFormatting", err.toString());
            }
            //TGL MASUK DATA ------------------------------------------------------------------------------------ 5
            try{
                format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_DH_24_48_IN_BOLD);
                format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.CENTER);
                printer.addText(format, "\n" + json.getString("nominal"));
                printer.feedLine(1);
            } catch (Exception err) {
                // Log.d("errorFormatting", err.toString());
            }


//            try{
//                for(int i = 0; i < item.length(); i++){
//                    format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_24_24);
//                    format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.CENTER);
//                    printer.addText(format, item.getString(i));
//                    printer.feedLine(1);
//                }
//            }catch (Exception err) {
//                // Log.d("errorFormatting", err.toString());
//            }

            //TGL KELUAR DATA ------------------------------------------------------------------------------------ 5
            try{
                format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_24_24);
                format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.LEFT);
                printer.addText(format, "Keluar\t :  " + json.getString("keluar"));
                printer.feedLine(1);
            } catch (Exception err) {
                // Log.d("errorFormatting", err.toString());
            }

            //DURASI DATA ------------------------------------------------------------------------------------ 5
            try{
                format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_24_24);
                format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.LEFT);
                printer.addText(format, "Durasi\t :  " + json.getString("durasi"));
                printer.feedLine(1);
            } catch (Exception err) {
                // Log.d("errorFormatting", err.toString());
            }

            //PETUGAS DATA ------------------------------------------------------------------------------------ 5
            try{
                format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_24_24);
                format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.LEFT);
                printer.addText(format, "Petugas\t :  " + json.getString("petugas"));
                printer.feedLine(1);
            } catch (Exception err) {
                // Log.d("errorFormatting", err.toString());
            }

            //TOTAL DATA ------------------------------------------------------------------------------------ 5
            try{
                format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_24_24);
                format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.LEFT);
                printer.addText(format, "Total\t :  " + json.getString("total"));
                printer.feedLine(3);
            } catch (Exception err) {
                // Log.d("errorFormatting", err.toString());
            }



            //FOOTER DATA ------------------------------------------------------------------------------------ 9
            try {
                format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_24_24);
                format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.CENTER);
                printer.addText(format,"\n " + json.getString("footer"));
                printer.feedLine(1);

            } catch (Exception err) {
                // Log.d("errorFormatting", err.toString());
            }
            try {
                format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_DH_24_48_IN_BOLD);
                format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.CENTER);
                printer.addText(format,"\n " + json.getString("footers"));
                printer.feedLine(1);

            } catch (Exception err) {
                // Log.d("errorFormatting", err.toString());
            }
            //FOOTER DATA ------------------------------------------------------------------------------------


            // try {
            //     //esc.addSelectPrintModes(FONT.FONTB, ENABLE.OFF, ENABLE.OFF, ENABLE.OFF, ENABLE.OFF);
            //     if (getIntent().getStringExtra("font") != null && getIntent().getStringExtra("font").equals("besar")) {
            //         format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_DH_24_48_IN_BOLD);
            //     } else {
            //         format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_24_24);
            //     }
            //     format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.LEFT);
            //     if (getIntent().getStringExtra("cutpaper") != null) {
            //         if (getIntent().getStringExtra("cutpaper").equals("0")) {
            //             printer.addText(format, "\n\n\n\n\n");
            //             Log.d(DEBUG_TAG, "bukan cutpaper printer");
            //         }
            //     }
            //     printer.feedLine(1);
            // } catch (Exception err) {
            //     Log.d("errorFormatting", err.toString());
            // }




            //create enter
            format.putInt(PrinterConfig.addText.FontSize.BundleName, PrinterConfig.addText.FontSize.NORMAL_DH_24_48_IN_BOLD);
            format.putInt(PrinterConfig.addText.Alignment.BundleName, PrinterConfig.addText.Alignment.CENTER);
            printer.addText(format, "     ");
            printer.addText(format, "     ");
            printer.feedLine(1);


            // start print here
            printer.startPrint(new MyListener());

        } catch (Exception err) {
            // Log.d("errorFormatting", err.toString());
            // gagalPrint();
        }

    }

    // public byte[] getBytesByBitmap(Bitmap bitmap, int maxWidth, int offset) {
    //     Bitmap newBitmap = Bitmap.createBitmap(bitmap, 0, 0, maxWidth, offset);
    //     ByteArrayOutputStream baos = new ByteArrayOutputStream();
    //     newBitmap.compress(Bitmap.CompressFormat.JPEG, 100, baos);
    //     return baos.toByteArray();
    // }

    class MyListener extends PrinterListener.Stub {
        @Override
        public void onError(int error) {
            // Log.i("TAG", "deviceService onError " + error);
            error_code = error;
            error_msg = statusCode2Str(error);
            // gagalPrint();
        }

        @Override
        public void onFinish() {
            // Log.i("TAG", "deviceService onFinish");
            // suksesPrint();
        }
    }

    private String statusCode2Str(int status) {
        String res = "";
        switch (status) {
            case 0:
                res = "Success ";
                break;
            case 1:
                res = "Printer is busy ";
                break;
            case 2:
                res = "Out of paper ";
                break;
            case 3:
                res = "The format of print data packet error ";
                break;
            case 4:
                res = "Printer malfunctions ";
                break;
            case 8:
                res = "Printer over heats ";
                break;
            case 9:
                res = "Printer voltage is too low";
                break;
            case -16:
            case 240:
                res = "Printing is unfinished ";
                break;
            case -4:
            case 252:
                res = "The printer has not installed font library ";
                break;
            case -2:
            case 254:
                res = "Data package is too long ";
                break;
            default:
                res = "Unknown error ";
                break;
        }
        return res;
    }

    // void suksesPrint() {
    //     Log.d("tipePrintAccept", "sukses print end");
    //     Intent intent = new Intent();
    //     intent.putExtra("state", getIntent().getStringExtra("state"));
    //     intent.putExtra("result", "sukses");
    //     intent.putExtra("printer_type", getIntent().getStringExtra("printer_type"));
    //     intent.putExtra("printer_address", getIntent().getStringExtra("printer_address"));
    //     intent.putExtra("printer_merk", getIntent().getStringExtra("printer_merk"));
    //     setResult(8, intent);
    //     finishAndRemoveTask();
    // }

    // void gagalPrint() {
    //     Intent intent = new Intent();
    //     intent.putExtra("state", getIntent().getStringExtra("state"));
    //     intent.putExtra("result", "gagal");
    //     intent.putExtra("printer_type", getIntent().getStringExtra("printer_type"));
    //     intent.putExtra("printer_address", getIntent().getStringExtra("printer_address"));
    //     intent.putExtra("printer_merk", getIntent().getStringExtra("printer_merk"));
    //     intent.putExtra("error_code", error_code);
    //     intent.putExtra("error_msg", error_msg);
    //     if (getIntent().getStringExtra("kickdrawer") != null)
    //         intent.putExtra("kickdrawer", getIntent().getStringExtra("kickdrawer"));
    //     if (getIntent().getStringExtra("cutpaper") != null)
    //         intent.putExtra("cutpaper", getIntent().getStringExtra("cutpaper"));
    //     if (getIntent().getStringExtra("font") != null)
    //         intent.putExtra("font", getIntent().getStringExtra("font"));
    //     intent.putExtra(Intent.EXTRA_TEXT, getIntent().getStringExtra(Intent.EXTRA_TEXT));
    //     setResult(8, intent);
    //     finishAndRemoveTask();
    // }

    // public void cancelClicked(View view) {
    //     if (view.getId() == R.id.btn_batal) {
    //         error_code = 19;
    //         error_msg = "Mencetak telah dibatalkan";
    //         gagalPrint();
    //     } else {
    //         Intent resultInt = new Intent();
    //         resultInt.putExtra("Result", "Not connected To Device");
    //         setResult(2, resultInt);
    //         finishAndRemoveTask();
    //     }
    // }


    @Override
    protected void onDestroy() {
        super.onDestroy();
    }
}
