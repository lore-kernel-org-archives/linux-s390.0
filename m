Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6C433557D
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814478; cv=none; b=OJDUT/hLLPDa8n2ZYESBSTsLAbF/XRO/elu2HXvFoG8y9Qe1Q+MueBDzuo0kOLtWtAUJ+MgKt5979ATEnfCg9y2Yf+A7udDr2X6ISMog8rWRgJIWp6hiw9h2+v8gsPgbFO4vmqn/JvIG+zd1LwIHuZcGSl0jo23ZnHLGMN4COLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814478; c=relaxed/simple;
	bh=bccPoaEbuAcCUZ1wPpuskSoGNjEzZsA0pr5227V8ao4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGg+X3foaqYgICzYirykjBPK1wh+pjyEizhlLZ/Ubt20k3q+QhAtj7ngGbKo+rOnF73fg9Zdo5iQrtaT31enFbgS7d1E0+Uv6RT9ccS9JnO0+cweSKJT8vq0KKDK6/kNojDkhfM1it6I9w5wcq/QYGZA1yDWlTnKWzbo50eZGGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M5sq2XPs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M5sq2XPs"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NDBw4I1211213
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=K7pF4qhn4VnOJtVTG
	QqylnBUFOQyqhD0ulBrEq0EvDY=; b=M5sq2XPsVshu+HnZsRMOI3Pc4WAsX9y79
	EmxOZmjUW+nxWwTs1+zNsyTuzPW+9sqQ5XTPJLzPU/vRIdco5aw8bS50xDGycP/i
	Nof34iy6C1oj8C6NeRZn1Q1Apk4q1UsCl12dE71x1UV/XQND9KqSBy+JvoO22ein
	26R9rY6DTt3kKRuMQfvP8gD1L+ugLub3MlBX0Wf/ID9l/i48iddXKwk9rtBu4taI
	dsWHk9BFoV379KODOLTVOR28jRK3pKB0DdB4As9/9qx6W4HHgXr9eRvobFwyo+IJ
	sBXRzYwItzMa07L410iJqL3xPPUKvhcTFDIlpFdT3lNJ4z3q7U2Eg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77aqtd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NDYZ28025376
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6wcgrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 13:47:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NDlmTU51577208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 13:47:48 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D7AE20040;
	Thu, 23 Jul 2026 13:47:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 139C22004D;
	Thu, 23 Jul 2026 13:47:48 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 13:47:48 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v3 04/13] s390/dasd: Extend prepare_itcw() to support WRITE_FULL_TRACK
Date: Thu, 23 Jul 2026 15:47:34 +0200
Message-ID: <20260723134743.672413-5-sth@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: V0E9SvCxqbh3gFmrIGEeJOrBN-sJ5-uj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfX59LlqxsU2gzH
 D56+BGaEHDP+iuUj/SBdDVpJ2nPklJ/EMxCivTecY23VChFVh4/BFfZtgjwyCig/P5s4uWCiMSm
 GXuv6HBz/q+iu4ety1rCZ5JmMWrJ2RY=
X-Proofpoint-GUID: V0E9SvCxqbh3gFmrIGEeJOrBN-sJ5-uj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEzNSBTYWx0ZWRfXwffOmBtwYtRh
 dIifiE/Iuc+l4nBL+jEv2XP9vh4mFBtV+2zivs/76YnZiNVuqRt0YTRxNBscR9lLq8tptOehCTJ
 +IfiOpr3NpVLWH5QBBMsHwMLRMQ/KYizqs1Ax4xHGbk+EzhXEpRDPxNY9+N516wbn5XIgLTvt/d
 7yyF9GwuFZrfR6v9OMaAbj2itvYgTGKwE7at8cv+K5ucnu4IZZ5sFWe0h3n/Bu3mM8keGK8AFAF
 i/p2VBHqUr4I90qyCik5cITQtcv4P6Z1lhuaD1tcMpXaRU5Q7vc82fCaB7O8GUL9LGva/GgjKS7
 Wh6n3LgwKtJKKuxbmfHoGjh473KCa42XDjoPxQ/eYpVyBXvkuahlLbAl6BVMTW+a4rsvy7J+rpJ
 Ewsyu+/+Ir5AdtFR9fDp1yidTVRkXzFNuV+TUMVcnV39noP5plhlLWGRluUyfQ6VZPu5/kyYSPo
 Y7O0HT/5CKRjlfuTZJw==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a621b89 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=z9cVXL644kTWRId5wbEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_04,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230135

prepare_itcw() builds the FCX prefix block (PFX + LRE) for track-mode
I/O. Extend it to handle DASD_ECKD_CCW_WRITE_FULL_TRACK.

WRITE_FULL_TRACK needs two extra bytes appended to the LRE for that
bitmask. The prefix block is a scratch buffer copied into the TCCB by
itcw_add_dcw(), so keep it on the stack (sized for the two extra bytes)
rather than allocating it: this runs in the writeback path and must not
depend on an allocation that can fail under memory pressure.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 65 +++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 541b8eff647e..8649e57fe4c2 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -4356,11 +4356,13 @@ static int prepare_itcw(struct itcw *itcw,
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
@@ -4370,26 +4372,31 @@ static int prepare_itcw(struct itcw *itcw,
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
@@ -4419,7 +4426,39 @@ static int prepare_itcw(struct itcw *itcw,
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
+		lredata->length = 0;
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
@@ -4498,7 +4537,7 @@ static int prepare_itcw(struct itcw *itcw,
 	lredata->search_arg.record = rec_on_trk;
 
 	dcw = itcw_add_dcw(itcw, pfx_cmd, 0,
-		     &pfxdata, sizeof(pfxdata), total_data_size);
+			   pfxdata, pfxsize, total_data_size);
 	return PTR_ERR_OR_ZERO(dcw);
 }
 
-- 
2.53.0

