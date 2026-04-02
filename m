Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B3F387372;
	Thu,  2 Apr 2026 04:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775103770; cv=none; b=lZ5Z+DWgooqXPhLMn01BChKLXK+KxZu6ThoSOk+TD6z4I3r2kiS5z407in3pHedfpb5zpAMx4Dp3spdEz86sT1PrxfL5h5ZbrwG8s2zQe3MeD9Rw4EAPrERKibZzTn3WA2Pt4NjnJJItoQRYY0IaxoQIpPBbt6+p48H2YoImd1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775103770; c=relaxed/simple;
	bh=NMJF/YDqQh/846qEMECzropxuFLUVfjIl+o/eH3Uckk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HXz+KqsyBcWf6zqPJJc8lUY8ww/2Bn7fzQWdED35DKa1TdKd/3ynvpcPIrwWiti76iHUvpkSdLDZABfIZmETDETAVt9yyOd5b2ETZYrccwZkkPD9qhjup7eVNjzDlCQkcS0d/IbefLGjbmn+ssXe6wz/mQocoDksaY21GlMJZP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VkWd8kVK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VkWd8kVK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631J9F4C016485;
	Thu, 2 Apr 2026 04:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=OVlMWoxVuVC3bddRg
	iIL2oCSJYmdMUTYiq38BM6SzrQ=; b=VkWd8kVKL5e9VZzlA209dWR7tQxJY6131
	bSlr67NjCSf2zOyJYGbPg6Y65HFq1A1nCOepFcI6jvVNeEB69rGb3EZmcX59mHn9
	IOLlxhASJfklFb8yycX9anzIKXHLBV7WNM5u2ZT/SKaPGdyP70sYMW/JSBwydLMf
	Z4CPuOGEbqOOikmJ2ZCRC8TkRdV1Dy3b2fYcjfMl+DxfHxxqDz9IedqLY5ZK28Tb
	Sfype6DWxwcU1cCfOxLotdDCJADeyHFkpeN/48d/YUVDpcxb7BUH17MQ2gUYAFUH
	Nmj3RFUZ8lyrGCtdsSXGa6+16ora4CexF7hWQa1/3JYY1Hj/zfyvg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnu7t7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6321BP6n031034;
	Thu, 2 Apr 2026 04:21:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6uhk0eeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Apr 2026 04:21:39 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6324LaZd46727552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Apr 2026 04:21:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CAE02004D;
	Thu,  2 Apr 2026 04:21:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC98C2004F;
	Thu,  2 Apr 2026 04:21:35 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Apr 2026 04:21:35 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Andreas Grapentin <Andreas.Grapentin@ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
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
Subject: [PATCH v1 27/27] KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild
Date: Thu,  2 Apr 2026 06:21:23 +0200
Message-ID: <20260402042125.3948963-28-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260402042125.3948963-1-seiden@linux.ibm.com>
References: <20260402042125.3948963-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PaMpjwWptYBnAr715fnkwaYT51Yy7Rft
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cdeed4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=YcNp7YdKFKR72B5OmKgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDAzNCBTYWx0ZWRfX8rdp1F5b0FW4
 257NsLh9PI2gUlheaGeAsQQqQ9ll4S7hgF4XDK2GlMbVOY0QkNvG/4X+UTUbwKTw1ibmwU+t9KJ
 fGCreKRXWD7aghpK3zQTUfOXfI5q71S8KzV4B/sGsMopZ0H80gw7nCNIr/aCKqTWROBJiHkazsj
 3QTY5GkAPMkHgQjtwVMcWQMG8fKwT1RHkMStnZCqT+lW9etdK+SvO+/Q8E00957T0tgOTto1Yoe
 3MsRxBL/N/4qMSUr2WKZc7EkVc2wO/rtdK9cYICgK2tf230FkoKnz3PrBUsWI2CbU5ujD1M/IGM
 VQJNzw1/VMLHk87mCNeLLqbhC/QkFMmMNZJk622lONxbu5C3uQPyHbGgok0SE9EalMIibYdOD+s
 YhxrCBdm3Mfi+HA9eGOZt+WgjemMDhlzCzbCXcPEBon/q5Droq/ILXeEt/wyGPOKUJaCaFTA6bM
 PLibW4+ZB2o2VL2BN7Q==
X-Proofpoint-ORIG-GUID: PaMpjwWptYBnAr715fnkwaYT51Yy7Rft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604020034

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
 arch/s390/kvm/Kconfig        |   1 +
 arch/s390/kvm/Makefile       |   1 +
 arch/s390/kvm/arm64/Kconfig  |  23 ++++++++
 arch/s390/kvm/arm64/Makefile | 107 +++++++++++++++++++++++++++++++++++
 arch/s390/tools/Makefile     |   2 +
 6 files changed, 135 insertions(+)
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
index 000000000000..6794bb0436e9
--- /dev/null
+++ b/arch/s390/kvm/arm64/Kconfig
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+
+source "virt/kvm/Kconfig"
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
index 000000000000..9fa3f209c320
--- /dev/null
+++ b/arch/s390/kvm/arm64/Makefile
@@ -0,0 +1,107 @@
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
+	reset.o \
+	mmu.o \
+
+kvm-arm64-obj += $(patsubst %.o,%-arm64.o,$(shared-arm64-obj))
+kvm-arm64-obj += $(patsubst %.o,%-arm64.o,$(kvm-y))
+
+obj-$(CONFIG_KVM_ARM64) += kvm-arm64.o
+
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
+targets += $(notdir $(KVM_ARM64_MODNAME_H))
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
+$(KVM_ARM64_MODNAME_H): FORCE
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
2.51.0

