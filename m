Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D87A3CF03D;
	Fri, 20 Mar 2026 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023350; cv=none; b=lDU8M2ehDW1LBZ/uYttP9SqoBehs9D1s1cbCflm+jHlqexaJu9mlDNecsjpnZp75kXxWCcAenXmQiEcYUL+alsE0YTLQL5hmLBLDL7gCLPQVAsyB6M+o9xNJhEvloE1LsoZjcFw0uIQEBpRNowvo0ImOXgOOrh6i98fA8hvEWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023350; c=relaxed/simple;
	bh=XSuyupCCocHeG1e3uelNBhprn+VVK6y728zX8CfECWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u8w3ods2CreNQ/tMJjwB/9uBP1u5eENgm+o8iNy0RZEQG5YMOCcinQo3yTHEXFZywq7ejponO8eQnKYQHJ5xRevdm0cjoo3tbP6rWCYWzyc/CBbXrlXDjd9Jh+SXZTbdK3XpdTb1KwNCotWAP/037+ir//KcR4s2exdPPpehiIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NQ63O3ob; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NQ63O3ob"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K9TQ721189728;
	Fri, 20 Mar 2026 16:15:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uV7sTapygDfJhmllU
	rkjGxeX11k8rcYx56CScBI5AMk=; b=NQ63O3obH/sC/UPaM1X93uq7AeyrFB4ZV
	FwLcvqy+qV5eGS44OINng795C89KvN6pAxtR1NSP69TZpZYoPYdo1KxsaNnVlcFt
	6ZMvW+ERv9/Lcxu+JPglVLDmm2V2M5ZO8v/dlutsmiWGM9XS49CAUpSrKm1yJ8+N
	8sU263mhqhvS9gYFD9+8wGostIP1lh6Qq3r5dKOocSuhxQWm1dm85RchQKj4q2Qs
	Bu7MJEgFD8TkpgILSFiCgI35CeEBmj73cWD1yOROqbTF9VSVC8vMJA2mVZOBThpN
	JmqB8VcIdWpRhFUQOLdt5FR8w/MepgUZXjwFjI9U1gR/Y7qTPsV8Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfxnme-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62KG5sen005412;
	Fri, 20 Mar 2026 16:15:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sr0d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Mar 2026 16:15:46 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62KGFgbe41288172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Mar 2026 16:15:42 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DCE920040;
	Fri, 20 Mar 2026 16:15:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DF892004B;
	Fri, 20 Mar 2026 16:15:42 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Mar 2026 16:15:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, nrb@linux.ibm.com,
        seiden@linux.ibm.com, gra@linux.ibm.com, schlameuss@linux.ibm.com,
        hca@linux.ibm.com, david@kernel.org
Subject: [PATCH v2 1/8] KVM: s390: vsie: Fix dat_split_ste()
Date: Fri, 20 Mar 2026 17:15:35 +0100
Message-ID: <20260320161542.202913-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260320161542.202913-1-imbrenda@linux.ibm.com>
References: <20260320161542.202913-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 58IB4QlfWZsIO71Jp5LG3Acdo3blWttz
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69bd72b3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=LsQdvuOhCgcXfIND9tsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDEzMCBTYWx0ZWRfXxo4f2gKB9Z1z
 Hl3gU0a8iliwNGdSk4alB/dJfmL89Qq54V0EAadggjMUXfCaTgPBTh6mfiw75/tGvXK8WjMvJKr
 5Yp4zY87eTW5pBVhWEmMnIGqCwkdQs4rC2sRmFla4SqaFpIghWBKtuCFTWh3PCUK6R8UbTxbN2z
 Wq3S2hM4pNL6DelxuX0fDHmg5ipifJ+EgsIeYyWw+njiuvwHYLPvBp0B5qLA0uZm1KQVNZoLukJ
 pyLp7ewxW+24xas5uwzo6ewUa5FuGeO6kcHV1xTOBAimYOOopAr4i0jtLhXbvNH6S+EHVNq+Pyz
 Ur8XCLsyzateZAD7bShS+cLEwsfFh6BYGDmLfe/22WjVIlmzL7UYQR5bbZW+uZXSppJLNrr6PJr
 kj/M7Bm9bHPgVzQV2YLOd4bQ5/1nBnQ/vqms8O2oxBLzgbF8tecZUNQfrj4RKkp9a/wdvpTdiPw
 xOj2VUl8nXiiXiDgbUA==
X-Proofpoint-GUID: 58IB4QlfWZsIO71Jp5LG3Acdo3blWttz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_02,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603200130

If the guest misbehaves and puts the page tables for its nested guest
inside the memory of the nested guest itself, the shadow mapping will
lose synchronization with the actual mapping.

Propagate the vsie_notif bit from shadowed large pages to smaller pages
when splitting a large page.

Fixes: 2db149a0a6c5 ("KVM: s390: KVM page table management functions: walks")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 670404d4fa44..48b5f2bcf172 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -292,6 +292,7 @@ static int dat_split_ste(struct kvm_s390_mmu_cache *mc, union pmd *pmdp, gfn_t g
 				pt->ptes[i].val = init.val | i * PAGE_SIZE;
 			/* No need to take locks as the page table is not installed yet. */
 			pgste_init.prefix_notif = old.s.fc1.prefix_notif;
+			pgste_init.vsie_notif = old.s.fc1.vsie_notif;
 			pgste_init.pcl = uses_skeys && init.h.i;
 			dat_init_pgstes(pt, pgste_init.val);
 		} else {
-- 
2.53.0

