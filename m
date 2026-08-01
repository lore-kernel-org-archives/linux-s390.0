Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D03BE162
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 18:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785607245; cv=none; b=oU74hfJhn52zPoWf6n4pFPwB65dR2yoWmvpa/m0q4ypH2CgMCgrxIcwWuu46hTGGsTq9ciBKJnritWtVIVqWDU/NGiluhr/nvzFcne94pf27EjqYfXs1gDgB3gn473vqSTj6pr03L4WFob7TIoL+tdkoTIZr5FGMemo0OVdogHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785607245; c=relaxed/simple;
	bh=EBSQ8naGzNkGQXcCcQYmUDBGctWzcGQ8CCrpOKYWMqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AoTMUXRsUv504syGcKd9Mz66NhTrZSEkl73gytVtREjV5GvTdI4TpcKUXE6CZZVmJIU3hJf2lhfCY6x0/Cx7/ErWm/Xg/GseBHPjI8xHamOoYNHUsxmHw6Io3pAH4y3buV0Q9jjXO9hWyA/H7Vs/x3SmGXkmz2ogAWdT+nCU1og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MQsRANUo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MQsRANUo"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671Flx8N875982
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=tIV2rX
	nO3NfxruMLrbEDxXgtho3MrM/P4Tz5jxSxclU=; b=MQsRANUoFyTMrPzjhd525Y
	+q1DPN/m020LhHJH+69Knl6C3zKHpsetrN6yShLmvtRfL1/O6ZOmw3Od3Ckow8Fh
	Ze1brs6vamOruhSe6A0PFFuLA+F4hIAH7I+Esf+lEDeKdjQveh4Mt32AJcJnJpIo
	zpLwA8FzEmpUCfOWHnOThBrKtVmWhC507/D0fQMPexhaW5T5/9fdNsFqutqsDsFJ
	uO8bQ+yS+CJYSOmYXA4E6xgicOCrtGeXSnWbLy0KH0onStpaJjs195m+ac4gIGUz
	6LJXcHb/mLPxHgpmIbrMofOY87ieUMa8f4HzbZD0vm0oKb01rgr/dZWpSIB0Xiyg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67ha9sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671HujaG030913
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 18:00:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhvmty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 18:00:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671I0bkU35127784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 18:00:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7067220040;
	Sat,  1 Aug 2026 18:00:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 589242004D;
	Sat,  1 Aug 2026 18:00:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 18:00:37 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v7 10/19] s390/dasd: Extend prepare_itcw() to support WRITE_FULL_TRACK
Date: Sat,  1 Aug 2026 20:00:24 +0200
Message-ID: <20260801180033.3679412-11-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801180033.3679412-1-sth@linux.ibm.com>
References: <20260801180033.3679412-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfXyIcuNwO87JtO
 sCQe9ySAJ4cRDOLVrD/LhpSRxyk0xNKgMbg5WHI8heNYKDWnjf3xHWm3OqoZ31027gNBkkqpvu3
 LbYs6i/yfCVdvknw2kKJkLtQbkPfwR8=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a6e344a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=z9cVXL644kTWRId5wbEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDE0MyBTYWx0ZWRfX7AqyQtfYfCTU
 focSWWJvCWFPNQML5NQN/Mm2lSEEYDqQ66BXLmOtHS7mzkewDyv2c/QJhSOajYUfLHEKIQkY/u3
 kbX7Xv/V4GakuK046WkKpTur96Y/1TwSJRVWGEgIQQ4nrpbyWWEj1GCuITdf1UGhh8iQ7Wp7adI
 548rvXyIfBdaU6Wo8J8ERa1c9BAWD0xaIuqN4aJ4IQeq3KwtFMjhhuBvEkv/CsgN9sqIywJqwjz
 7m/mp58mklKRoMiDJV5IkMQZ9nKwLR/TaE8oHIpGWLccA6GqJcAFLw52F2LoMe9PHg1suOp/OK+
 yzJCSiND+ENaLx6Pw41TCWFKDkTCZ8LBlmgSTNFSTZ40znYjAnOrfypY5qiztEeFsu34/ekuW2i
 NNQZcCVLzKSGUUGyS36juGzhMiAa2dtJDxUWaUzyqhNH8itnqQxnJhCC0TdFX95FA/+b7kbyGQG
 Vvnm7ACqDo5xr7ZiCew==
X-Proofpoint-ORIG-GUID: PrY9smYP5iNeHYlvDubqYqDehGmQIhlM
X-Proofpoint-GUID: PrY9smYP5iNeHYlvDubqYqDehGmQIhlM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-01_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608010143

prepare_itcw() builds the FCX prefix block (PFX + LRE) for track-mode
I/O. Extend it to handle DASD_ECKD_CCW_WRITE_FULL_TRACK.

WRITE_FULL_TRACK needs two extra bytes appended to the LRE for that
bitmask. The prefix block is a scratch buffer copied into the TCCB by
itcw_add_dcw(), so keep it on the stack (sized for the two extra bytes)
rather than allocating it: this runs in the writeback path and must not
depend on an allocation that can fail under memory pressure.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 64 +++++++++++++++++++++++++++-------
 1 file changed, 51 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index e1b096b9271f..8b0c32395c8b 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -4385,11 +4385,13 @@ static int prepare_itcw(struct itcw *itcw,
 			unsigned int tlf,
 			unsigned int blk_per_trk)
 {
-	struct PFX_eckd_data pfxdata;
+	u8 pfxbuf[sizeof(struct PFX_eckd_data) + 2] __aligned(8);
+	struct PFX_eckd_data *pfxdata = (struct PFX_eckd_data *)pfxbuf;
 	struct dasd_eckd_private *basepriv, *startpriv;
 	struct DE_eckd_data *dedata;
 	struct LRE_eckd_data *lredata;
 	struct dcw *dcw;
+	int pfxsize;
 
 	u32 begcyl, endcyl;
 	u16 heads, beghead, endhead;
@@ -4399,26 +4401,31 @@ static int prepare_itcw(struct itcw *itcw,
 	int sector = 0;
 	int dn, d;
 
+	pfxsize = sizeof(struct PFX_eckd_data);
+	/* prefix + LRE extended data */
+	if (cmd == DASD_ECKD_CCW_WRITE_FULL_TRACK)
+		pfxsize += 2;
+
+	memset(pfxbuf, 0, pfxsize);
 
 	/* setup prefix data */
 	basepriv = basedev->private;
 	startpriv = startdev->private;
-	dedata = &pfxdata.define_extent;
-	lredata = &pfxdata.locate_record;
+	dedata = &pfxdata->define_extent;
+	lredata = &pfxdata->locate_record;
 
-	memset(&pfxdata, 0, sizeof(pfxdata));
-	pfxdata.format = 1; /* PFX with LRE */
-	pfxdata.base_address = basepriv->conf.ned->unit_addr;
-	pfxdata.base_lss = basepriv->conf.ned->ID;
-	pfxdata.validity.define_extent = 1;
+	pfxdata->format = 1; /* PFX with LRE */
+	pfxdata->base_address = basepriv->conf.ned->unit_addr;
+	pfxdata->base_lss = basepriv->conf.ned->ID;
+	pfxdata->validity.define_extent = 1;
 
 	/* private uid is kept up to date, conf_data may be outdated */
 	if (startpriv->uid.type == UA_BASE_PAV_ALIAS)
-		pfxdata.validity.verify_base = 1;
+		pfxdata->validity.verify_base = 1;
 
 	if (startpriv->uid.type == UA_HYPER_PAV_ALIAS) {
-		pfxdata.validity.verify_base = 1;
-		pfxdata.validity.hyper_pav = 1;
+		pfxdata->validity.verify_base = 1;
+		pfxdata->validity.hyper_pav = 1;
 	}
 
 	switch (cmd) {
@@ -4448,7 +4455,38 @@ static int prepare_itcw(struct itcw *itcw,
 		 * data as well.
 		 */
 		if (dedata->ga_extended & 0x08 && dedata->ga_extended & 0x02)
-			pfxdata.validity.time_stamp = 1; /* 'Time Stamp Valid' */
+			pfxdata->validity.time_stamp = 1; /* 'Time Stamp Valid' */
+		pfx_cmd = DASD_ECKD_CCW_PFX;
+		break;
+	case DASD_ECKD_CCW_WRITE_FULL_TRACK:
+		dedata->mask.perm = 0x3;
+		dedata->mask.auth = 0x00;
+		dedata->attributes.operation = basepriv->attrib.operation;
+		dedata->blk_size = blksize;
+		dedata->ga_extended |= 0x42;
+		rc = set_timestamp(NULL, dedata, basedev);
+		lredata->operation.orientation = 0x0;
+		lredata->operation.operation = 0x3F;
+		lredata->extended_operation = 0x11;
+		lredata->auxiliary.check_bytes = 0x2;
+		lredata->extended_parameter_length = 0x02;
+		if (count > 8) {
+			lredata->extended_parameter[0] = 0xFF;
+			lredata->extended_parameter[1] = 0xFF;
+			lredata->extended_parameter[1] <<= (16 - count);
+		} else {
+			lredata->extended_parameter[0] = 0xFF;
+			lredata->extended_parameter[0] <<= (8 - count);
+			lredata->extended_parameter[1] = 0x00;
+		}
+		sector = 0xFF;
+		/*
+		 * If XRC is supported the System Time Stamp is set. The
+		 * validity of the time stamp must be reflected in the prefix
+		 * data as well.
+		 */
+		if (dedata->ga_extended & 0x08 && dedata->ga_extended & 0x02)
+			pfxdata->validity.time_stamp = 1; /* 'Time Stamp Valid' */
 		pfx_cmd = DASD_ECKD_CCW_PFX;
 		break;
 	case DASD_ECKD_CCW_READ_COUNT_MT:
@@ -4527,7 +4565,7 @@ static int prepare_itcw(struct itcw *itcw,
 	lredata->search_arg.record = rec_on_trk;
 
 	dcw = itcw_add_dcw(itcw, pfx_cmd, 0,
-		     &pfxdata, sizeof(pfxdata), total_data_size);
+			   pfxdata, pfxsize, total_data_size);
 	return PTR_ERR_OR_ZERO(dcw);
 }
 
-- 
2.53.0

