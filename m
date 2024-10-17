Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F3176FCE;
	Thu, 17 Oct 2024 06:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729145297; cv=none; b=iQQg5ShrhVCEg+zOGBqXAMD4wCTfFzu0OFVZ6zL6/lVnUScIDkfdQKs1BMYW0CuEVaGWNvBhbrG0z00GtzZ4fIhqjMPkn0oFOSOgF2P1qTfOuzAsUOrUFwoLJOVW/gxOSu9yjerWKdqfdWLg0agJ1VNhaxCZG+lcFwkdSxO5GAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729145297; c=relaxed/simple;
	bh=iguEBDl8q+O3eYgeqHRt+q0bauQl/22Of+lo5GWS9OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ct+7n2dWQalq/ZD9DL21Csp85m3Wkd0taxmj7kyH6+uLjLYBatFHE/giM4ajiFYY2xkCDGg9I23CoMqIxPSKq3uQ/BfS8R4/0RBEH5F92lgUa8wXiOaV01F744ZT5kDcLeVnqXBbdw+wDYIn2msJgyL8T94MCWSrhix9JQdvCJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rSMPtfVH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rSMPtfVH"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H1tS4x028269;
	Thu, 17 Oct 2024 06:08:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E+k3UV0GeMDRIFZTg
	pu8BxXs0tZH4a0UJwOSzoCuvas=; b=rSMPtfVHTsSXMOB0B0+YJEIC27z5TXS9G
	/+YG0MTHT5HI+igKPYgdoK0+AEdt53ru0vwnfEU3lwfmatxXNIEdEHowQIfB+IUp
	L+OdKg3JHtZpC/HAOmRZoxYSDj9pKdXKBSEcuxhmF9+jPWynPkMeWDXSkfpFmX7n
	55t4tu3lIGQpYr7bnErKx61+Tgdj7KTmsv6mqBDEhAYeQMvSYNnK3ry6NGYMQ+WK
	de4UCwxHXiC/ftbJbKPKQA6sydEw/9G2J7Qgr3SOH28h2THBwAHOq4ShTiyPoVbo
	OCeEQYD9LDc2tBnZC7Vr2u3I2ftuQRHwTpB/n5Ya4BYCEiL4oYO5A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42asbd0t3m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 06:08:03 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49H67tbI030821;
	Thu, 17 Oct 2024 06:08:03 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42asbd0t3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 06:08:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49H2PShJ005965;
	Thu, 17 Oct 2024 06:08:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4286514tgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 06:08:02 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49H67wPP34538078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 06:07:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5DB62004D;
	Thu, 17 Oct 2024 06:07:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B51612004B;
	Thu, 17 Oct 2024 06:07:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 17 Oct 2024 06:07:58 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 2CB18E00F4; Thu, 17 Oct 2024 08:07:58 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH v3 1/2] s390/time: Add clocksource id to TOD clock
Date: Thu, 17 Oct 2024 08:07:48 +0200
Message-ID: <20241017060749.3893793-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241017060749.3893793-1-svens@linux.ibm.com>
References: <20241017060749.3893793-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uuu7BIsiqu7raj3CcTDlbug7jnr7wUu8
X-Proofpoint-GUID: lmDNaYw7azHNB2eP3hc3AJtu5ty6tUjk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170039

To allow specifying the clock source in the upcoming PtP driver,
add a clocksource ID to the s390 TOD clock.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/kernel/time.c         | 1 +
 include/linux/clocksource_ids.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index b713effe0579..4214901c3ab0 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -255,6 +255,7 @@ static struct clocksource clocksource_tod = {
 	.shift		= 24,
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 	.vdso_clock_mode = VDSO_CLOCKMODE_TOD,
+	.id		= CSID_S390_TOD,
 };
 
 struct clocksource * __init clocksource_default_clock(void)
diff --git a/include/linux/clocksource_ids.h b/include/linux/clocksource_ids.h
index 2bb4d8c2f1b0..c4ef4ae2eded 100644
--- a/include/linux/clocksource_ids.h
+++ b/include/linux/clocksource_ids.h
@@ -6,6 +6,7 @@
 enum clocksource_ids {
 	CSID_GENERIC		= 0,
 	CSID_ARM_ARCH_COUNTER,
+	CSID_S390_TOD,
 	CSID_X86_TSC_EARLY,
 	CSID_X86_TSC,
 	CSID_X86_KVM_CLK,
-- 
2.43.0

