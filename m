Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8F93F0755;
	Fri, 29 May 2026 15:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780069900; cv=none; b=KUH80VCiCajeG0CegpjIJ9QpPq7kRj532sgbZJ+ZipgDlmRx2KeGVrXCq+S4A9ZFjxVxmyJh5kblpz+awRhIoU5SIzPDSPvHzeGO+c46dboh/ESQjGBz08LLuvbiSjxbjFfpSbt4VDrQAJIXy1F5+KwRcCkqpffCgwavi9Z/jDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780069900; c=relaxed/simple;
	bh=345HmncotsV9pWQLZkzansMv4WWVEa6GK6TZ3rObZf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKHtdAP2bNKL8rUX3rifJW8rAPG2YddAD+GwhPUL8eQzrRlkQrNSt6W/4u6GzUcq26DzZIab9naskkSxTTCGWXSAfm+3BU8y3XHhn9g36R6PPmgg+YdjArfaTyQWsmpnyY0HnR/P4O88j9p0wzZeS0HVvXVlCyjTZZThTH//kzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k3d8vDic; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k3d8vDic"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64TFGVBO2418177;
	Fri, 29 May 2026 15:51:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Cg0ros1wPgTvf6bFu
	zYmLK4U6oANOh/aWRatOLQjbbI=; b=k3d8vDicnGVnkYtHSagOzI8BStNgoM75d
	QdgZilUFgwOayY9otF9XMuaD5FG+TBfh/c9woL68W0bO6m04C0ItzqlWAJNMolzg
	jWo3Slv3LKs2KvImEiNsK3T+bPScmXzh+7p6uLhUoAbS7kwtQWaQ+9A8evp8YPE/
	FDWjkb9CSxktIuRj8IUFApnli6+57LTByqWxrV0zH8hlZpOUxDSeU6/0GEwtoXnJ
	DSe+WQnjBPbiU5AdlPTlOFrmJq0JSMhZ6axf0ETCVuAYRrWF7pKsF3NTcrZUReHz
	vuTPrpJSI01JVIg9IKXoiG6C5xoqrAGIXKbkSEXGfXd58yc61oEWg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee884ve5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64TFd6JC022954;
	Fri, 29 May 2026 15:51:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrc8exg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 15:51:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64TFp09629294930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 15:51:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A703720043;
	Fri, 29 May 2026 15:51:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 563A220063;
	Fri, 29 May 2026 15:51:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 15:51:00 +0000 (GMT)
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
        Friedrich Welter <fritz@linux.ibm.com>,
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
Subject: [PATCH v3 27/27] KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild
Date: Fri, 29 May 2026 17:50:41 +0200
Message-ID: <20260529155050.2902245-28-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529155050.2902245-1-seiden@linux.ibm.com>
References: <20260529155050.2902245-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L4MtheT8 c=1 sm=1 tr=0 ts=6a19b5ed cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=kekBd6hy71sv0FWHAtgA:9
X-Proofpoint-ORIG-GUID: BGMmbF-YSmlvH2_1RWij-uvq5SOJ6fwS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDE1NiBTYWx0ZWRfX/zELhmqRfDL1
 mptV8d1f4BdrkSkC1Cvsj+Qfj+FI7CE+JbYjHXIgYVuQxqSznXE8XJerwIIPcrw+Ei5EyjCoqly
 BhyVjMHxHTqNNJtTXE++f6+1SPWvY0gD9R2gEY+lHQmBpe47tgaRFn3HTQutVj3w2tRd3cmeL9F
 Wix5e42mMuZdXmO5ZGZ1NUfzxFsTwPkKf5V5VeiO4I8Q/rkx44M34tEqJsvmnIDum/P5iwslyQx
 CY7qDWVQp1k8mjRDLGH2P/I0e7hRi5X1xXcUOlGrCFQhuL79ei8WAAS1acVQWrth3jLm9/itDDX
 O9x1B1FdtXz1Mj7P69PeCX2e+WlBDXFahnlMxZtrkkjXTWYEJ2TzJnxsYupWPYMnSonaS0fEwY0
 1pHAluMKrm80FwLCIQzF32Fec4jfZECkqT8qglGIX8T+8/kMNQ45NSZQREVmbLLEokJNMfCjkev
 5JvmkMdOGu+vEjC20NQ==
X-Proofpoint-GUID: BGMmbF-YSmlvH2_1RWij-uvq5SOJ6fwS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290156

Add all Kbuild/Makefile configurations to build a second KVM module on
s390 implementing the arm64-KVM API. To prevent symbol conflicts with
kvm-s390 all internal symbols in kvm-arm64 are mangled if compiled as
built-in. The new module ins named kvm-arm64.

As in this case the build does not go through the normal build process
the module parameter handling would be messed up. By forcing
KBUILD_MODNAME to kvm-arm64 all parameters are at the same location and
not at object/basename of the object file the parameter is introduced.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Gautam Gala <ggala@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/configs/defconfig  |   1 +
 arch/s390/include/asm/Kbuild |   3 +
 arch/s390/kvm/Kconfig        |   1 +
 arch/s390/kvm/Makefile       |   1 +
 arch/s390/kvm/arm64/Kconfig  |  22 +++++++
 arch/s390/kvm/arm64/Makefile | 108 +++++++++++++++++++++++++++++++++++
 arch/s390/tools/Makefile     |   2 +
 7 files changed, 138 insertions(+)
 create mode 100644 arch/s390/kvm/arm64/Kconfig
 create mode 100644 arch/s390/kvm/arm64/Makefile

diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 21e803354845..65d5e739539b 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -58,6 +58,7 @@ CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_S390_HYPFS_FS=y
 CONFIG_KVM_S390=m
+CONFIG_KVM_ARM64=m
 CONFIG_S390_UNWIND_SELFTEST=m
 CONFIG_S390_KPROBES_SANITY_TEST=m
 CONFIG_S390_MODULES_SANITY_TEST=m
diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 0c1fc47c3ba0..f6fd67d1c651 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -8,3 +8,6 @@ generic-y += asm-offsets.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
 generic-y += ring_buffer.h
+
+generated-y += sysreg-gen-defs.h
+generated-y += kvm_arm64_modname.h
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index f8d4a9a38dae..bbae58aa8bc4 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -20,5 +20,6 @@ config KVM
 	tristate
 
 source "arch/s390/kvm/s390/Kconfig"
+source "arch/s390/kvm/arm64/Kconfig"
 
 endif # VIRTUALIZATION
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index c43d7dffca13..38bdd7c9b42d 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -4,3 +4,4 @@
 # Copyright IBM Corp. 2008
 
 obj-$(CONFIG_KVM_S390) += s390/
+obj-$(CONFIG_KVM_ARM64) += arm64/
diff --git a/arch/s390/kvm/arm64/Kconfig b/arch/s390/kvm/arm64/Kconfig
new file mode 100644
index 000000000000..65b9dc25fe62
--- /dev/null
+++ b/arch/s390/kvm/arm64/Kconfig
@@ -0,0 +1,22 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config KVM_ARM64
+	def_tristate y
+	prompt "Kernel-based Virtual Machine (KVM) support for arm64 guests"
+	depends on HAS_IOMEM
+	select KVM
+	select KVM_VFIO
+	select IRQ_BYPASS_MANAGER
+	select SCHED_INFO
+	select XARRAY_MULTI
+	select KVM_COMMON
+	select HAVE_KVM_CPU_RELAX_INTERCEPT
+	select HAVE_KVM_MSI
+	select HAVE_KVM_IRQCHIP
+	select HAVE_KVM_IRQ_ROUTING
+	select HAVE_KVM_VCPU_RUN_PID_CHANGE
+	select GUEST_PERF_EVENTS if PERF_EVENTS
+	help
+	  Support hosting virtualized arm64 guest machines on s390 host machines.
+
+	  If unsure, say N.
diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
new file mode 100644
index 000000000000..d0aac34b8d2f
--- /dev/null
+++ b/arch/s390/kvm/arm64/Makefile
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: GPL-2.0
+
+KVM := ../../../../virt/kvm
+include $(srctree)/virt/kvm/Makefile.kvm
+include $(srctree)/virt/kvm/arm64/Makefile.kvm
+include $(srctree)/arch/s390/kvm/gmap/Makefile
+
+ccflags-y += -I $(src) -I$(srctree)/arch/s390/kvm/gmap -DKVM_S390_ARM64
+
+kvm-arm64-obj := \
+	arm.o \
+	guest.o \
+	handle_exit.o \
+	inject_fault.o \
+	mmu.o \
+	reset.o \
+
+kvm-arm64-obj += $(patsubst %.o,%-arm64.o,$(shared-arm64-obj))
+kvm-arm64-obj += $(patsubst %.o,%-arm64.o,$(kvm-y))
+
+targets += $(kvm-arm64-obj)
+
+$(obj)/%-arm64.o: $(src)/%.c FORCE
+	@mkdir -p $(dir $@)
+	$(call if_changed_rule,cc_o_c)
+
+ifeq ($(CONFIG_KVM_ARM64),m)
+
+kvm-arm64-y = $(kvm-arm64-obj)
+
+else ifeq ($(CONFIG_KVM_ARM64),y)
+
+KVM_ARM64_GEN_DIR :=$(objtree)/arch/${SRCARCH}/include/generated/asm
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
+LDFLAGS_kvm-unnamespaced.o := -r
+$(obj)/kvm-unnamespaced.o: $(addprefix $(obj)/,$(kvm-arm64-obj)) FORCE
+	$(call if_changed_rule,ld_o_o)
+
+# Make list of symbols to localize.
+# Collect normal/exported symbols. Use dict as set for deduplication.
+quiet_cmd_nm_filter = NMFLTR  $@
+	cmd_nm_filter = \
+$(NM) -jU $< | awk '							\
+{	if (match($$0, /^__export_symbol_(.*)$$/, exp_sym)) {		\
+		exp_syms[exp_sym[1]] = 1;				\
+	} else {							\
+		normal_syms[$$0] = 1;					\
+	}								\
+}									\
+END {									\
+	for (sym in normal_syms) {					\
+		if (!(sym in exp_syms)) {				\
+			print sym;					\
+		}							\
+	}								\
+}' > $@
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
+OBJCOPYFLAGS_kvm-namespaced.o := -O default --localize-symbols=$(obj)/kvm_symbol_list
+$(obj)/kvm-namespaced.o: $(obj)/kvm-unnamespaced.o $(obj)/kvm_symbol_list FORCE
+	$(call if_changed_rule,oc_o_o)
+
+kvm-arm64-y = kvm-namespaced.o
+
+targets += kvm-unnamespaced.o kvm_symbol_list kvm-namespaced.o
+
+endif
+
+obj-$(CONFIG_KVM_ARM64) += kvm-arm64.o
+
+LINUXINCLUDE := -I$(srctree)/include/arch/arm64/ $(LINUXINCLUDE)
diff --git a/arch/s390/tools/Makefile b/arch/s390/tools/Makefile
index f2862364fb42..921261dcde28 100644
--- a/arch/s390/tools/Makefile
+++ b/arch/s390/tools/Makefile
@@ -6,6 +6,8 @@
 kapi := arch/$(ARCH)/include/generated/asm
 kapi-hdrs-y := $(kapi)/facility-defs.h $(kapi)/dis-defs.h
 
+include $(srctree)/arch/arm64/tools/Makefile.sysreg
+
 PHONY += kapi
 
 kapi:	$(kapi-hdrs-y)
-- 
2.53.0

