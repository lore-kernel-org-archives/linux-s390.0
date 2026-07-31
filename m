Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5387F43802C;
	Fri, 31 Jul 2026 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785503391; cv=none; b=JpR+VY6BqVj9LFVPJ//fA3FyII+dMcQf5kyN48Aw80miIJ1E7MBURekgtsuMnz4E0ax9tmd1+S35wUPegYyojXDJtRKYnHW3FxBTYhFOq0PKbCNzywzVZpduogmpGPjdWivk4z7IcXYlZPtv2mVf9lfdotiqC7YQmVs8RVs+yzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785503391; c=relaxed/simple;
	bh=/oV3eyAK1cbDRvPx+9LLhErywekKRVFgqAm/mn95++o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOf2PIaVKjJu6PECjf/a2lb+M6gtwYisRUrfNu1TIJkB7MtkbsB+3Vt0ZojDuwh4XxxpqXtiLtA95JS3gGa6U5bs+Ss+D/5v7qFUZvAgGFAnDk/qDu/cT9QRzCcnGkjhXFcUEskFObcb/jrqIuS1q+3wYltdG8OEz2ZTsQOIBDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qFTtpzD3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qFTtpzD3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBlp3I4072850;
	Fri, 31 Jul 2026 13:09:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ULOvOfwPtEGE5jko2
	/sd8TtxH5WeGPHpTOCc3jzGCp4=; b=qFTtpzD3IvJQ8IeMvAmQ1VU097nqA1tAp
	qDykny4ajHJv/fEruSEeTanO5tiDys8C3qYn6y8a4Jqci28dS1TMmCkjNT6ZVhFu
	7Es+osIL/3eNfoRbsNz1NeYG0yelNMGlge6j6yBd+jWqa/lb6b0NFASX9kIRk544
	bKoaBsAHTjWQuISrTRaJxkmrIvBd2eAPFwIWC6BjRxLhFS43nf1x72rHyPLRK7KB
	lS3RsbhITp/to7gGmVqWHxARJwjEIXbU0qt58Q6WYp8QLKKZ8llVVgfy/TFnYFwK
	fk05qSPeXcGjct3BiXaysr+0GnX4vo0M67KOkK3JSQtxb5sC1eiFg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycw2nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuJNx012649;
	Fri, 31 Jul 2026 13:09:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkg083-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:09:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD99uI32309732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:09:10 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D753420040;
	Fri, 31 Jul 2026 13:09:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FE7620043;
	Fri, 31 Jul 2026 13:09:09 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:09:09 +0000 (GMT)
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
Subject: [PATCH v5 15/31] KVM: s390: Guard KVM/s390 behind CONFIG_KVM_S390
Date: Fri, 31 Jul 2026 15:08:43 +0200
Message-ID: <20260731130902.654679-16-seiden@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: AdgRE-4qQiWoRXdX6o5TOetxKhjuFY8_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX8hbOS3QFyNA4
 USdAdosr8iih8XYi+vcVvd6G3VZMovBu5qDTUZ3gJmxOEleqRkrhGTGA0aELoBUdaJBxMzczWmq
 7wpBNnWamHbOg1BDCUpttWkNLntUX0gv/yGzq8QtkkgYKVxVAJpZeQQDikbqCvNzU+2PSRAe0c3
 PTdDkqJ7DYwfhDZJwzYGR+CAd+N/SBL+Z2QJatRPZyhsNfjyiKYEP6UmciEks9fRhDEhNsEm1pr
 oCdjrhjNzcSD5ao+R0LgOoOLaSetK6CFEnI8rjAbwwh2qVp7tXd6jr0kdzUkYItRg3rwB8cMz0C
 xErqR5U8/veUbHLQhTQ0HMG1oyWEYRsRFbdNg1IxxvC9PTZCPKAVAN7SgyVnEyznP3GEQc/PhYe
 juGzBwytUeq8gQea+H9N4ZtUTqGuAoVkBOir2TFB2xVo+3ivp+Vqj8nnl6ah8k30qk6ZM/8JW3G
 0mLDYf1YDuciBNdmVwQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX2B/EdPQp8nF9
 W3Hurp+3y89WVtRjWsDBZk+eFeVVI+9qrT0hvq/as40OyQBQWJDruDONkbUAUt5esVDrATsA5ZN
 fCGudHoDglFM8pyrKO4jzAW6/7ZGQMI=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6c9e7f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=TDxLvxBx8DFaYtTTU-YA:9
X-Proofpoint-GUID: iYp1v1CtsQuSW0cyCdHoeyIWgXvvAbLT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

To allow for a second KVM Module guard KVM/s390 behind CONIG_KVM_S390
instead of CONFIG_KVM and turn CONFIG_KVM on if selected.

Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/Kconfig                 |  2 +-
 arch/s390/boot/ipl_parm.c         |  2 +-
 arch/s390/boot/uv.c               |  2 +-
 arch/s390/configs/debug_defconfig |  2 +-
 arch/s390/configs/defconfig       |  2 +-
 arch/s390/kernel/early.c          |  2 +-
 arch/s390/kernel/entry.S          | 10 +++++-----
 arch/s390/kernel/perf_event.c     |  2 +-
 arch/s390/kvm/Kconfig             |  3 +++
 arch/s390/kvm/Makefile            |  2 +-
 arch/s390/kvm/s390/Kconfig        |  5 +++--
 arch/s390/kvm/s390/Makefile       |  2 +-
 include/linux/kvm_host.h          |  2 +-
 13 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 84404e6778d5..b2eaa2000b10 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -834,7 +834,7 @@ config VFIO_CCW
 config VFIO_AP
 	def_tristate n
 	prompt "VFIO support for AP devices"
-	depends on KVM
+	depends on KVM_S390
 	depends on VFIO
 	depends on AP
 	select VFIO_MDEV
diff --git a/arch/s390/boot/ipl_parm.c b/arch/s390/boot/ipl_parm.c
index 6bc950b92be7..b8906ba7e5e8 100644
--- a/arch/s390/boot/ipl_parm.c
+++ b/arch/s390/boot/ipl_parm.c
@@ -300,7 +300,7 @@ void parse_boot_command_line(void)
 			stack_protector_debug = 1;
 #endif
 
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 		if (!strcmp(param, "prot_virt")) {
 			rc = kstrtobool(val, &enabled);
 			if (!rc && enabled)
diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
index 4568e8f81dac..f7b68bdcedc1 100644
--- a/arch/s390/boot/uv.c
+++ b/arch/s390/boot/uv.c
@@ -26,7 +26,7 @@ void uv_query_info(void)
 	if (uv_call(0, (uint64_t)&uvcb) && uvcb.header.rc != UVC_RC_MORE_DATA)
 		return;
 
-	if (IS_ENABLED(CONFIG_KVM)) {
+	if (IS_ENABLED(CONFIG_KVM_S390)) {
 		memcpy(uv_info.inst_calls_list, uvcb.inst_calls_list, sizeof(uv_info.inst_calls_list));
 		uv_info.uv_base_stor_len = uvcb.uv_base_stor_len;
 		uv_info.guest_base_stor_len = uvcb.conf_base_phys_stor_len;
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 54637be87fb7..e9ad718a9408 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -63,7 +63,7 @@ CONFIG_IOMMUFD=y
 CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_S390_HYPFS_FS=y
-CONFIG_KVM=m
+CONFIG_KVM_S390=m
 CONFIG_KVM_S390_UCONTROL=y
 CONFIG_S390_UNWIND_SELFTEST=m
 CONFIG_S390_KPROBES_SANITY_TEST=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 5f5114a253cf..327ab4a3933c 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -61,7 +61,7 @@ CONFIG_IOMMUFD=y
 CONFIG_CMM=m
 CONFIG_APPLDATA_BASE=y
 CONFIG_S390_HYPFS_FS=y
-CONFIG_KVM=m
+CONFIG_KVM_S390=m
 CONFIG_S390_UNWIND_SELFTEST=m
 CONFIG_S390_KPROBES_SANITY_TEST=m
 CONFIG_S390_MODULES_SANITY_TEST=m
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index b27239c03d79..464f8918d447 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -57,7 +57,7 @@ decompressor_handled_param(cmma);
 decompressor_handled_param(relocate_lowcore);
 decompressor_handled_param(bootdebug);
 __decompressor_handled_param(debug_alternative, debug-alternative);
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 decompressor_handled_param(prot_virt);
 #endif
 
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 79a45efae23d..9572620fcaa6 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -113,7 +113,7 @@ _LPP_OFFSET	= __LC_LPP
 		    "jnz .+8; .insn rrf,0xb2e80000,0,0,13,0", ALT_SPEC(82)
 	.endm
 
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 	.macro SIEEXIT sie_control,lowcore
 	lg	%r9,\sie_control			# get control block pointer
 	ni	__SIE_PROG0C+3(%r9),0xfe		# no longer in SIE
@@ -184,7 +184,7 @@ EXPORT_SYMBOL(__WARN_trap)
 
 #endif /* CONFIG_BUG && CONFIG_CC_HAS_ASM_IMMEDIATE_STRINGS */
 
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 /*
  * __sie64a calling convention:
  * %r2 pointer to sie control block phys
@@ -315,7 +315,7 @@ SYM_CODE_START(pgm_check_handler)
 	xgr	%r10,%r10
 	tmhh	%r8,0x0001		# coming from user space?
 	jo	3f			# -> fault in user space
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 	lg	%r11,__LC_CURRENT(%r13)
 	tm	__TI_sie(%r11),0xff
 	jz	1f
@@ -397,7 +397,7 @@ SYM_CODE_START(\name)
 	lmg	%r8,%r9,\lc_old_psw(%r13)
 	tmhh	%r8,0x0001			# interrupting from user ?
 	jnz	1f
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 	lg	%r10,__LC_CURRENT(%r13)
 	tm	__TI_sie(%r10),0xff
 	jz	0f
@@ -475,7 +475,7 @@ SYM_CODE_START(mcck_int_handler)
 	jnz	.Lmcck_user
 	TSTMSK	__LC_MCCK_CODE(%r13),MCCK_CODE_PSW_IA_VALID
 	jno	.Lmcck_panic
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 	lg	%r10,__LC_CURRENT(%r13)
 	tm	__TI_sie(%r10),0xff
 	jz	.Lmcck_user
diff --git a/arch/s390/kernel/perf_event.c b/arch/s390/kernel/perf_event.c
index 606750bae508..6441746b8e72 100644
--- a/arch/s390/kernel/perf_event.c
+++ b/arch/s390/kernel/perf_event.c
@@ -37,7 +37,7 @@ static bool is_in_guest(struct pt_regs *regs)
 {
 	if (user_mode(regs))
 		return false;
-#if IS_ENABLED(CONFIG_KVM)
+#if IS_ENABLED(CONFIG_KVM_S390)
 	return instruction_pointer(regs) == (unsigned long) &sie_exit;
 #else
 	return false;
diff --git a/arch/s390/kvm/Kconfig b/arch/s390/kvm/Kconfig
index 51646b067935..f8d4a9a38dae 100644
--- a/arch/s390/kvm/Kconfig
+++ b/arch/s390/kvm/Kconfig
@@ -16,6 +16,9 @@ menuconfig VIRTUALIZATION
 
 if VIRTUALIZATION
 
+config KVM
+	tristate
+
 source "arch/s390/kvm/s390/Kconfig"
 
 endif # VIRTUALIZATION
diff --git a/arch/s390/kvm/Makefile b/arch/s390/kvm/Makefile
index a4e3875b5bdd..c43d7dffca13 100644
--- a/arch/s390/kvm/Makefile
+++ b/arch/s390/kvm/Makefile
@@ -3,4 +3,4 @@
 #
 # Copyright IBM Corp. 2008
 
-obj-$(CONFIG_KVM) += s390/
+obj-$(CONFIG_KVM_S390) += s390/
diff --git a/arch/s390/kvm/s390/Kconfig b/arch/s390/kvm/s390/Kconfig
index 62d65de3878d..bacfa1a48446 100644
--- a/arch/s390/kvm/s390/Kconfig
+++ b/arch/s390/kvm/s390/Kconfig
@@ -1,12 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 
-config KVM
+config KVM_S390
 	def_tristate y
 	prompt "Kernel-based Virtual Machine (KVM) support (s390)"
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select KVM_ASYNC_PF
 	select KVM_ASYNC_PF_SYNC
 	select KVM_COMMON
+	select KVM
 	select HAVE_KVM_IRQCHIP
 	select HAVE_KVM_IRQ_ROUTING
 	select HAVE_KVM_INVALID_WAKEUPS
@@ -30,7 +31,7 @@ config KVM
 
 config KVM_S390_UCONTROL
 	bool "Userspace controlled virtual machines"
-	depends on KVM
+	depends on KVM_S390
 	help
 	  Allow CAP_SYS_ADMIN users to create KVM virtual machines that are
 	  controlled by userspace.
diff --git a/arch/s390/kvm/s390/Makefile b/arch/s390/kvm/s390/Makefile
index de7deb81e655..354cb4c52635 100644
--- a/arch/s390/kvm/s390/Makefile
+++ b/arch/s390/kvm/s390/Makefile
@@ -11,4 +11,4 @@ kvm-y += diag.o gaccess.o guestdbg.o vsie.o pv.o
 
 kvm-$(CONFIG_VFIO_PCI_ZDEV_KVM) += pci.o
 
-obj-$(CONFIG_KVM) += kvm.o
+obj-$(CONFIG_KVM_S390) += kvm.o
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7a5e2797db7f..050aca8a8ff4 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1541,7 +1541,7 @@ void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu);
 void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu);
 
-#ifndef CONFIG_S390
+#ifndef CONFIG_KVM_S390
 void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait);
 
 static inline void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
-- 
2.53.0

