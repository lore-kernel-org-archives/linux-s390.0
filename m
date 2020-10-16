Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392711AbgJPXLX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 16 Oct 2020 19:11:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41110C061755
        for <linux-s390@vger.kernel.org>; Fri, 16 Oct 2020 16:11:23 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h6so2302821pgk.4
        for <linux-s390@vger.kernel.org>; Fri, 16 Oct 2020 16:11:23 -0700 (PDT)
MIME-Version: 1.0
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 16 Oct 2020 16:11:11 -0700
Message-ID: <CAKwvOd=0nOhK4KoLb1_Jni5u3ENDx10QeAxfYcSbtFQs77FxAw@mail.gmail.com>
Subject: s390 - buildroot + qemu
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: egorenar@linux.ibm.com, Vasily Gorbik <gor@linux.ibm.com>
Cc: Joel Stanley <joel@jms.id.au>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Guenter Roeck <linux@roeck-us.net>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390 <linux-s390@vger.kernel.org>

Hello all,
I'm working on integrating the latest release of buildroot (2020.08.1)
into our CI for ClangBuiltLinux.

https://github.com/ClangBuiltLinux/boot-utils/pull/25
https://github.com/ClangBuiltLinux/boot-utils/pull/26
https://github.com/ClangBuiltLinux/continuous-integration/pull/327

I'm seeing the following error from QEMU:
KASLR disabled: CPU has no PRNG
Linux version 5.9.0-00732-g04ed4527465f (ndesaulniers@<myhost>) #30
SMP Fri Oct 16 15:49:05 PDT 2020Kernel fault: interruption code 0005
ilc:2
PSW : 0000200180000000 000000000001779e
      R:0 T:0 IO:0 EX:0 Key:0 M:0 W:0 P:0 AS:0 CC:2 PM:0 RI:0 EA:3
GPRS: 0000000000000001 0000000c00000000 00000003fffffff4 00000000fffffff0
      0000000000000000 00000000fffffff4 000000000000000c 00000000fffffff0
      00000000fffffffc 0000000000000000 00000000fffffff8 00000000008a75a8
      0000000000000009 0000000000000002 0000000000000008 000000000000bce0

This is via a kernel built by:
$ ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- make CC=clang -j71 defconfig
$ ARCH=s390 CROSS_COMPILE=s390x-linux-gnu- make CC=clang -j71

The booting qemu:
$ qemu-system-s390x -M s390-ccw-virtio -append 'rdinit=/bin/sh '
-display none -initrd /android1/boot-utils/images/s390/rootfs.cpio
-kernel /android0/kernel-all/arch/s390/boot/bzImage -m 512m
-nodefaults -serial mon:stdio

Is there a preferred kernel config or additional flags to QEMU I
should be using to avoid this error?  It's also possible that there's
a bug in the kernel image, but given that it fails very early with no
other output, I am slightly suspicious of that.
-- 
Thanks,
~Nick Desaulniers
