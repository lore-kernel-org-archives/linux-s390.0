Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F148470448
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814481; cv=none; b=pyfTk8MLyRTyj7XXwQtNShclGfjeDJcO0uIu3UL0XZYhq5FfUepLrD3y6VGfe9d1qmMWZRPi6tCaaEM4ZCkPNIbXhDXiWniivntUsNK6DFsNg2sxfRyf+YOx6CqpNp0lxNQ5btlyE7P7Kel/U8FAkQsurOIoHUUI/UJkUtAc07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814481; c=relaxed/simple;
	bh=jtwYGJFn/1VmT7Qc4AAu8qnhJ/STE0xWscP5c6Tdk1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvDzn0ApLecawuIz8fRmiTbmaFxcf5cob0qqu1BbrAAFJHmdeISBIxy08Cf/wgR6OR4h+8g2nHdaaSwq1U64vvywta+cn4SOGHplVXF+ruWsL9A5U1RTS1U8EI8PXeI9CiGiI7nQkFeaqwyj/77pAuAwLwziSGmIjSsYRxKVj/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jXH9kKgn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jXH9kKgn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBtlI3095062
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AsFv/cQnwk9ZiIyWz
	6nzOhL7VTTFlksA4I8fT4+HVCA=; b=jXH9kKgn9Lmt+zaGWfM1+FAAQeOEKAlm1
	OB7F1z+Vzm7i75m9Ik+DBuzZNsPWVSzYWktjfftlbm7Vc8nermDRMOm58PTtlHQA
	qe5JgXCbm7SV32lG0tUBAFFQ3cM2os5ulYc2DdxXrtWZe5bc+uUOHFpQ/4EhJd/L
	QnPCho0x1sSGVJCrMkxJHbbjTUFoazt+abXTQTyIMoB7yKW4dRKwsklYIZr9Nvvh
	qYufl+ul+gqHGXQz3WDT6Kr/aedEkiucsgFI1Dqo8f4FT9xB5P264mroc8eN9kXt
	yCqiAulCmmaTg0ACkj6sgeZK8Jfm92GZQlJ88edM6fGJyvMnAP15g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahf7bu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NDYYWS025668
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqcjty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NDlnBj59179424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 13:47:49 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F7562004B;
	Thu, 23 Jul 2026 13:47:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54BF02004E;
	Thu, 23 Jul 2026 13:47:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 13:47:49 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v3 13/13] s390/dasd: Read cached unit address and LSS in the CCW build path
Date: Thu, 23 Jul 2026 15:47:43 +0200
Message-ID: <20260723134743.672413-14-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723134743.672413-1-sth@linux.ibm.com>
References: <20260723134743.672413-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xIAC2_cuNVdrpG2ssc51SXsZ1slVOYp4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfXw1V/UXCCToKz
 61CidITihJ7/Rgp4dt/k70hcT4UwPa/DZqFe0EeFp+a/V0RZhsTM3QCafII4jJ24ysIQrCK2Hn+
 6xELgJlbf2b2QchwwBGTS/mO7rNaNvkYvyH4eLKbWhOS4olIdJL1TKJKWn+RD900ceJSsqdzRuE
 zTkfvpWflPZTxvbf6p7Gu5YLtIPPPmUnjXjVmu0VyO+sk3WKdxRwX6Cu8qnis95Xm6aeqTgPR/o
 SE/aDoLPrkBT1z5qDij3qQt7cYBjk7tOwFtyfi6bsLOmYB489EGJnJAwIFycVTu4CxH/ukFQJKQ
 wXFoNNNN9HejYtBiuUmGHc/VIl7Wl5YVViKwKClxBRO4Yf0KAGup/PuhiEanlfbqLdr651pfcby
 OJr2jZ5RZk113p3gr59Op7lbn/PL8aGtBUpuhsluf0dVsGNq2OqLaum8wHNOU4t1s4rAr8FQaRi
 Z8Ey0j/74V/g1p7rbZw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX6uum4vs2A3aP
 /6/lk/GJIcDcqCrUYaYOm4o+Ll1DwWzy6seaRkyHXb2bCWScH4rt9+eDCR5lAnffcGozk/gHKay
 Mobf8WppgVysTq2QV3ISFgrIvtOIjNQ=
X-Proofpoint-GUID: xIAC2_cuNVdrpG2ssc51SXsZ1slVOYp4
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a621b89 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=OPmwjG8nANrwyK2qht4A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230135

The CCW build path (prefix_LRE, the full-track prefix and dso_ras) read the
base address and LSS straight from conf.ned. That buffer is freed and
reallocated by the reload worker (do_reload_device - dasd_eckd_read_conf -
dasd_eckd_clear_conf_data), so a configuration change concurrent with I/O
can free conf.ned while a request is being built.
Use-after-free reported by KASAN in prefix_LRE.

Read the cached copies instead.
The unit address is already kept in uid.real_unit_addr, and the LSS is now
cached in ned_lss. Both are refreshed under the ccwdev lock in
dasd_eckd_generate_uid whenever the configuration is (re)read.
Also fix for prepare for read subsystem data (prssd) users.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 25 +++++++++++++++----------
 drivers/s390/block/dasd_eckd.h |  2 ++
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index ba429467f3c4..19f794c7af3b 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -587,8 +587,9 @@ static int prefix_LRE(struct ccw1 *ccw, struct PFX_eckd_data *pfxdata,
 		return -EINVAL;
 	}
 	pfxdata->format = format;
-	pfxdata->base_address = basepriv->conf.ned->unit_addr;
-	pfxdata->base_lss = basepriv->conf.ned->ID;
+	/* cached copies - conf.ned may be freed under us by the reload worker */
+	pfxdata->base_address = basepriv->uid.real_unit_addr;
+	pfxdata->base_lss = basepriv->ned_lss;
 	pfxdata->validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
@@ -805,6 +806,8 @@ static int dasd_eckd_generate_uid(struct dasd_device *device)
 		return -ENODEV;
 	spin_lock_irqsave(get_ccwdev_lock(device->cdev), flags);
 	create_uid(&private->conf, &private->uid);
+	/* cache the LSS for the lockless CCW-build path (see ned_lss) */
+	private->ned_lss = private->conf.ned->ID;
 	spin_unlock_irqrestore(get_ccwdev_lock(device->cdev), flags);
 	return 0;
 }
@@ -1628,8 +1631,8 @@ static int dasd_eckd_read_vol_info(struct dasd_device *device)
 	prssdp = cqr->data;
 	prssdp->order = PSF_ORDER_PRSSD;
 	prssdp->suborder = PSF_SUBORDER_VSQ;	/* Volume Storage Query */
-	prssdp->lss = private->conf.ned->ID;
-	prssdp->volume = private->conf.ned->unit_addr;
+	prssdp->lss = private->ned_lss;
+	prssdp->volume = private->uid.real_unit_addr;
 
 	ccw = cqr->cpaddr;
 	ccw->cmd_code = DASD_ECKD_CCW_PSF;
@@ -4190,8 +4193,9 @@ dasd_eckd_dso_ras(struct dasd_device *device, struct dasd_block *block,
 	if (!req && features->feature[56] & 0x01 && !copy_relation)
 		ras_data->op_flags.guarantee_init = 1;
 
-	ras_data->lss = private->conf.ned->ID;
-	ras_data->dev_addr = private->conf.ned->unit_addr;
+	/* cached copies - conf.ned may be freed under us by the reload worker */
+	ras_data->lss = private->ned_lss;
+	ras_data->dev_addr = private->uid.real_unit_addr;
 	ras_data->nr_exts = nr_exts;
 
 	if (by_extent) {
@@ -4762,8 +4766,9 @@ static int prepare_itcw(struct itcw *itcw,
 	lredata = &pfxdata->locate_record;
 
 	pfxdata->format = 1; /* PFX with LRE */
-	pfxdata->base_address = basepriv->conf.ned->unit_addr;
-	pfxdata->base_lss = basepriv->conf.ned->ID;
+	/* cached copies - conf.ned may be freed under us by the reload worker */
+	pfxdata->base_address = basepriv->uid.real_unit_addr;
+	pfxdata->base_lss = basepriv->ned_lss;
 	pfxdata->validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
@@ -6832,8 +6837,8 @@ static int dasd_eckd_query_host_access(struct dasd_device *device,
 	prssdp->order = PSF_ORDER_PRSSD;
 	prssdp->suborder = PSF_SUBORDER_QHA;	/* query host access */
 	/* LSS and Volume that will be queried */
-	prssdp->lss = private->conf.ned->ID;
-	prssdp->volume = private->conf.ned->unit_addr;
+	prssdp->lss = private->ned_lss;
+	prssdp->volume = private->uid.real_unit_addr;
 	/* all other bytes of prssdp must be zero */
 
 	ccw = cqr->cpaddr;
diff --git a/drivers/s390/block/dasd_eckd.h b/drivers/s390/block/dasd_eckd.h
index 93529b4f376c..035d11ddd0de 100644
--- a/drivers/s390/block/dasd_eckd.h
+++ b/drivers/s390/block/dasd_eckd.h
@@ -729,6 +729,8 @@ struct dasd_eckd_private {
 
 	/* alias management */
 	struct dasd_uid uid;
+	/* Cached copy of conf.ned->ID (the LSS), refreshed under ccwdev_lock */
+	__u8 ned_lss;
 	struct alias_pav_group *pavgroup;
 	struct alias_lcu *lcu;
 	int count;
-- 
2.53.0

