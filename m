Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3463722318;
	Wed, 23 Oct 2024 06:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666593; cv=none; b=bLzs0wxsObVdUipm/+TQiG4vgdsjmWI9rYz8M2peImG8VIEYOE5wNiyoP+Zdl1I9n7You+Ds/mN2DQss+KdSQ97Y3Fk6/DR2UVFxXzoUbXDHlQ4J69hCrr1ulXqMuXkd6JyfdkhXFCC4h4YfEZxgJEgUu6PuICsW0KOK+nvRI2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666593; c=relaxed/simple;
	bh=kVOdspsOldUc4zTQdMJx5v8MGcrl0GH9GsIPrPwpC28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IYrCOJRx1mM65k9nfjajyrgf30dOwMUbxGChSAKmlnr2pLjroMhSov8R6sQjyU0bHPsHrckPXU5XksrLTBa8FJFJ+SY44o9Z03yfxqVGTrtS2/3TGQksPRUoC7Abk/gnTmxvZmyJ/Hn1pF1WCG7EK42rba1Ro7Ok75waOqzJ2Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cCtLrSJV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cCtLrSJV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N0NPEB027512;
	Wed, 23 Oct 2024 06:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+TzTKw2qZOwYpEgGG
	4xDr85w8C+eDr8IhBo8hoBHBHM=; b=cCtLrSJVL1iWpv5NudTTl7ILymu9LMZHt
	afZFYb6IN8WJBUJDgWg1yqysHTPjwwaxtKthdnzyAsI48GPhNe45oKAGKhhDzK/d
	SjvVHNfkahysNGzc9CcGsUIhFJr8Pa3n4dt3kjEYo33u+HAdl6CdWU/l1sIGPb4E
	pAeQ4ZiNjzqARuHVMPfsiVwtQm5b8Ue/I1/BHvgl6TG0jqATDAOS/L9YdKjc5pED
	42V1pUkss5tp76ByhxW5brk8J/6PY1UbVW5rSz6mPc8u08m6TsPj9HV0e5n5f9M7
	iM+E5AneVWVTEfJniEL61Jx/rE5NzdfM//jxMhCaPyo6CsKAxkRGg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafhpqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:56:22 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49N6uMsM001366;
	Wed, 23 Oct 2024 06:56:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emafhpqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:56:21 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49N2kewh014308;
	Wed, 23 Oct 2024 06:56:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42emhfhmcg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:56:20 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49N6uGQP56426980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 06:56:16 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B14462004D;
	Wed, 23 Oct 2024 06:56:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F1972004B;
	Wed, 23 Oct 2024 06:56:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 23 Oct 2024 06:56:16 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 42CF4E0545; Wed, 23 Oct 2024 08:56:16 +0200 (CEST)
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
Subject: [PATCH net-next v4 1/2] s390/time: Add clocksource id to TOD clock
Date: Wed, 23 Oct 2024 08:56:00 +0200
Message-ID: <20241023065601.449586-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241023065601.449586-1-svens@linux.ibm.com>
References: <20241023065601.449586-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Dqb4RJfrnLYEHIoaA0Tj9zsvSSE4bumx
X-Proofpoint-GUID: rxuVeU4qL0ExvmQZ6IsWa6UlS6AoLbIA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230041

To allow specifying the clock source in the upcoming PtP driver,
add a clocksource ID to the s390 TOD clock.

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
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
2.45.2

