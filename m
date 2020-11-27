Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from know-smtprelay-omc-5.server.virginmedia.net ([80.0.253.69]:38665
        "EHLO know-smtprelay-omc-5.server.virginmedia.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730004AbgK0NN4 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Nov 2020 08:13:56 -0500
From: Yevhen Viktorov <yevhen.viktorov@virginmedia.com>
Subject: [PATCH] scsi: zfcp: fix indentation coding style issue
Date: Fri, 27 Nov 2020 13:06:46 +0000
Message-Id: <20201127130646.11427-1-yevhen.viktorov@virginmedia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: maier@linux.ibm.com
Cc: bblock@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Yevhen Viktorov <yevhen.viktorov@virginmedia.com>

code indent should use tabs where possible

Signed-off-by: Yevhen Viktorov <yevhen.viktorov@virginmedia.com>
---
 drivers/s390/scsi/zfcp_def.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_def.h b/drivers/s390/scsi/zfcp_def.h
index da8a5ceb615c..a2a59cbb330a 100644
--- a/drivers/s390/scsi/zfcp_def.h
+++ b/drivers/s390/scsi/zfcp_def.h
@@ -157,7 +157,7 @@ struct zfcp_adapter {
 	u32			fsf_lic_version;
 	u32			adapter_features;  /* FCP channel features */
 	u32			connection_features; /* host connection features */
-        u32			hardware_version;  /* of FCP channel */
+	u32			hardware_version;  /* of FCP channel */
 	u32			fc_security_algorithms; /* of FCP channel */
 	u32			fc_security_algorithms_old; /* of FCP channel */
 	u16			timer_ticks;       /* time int for a tick */
@@ -181,7 +181,7 @@ struct zfcp_adapter {
 	rwlock_t		erp_lock;
 	wait_queue_head_t	erp_done_wqh;
 	struct zfcp_erp_action	erp_action;	   /* pending error recovery */
-        atomic_t                erp_counter;
+	atomic_t                erp_counter;
 	u32			erp_total_count;   /* total nr of enqueued erp
 						      actions */
 	u32			erp_low_mem_count; /* nr of erp actions waiting
@@ -217,7 +217,7 @@ struct zfcp_port {
 	u32		       d_id;	       /* D_ID */
 	u32		       handle;	       /* handle assigned by FSF */
 	struct zfcp_erp_action erp_action;     /* pending error recovery */
-        atomic_t               erp_counter;
+	atomic_t               erp_counter;
 	u32                    maxframe_size;
 	u32                    supported_classes;
 	u32                    connection_info;
-- 
2.26.2
