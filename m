Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joe Perches <joe@perches.com>
Subject: [PATCH 04/15] s390: Remove duplicate unlikely from IS_ERR
Date: Thu,  9 Dec 2010 12:03:57 -0800
Message-Id: <7c78f27c370e46472af0f8197d4a339dc77c1a0e.1291923889.git.joe@perches.com>
In-Reply-To: <1291906801-1389-2-git-send-email-tklauser@distanz.ch>
References: <1291906801-1389-2-git-send-email-tklauser@distanz.ch>
In-Reply-To: <cover.1291923888.git.joe@perches.com>
References: <cover.1291923888.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christof Schmitt <christof.schmitt@de.ibm.com>, Swen Schillig <swen@vnet.ibm.com>, linux390@de.ibm.com
Cc: Jiri Kosina <trivial@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

IS_ERR already uses unlikely, remove unlikely from the call sites.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/s390/scsi/zfcp_fsf.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 2eb7dd5..722cdf5 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -1553,7 +1553,7 @@ int zfcp_fsf_open_wka_port(struct zfcp_fc_wka_port *wka_port)
 				  SBAL_FLAGS0_TYPE_READ,
 				  qdio->adapter->pool.erp_req);
 
-	if (unlikely(IS_ERR(req))) {
+	if (IS_ERR(req)) {
 		retval = PTR_ERR(req);
 		goto out;
 	}
@@ -1606,7 +1606,7 @@ int zfcp_fsf_close_wka_port(struct zfcp_fc_wka_port *wka_port)
 				  SBAL_FLAGS0_TYPE_READ,
 				  qdio->adapter->pool.erp_req);
 
-	if (unlikely(IS_ERR(req))) {
+	if (IS_ERR(req)) {
 		retval = PTR_ERR(req);
 		goto out;
 	}
-- 
1.7.3.3.464.gf80b6
