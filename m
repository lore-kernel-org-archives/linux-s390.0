Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF734F93C3;
	Fri, 18 Sep 2026 13:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738359; cv=none; b=qIiJrFjWvssV4s8njrrFZO2Z1cjVbQMRzIT4r0VLcgBhQ/28MHD9/oq3eXfCp/BATPwjlNdTMDhINlPwvCbpOoib2z7CZI1lYfyUDOme6ho3Qijq5j7msmRsY/7E48MjtvcZPqeKbg2wZ/CSO0SGpFMLu7tJxxD8+UbX32+WFYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738359; c=relaxed/simple;
	bh=6EgD8i3CE3AtETIenE0D3zpVwvhqFf6EDMOChlJQZc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MgwR/PtH3O7+ZdohEd2wEyy5tnfdOOnzN+eUtJaXp/rRvbO2VE9xPp9M2hZLu2DzXKVqjQ6PLMe20av6sl6+/gJ2PCwoGJmuekCd6ID8B3KBrmsZZ392n6kb32eiQDVzMjHmauWFpTjW14YJjJR0h/xbfYZP0po1YoxZUyiDxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pTtu5a+E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pTtu5a+E"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1WPA3979066;
	Fri, 18 Sep 2026 13:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pbtqYrAN3W2LzyED5
	w10DT4NqSRcgG+1DLfffCPvG38=; b=pTtu5a+EuRUpHunQ0MQiOpzM4O9igk22g
	GD8ZcBvXI0ks5VuFa0jjaAqYRDuzbhhnq40KMTQuBZmLfeXtQlUZClD1EE9q31V2
	+VKWFjzgqsJvQnfC69bdbeiDqS7rMs14BOcHLxys4B31JkrQmFX+9NsQFHUpT1BX
	oUZRusofjSpnv+F6/VhALZdlT3DtDHKu64o6ngXw0Qi/adcIcmWpVC4mx79bqUdJ
	faYhbIOpQffpfFz5ApSjx1oVtEhn7htuOUw/vlIzPFYffGwT63/G7uXd/nMcoepa
	9A6rFRZnAJWNwH1qKC5qjz1bxgrguxbRXpoOhPb1z1fNTG2SBfBLw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5eftsh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDO9In771962;
	Fri, 18 Sep 2026 13:31:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr5fffhcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDVBG746072142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:31:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15EC020040;
	Fri, 18 Sep 2026 13:31:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3AE92004B;
	Fri, 18 Sep 2026 13:31:10 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 13:31:10 +0000 (GMT)
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
Subject: [PATCH v8 08/29] KVM: Move architecture capability Kconfigs to header defines
Date: Fri, 18 Sep 2026 15:30:45 +0200
Message-ID: <20260918133107.1042730-9-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX+L0b5IMlrCHL
 g51jzBPnMW/yQz5uHgeO1+bxpBneAhZ22CkbDl7QL2HBo4n6BVOhjXksaJ6yB3RddRrRoJMbDA3
 QnzeWFGqx0AuFMq4Y7KT9AzDz0SyZ3nTRfOrmzX/aAeYIKJ2k9yYED98dFvKoS6kLZc6SQuc7Og
 +14AvvEXMEcwNy8hxdmWJ+VVWKmLE4JC05mocjyw4wQfTewxHd5HXPyUdiBKYqJHd2gwIG6WWEO
 r9Xb/BrHpyryeRI51+Cyp5R4240doqt7F+L2f0ob53YDzNW8hZsl56XrGZbnFBuvWRUSJnhiVV6
 SoNEAp6+rSAV/9hW/OgY3W1n+o64ofETlPQF7La/0hSZQ0MZf44fDoCNpZy9aql1lircOtkE1Qi
 dHBRlKEpfM/ztL8R32GRugRgsMbrW6l2tT3SegQrx5efTXVTb2PIKi0oY3aS1tK2xCe2qaNYp/K
 V/2BnwAIiNCkh2ORQXg==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aad3d2a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Zed0xjmiq0EMZ3KVzcgA:9
 a=4VlVeAog_cEay8Ou:21
X-Proofpoint-ORIG-GUID: 6xrBa-2ANJ8qif2L6cstpVccskYDFVO6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE4NCBTYWx0ZWRfX4suYAxM5NcwU
 uTxx1zkNizqWCqthQqjTA+VDvGIFbJk5FjC1rzqbVLlWjtxwSxnBdQ94+Ns6w7HtDIkc7EsceUe
 VIyU5ZZCO5mSZwY6jlgRQhXErsEom/M=
X-Proofpoint-GUID: HQOMIqY6q82Dfi2VG72T0w3t9R0HebQM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180184

Historically, KVM feature opt-ins and callbacks (e.g. read-only memory,
MSI routing, generic pre-fault memory, lockless aging, halt-polling
controls, and vcpu run PID changes) were configured globally via Kconfig
symbols (CONFIG_HAVE_KVM_* and CONFIG_KVM_*).

With s390 hosting multiple independent KVM implementations within the
same kernel build (native s390 KVM and arm64 on s390), global Kconfig
selections force both implementations to inherit options that only apply
to one of them. For instance, selecting KVM_GENERIC_PRE_FAULT_MEMORY for
native s390 would force arm64 on s390 to provide unused dummy stubs.

Replace these global Kconfig options with architecture-specific opt-in
defines in <asm/kvm_host.h> and standardize their naming by dropping the
HAVE_ prefix:
  - KVM_GENERIC_PRE_FAULT_MEMORY
  - KVM_INVALID_WAKEUPS
  - KVM_MSI               (formerly HAVE_KVM_MSI)
  - KVM_NO_POLL           (formerly HAVE_KVM_NO_POLL)
  - KVM_READONLY_MEM      (formerly HAVE_KVM_READONLY_MEM)
  - KVM_VCPU_RUN_PID_CHANGE (formerly HAVE_KVM_VCPU_RUN_PID_CHANGE)

This allows each architecture and guest implementation to configure its
supported capabilities independently in its kvm_host header and eliminates
unnecessary fallback stubs across different KVM targets.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/arm64/include/asm/kvm_host.h     |  3 +++
 arch/arm64/kvm/Kconfig                |  3 ---
 arch/loongarch/include/asm/kvm_host.h |  2 ++
 arch/loongarch/kvm/Kconfig            |  2 --
 arch/mips/include/asm/kvm_host.h      |  1 +
 arch/mips/kvm/Kconfig                 |  1 -
 arch/powerpc/include/asm/kvm_host.h   |  3 +++
 arch/powerpc/kvm/Kconfig              |  1 -
 arch/riscv/include/asm/kvm_host.h     |  2 ++
 arch/riscv/kvm/Kconfig                |  2 --
 arch/s390/include/asm/kvm_host_s390.h |  4 ++++
 arch/s390/kvm/Kconfig                 |  3 ---
 arch/x86/include/asm/kvm_host.h       |  4 ++++
 arch/x86/kvm/Kconfig                  |  4 ----
 include/linux/kvm_host.h              | 20 ++++++++++++--------
 virt/kvm/Kconfig                      | 20 +-------------------
 virt/kvm/kvm_main.c                   |  8 ++++----
 17 files changed, 36 insertions(+), 47 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 27fe0cd5b2d7..9c314d0568b1 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -30,6 +30,9 @@
 #include <asm/vncr_mapping.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
+#define KVM_MSI
+#define KVM_READONLY_MEM
+#define KVM_VCPU_RUN_PID_CHANGE
 
 #define KVM_HALT_POLL_NS_DEFAULT 500000
 
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 449154f9a485..7329124deb2f 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -28,12 +28,9 @@ menuconfig KVM
 	select KVM_VFIO
 	select HAVE_KVM_DIRTY_RING_ACQ_REL
 	select NEED_KVM_DIRTY_RING_WITH_BITMAP
-	select HAVE_KVM_MSI
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_IRQ_BYPASS
-	select HAVE_KVM_READONLY_MEM
-	select HAVE_KVM_VCPU_RUN_PID_CHANGE
 	select SCHED_INFO
 	select GUEST_PERF_EVENTS if PERF_EVENTS
 	select KVM_GUEST_MEMFD
diff --git a/arch/loongarch/include/asm/kvm_host.h b/arch/loongarch/include/asm/kvm_host.h
index 65d91c3ce313..4cb370a8d09b 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -26,6 +26,8 @@
 #include <asm/loongarch.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
+#define KVM_MSI
+#define KVM_READONLY_MEM
 
 /* Loongarch KVM register ids */
 #define KVM_GET_IOC_CSR_IDX(id)		((id & KVM_CSR_IDX_MASK) >> LOONGARCH_REG_SHIFT)
diff --git a/arch/loongarch/kvm/Kconfig b/arch/loongarch/kvm/Kconfig
index 15da2d88c0c1..a427429a2b05 100644
--- a/arch/loongarch/kvm/Kconfig
+++ b/arch/loongarch/kvm/Kconfig
@@ -23,8 +23,6 @@ config KVM
 	select HAVE_KVM_DIRTY_RING_ACQ_REL
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_IRQCHIP
-	select HAVE_KVM_MSI
-	select HAVE_KVM_READONLY_MEM
 	select KVM_COMMON
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_GENERIC_HARDWARE_ENABLING
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index c14b10821817..8e484bb482ba 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -893,5 +893,6 @@ static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 
 #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS
+#define KVM_READONLY_MEM
 
 #endif /* __MIPS_KVM_HOST_H__ */
diff --git a/arch/mips/kvm/Kconfig b/arch/mips/kvm/Kconfig
index b1b9a1d67758..c24b872afbcb 100644
--- a/arch/mips/kvm/Kconfig
+++ b/arch/mips/kvm/Kconfig
@@ -24,7 +24,6 @@ config KVM
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_MMIO
 	select KVM_GENERIC_HARDWARE_ENABLING
-	select HAVE_KVM_READONLY_MEM
 	help
 	  Support for hosting Guest kernels.
 
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 2d139c807577..ad7c34e9b227 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -49,6 +49,9 @@
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
+#ifdef CONFIG_KVM_MPIC
+#define KVM_MSI
+#endif
 
 #define KVM_HALT_POLL_NS_DEFAULT 10000	/* 10 us */
 
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index b6bc2fc86dca..1fae2de8fa68 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -232,7 +232,6 @@ config KVM_MPIC
 	depends on KVM && PPC_E500
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQ_ROUTING
-	select HAVE_KVM_MSI
 	help
 	  Enable support for emulating MPIC devices inside the
 	  host kernel, rather than relying on userspace to emulate.
diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
index a30600579231..23b5560e97ba 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -47,6 +47,8 @@
 #define KVM_REQ_STEAL_UPDATE		KVM_ARCH_REQ(6)
 
 #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
+#define KVM_MSI
+#define KVM_READONLY_MEM
 
 #define KVM_HAVE_MMU_RWLOCK
 
diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
index ec2cee0a39e0..3cb4f8037300 100644
--- a/arch/riscv/kvm/Kconfig
+++ b/arch/riscv/kvm/Kconfig
@@ -22,8 +22,6 @@ config KVM
 	depends on RISCV_SBI && MMU
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQ_ROUTING
-	select HAVE_KVM_MSI
-	select HAVE_KVM_READONLY_MEM
 	select HAVE_KVM_DIRTY_RING_ACQ_REL
 	select KVM_COMMON
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
diff --git a/arch/s390/include/asm/kvm_host_s390.h b/arch/s390/include/asm/kvm_host_s390.h
index 8a7eed5847e1..5fd7f49d7c0d 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -34,6 +34,10 @@
 
 #define KVM_INTERNAL_MEM_SLOTS 1
 
+#define KVM_GENERIC_PRE_FAULT_MEMORY
+#define KVM_INVALID_WAKEUPS
+#define KVM_NO_POLL
+
 #define KVM_S390_MANAGES_S390_GUEST 1
 
 /*
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 8d3ee17a1bcb..a6ff2e5aa19b 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -25,12 +25,9 @@ config KVM
 	select KVM_COMMON
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQ_ROUTING
-	select HAVE_KVM_INVALID_WAKEUPS
-	select HAVE_KVM_NO_POLL
 	select KVM_VFIO
 	select VIRT_XFER_TO_GUEST_WORK
 	select KVM_MMU_LOCKLESS_AGING
-	select KVM_GENERIC_PRE_FAULT_MEMORY
 	help
 	  Support hosting paravirtualized guest machines using the SIE
 	  virtualization capability on the mainframe. This should work
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e460073ff176..cfe22832a4df 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -47,6 +47,10 @@
 #define kvm_file_to_kvm_arch x86
 
 #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
+#define KVM_GENERIC_PRE_FAULT_MEMORY
+#define KVM_MSI
+#define KVM_NO_POLL
+#define KVM_READONLY_MEM
 
 /*
  * CONFIG_KVM_MAX_NR_VCPUS is defined iff CONFIG_KVM!=n, provide a dummy max if
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 538ed1e80332..fa20f64d6a2f 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -28,7 +28,6 @@ config KVM_X86
 	select HAVE_KVM_DIRTY_RING_ACQ_REL
 	select HAVE_KVM_IRQ_BYPASS
 	select HAVE_KVM_IRQ_ROUTING
-	select HAVE_KVM_READONLY_MEM
 	select VHOST_TASK
 	select KVM_ASYNC_PF
 	select USER_RETURN_NOTIFIER
@@ -37,15 +36,12 @@ config KVM_X86
 	select PERF_EVENTS
 	select GUEST_PERF_EVENTS
 	select PERF_GUEST_MEDIATED_PMU
-	select HAVE_KVM_MSI
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
-	select HAVE_KVM_NO_POLL
 	select VIRT_XFER_TO_GUEST_WORK
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_VFIO
 	select HAVE_KVM_PM_NOTIFIER if PM
 	select KVM_GENERIC_HARDWARE_ENABLING
-	select KVM_GENERIC_PRE_FAULT_MEMORY
 	select KVM_WERROR if WERROR
 	select KVM_GUEST_MEMFD if X86_64
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5926478563e8..b7bd20fc9e34 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -749,7 +749,11 @@ static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
 #ifndef kvm_arch_has_readonly_mem
 static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)
 {
-	return IS_ENABLED(CONFIG_HAVE_KVM_READONLY_MEM);
+#ifdef KVM_READONLY_MEM
+	return true;
+#else
+	return false;
+#endif
 }
 #endif
 
@@ -2481,7 +2485,7 @@ void kvm_arch_update_irqfd_routing(struct kvm_kernel_irqfd *irqfd,
 				   struct kvm_kernel_irq_routing_entry *new);
 #endif /* CONFIG_HAVE_KVM_IRQ_BYPASS */
 
-#ifdef CONFIG_HAVE_KVM_INVALID_WAKEUPS
+#ifdef KVM_INVALID_WAKEUPS
 /* If we wakeup during the poll time, was it a sucessful poll? */
 static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
 {
@@ -2493,9 +2497,9 @@ static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
 {
 	return true;
 }
-#endif /* CONFIG_HAVE_KVM_INVALID_WAKEUPS */
+#endif /* KVM_INVALID_WAKEUPS */
 
-#ifdef CONFIG_HAVE_KVM_NO_POLL
+#ifdef KVM_NO_POLL
 /* Callback that tells if we must not poll */
 bool kvm_arch_no_poll(struct kvm_vcpu *vcpu);
 #else
@@ -2503,18 +2507,18 @@ static inline bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
 {
 	return false;
 }
-#endif /* CONFIG_HAVE_KVM_NO_POLL */
+#endif /* KVM_NO_POLL */
 
 void kvm_arch_guest_memory_reclaimed(struct kvm *kvm);
 
-#ifdef CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE
+#ifdef KVM_VCPU_RUN_PID_CHANGE
 int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu);
 #else
 static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 {
 	return 0;
 }
-#endif /* CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE */
+#endif /* KVM_VCPU_RUN_PID_CHANGE */
 
 #ifdef CONFIG_VIRT_XFER_TO_GUEST_WORK
 static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
@@ -2663,7 +2667,7 @@ void kvm_arch_gmem_reclaim(kvm_pfn_t pfn, kvm_pfn_t nr_pages);
 void kvm_arch_gmem_invalidate_range(struct kvm *kvm, struct kvm_gfn_range *range);
 #endif
 
-#ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
+#ifdef KVM_GENERIC_PRE_FAULT_MEMORY
 long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 				    struct kvm_pre_fault_memory *range);
 #endif
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index c3c0ee253fc7..008b110ebdb7 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -9,7 +9,7 @@ config KVM_COMMON
        select PREEMPT_NOTIFIERS
 
 config HAVE_KVM_PFNCACHE
-       bool
+       booCONFIG_ltt
 
 config HAVE_KVM_IRQCHIP
        bool
@@ -50,27 +50,15 @@ config KVM_ASYNC_PF
 config KVM_ASYNC_PF_SYNC
        bool
 
-config HAVE_KVM_MSI
-       bool
-
-config HAVE_KVM_READONLY_MEM
-       bool
-
 config HAVE_KVM_CPU_RELAX_INTERCEPT
        bool
 
 config KVM_VFIO
        bool
 
-config HAVE_KVM_INVALID_WAKEUPS
-       bool
-
 config KVM_GENERIC_DIRTYLOG_READ_PROTECT
        bool
 
-config KVM_GENERIC_PRE_FAULT_MEMORY
-       bool
-
 config KVM_COMPAT
        def_bool y
        depends on KVM && COMPAT && !(S390 || ARM64 || RISCV)
@@ -79,12 +67,6 @@ config HAVE_KVM_IRQ_BYPASS
        tristate
        select IRQ_BYPASS_MANAGER
 
-config HAVE_KVM_VCPU_RUN_PID_CHANGE
-       bool
-
-config HAVE_KVM_NO_POLL
-       bool
-
 config VIRT_XFER_TO_GUEST_WORK
        bool
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4f25e170b542..a7ce1f22b3de 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4351,7 +4351,7 @@ static int kvm_vcpu_ioctl_get_stats_fd(struct kvm_vcpu *vcpu)
 	return fd;
 }
 
-#ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
+#ifdef KVM_GENERIC_PRE_FAULT_MEMORY
 static int kvm_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
 				     struct kvm_pre_fault_memory *range)
 {
@@ -4650,7 +4650,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = kvm_vcpu_ioctl_get_stats_fd(vcpu);
 		break;
 	}
-#ifdef CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY
+#ifdef KVM_GENERIC_PRE_FAULT_MEMORY
 	case KVM_PRE_FAULT_MEMORY: {
 		struct kvm_pre_fault_memory range;
 
@@ -4891,7 +4891,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
 	case KVM_CAP_JOIN_MEMORY_REGIONS_WORKS:
 	case KVM_CAP_INTERNAL_ERROR_DATA:
-#ifdef CONFIG_HAVE_KVM_MSI
+#ifdef KVM_MSI
 	case KVM_CAP_SIGNAL_MSI:
 #endif
 #ifdef CONFIG_HAVE_KVM_IRQCHIP
@@ -5281,7 +5281,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_ioeventfd(kvm, &data);
 		break;
 	}
-#ifdef CONFIG_HAVE_KVM_MSI
+#ifdef KVM_MSI
 	case KVM_SIGNAL_MSI: {
 		struct kvm_msi msi;
 
-- 
2.53.0

