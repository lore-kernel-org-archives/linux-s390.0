Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA14F0526;
	Wed, 30 Sep 2026 17:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789703; cv=none; b=erpIglvBAjMub0gLqPNsS8Icf6FAprI049wQtoCIh4QjB3o7vMe6XtG4MMwAqDRvmt5HG3h8LhOn98Z3QqBU3HYsjMK2zxu+RINcxG3pjP0sAXnymCMRCkME31rYdP2+jGVeWI3Qgo73BIN7ja7U6akD3TsPvSY6I0rnm8Qd9Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789703; c=relaxed/simple;
	bh=+BJO0HRvGd/Ll23CF8oF54E23rDoJ4r/khlbXrdVigA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LsLfu/svT0x7Cjx6xD6kYa2KLmZOI+am3jqfOnjvy6Adw6OD8inpnknN4fny+tTYMb2TQvgdRlZJkdwUVWqvRzz0XNXAGf4G8TrzvmWHYx+jlj7nvC6psYzeBQ4WnDKZ2hF6tIxAN5HuIDt/CzEVGrYGJE6/im1PzOfFy8dTwCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QZYiw5Sb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QZYiw5Sb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UE5RHG1932732;
	Wed, 30 Sep 2026 17:34:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aPj+gJE+m9/33mikg
	KRuFOW0wzU7IUN0eD8vymH7cBw=; b=QZYiw5SbIIiPbEBNVgON+ItKcgmu22UFu
	unOHVoJVP8em5NdsvE1JUH21ShnUuV8DenYmDSyteNIgNwhu+fhL+0vPQkfuXvUx
	CNBN3AfmOm/v+JAihUqX2CF+00KI+JoA4oHTzqYYLG+2N/pRtU8rVvumc3Q2HkFP
	uPy/DTv7J0b49B4ywzvVXfYOv4jkuyO1ZIBJJ9xZQg+CqJLvnijZeyGGZssGyqA5
	z3jFQosj2zeG1cd6yqmVv+0U84wJkw0QEzE19S0C+xtfAf1r0paLu3deG19L7p9P
	mLpHMsYBZ8WXD7WhNK9P+c0EevH4lwfaMV2Tc9UA9JguQ9yDx6R1g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fedn41-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68UEI6sI3569577;
	Wed, 30 Sep 2026 17:34:53 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcsa66y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 17:34:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68UHYpES16777522
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 17:34:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D970420040;
	Wed, 30 Sep 2026 17:34:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C39B2006C;
	Wed, 30 Sep 2026 17:34:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 17:34:50 +0000 (GMT)
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
Subject: [PATCH v9 24/24] KVM: s390: arm64: Integrate arm on s390
Date: Wed, 30 Sep 2026 19:34:39 +0200
Message-ID: <20260930173441.66762-25-seiden@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930173441.66762-1-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abd483d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=G4QZG555kC8JGPZt_3gA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX7uLjfsgjKhH+
 KCXCEaF0udW8elZWihOCqMXx3Lxi/2AjhgNLKBsQ8kObaNcbhx51u8Lb/8r5tBCH7R5w0rRVoDs
 xrGqvq0B5kn1jWYVVzFKiaI8yj/e2SQ=
X-Proofpoint-ORIG-GUID: miET6eAxzx7KT0jHhHd8IVd9PrbkRbBt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2OCBTYWx0ZWRfX5UhdnsAsr5MS
 flVVHj4tbOGifumMutHiEveC2UTUvtzaMgAz3FzyjY+q9GL9xvmGOflVnGG2JBfZuUXtTzWpSe4
 8yieqlY4Ml+Q7oSwq0rOGU0NxVPE4Iwz8zWOWUS5PUKZM4wnHFA4a1Y41jwwv7Fka2VbdJfVqTi
 /FibdRroJ86j0FSnSmvXOmEFeF7meezHxoA7tf/bZKkEGOO4flOj/x+DedjARpD09/sSFWtx/AM
 I/Udgz7wJhYvUHMX8mVPqrD2zZmlj2zVW3d0im2xdbp2atYdDw/chjh65FbhRKfs8nUSeD2MEat
 G/icvM4yllOibdkp6nWqp0zb2Z76Xg9O1Ud6PTv6CjgLyeIqoO3d604IO9UIGCu2me6ZevuGE9Q
 9EniSZw4KUBJyRVCFiDTTiFPzI+Yc9w9PBr6zMG29KjaBeK8818kKcTD5QEpt0SWFsuxPAS2kUj
 d+80QYeGGXuTfEzVqYg==
X-Proofpoint-GUID: miET6eAxzx7KT0jHhHd8IVd9PrbkRbBt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300068

Add all Kbuild/Makefile configurations to build a second KVM module on
s390 implementing the arm64 KVM API. The new module is named kvm_arm64.

Symbol conflicts with kvm_s390 are prevented by localising all internal
symbols in kvm_arm64 when compiled as built-in (=y): kvm-unnamespaced.o
holds all constituent objects. objcopy --localize-symbols then produces
kvm-namespaced.o which is what kvm-arm64.o resolves to. For =m the
normal module symbol scoping applies and no localisation step is needed.

Because the %-arm64.o pattern targets do not match any kvm-arm64-y entry,
kbuild would derive a wrong KBUILD_MODNAME (e.g. "kvm_main_arm64") and
a wrong KBUILD_MODFILE for the virt/kvm and gmap copies.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Co-developed-by: Gautam Gala <ggala@linux.ibm.com>
Signed-off-by: Gautam Gala <ggala@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/Kconfig        |  25 +++++---
 arch/s390/kvm/Makefile       |   1 +
 arch/s390/kvm/arm64/Makefile | 110 +++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+), 9 deletions(-)
 create mode 100644 arch/s390/kvm/arm64/Makefile

diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 9045ae20fd89..e7b525d04c6d 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -30,15 +30,22 @@ config KVM
 	select KVM_MMU_LOCKLESS_AGING
 	select KVM_GENERIC_PRE_FAULT_MEMORY
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
index 000000000000..3f0fe5c9f0a1
--- /dev/null
+++ b/arch/s390/kvm/arm64/Makefile
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: GPL-2.0
+
+KVM := ../../../../virt/kvm
+KVM_DEV_NAME = kvm_arm64
+KVM_DEV_MINOR = MISC_DYNAMIC_MINOR
+include $(srctree)/virt/kvm/Makefile.kvm
+include $(srctree)/arch/$(SRCARCH)/kvm/gmap/Makefile
+include $(src)/Makefile.gen
+
+ccflags-y += -I $(src) -I $(objtree)/$(obj) -I$(srctree)/arch/$(SRCARCH)/kvm/gmap -DKVM_S390_ARM64
+
+kvm-arm64-local := \
+	arm.o \
+	guest.o \
+	handle_exit.o \
+	inject_fault.o \
+	mmio.o \
+	mmu.o \
+	reset.o
+
+kvm-arm64-obj := $(kvm-arm64-local)
+kvm-arm64-obj += $(patsubst %.o,%-arm64.o,$(kvm-y))
+kvm-arm64-obj += $(patsubst %.o,%-arm64.o,$(gmap-y))
+
+targets += $(kvm-arm64-obj)
+
+$(obj)/%-arm64.o: $(src)/%.c FORCE
+	@mkdir -p $(dir $@)
+	$(call if_changed_rule,cc_o_c)
+	$(call cmd,force_checksrc)
+
+# %-arm64.o stems don't match any kvm-arm64-y entry so Kbuild derives wrong
+# KBUILD_MODNAME/KBUILD_MODFILE. Force include a generated header to override.
+KVM_ARM64_MODNAME_H := $(obj)/generated/kvm_arm64_modname.h
+ccflags-y += -include $(KVM_ARM64_MODNAME_H)
+
+$(addprefix $(obj)/,$(kvm-arm64-obj)): $(KVM_ARM64_MODNAME_H)
+$(foreach sfx, i s ll lst, \
+	$(eval $(patsubst %.o,%.$(sfx),$(addprefix $(obj)/,$(kvm-arm64-local))): $(KVM_ARM64_MODNAME_H)))
+
+targets += generated/kvm_arm64_modname.h
+
+define filechk_kvm_arm64_modname
+	echo '#ifndef __KVM_ARM64_MODNAME_H';			\
+	echo '#define __KVM_ARM64_MODNAME_H';			\
+	echo '#undef KBUILD_MODNAME';				\
+	echo '#define KBUILD_MODNAME "$(KVM_DEV_NAME)"';	\
+	echo '#undef __KBUILD_MODNAME';				\
+	echo '#define __KBUILD_MODNAME $(KVM_DEV_NAME)';	\
+	echo '#undef KBUILD_MODFILE';				\
+	echo '#define KBUILD_MODFILE "$(obj)/kvm-arm64"';	\
+	echo '#endif /* __KVM_ARM64_MODNAME_H */'
+endef
+
+$(KVM_ARM64_MODNAME_H): FORCE
+	$(call filechk,kvm_arm64_modname)
+
+# Members are not in real-obj-y. Set part-of-builtin to enable instrumentation.
+$(addprefix $(obj)/,$(kvm-arm64-obj)): private part-of-builtin := y
+
+ifeq ($(CONFIG_KVM),m)
+
+kvm-arm64-y = $(kvm-arm64-obj)
+
+else ifeq ($(CONFIG_KVM),y)
+
+prereq-o-cmd = $(foreach o, $(filter %.o, $^), $(dir $(o)).$(notdir $(o)).cmd)
+cmd_gen_symversions_o = \
+	grep --no-filename "^\#SYMVER" $(prereq-o-cmd) >> $(dot-target).cmd || true
+
+cmd_ld_o_o = $(cmd_ld)
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
+# cmd_oc_o_o carries -DKBUILD_MODFILE so generate_builtin_ranges.awk
+# can attribute kvm-namespaced.o to kvm_arm64 via its .cmd file.
+cmd_oc_o_o = $(cmd_objcopy) -DKBUILD_MODFILE='"$(obj)/kvm-arm64"'
+define rule_oc_o_o
+	$(call cmd,objcopy)
+	@printf '%s\n' 'savedcmd_$@ := $(call make-cmd,oc_o_o)' > $(dot-target).cmd
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
+clean-files += kvm-unnamespaced.o kvm_symbol_list kvm-namespaced.o
+
+obj-$(CONFIG_KVM) += kvm-arm64.o
+
-- 
2.53.0

