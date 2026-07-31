Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CFD414A1E;
	Fri, 31 Jul 2026 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503376; cv=none; b=Kk9QNyZ5EPM5i+9NbJNeVfg5iob4/xXuIZ1r/HL+IMm1LfO5sSGFHz4AOXfRWpc0ntj3A9xq9XdpRciJjKC/wgdXMnsxLkHi/YwuuOcvaFny+vz1tsRlthB+fQ306+O5DKEqqt5BwVNZU6FkUXojMMXdIfrPoDWeIpzPEFt21tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503376; c=relaxed/simple;
	bh=shf3bWdB62u5SV2u/3gJ0T5lxiAGTldcYcxETPqnncc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ULwAyPAAYE3+wCI9PkD9emZt3WCZ6gP+4G90i5JTQfS8ogKCzNWEZ75alAQX4JZ8almMt2ed1CtDKiRnNLAKt/yS6BjV37CN4zC6USYZmpI08zNm4Jihavfdy8RvYTWti21lJK2ptqXKPRk7cHCnHWdc8bYAQwb2TqkbqJ8A4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g94x0XB8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g94x0XB8"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlwiC1791081;
	Fri, 31 Jul 2026 13:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SM7oNCI4u0y5aJ6mj
	P8ZOQnyJ9ITYGSkXVkpk4AYg/8=; b=g94x0XB8b+zRs4XLQ7qIp0zYqRcmnmgnY
	P0MpHxE98/jBcDdodyZBoqjGnA4qAmkAT0OcPcwai7R77iRf39EMFBH3wHCdiAbh
	aL1t58ojvD3+M7TfZKYyXbTZuyKQCDvKQLSu1DRBK4SYz8UeM8NLa5dxFvWg2lcM
	fiR4/Ja3hfuqoXKDAFZcdeNc9weHdmvAnABehfjwjP0viIgeRiYOV+bIf5IL+of1
	NPQGBVhCMfBALCWUfBCDoBsksFqrGTGmnAYIOSK/T/3AZX9VJeVC2Vbz5iQOoJCT
	TpXXfk+djqvlQoDRdo1ZMclHSPnyJ5W53DwLboUxMl7rBKJ4TCiqg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwdc41m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuN5O012675;
	Fri, 31 Jul 2026 13:09:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkg07r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:12 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD94u447382904
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:04 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91FE82004D;
	Fri, 31 Jul 2026 13:09:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CD4F2004B;
	Fri, 31 Jul 2026 13:09:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:04 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v5 03/31] KVM: Allow KVM implementations to switch off MMIO independent of Kconfig
Date: Fri, 31 Jul 2026 15:08:31 +0200
Message-ID: <20260731130902.654679-4-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731130902.654679-1-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: DFLIu-1q7DRkoGPS0JzL_Dc-7tB-KhNl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX/fv9TXVmQsVY
 yMIkJpvl04L5JK/tNXPT8sUWdUId88Tdp3VQ8h0x9sAnNGAAnplI2zJcM/yYJjRLhtyW7i8HMe3
 2qkCypsgzL0ELCS22I3i1TtkvvuqV6s=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6c9e79 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=-AqJVl6EvvwGbS2dlloA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX/tIFvvQgwy7K
 lFdunpfj13EYbP5Z/6kpYT/MeuWHKHzmBKxIgkT9D2oKo8l/ujCFt9mNybL3dVQUm6Z5lfHrYLV
 XHdyo8F6VkdpyibrL9EZ1r6fk03ummmhNJfd0m1DSIxS7M3clJMJQYLTP32/FysrTHhtsX4aQ6g
 ZzWayUWA2qijtQ3Zf0Qa428YkJtnTNASXNrEmA4ynHzfr4757utNaL+qWtx8az23NF4H0/oAj4n
 WrssHWnKGOWGKLMmdNSsihdEc7TAzo5ZvoAB204rIaD4F1my8QXcmPLmz/lTCgKJPAjsZtl8dno
 QqxVkmifWHA4dF5nU/1Zg1jO6hmP46+nu8krmOlcQYiNRdogOd/ZHnJSouxIHOD2OOMHJf0QyrM
 XKxTslfidqescdupWL1RQ0pyCQnaCxgzlGrCrwB52R/yxJa6kcWmYkTikm375x4fK/iUsNo8JAG
 Qz1h7LD6HK/5gvsmMXQ==
X-Proofpoint-GUID: 2Sxg6PMissB01-jMXtKoSktWy8YNwTQd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

Only defining KVM_MMIO is not flexible enough for multi-KVM systems
where one KVM implements MMIO but others do not. Solve this by
additionally testing for the non-existence of KVM_NO_MMIO before
including MMIO code to KVM.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 virt/kvm/coalesced_mmio.c | 4 ++++
 virt/kvm/coalesced_mmio.h | 2 +-
 virt/kvm/kvm_main.c       | 8 ++++----
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/virt/kvm/coalesced_mmio.c b/virt/kvm/coalesced_mmio.c
index 6b1d90161099..8ff9d9a6f47a 100644
--- a/virt/kvm/coalesced_mmio.c
+++ b/virt/kvm/coalesced_mmio.c
@@ -15,6 +15,8 @@
 #include <linux/slab.h>
 #include <linux/kvm.h>
 
+#ifndef KVM_NO_MMIO
+
 #include "coalesced_mmio.h"
 
 static inline struct kvm_coalesced_mmio_dev *to_mmio(struct kvm_io_device *dev)
@@ -188,3 +190,5 @@ int kvm_vm_ioctl_unregister_coalesced_mmio(struct kvm *kvm,
 	 */
 	return 0;
 }
+
+#endif /* ifndef KVM_NO_MMIO */
diff --git a/virt/kvm/coalesced_mmio.h b/virt/kvm/coalesced_mmio.h
index 36f84264ed25..826af421a5be 100644
--- a/virt/kvm/coalesced_mmio.h
+++ b/virt/kvm/coalesced_mmio.h
@@ -11,7 +11,7 @@
  *
  */
 
-#ifdef CONFIG_KVM_MMIO
+#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
 
 #include <linux/list.h>
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 18eb3d5d04f4..bb3682d8e1f7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4056,7 +4056,7 @@ static vm_fault_t kvm_vcpu_fault(struct vm_fault *vmf)
 	else if (vmf->pgoff == KVM_PIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->arch.pio_data);
 #endif
-#ifdef CONFIG_KVM_MMIO
+#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
 	else if (vmf->pgoff == KVM_COALESCED_MMIO_PAGE_OFFSET)
 		page = virt_to_page(vcpu->kvm->coalesced_mmio_ring);
 #endif
@@ -4882,7 +4882,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_ENABLE_CAP_VM:
 	case KVM_CAP_HALT_POLL:
 		return 1;
-#ifdef CONFIG_KVM_MMIO
+#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
 	case KVM_CAP_COALESCED_MMIO:
 		return KVM_COALESCED_MMIO_PAGE_OFFSET;
 	case KVM_CAP_COALESCED_PIO:
@@ -5223,7 +5223,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		break;
 	}
 #endif
-#ifdef CONFIG_KVM_MMIO
+#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
 	case KVM_REGISTER_COALESCED_MMIO: {
 		struct kvm_coalesced_mmio_zone zone;
 
@@ -5558,7 +5558,7 @@ static long kvm_dev_ioctl(struct file *filp,
 #ifdef CONFIG_X86
 		r += PAGE_SIZE;    /* pio data page */
 #endif
-#ifdef CONFIG_KVM_MMIO
+#if defined(CONFIG_KVM_MMIO) && !defined(KVM_NO_MMIO)
 		r += PAGE_SIZE;    /* coalesced mmio ring page */
 #endif
 		break;
-- 
2.53.0

