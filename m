Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7643D4F5
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512355; cv=none; b=YWKvnNgMgRUXAjxgQ9NBfswIJZsILbMTtxKB9ZS94u03rv08DmP63OyiNf7CDf9LqVswGIBtaPQrhvLJkcO9URH66ktk72h4KZHpEUTLrn3anuNFRCJHy6nSW4zFZPxtEIqNxwA1JBz2H4AT7RWw3eiPq7UQ3GJRkdgWQB5P86c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512355; c=relaxed/simple;
	bh=0kM3BQZAnjj6DPp4axf6hm5R/5DeOQQ03/rsFiehmXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cFxNBnhdH3y97imIopjsfcSnEoyEPWftV82gDG11IGkKmILhDEIHCZFOnBwXOvgpICBVF/7wKjqU3axDx6YggKXrIV4n5rMH7AMCHW4X9C3Y1ELn6dLwjjSTUUPhMmFm9hwMRwBDvoRaKjg836zFgNCobc7nYM3vgaPc2ZA0iMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WPwFAS6j; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WPwFAS6j"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlwAs1791087
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hfNqD+
	tWONOCCqzBY7Hm22T5Aces/p59Us2aOB/pmuw=; b=WPwFAS6jW50meViimuxSTl
	yJIsJgdTaIde3yFR3sKu+jBNg5Lk6xjFsy636KkQjl3moyvNZxjSIK4uKu50zidW
	wgF5/3+WNpIXjqiPYPVxvGdKSRZ3jmbhHjgJX6NUz7IAkSwOpj/Gutjhx7E0YbGa
	y3zGtFfdQ6JjmfOYcsYC/tGdRi2evBYpCb5w7Ix6ez8wL0IkQryV00lJiHY+b/e5
	IUMFnyR8bzBd50cCVi8zNYP2/7PN452hgN1Eoh16htZ269KoGyVW7BfNRJWiK8L6
	M6RNyiyGvN9GcSxw/AFn6bkIIHFmJlcYSHddLmRdXK6HCCYyqcJZYbTCq5mM93IQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwdcrdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VFBSV8026072
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:06 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhrd8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 15:39:05 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VFd1WY28639494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 15:39:01 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CFDB20040;
	Fri, 31 Jul 2026 15:39:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 763F92004B;
	Fri, 31 Jul 2026 15:39:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 15:39:01 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>,
        Eduard Shishkin <edward6@linux.ibm.com>
Subject: [PATCH v5 15/17] s390/dasd: Report ESE capability and format mode at device online
Date: Fri, 31 Jul 2026 17:38:40 +0200
Message-ID: <20260731153842.1729627-16-sth@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: pEMoFyIpIAkcOhu0tH7boAJDmPMr0ECp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfX0ekI0vyfzfwy
 krX5gD6zJUzg+YTQi2/7RgoRTa4dIAR/9YuZFbU+s8Uw6NYRBUxSjJfVhU4ol50oYiCZJwAnGm8
 OQZG9AOZL+6nBZnxpZ0iEQ+UMKLX0/E=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6cc19a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=_yd_xlNYP7hmE0PasyQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDExNiBTYWx0ZWRfX7UxM93sBINX3
 9Zpm5b+46SkXLCKQ+NggVWm5fID8X8FwhDDEisQ6UCaT66h+2WRtJ7BUcnBW84HombaUVONXshB
 JTecUHn8wXW05ilDHtWSUUiVRXh8UeM0lIkW15LLarPpPUY15BlWm6FGdrR5VyIhT/7HuYhvUC1
 qqR2Ta39ZFeVvC6HcjEFYIBe7sYbNsZJNcDotfZQM4I46Mnwg7TeAspXNKbqmxeoyunqup5AGAQ
 LENr4ss5B/lUXy0DF3XDKWMMlL2hz2nd3oDW4t6PhNRx4aK4hqmQb9LLeDansavDy9EQqNTNrwE
 ywiL+K1i1nouW66WXBffvLC6aV3dRivz5jbQEMoISl8nf9baxaYGcsvYXkHBTQNqKVJQGi4F0zG
 Y1JWZAYjqx5maLIet4jqTqBdQmNmoceHp5GWrNqA3oHd6o46o6siI3/JjILLDPrrSnnohb6lWzv
 ubvALA5KdRuLZod8+Nw==
X-Proofpoint-GUID: pEMoFyIpIAkcOhu0tH7boAJDmPMr0ECp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310116

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
index 98db3f0bd60e..787c3cc6ac68 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2518,6 +2518,7 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
 	struct dasd_device *device = block->base;
 	struct dasd_eckd_private *private = device->private;
 	struct eckd_count *count_area;
+	const char *ese_str, *fmt_str;
 	unsigned int sb, blk_per_trk;
 	int status, i;
 	struct dasd_ccw_req *init_cqr;
@@ -2604,15 +2605,29 @@ static int dasd_eckd_end_analysis(struct dasd_block *block)
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

