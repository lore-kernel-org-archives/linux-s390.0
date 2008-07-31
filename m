Return-Path: <linux-kernel-owner+w=401wt.eu-S1755925AbYGaMlj@vger.kernel.org>
Message-Id: <20080731123932.854951652@de.ibm.com>
References: <20080731123004.868574766@de.ibm.com>
Date: Thu, 31 Jul 2008 14:30:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 3/6] qdio: fix section mismatch bug.
Content-Disposition: inline; filename=102-qdio-section.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Fix the two section mismatch warnings below.
This fixes two real bugs since the code which has __exit annotations
may already be gone when it is called.

WARNING: vmlinux.o(.init.text+0x1cc4a): Section mismatch in reference from the function init_QDIO() to the function .exit.text:qdio_setup_exit()
The function __init init_QDIO() references
a function __exit qdio_setup_exit().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __exit annotation of
qdio_setup_exit() so it may be used outside an exit section.

WARNING: vmlinux.o(.init.text+0x1cc7a): Section mismatch in reference from the function init_QDIO() to the function .exit.text:qdio_remove_perf_stats()
The function __init init_QDIO() references
a function __exit qdio_remove_perf_stats().
This is often seen when error handling in the init function
uses functionality in the exit path.
The fix is often to remove the __exit annotation of
qdio_remove_perf_stats() so it may be used outside an exit section.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/qdio_perf.c  |    2 +-
 drivers/s390/cio/qdio_setup.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/cio/qdio_perf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_perf.c
+++ quilt-2.6/drivers/s390/cio/qdio_perf.c
@@ -142,7 +142,7 @@ int __init qdio_setup_perf_stats(void)
 	return 0;
 }
 
-void __exit qdio_remove_perf_stats(void)
+void qdio_remove_perf_stats(void)
 {
 #ifdef CONFIG_PROC_FS
 	remove_proc_entry("qdio_perf", NULL);
Index: quilt-2.6/drivers/s390/cio/qdio_setup.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio_setup.c
+++ quilt-2.6/drivers/s390/cio/qdio_setup.c
@@ -515,7 +515,7 @@ int __init qdio_setup_init(void)
 	return 0;
 }
 
-void __exit qdio_setup_exit(void)
+void qdio_setup_exit(void)
 {
 	kmem_cache_destroy(qdio_q_cache);
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
