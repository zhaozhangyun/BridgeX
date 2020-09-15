###
-dontwarn zizzy.zhao.bridgex.multidex**
-keeppackagenames zizzy.zhao.bridgex.multidex, zizzy.zhao.bridgex.multidex.**
#-flattenpackagehierarchy zizzy.zhao.bridgex.multidex

-keep class zizzy.zhao.bridgex.multidex.** {
    public protected *;
}