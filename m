Return-Path: <linux-kernel-owner+w=401wt.eu-S1767592AbXECR5B@vger.kernel.org>
Subject: [RFC] [Patch 2/3] readahead statistics slimmed down, adapt zfcp
From: Martin Peschke <mp3@de.ibm.com>
Content-Type: text/plain
Date: Thu, 03 May 2007 19:56:34 +0200
Message-Id: <1178214994.5639.78.camel@dix>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Fengguang Wu <fengguang.wu@gmail.com>, Fengguang Wu <wfg@mail.ustc.edu.cn>, swen@vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

This patch adapts zfcp to the counter changes in lib/statistics.c.

Signed-off-by: Martin Peschke <mp3@de.ibm.com>
---

 zfcp_ccw.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux/drivers/s390/scsi/zfcp_ccw.c
===================================================================
--- linux.orig/drivers/s390/scsi/zfcp_ccw.c
+++ linux/drivers/s390/scsi/zfcp_ccw.c
@@ -137,7 +137,7 @@ static struct statistic_info zfcp_statin
 		.name	  = "qdio_outb_full",
 		.x_unit	  = "sbals_left",
 		.y_unit	  = "",
-		.defaults = "type=counter_inc"
+		.defaults = "type=counter"
 	},
 	[ZFCP_STAT_A_QO] = {
 		.name	  = "qdio_outb",
@@ -155,7 +155,7 @@ static struct statistic_info zfcp_statin
 		.name	  = "erp",
 		.x_unit	  = "",
 		.y_unit	  = "",
-		.defaults = "type=counter_inc"
+		.defaults = "type=counter"
 	}
 };
 
