Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71A8401A29
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582625; cv=none; b=tD2EOLg9CBw17TVlRUHu674FswvLnBPlzHlPWTGm088m4w8lKupbA1HRddP5Q4dcQ1WcklJXDUJQFsbvKTCSRY6//iTd5ynOgub3TKphX+zMINQX6I+AObtEysfDSrBJZpKmJgek9d1jJXjcAg2wLHJDzBgkfT9Xh3MOcmGkxDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582625; c=relaxed/simple;
	bh=hQwKU0RcaM6/DVxCK+X6RVVQ/A3q4HoMjnBd5Ue1ClE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cmCLfBOri1wvYWciLuaSze8srk6eHFtm4USBBmWMdZHtlrkHGo9SKKfP1B0zfVlXbiyCqLlTUJvH3e4JAJR06AacSlillEYfhkzP/InwGAj5bRVLzszgAyfFLMi+saRfTQffLDYa9K6iakfOU6UpGwwMzv24GiBHBIDwoEgeHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MjNdNy7/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MjNdNy7/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 671317ig3672919
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rIDC3L
	ntZu7XulqUTzbAeVtlF4/nah0dIOkXpZORTyk=; b=MjNdNy7//bh64Z/iM99qRp
	lClPmnWTu4ymTa7HAfOuF6zh9lr8YU/k3gq8eW7gUJmJWTzkdy8zNKfGIMVkznwz
	/u6yWuqTq+T5zM2xpgzb6E12L2RZvJmQneFMs232SCx7sZ4yIoMyv9pRpgbUFvXD
	6k1vdTbRLXeRkmXJV1yWO/t5/xTOzuhGem74LsVsl4PraI0O6hLvpEAYrAmYGue+
	biM12Lq7srNiLyD37MtwKYAMhSuQCPln5XUIdcFhA/WleRaru5N/89GCkVTcx/u4
	QVljqA0b8ZUPGmu9sfBR6hEKStlwifcmY5lAk8qCC0MSgg7tM7BnGant3fkUeInA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4h39w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671AuMtt014343
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhum1m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671BAHGG48103864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 11:10:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D606E2004B;
	Sat,  1 Aug 2026 11:10:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC8A020043;
	Sat,  1 Aug 2026 11:10:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 11:10:17 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v6 09/18] s390/dasd: Extend prepare_itcw() to support WRITE_FULL_TRACK
Date: Sat,  1 Aug 2026 13:09:59 +0200
Message-ID: <20260801111008.3391031-10-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801111008.3391031-1-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX7cO5MHhRrN8O
 FBxyrAYBQKJCPzSIrf9qkPzyYPXboNt45Sg1rG/hqbqDex19/mTjinF6DbAYeOIMiiAG0zdEOrz
 y7vzxw5rbq+46qHLm5csi7U+ueKcugY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX5H/Xt8OgWgT5
 v2FS/wggPDa1cStAimtDZOnZ09Q2f/aGnNradd0euzaoOhz3edJuyu8QFsVTHUYYpXCcM+1OeKr
 O+jkmMJspR5W1PHI9AVZpQptsKY4Dqmgw6dh9FXxrSNeJb2Rv1ZvXvnXsNOzAB68inlpD59ry3d
 3D0E+IrwQ6+SdNgENSWDdmLiYTx/J1jEXrIIH3zRQs/XRlDnftSkK8lxDPeNJVQoN/kFnOLzz5Y
 jNG5iP7r/WhUzPsnLe1+C2qTniR6KWOKMDbZ73NQPFb4Q1KBFEQhsDw/ZT+JtgB2YOcmor4GvB/
 DOCSI6FOUuM+DkEPHRSNb9iX+iBbGkow2l8v9EY1EGHcRN4iSG/aq+U4mMEVzTUTm9Ib3aAC36w
 4Zyrz5Ueq/PLlvZ3EqWwMRGcOJjLvyLCfaje/XPHn3BSoRDYobSsUsLcvMWHrtWDBqpknoPRv3f
 DajCUzBVxWWDNiy/zKQ==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a6dd41e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=z9cVXL644kTWRId5wbEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 9T7nnEWue_r13O-bb0JW3fcHV0FJLKLq
X-Proofpoint-GUID: 9T7nnEWue_r13O-bb0JW3fcHV0FJLKLq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010083

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
index 577ce55da68f..a20ab98936b2 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -4383,11 +4383,13 @@ static int prepare_itcw(struct itcw *itcw,
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
@@ -4397,26 +4399,31 @@ static int prepare_itcw(struct itcw *itcw,
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
@@ -4446,7 +4453,38 @@ static int prepare_itcw(struct itcw *itcw,
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
@@ -4525,7 +4563,7 @@ static int prepare_itcw(struct itcw *itcw,
 	lredata->search_arg.record = rec_on_trk;
 
 	dcw = itcw_add_dcw(itcw, pfx_cmd, 0,
-		     &pfxdata, sizeof(pfxdata), total_data_size);
+			   pfxdata, pfxsize, total_data_size);
 	return PTR_ERR_OR_ZERO(dcw);
 }
 
-- 
2.53.0

