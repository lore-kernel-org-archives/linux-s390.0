Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCE84F7970;
	Tue, 13 Oct 2026 12:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791893668; cv=none; b=hzItQFoL9kNdrJaQzkPpT6+hintINRYgAohEkeGMaZ7bD74x/8CPuXLU8DiR0xGFtnoJnQwDZLtApGucR+9NDv4SVUlvEbv1qdUGaZdIMwMUJpTP8q4iVICZHBF7xgJDPslcsOeYEun3WGOrUh9Xy5aD80rq8BQSwowLvmwtKNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791893668; c=relaxed/simple;
	bh=cZ4gkNCXIea2yzFLNkymPOUwaS3JarTJyXSSC9orllQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D88qbiNwo+q+dJ7sS2VQYoBiQy8CKJ5R4IKKvyFxysLi58kyoMCIcPaGOtoncdTY0t5J779wUnAzEYuit/RcELu69eFxD65hJzWMI2Sdg17pMv6oxLJrk1hQlxTf6loXDL05gaB8JM8DFYMo9cislqMhHxnoUJjvnKtMcxFPOCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jSz3vTvK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jSz3vTvK"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2Exo42017848;
	Tue, 13 Oct 2026 12:14:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ykohq2hyalPteRG/N
	SqfLGIk6uqasw0mmp7z8Gfbo/0=; b=jSz3vTvKhDmemqSfR0HPsHw6oGdc5JLYv
	f9kZnPFbPNNQPc41eSSA2ILWTm1EEDVZlnBCmFM1E8WZVf0WjHkwV71tPgy+zF/n
	2HjZiq+dhMCIzb5Idt4SSez0bPLuRtJiB0+z/6nXQYLjj3lksHCYBCLODqgCBlPV
	ltZQ6dMFq9BMjLthFc+0lXooww8HyYYgFzmLgkWs2MMKSuoG6cyWW8wsItltHKkj
	goE6nRr0pHeJsoelnO30vzOwtfKbPmJcpAesN0FXs6HI0rUCRGdPrdLRnDY6vnlY
	y1Wo4q615cX6G98PA3ljFvd77eIaGVjG2Zn9qDL7a+U5ov7Gvdnvw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dugdvvm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 12:13:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8UQ7F1440163;
	Tue, 13 Oct 2026 12:13:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wg1gh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 12:13:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DCDoof25821798
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 12:13:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCB5B20049;
	Tue, 13 Oct 2026 12:13:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E13620040;
	Tue, 13 Oct 2026 12:13:50 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 12:13:50 +0000 (GMT)
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
        Oliver Upton <oupton@kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Steffen Eiden <seiden@linux.ibm.com>
Subject: [PATCH v10 02/24] KVM: Move architecture capability Kconfigs to header defines
Date: Tue, 13 Oct 2026 14:13:43 +0200
Message-ID: <20261013121343.1997112-1-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173441.66762-3-seiden@linux.ibm.com>
References: <20260930173441.66762-3-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6ace2087 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=43XmKtFRw13_1s8YYrEA:9
 a=nhjZEc3S35jqr8fL:21
X-Proofpoint-GUID: i7FZQ7lHiXk1GjyUNtS4cT9-cAL2Anpm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0OCBTYWx0ZWRfX+TOPaCHhLH7D
 HvLwr3SBGW3iNMmUi03WkBOE6IRY2iDL2Br+XoKyfaiLi8MS6+ufv7dVUhRCsOIXFYkicKEN5Ko
 6779ntLWLjxuSiDHe9Lom8SEevvGZSZALBuR+50jcd0VUJ9RxGH8U9uA/IcaWgQ/ouvO8sduGIV
 /MxaM6L5F1EkK59+ZH/PevnkGRRcJhbXCvRF12MIhWIyz7ikkUUBPZYHHon1UrOTbBNZhEZgEwv
 SbD4ze+diLPBTRvbSMRTcln1dB20prg5t1tqnXxLTOsivT6zV8r5w9BAPR3/3s5VSadkyprsi/H
 K8lnUQ3GdHVJa9W0kjvv5Lejam5z4EqhGH1rmnnqkKgXebUze6cOA7ybIyxCE1i/xmhgGdZwYMG
 Izc/cS2j7Of8lHcIwt5IN+mWGOaOEKsFmFOevinokkT719GjvYSoXCNtbQgoq+7Uf/9ogt+fJO1
 Ndvn3bFKTOz2/Cm1+ew==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0OCBTYWx0ZWRfX3/tAgNiwbArE
 5Lp8hMl99DiYlHEx+UJWSNfxZElFp4EWYdB1aLIrHDxfMoL7KpbrW6lsT1JFn2NxOdB+h9usEkX
 vWWwUZ3iq+kIk9awtJBwIzNgeouy72A=
X-Proofpoint-ORIG-GUID: mPdSjF0Fcw7oeYIR0q2wdEHqSYMZgt-s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130048

With s390 hosting multiple independent KVM implementations within the
same kernel build (native s390 KVM and arm64 on s390), global Kconfig
selections force both implementations to inherit options that only apply
to one of them.

Replace global Kconfig options which only apply to one KVM
implementation with architecture-specific opt-in defines in the
respective <asm/kvm_host.h>. Only remove Kconfig symbols that would be
different on both s390 KVM implementations

  - __KVM_HAVE_INVALID_WAKEUPS		(formerly HAVE_KVM_INVALID_WAKEUPS)
  - __KVM_HAVE_MSI			(formerly HAVE_KVM_MSI)
  - __KVM_HAVE_NO_POLL			(formerly HAVE_KVM_NO_POLL)
  - __KVM_HAVE_READONLY_MEM		(formerly HAVE_KVM_READONLY_MEM)
  - __KVM_HAVE_VCPU_RUN_PID_CHANGE	(formerly HAVE_KVM_VCPU_RUN_PID_CHANGE)

This allows each architecture and guest implementation to configure its
supported capabilities independently in its kvm_host header and eliminates
adding unnecessary fallback stubs across different KVM targets.

Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---

Sending this patch alone. All others are OK or already picked.

Changes for v10:
  - Use __KVM_HAVE_ as prefix
  - Clarify that this patch touches only selected Kconfig options and
    not all.

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
 arch/s390/include/asm/kvm_host_s390.h |  3 +++
 arch/s390/kvm/Kconfig                 |  2 --
 arch/x86/include/asm/kvm_host.h       |  3 +++
 arch/x86/kvm/Kconfig                  |  3 ---
 include/linux/kvm_host.h              | 18 +++++++++++-------
 virt/kvm/Kconfig                      | 15 ---------------
 virt/kvm/kvm_main.c                   |  4 ++--
 17 files changed, 30 insertions(+), 38 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 1c6632216e32..5c9843338c51 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -32,6 +32,9 @@
 #include <asm/vncr_mapping.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
+#define __KVM_HAVE_MSI
+#define __KVM_HAVE_READONLY_MEM
+#define __KVM_HAVE_VCPU_RUN_PID_CHANGE
 
 #define KVM_HALT_POLL_NS_DEFAULT 500000
 
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 71233068b7cb..df8e4003f76c 100644
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
index 65d91c3ce313..79d3ce7ad029 100644
--- a/arch/loongarch/include/asm/kvm_host.h
+++ b/arch/loongarch/include/asm/kvm_host.h
@@ -26,6 +26,8 @@
 #include <asm/loongarch.h>
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
+#define __KVM_HAVE_MSI
+#define __KVM_HAVE_READONLY_MEM
 
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
index c14b10821817..d481275f38eb 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -893,5 +893,6 @@ static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
 
 #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS
+#define __KVM_HAVE_READONLY_MEM
 
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
index 2d139c807577..d8ef70c14aad 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -49,6 +49,9 @@
 #endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
 
 #define __KVM_HAVE_ARCH_INTC_INITIALIZED
+#ifdef CONFIG_KVM_MPIC
+#define __KVM_HAVE_MSI
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
index a30600579231..e28f058a94d7 100644
--- a/arch/riscv/include/asm/kvm_host.h
+++ b/arch/riscv/include/asm/kvm_host.h
@@ -47,6 +47,8 @@
 #define KVM_REQ_STEAL_UPDATE		KVM_ARCH_REQ(6)
 
 #define __KVM_HAVE_ARCH_FLUSH_REMOTE_TLBS_RANGE
+#define __KVM_HAVE_MSI
+#define __KVM_HAVE_READONLY_MEM
 
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
index 9519b8028b10..a00353ba0343 100644
--- a/arch/s390/include/asm/kvm_host_s390.h
+++ b/arch/s390/include/asm/kvm_host_s390.h
@@ -34,6 +34,9 @@
 
 #define KVM_INTERNAL_MEM_SLOTS 1
 
+#define __KVM_HAVE_INVALID_WAKEUPS
+#define __KVM_HAVE_NO_POLL
+
 #define KVM_S390_MANAGES_S390_GUEST 1
 
 /*
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 8d3ee17a1bcb..9045ae20fd89 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -25,8 +25,6 @@ config KVM
 	select KVM_COMMON
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQ_ROUTING
-	select HAVE_KVM_INVALID_WAKEUPS
-	select HAVE_KVM_NO_POLL
 	select KVM_VFIO
 	select VIRT_XFER_TO_GUEST_WORK
 	select KVM_MMU_LOCKLESS_AGING
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e460073ff176..9baafeff1f25 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -47,6 +47,9 @@
 #define kvm_file_to_kvm_arch x86
 
 #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
+#define __KVM_HAVE_MSI
+#define __KVM_HAVE_NO_POLL
+#define __KVM_HAVE_READONLY_MEM
 
 /*
  * CONFIG_KVM_MAX_NR_VCPUS is defined iff CONFIG_KVM!=n, provide a dummy max if
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 538ed1e80332..294684b217bb 100644
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
@@ -37,9 +36,7 @@ config KVM_X86
 	select PERF_EVENTS
 	select GUEST_PERF_EVENTS
 	select PERF_GUEST_MEDIATED_PMU
-	select HAVE_KVM_MSI
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
-	select HAVE_KVM_NO_POLL
 	select VIRT_XFER_TO_GUEST_WORK
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
 	select KVM_VFIO
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e3035fa1bb53..8f01c2bd9feb 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -750,7 +750,11 @@ static inline u64 kvm_gmem_get_supported_flags(struct kvm *kvm)
 #ifndef kvm_arch_has_readonly_mem
 static inline bool kvm_arch_has_readonly_mem(struct kvm *kvm)
 {
-	return IS_ENABLED(CONFIG_HAVE_KVM_READONLY_MEM);
+#ifdef __KVM_HAVE_READONLY_MEM
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
+#ifdef __KVM_HAVE_INVALID_WAKEUPS
 /* If we wakeup during the poll time, was it a sucessful poll? */
 static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
 {
@@ -2493,9 +2497,9 @@ static inline bool vcpu_valid_wakeup(struct kvm_vcpu *vcpu)
 {
 	return true;
 }
-#endif /* CONFIG_HAVE_KVM_INVALID_WAKEUPS */
+#endif /* __KVM_HAVE_INVALID_WAKEUPS */
 
-#ifdef CONFIG_HAVE_KVM_NO_POLL
+#ifdef __KVM_HAVE_NO_POLL
 /* Callback that tells if we must not poll */
 bool kvm_arch_no_poll(struct kvm_vcpu *vcpu);
 #else
@@ -2503,18 +2507,18 @@ static inline bool kvm_arch_no_poll(struct kvm_vcpu *vcpu)
 {
 	return false;
 }
-#endif /* CONFIG_HAVE_KVM_NO_POLL */
+#endif /* __KVM_HAVE_NO_POLL */
 
 void kvm_arch_guest_memory_reclaimed(struct kvm *kvm);
 
-#ifdef CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE
+#ifdef __KVM_HAVE_VCPU_RUN_PID_CHANGE
 int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu);
 #else
 static inline int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vcpu)
 {
 	return 0;
 }
-#endif /* CONFIG_HAVE_KVM_VCPU_RUN_PID_CHANGE */
+#endif /* __KVM_HAVE_VCPU_RUN_PID_CHANGE */
 
 #ifdef CONFIG_VIRT_XFER_TO_GUEST_WORK
 static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index c3c0ee253fc7..f3d7f66746c8 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -50,21 +50,12 @@ config KVM_ASYNC_PF
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
 
@@ -79,12 +70,6 @@ config HAVE_KVM_IRQ_BYPASS
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
index 35880a2c68a4..22627c06a5fa 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4901,7 +4901,7 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 	case KVM_CAP_DESTROY_MEMORY_REGION_WORKS:
 	case KVM_CAP_JOIN_MEMORY_REGIONS_WORKS:
 	case KVM_CAP_INTERNAL_ERROR_DATA:
-#ifdef CONFIG_HAVE_KVM_MSI
+#ifdef __KVM_HAVE_MSI
 	case KVM_CAP_SIGNAL_MSI:
 #endif
 #ifdef CONFIG_HAVE_KVM_IRQCHIP
@@ -5291,7 +5291,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		r = kvm_ioeventfd(kvm, &data);
 		break;
 	}
-#ifdef CONFIG_HAVE_KVM_MSI
+#ifdef __KVM_HAVE_MSI
 	case KVM_SIGNAL_MSI: {
 		struct kvm_msi msi;
 
-- 
2.53.0

