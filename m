Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:57948 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727266AbfGLRVN (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 12 Jul 2019 13:21:13 -0400
From: Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH 2/2] s390: add Linux banner to the compressed image
Date: Fri, 12 Jul 2019 19:21:01 +0200
Message-Id: <aa477dd145aa2beb37fe813619b0723744a22a0a.1562950641.git.ptesarik@suse.com>
In-Reply-To: <cover.1562950641.git.ptesarik@suse.com>
References: <cover.1562950641.git.ptesarik@suse.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Laura Abbott <labbott@redhat.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Petr Tesarik <ptesarik@suse.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

Various tools determine the kernel version from a given binary by
scanning for the Linux banner string. This does not work if the
banner string is compressed, but we can link it once more into the
uncompressed portion of bzImage.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 arch/s390/boot/compressed/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index fa529c5b4486..9bc4685477c5 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -11,6 +11,7 @@ UBSAN_SANITIZE := n
 KASAN_SANITIZE := n
 
 obj-y	:= $(if $(CONFIG_KERNEL_UNCOMPRESSED),,decompressor.o) piggy.o info.o
+obj-y   += ../../../../init/banner.o
 targets	:= vmlinux.lds vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2
 targets += vmlinux.bin.xz vmlinux.bin.lzma vmlinux.bin.lzo vmlinux.bin.lz4
 targets += info.bin $(obj-y)
-- 
2.16.4
