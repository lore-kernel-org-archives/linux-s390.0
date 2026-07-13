Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF32B31DD97;
	Mon, 13 Jul 2026 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955356; cv=none; b=ol8xPP2Np+uhFfGNUZLy+XpWXx/sDI6oMms8Tjp6HZFAZTJUu8PYQusN8NvZhHDXCwp2HYueMKI1TjnK5UjTkRZmvBv4g/ha0/K63HSsomNuYrrO+3/i2QB02J80MTkTUNpMEfMTwrOtpTIqkBg4c0nKQPtuUb2+aySEc/ssPbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955356; c=relaxed/simple;
	bh=Gug3m8waKqQj52Ng15611qHVWQsQtQju401Skbo31D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PAPNuZ1h9/VvjBe0c8rilx4BsBltKKeRVFpFyICRv651yfNhOC+pfaWoBGgrZC2LWaM3dxyN4OgOJY1ha3ZkuJMdweAFOEZyTqoLXEMN5wmkHHQ45XzdJlxhiEeMCfZ1pTonhkwfIaShO6OhcFhl/76OAPHhw3ch59sy8LHgZlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ebD7aLLJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ebD7aLLJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCCuT82436841;
	Mon, 13 Jul 2026 15:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hD1xZusRyHJmtNOzB
	MOg3BMaby2xmXZl29BH2/XbpEs=; b=ebD7aLLJRwj6orJYBzZbg0BZlyDcJwayT
	fqygD9Ib0R1iENBlGjp4dd6C6bQ0cZEwZR3u/ajKG2KgKVJRpNb8lPxH2EE3GbuI
	GfEPb/YOwxus57wqdv4Fd4xGH0+cbb3TFvlYC/iLiRMdCfWIaFg72DiY8TBoDVdp
	0NNpfikb819vSMHMyacxswv1vBD+c0bkHbxodf0oxLUQHdAxa6P1KJ3qPtz1jHqw
	ZaehgdVW1Qh/impPRVCO26T3WBfpH08KPJ2bAsYBokZWOgVidVQloVjStyhdcnUV
	e+b/DFDtO+TWpUxuW/X9biiJg0OW3PJ3A8/GuwEkgMW23SjoPZMNQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepx9ahh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DF4dmK010986;
	Mon, 13 Jul 2026 15:09:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jp81u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 15:09:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DF95RO49152472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 15:09:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FEB320040;
	Mon, 13 Jul 2026 15:09:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F64B20043;
	Mon, 13 Jul 2026 15:09:04 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.87.153.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 15:09:04 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 7/7] KVM: s390: Return -EINTR if a signal was pending while faulting-in
Date: Mon, 13 Jul 2026 17:08:57 +0200
Message-ID: <20260713150857.269954-8-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713150857.269954-1-imbrenda@linux.ibm.com>
References: <20260713150857.269954-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OLU_nqu0Nhm26139JSoWQE8gxpWuH_3k
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfX6cISORcI76T8
 W4Ir8ahb51rOSH6qwzBJsLazOBDlNyIuD4XkOUACiFSUJPQ0283a9J/ReKTlBvU+jxurH4Fn0+l
 +yXg8nh/9bgvXXjWcXbu0kwDHDhQU5Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDE1MyBTYWx0ZWRfXw3mRlRvOdXm6
 rGAHjg9WZAAwEBk7mfZi3DtRfAbfeDCY8et9HFJq/yiB05S5mT4CUfmVmfeiZ7+q3XQ1VOmsKP5
 hSbiL3rHiXPKtjnt0PDzJ4T83OvnhhZSmHvhk4D7Wf9EkEtYhkIjwQ0AzcNqQAKVdkNykMpEEdA
 +i6FL90AqdlwEcNvxX3EK1cttXn7+vLDY1VGN1Fer0Jv6o8OU2FdszjaKu4apCrcHedD9fGuy7e
 5DIGvzflVxK3WX1f8mkQYRpxFcFFkZYKjlB8Jwfct+dL4ugofWYXzvAtPZHWfNaSNhZktz4y3hR
 qNDqANHKuC0cccfC3zjp7jG65Fm0AOxSL77OeoggfU7co4xuXR8yx01XZv5R0RzEWwSIC08xbo2
 ajcjkIpTINwO1PJbGc8kgWXEW0iigoOoypZssWSMweUHh816yH8ej+K+EqheVAmNn8YFrPTLop8
 RzlmgnYqGy9WQxN/0gQ==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a54ff98 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Rpd2EocR8erB28K5S3gA:9
X-Proofpoint-ORIG-GUID: OLU_nqu0Nhm26139JSoWQE8gxpWuH_3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130153

If a signal is pending while trying to fault-in a page, return -EINTR
instead of -EAGAIN.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
---
 arch/s390/kvm/faultin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
index fee80047bd94..235b9c66ce54 100644
--- a/arch/s390/kvm/faultin.c
+++ b/arch/s390/kvm/faultin.c
@@ -93,7 +93,7 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
 			return PGM_ADDRESSING;
 		/* Signal pending: try again. */
 		if (f->pfn == KVM_PFN_ERR_SIGPENDING)
-			return -EAGAIN;
+			return -EINTR;
 		/* Check if it's read-only memory; don't try to actually handle that case. */
 		if (f->pfn == KVM_PFN_ERR_RO_FAULT)
 			return -EOPNOTSUPP;
-- 
2.55.0

