Return-Path: <linux-kernel-owner+w=401wt.eu-S1754670AbYGaMkg@vger.kernel.org>
Message-Id: <20080731123933.369255482@de.ibm.com>
References: <20080731123004.868574766@de.ibm.com>
Date: Thu, 31 Jul 2008 14:30:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 5/6] virtio console: fix section mismatch warning.
Content-Disposition: inline; filename=104-virtio-console.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fix these two false positive warnings:

WARNING: vmlinux.o(.text+0x2e1cc4): Section mismatch in reference from the function s390_virtio_console_init() to the function .init.text:early_put_chars()
The function s390_virtio_console_init() references
the function __init early_put_chars().
This is often because s390_virtio_console_init lacks a __init 
annotation or the annotation of early_put_chars is wrong.

WARNING: vmlinux.o(.text+0x2e1cd0): Section mismatch in reference from the function s390_virtio_console_init() to the function .init.text:virtio_cons_early_init()
The function s390_virtio_console_init() references
the function __init virtio_cons_early_init().
This is often because s390_virtio_console_init lacks a __init 
annotation or the annotation of virtio_cons_early_init is wrong.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/kvm/kvm_virtio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/drivers/s390/kvm/kvm_virtio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/kvm/kvm_virtio.c
+++ quilt-2.6/drivers/s390/kvm/kvm_virtio.c
@@ -352,7 +352,7 @@ static __init int early_put_chars(u32 vt
 	return len;
 }
 
-void s390_virtio_console_init(void)
+void __init s390_virtio_console_init(void)
 {
 	virtio_cons_early_init(early_put_chars);
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
