MIME-Version: 1.0
In-Reply-To: <1516029691-8593-1-git-send-email-geert@linux-m68k.org>
References: <1516029691-8593-1-git-send-email-geert@linux-m68k.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 16 Jan 2018 10:24:03 +0100
Message-ID: <CAK8P3a290yWCt07tJ8iwySCvjDpgLBKpEoPRN3mbe+93Hmw-4Q@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.15-rc8
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Return-Path: <linux-kernel-owner@vger.kernel.org>
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 15, 2018 at 4:21 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

>
> *** WARNINGS ***
>
> [Deleted 568 lines about "warning: ... [-Wpointer-sign]" on parisc-allmodconfig]
> [Deleted 1319 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on parisc-allmodconfig]

parisc builds seem to have gotten worse than they used to in general.

>   + /home/kisskb/slave/src/drivers/crypto/inside-secure/safexcel_cipher.c: warning: 'safexcel_cipher_exit_inv' uses dynamic stack allocation [enabled by default]:  => 459:1
>   + /home/kisskb/slave/src/drivers/crypto/inside-secure/safexcel_hash.c: warning: 'safexcel_ahash_exit_inv' uses dynamic stack allocation [enabled by default]:  => 486:1
>   + /home/kisskb/slave/src/drivers/crypto/s5p-sss.c: warning: 's5p_hash_shash_digest' uses dynamic stack allocation [enabled by default]:  => 1539:1
>   + /home/kisskb/slave/src/drivers/gpio/gpio-max3191x.c: warning: 'gpiod_set_array_single_value_cansleep' uses dynamic stack allocation [enabled by default]:  => 324:1
>   + /home/kisskb/slave/src/drivers/gpio/gpiolib.c: warning: 'gpiod_get_array_value_complex' uses dynamic stack allocation [enabled by default]:  => 2644:1

This seems to come from s390 using -mstack-size= rather than
-Wframe-larger-than=, there are many
more of this one. We also have a generic -Wstack-usage= warning in
modern gcc with similar output,
so we could decide to enable that at W=1 if there is consensus that
this is a good thing, otherwise
it may be better for s390 to just use the default warning.

>   + /home/kisskb/slave/src/drivers/gpu/drm/drm_gem_cma_helper.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]:  => 115:21

This appears to have been introduced by a warning fix for the reverse warning.
The variable here is indeed a 'size_t', but there is apparently at least one
architecture on which the compiler's idea of size_t disagrees with the kernel
definition. Do you know which architecture caused this?

>   + /home/kisskb/slave/src/drivers/iio/industrialio-core.c: warning: 'name' may be used uninitialized in this function [-Wuninitialized]:  => 1307:8
>   + /home/kisskb/slave/src/drivers/iio/industrialio-core.c: warning: 'sz' may be used uninitialized in this function [-Wuninitialized]:  => 1308:2
>   + /home/kisskb/slave/src/drivers/iio/industrialio-core.c: warning: control reaches end of non-void function [-Wreturn-type]:  => 262:1

This should have been addressed by my patch that makes 'BUG()' never return
on any architecture, it's in linux-next now. Which architecture caused this?

>   + /home/kisskb/slave/src/drivers/net/ethernet/intel/fm10k/fm10k_pci.c: warning: 'fm10k_resume' defined but not used [-Wunused-function]:  => 2475:12
>   + /home/kisskb/slave/src/drivers/net/ethernet/intel/fm10k/fm10k_pci.c: warning: 'fm10k_suspend' defined but not used [-Wunused-function]:  => 2502:12

I sent a patch in October, no idea what happened. I sent it again now.

[-Wuninitialized]:  => 114:22
>   + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U  a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 100:33
>   + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 140>]' may be used uninitialized in this function [-Wuninitialized]:  => 119:32
>   + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 119:32
>   + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 100:33
>   + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 100:33

Ugh. Any idea on which compiler/arch has those?

>   + /home/kisskb/slave/src/lib/asn1_decoder.c: warning: format '%zu' expects argument of type 'size_t', but argument 2 has type 'unsigned int' [-Wformat]:  => 401:3, 432:4, 340:4, 205:2
>   + /home/kisskb/slave/src/lib/asn1_decoder.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat]:  => 515:2, 309:3, 401:3, 432:4, 472:2, 205:2
>   + /home/kisskb/slave/src/lib/asn1_decoder.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat]:  => 515:2, 205:2, 401:3
>   + /home/kisskb/slave/src/lib/asn1_decoder.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat]:  => 401:3, 205:2
>   + /home/kisskb/slave/src/lib/asn1_decoder.c: warning: format '%zu' expects argument of type 'size_t', but argument 7 has type 'unsigned int' [-Wformat]:  => 515:2
>   + /home/kisskb/slave/src/lib/assoc_array.c: warning: format '%zu' expects argument of type 'size_t', but argument 2 has type 'unsigned int' [-Wformat]:  => 785:2, 885:3

More of the above.

>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/auxdisplay/img-ascii-lcd.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-ath79.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/gpio/gpio-iop.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/accel/kxsd9-i2c.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/iio/adc/qcom-vadc-common.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/input/touchscreen/of_touchscreen.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/mtk-vcodec/mtk-vcodec-common.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/soc_camera/soc_scale_crop.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/media/platform/tegra-cec/tegra_cec.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/mtd/nand/denali_pci.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/net/ethernet/cirrus/cs89x0.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/phy/qualcomm/phy-qcom-ufs.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/pinctrl/pxa/pinctrl-pxa2xx.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/power/reset/zx-reboot.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in drivers/soc/qcom/rmtfs_mem.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in net/9p/9pnet_xen.o:  => N/A
>   + modpost: WARNING: modpost: missing MODULE_LICENSE() in sound/soc/codecs/snd-soc-pcm512x-spi.o:  => N/A

Most of the added modpost warnings got addressed already, I recently
took a look at whatever
remained at the time and sent patches for all.

>   + warning: "memcpy" [crypto/sm3_generic.ko] has no CRC!:  => N/A
>   + warning: "memcpy" [net/nsh/nsh.ko] has no CRC!:  => N/A
>   + warning: EXPORT symbol "___rw_read_enter" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>   + warning: EXPORT symbol "___rw_read_exit" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>   + warning: EXPORT symbol "___rw_read_try" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>   + warning: EXPORT symbol "___rw_write_enter" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>   + warning: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>   + warning: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>   + warning: EXPORT symbol "__copy_1page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>   + warning: EXPORT symbol "__divdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>   + warning: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>   + warning: EXPORT symbol "__muldi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>   + warning: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>   + warning: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>   + warning: EXPORT symbol "bzero_1page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>   + warning: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A

This seems to be a problem with the export-from-assembler patches that got added
at some point in all the architectures. I don't remember all the
details, but apparently
the ARM portion got reverted because of this, and other architectures didn't
revert theirs.  I think I bisected this to a particular binutils
commit at the time.

       Arnd
