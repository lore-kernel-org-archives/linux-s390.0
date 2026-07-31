Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CBF443E2F
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512351; cv=none; b=IbwC09iUEUvPn2dMTpeXI3KQrZcytqZ/dH4trsYitbub0694C6M4UWYXZs0EQmz+O5zFd2qvlV5VWgAJp1iVwQfIjkumFrtv+26deip6sYaqJHznFX7j83vVkrC9WOx3hpjpK0AYo2RcvqWUf45fJhfOYcPk5Gnz1GA5pCF79FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512351; c=relaxed/simple;
	bh=aEIsvNIDevY63n9LmKYu3+Le7CloBPEvt1Lax86qKmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wgw8MEShx6RflVEvAzgzmyRxJ4lsU4YZVO3yOLalPyiPUt5TwWRIuUEkV4+i959RUKHr52gf35LxSvvA4whhXPDPuOy94Y0EthWeWgPuu/wN5WfbOTNiMcUfAO/HGR9FMkjJQRTT5I58HndL2BF4H21njGbcVXUbFmNFJ+fUJrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LyB8ZIX6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LyB8ZIX6"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBm3FS1791182
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=K0H7xI
	pSlWzYo0OmC1Zlq83MN+uUfffiU5bK9TPXi7w=; b=LyB8ZIX6REr0up7MjSP+Nd
	KCmLYGtEIQIC5zrvP1NDox5vvlLvY8SrExxpvkwu7jx4zOVz3NO+AZaRfAvD6t7L
	2Ee2lOCobQUb46cB+FSErD5HuV6qFZ++JC/BEypeYheMAd+gFfASRSd1QEj0iMmY
	Pu2zZuC7jO3pKelLdGB7eaG/2uWfetH00n9x/9isEFbEbxjhkmqThs40BhJUSgNN
	tihtZ3RKvWByQOgR+R04EeqPWdO0NeDAVi+WDWuEfUDecWjBTBeGdYhed4tW62qT
	UZPYBXoFxB9HvP41LBnp0Eejt+btur7h0CaxcTXaqyscPdqvyoSpJGv80PzZnKsw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwdcrdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VFQhg7006707
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwgm6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VFd0OM44499450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 15:39:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 924E620049;
	Fri, 31 Jul 2026 15:39:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D7592004D;
	Fri, 31 Jul 2026 15:39:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 15:39:00 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v5 08/17] s390/dasd: Extend prepare_itcw() to support WRITE_FULL_TRACK
Date: Fri, 31 Jul 2026 17:38:33 +0200
Message-ID: <20260731153842.1729627-9-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731153842.1729627-1-sth@linux.ibm.com>
References: <20260731153842.1729627-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mKHchn4W8DnX9q60g2EO3_R3atFyt4E0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfX8cDodkBZhJP/
 o6AvksOkwrOl9UU94gghubo2dz0RycbiLEydQW5BCrjEGMML+Z4fSNNR5K4zv1a765dlb0yD9zI
 Or7JQ5uhoKPN7A+2CaR/uteKRD72JNE=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6cc199 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=z9cVXL644kTWRId5wbEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfX3wlm80r7eHxo
 ZXc05LfwtjtQkSG4S3cTKB9bP9IXJ/YTmE52Xnelo07cytLFpvsu7CJVLErTE4ubd6FpjlVvQrG
 7i4np95vOymDSXDAhdnlmM0Q2srYWvjPcMc8xNpcpsR5Yk2Ltg2lpkzLZpwH0gXrt8WpkLo3tMu
 0cOE++TXUCyJMF3fzjMcISb/WxfmZaTzNFF6LooekEnrehS0x8t9BD1XtntWK5/DVWl0h8lUcyU
 d3gipoq0h+IGlyUZi6Ks6Eq8ZFBXk+B1QJI98gYuobouuOv/sY+MKSKyLJm9ubumaE+wJERRedF
 L47gSX4rO0StguQP6MVcEdMFVfD3db/s+CT/jx5pI+2Q8eXByRenrgyXZKtjuaW3SlzUPauj9Mb
 KuK9y8t6sUC8VoY+2FdoDDto/wy6N157cLRkWK+Z4/La41m84nZtVV2RP5XZLyrH3Wow++wbxKT
 /TJVbP1cVRfr90gXLhg==
X-Proofpoint-GUID: mKHchn4W8DnX9q60g2EO3_R3atFyt4E0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310116

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
 drivers/s390/block/dasd_eckd.c | 65 +++++++++++++++++++++++++++-------
 1 file changed, 52 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 6577958fdc2d..2c1e0b02a9b2 100644
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
@@ -4446,7 +4453,39 @@ static int prepare_itcw(struct itcw *itcw,
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
@@ -4525,7 +4564,7 @@ static int prepare_itcw(struct itcw *itcw,
 	lredata->search_arg.record = rec_on_trk;
 
 	dcw = itcw_add_dcw(itcw, pfx_cmd, 0,
-		     &pfxdata, sizeof(pfxdata), total_data_size);
+			   pfxdata, pfxsize, total_data_size);
 	return PTR_ERR_OR_ZERO(dcw);
 }
 
-- 
2.53.0

