Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D6D39CCE6;
	Tue,  4 Aug 2026 12:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785845212; cv=none; b=SQ8WLE4KJl9Khl4imFO6/Ov0BYLR0b6GLar4+/6rv/YjMgsvRmGMBmAhxTeJUKxp3a6OsPkYFvOs+cP/KpsFmBknRvptsiObelExGpORlmXTsKUNIdpl2rQmPig+8kDxNwxWk9SYwrqdCdFoLuf/4XLQqyvXzK30zYsB3cd9E9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785845212; c=relaxed/simple;
	bh=xl3vHG+cLqCBEvV+7SCVREzMMvOf38P9Ynw84+w7n2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEHQ4rUmg/I7H3lzruOeutBw5DBF5HvXN5X6Hk3NvvTfSPiJI4nTEGO5i6nfUz8W5M8GebN6CG6Pc4XWu4KRuRUu851l91W03JPiGQOI+E9UzOXL9f7sNTMNgg7z/fWILvM0H0S1eMnnn2xk2/NK6c8eRhZHUwSHCZdfaVyHzVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GAtlY4B5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GAtlY4B5"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6748HYOF295950;
	Tue, 4 Aug 2026 12:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bCs5zaovYzZ8UBIt9
	SQI1Hy194BwqW/Ko3GqXOVaRrk=; b=GAtlY4B5xizf/ZvHWq/CGmyoDRnBG8CG0
	N2ja/ij3c454hbLf7BVVDxPrR3ikwJZ2QZ6SuKITiSsddBEhyYMmh8i+7VH/89vc
	3yToZlOmb7Y89EDQsdzpT3GXt6xGRqAHOT2w0fwbLad1pBoqUJbGYzGpWa4nsGP+
	oKhB40ro3H2kWD9MySx70tgVLVElMnkpsO8J31jttkkIAu9hrztlrdlLx7Y0hWXJ
	RDyieqgm3BfCgccaX9m8JVgjM0UhM3w3oP/QO+0GDjCEyDKs1OytmnNrEQSGf7A8
	We4Ii/UjdU+YJZIJpUNxTHf4UtjQzJgOzfvhosrUlatAfQBJTQyEA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3wpj0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 12:06:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674BuO7r028088;
	Tue, 4 Aug 2026 12:06:41 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qhyjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 12:06:41 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674C6ecb29557364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 12:06:40 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61FDD58051;
	Tue,  4 Aug 2026 12:06:40 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BA685805A;
	Tue,  4 Aug 2026 12:06:38 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 12:06:38 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: KVM <kvm@vger.kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH 2/3] KVM: s390: zero initialize irq for inject_pfault_token
Date: Tue,  4 Aug 2026 14:06:30 +0200
Message-ID: <20260804120631.736919-3-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804120631.736919-1-borntraeger@linux.ibm.com>
References: <20260804120631.736919-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a71d5d2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Q_Ct-ZrBiiAWXo638_EA:9
X-Proofpoint-ORIG-GUID: rAXo96FyUZOn1xqhfORAA8i9Zu_8IROV
X-Proofpoint-GUID: rAXo96FyUZOn1xqhfORAA8i9Zu_8IROV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfX+PClx7DJXlbo
 sZLtXdYt0rHw5MhBcclyypDvJ1Igx7rZ7MsZXqgHDq57OfZxKD9fUiTzX+rfTJ1KcOpflRNtdA+
 ipcxosdfJbo0Ul+DKLI9qgxygJzwFvU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA5NCBTYWx0ZWRfXxwb8Y7YeWQOK
 KcO4m5s2nu1+X3/DPjG31kGlqC+f/0YZsQ6BjgyrqhsC4n/2qS6utmkB7y9JqqB9wAW/mivw7hi
 p+U4a1OwwRBD/QE0EeM/encFmP3XquDYqjs6Z3yavstyaCpnjsLMTknCNrzHxCKgFAaS6Uo4eYC
 gxbJrLMgfX5yt/X/ZowNRgE2JoOiXpWpHfXNEPHdZCLvUQN+WG+hPIPc9K4Pr1DvFQlRG8co6GP
 gXZnW0h3XpvnrEk1fB5NBiRHGa3Gf0JYT7pUVELz2zh1igD3T8NH4VeohFEKvQPKIkMjOZz5f99
 3uP26yFevXmYtac546qNzE7MGI3xOTYJLgYwrGQmE3lMdOqul3ANTm/iGn4sHJhvZfc1vqeLSzN
 Q7rNLms0JeO3uko+83m7gUmnuTlfanUOhW58dgZV2RXQMd7nE6Lv1oNLH4UbBF4c/+Q/4UtxDLk
 CN/HOx8xuXakPkPW3nQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_02,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040094

__kvm_inject_pfault_token() only sets .type and .u.ext.ext_params2 of
the on-stack struct kvm_s390_irq but the full ext substructure is copied
into the cpu local variable on inject. ext_params and pad contain stale
stack values.

Interrupt delivery only uses ext_params2, so nothing leaks, but a host
user can use the migration ioctls to get to the data.

Fix by zero-initializing the irq struct.

Fixes: 383d0b050106 ("KVM: s390: handle pending local interrupts via bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4a38de3d6758..447e6a61f886 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -4474,7 +4474,7 @@ static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
 				     unsigned long token)
 {
 	struct kvm_s390_interrupt inti;
-	struct kvm_s390_irq irq;
+	struct kvm_s390_irq irq = {};
 	struct kvm_s390_interrupt_info *inti_mem = NULL;
 	int ret = 0;
 
-- 
2.53.0

