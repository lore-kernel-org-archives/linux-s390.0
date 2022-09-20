Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB40CC6FA82
	for <linux-s390@archiver.kernel.org>; Tue, 20 Sep 2022 19:26:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiITT0k (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 20 Sep 2022 15:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiITT0Z (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 20 Sep 2022 15:26:25 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A0A67469;
        Tue, 20 Sep 2022 12:26:23 -0700 (PDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28KJJ0dP021694;
        Tue, 20 Sep 2022 19:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=syE09xaXlEfcUeHyXTBCPuSxRnXfWD0KxYKaXHtnnVk=;
 b=Z1vCPVspV8JgRyPOTuEEiQ98CIoVHfDO9KcgFnmsz1TlQxchDyvmcRNNxE01xoKuvmP6
 FBke94Eu/Izhm7I20iL1yarhiNbR/HfIuU4MJm1GGiJ42TuH13JSvdb1TXJyS9l1itqs
 I8d56rbR8Z1/Uc0EiwNq03azIAyfYMETOQPt7QnfMTk7bj5biZ4hRiCnJoxxx0I+1Hy2
 7ToDWgRaBKof8ZiLzAjXDsy0gyA4i6ZwYepOSOUFsHuAoCcnhSkch9Ow39KROOuO6dq9
 uwHUW/OzWbC58ueFAXSjGUk5hQuXMNwMqnI88LZyD+xZCR8UMgho3DEL3xDAnT78R1nt +A== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jqk21904r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:26:22 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28KJLDY7017177;
        Tue, 20 Sep 2022 19:26:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03ams.nl.ibm.com with ESMTP id 3jn5v9498n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 19:26:20 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28KJQH9t26411490
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Sep 2022 19:26:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF131A406A;
        Tue, 20 Sep 2022 19:26:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1F3DA405B;
        Tue, 20 Sep 2022 19:26:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 20 Sep 2022 19:26:16 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 86452E0804; Tue, 20 Sep 2022 21:26:16 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 2/7] s390/dasd: add query PPRC function
Date:   Tue, 20 Sep 2022 21:26:11 +0200
Message-Id: <20220920192616.808070-3-sth@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220920192616.808070-1-sth@linux.ibm.com>
References: <20220920192616.808070-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DpGl_sksp2Y8ztEQCLLWYfM2mnrBiXjf
X-Proofpoint-GUID: DpGl_sksp2Y8ztEQCLLWYfM2mnrBiXjf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_09,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 mlxscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200114
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Add function to query the Peer-to-Peer-Remote-Copy (PPRC) state of a
device by reading the related structure through a read subsystem data call.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 66 ++++++++++++++++++++++++++++++++++
 drivers/s390/block/dasd_eckd.h |  6 ++++
 drivers/s390/block/dasd_int.h  | 32 +++++++++++++++++
 3 files changed, 104 insertions(+)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index bdb4207d5aa2..600606d8d038 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6086,6 +6086,71 @@ static int dasd_hosts_print(struct dasd_device *device, struct seq_file *m)
 	return 0;
 }
 
+/*
+ * Perform Subsystem Function - Peer-to-Peer Remote Copy Extended Query
+ */
+static int dasd_eckd_query_pprc_status(struct dasd_device *device,
+				       struct dasd_pprc_data_sc4 *data)
+{
+	struct dasd_pprc_data_sc4 *pprc_data;
+	struct dasd_psf_prssd_data *prssdp;
+	struct dasd_ccw_req *cqr;
+	struct ccw1 *ccw;
+	int rc;
+
+	cqr = dasd_smalloc_request(DASD_ECKD_MAGIC, 1 /* PSF */	+ 1 /* RSSD */,
+				   sizeof(*prssdp) + sizeof(*pprc_data) + 1,
+				   device, NULL);
+	if (IS_ERR(cqr)) {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev, "%s",
+				"Could not allocate query PPRC status request");
+		return PTR_ERR(cqr);
+	}
+	cqr->startdev = device;
+	cqr->memdev = device;
+	cqr->block = NULL;
+	cqr->retries = 256;
+	cqr->expires = 10 * HZ;
+
+	/* Prepare for Read Subsystem Data */
+	prssdp = (struct dasd_psf_prssd_data *)cqr->data;
+	memset(prssdp, 0, sizeof(struct dasd_psf_prssd_data));
+	prssdp->order = PSF_ORDER_PRSSD;
+	prssdp->suborder = PSF_SUBORDER_PPRCEQ;
+	prssdp->varies[0] = PPRCEQ_SCOPE_4;
+	pprc_data = (struct dasd_pprc_data_sc4 *)(prssdp + 1);
+
+	ccw = cqr->cpaddr;
+	ccw->cmd_code = DASD_ECKD_CCW_PSF;
+	ccw->count = sizeof(struct dasd_psf_prssd_data);
+	ccw->flags |= CCW_FLAG_CC;
+	ccw->flags |= CCW_FLAG_SLI;
+	ccw->cda = (__u32)(addr_t)prssdp;
+
+	/* Read Subsystem Data - query host access */
+	ccw++;
+	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
+	ccw->count = sizeof(*pprc_data);
+	ccw->flags |= CCW_FLAG_SLI;
+	ccw->cda = (__u32)(addr_t)pprc_data;
+
+	cqr->buildclk = get_tod_clock();
+	cqr->status = DASD_CQR_FILLED;
+
+	rc = dasd_sleep_on_interruptible(cqr);
+	if (rc == 0) {
+		*data = *pprc_data;
+	} else {
+		DBF_EVENT_DEVID(DBF_WARNING, device->cdev,
+				"PPRC Extended Query failed with rc=%d\n",
+				rc);
+		rc = -EOPNOTSUPP;
+	}
+
+	dasd_sfree_request(cqr, cqr->memdev);
+	return rc;
+}
+
 /*
  * Perform Subsystem Function - CUIR response
  */
@@ -6705,6 +6770,7 @@ static struct dasd_discipline dasd_eckd_discipline = {
 	.ext_pool_exhaust = dasd_eckd_ext_pool_exhaust,
 	.ese_format = dasd_eckd_ese_format,
 	.ese_read = dasd_eckd_ese_read,
+	.pprc_status = dasd_eckd_query_pprc_status,
 };
 
 static int __init
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index a91b265441cc..ecf25b985aa8 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -66,9 +66,15 @@
  * Perform Subsystem Function / Sub-Orders
  */
 #define PSF_SUBORDER_QHA		 0x1C /* Query Host Access */
+#define PSF_SUBORDER_PPRCEQ		 0x50 /* PPRC Extended Query */
 #define PSF_SUBORDER_VSQ		 0x52 /* Volume Storage Query */
 #define PSF_SUBORDER_LCQ		 0x53 /* Logical Configuration Query */
 
+/*
+ * PPRC Extended Query Scopes
+ */
+#define PPRCEQ_SCOPE_4			 0x04 /* Scope 4 for PPRC Extended Query */
+
 /*
  * CUIR response condition codes
  */
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index 333a399f754e..39316020529d 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -259,6 +259,37 @@ struct dasd_uid {
 	char vduit[33];
 };
 
+/*
+ * PPRC Status data
+ */
+struct dasd_pprc_header {
+	__u8 entries;		/* 0     Number of device entries */
+	__u8 unused;		/* 1     unused */
+	__u16 entry_length;	/* 2-3   Length of device entry */
+	__u32 unused2;		/* 4-7   unused */
+} __packed;
+
+struct dasd_pprc_dev_info {
+	__u8 state;		/* 0       Copy State */
+	__u8 flags;		/* 1       Flags */
+	__u8 reserved1[2];	/* 2-3     reserved */
+	__u8 prim_lss;		/* 4       Primary device LSS */
+	__u8 primary;		/* 5       Primary device address */
+	__u8 sec_lss;		/* 6       Secondary device LSS */
+	__u8 secondary;		/* 7       Secondary device address */
+	__u16 pprc_id;		/* 8-9     Peer-to-Peer Remote Copy ID */
+	__u8 reserved2[12];	/* 10-21   reserved */
+	__u16 prim_cu_ssid;	/* 22-23   Pimary Control Unit SSID */
+	__u8 reserved3[12];	/* 24-35   reserved */
+	__u16 sec_cu_ssid;	/* 36-37   Secondary Control Unit SSID */
+	__u8 reserved4[90];	/* 38-127  reserved */
+} __packed;
+
+struct dasd_pprc_data_sc4 {
+	struct dasd_pprc_header header;
+	struct dasd_pprc_dev_info dev_info[5];
+} __packed;
+
 /*
  * the struct dasd_discipline is
  * sth like a table of virtual functions, if you think of dasd_eckd
@@ -387,6 +418,7 @@ struct dasd_discipline {
 	struct dasd_ccw_req *(*ese_format)(struct dasd_device *,
 					   struct dasd_ccw_req *, struct irb *);
 	int (*ese_read)(struct dasd_ccw_req *, struct irb *);
+	int (*pprc_status)(struct dasd_device *, struct	dasd_pprc_data_sc4 *);
 };
 
 extern struct dasd_discipline *dasd_diag_discipline_pointer;
-- 
2.34.1

