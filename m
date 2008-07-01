Return-Path: <linux-kernel-owner+w=401wt.eu-S1758061AbYGAMwS@vger.kernel.org>
Message-Id: <20080701124958.615523678@de.ibm.com>
References: <20080701124809.319736054@de.ibm.com>
Date: Tue, 01 Jul 2008 14:48:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/14] cio: Use isc_{register,unregister}.
Content-Disposition: inline; filename=124-cio-isc-use.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Cornelia Huck <cornelia.huck@de.ibm.com>

Use the new isc registration functions for all places that need
an I/O interruption subclass.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/cio.c  |    5 +++--
 drivers/s390/cio/css.c  |    2 +-
 drivers/s390/cio/qdio.c |    2 ++
 3 files changed, 6 insertions(+), 3 deletions(-)

Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -786,12 +786,13 @@ cio_probe_console(void)
 	/*
 	 * enable console I/O-interrupt subclass
 	 */
-	ctl_set_bit(6, 31 - CONSOLE_ISC);
+	isc_register(CONSOLE_ISC);
 	console_subchannel.schib.pmcw.isc = CONSOLE_ISC;
 	console_subchannel.schib.pmcw.intparm =
 		(u32)(addr_t)&console_subchannel;
 	ret = cio_modify(&console_subchannel);
 	if (ret) {
+		isc_unregister(CONSOLE_ISC);
 		console_subchannel_in_use = 0;
 		return ERR_PTR(ret);
 	}
@@ -803,7 +804,7 @@ cio_release_console(void)
 {
 	console_subchannel.schib.pmcw.intparm = 0;
 	cio_modify(&console_subchannel);
-	ctl_clear_bit(6, 31 - CONSOLE_ISC);
+	isc_unregister(CONSOLE_ISC);
 	console_subchannel_in_use = 0;
 }
 
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -806,7 +806,7 @@ init_channel_subsystem (void)
 	css_init_done = 1;
 
 	/* Enable default isc for I/O subchannels. */
-	ctl_set_bit(6, 31 - IO_SCH_ISC);
+	isc_register(IO_SCH_ISC);
 
 	for_each_subchannel(__init_channel_subsystem, NULL);
 	return 0;
Index: quilt-2.6/drivers/s390/cio/qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/qdio.c
+++ quilt-2.6/drivers/s390/cio/qdio.c
@@ -3892,6 +3892,7 @@ init_QDIO(void)
 					    qdio_mempool_alloc,
 					    qdio_mempool_free, NULL);
 
+	isc_register(QDIO_AIRQ_ISC);
 	if (tiqdio_check_chsc_availability())
 		QDIO_PRINT_ERR("Not all CHSCs supported. Continuing.\n");
 
@@ -3904,6 +3905,7 @@ static void __exit
 cleanup_QDIO(void)
 {
 	tiqdio_unregister_thinints();
+	isc_unregister(QDIO_AIRQ_ISC);
 	qdio_remove_procfs_entry();
 	qdio_release_qdio_memory();
 	qdio_unregister_dbf_views();

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
