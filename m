Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA0E4334AE;
	Wed,  5 Aug 2026 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928595; cv=none; b=uYavlueL1ivVcn9PFfmuxx2op7d0k48h+R+h/Dm60a7dqoO/OL77QZvmZwir+gFdGSzKQoVjRFyc8/KodopTb93zOT8o3tgxLcgrHPS+AU1vNBOXbpYXrSOMklu7KTNv6iK+kZog/0vJ7ff/x5gekILEydtuLgK7JkOhZ6PTn0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928595; c=relaxed/simple;
	bh=ZPc4Zo1UkwfcvMB4oKt7VrTdvm8ibMZ0YZAdFhRCoPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUviIdOM+llGDBVYT9qgEYRQUKKCe6UvVvUgx5KB/JyrFJnawhz0cMsSXW5y/Xub49WPNxVNgXj7nAuyaymCnm6uIfX6KHVRNvzpe0sSTb7h04kpvUxrbkkXJwHHh8yo9Sz3likB/Al4L7YCX7K16EG943XRFC0ibIsuk53K/lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZZezynmf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZZezynmf"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758lZEK3354411;
	Wed, 5 Aug 2026 11:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ml5FtK
	bcAbApMlBjJawl2jY6zG+8qZ21O7BRPKxDgj0=; b=ZZezynmfJO6pPviOX/ktft
	5uOQgh0Ms60OcHhm054B6clQxZHB5r1a7J/1v4J2MYHbrOrsTbFsua6H4UkKCkeF
	pIDWcUUT+82ScRo/q7JcVXsHn3hqDXbgIcxyIzLtOb2pkuD0IlR/X2syE5Ru7Jp5
	Aq6M1VlC35ktUCgEjYh2g04rNRYfZnVxx8bLz2AI1ZhtGRzYaYlOYK4Z+B9AzBp0
	RuOdpomezyIV89VtrPJZ7R4P561dlphAof7bOirRaz1I6+F5X8adVO38+cV1tkNB
	aWBs1TvUpuCw/EUTcNSdlZcj2zFGEExWYgrp83emBsQaEscWWwu+XHdUyM4/O4sQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a42prp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BBKIB029194;
	Wed, 5 Aug 2026 11:16:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhe65p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGIxh32375238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D24F2004D;
	Wed,  5 Aug 2026 11:16:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1011D2004B;
	Wed,  5 Aug 2026 11:16:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:16:18 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 10/19] s390/dasd: Extend prepare_itcw() to support WRITE_FULL_TRACK
Date: Wed,  5 Aug 2026 13:16:03 +0200
Message-ID: <20260805111612.1285190-11-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260805111612.1285190-1-sth@linux.ibm.com>
References: <20260805111612.1285190-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a731b89 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=z9cVXL644kTWRId5wbEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WSNYl4ibfn1TTLzWCR2V5F1uUjZBzQN6
X-Proofpoint-GUID: WSNYl4ibfn1TTLzWCR2V5F1uUjZBzQN6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX8G6/8qTExygc
 /lOEyeDKPRyB4gUqq0lwVaR2rqnJ4cJDsbuXnnMcZSHQ0r0srGumNO9MMwV1JdvS8JLl1TclBYP
 3CeitFmaIOhV2nDO2OBel5fCfKBfS3s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfXzU/y8tFCBiKz
 nIvFapMxAQ0KSFH9Txhlc73xXunLQzKb3QD+6Ts8sVqTgdKFpS9N+5PLrbkk31yepsEr2RiunKW
 gDblAbCHsccNksdqzF0vV3UB2SMqyNC2hA041nmJFRKu7t253mh5ycxpPNVFNgz0ECK0bX+XIcd
 fHdLmJO56y/AK2EEScgedQ1hOLhi/+Qr3+ESOKBpq0+DOQEP6tisk6xp7bF71bU8U8i0fxqhkfW
 AQQKYontJdYrucXKpH61sJp8c+VDfAB08TskZoIBBO/aC7FPB45hjXcS1d6sKUIB9oiMU7Vun03
 K1we7IJJBqgajQFHs4DumdUjw42ztZA/y/zx1Ak/+2SHyTfvi4TV0vMBslKECVtWxVYDmIBx6Ym
 BeAh1XH/eJk4nosL0idO53qHF+EX2Mipmdlr422C/Y0nU+bwbGRmmaaRhr8OosWmQrRFkryiSri
 9voqIEzmMNM5sK47MtQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608050086

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
index be54c356dc24..ae122fbdca3e 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -4388,11 +4388,13 @@ static int prepare_itcw(struct itcw *itcw,
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
@@ -4402,26 +4404,31 @@ static int prepare_itcw(struct itcw *itcw,
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
@@ -4451,7 +4458,38 @@ static int prepare_itcw(struct itcw *itcw,
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
@@ -4530,7 +4568,7 @@ static int prepare_itcw(struct itcw *itcw,
 	lredata->search_arg.record = rec_on_trk;
 
 	dcw = itcw_add_dcw(itcw, pfx_cmd, 0,
-		     &pfxdata, sizeof(pfxdata), total_data_size);
+			   pfxdata, pfxsize, total_data_size);
 	return PTR_ERR_OR_ZERO(dcw);
 }
 
-- 
2.53.0

