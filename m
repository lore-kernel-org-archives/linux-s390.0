MIME-Version: 1.0
In-Reply-To: <CAK8P3a290yWCt07tJ8iwySCvjDpgLBKpEoPRN3mbe+93Hmw-4Q@mail.gmail.com>
References: <1516029691-8593-1-git-send-email-geert@linux-m68k.org> <CAK8P3a290yWCt07tJ8iwySCvjDpgLBKpEoPRN3mbe+93Hmw-4Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 16 Jan 2018 10:38:48 +0100
Message-ID: <CAMuHMdX_tR-pj-eV0Mu8AEkOsVm1bT48_FFYx=QD5zBbF3TFkA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.15-rc8
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Return-Path: <linux-kernel-owner@vger.kernel.org>
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi Arnd,

On Tue, Jan 16, 2018 at 10:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jan 15, 2018 at 4:21 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> *** WARNINGS ***
>>
>> [Deleted 568 lines about "warning: ... [-Wpointer-sign]" on parisc-allmodconfig]
>> [Deleted 1319 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on parisc-allmodconfig]
>
> parisc builds seem to have gotten worse than they used to in general.

it's been like that for quite a while...

>>   + /home/kisskb/slave/src/drivers/gpu/drm/drm_gem_cma_helper.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat=]:  => 115:21
>
> This appears to have been introduced by a warning fix for the reverse warning.
> The variable here is indeed a 'size_t', but there is apparently at least one
> architecture on which the compiler's idea of size_t disagrees with the kernel
> definition. Do you know which architecture caused this?

Ah, I should look into kup and start publishing summaries again...

arcv2/axs103_smp_defconfig

>>   + /home/kisskb/slave/src/drivers/iio/industrialio-core.c: warning: 'name' may be used uninitialized in this function [-Wuninitialized]:  => 1307:8
>>   + /home/kisskb/slave/src/drivers/iio/industrialio-core.c: warning: 'sz' may be used uninitialized in this function [-Wuninitialized]:  => 1308:2
>>   + /home/kisskb/slave/src/drivers/iio/industrialio-core.c: warning: control reaches end of non-void function [-Wreturn-type]:  => 262:1
>
> This should have been addressed by my patch that makes 'BUG()' never return
> on any architecture, it's in linux-next now. Which architecture caused this?

cris-allmodconfig


> [-Wuninitialized]:  => 114:22
>>   + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U  a0>]' may be used uninitialized in this function [-Wuninitialized]:  => 100:33
>>   + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 140>]' may be used uninitialized in this function [-Wuninitialized]:  => 119:32
>>   + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 3c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 119:32
>>   + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U 8c0>]' may be used uninitialized in this function [-Wuninitialized]:  => 100:33
>>   + /home/kisskb/slave/src/kernel/rcu/srcutree.c: warning: 'levelspread[<U dc0>]' may be used uninitialized in this function [-Wuninitialized]:  => 100:33
>
> Ugh. Any idea on which compiler/arch has those?

There are more than the 5 listed above:

am33_2.0/asb2303_defconfig
am33_2.0/asb2364_defconfig
arm/colibri_pxa270_defconfig
arm/efm32_defconfig
arm/exynos_defconfig
arm/ezx_defconfig
arm/h3600_defconfig
arm/imote2_defconfig
arm/imx_v6_v7_defconfig
arm/integrator_defconfig
arm/lpc32xx_defconfig
arm/magician_defconfig
arm/mmp2_defconfig
arm/mv78xx0_defconfig
arm/mvebu_v7_defconfig
arm/netx_defconfig
arm/nhk8815_defconfig
arm/nuc910_defconfig
arm/nuc950_defconfig
arm/nuc960_defconfig
arm/omap1_defconfig
arm/omap2plus_defconfig
arm/orion5x_defconfig
arm/palmz72_defconfig
arm/pcm027_defconfig
arm/pxa168_defconfig
arm/pxa3xx_defconfig
arm/pxa910_defconfig
arm/realview_defconfig
arm/s5pv210_defconfig
arm/shmobile_defconfig
arm/simpad_defconfig
arm/spitz_defconfig
arm/tegra_defconfig
arm/u300_defconfig
arm/u8500_defconfig
arm/vexpress_defconfig
bfin/BF527-AD7160-EVAL_defconfig
bfin/BF561-EZKIT-SMP_defconfig
i386/i386_defconfig
m32r/m32700ut.smp_defconfig
mips/bigsur_defconfig
mips/malta_defconfig
mips/mips-defconfig
parisc64/a500_defconfig
powerpc/44x/currituck_defconfig
powerpc/cell_defconfig
powerpc/chrp32_defconfig
powerpc/g5_defconfig
powerpc/maple_defconfig
powerpc/pasemi_defconfig
powerpc/pmac32_defconfig+SMP
powerpc/ps3_defconfig
sh4/ap325rxa_defconfig
sh4/ecovec24_defconfig
sh4/edosk7760_defconfig
sh4/kfr2r09_defconfig
sh4/microdev_defconfig
sh4/polaris_defconfig
sh4/r7785rp_defconfig
sh4/sdk7780_defconfig
sh4/se7206_defconfig
sh4/se7705_defconfig
sh4/se7722_defconfig
sh4/se7724_defconfig
sh4/sh03_defconfig
sh4/sh7785lcr_32bit_defconfig
sh4/shx3_defconfig
sh4/ul2_defconfig
x86_64/x86_64-randconfig

>>   + /home/kisskb/slave/src/lib/asn1_decoder.c: warning: format '%zu' expects argument of type 'size_t', but argument 2 has type 'unsigned int' [-Wformat]:  => 401:3, 432:4, 340:4, 205:2
>>   + /home/kisskb/slave/src/lib/asn1_decoder.c: warning: format '%zu' expects argument of type 'size_t', but argument 3 has type 'unsigned int' [-Wformat]:  => 515:2, 309:3, 401:3, 432:4, 472:2, 205:2
>>   + /home/kisskb/slave/src/lib/asn1_decoder.c: warning: format '%zu' expects argument of type 'size_t', but argument 4 has type 'unsigned int' [-Wformat]:  => 515:2, 205:2, 401:3
>>   + /home/kisskb/slave/src/lib/asn1_decoder.c: warning: format '%zu' expects argument of type 'size_t', but argument 5 has type 'unsigned int' [-Wformat]:  => 401:3, 205:2
>>   + /home/kisskb/slave/src/lib/asn1_decoder.c: warning: format '%zu' expects argument of type 'size_t', but argument 7 has type 'unsigned int' [-Wformat]:  => 515:2
>>   + /home/kisskb/slave/src/lib/assoc_array.c: warning: format '%zu' expects argument of type 'size_t', but argument 2 has type 'unsigned int' [-Wformat]:  => 785:2, 885:3
>
> More of the above.

am33_2.0/asb2364_defconfig

>>   + warning: "memcpy" [crypto/sm3_generic.ko] has no CRC!:  => N/A
>>   + warning: "memcpy" [net/nsh/nsh.ko] has no CRC!:  => N/A

For this I sent a patch a while ago, but it hasn't gone upstream yet as
Linus rejected the UML pull request due to being too late for v4.15-rc1.

>>   + warning: EXPORT symbol "___rw_read_enter" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>>   + warning: EXPORT symbol "___rw_read_exit" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>>   + warning: EXPORT symbol "___rw_read_try" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>>   + warning: EXPORT symbol "___rw_write_enter" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>>   + warning: EXPORT symbol "__ashldi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>>   + warning: EXPORT symbol "__ashrdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>>   + warning: EXPORT symbol "__copy_1page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>>   + warning: EXPORT symbol "__divdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>>   + warning: EXPORT symbol "__lshrdi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>>   + warning: EXPORT symbol "__muldi3" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>>   + warning: EXPORT symbol "__ndelay" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>>   + warning: EXPORT symbol "__udelay" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>>   + warning: EXPORT symbol "bzero_1page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>>   + warning: EXPORT symbol "empty_zero_page" [vmlinux] version generation failed, symbol will not be versioned.:  => N/A
>
> This seems to be a problem with the export-from-assembler patches that got added
> at some point in all the architectures. I don't remember all the
> details, but apparently
> the ARM portion got reverted because of this, and other architectures didn't
> revert theirs.  I think I bisected this to a particular binutils
> commit at the time.

All from sparc64/sparc-allmodconfig

sparc64/sparc64-defconfig has one more (_mcount)
um-x86_64/um-allmodconfig um-x86_64/um-allyesconfig have two ({__,}memcpy,
perhaps also fixed by has no CRC fix?).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
