Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C79DC636D3
	for <linux-s390@archiver.kernel.org>; Fri, 10 Feb 2023 00:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbjBJADJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Feb 2023 19:03:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjBJADH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Feb 2023 19:03:07 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E003449407;
        Thu,  9 Feb 2023 16:03:04 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319NuEDM031919;
        Fri, 10 Feb 2023 00:03:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=k33zBpB3+FlFoBafnx5S5p+dR4y2NN7Z+PhIKiqurfg=;
 b=HTNOlzQ8FniJfxbwVpOtfIWdWmifxIfNJiuLymt+ufjZsB8vaHXLjIg17xQE2zOF4zKH
 SmxqLdOJ8XG6eyz4D6inse+J54PZKr4N2i7zbAjOn0l5AsxQclSRj4hWIygdh9DM3HzC
 FXIJH5khCJpUSCxJ8IbUA31+dDdGbT20UM8sJ5wZZlR/NOQZo0lL30lv46ZnNNIdIOhm
 7bpbfsk9nsAAo80Ajj99Sf3gjXp9stBIYouTLky5Y1vJ+ywFDELYhYnUAq+Z08PGgK+l
 R5BTpRjpsY2OkLf8U/ujuQf3BpwtepcYLh7xqxrMQJ5Yf7NzRxRH2WtAd3maKcZNsf4u CQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nnaxpg52f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:03:00 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 319DQqQR023711;
        Fri, 10 Feb 2023 00:02:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3nhf06xsyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Feb 2023 00:02:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31A02s9i22479310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 00:02:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 639A520040;
        Fri, 10 Feb 2023 00:02:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C61B20043;
        Fri, 10 Feb 2023 00:02:54 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 10 Feb 2023 00:02:54 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id D2146E0611; Fri, 10 Feb 2023 01:02:53 +0100 (CET)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Qiheng Lin <linqiheng@huawei.com>
Subject: [PATCH 1/2] s390/dasd: sort out physical vs virtual pointers usage
Date:   Fri, 10 Feb 2023 01:02:52 +0100
Message-Id: <20230210000253.1644903-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230210000253.1644903-1-sth@linux.ibm.com>
References: <20230210000253.1644903-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: y5TCbylH85gBfz6jgZjvB8KadnvRaAsq
X-Proofpoint-ORIG-GUID: y5TCbylH85gBfz6jgZjvB8KadnvRaAsq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-09_15,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302090212
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

This does not fix a real bug, since virtual addresses
are currently indentical to physical ones.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c          |   5 +-
 drivers/s390/block/dasd_3990_erp.c |  10 +--
 drivers/s390/block/dasd_alias.c    |   6 +-
 drivers/s390/block/dasd_eckd.c     | 100 ++++++++++++++---------------
 drivers/s390/block/dasd_eer.c      |   2 +-
 drivers/s390/block/dasd_fba.c      |  14 ++--
 6 files changed, 67 insertions(+), 70 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 5a6d9c15395f..a9c2a8d76c45 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3978,7 +3978,7 @@ static struct dasd_ccw_req *dasd_generic_build_rdc(struct dasd_device *device,
 
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = CCW_CMD_RDC;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	ccw->flags = 0;
 	ccw->count = rdc_buffer_size;
 	cqr->startdev = device;
@@ -4022,8 +4022,7 @@ char *dasd_get_sense(struct irb *irb)
 
 	if (scsw_is_tm(&irb->scsw) && (irb->scsw.tm.fcxs == 0x01)) {
 		if (irb->scsw.tm.tcw)
-			tsb = tcw_get_tsb((struct tcw *)(unsigned long)
-					  irb->scsw.tm.tcw);
+			tsb = tcw_get_tsb(phys_to_virt(irb->scsw.tm.tcw));
 		if (tsb && tsb->length == 64 && tsb->flags)
 			switch (tsb->flags & 0x07) {
 			case 1:	/* tsa_iostat */
diff --git a/drivers/s390/block/dasd_3990_erp.c b/drivers/s390/block/dasd_3990_erp.c
index 81d283b3cd3b..9fd36c468706 100644
--- a/drivers/s390/block/dasd_3990_erp.c
+++ b/drivers/s390/block/dasd_3990_erp.c
@@ -220,7 +220,7 @@ dasd_3990_erp_DCTL(struct dasd_ccw_req * erp, char modifier)
 	memset(ccw, 0, sizeof(struct ccw1));
 	ccw->cmd_code = CCW_CMD_DCTL;
 	ccw->count = 4;
-	ccw->cda = (__u32)(addr_t) DCTL_data;
+	ccw->cda = (__u32)virt_to_phys(DCTL_data);
 	dctl_cqr->flags = erp->flags;
 	dctl_cqr->function = dasd_3990_erp_DCTL;
 	dctl_cqr->refers = erp;
@@ -1714,7 +1714,7 @@ dasd_3990_erp_action_1B_32(struct dasd_ccw_req * default_erp, char *sense)
 	ccw->cmd_code = DASD_ECKD_CCW_DEFINE_EXTENT;
 	ccw->flags = CCW_FLAG_CC;
 	ccw->count = 16;
-	ccw->cda = (__u32)(addr_t) DE_data;
+	ccw->cda = (__u32)virt_to_phys(DE_data);
 
 	/* create LO ccw */
 	ccw++;
@@ -1722,7 +1722,7 @@ dasd_3990_erp_action_1B_32(struct dasd_ccw_req * default_erp, char *sense)
 	ccw->cmd_code = DASD_ECKD_CCW_LOCATE_RECORD;
 	ccw->flags = CCW_FLAG_CC;
 	ccw->count = 16;
-	ccw->cda = (__u32)(addr_t) LO_data;
+	ccw->cda = (__u32)virt_to_phys(LO_data);
 
 	/* TIC to the failed ccw */
 	ccw++;
@@ -2419,7 +2419,7 @@ static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
 		tcw = erp->cpaddr;
 		tsb = (struct tsb *) &tcw[1];
 		*tcw = *((struct tcw *)cqr->cpaddr);
-		tcw->tsb = (long)tsb;
+		tcw->tsb = virt_to_phys(tsb);
 	} else if (ccw->cmd_code == DASD_ECKD_CCW_PSF) {
 		/* PSF cannot be chained from NOOP/TIC */
 		erp->cpaddr = cqr->cpaddr;
@@ -2430,7 +2430,7 @@ static struct dasd_ccw_req *dasd_3990_erp_add_erp(struct dasd_ccw_req *cqr)
 		ccw->flags = CCW_FLAG_CC;
 		ccw++;
 		ccw->cmd_code = CCW_CMD_TIC;
-		ccw->cda      = (long)(cqr->cpaddr);
+		ccw->cda      = (__u32)virt_to_phys(cqr->cpaddr);
 	}
 
 	erp->flags = cqr->flags;
diff --git a/drivers/s390/block/dasd_alias.c b/drivers/s390/block/dasd_alias.c
index b6b938aa6615..c9740ae88d1a 100644
--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -443,7 +443,7 @@ static int read_unit_address_configuration(struct dasd_device *device,
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t) prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - feature codes */
 	memset(lcu->uac, 0, sizeof(*(lcu->uac)));
@@ -451,7 +451,7 @@ static int read_unit_address_configuration(struct dasd_device *device,
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(*(lcu->uac));
-	ccw->cda = (__u32)(addr_t) lcu->uac;
+	ccw->cda = (__u32)virt_to_phys(lcu->uac);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -747,7 +747,7 @@ static int reset_summary_unit_check(struct alias_lcu *lcu,
 	ccw->cmd_code = DASD_ECKD_CCW_RSCK;
 	ccw->flags = CCW_FLAG_SLI;
 	ccw->count = 16;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	((char *)cqr->data)[0] = reason;
 
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 5d0b9991e91a..03ecd8846378 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -288,7 +288,7 @@ define_extent(struct ccw1 *ccw, struct DE_eckd_data *data, unsigned int trk,
 		ccw->cmd_code = DASD_ECKD_CCW_DEFINE_EXTENT;
 		ccw->flags = 0;
 		ccw->count = 16;
-		ccw->cda = (__u32)__pa(data);
+		ccw->cda = (__u32)virt_to_phys(data);
 	}
 
 	memset(data, 0, sizeof(struct DE_eckd_data));
@@ -398,7 +398,7 @@ static void locate_record_ext(struct ccw1 *ccw, struct LRE_eckd_data *data,
 			ccw->count = 22;
 		else
 			ccw->count = 20;
-		ccw->cda = (__u32)__pa(data);
+		ccw->cda = (__u32)virt_to_phys(data);
 	}
 
 	memset(data, 0, sizeof(*data));
@@ -544,11 +544,11 @@ static int prefix_LRE(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
 	ccw->flags = 0;
 	if (cmd == DASD_ECKD_CCW_WRITE_FULL_TRACK) {
 		ccw->count = sizeof(*pfxdata) + 2;
-		ccw->cda = (__u32) __pa(pfxdata);
+		ccw->cda = (__u32)virt_to_phys(pfxdata);
 		memset(pfxdata, 0, sizeof(*pfxdata) + 2);
 	} else {
 		ccw->count = sizeof(*pfxdata);
-		ccw->cda = (__u32) __pa(pfxdata);
+		ccw->cda = (__u32)virt_to_phys(pfxdata);
 		memset(pfxdata, 0, sizeof(*pfxdata));
 	}
 
@@ -615,7 +615,7 @@ locate_record(struct ccw1 *ccw, struct LO_eckd_data *data, unsigned int trk,
 	ccw->cmd_code = DASD_ECKD_CCW_LOCATE_RECORD;
 	ccw->flags = 0;
 	ccw->count = 16;
-	ccw->cda = (__u32) __pa(data);
+	ccw->cda = (__u32)virt_to_phys(data);
 
 	memset(data, 0, sizeof(struct LO_eckd_data));
 	sector = 0;
@@ -830,7 +830,7 @@ static void dasd_eckd_fill_rcd_cqr(struct dasd_device *device,
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_RCD;
 	ccw->flags = 0;
-	ccw->cda = (__u32)(addr_t)rcd_buffer;
+	ccw->cda = (__u32)virt_to_phys(rcd_buffer);
 	ccw->count = DASD_ECKD_RCD_DATA_SIZE;
 	cqr->magic = DASD_ECKD_MAGIC;
 
@@ -858,7 +858,7 @@ static void read_conf_cb(struct dasd_ccw_req *cqr, void *data)
 
 	if (cqr->status !=  DASD_CQR_DONE) {
 		ccw = cqr->cpaddr;
-		rcd_buffer = (__u8 *)((addr_t) ccw->cda);
+		rcd_buffer = phys_to_virt(ccw->cda);
 		memset(rcd_buffer, 0, sizeof(*rcd_buffer));
 
 		rcd_buffer[0] = 0xE5;
@@ -1547,7 +1547,7 @@ static int dasd_eckd_read_features(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t) prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - feature codes */
 	features = (struct dasd_rssd_features *) (prssdp + 1);
@@ -1556,7 +1556,7 @@ static int dasd_eckd_read_features(struct dasd_device *device)
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(struct dasd_rssd_features);
-	ccw->cda = (__u32)(addr_t) features;
+	ccw->cda = (__u32)virt_to_phys(features);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -1616,7 +1616,7 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(*prssdp);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t)prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - Volume Storage Query */
 	vsq = (struct dasd_rssd_vsq *)(prssdp + 1);
@@ -1626,7 +1626,7 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(*vsq);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t)vsq;
+	ccw->cda = (__u32)virt_to_phys(vsq);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -1801,7 +1801,7 @@ static int dasd_eckd_read_ext_pool_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(*prssdp);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t)prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	lcq = (struct dasd_rssd_lcq *)(prssdp + 1);
 	memset(lcq, 0, sizeof(*lcq));
@@ -1810,7 +1810,7 @@ static int dasd_eckd_read_ext_pool_info(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(*lcq);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t)lcq;
+	ccw->cda = (__u32)virt_to_phys(lcq);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -1907,7 +1907,7 @@ static struct dasd_ccw_req *dasd_eckd_build_psf_ssc(struct dasd_device *device,
 	}
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
-	ccw->cda = (__u32)(addr_t)psf_ssc_data;
+	ccw->cda = (__u32)virt_to_phys(psf_ssc_data);
 	ccw->count = 66;
 
 	cqr->startdev = device;
@@ -2262,7 +2262,7 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
 		ccw->cmd_code = DASD_ECKD_CCW_READ_COUNT;
 		ccw->flags = 0;
 		ccw->count = 8;
-		ccw->cda = (__u32)(addr_t) count_data;
+		ccw->cda = (__u32)virt_to_phys(count_data);
 		ccw++;
 		count_data++;
 	}
@@ -2276,7 +2276,7 @@ dasd_eckd_analysis_ccw(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_READ_COUNT;
 	ccw->flags = 0;
 	ccw->count = 8;
-	ccw->cda = (__u32)(addr_t) count_data;
+	ccw->cda = (__u32)virt_to_phys(count_data);
 
 	cqr->block = NULL;
 	cqr->startdev = device;
@@ -2647,7 +2647,7 @@ dasd_eckd_build_check(struct dasd_device *base, struct format_data_t *fdata,
 		ccw->cmd_code = DASD_ECKD_CCW_READ_COUNT;
 		ccw->flags = CCW_FLAG_SLI;
 		ccw->count = 8;
-		ccw->cda = (__u32)(addr_t) fmt_buffer;
+		ccw->cda = (__u32)virt_to_phys(fmt_buffer);
 		ccw++;
 		fmt_buffer++;
 	}
@@ -2857,7 +2857,7 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 			ccw->cmd_code = DASD_ECKD_CCW_WRITE_RECORD_ZERO;
 			ccw->flags = CCW_FLAG_SLI;
 			ccw->count = 8;
-			ccw->cda = (__u32)(addr_t) ect;
+			ccw->cda = (__u32)virt_to_phys(ect);
 			ccw++;
 		}
 		if ((intensity & ~0x08) & 0x04) {	/* erase track */
@@ -2872,7 +2872,7 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 			ccw->cmd_code = DASD_ECKD_CCW_WRITE_CKD;
 			ccw->flags = CCW_FLAG_SLI;
 			ccw->count = 8;
-			ccw->cda = (__u32)(addr_t) ect;
+			ccw->cda = (__u32)virt_to_phys(ect);
 		} else {		/* write remaining records */
 			for (i = 0; i < rpt; i++) {
 				ect = (struct eckd_count *) data;
@@ -2907,7 +2907,7 @@ dasd_eckd_build_format(struct dasd_device *base, struct dasd_device *startdev,
 						DASD_ECKD_CCW_WRITE_CKD_MT;
 				ccw->flags = CCW_FLAG_SLI;
 				ccw->count = 8;
-				ccw->cda = (__u32)(addr_t) ect;
+				ccw->cda = (__u32)virt_to_phys(ect);
 				ccw++;
 			}
 		}
@@ -3821,7 +3821,7 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	}
 
 	ccw = cqr->cpaddr;
-	ccw->cda = (__u32)(addr_t)cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	ccw->cmd_code = DASD_ECKD_CCW_DSO;
 	ccw->count = size;
 
@@ -4090,11 +4090,11 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_single(
 			ccw->cmd_code = rcmd;
 			ccw->count = count;
 			if (idal_is_needed(dst, blksize)) {
-				ccw->cda = (__u32)(addr_t) idaws;
+				ccw->cda = (__u32)virt_to_phys(idaws);
 				ccw->flags = CCW_FLAG_IDA;
 				idaws = idal_create_words(idaws, dst, blksize);
 			} else {
-				ccw->cda = (__u32)(addr_t) dst;
+				ccw->cda = (__u32)virt_to_phys(dst);
 				ccw->flags = 0;
 			}
 			ccw++;
@@ -4228,7 +4228,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
 				ccw[-1].flags |= CCW_FLAG_CC;
 				ccw->cmd_code = cmd;
 				ccw->count = len_to_track_end;
-				ccw->cda = (__u32)(addr_t)idaws;
+				ccw->cda = (__u32)virt_to_phys(idaws);
 				ccw->flags = CCW_FLAG_IDA;
 				ccw++;
 				recid += count;
@@ -4244,7 +4244,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
 			 * idaw ends
 			 */
 			if (!idaw_dst) {
-				if (__pa(dst) & (IDA_BLOCK_SIZE-1)) {
+				if ((__u32)virt_to_phys(dst) & (IDA_BLOCK_SIZE - 1)) {
 					dasd_sfree_request(cqr, startdev);
 					return ERR_PTR(-ERANGE);
 				} else
@@ -4264,7 +4264,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
 			 * idal_create_words will handle cases where idaw_len
 			 * is larger then IDA_BLOCK_SIZE
 			 */
-			if (!(__pa(idaw_dst + idaw_len) & (IDA_BLOCK_SIZE-1)))
+			if (!((__u32)virt_to_phys(idaw_dst + idaw_len) & (IDA_BLOCK_SIZE - 1)))
 				end_idaw = 1;
 			/* We also need to end the idaw at track end */
 			if (!len_to_track_end) {
@@ -4817,7 +4817,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 		ccw->count = 57326;
 		/* 64k map to one track */
 		len_to_track_end = 65536 - start_padding_sectors * 512;
-		ccw->cda = (__u32)(addr_t)idaws;
+		ccw->cda = (__u32)virt_to_phys(idaws);
 		ccw->flags |= CCW_FLAG_IDA;
 		ccw->flags |= CCW_FLAG_SLI;
 		ccw++;
@@ -4836,7 +4836,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 			ccw->count = 57326;
 			/* 64k map to one track */
 			len_to_track_end = 65536;
-			ccw->cda = (__u32)(addr_t)idaws;
+			ccw->cda = (__u32)virt_to_phys(idaws);
 			ccw->flags |= CCW_FLAG_IDA;
 			ccw->flags |= CCW_FLAG_SLI;
 			ccw++;
@@ -4893,9 +4893,9 @@ dasd_eckd_free_cp(struct dasd_ccw_req *cqr, struct request *req)
 				ccw++;
 			if (dst) {
 				if (ccw->flags & CCW_FLAG_IDA)
-					cda = *((char **)((addr_t) ccw->cda));
+					cda = *((char **)phys_to_virt(ccw->cda));
 				else
-					cda = (char *)((addr_t) ccw->cda);
+					cda = phys_to_virt(ccw->cda);
 				if (dst != cda) {
 					if (rq_data_dir(req) == READ)
 						memcpy(dst, cda, bv.bv_len);
@@ -5045,7 +5045,7 @@ dasd_eckd_release(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RELEASE;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 32;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5100,7 +5100,7 @@ dasd_eckd_reserve(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_RESERVE;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 32;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5154,7 +5154,7 @@ dasd_eckd_steal_lock(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_SLCK;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 32;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5215,7 +5215,7 @@ static int dasd_eckd_snid(struct dasd_device *device,
 	ccw->cmd_code = DASD_ECKD_CCW_SNID;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = 12;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 	cqr->startdev = device;
 	cqr->memdev = device;
 	clear_bit(DASD_CQR_FLAGS_USE_ERP, &cqr->flags);
@@ -5282,7 +5282,7 @@ dasd_eckd_performance(struct dasd_device *device, void __user *argp)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t) prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - Performance Statistics */
 	stats = (struct dasd_rssd_perf_stats_t *) (prssdp + 1);
@@ -5291,7 +5291,7 @@ dasd_eckd_performance(struct dasd_device *device, void __user *argp)
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(struct dasd_rssd_perf_stats_t);
-	ccw->cda = (__u32)(addr_t) stats;
+	ccw->cda = (__u32)virt_to_phys(stats);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -5435,7 +5435,7 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
 	ccw->count = usrparm.psf_data_len;
 	ccw->flags |= CCW_FLAG_CC;
-	ccw->cda = (__u32)(addr_t) psf_data;
+	ccw->cda = (__u32)virt_to_phys(psf_data);
 
 	ccw++;
 
@@ -5443,7 +5443,7 @@ static int dasd_symm_io(struct dasd_device *device, void __user *argp)
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = usrparm.rssd_result_len;
 	ccw->flags = CCW_FLAG_SLI ;
-	ccw->cda = (__u32)(addr_t) rssd_result;
+	ccw->cda = (__u32)virt_to_phys(rssd_result);
 
 	rc = dasd_sleep_on(cqr);
 	if (rc)
@@ -5512,9 +5512,9 @@ dasd_eckd_dump_ccw_range(struct ccw1 *from, struct ccw1 *to, char *page)
 
 		/* get pointer to data (consider IDALs) */
 		if (from->flags & CCW_FLAG_IDA)
-			datap = (char *) *((addr_t *) (addr_t) from->cda);
+			datap = (char *)*((addr_t *)phys_to_virt(from->cda));
 		else
-			datap = (char *) ((addr_t) from->cda);
+			datap = phys_to_virt(from->cda);
 
 		/* dump data (max 128 bytes) */
 		for (count = 0; count < from->count && count < 128; count++) {
@@ -5585,7 +5585,7 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 	len += sprintf(page + len, PRINTK_HEADER
 		       " device %s: Failing CCW: %p\n",
 		       dev_name(&device->cdev->dev),
-		       (void *) (addr_t) irb->scsw.cmd.cpa);
+		       phys_to_virt(irb->scsw.cmd.cpa));
 	if (irb->esw.esw0.erw.cons) {
 		for (sl = 0; sl < 4; sl++) {
 			len += sprintf(page + len, PRINTK_HEADER
@@ -5632,8 +5632,7 @@ static void dasd_eckd_dump_sense_ccw(struct dasd_device *device,
 		/* print failing CCW area (maximum 4) */
 		/* scsw->cda is either valid or zero  */
 		from = ++to;
-		fail = (struct ccw1 *)(addr_t)
-				irb->scsw.cmd.cpa; /* failing CCW */
+		fail = phys_to_virt(irb->scsw.cmd.cpa); /* failing CCW */
 		if (from <  fail - 2) {
 			from = fail - 2;     /* there is a gap - print header */
 			printk(KERN_ERR PRINTK_HEADER "......\n");
@@ -5687,13 +5686,12 @@ static void dasd_eckd_dump_sense_tcw(struct dasd_device *device,
 	len += sprintf(page + len, PRINTK_HEADER
 		       " device %s: Failing TCW: %p\n",
 		       dev_name(&device->cdev->dev),
-		       (void *) (addr_t) irb->scsw.tm.tcw);
+		       phys_to_virt(irb->scsw.tm.tcw));
 
 	tsb = NULL;
 	sense = NULL;
 	if (irb->scsw.tm.tcw && (irb->scsw.tm.fcxs & 0x01))
-		tsb = tcw_get_tsb(
-			(struct tcw *)(unsigned long)irb->scsw.tm.tcw);
+		tsb = tcw_get_tsb(phys_to_virt(irb->scsw.tm.tcw));
 
 	if (tsb) {
 		len += sprintf(page + len, PRINTK_HEADER
@@ -5917,7 +5915,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t) prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - message buffer */
 	message_buf = (struct dasd_rssd_messages *) (prssdp + 1);
@@ -5927,7 +5925,7 @@ static int dasd_eckd_read_message_buffer(struct dasd_device *device,
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(struct dasd_rssd_messages);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t) message_buf;
+	ccw->cda = (__u32)virt_to_phys(message_buf);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -6008,14 +6006,14 @@ static int dasd_eckd_query_host_access(struct dasd_device *device,
 	ccw->count = sizeof(struct dasd_psf_prssd_data);
 	ccw->flags |= CCW_FLAG_CC;
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t) prssdp;
+	ccw->cda = (__u32)virt_to_phys(prssdp);
 
 	/* Read Subsystem Data - query host access */
 	ccw++;
 	ccw->cmd_code = DASD_ECKD_CCW_RSSD;
 	ccw->count = sizeof(struct dasd_psf_query_host_access);
 	ccw->flags |= CCW_FLAG_SLI;
-	ccw->cda = (__u32)(addr_t) host_access;
+	ccw->cda = (__u32)virt_to_phys(host_access);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
@@ -6351,7 +6349,7 @@ dasd_eckd_psf_cuir_response(struct dasd_device *device, int response,
 	psf_cuir->ssid = device->path[pos].ssid;
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
-	ccw->cda = (__u32)(addr_t)psf_cuir;
+	ccw->cda = (__u32)virt_to_phys(psf_cuir);
 	ccw->flags = CCW_FLAG_SLI;
 	ccw->count = sizeof(struct dasd_psf_cuir_response);
 
diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
index d4d31cd11d26..a4cc772208a6 100644
--- a/drivers/s390/block/dasd_eer.c
+++ b/drivers/s390/block/dasd_eer.c
@@ -491,7 +491,7 @@ int dasd_eer_enable(struct dasd_device *device)
 	ccw->cmd_code = DASD_ECKD_CCW_SNSS;
 	ccw->count = SNSS_DATA_SIZE;
 	ccw->flags = 0;
-	ccw->cda = (__u32)(addr_t) cqr->data;
+	ccw->cda = (__u32)virt_to_phys(cqr->data);
 
 	cqr->buildclk = get_tod_clock();
 	cqr->status = DASD_CQR_FILLED;
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index cddfb01a3dca..bcb67fa747a7 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -83,7 +83,7 @@ define_extent(struct ccw1 * ccw, struct DE_fba_data *data, int rw,
 	ccw->cmd_code = DASD_FBA_CCW_DEFINE_EXTENT;
 	ccw->flags = 0;
 	ccw->count = 16;
-	ccw->cda = (__u32) __pa(data);
+	ccw->cda = (__u32)virt_to_phys(data);
 	memset(data, 0, sizeof (struct DE_fba_data));
 	if (rw == WRITE)
 		(data->mask).perm = 0x0;
@@ -103,7 +103,7 @@ locate_record(struct ccw1 * ccw, struct LO_fba_data *data, int rw,
 	ccw->cmd_code = DASD_FBA_CCW_LOCATE;
 	ccw->flags = 0;
 	ccw->count = 8;
-	ccw->cda = (__u32) __pa(data);
+	ccw->cda = (__u32)virt_to_phys(data);
 	memset(data, 0, sizeof (struct LO_fba_data));
 	if (rw == WRITE)
 		data->operation.cmd = 0x5;
@@ -262,7 +262,7 @@ static void ccw_write_zero(struct ccw1 *ccw, int count)
 	ccw->cmd_code = DASD_FBA_CCW_WRITE;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = count;
-	ccw->cda = (__u32) (addr_t) dasd_fba_zero_page;
+	ccw->cda = (__u32)virt_to_phys(dasd_fba_zero_page);
 }
 
 /*
@@ -528,11 +528,11 @@ static struct dasd_ccw_req *dasd_fba_build_cp_regular(
 			ccw->cmd_code = cmd;
 			ccw->count = block->bp_block;
 			if (idal_is_needed(dst, blksize)) {
-				ccw->cda = (__u32)(addr_t) idaws;
+				ccw->cda = (__u32)virt_to_phys(idaws);
 				ccw->flags = CCW_FLAG_IDA;
 				idaws = idal_create_words(idaws, dst, blksize);
 			} else {
-				ccw->cda = (__u32)(addr_t) dst;
+				ccw->cda = (__u32)virt_to_phys(dst);
 				ccw->flags = 0;
 			}
 			ccw++;
@@ -590,9 +590,9 @@ dasd_fba_free_cp(struct dasd_ccw_req *cqr, struct request *req)
 				ccw++;
 			if (dst) {
 				if (ccw->flags & CCW_FLAG_IDA)
-					cda = *((char **)((addr_t) ccw->cda));
+					cda = *((char **)phys_to_virt(ccw->cda));
 				else
-					cda = (char *)((addr_t) ccw->cda);
+					cda = phys_to_virt(ccw->cda);
 				if (dst != cda) {
 					if (rq_data_dir(req) == READ)
 						memcpy(dst, cda, bv.bv_len);
-- 
2.37.2

