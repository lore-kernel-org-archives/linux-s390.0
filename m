Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F3D334368;
	Wed, 18 Feb 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771424424; cv=none; b=BZU4xuTwoSomDaOmPLCZ6uvQNxZUKPx909Kq4xiRyNDw3ITyznJ3oSI93wpZZPL3lcxSjeixBvCUiDO1BSWyOOQTn7L/0y6XmXVSQBlcIJyfmSD+JjC2TW3wBFrOaHTDu/rsOMifop/CYI7rgxke+pyB4lhNsevchp7jlQdVgYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771424424; c=relaxed/simple;
	bh=pxlImbyIG7z3s+moWkb9YzYfxIqC6b8tWTVhzecud0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnu2coHclTSTMFLxyYprd8kOEWXNay59WoSbyXuNYV8HMnCgYyMSkL1U3W8vF0Y/RIAWITZO+GgjAYIuA+11+40i/2dlnygU9SyXvpua7LRhT4uHoxryGNeOW9+fL2fz3vZTgn7Zup81aqK3qBgT4feQ7RzVybnjTsuFTq/OCfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GcmUJHVq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GcmUJHVq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I1nEVF1674735;
	Wed, 18 Feb 2026 14:20:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JiiQ9+9F3+wHfmwhc
	QzO4Bd3k8oCoI/UAdCTHe4EzUw=; b=GcmUJHVq3Qg6AlYwEmwuvXmpi+ThML82L
	6srwKzGVkAokVkVv5Fo8sry75f2JRnOdXWFgNtai8n7688RoI9TqYWaaLZqWDau9
	1JiV8m9EY/2Da/fcf9etvhLgfU/3hCdDqVSI59jd39mbrAuk4yXvEgH6FqNZGZUE
	T5idhp+d5B4gWwV4lkgCfEBc3bfgsq5p+Q4fpe318sNQ/ZnNFi2PsaVIzo9MVS2f
	07f6/PrMWHmlA14cJBTMDY20aVQIhdfKMMxCfB+OesFBfsq6fOKQQtCcLCRNtXhF
	dMPHzlCTKAJaeminygqbN7PPWnI83GCVXq1URRFAD0i6opeEVHbWQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6s1h1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61ID17L0015721;
	Wed, 18 Feb 2026 14:20:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ccb4583e0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Feb 2026 14:20:18 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61IEKEg115204762
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 14:20:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9352C20040;
	Wed, 18 Feb 2026 14:20:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69B502004B;
	Wed, 18 Feb 2026 14:20:14 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Feb 2026 14:20:14 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Frederic Weisbecker <frederic@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 8/9] s390/vtime: Use lockdep_assert_irqs_disabled() instead of BUG_ON()
Date: Wed, 18 Feb 2026 15:20:11 +0100
Message-ID: <20260218142012.863464-9-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260218142012.863464-1-hca@linux.ibm.com>
References: <20260218142012.863464-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=dvvWylg4 c=1 sm=1 tr=0 ts=6995caa3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=Kc6-FovL7Q0bcOmGwqcA:9
X-Proofpoint-GUID: R_WFhomB0FnOKeopz_wzre5swklkWUdN
X-Proofpoint-ORIG-GUID: R_WFhomB0FnOKeopz_wzre5swklkWUdN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEyMCBTYWx0ZWRfX/ACCg9fG0mcZ
 tmAyu6tM85pEC9VQxdpmIu3s400NjAOsaCvGNEvYQFW9/bUeb6wupgq6hQ3eJ6RKrWk9A2yWwjU
 mH9fbgNrri1zcVrdkI+1Z+GYVXLlGG0BqVH/PdNVKDVBGq4RBuf0xIthDewChD9UZ8hA7cz26rO
 zvddRshSldY3frq709maErVhN1yli8ZgfxJc4U20iAaHrk7xUjbS5xVM1SJpJ+/4KMs3Sj9rRRx
 RGmE1rXrlkpyVU7qHDqmhkx5KPHNfSG2rkLEdRmdQx8xReGVcqZF0C1Xzd1mUylLEEbjru0XsVJ
 Je5N51k+rq8uZTrkj8B+HcxPt7dW8K+fmk/+oSi9haDkM0CIGhdYRhP2ztsJ7gWGHevm+OWazJe
 VkBy6dgijyBKHOW7BioJr54Vk1wrqtkBA4R3sineiBXAHxRtt425uWB/66FuDobxpSmV7NVmCIk
 z+3HgUz/FT08iPIyxog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_02,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602180120

Use lockdep_assert_irqs_disabled() instead of BUG_ON(). This avoids
crashing the kernel, and generates better code if CONFIG_PROVE_LOCKING
is disabled.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/vtime.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index 4111ff4d727c..bf48744d0912 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -48,8 +48,7 @@ static inline void set_vtimer(u64 expires)
 
 static inline int virt_timer_forward(u64 elapsed)
 {
-	BUG_ON(!irqs_disabled());
-
+	lockdep_assert_irqs_disabled();
 	if (list_empty(&virt_timer_list))
 		return 0;
 	elapsed = atomic64_add_return(elapsed, &virt_timer_elapsed);
-- 
2.51.0

