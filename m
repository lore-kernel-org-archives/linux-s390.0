Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8267242E01F;
	Tue, 28 Apr 2026 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392366; cv=none; b=q9xHLoy6QLutl0RcC1imygVy3yS6y40FBYVmpyNcB5FVZcL7RALZi9yGhE6v+Gn6MFATcf5c+KJkLQg6wr1TmAakPeQeq3TUZUKVLGL+qmJ7ZGzWSgxj38U2K7YO3dbUoCSn/cWJxZviULjcT4gjftnpwRBp88pKxpHBPdo6oQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392366; c=relaxed/simple;
	bh=gJ50aN2aHsnqyzzecYooom9Y4sYzshztAEvY3ZxQOJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m7FvfaYw3uQIQzKn5c1YsaVrs34Zischkcxk27LaL7QGzAcx1QAz5JImHNtM0+/EMPBnwz3+z/XeISpIy4k4MGUlMWOUV8UkFGd3iwJ94AuYDfCxHrhmFwxiLnOAkSg6/pwZQyd8f+EDfJ2ieT1DwJ06mvdqKgDUH/0kL00PdH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SDX8tQej; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SDX8tQej"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63S6TLKO3017137;
	Tue, 28 Apr 2026 16:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uTgzHy3m98P55yjTh
	PJgJScPlT/2lMhPDUIfJDMciRc=; b=SDX8tQejgsqGPsV8jMCIVKbBRQV+ZHxzZ
	7pqjeiPj8Xki6agzcYUhbfRITAmT4XdFP6xdyQ4eQNY2bC+Aq4sk4BI6ZzR5Zlzg
	v4jiM16s7EBj3ER9ckzIL83yCAHp3E9wScH2bLd1JvbefPUlrQgm21kAruvlAHRu
	e11jCyHxa5/pRPCn8x572U6gdiIRcYoQhhIMGultADQUfweLLXed/NdwvW9qwsH2
	9Nem4T7bf+E0sIDmeN6Ov+zt8kUIhYmN+0lS//xIdhva4acREF9jeDhcgDQvsrlf
	YjYogyslH7eAN2yYgRi2L8nvQGy/5tgdJMUJO9y3nUK+FnN1LhqXw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn9r6dq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63SFrpof027791;
	Tue, 28 Apr 2026 16:05:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dsamya6h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Apr 2026 16:05:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63SG5bIo44433780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Apr 2026 16:05:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC42B20040;
	Tue, 28 Apr 2026 16:05:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C42F20043;
	Tue, 28 Apr 2026 16:05:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Apr 2026 16:05:37 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Will Deacon <will@kernel.org>, Zenghui Yu <yuzenghui@huawei.com>
Subject: [RFC PATCH v2 28/28] KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild
Date: Tue, 28 Apr 2026 18:05:25 +0200
Message-ID: <20260428160527.1378085-29-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260428160527.1378085-1-seiden@linux.ibm.com>
References: <20260428160527.1378085-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: NjLRPQ4GE9y6FwJleJxxJGfezK0KCzxc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDE1MSBTYWx0ZWRfX8Virap4sE+V2
 7dlx4bjfjRdwDZvUXB7GDUKKbRobzYsQyNpOIUvbMv+3OScdqyD9G+5Z66SydNlIl1H5dT3b1/e
 0IhkMCBjyQIENJ8A7P/ERqjuXkkDwmk3zSzxXfjZ20LzgdNhADEkeLWp62Y1Y/kPDEknNYE6oW4
 QlfN32G2c4IAoCKvUgp0LzO1M8DeZVY7c0wHsR2dtX23p6JB1hIq0z14kBQaBz3xuBQTHGsGi8h
 YFIeaECKdj9bf0XkGH+MBStOFpYO09gNGUC7KeYJXPROlEzsa/X+UevKo0CKP+9Fh9umU2K+zqn
 X/sgl37IKSsifby8RTnj/2wQ+Pzd/oZyIFx/4tMvNa/NjRibt1GIAJVPme3EiWw+ZniZODabqc2
 8KFEf3xabCf+AUHPn91f/zW1S9cnJ3hIAdqOdKiZFl/M7NBMEIr2CAWmDyix/jXv7lbM9rHdvB3
 VMVNafK7Aq6be6l3jsg==
X-Authority-Analysis: v=2.4 cv=Kc7idwYD c=1 sm=1 tr=0 ts=69f0dad6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=kekBd6hy71sv0FWHAtgA:9
X-Proofpoint-ORIG-GUID: NjLRPQ4GE9y6FwJleJxxJGfezK0KCzxc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_05,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280151

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
 arch/s390/kvm/arm64/Kconfig  |  21 +++++++
 arch/s390/kvm/arm64/Makefile | 108 +++++++++++++++++++++++++++++++++++
 arch/s390/kvm/s390/Kconfig   |   1 -
 arch/s390/tools/Makefile     |   2 +
 8 files changed, 137 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/kvm/arm64/Kconfig
 create mode 100644 arch/s390/kvm/arm64/Makefile

diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index bbbb4d0df9dd..e10e9e1ad94d 100644
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
index 80bad7de7a04..c2c238f418c6 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -7,3 +7,6 @@ generated-y += unistd_nr.h
 generic-y += asm-offsets.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
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
index 000000000000..42a1be50f6e1
--- /dev/null
+++ b/arch/s390/kvm/arm64/Kconfig
@@ -0,0 +1,21 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config KVM_ARM64
+	def_tristate y
+	prompt "Kernel-based Virtual Machine (KVM) support for arm64 guests"
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
diff --git a/arch/s390/kvm/s390/Kconfig b/arch/s390/kvm/s390/Kconfig
index f9853e61fd58..263ff29b9c9c 100644
--- a/arch/s390/kvm/s390/Kconfig
+++ b/arch/s390/kvm/s390/Kconfig
@@ -2,7 +2,6 @@
 #
 # KVM_S390 configuration
 #
-source "virt/kvm/Kconfig"
 
 config KVM_S390
 	def_tristate y
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
2.51.0

