Return-Path: <linux-kernel-owner+w=401wt.eu-S965852AbXCLNu1@vger.kernel.org>
Date: Mon, 12 Mar 2007 14:50:30 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [S390] reboot from and dump to SCSI under z/VM fails.
Message-ID: <20070312135030.GB11426@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: holzheu@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

[S390] reboot from and dump to SCSI under z/VM fails.

We used wrong length values for ipl and dump hardware structures.
Since z/VM checks the ipl parameters more accurately than LPAR,
the operations fail there.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ipl.c |    9 ++++-----
 include/asm-s390/ipl.h |    5 +++++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/ipl.c linux-2.6-patched/arch/s390/kernel/ipl.c
--- linux-2.6/arch/s390/kernel/ipl.c	2007-03-12 13:52:25.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/ipl.c	2007-03-12 13:53:01.000000000 +0100
@@ -839,7 +839,7 @@ static int __init reipl_ccw_init(void)
 	}
 	reipl_block_ccw->hdr.len = IPL_PARM_BLK_CCW_LEN;
 	reipl_block_ccw->hdr.version = IPL_PARM_BLOCK_VERSION;
-	reipl_block_ccw->hdr.blk0_len = sizeof(reipl_block_ccw->ipl_info.ccw);
+	reipl_block_ccw->hdr.blk0_len = IPL_PARM_BLK0_CCW_LEN;
 	reipl_block_ccw->hdr.pbt = DIAG308_IPL_TYPE_CCW;
 	/* check if read scp info worked and set loadparm */
 	if (SCCB_VALID)
@@ -880,8 +880,7 @@ static int __init reipl_fcp_init(void)
 	} else {
 		reipl_block_fcp->hdr.len = IPL_PARM_BLK_FCP_LEN;
 		reipl_block_fcp->hdr.version = IPL_PARM_BLOCK_VERSION;
-		reipl_block_fcp->hdr.blk0_len =
-			sizeof(reipl_block_fcp->ipl_info.fcp);
+		reipl_block_fcp->hdr.blk0_len = IPL_PARM_BLK0_FCP_LEN;
 		reipl_block_fcp->hdr.pbt = DIAG308_IPL_TYPE_FCP;
 		reipl_block_fcp->ipl_info.fcp.opt = DIAG308_IPL_OPT_IPL;
 	}
@@ -930,7 +929,7 @@ static int __init dump_ccw_init(void)
 	}
 	dump_block_ccw->hdr.len = IPL_PARM_BLK_CCW_LEN;
 	dump_block_ccw->hdr.version = IPL_PARM_BLOCK_VERSION;
-	dump_block_ccw->hdr.blk0_len = sizeof(reipl_block_ccw->ipl_info.ccw);
+	dump_block_ccw->hdr.blk0_len = IPL_PARM_BLK0_CCW_LEN;
 	dump_block_ccw->hdr.pbt = DIAG308_IPL_TYPE_CCW;
 	dump_capabilities |= IPL_TYPE_CCW;
 	return 0;
@@ -954,7 +953,7 @@ static int __init dump_fcp_init(void)
 	}
 	dump_block_fcp->hdr.len = IPL_PARM_BLK_FCP_LEN;
 	dump_block_fcp->hdr.version = IPL_PARM_BLOCK_VERSION;
-	dump_block_fcp->hdr.blk0_len = sizeof(dump_block_fcp->ipl_info.fcp);
+	dump_block_fcp->hdr.blk0_len = IPL_PARM_BLK0_FCP_LEN;
 	dump_block_fcp->hdr.pbt = DIAG308_IPL_TYPE_FCP;
 	dump_block_fcp->ipl_info.fcp.opt = DIAG308_IPL_OPT_DUMP;
 	dump_capabilities |= IPL_TYPE_FCP;
diff -urpN linux-2.6/include/asm-s390/ipl.h linux-2.6-patched/include/asm-s390/ipl.h
--- linux-2.6/include/asm-s390/ipl.h	2007-03-12 13:52:45.000000000 +0100
+++ linux-2.6-patched/include/asm-s390/ipl.h	2007-03-12 13:53:01.000000000 +0100
@@ -14,9 +14,13 @@
 #define IPL_PARM_BLK_FCP_LEN (sizeof(struct ipl_list_hdr) + \
 			      sizeof(struct ipl_block_fcp))
 
+#define IPL_PARM_BLK0_FCP_LEN (sizeof(struct ipl_block_fcp) + 8)
+
 #define IPL_PARM_BLK_CCW_LEN (sizeof(struct ipl_list_hdr) + \
 			      sizeof(struct ipl_block_ccw))
 
+#define IPL_PARM_BLK0_CCW_LEN (sizeof(struct ipl_block_ccw) + 8)
+
 #define IPL_MAX_SUPPORTED_VERSION (0)
 
 #define IPL_PARMBLOCK_START	((struct ipl_parameter_block *) \
@@ -58,6 +62,7 @@ struct ipl_block_ccw {
 	u8  vm_flags;
 	u8  reserved3[3];
 	u32 vm_parm_len;
+	u8  reserved4[80];
 } __attribute__((packed));
 
 struct ipl_parameter_block {
