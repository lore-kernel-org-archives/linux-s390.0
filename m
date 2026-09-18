Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0858B502D46;
	Fri, 18 Sep 2026 13:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738330; cv=none; b=lp1nHWk3lkBDmCpoi0D5SQSVRTyBnjcjUgeHs/Qit4QUyWyQzViWz07UV8dKC2+cyymKdu5ylXrWdzzD96vvFhSoCsbi3wmAXrYRAEFO5kWyfQAWtGYo7qN2Qr3iXb3bN7VFc4Niw+RDexNa2L04Hq8//bVDTSEn8CZAj06ObG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738330; c=relaxed/simple;
	bh=aoV+5a5Z4iuGJ35qmrd0zOsIb5IvTgcwx1xkzzEjUKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtkKK/pBj/cG8eYhfuGtilzyrS+6lFfw0mg/qh5RT9QhOwsYopTxnX78bcLf1wYJox4bjyQ0l7mKMqvQH0wzXg28QPnuogPtAQ0clA7hNFf2mhGSUgPLTPkl2bdCRh2MIYis+CsD4KKHXu12ERP7LNCItj/sEAKDDtLRkZfXyNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ng7dJ5l0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ng7dJ5l0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVOT61378352;
	Fri, 18 Sep 2026 13:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WCL+CA7pTX69IiknF
	0LM7xJ6P4tgzKbQdTZYtTbfrv8=; b=Ng7dJ5l0KJktT8YucRQbjpsZ7Ya/5ZANe
	zBluefEEky4NgtdfmAMTZJ+66ZLHY48uKTg4TPz4hOp/azjCjsm/1fWnrJwd1wTH
	LRv52FfHOEmG8vlQbe5v1FBuqWHd/+cCZ4ZGu8w815r4zXdTDWv03Ak2d9aMUTHz
	qDREDdNDmEGetkikEF97IStY/dhMxPe+rfisDXPf9H58PKRhUJzazqIDtwK92NuB
	o5Kc+feQyrt0dEuLJY3jUI6FK1/otCZmaw84SnGPEkPFYXR+vJ8W410P5RZzWRjb
	nH/AHIX2vVFGOhHli3WnsuivH3cSahwXZF4o9QxN+ooSUsHLJ+cuQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx848a6w-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNs9f771781;
	Fri, 18 Sep 2026 13:31:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5fffhd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDVIYY51511726
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:31:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D038E20040;
	Fri, 18 Sep 2026 13:31:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 829712004B;
	Fri, 18 Sep 2026 13:31:18 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 13:31:18 +0000 (GMT)
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
Subject: [PATCH v8 29/29] KVM: s390: Enforce no unexpected external symbol exports in s390 KVM
Date: Fri, 18 Sep 2026 15:31:06 +0200
Message-ID: <20260918133107.1042730-30-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918133107.1042730-1-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE5MiBTYWx0ZWRfXy6qgH+KHIi4l
 DepgFH3mLaQBLw17bC4HCSFeciPpdFxhfb6dSsDtaggdjh93h/l0tf4zeD9FRCJqqlmhVLpv72t
 +sT3zeQMLT09IVX10Xb8wVqIwuVifOH4oJajXEEsw5qMexlB9/bb3hmM450II72zEYPDbR/gGUl
 jjQKAlM1bxjyNaYSnAX5NOR4XWLSolKqcRLDOEHNzM68VkBN+/LdvpbDW0cw5CrXY0G3qffTnWP
 whF0kK55LOrp76uqoGd5Pufgx2SRdjQMMw/4AZg4myW39nAS0PUQ87pqdn9ZYmwJMIieYuzX4+a
 h335zQPYPWyXQ0adqXDXURADgDQTm3jXwtVU2FlCwb6Pw25Ny9v0prC/VuTS7YOQLbjyawjjRHd
 ZkFva0/diMdAzwYP+0dcjwAc0WgjhpUstNUmDjXyjeGcZXXWwMXiUV3aOz9lGgzkHwa7YgwW+qZ
 Mxw7rP1hz7EsrQOUXgA==
X-Proofpoint-ORIG-GUID: zvGj3enOp3CadNtbS38DnRKI3uoq46V4
X-Proofpoint-GUID: CK-Htzt2iMw14alug5hpUMBDv9Xuwa9G
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE5MiBTYWx0ZWRfXzwKyHnhxKqz0
 IeRxDXTiVO5ZVklAPLaKFCS0Y9Du1FRKba6zFWKr+ZzbTXXnNHzysHARjwCeSXu7PMuGBSexw/Z
 hOorftFQwkzFgM+7xk48f/wBR+KfLSM=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aad3d2f cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=DPUpadGSCr_GuARIGB0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180192

Add a Makefile check to arch/s390/kvm that fails the build on any
EXPORT_SYMBOL_GPL or EXPORT_SYMBOL not in the allowed list. A symbol
may only use EXPORT_SYMBOL_GPL if it is defined in exactly one of the
two s390 KVM modules (kvm or kvm-arm64). A symbol defined in both
modules could cause a link conflict if built builtin.

While at it remove the unnecessary EXPORT_SYMBOL_GPL from
kvm_s390_pv_is_protected, which has no external callers.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/Makefile       |  1 +
 arch/s390/kvm/arm64/Makefile | 14 ++++++++++++++
 arch/s390/kvm/s390/Makefile  | 16 ++++++++++++++++
 arch/s390/kvm/s390/pv.c      |  1 -
 4 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index 380db443a0e9..0e474335bb78 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -5,3 +5,4 @@
 
 obj-$(CONFIG_KVM) += s390/
 obj-$(CONFIG_KVM) += arm64/
+
diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
index bd78d64939d1..d84d3be74037 100644
--- a/arch/s390/kvm/arm64/Makefile
+++ b/arch/s390/kvm/arm64/Makefile
@@ -3,6 +3,7 @@
 KVM := ../../../../virt/kvm
 KVM_DEV_NAME = kvm_arm64
 KVM_DEV_MINOR = MISC_DYNAMIC_MINOR
+KVM_CHECK_EXPORT_DIRS ?= $(srctree)/virt/kvm $(srctree)/arch/s390/kvm/gmap $(src)
 include $(srctree)/virt/kvm/Makefile.kvm
 include $(srctree)/arch/s390/kvm/gmap/Makefile
 include $(src)/Makefile.gen
@@ -91,3 +92,16 @@ targets += kvm-unnamespaced.o kvm_symbol_list kvm-namespaced.o
 endif
 
 obj-$(CONFIG_KVM) += kvm-arm64.o
+
+# Fail the build if there is unexpected EXPORT_SYMBOL_GPL (or EXPORT_SYMBOL)
+# usage in arm64 KVM code. A symbol may only use EXPORT_SYMBOL_GPL if it is
+# defined in exactly one of the two s390 KVM modules (kvm or kvm_arm64). A
+# symbol defined in both would cause a conflict during linking if builtin is
+# selected. Catch the issue early.
+
+# This "symbol" is not exported by arm on s390 but still in the source code and the
+# export check scans unexpanded source code.
+kvm_exports_allowed := kvm_file_to_kvm_fn
+
+$(eval $(call kvm_check_exports,EXPORT_SYMBOL_GPL))
+$(eval $(call kvm_check_exports,EXPORT_SYMBOL))
diff --git a/arch/s390/kvm/s390/Makefile b/arch/s390/kvm/s390/Makefile
index b91334db90a2..5d6eb45d3037 100644
--- a/arch/s390/kvm/s390/Makefile
+++ b/arch/s390/kvm/s390/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 KVM := ../../../../virt/kvm
+KVM_CHECK_EXPORT_DIRS ?= $(srctree)/virt/kvm $(srctree)/arch/$(ARCH)/kvm/gmap $(src)
 include $(srctree)/virt/kvm/Makefile.kvm
 include $(srctree)/arch/s390/kvm/gmap/Makefile
 
@@ -12,3 +13,18 @@ kvm-y += $(gmap-y)
 
 kvm-$(CONFIG_VFIO_PCI_ZDEV_KVM) += pci.o
 obj-$(CONFIG_KVM) += kvm.o
+
+# Fail the build if there is unexpected EXPORT_SYMBOL_GPL (or EXPORT_SYMBOL)
+# usage in s390 KVM code. A symbol may only use EXPORT_SYMBOL_GPL if it is
+# defined in exactly one of the two s390 KVM modules (kvm or kvm_arm64). A
+# symbol defined in both would cause a conflict during linking if builtin is
+# selected. Catch the issue early.
+kvm_exports_allowed := kvm_s390_pv_cpu_is_protected \
+		       kvm_arch_crypto_set_masks \
+		       kvm_arch_crypto_clear_masks \
+		       kvm_s390_gisc_register \
+		       kvm_s390_gisc_unregister \
+		       kvm_file_to_kvm_fn
+
+$(eval $(call kvm_check_exports,EXPORT_SYMBOL_GPL))
+$(eval $(call kvm_check_exports,EXPORT_SYMBOL))
diff --git a/arch/s390/kvm/s390/pv.c b/arch/s390/kvm/s390/pv.c
index b18abd0e29ef..1fec224e4d2b 100644
--- a/arch/s390/kvm/s390/pv.c
+++ b/arch/s390/kvm/s390/pv.c
@@ -29,7 +29,6 @@ bool kvm_s390_pv_is_protected(struct kvm *kvm)
 	lockdep_assert_held(&kvm->lock);
 	return !!kvm_s390_pv_get_handle(kvm);
 }
-EXPORT_SYMBOL_GPL(kvm_s390_pv_is_protected);
 
 bool kvm_s390_pv_cpu_is_protected(struct kvm_vcpu *vcpu)
 {
-- 
2.53.0

