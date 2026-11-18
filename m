Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013251;
	b=HlV2jHNeo6/KE2Hrk9dTibDCHMcZXhMGkvRLC4+Uwm2xe7Wch2qetlJyQp3dXyaVfxPA
	 zxaTVZQ492u17J0V28OChCtSGq1adYuz2OAr5GjoKsgRiLITYk5jzMxG/Yx/PFWj+prLe
	 0YpEMom09inzkebO9WJe1H9rI3Uv2+QU/uQnuR+XRCNRO5e7IVtAuJIr/OBOeiwjavlRU
	 VXQJkE2pfrCJ9diwQUZYwTEiEA9Nblj5fXEoby9sZ84hiOGeo6QQa4UqcqiSMbdsQdoh7
	 P3QQfPnKHdKUMvw2eRv0IFjzvMGXB7yZcW6mCZDp1NtDdsLTAgG5bZVVDkoWFYtNo9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013251;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=9+W+GTTjsm60DmjjEWMDh32m0sii/cvxReGskHFcZ0E=;
	b=pVav/PeJ43HxQQqi7Rlfz4Ebak5VRUoIbdXWR7hwk7itGiKdaVR3Dl8wRatRzfUXlozz
	 agUgWJRlFxduNqF6g4UnoQ/sydj8/1sg1NlYtiTyQoDAr9N9XF87brWyI1xLePGOkZf25
	 s4rvpL3AjU5gQtWB17W20lCWrNmTN3rGdLu8tN7g6+62N0UDtKIz/yiHKwFNK7o4S86h6
	 BtTtmJPjUfXooDgkJBlGqKOu+RnrSwQTsPkQ4xUmdhdxMPrY9bwRtZYV9VnI+L976moCC
	 iGl9ImCpjB/NHVsxglqsZaMKh2lInJ2sIZHl3qpbLK764XRf/6Q9iYe+SSwuyYh1TNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="TKewQ8i/";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4564606A337;
	Wed, 18 Nov 2026 14:47:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4564606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TKewQ8i/
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQh3A1196361;
	Wed, 18 Nov 2026 14:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9+W+GTTjsm60DmjjE
	WMDh32m0sii/cvxReGskHFcZ0E=; b=TKewQ8i/xQEkqqoiNnZUHKrDp4XzqNaD7
	3RaYcqCOLc39LyFOm5PZZEw5V6mRxwvxb0FtuI/nQPAgEyI5pBxkRNVI7/xhoIQ6
	qBlyQDv2LWHdzah1sFmHOnK7iICAmiKV4VxelM5QIVrxFBx+YnYPNWtna+SdDKgp
	v40wacd0pmntMBqQ3p/LHHQKjbqs1y2xJ+urLK/sN93Jmmsb7gHuuSzLUL+aQWRd
	TY0EtYytxJNz/E40vZEdrN8mOv6g1Fpakssk7UoHYR/Fmqec0/0o0bBbCue0wzqA
	l0F2XzuvFEoNQNUnqckYCqTBUJKoKJ5QEbyeoRLzs9MgvJWEZzJVQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wtuxd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDnqGJ1380830;
	Wed, 18 Nov 2026 14:47:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvjd1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 14:47:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AIElBmY34341244
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 14:47:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35E4B20040;
	Wed, 18 Nov 2026 14:47:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D6E92004B;
	Wed, 18 Nov 2026 14:47:11 +0000 (GMT)
Received: from osiris.ehn-de.ibm.com (unknown [9.68.31.201])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 14:47:11 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 5/8] s390/mm: Add error handling to arch_setup_zero_pages()
Date: Wed, 18 Nov 2026 15:47:06 +0100
Message-ID: <20261118144709.202520-6-hca@linux.ibm.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118144709.202520-1-hca@linux.ibm.com>
References: <20261118144709.202520-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7pinSIPrgFHM2q5nNihSYbfO-A5T1YY5
X-Proofpoint-GUID: 7pinSIPrgFHM2q5nNihSYbfO-A5T1YY5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfXxMnPNX0+97Ix
 OgCZ17tvGuZBD4xjlM9xcubdRQCccalUln8UITLAYaaVhDvz+eVPWNfz1PQDX8k0ebHnCjiX3un
 6bNTyK47/eVDhTZ09FTJDFxT2ej6ZrUNrSq8q9irJKioSM+vvSkmyT852KKCnDthjPEmyHz89Pg
 239ml5Mj5OrrvjZj02+OOtDtCwRyW4GnbzEvSZEdcDA1TgMOO2NILttufKvRCCHeRzl2tvmeeah
 kKOegZDmpddwFCGoRwZOus34foVLtuQUPIiSzxzhYRSBX1Hkri3cbxZ5mRt/3XxmRED2iDGrbwT
 dajoqjZb3jcsHYNYQQxnuHJQPWKYn29Z2a25NoWwAioQbU3nKViFGDxU3nl+3aCOVJnBHmzx6Ud
 +AMhymqKFi4G0QHw8HzVbxis+9MuDDyleK30/G900YjCUX4avYgLQ9xMaOln8ZlxeeZj7gdeqfS
 kWmSp9C2b2x1gXUL0RA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA1NyBTYWx0ZWRfX2Fgyb/6fiKNZ
 T+gV4r3oUzV1e23rL+AafM3ZC8RempY8BOfCmiYeJ+QySSxYBsRivPkrUYsDk7QghAGhq0g+vZK
 X5l5DCtvc69FNVnwggzgFqf4PkkxPQs=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afdba73 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=snAV7dwMZjPuKDNIHeMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180057

If set_memory_ro() fails early in arch_setup_zero_pages() just
panic. This should never happen.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index be7e009e7b59..4d5a13b19dca 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -74,6 +74,7 @@ void __init arch_setup_zero_pages(void)
 {
 	unsigned long total_pages = memblock_estimated_nr_free_pages();
 	unsigned int order;
+	int rc;
 
 	/* Latest machines require a mapping granularity of 512KB */
 	order = 7;
@@ -86,7 +87,9 @@ void __init arch_setup_zero_pages(void)
 
 	zero_page_mask = ((PAGE_SIZE << order) - 1) & PAGE_MASK;
 
-	set_memory_ro(empty_zero_page, 1UL << order);
+	rc = set_memory_ro(empty_zero_page, 1UL << order);
+	if (rc)
+		panic("%s() failed, err = %d\n", __func__, rc);
 }
 
 void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
-- 
2.56.1

