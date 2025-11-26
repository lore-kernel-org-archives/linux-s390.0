Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3183B277C9A;
	Wed, 26 Nov 2025 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764173204; cv=none; b=g7VtuV3SGEG2rlvy3VFgi0/mEDBzmMq5VpHk0a2dm223xXEkX8pR9UNh3zZNC0yboJwdu+cTcOQV4+rfLsaEchCnsiCSpvzqiPlzV9loV0xXfD3Me/DzCpbErCxrysn6wY10im1bZ4t6B1q4pWyLv7aTwfts6WEUkMffcPoMkdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764173204; c=relaxed/simple;
	bh=bLlpAQP6FHUXVTutbay2yKEJQgzvOQrCAu2IO/PXnTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSgNrwwxq1RlMpPK7P8MnZt2XvUpA9bIrqgsj9p0pjXEzX3VR7kj+TBurHT0YJmROvuwCULeh0M0SQBNL7cRGXo81xBXRPmUntMFmfH9Ylh6DwoDAHlNQqKBcxgybcYiUe+V8onebL3lpi07SBiVqCve74HXuxFTWhowqih+8Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pejq2Ubw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pejq2Ubw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQC5nco009766;
	Wed, 26 Nov 2025 16:06:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=old/KoKWipBmm6f6u
	187zs1JY2qY4moB8fQWAaQCdfU=; b=pejq2UbwjqcEqjiM4rhvZ34FY64x2kUW5
	WkHZ+2P0ckeWcWmPooSvfDKN4YP7UE9/UBW6SBvfIMMurpZWUXpAEimkOSwvZ+R1
	m/1FZPGOYE+uBBOuSHckzI8z5QWilYqGFFV5NaKFkcMyw8rXMPXpbotoju6P/O8t
	7p9UdJN5FE1RNdjOlcpNGtjSaQ9ICGvFiSoxAnZXh9m3yr4oP4S+OmPxpYnSvD7r
	vKswAghSIQVuTv4pS5tEgVSkaAo3BYR3ry06VEA0Wk28eDhP787HvWO6kvSbtJuq
	qcUYlsbWoFG3XYUM6ZEtNmvMpwf2p5hKPGbij+vGRxy1Id5YkPFcw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ak4u243wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:06:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AQDkNLu030755;
	Wed, 26 Nov 2025 16:06:40 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4akqgsknmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 16:06:40 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AQG6Y0x48955768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Nov 2025 16:06:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C41A72004D;
	Wed, 26 Nov 2025 16:06:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B10E220043;
	Wed, 26 Nov 2025 16:06:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Nov 2025 16:06:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
	id 78ECFE0464; Wed, 26 Nov 2025 17:06:34 +0100 (CET)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/4] s390/dasd: Fix gendisk parent after copy pair swap
Date: Wed, 26 Nov 2025 17:06:31 +0100
Message-ID: <20251126160634.3446919-2-sth@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251126160634.3446919-1-sth@linux.ibm.com>
References: <20251126160634.3446919-1-sth@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAyMSBTYWx0ZWRfX85yARuePHrq8
 6Y1MiIQt8pQ2bQ9yi/KpDgeqe54FbKnmXHR0VKobcqm8Zq1DlSH4cBL4a3YN/KUahtgutwZQ6Fk
 AeF3qqj86RHi7dsrWQFEC2YXOMXUAgLV/sEoPrO5VH0uZtx745z9AdA1Ikffj3YFqpcUf4dXtl3
 TwqMDnpnTkpYnzX/C7x39ujFYny2jnaMOprDB8quEu5625uy2iO51tcU+L2Z3VWKf2dFBxQdDqV
 W53bPsRarWXTwNT6Te8dALaD7GdEuZZgVJ3i3lIem914ZTsHop/kMR6qMNo/nh7L8ShnIUbHP/d
 ogxQhySVU5INWr4TW+g4tHSH0mHcg9GAm40n7oTCrWCDWNcY8o7kqbvMi00K9S3gEOyIzMKQOKj
 IieWqJ9Es92qjqpsfpMjV+XDnXWiJw==
X-Authority-Analysis: v=2.4 cv=SuidKfO0 c=1 sm=1 tr=0 ts=69272591 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dCf6F0qxv91GNDAvypAA:9
X-Proofpoint-ORIG-GUID: 8tOFUhlKVQut2yjPX7AgwxbFfYpJXuhv
X-Proofpoint-GUID: 8tOFUhlKVQut2yjPX7AgwxbFfYpJXuhv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1011 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511220021

After a copy pair swap the block device's "device" symlink points to
the secondary CCW device, but the gendisk's parent remained the
primary, leaving /sys/block/<dasdx> under the wrong parent.

Move the gendisk to the secondary's device with device_move(), keeping
the sysfs topology consistent after the swap.

Fixes: 413862caad6f ("s390/dasd: add copy pair swap capability")
Cc: stable@vger.kernel.org #6.1
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 88fa17aea2ec..ec0c62e5ef73 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -6150,6 +6150,7 @@ static int dasd_eckd_copy_pair_swap(struct dasd_device *device, char *prim_busid
 	struct dasd_copy_relation *copy;
 	struct dasd_block *block;
 	struct gendisk *gdp;
+	int rc;
 
 	copy = device->copy;
 	if (!copy)
@@ -6184,6 +6185,13 @@ static int dasd_eckd_copy_pair_swap(struct dasd_device *device, char *prim_busid
 	/* swap blocklayer device link */
 	gdp = block->gdp;
 	dasd_add_link_to_gendisk(gdp, secondary);
+	rc = device_move(disk_to_dev(gdp), &secondary->cdev->dev, DPM_ORDER_NONE);
+	if (rc) {
+		dev_err(&primary->cdev->dev,
+			"copy_pair_swap: moving blockdevice parent %s->%s failed (%d)\n",
+			dev_name(&primary->cdev->dev),
+			dev_name(&secondary->cdev->dev), rc);
+	}
 
 	/* re-enable device */
 	dasd_device_remove_stop_bits(primary, DASD_STOPPED_PPRC);
-- 
2.51.0

