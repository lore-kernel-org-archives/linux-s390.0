Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-m973.mail.163.com ([123.126.97.3]:46260 "EHLO
        mail-m973.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfLFCuY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Dec 2019 21:50:24 -0500
From: Xidong Wang <wangxidong_97@163.com>
Subject: [PATCH 1/1] scsi: zfcp: check qdio before use
Date: Fri,  6 Dec 2019 10:34:04 +0800
Message-Id: <1575599644-15837-1-git-send-email-wangxidong_97@163.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Xidong Wang <wangxidong_97@163.com>, Steffen Maier <maier@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

In zfcp_fsf_fcp_cmnd(), zfcp_qdio_sbal_get(qdio) should
be checked before zfcp_fsf_req_create() is called.

Signed-off-by: Xidong Wang <wangxidong_97@163.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index cf63916..8e460e3 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -2292,6 +2292,9 @@ int zfcp_fsf_fcp_cmnd(struct scsi_cmnd *scsi_cmnd)
 	if (scsi_cmnd->sc_data_direction == DMA_TO_DEVICE)
 		sbtype = SBAL_SFLAGS0_TYPE_WRITE;
 
+	if (zfcp_qdio_sbal_get(qdio))
+		goto out;
+
 	req = zfcp_fsf_req_create(qdio, FSF_QTCB_FCP_CMND,
 				  sbtype, adapter->pool.scsi_req);
 
-- 
2.7.4
