Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5528E33B97F;
	Wed, 26 Nov 2025 16:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173204; cv=none; b=h50QzYGHRQvJ/jNS8U/9IyTMfYpqOAXyHIx5Ovm5UYCBcyxq0ZEE6Ur3JFi9PwDUTdCZ45WQQWH1lZ8yKUwh8Itx0nKm3AbwIWhkDnmSp0QopDTeGmCyizYMpSt/r1x4mIrYbNorR68pQVzizaTt4eOrMkkxm8xVcWI/VzW1x3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173204; c=relaxed/simple;
	bh=Qe+6qdBjVP2i52/XpDhZNZdVCN2Zah65zdS55EaRhyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jgfjvaYzOeDo1Ede5ThvTy6yQejDJQB2silNR9eVQY2KGwYxPkKVzSsu9FK08BJ1On6F4DigacBmjcdJcXlv1ucByeGkwNUxH0uYpCE9BUGMyI9nyEydMqEblXwsCBfvNdeUgn/GAYOXjyb/U4MRgsdTZ8CAwYeEClHDsImhy00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZVwpB/uT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZVwpB/uT"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQAIQm4006704;
	Wed, 26 Nov 2025 16:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MnPfX+
	iv9FVs6bMxEvEizt/DfC83x4brwcy5gna8RCE=; b=ZVwpB/uTYKJJVU5UYx68mm
	jQkLWMLIpI1dlVgvMr38f+lRdLbHgYdtM/XpiKbNgbArrSCabBqLrkyRLwborie1
	Ek+W8xQzRm1elOjygifo0g39lg3IQ59+ntethCX8cDkheNVIyIFsPntgbqZIjbd3
	p2OJVcESUVNhcKwBy1ZQiaQuhhvKvK8JHytsiVWhKjJalBZrtkkFgYMbrctrqvss
	pluReD7tMBcCv3tZsHuiRkzcXmlHSlxb9W5D9ZkR3XsLtg1fgk6b76ty7Jpp/5eb
	w8Ffmp7ZHAQiYXeVhekFQKFRsQ1ngHSs9LpkfHt1WCA7I2Z3GPgcA+wkboCsbCDQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak2kq4a4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:06:41 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQDUhJX027443;
	Wed, 26 Nov 2025 16:06:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4anq4h4d1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:06:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQG6YTF47776032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 16:06:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B97DD2004D;
	Wed, 26 Nov 2025 16:06:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA39C20043;
	Wed, 26 Nov 2025 16:06:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Nov 2025 16:06:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 7FFEDE047E; Wed, 26 Nov 2025 17:06:34 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/4] s390/dasd: Use scnprintf() instead of sprintf()
Date: Wed, 26 Nov 2025 17:06:34 +0100
Message-ID: <20251126160634.3446919-5-sth@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126160634.3446919-1-sth@linux.ibm.com>
References: <20251126160634.3446919-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAwMCBTYWx0ZWRfX7blDArzxiFch
 UlRikE33n7h2OIjU8X80D8wRnI8/4dHN8drK4ticH9PR5q+P25muviScs4JH3jVifl/IkwOCjXn
 YWAyG1GtcP2tBV9k0RLtfp3NJrFIf4gdDdZesf7tt60jpFnzcrFz5ubbCkTYWKUBe/l5shS2QqB
 Aw4G8a8K0FL8klzFZ3G4zL3JF1lGWDg2jruqgZGN74gCbtNT56MO2Md83+TtoEYDRR1baUBfHPY
 N9Bz1f+P9nAfquUvd7oo9huZLsufPwQBFRS9UUEIVT44Zp7go49axlZFfDK7P2BGDrBNdGFgi2P
 3wNL4XqgiFhUQvpK+Ihe+I46xaNQoja1UjvTdJaXoCjyjfMlaqYUg/QzjBwnxAdq93Vtzz5dnru
 sqrRw9XTfsTpPLzrxwg3irBZaalsGA==
X-Authority-Analysis: v=2.4 cv=fJM0HJae c=1 sm=1 tr=0 ts=69272591 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=Z1CxPU4tzBiM0jesnDwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: AVEasBLdsxT6vZW681MofdzvWiOGUvbp
X-Proofpoint-ORIG-GUID: AVEasBLdsxT6vZW681MofdzvWiOGUvbp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220000

From: Jan Höppner <hoeppner@linux.ibm.com>

Use scnprintf() instead of sprintf() for those cases where the
destination is an array and the size of the array is known at compile
time.

This prevents theoretical buffer overflows, but also avoids that people
again and again spend time to figure out if the code is actually safe.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_devmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_devmap.c b/drivers/s390/block/dasd_devmap.c
index ddbdf1f85d44..73972900fc55 100644
--- a/drivers/s390/block/dasd_devmap.c
+++ b/drivers/s390/block/dasd_devmap.c
@@ -355,7 +355,8 @@ static int __init dasd_parse_range(const char *range)
 	/* each device in dasd= parameter should be set initially online */
 	features |= DASD_FEATURE_INITIAL_ONLINE;
 	while (from <= to) {
-		sprintf(bus_id, "%01x.%01x.%04x", from_id0, from_id1, from++);
+		scnprintf(bus_id, sizeof(bus_id),
+			  "%01x.%01x.%04x", from_id0, from_id1, from++);
 		devmap = dasd_add_busid(bus_id, features);
 		if (IS_ERR(devmap)) {
 			rc = PTR_ERR(devmap);
-- 
2.51.0

