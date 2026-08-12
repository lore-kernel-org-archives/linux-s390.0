Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318633EEAC4;
	Wed, 12 Aug 2026 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786531486; cv=none; b=ZJXJiHHflsSMdyLzbAnIZOK0XNUhkQYXE2HlPhpHdRrkR3AU//e4KGnHWufX2zDVetgWnjykPLGlAd9pRHRZhzfHq4jz/4tJdyI5FJCfqN9RU1MAyZMw/eg1qSrPmqz0V0JthViwj1OmiZsiN9z1XFSPGsHFgKo6Plt6YwHYG1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786531486; c=relaxed/simple;
	bh=DIs17kO5mWZpkFUAL7AAyjKv1jw2FeZ/kbg3M17UxxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SvnrboDzKCmoJ5ZdegznqTWLTTyrQ0MvwmJyhr4ozceYK+3Jaqt/zYFZet8uT+bYIkFbIiZPlezuAYYAduG8+E+GKNXnOul+kld+/kcEE30NhoG2wsyShT2qRajRPWmVT0TiIgpPQzaYyRhdFEhwwBNSdfMlviaiHTt7jmVZhZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=npB/JuvA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="npB/JuvA"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CA1P5B3130304;
	Wed, 12 Aug 2026 10:44:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+8FD+Twa6/xpAxs2n
	YjC9A3ZU8aYyJ/ePbtB/tHuN0o=; b=npB/JuvAnoHiCTjjHLwCqVMPHSHAf3Lda
	nRphxb8o2h8RJvLsmQMbpEtw04E5yb2Yf2Ze/N/ZUJj5Tx1QaWbACuLoo94KtQdI
	Blt66T7I2g02EFlwcR0uKpQ9QmDAW9A7sVkMyR4tA2vi9iMC/K5te/ZJxPxUQNbN
	cRhXInEDtb7aoL+nMFa+HFMJlLWSi2Vm2ZByctiwQ+XQzfohcbJtCzDmnM7QBQMo
	PYs1CpB7a9wmapbcX72msID2hWGpqimlql2Phuc3/vRZRHzodanh2IT9SVnh7h7j
	4rLz+UDxUjD//YXkcsbUXU0aE2YjzGgimzWl5Hp2Q46swffgBm1wA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9hy69-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CAfIJ8025117;
	Wed, 12 Aug 2026 10:44:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h5hxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 10:44:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CAibUg25494190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 10:44:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49BE420043;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A0D02004B;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 10:44:37 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 1/9] KVM: s390: Properly handle NULL pointer in dat_cond_set_storage_key()
Date: Wed, 12 Aug 2026 12:44:28 +0200
Message-ID: <20260812104436.109741-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812104436.109741-1-imbrenda@linux.ibm.com>
References: <20260812104436.109741-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aXwSQ_WH9gigVBIa_yJVr5tyjpSuW_4Z
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7c4e9b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HXcwjgiTS1qyJsQYY4QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX3PwocYy8oT0r
 1Ir0ib83Zphw5LH7+9misZ4wK2+1bJ5/bnuMaYVa5VJbJF36KotQABpO23fGFPJe9iBVPiBs7VK
 999ITnQSqk/NpJAD0ooPovbrInm/fRRLQ/X3yrBnJU/nK6uwVFQgs6xmZw4Kn4EBQUM33PTo8UD
 R4Mqd12PNlBGqPn+g1VXFLEGPxGvz18WVinHBWocDO3two03oq7zUck1Sm9mL2/NNBh3a+YfdCr
 JiiqNnuRArPijR2DyWUShO+/2L4NAabMbBpohVwz8YqpLQBQP/jVe5RfUsMZwEEcMlFyosR32WN
 W0bYpUrNOEGd31/aeX9jdu4yoENw9fOPBtn+EdPpt0I1xg1HEUKG31uiUMBeInW407FFxOMRs82
 HctHp12bzVDK0hrD8h+x+UnpKkk7XetwsJya9Gf+jPNeV/99cAlVh850htyHxzwPyRaeyMUgJnA
 kvt218WA3lXVL1tYFEg==
X-Proofpoint-ORIG-GUID: aXwSQ_WH9gigVBIa_yJVr5tyjpSuW_4Z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA4NCBTYWx0ZWRfX7bjoyciM3d6u
 fhIhMjYEdbyF71EfPHHFTipgiA6cGTCv8OYAdfeHluoqvQUeTd6Qx4DMYw2atRL6kt87/UoOTlz
 R+9ouyugcg+sVcgUyU97JkUyKnVNKc4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120084

Some callers pass NULL as oldkey. Calling page_cond_set_storage_key()
will cause that NULL pointer to get dereferenced.

Fix by checking for NULL and assigning the pointer to a dummy local
variable to avoid crashes.

Fixes: 8e03e8316eb2 ("KVM: s390: KVM page table management functions: storage keys")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 3f2d6e8902d7..165c704fcf29 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -722,9 +722,12 @@ int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce asce, gf
 	if (rc)
 		return rc;
 
-	if (!ptep)
+	if (!ptep) {
+		if (!oldkey)
+			oldkey = &prev;
 		return page_cond_set_storage_key(large_crste_to_phys(*crstep, gfn), skey, oldkey,
 						 nq, mr, mc);
+	}
 
 	old = pgste_get_lock(ptep);
 	pgste = old;
-- 
2.55.0

