Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BDF3D564B
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785582625; cv=none; b=DfQs4QTP168QGf3dzxkZhrJJ0FcvjtgA/AzRE1b4xkRaZ0eOHTuaznaGDSkU221FvXzZd0WbWWJf9WvXJrPOOBczX3Zcj3OuxboHCYWw1SwUtpawBtmS9ifU1uol0Jh6YU01xEiBKhA/rfFa6vTw6YyeqIh3/xxgY6lxuVrP5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785582625; c=relaxed/simple;
	bh=tYguD8meh4MmgDZfe7DZeTxxBnSn6tBjicvZ2I24z1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L78MZQVIOB9w5ZvGUk2LD8WUCS+jZBiFn2jTpa/CbNZmewsPphaT6KT3s5gjeeUqIFP/IFf5srzNZUK0C+dzOwPFBQ49BnJyK9y5DyOKhL65pwez9SHaVbP6Ebxny3o9AQjOu3OnyXL8yfCqZb2WYPD3hlgSAWuPpU277iHstm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fZnTBzsC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fZnTBzsC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67130tD43672689
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yOeodh
	udKBkfnpyvJoPlEbD+UX6lhGEY8gAxk4Meja4=; b=fZnTBzsCXFpe6C5FIFvEP/
	GtD2hXQU14vhH/laKGC7xsw2hIic4CyFMKRqJ6hJJ/A+RHE2EIC0dcHG5Djo9HjT
	bk1Fz3fMSu0S1iwhAFASQq0i4koy3JB0gze37ycn51XxZwM4FPOfkYM8FTw///cC
	nIaRRBgY4zwl0fbnZjO9NZGo+8WogX6XV4OGucFR888jlFP2Bm/pT6Ut9BF8iGNT
	tTqDsGG6RCbFhKHQnsApPhpcWXKIZa4HgXdsDZSeuG/LObCjJ4Ext6yJ4q6G6uA/
	5Lji9Yjgk/+WRHMxYAIc/Vjiiy65R+G4jqZvWqFWgd5DaaX6/buhpB5Y25Aj8+ig
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4h3a3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 671AuX7L014293
	for <linux-s390@vger.kernel.org>; Sat, 1 Aug 2026 11:10:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5ykef4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sat, 01 Aug 2026 11:10:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 671BAJNF28049666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 1 Aug 2026 11:10:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 017C020043;
	Sat,  1 Aug 2026 11:10:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC2662004D;
	Sat,  1 Aug 2026 11:10:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat,  1 Aug 2026 11:10:18 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v6 16/18] s390/dasd: Report ESE capability and format mode at device online
Date: Sat,  1 Aug 2026 13:10:06 +0200
Message-ID: <20260801111008.3391031-17-sth@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX9rhPxMYiDsrT
 ClG0Q2/B/nfMMRXrRRTTHYQWQ9ksS1hEDipNcjnG47ieZFpu6GzCpntcTtXLfJNmixgXgZzjipy
 eTUQfdrRBN6lmyb7fOoiAVPhfZ+LayE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAxMDA4MyBTYWx0ZWRfX1XSq2NVkqLr2
 A8WXAuJAt9OLH1nocdT4a2YnuS7cIK3+mVgzR4Am8M7Ri3bZwGrDbtVYW/3z4Ytui4egGjt468m
 Y0NLLlA13D1D0n7aEPCuOSUfGjZd2TqbODlKi0kunlQr9MEOGvRkYaPWBf5XU4xKptfOjbmGTGt
 SmDyexM686hiPfogXD6DpoL+ZQpKG+GZZ6mnU9ZHeKqpoS68DmuwbKHSiOUQ3cx/0sf4Vt2RZ9b
 9eQNfjtohbB7ZKhluViYAbGdBaz7MuER9AeipOfK/3eL31zr0eX2MbwgvvP/+G9Q+9ZNiIfpbF3
 dZ64tdKv6gCzviMK453GP6AM1Ac9tEdkA8En20Yi17QgB62j5kvz6wLKpQyUMha0Dk/YZbNkJgg
 4gwV8xCjH0R4joYTSYr4vCI5LQcHT860de7TTkraORXpLGSR/NQHsoYd0pcYD0Hd/HqmcV7hp/V
 KB5vwkrgiq30qCi2pCA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a6dd41f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=_yd_xlNYP7hmE0PasyQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 01G1hwymmGWAKY_Adv_mfQOkQOwqjecL
X-Proofpoint-GUID: 01G1hwymmGWAKY_Adv_mfQOkQOwqjecL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_07,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608010083

Extend the device information line logged when a volume comes online with
the ESE hardware capability and the on-disk format mode. The format mode
(full or on demand) is derived from the on-disk format label alone, so a
volume that is not backed by ESE hardware but was still formatted on
demand is reported correctly.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 69a6a462e3e2..428a691ed5a1 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2522,6 +2522,7 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
 	struct dasd_device *device = block->base;
 	struct dasd_eckd_private *private = device->private;
 	struct eckd_count *count_area;
+	const char *ese_str, *fmt_str;
 	unsigned int sb, blk_per_trk;
 	int status, i;
 	struct dasd_ccw_req *init_cqr;
@@ -2608,15 +2609,29 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
 			  private->rdc_data.trk_per_cyl *
 			  blk_per_trk);
 
+	/*
+	 * Report the ESE hardware capability and the format mode. The mode
+	 * comes from dasd_eckd_on_demand_format() (the on-disk label, or the
+	 * ESE state when no label is present), matching the on_demand_formatting
+	 * sysfs attribute.
+	 */
+	ese_str = dasd_eckd_ese_capable(device) ? ", ESE" : "";
+	fmt_str = "";
+	if (dasd_eckd_on_demand_format(device))
+		fmt_str = ", on-demand format";
+	else if (dasd_eckd_ese_capable(device))
+		fmt_str = ", full format";
+
 	dev_info(&device->cdev->dev,
-		 "DASD with %u KB/block, %lu KB total size, %u KB/track, "
-		 "%s\n", (block->bp_block >> 10),
+		 "DASD with %u KB/block, %lu KB total size, %u KB/track, %s%s%s\n",
+		 (block->bp_block >> 10),
 		 (((unsigned long) private->real_cyl *
 		   private->rdc_data.trk_per_cyl *
 		   blk_per_trk * (block->bp_block >> 9)) >> 1),
 		 ((blk_per_trk * block->bp_block) >> 10),
 		 private->uses_cdl ?
-		 "compatible disk layout" : "linux disk layout");
+		 "compatible disk layout" : "linux disk layout",
+		 ese_str, fmt_str);
 
 	return 0;
 }
-- 
2.53.0

