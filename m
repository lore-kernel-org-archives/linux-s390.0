Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC504FDA68;
	Fri, 18 Sep 2026 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789738321; cv=none; b=d5kgtJdO92QDb6hN/VHZe/Pd2mDBsCN8SSQC/tahI6DSLZjJ+vOne2f4YdneaBYsNmbXXA5XmzmhS+IHSXdseAGsKhmTJdkRTeFGegBoPBIHISwO3OmFYcN6vyUNnofZ4O5WWED3x40C7alpuKoR66O1iVQwXz5rjLge+xP7u+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789738321; c=relaxed/simple;
	bh=dXpCdwG66pkHTyERbncZkMWhpTnDi2Lf2HJjOjupGCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUQO0G2J3RIccEP6xhYmL3QA62bPgsNUMbopMvKm5zy8CwS5V8h3x0wrtxPUVbcQvtW49V4JI+60Mz9vd6tpv6T7ShMIZF5Np992P9C56ekTTLBPqzp69jL0Qi56tHr81VqczHsu3za9ydFv/YxfFTfJj6uLYIqPGvbgtCCmGQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XgI9G39q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XgI9G39q"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDVPo73708413;
	Fri, 18 Sep 2026 13:31:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FcmdycdQXp41OBusk
	c+AzFrFAnw0ExIOHhNLryI9ozA=; b=XgI9G39qTDV1E4ZsjU+bZ/5EZhG3xm0oI
	tgsHulmgwBMjt2YINU0S8cExzZRvkf89Z0bd/gugIuOAC2F/8c42vp/ndkeuEqZb
	2C0/oMoTHA0sDCEYZ+x1yPUAKMhYkdC6jEI/OK9QtoqL8kYQPx8jO9NJILJhAQq/
	ihFJZWChokxEBpu/PoqAeItn/cbbctlluDdyoK8NPM9fKbYq4rs6howYFNWzEHz0
	56jCls+Szdbr5BCpi28V0LYuj9inzdAGoJhBhg13i2ccQu6/YVuPbQOogYjuiS8I
	7aIvJ2lRhb3tGJRTwE8ZJCC21j9vsuS3D87vC/H4QXsjNsieLIpNQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqra32-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68IDNqig777341;
	Fri, 18 Sep 2026 13:31:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gra3yxkc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 13:31:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68IDVIEO51511724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 13:31:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C47520040;
	Fri, 18 Sep 2026 13:31:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 26CB120049;
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
Subject: [PATCH v8 28/29] KVM: s390: arm64: Integrate arm on s390
Date: Fri, 18 Sep 2026 15:31:05 +0200
Message-ID: <20260918133107.1042730-29-seiden@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE5MiBTYWx0ZWRfX7q6BDXeYqT3+
 CgoRoixI/sExF00hRyln9vGdV5+Vl/hbURdZbyIHIl3IIGfEiuFdWcxk9lsfLtGBV+eqJDzVFkv
 jTsz9polcAEelgamHS2zY8KJNggoiQNB0Tg4uCkoSVf7UOJDvgMV5IM9AFl9k0QNXJMmd8qrJVY
 4ArRlXl8JMrMDK5+RerGI9tPfevGBOveLgpGTQvAIs/tkws6mtgLc3vRN5rEPRZJ3xaXwDcFULU
 OwH/SJYZVt2oeBzSROq/PODb14gx5KcJ8b8Y8OufA35o81C6ptU3CeV4ldrZbJvx7oL2fasoGk0
 x+Wono5kxsBQ9Nq1YlozAUvr/aqxpqQDsBY4h5w9hujZ94dwB7hxA7y2cs0v2cNyJHAfKWKzlOU
 P7JPohWyyeUPpdSuk5sKMgw3IrruNMWVVK7BK0PVgxYQWheJad8rdSjU9jynBgai2PP+2Q6YPnZ
 NNdPajPKhIB4kxMFYSg==
X-Proofpoint-GUID: TBX9soDy60mSVGXr9vwCVrQzbAInrvi0
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aad3d2d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=86Nss3GfdkgdrDYwrAMA:9
X-Proofpoint-ORIG-GUID: 8LmCva1kK--8xXt6EznWyIQYnJ1n4udm
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE5MiBTYWx0ZWRfXxffRJPniMDSS
 oGUtJssU5YBQEIuSVC+b++kIPITpl5X4TPUWok+ZhvdTkYoO7E9j7SRl2JOmItI+P3zR3jclwOq
 CRXQO30c8qbyQgWgtK+cTQov2b6cFmg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180192

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
 arch/s390/include/asm/Kbuild |  1 +
 arch/s390/kvm/Kconfig        | 28 +++++++----
 arch/s390/kvm/Makefile       |  1 +
 arch/s390/kvm/arm64/Makefile | 93 ++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/arm64/arm.c    |  2 +-
 5 files changed, 115 insertions(+), 10 deletions(-)
 create mode 100644 arch/s390/kvm/arm64/Makefile

diff --git a/arch/s390/include/asm/Kbuild b/arch/s390/include/asm/Kbuild
index 0c1fc47c3ba0..9409970a2123 100644
--- a/arch/s390/include/asm/Kbuild
+++ b/arch/s390/include/asm/Kbuild
@@ -8,3 +8,4 @@ generic-y += asm-offsets.h
 generic-y += mcs_spinlock.h
 generic-y += mmzone.h
 generic-y += ring_buffer.h
+
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index a6ff2e5aa19b..4e060185c2fb 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -19,6 +19,7 @@ if VIRTUALIZATION
 config KVM
 	def_tristate y
 	prompt "Kernel-based Virtual Machine (KVM) support"
+	depends on HAS_IOMEM
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select KVM_ASYNC_PF
 	select KVM_ASYNC_PF_SYNC
@@ -28,16 +29,25 @@ config KVM
 	select KVM_VFIO
 	select VIRT_XFER_TO_GUEST_WORK
 	select KVM_MMU_LOCKLESS_AGING
+	select GUEST_PERF_EVENTS if PERF_EVENTS
+	select SCHED_INFO
 	help
-	  Support hosting paravirtualized guest machines using the SIE
-	  virtualization capability on the mainframe. This should work
-	  on any 64bit machine.
-
-	  This module provides access to the hardware capabilities through
-	  a character device node named /dev/kvm.
-
-	  To compile this as a module, choose M here: the module
-	  will be called kvm.
+	  Enable support for hosting virtualized, hardware-accelerated
+	  virtual machines via two modules: kvm and kvm_arm64.
+
+	  The kvm module provides access to host hardware-accelerated s390
+	  guests using the Start Interpretive Execution (SIE) instruction via a
+	  character device node named /dev/kvm. This requires a 64-bit machine
+	  (hardware model).
+
+	  The kvm_arm64 module provides access to host hardware-accelerated
+	  arm64 guests using the Start ARM Execution (SAE) instruction via a
+	  character device node named /dev/kvm_arm64. This requires hardware
+	  models that support the Arm execution facility (AEF).
+
+	  To compile this driver as a module, choose M here. The module will be
+	  called kvm for the SIE acceleration and kvm_arm64 for the SAE
+	  acceleration.
 
 	  If unsure, say N.
 
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index a4e3875b5bdd..380db443a0e9 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -4,3 +4,4 @@
 # Copyright IBM Corp. 2008
 
 obj-$(CONFIG_KVM) += s390/
+obj-$(CONFIG_KVM) += arm64/
diff --git a/arch/s390/kvm/arm64/Makefile b/arch/s390/kvm/arm64/Makefile
new file mode 100644
index 000000000000..bd78d64939d1
--- /dev/null
+++ b/arch/s390/kvm/arm64/Makefile
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: GPL-2.0
+
+KVM := ../../../../virt/kvm
+KVM_DEV_NAME = kvm_arm64
+KVM_DEV_MINOR = MISC_DYNAMIC_MINOR
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
+ifeq ($(CONFIG_KVM),m)
+
+kvm-arm64-y = $(kvm-arm64-obj)
+
+else ifeq ($(CONFIG_KVM),y)
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
+LDFLAGS_kvm-unnamespaced.o := -r
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
+obj-$(CONFIG_KVM) += kvm-arm64.o
diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index bb3e7fa8cad5..43e40fc78501 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#define KMSG_COMPONENT "kvm-s390-arm64"
+#define KMSG_COMPONENT "kvm_arm64"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/miscdevice.h>
-- 
2.53.0

