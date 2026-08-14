Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C610E3C4B92;
	Fri, 14 Aug 2026 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786725248; cv=none; b=bh315OJbgZB669PUy5U7m1Kfl7R9wgUM4zEpVPlqzR1Joe6t4KZNHPVw4KMq2etLKnyRPAd+WG4v/T+smDPVsZv/Mp8PuQyGBJP9N4tLy2k+Y3RpYLhThN3pkYBRCuAAC69cOOr0uR0JU0ZIq0TnDOi6L82YS0TLh44JleU7UMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786725248; c=relaxed/simple;
	bh=F59Qurcp/kTVoXzlPeyY+3oN0QzaQuxO5xt4EBdXI80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WE9t4o6pxBwkPCa924PJyCsnBs0xbTFAfDvb8pN6AyeriC0LKNG996v7m1k8siWeRx2dydehwXz7+cC6vbI8PgqQfRz67vs7phvL8f9DB52BVHkNPUiwac34+rqurV3/khZmCzhIvXMIyvEvdTMZcqg/Lw1fRAJJMgz+NfwGR2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ru2i6RGJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ru2i6RGJ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5x8T1248784;
	Fri, 14 Aug 2026 16:34:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xilWAbM9y3pPZPJsW
	/U53F9B1V2aBsOTYtlGrg9Kflk=; b=Ru2i6RGJmDVwTp63OxCQP3Bsy3JQ+KBNZ
	ue/WFdJ15XASqA+AzOelnq07xVW3R0/ZAHkhKmzS0FKivTAagUqGSE5kn5Qn9pWc
	Z0wsqRjHfrS42izNv4n7PbVPJkykUTSOPvHt9B/v+EufnvVBkEEUn6azF8hHY4/8
	fJo77J/aiXo9bv0s8XOByNJ6fF1Lb884vdvpyF2qfwIGHzS5fWFv+meXcFegkrt4
	fFcSl6O8ZgfsZRRZR1WxWDdXclJU/egUDagDxDRfw0e8nyZ6eN3iSXtoLovkgIbn
	EpuwW2zxtPUNLw0hOv5w0IUwsxobdI6HacY0NbxHjOuUVE2Gp0j1w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp3chhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 16:34:03 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EGQQu0029403;
	Fri, 14 Aug 2026 16:34:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wg50b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 16:34:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EGXvgt23200364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 16:33:57 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E69A220043;
	Fri, 14 Aug 2026 16:33:56 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B8C6420040;
	Fri, 14 Aug 2026 16:33:56 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 16:33:56 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v2 5/6] KVM: s390: Add missing srcu in kvm_s390_set_irq_state()
Date: Fri, 14 Aug 2026 18:33:54 +0200
Message-ID: <20260814163355.227191-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814163355.227191-1-imbrenda@linux.ibm.com>
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7f437b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=F91muKJsJommOsj9A9kA:9
X-Proofpoint-GUID: L0_K220QkQwFTGAlmDWtlye42E6ryUSa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDEyNiBTYWx0ZWRfXxp7t/fBmTpcI
 NyqjPYAY/iygC6vWxzsZsVjG15C3qVtfojRJ+Qns6XVccKD5lrntomy63BcmgX8ivP97doPTP5p
 HTULlrk4ZR4/6zs4M3ctM2nCrtg1Ns1k0TzzEHmPIYXEa0iv0V6i9uv4mIbuCdzFAhn+QWa0TIW
 RKOLziaCmlkPBWmOsqmmnVxv5ZbVdgzHA+Sp9x96nxRGfX2ut8wRXKBS3iOVN6fmvf0jJIPKHBX
 3igeQf47qWUWhY4TcoaV8O6Pfz9B4QbgpKc+vW1Brv4sQaRZfq/2udtiKyOO0NIFF8HcHXm4gqv
 yGhjoZCKhfJgVqAnYjLEV1LEIaTRvG+uBBaBpKhjTh+3kvPoKPbuvctSrTgJ6a2ihWaDFen9vTl
 ZyEDLQxXM1JS1V1C6DBtGOdttISr4AeEuUZ6ArL6t8lVpM7IUIFwRNK8tNO+sf1d40F5Y+ZuaA/
 JqRcen1RmXt1Kj6fS1w==
X-Proofpoint-ORIG-GUID: L0_K220QkQwFTGAlmDWtlye42E6ryUSa
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDEyNiBTYWx0ZWRfX29gGZyIDCGUZ
 4tR1r8lKH2KIbjshnxz8u2a3ibjMB0EcB9shdowbMtF1Xifsuv2RGDYpyMFyEJNo9y6kHyACTGX
 K/sHjq7H8xKTdlhTS81wXqJtpDa3yIM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140126

Like kvm_s390_inject_vcpu(), kvm_s390_set_irq_state() also needs the
kvm->srcu or the slots lock when performing the Store status operation.

Fix by taking kvm->srcu in kvm_s390_set_irq_state().

Fixes: ba5c1e9b6cee ("KVM: s390: interrupt subsystem, cpu timer, waitpsw")
Fixes: 062e44a9319f ("KVM: s390: Use srcu in kvm_arch_vcpu_unlocked_ioctl()")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index fc4d1f8193d9..8a251f83d323 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -3230,9 +3230,9 @@ int kvm_s390_set_irq_state(struct kvm_vcpu *vcpu, void __user *irqstate, int len
 				break;
 		}
 	}
-
 	if (storestatus) {
-		n = kvm_s390_store_status_unloaded(vcpu, KVM_S390_STORE_STATUS_NOADDR);
+		scoped_guard(srcu, &vcpu->kvm->srcu)
+			n = kvm_s390_store_status_unloaded(vcpu, KVM_S390_STORE_STATUS_NOADDR);
 		return r ? r : n;
 	}
 
-- 
2.55.0

