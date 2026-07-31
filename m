Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C2443847E;
	Fri, 31 Jul 2026 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503391; cv=none; b=TpBPZomH/rWKrUw+mZoDxcH77UrDywaP+Nw8zNXm06VSg7Cm306Wnl3dA3hugs7OlSm2cfbYd/+cCRx0ve5JB/iW/CbzaKZUZPohA1sq0ybP77Ptgrki8ICCYD1keAYm0XIsS7o0IrMoczNiavLqW5FUtPOPs9GpG788lXGfAik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503391; c=relaxed/simple;
	bh=YG1NvJoyhv87X+UOUAt45z0IQnLMXQiRb3P/TcDdrTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RD7XECcr/GFCFedgXhKQk21Jrb28LgdMNfiIA/uGzHW3Mflwax74HMvwmM9b7KWozXo1NuWAdLHRaaVSrCeNAMzJOiMbRKPHgPYXa3kLcxCZH+7qB0z1cqMdmQiSTe9lm67hPm2QjLmpPhgswCD6e6t/NJY3mBbYd4r4ar6geQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kjlRiwT8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kjlRiwT8"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBm7nw1732055;
	Fri, 31 Jul 2026 13:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9O9bxcs/CQGb5OBe7
	pnl0LW2foATwy5DPiHGFcANeLc=; b=kjlRiwT8bavw3mKEf8rwW0ZgpOrwFSdLV
	Faty8sqiEfRGnKX+o50P+sxqX+UPAnjLt+9+ZQTfF47UAyh+bHyR1AGkuw2CplYC
	QwGFbwY5RMK6dKq84gWV7yqGryFyLAUoJ6hsJnmbuhucGKftU9J/gFW5Lo/cHojC
	xZP8nEP+6RDSo9hC6T9/vz8AGtVf00pEelsVZj2KEGQMlPIABQ2Ef7I8hZ+bSTy1
	HayOdMTE0ePeBhjmqHB6Wt1+TEFSLg2rvLIakzireM+ke/d1uNsMHB/fC2bOxgAV
	pBJQ5sLyGXbaP6l6zL3pIigb4g8a5PTnZWEt/fH0G6p/cXgU+Zo+w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuw7w4mh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuN5R012675;
	Fri, 31 Jul 2026 13:09:23 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkg08c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD9Htk32637366
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:17 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18A5120040;
	Fri, 31 Jul 2026 13:09:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A49E820043;
	Fri, 31 Jul 2026 13:09:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:16 +0000 (GMT)
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
Subject: [PATCH v5 31/31] KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild
Date: Fri, 31 Jul 2026 15:08:59 +0200
Message-ID: <20260731130902.654679-32-seiden@linux.ibm.com>
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
X-Proofpoint-GUID: pfdhqXbQC7jqJMONarHISRs4XYt2XbXg
X-Proofpoint-ORIG-GUID: qgJ8BdUnfumoSAFTZjSYs_6dq4KqKIZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX8S31ufeTk2JT
 cTq8XLGekONKaIkR+7wtbzF3FPNfxHoP8em+tTz41RN34jnNxpHr4fFz6dodBBID9Wg+RehSXLU
 VjMfPJ1FrV6Rt03wDL4iu+MpNJKr0UTSdpgUKi/N263o5I/KUxGh2bccZe2pol+fcnWfvfXuFaY
 9BpdcpI/FVZ/JImKIdV5SZHzl/6ZlhuZNeQd64GzBzWokmfgRA5UGpvF84ySnL0SSCaSSF0XWCt
 J9xq7WASmNbsCt1cK/MnDgBLS/ZAvHkXQf4YSMsO799ishHcl55wSASS3b5v//oF+WQnIf8HksG
 V5dpf8UDGqJflsfZkEGpq8qcpVhxYM+AfB341bLsPdXDBKCV1EAfFxD2L1Fz6HrWbrKNV0Nu+Zh
 ugshwnD7WcYWn8CoAwOhLYoSil601kkkA7Y6m32XaOBGUm4g9oYA3omHA9TIyNmZKQMhvr2finr
 ixUnvR6hv+Wplwyk53A==
X-Authority-Analysis: v=2.4 cv=SKFykuvH c=1 sm=1 tr=0 ts=6a6c9e85 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Zz3svKs3IDGlfYr5LI8A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX3Gop5Qm/Sl5u
 1R0oQN0H5xH0GLfACWWcCe6MVBMhys50CkbTXehE5EQpANZ7uKG+A3+7OavjyCS/69GXkMHNrN5
 I6qx4xSZqVUOPXw69e3UMqcf+/LtcQI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607310096

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
 arch/s390/configs/defconfig  |  1 +
 arch/s390/include/asm/Kbuild |  3 ++
 arch/s390/kvm/Kconfig        |  1 +
 arch/s390/kvm/Makefile       |  1 +
 arch/s390/kvm/arm64/Kconfig  | 22 +++++++++
 arch/s390/kvm/arm64/Makefile | 91 ++++++++++++++++++++++++++++++++++++
 6 files changed, 119 insertions(+)
 create mode 100644 arch/s390/kvm/arm64/Kconfig
 create mode 100644 arch/s390/kvm/arm64/Makefile

diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 327ab4a3933c..20de85c96e9e 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -62,6 +62,7 @@ CONFIG_CMM=m
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
index 000000000000..15de7c52c861
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
+	select GUEST_PERF_EVENTS if PERF_EVENTS
+	select HAVE_KVM_CPU_RELAX_INTERCEPT
+	select HAVE_KVM_IRQCHIP
+	select HAVE_KVM_MSI
+	select HAVE_KVM_VCPU_RUN_PID_CHANGE
+	select IRQ_BYPASS_MANAGER
+	select KVM_COMMON
+	select KVM_MMIO
+	select KVM_VFIO
+	select SCHED_INFO
+	select XARRAY_MULTI
+	help
+	  Support hosting virtualized arm64 guest machines on s390 host machines.
+
+	  If unsure, say N.
diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
new file mode 100644
index 000000000000..a102c35664ca
--- /dev/null
+++ b/arch/s390/kvm/arm64/Makefile
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0
+
+KVM := ../../../../virt/kvm
+include $(srctree)/virt/kvm/Makefile.kvm
+KVM_MANAGES_S390_GUEST = n
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
+	mmu.o \
+	mmio.o \
+	reset.o \
+
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
+	cmd_nm_filter = $(NM) -jU $< | sort -u > $@
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
-- 
2.53.0

