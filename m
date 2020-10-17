Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411646AbgJQGBg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 17 Oct 2020 02:01:36 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35280C0613E0
        for <linux-s390@vger.kernel.org>; Fri, 16 Oct 2020 17:15:04 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id h10so4464105oie.5
        for <linux-s390@vger.kernel.org>; Fri, 16 Oct 2020 17:15:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: s390 - buildroot + qemu
References: <CAKwvOd=0nOhK4KoLb1_Jni5u3ENDx10QeAxfYcSbtFQs77FxAw@mail.gmail.com>
 <30b7bea6-1135-609b-f1e5-a4f243e1dcc1@roeck-us.net>
 <CAKwvOdmnr0qqJTg+cU5KJ2-nJQgTY-8AraZQHXZUw0KNZKE4fg@mail.gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <f0164e2d-bb8c-0805-23bb-88443af11ea2@roeck-us.net>
Date: Fri, 16 Oct 2020 17:15:00 -0700
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmnr0qqJTg+cU5KJ2-nJQgTY-8AraZQHXZUw0KNZKE4fg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: egorenar@linux.ibm.com, Vasily Gorbik <gor@linux.ibm.com>, Joel Stanley <joel@jms.id.au>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390 <linux-s390@vger.kernel.org>

On 10/16/20 4:40 PM, Nick Desaulniers wrote:
> On Fri, Oct 16, 2020 at 4:18 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 10/16/20 4:11 PM, Nick Desaulniers wrote:
>>> Hello all,
>>> I'm working on integrating the latest release of buildroot (2020.08.1)
>>> into our CI for ClangBuiltLinux.
>>>
>>> https://github.com/ClangBuiltLinux/boot-utils/pull/25
>>> https://github.com/ClangBuiltLinux/boot-utils/pull/26
>>> https://github.com/ClangBuiltLinux/continuous-integration/pull/327
>>>
>>> I'm seeing the following error from QEMU:
>>> KASLR disabled: CPU has no PRNG
>>> Linux version 5.9.0-00732-g04ed4527465f (ndesaulniers@<myhost>) #30
>>> SMP Fri Oct 16 15:49:05 PDT 2020Kernel fault: interruption code 0005
>>> ilc:2
>>> PSW : 0000200180000000 000000000001779e
>>>       R:0 T:0 IO:0 EX:0 Key:0 M:0 W:0 P:0 AS:0 CC:2 PM:0 RI:0 EA:3
>>> GPRS: 0000000000000001 0000000c00000000 00000003fffffff4 00000000fffffff0
>>>       0000000000000000 00000000fffffff4 000000000000000c 00000000fffffff0
>>>       00000000fffffffc 0000000000000000 00000000fffffff8 00000000008a75a8
>>>       0000000000000009 0000000000000002 0000000000000008 000000000000bce0
>>>
>>> This is via a kernel built by:
>>> $ ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- make CC=clang -j71 defconfig
>>> $ ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- make CC=clang -j71
>>>
>>> The booting qemu:
>>> $ qemu-system-s390x -M s390-ccw-virtio -append 'rdinit=/bin/sh '
>>> -display none -initrd /android1/boot-utils/images/s390/rootfs.cpio
>>> -kernel /android0/kernel-all/arch/s390/boot/bzImage -m 512m
>>> -nodefaults -serial mon:stdio
>>>
>>> Is there a preferred kernel config or additional flags to QEMU I
>>> should be using to avoid this error?  It's also possible that there's
>>> a bug in the kernel image, but given that it fails very early with no
>>> other output, I am slightly suspicious of that.
>>>
>>
>> Maybe that helps ? From my builders:
>>
>>     # qemu only supports MARCH_Z900. Older kernels select it as default,
>>     # but newer kernels may select MARCH_Z196.
>>     sed -i -e '/CONFIG_MARCH_Z/d' ${defconfig}
>>     sed -i -e '/HAVE_MARCH_Z/d' ${defconfig}
>>     echo "CONFIG_MARCH_Z900=y" >> ${defconfig}
>>     echo "CONFIG_PCI=y" >> ${defconfig}
> 
> $ clang -march=z900 --target=s390x-linux-gnu -c -x c /dev/null -o -
> error: unknown target CPU 'z900'
> note: valid target CPU values are: arch8, z10, arch9, z196, arch10,
> zEC12, arch11, z13, arch12, z14, arch13, z15
> 
> Hopefully qemu supports something newer than Z900?  Or can we change

I don't think it does. I tried several others, and it always says "Some
features requested in the CPU model are not available in the configuration"
If I recall correctly, the s390 qemu is primarily supposed to be used on
real s390 systems, and  the simulator port is not officially supported
by IBM. My memory may defeat me, though.

> arch/s390/Kconfig:255 to use a different arch? Is arch9 == z900???:

You could give it a try ...

Guenter

> > 252 config MARCH_Z900
> 253   bool "IBM zSeries model z800 and z900"
> 254   select HAVE_MARCH_Z900_FEATURES
> 255   depends on $(cc-option,-march=z900)
> 256   help
> 257     Select this to enable optimizations for model z800/z900 (2064
> and
> 258     2066 series). This will enable some optimizations that are not
> 259     available on older ESA/390 (31 Bit) only CPUs.
> 
