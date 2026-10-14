Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E357153CA85
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987697; cv=none; b=NgsXgDZExiqrpQmcgm6bGdEdXMjN6mka8wUg4klu2bYnzvmGgf6/7QE+wHXTX6sPf5SEoapSz9DcyNDP8nYOzhrzH7Nt4+n9L6+aFZKzcy+R7/SVLAC0LCMSD3cT5pj1eF0RgARYkpMjtEOlGB/PhKcQL3XBvhXeeawuYo1jmLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987697; c=relaxed/simple;
	bh=GMgnWVjPUWcwBkrzrFarf+1pyy06yXxlEMHZqyqQE1w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=o0xUZ9ipQQquemwcQ7EV8ihudo5hk3vJ6R0xEFwZnrtW2jQh1PPCzEWFWoarUfeLiQKHFFeDkx+O9JGiaZHKHxQUySmW+L6PuYy7U9qjpav1FkwoHRekhyJSnRxVPNUskkv9b38GpKiEQoAwYQcOsOk+pP/HddgdLZtV83PoNus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kiSCAgzw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kiSCAgzw"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EAPJwf150035
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 14:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=N4MFhqcZI4oLwKjRneeibkFTZqVS
	Zl2hqUjc9CSilYE=; b=kiSCAgzw1jp95T7zerL7ETQyKuPCs2MDs/FH+TLn6eEA
	E8xbUWxKCpnTTkFNy4VU5Oc9WccBR4wnXzAU5iFzJaM3xwRmZJBc7zW7bJiNYzXa
	m4QUJLav+ycsI6ERMYvKq/KLxaDWjjHu/XyIcmVGGBVtIPkYbQcteFzdAkRg8W7G
	DKBfzFnH+jDOSkl9uc+T4k3xOnc3xVJje61rMWGduFIMLvBvdviFoBXbWa/xIKcH
	tEnHur2mNh4Fz2YPSaGsD4TFu38u1bWvpBEMSFYBCaPyC7tUVJBpG67hi+UGXEzL
	uBG2G+jY6v1nGsyjdSCB32zDdR9D/P3IX2CLqmd8vg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhmvnw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 14:21:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69EB7BVg3212002
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 14:21:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9q2yn6wk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 14:21:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69EELWBx44630318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 14:21:32 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F087520049
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 14:21:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C25F420040
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 14:21:31 +0000 (GMT)
Received: from li-c11aa8cc-2ecc-11b2-a85c-95df2f347b4c.ibm.com (unknown [9.111.69.112])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <linux-s390@vger.kernel.org>; Wed, 14 Oct 2026 14:21:31 +0000 (GMT)
From: Volkan Unal <vunal@linux.ibm.com>
To: linux-s390@vger.kernel.org
Subject: [PATCH v1] s390/dasd: Fix memory leak in FBA driver initialization
Date: Wed, 14 Oct 2026 15:21:30 +0100
Message-ID: <20261014142130.756272-1-vunal@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX+A5PLAumx62d
 oq7mFVLkfD1HohNMwBOXeogut3eavavV82WClJMNpP4XEaMV2Zmax0+ajQ+5H4X2Jb98jQbcXNe
 iLuFdLejm3qCzxyRUjVodCEwk69jRpc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NiBTYWx0ZWRfX8nZVX9qgWytX
 o/Fbp9jjCqcHAKeeYuYbGDenZIsx1qDi75ZccorZDQZin3RW6DYWZC9wStDpXh7vYNXuQFAryH0
 DLbHb0ApUkHo9cUgbiJTcTqVwAge3uGZ+dptdcZyLRRZHtHtMENzu2cAxhcNM18q2Qu8cikBl1s
 xp/9A6xOdQ61nmU2JT2jkKWvqxSlbjyjzVjZnItpeEp0j9fAMOwIUXay9mkxiyTxERQpAUHOfa2
 6b2zc6pR7iWIwlGwGpPnTi3pUDupOLR0ZIGC3waKgeTeYgsbzprMQ7r/lyrtiZd7hC2J7sSB7+6
 bBsL7ZtBi/NZw1PCFeaaF1O8VoF2MblCafETNrebH0aEbFKYKU7us33eP1he6mfWxMJLs/PQHe8
 ajVY57ygavWKIMnnQFtHifsoYON2xG229QEffLYiD0G1dDPohECtwRmEJSX+aWrio7khprAzXUB
 EI/98GnuzicaSJ10HUg==
X-Proofpoint-GUID: Lz-KAMClqmJMp1cOXorvWzRc-hIv0DeI
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acf8fef cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=OZ06gVdjTFqNWBltAnYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Lz-KAMClqmJMp1cOXorvWzRc-hIv0DeI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140056

Fix memory leak in dasd_fba_init() where the allocated zero page
is not freed if ccw_driver_register() fails.

Reviewed-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Volkan Unal <vunal@linux.ibm.com>
---
 drivers/s390/block/dasd_fba.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 3f56b353b868..3b8d15e9a2de 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -804,10 +804,13 @@ dasd_fba_init(void)
 		return -ENOMEM;
 
 	ret = ccw_driver_register(&dasd_fba_driver);
-	if (!ret)
-		wait_for_device_probe();
+	if (ret) {
+		free_page((unsigned long)dasd_fba_zero_page);
+		return ret;
+	}
 
-	return ret;
+	wait_for_device_probe();
+	return 0;
 }
 
 static void __exit
-- 
2.55.0

