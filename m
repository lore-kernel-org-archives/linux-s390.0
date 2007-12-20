Return-Path: <linux-kernel-owner+w=401wt.eu-S935773AbXLTPa7@vger.kernel.org>
Message-Id: <20071220152111.582744811@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:20:04 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 39/47] Use diag308 subcodes 3 and 6 for reboot and dump when possible.
Content-Disposition: inline; filename=138-diag308.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

This patch fixes a problem with the following scenario:
 1. Linux booted from DASD "A"
 2. Reboot from DASD "B" using "/sys/firmware/reipl/ccw/device"
 3. Reboot DASD "B"
Without this patch in step 3 on newer s390 systems under LPAR instead of
DASD "B", DASD "A" will be booted. The reason is that in step 2 we use CCW
reipl and in step 3 we use DIAG308 (subcode 3) reipl. DIAG308 does not
notice the CCW reipl and still thinks that it has to reboot DASD "A".
Before applying this fix, ensure to have MCF RJ9967101E or z9 GA3 base driver
installed.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ipl.c |   14 ++++++++------
 include/asm-s390/ipl.h |    4 ++++
 2 files changed, 12 insertions(+), 6 deletions(-)

Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c
+++ quilt-2.6/arch/s390/kernel/ipl.c
@@ -588,7 +588,9 @@ static int reipl_set_type(enum ipl_type 
 
 	switch(type) {
 	case IPL_TYPE_CCW:
-		if (MACHINE_IS_VM)
+		if (diag308_set_works)
+			reipl_method = REIPL_METHOD_CCW_DIAG;
+		else if (MACHINE_IS_VM)
 			reipl_method = REIPL_METHOD_CCW_VM;
 		else
 			reipl_method = REIPL_METHOD_CCW_CIO;
@@ -650,8 +652,6 @@ void reipl_run(struct shutdown_trigger *
 	switch (reipl_method) {
 	case REIPL_METHOD_CCW_CIO:
 		devid.devno = reipl_block_ccw->ipl_info.ccw.devno;
-		if (ipl_info.type == IPL_TYPE_CCW && devid.devno == ipl_devno)
-			diag308(DIAG308_IPL, NULL);
 		devid.ssid  = 0;
 		reipl_ccw_dev(&devid);
 		break;
@@ -736,6 +736,7 @@ static int __init reipl_ccw_init(void)
 	reipl_block_ccw->hdr.version = IPL_PARM_BLOCK_VERSION;
 	reipl_block_ccw->hdr.blk0_len = IPL_PARM_BLK0_CCW_LEN;
 	reipl_block_ccw->hdr.pbt = DIAG308_IPL_TYPE_CCW;
+	reipl_block_ccw->hdr.flags = DIAG308_FLAGS_LP_VALID;
 	/* check if read scp info worked and set loadparm */
 	if (sclp_ipl_info.is_valid)
 		memcpy(reipl_block_ccw->ipl_info.ccw.load_param,
@@ -744,8 +745,7 @@ static int __init reipl_ccw_init(void)
 		/* read scp info failed: set empty loadparm (EBCDIC blanks) */
 		memset(reipl_block_ccw->ipl_info.ccw.load_param, 0x40,
 		       LOADPARM_LEN);
-	/* FIXME: check for diag308_set_works when enabling diag ccw reipl */
-	if (!MACHINE_IS_VM)
+	if (!MACHINE_IS_VM && !diag308_set_works)
 		sys_reipl_ccw_loadparm_attr.attr.mode = S_IRUGO;
 	if (ipl_info.type == IPL_TYPE_CCW)
 		reipl_block_ccw->ipl_info.ccw.devno = ipl_devno;
@@ -867,7 +867,9 @@ static int dump_set_type(enum dump_type 
 		return -EINVAL;
 	switch (type) {
 	case DUMP_TYPE_CCW:
-		if (MACHINE_IS_VM)
+		if (diag308_set_works)
+			dump_method = DUMP_METHOD_CCW_DIAG;
+		else if (MACHINE_IS_VM)
 			dump_method = DUMP_METHOD_CCW_VM;
 		else
 			dump_method = DUMP_METHOD_CCW_CIO;
Index: quilt-2.6/include/asm-s390/ipl.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ipl.h
+++ quilt-2.6/include/asm-s390/ipl.h
@@ -143,6 +143,10 @@ enum diag308_opt {
 	DIAG308_IPL_OPT_DUMP	= 0x20,
 };
 
+enum diag308_flags {
+	DIAG308_FLAGS_LP_VALID	= 0x80,
+};
+
 enum diag308_rc {
 	DIAG308_RC_OK	= 1,
 };

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
