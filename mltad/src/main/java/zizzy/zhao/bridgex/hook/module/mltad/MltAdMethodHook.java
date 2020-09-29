package zizzy.zhao.bridgex.hook.module.mltad;

import android.os.SystemClock;
import android.util.Log;
import android.widget.Toast;

import com.mltad.liby.adspace.reward.MltRewardOption;
import com.mltad.liby.adspace.reward.MltRewardVideo;
import com.mltad.liby.adspace.reward.MltRewardVideoAdListener;
import com.mltad.liby.adspace.reward.MltRewardVideoLoader;

import java.util.Arrays;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;

import zizzy.zhao.bridgex.hook.XCMethodHook;

public class MltAdMethodHook extends XCMethodHook {
    private static final String TAG = "MltAdMethodHook";
    private static BlockingQueue<String> block = new LinkedBlockingQueue<>(1);

    public MltAdMethodHook(Class[] srcArgs) {
        super(srcArgs);
    }

    @Override
    protected Object executeHookedMethod(MethodHookParam param) {
        MltRewardVideoAdListener listener = new MltRewardVideoAdListener() {
            @Override
            public void onVideoCached() {
                Log.d(TAG, "激励视频 onVideoCached");
            }

            @Override
            public void onAdLoad(MltRewardVideo rewardVideo) {
                if (rewardVideo != null) {
                    if (rewardVideo.getExpireTimestamp() > 0) {
                        Log.d(TAG, "激励视频 onAdLoad: 广告加载成功 expireTime = "
                                + (System.currentTimeMillis() + rewardVideo.getExpireTimestamp()
                                - SystemClock.elapsedRealtime()));
                    } else {
                        Log.d(TAG, "激励视频 onAdLoad: 广告加载成功");
                    }

                    if (rewardVideo.hasShown()) {
                        Toast.makeText(getActivity(), "该条广告已经展示，请重新请求", Toast.LENGTH_LONG).show();
                    } else if (rewardVideo.getExpireTimestamp() > 0 && SystemClock.elapsedRealtime()
                            > rewardVideo.getExpireTimestamp()) {
                        Toast.makeText(getActivity(), "该条广告已经过期，请重新请求", Toast.LENGTH_LONG).show();
                    } else {
                        rewardVideo.showAd();
                    }
                }
            }

            @Override
            public void onAdShow() {
                Log.d(TAG, "激励视频 onAdShow");
            }

            @Override
            public void onAdExpose() {
                Log.d(TAG, "激励视频 onAdExpose");
            }

            @Override
            public void onReward(boolean rewardVerify, int rewardAmount, String rewardName) {
                Log.d(TAG, "激励视频 onReward");
            }

            @Override
            public void onVideoComplete() {
                Log.d(TAG, "激励视频 onVideoComplete");
            }

            @Override
            public void onAdClosed() {
                Log.d(TAG, "激励视频 onAdClosed");
            }

            @Override
            public void onError(int errCode, String errMsg) {
                Log.d(TAG, "onError: 激励视频加载失败: " + errCode + ", msg: " + errMsg);
                Toast.makeText(getActivity(), errMsg, Toast.LENGTH_SHORT).show();
            }

            @Override
            public void onAdClick() {
                Log.d(TAG, "激励视频 onAdClick");
            }
        };

        MltRewardOption rewardOption = new MltRewardOption.Builder()
                .setOrientation(getActivity().getRequestedOrientation())
                .setSkipLongTime(true)
                .setUserId("userid")
                .setRewardName("金币")//奖励的名称
                .setRewardAmount(3)
                .build(); //奖励的数量

        MltRewardVideoLoader rewardVideoLoader = new MltRewardVideoLoader(MLTADCfg.MLTAD_REWARD,
                getActivity(), listener, rewardOption);
        rewardVideoLoader.loadAd();
        return true;
    }

    @Override
    protected void endHookedMethod(MethodHookParam param) {
        Log.d(TAG, "endHookedMethod: method=" + param.method);
        Log.d(TAG, "endHookedMethod: args=" + Arrays.toString(param.args));
    }
}
