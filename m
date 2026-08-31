Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E737FF6D;
	Mon, 31 Aug 2026 14:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788187725; cv=none; b=Oc8gQe98OrHjqlTZlxX5I/kRB4aomm08RcezF37dKj/n/nirUfjLemTGVglWNqAjYDD91zjz94iznqivO5bh95Gc2WXm+gpucy8mzflt/bLWHD6rtUP3ZSlUhwJXh0iANAXbqgLZ0mmVHvAcvLJNpn4sCHrXBtgtPHcS4+iP2sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788187725; c=relaxed/simple;
	bh=UxkgQ1zM3tPtDn3b1aBgHZD2AgschunhvctLf5/mPKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSInKHT17vapeBUJ//lpz/wRRKvfhmBpPlbc9WpwGWyMvj4wO/mXb7gxcEC9A3cNkuckeIEI0+3IMNjUF4sdOQIuO0QguiqtVvThlMHE4xjuGhAYk7IdDXB72gHtPazxgTfFf3F4LXpIT/r6Dbx7Sme0d1dFrBXgNryOjkaqbKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VHdyAIT7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VHdyAIT7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ7Vr2530423;
	Mon, 31 Aug 2026 14:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=49n4XnmGFcb3P+ATI
	hXMoae7qqVIE2kvV302o4Yk0Gg=; b=VHdyAIT7tG32sbU9qUzTjV/J0k3bP4R+y
	/wD29v0C7pjlrApnBvQ9PZzythv/xWwNz6Ukb4dC5GLBPCW5hejWZGsaQqJ8drNM
	572/Rq4do904U+Px/FUfcZpTUyuwsKc/MYPJ4uW5rdtL5VW8hbiNhkltQ10VrIyZ
	Ln/xY5X/LdIqCRbzfDhmcl+9N9qFg3uyMkNqu3bLFvm/Sefym6eZ/l/AmjWeZzb0
	lEipC+5MYJat7RwjqQ4HImeqMErS68WxgkNkNbZseEvoglao3X4cEDl1PFlnLzhe
	30tQSe7rb+TFWn5YK7PEdlBZlAk99jzYIatHI8D5iNodQ0Xu84leA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx5a0d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEfeMM000476;
	Mon, 31 Aug 2026 14:48:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg695a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 14:48:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VEmDMu45613376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 14:48:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFFCE20043;
	Mon, 31 Aug 2026 14:48:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 464722004B;
	Mon, 31 Aug 2026 14:48:13 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 14:48:13 +0000 (GMT)
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
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH v7 23/23] KVM: s390: arm64: Add KVM_S390_ARM64 Kconfig and Makefile
Date: Mon, 31 Aug 2026 16:48:00 +0200
Message-ID: <20260831144802.834315-24-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831144802.834315-1-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a959433 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=5Rhiwhz_oZ9PaowiqMUA:9
X-Proofpoint-GUID: lOlaZ4-tD4Bxv3pInqZ6mfUupYyIQgFw
X-Proofpoint-ORIG-GUID: Qi8dhpCXkXbrts8L_m_E550eTj86X_Lh
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfX1uG84JCZ+Y+6
 QGE+TIeWtot0HNBXvUqHr339W/1Dvq/pJGhFIM7tLMM69cytpB8Ybm/SE/PaqDo4JOIyC81LC2O
 Z603Bl80S5+v7G7fjr9LZD2QDyfEAo0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEyNSBTYWx0ZWRfXws/WG1rgzMgs
 GOBOO+ntubP3JMwQ0VwYDXwj76UvvQoG12mU9HwDOSFLXcJmoPS5XKkUsT+lSSLlGt4iJwY1foH
 ds0+NF2JCYiCYPtrZx4Z6nZ5AkLry/vctxWuuw1F9ICvxhgeciRDqVkXpy+s9SVUBBmQFAR4v5q
 rcle+pBQeb0YnszDsfrnfFuo5Q2cdGvRkPESQzhA+BL6xDSpogofhZqW/2SkCGClnsUBuLPK2ES
 zYsxrB7/es9+Mvu6ylbnM+sok5YrxDTHmQ35R/eN1scdWdywUkW6ikhR1G0mFwQ6JsYmYredhjI
 RAXQaTuywt+slTuYNhol8K+A+TnGdZOBzgVAM4/jp3PUVZ3htbUn0Nth87l0UX6YpJsVRYXW+xQ
 pB/4j++na9RV42+BaroVZRpg9z/Fe9vkSETV2eyflBf+YShjHl7+kIRrmI8vdj0sHeXofSJIA6e
 MA5WRguUS05PkQoT3Tg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310125

Add all Kbuild/Makefile configurations to build a second KVM module on
s390 implementing the arm64-KVM API. To prevent symbol conflicts with
kvm-s390 all internal symbols in kvm-arm64 are mangled if compiled as
built-in. The new module ins named kvm-arm64.

As in this case the build does not go through the normal build process
the module parameter handling would be messed up. By forcing
KBUILD_MODNAME to kvm-arm64 all parameters are at the same location and
not at object/basename of the object file where the parameter is
introduced.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Gautam Gala <ggala@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/configs/debug_defconfig |  1 +
 arch/s390/configs/defconfig       |  1 +
 arch/s390/include/asm/Kbuild      |  3 +
 arch/s390/kvm/Kconfig             | 29 ++++++++++
 arch/s390/kvm/Makefile            |  1 +
 arch/s390/kvm/arm64/Makefile      | 91 +++++++++++++++++++++++++++++++
 6 files changed, 126 insertions(+)
 create mode 100644 arch/s390/kvm/arm64/Makefile

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 3dae71474333..ed9a38e763cd 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -66,6 +66,7 @@ CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_S390_HYPFS_FS=y
 CONFIG_KVM=m
+CONFIG_KVM_S390_ARM64=m
 CONFIG_KVM_S390_UCONTROL=y
 CONFIG_S390_UNWIND_SELFTEST=m
 CONFIG_S390_KPROBES_SANITY_TEST=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 6f5722634b4d..92d3c6442b0c 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -64,6 +64,7 @@ CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_S390_HYPFS_FS=y
 CONFIG_KVM=m
+CONFIG_KVM_S390_ARM64=m
 CONFIG_S390_UNWIND_SELFTEST=m
 CONFIG_S390_KPROBES_SANITY_TEST=m
 CONFIG_S390_MODULES_SANITY_TEST=m
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 0c1fc47c3ba0..40a81419e353 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -8,3 +8,6 @@ generic-y += asm-offsets.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
 generic-y += ring_buffer.h
+
+generated-y += sysreg-defs.h
+generated-y += kvm_arm64_modname.h
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 8d3ee17a1bcb..9c69ea16031e 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -53,4 +53,33 @@ config KVM_S390_UCONTROL
 
 	  If unsure, say N.
 
+config KVM_S390_ARM64
+	def_tristate y
+	prompt "KVM support for hardware accelerated arm64 guests"
+	depends on HAS_IOMEM
+	depends on KVM
+	select GUEST_PERF_EVENTS if PERF_EVENTS
+	select HAVE_KVM_CPU_RELAX_INTERCEPT
+	select HAVE_KVM_IRQCHIP
+	select HAVE_KVM_VCPU_RUN_PID_CHANGE
+	select IRQ_BYPASS_MANAGER
+	select KVM_COMMON
+	select KVM_MMIO
+	select KVM_VFIO
+	select SCHED_INFO
+	select XARRAY_MULTI
+	help
+	  Enable support for hosting virtualized, hardware-accelerated arm64
+	  virtual machines on s390 systems using the Start ARM Execution (SAE)
+	  instruction. This requires hardware models that support the Arm
+	  execution facility (AEF).
+
+	  The module provides a character device named /dev/kvm-arm64 to expose
+	  the hardware capabilities.
+
+	  To compile this driver as a module, choose M here. The module will
+	  be called kvm-arm64.
+
+	  If unsure, say N.
+
 endif # VIRTUALIZATION
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index a4e3875b5bdd..00fabbdaac80 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -4,3 +4,4 @@
 # Copyright IBM Corp. 2008
 
 obj-$(CONFIG_KVM) += s390/
+obj-$(CONFIG_KVM_S390_ARM64) += arm64/
diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
new file mode 100644
index 000000000000..ae614a62f7b5
--- /dev/null
+++ b/arch/s390/kvm/arm64/Makefile
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0
+
+KVM := ../../../../virt/kvm
+include $(srctree)/virt/kvm/Makefile.kvm
+include $(srctree)/arch/s390/kvm/gmap/Makefile
+include $(src)/Makefile.gen
+
+ccflags-y += -I $(src) -I $(objtree)/$(obj) -I$(srctree)/arch/s390/kvm/gmap -DKVM_S390_ARM64
+
+kvm-arm64-obj := \
+	arm.o \
+	guest.o \
+	handle_exit.o \
+	inject_fault.o \
+	mmio.o \
+	mmu.o \
+	reset.o \
+
+kvm-arm64-obj += $(patsubst %.o,%-arm64.o,$(kvm-y))
+kvm-arm64-obj += $(patsubst %.o,%-arm64.o,$(gmap-y))
+
+targets += $(kvm-arm64-obj)
+
+$(obj)/%-arm64.o: $(src)/%.c FORCE
+	@mkdir -p $(dir $@)
+	$(call if_changed_rule,cc_o_c)
+
+ifeq ($(CONFIG_KVM_S390_ARM64),m)
+
+kvm-arm64-y = $(kvm-arm64-obj)
+
+else ifeq ($(CONFIG_KVM_S390_ARM64),y)
+
+KVM_ARM64_GEN_DIR := $(objtree)/arch/${SRCARCH}/include/generated/asm
+KVM_ARM64_MODNAME_H := $(KVM_ARM64_GEN_DIR)/kvm_arm64_modname.h
+ccflags-y += -include $(KVM_ARM64_MODNAME_H)
+
+targets += $(KVM_ARM64_MODNAME_H)
+
+quiet_cmd_kvm_arm64_modname_h = GEN     $@
+      cmd_kvm_arm64_modname_h = { \
+	echo '/* Automatically generated; do not edit. */'; \
+	echo '\#ifndef _KVM_ARM64_MODNAME_H'; \
+	echo '\#define _KVM_ARM64_MODNAME_H'; \
+	echo '\#undef KBUILD_MODNAME'; \
+	echo '\#define KBUILD_MODNAME "kvm_arm64"'; \
+	echo '\#endif /* _KVM_ARM64_MODNAME_H */'; \
+	} > $@
+
+$(addprefix $(obj)/,$(kvm-arm64-obj)): $(KVM_ARM64_MODNAME_H)
+
+$(KVM_ARM64_MODNAME_H):
+	@mkdir -p $(KVM_ARM64_GEN_DIR)
+	$(call cmd,kvm_arm64_modname_h)
+
+prereq-o-cmd = $(foreach o, $(filter %.o, $^), $(dir $(o)).$(notdir $(o)).cmd)
+cmd_gen_symversions_o = \
+	grep --no-filename "^\#SYMVER" $(prereq-o-cmd) >> $(dot-target).cmd || true
+
+define rule_ld_o_o
+	$(call cmd_and_savecmd,ld)
+	$(call cmd,gen_symversions_o)
+endef
+
+LDFLAGS_kvm-unnamespaced.o := -r --whole-archive
+$(obj)/kvm-unnamespaced.o: $(addprefix $(obj)/,$(kvm-arm64-obj)) FORCE
+	$(call if_changed_rule,ld_o_o)
+
+quiet_cmd_nm_filter = NMFLTR  $@
+	cmd_nm_filter = $(NM) --defined-only --format=just-symbols $< | sort -u > $@
+
+$(obj)/kvm_symbol_list: $(obj)/kvm-unnamespaced.o FORCE
+	$(call if_changed,nm_filter)
+
+define rule_oc_o_o
+	$(call cmd_and_savecmd,objcopy)
+	$(call cmd,gen_objtooldep)
+	$(call cmd,gen_symversions_o)
+endef
+
+OBJCOPYFLAGS_kvm-namespaced.o := -O $(LD_BFD) --localize-symbols=$(obj)/kvm_symbol_list
+$(obj)/kvm-namespaced.o: $(obj)/kvm-unnamespaced.o $(obj)/kvm_symbol_list FORCE
+	$(call if_changed_rule,oc_o_o)
+
+kvm-arm64-y = kvm-namespaced.o
+
+targets += kvm-unnamespaced.o kvm_symbol_list kvm-namespaced.o
+
+endif
+
+obj-$(CONFIG_KVM_S390_ARM64) += kvm-arm64.o
-- 
2.53.0

