Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD514334DE;
	Wed,  5 Aug 2026 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928599; cv=none; b=V8RbRF79xEy3BUe83627FGWhbselihzvswrYbUXnpMohukxLulzpEf3K2WPAN+3rodUWbbVOBgO3T6FUDGye/mZyxKBhjZexhm8SKxONS+coNrcgNxMfyOOykziOaNlXzAujWO9KiR/6B7F7mSF+tpIY/BUdyaQnQPnRV4PKrtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928599; c=relaxed/simple;
	bh=6XZW2WMvdzIxb68pMBhac41tyfDkit6tXwhNGhCEk70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L3Myb9XdCG8A5hbCk2HvLrMJeBtafVLECtutWm+IR2SOjyNg0RiU3ODWJ3UsZhVVi+BxbLxnMjxQrbFqwdt5Qi16PR5QiztA3XUFkyiF/JBumgf3SKIOiEkfKyRKVpfDFR75I/AOq+VEhr4T0oi4EEQonLpN65uDmY1SjeTsoVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OH8a2uP/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OH8a2uP/"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758ljE83288699;
	Wed, 5 Aug 2026 11:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WHM+DL
	SkI1o7d6g8f29F02GGPtmf93K+O0GfZh/u1Bw=; b=OH8a2uP/8esCUiZl5MwllN
	PVH5R0cuKQ6vegeaTvCYUv6kXAfuimWDppx1+u0PVF+YKjol0hEezADJ/yYQvhi7
	YVbDqufACaGvrgSAiU0YbyBMkoTO9eoboM8FQTrMd5prHq9ZdSN7z+8st+qIX61G
	E3jOpUEoZHBYhiKM2euGKUfckkqpbiJQp6nflYOXju9i83tYNdkM2K5qB9RRqU/x
	JluEi64k4skb8RX0CgxTPPrkr+heOqiHnTczOmWsokTl3s7cQz3d9bg0U4X5Cfro
	0XgbecKjJ0wLaVN+my/1qBnAReBByNss4sofQobGPVva/ypc50CqPE9INQxWZu8w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67htg7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675BBGXl020880;
	Wed, 5 Aug 2026 11:16:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw6btc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 11:16:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675BGJsP43581910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 11:16:19 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6048C2004D;
	Wed,  5 Aug 2026 11:16:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 439CE2004E;
	Wed,  5 Aug 2026 11:16:19 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 11:16:19 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 17/19] s390/dasd: Report ESE capability and format mode at device online
Date: Wed,  5 Aug 2026 13:16:10 +0200
Message-ID: <20260805111612.1285190-18-sth@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfX34RcmcSHBrLY
 QI+VaRnVTktm3pHoFTwn6cNf3zr53SmfcbtHoEO2pEw0KiAPE61uiEeWPxkpw60CjNnjrTmuG/g
 3UEeTVbRZItoXIOZ41NmI/WZOTh3f9I=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a731b8a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=_yd_xlNYP7hmE0PasyQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA4NiBTYWx0ZWRfXzGsvc6DY4tdR
 kO0LY0bsX4YpUQGObQcWrnp1I3RvecrMXzqUV7QF5rx5QrBFUFb0QHa+Mp+RDaoYo5m7jkQ0yUL
 2F4cmdyMpClSyLmM5cQplYT6Wo3fMO7afPtjaeDojT362LCfzTLhyEiLEWTbFegpUfTxnxTtc5I
 kW3rdpC4hpZ2svY2azsXy+ZLRsBfVxMZ2wmFRR6RrK0ePhRNV5fUzqKHEpoQSrFEaxunMgCwcLf
 Q9j0DorH7OrdsIHINs27mILrkbwFchuoAvnEgivGfTanKD3IfTbIl6z0BcT/IZeDTkw95PDqBgk
 XCQPtaqIvEQFXQkyTHVHnnG3W6r5cMB2Uvd5OrR9wskzHkV6rI7HLf9243WO4cuOfBGdCdTXXRB
 XiMUnVWiPwcvZ+TnsSUXYeFw55v7klJcca1ajFggEvmmlD6nd53Zp7BR+rDdDIKDvQpQ7t+mBdj
 gMKQZr8iPum+rWrAJ5w==
X-Proofpoint-ORIG-GUID: MChX-d6plWYJBoKxHQxrFYRiwUJEYYKl
X-Proofpoint-GUID: MChX-d6plWYJBoKxHQxrFYRiwUJEYYKl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050086

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
index d5854ed0076e..3c4fcfb1558d 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2523,6 +2523,7 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
 	struct dasd_device *device = block->base;
 	struct dasd_eckd_private *private = device->private;
 	struct eckd_count *count_area;
+	const char *ese_str, *fmt_str;
 	unsigned int sb, blk_per_trk;
 	int status, i;
 	struct dasd_ccw_req *init_cqr;
@@ -2609,15 +2610,29 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
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

