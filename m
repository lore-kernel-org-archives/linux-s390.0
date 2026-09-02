Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBDF3290AA
	for <linux-s390@vger.kernel.org>; Wed,  2 Sep 2026 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788324971; cv=none; b=oaTCO9dhpLhFw0K1V9JYCZqJ2xI6UqEasA33kzPLQlDpO1omzUPe7WBZ0Mddh3E9pbgFgFbnnDxQV1DNx6TTyvQbrk0o5NoV677dCmI845D9CYoUczFU0mKuBKxP/6YobxTr7qPD462ODCaCCHCmDAnpByl86EHrRDtbYFQvJfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788324971; c=relaxed/simple;
	bh=jf92SOcjeY4XA1Wr57medPafuxi1ZcHXYjjRhHvWP7k=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TN+eHg/YvM3uWBQj5mieBtLMsYjRDeraOpq1yCJCnljgxn75Xtc7sjeq2XG3SN+HgKcSEdidoZSS4plTGnSUSAht086Q2i+Xd3g8fj94rLfV3ifHEsYS45hBZen9cuCiR4X3lW+rbyV/dML4ah7jX/rNk8+mHfbM8gTPUuubdXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QFn+YcST; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QFn+YcST"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788324969; x=1819860969;
  h=date:from:to:cc:subject:message-id;
  bh=jf92SOcjeY4XA1Wr57medPafuxi1ZcHXYjjRhHvWP7k=;
  b=QFn+YcSTcKxHccq4rk/pEj+atfb2aYXQuJgBAigXFbJb/kWh2TdLjg3t
   w5Vk1CBFA8aaUrZvEtkolHsjcmXDy9q0vAQ0cajXL9cxXFvtY7YlNCa15
   IS/splnNvb0jSP3hXEqEnfHDA58upbNmLVTtYJotoQJwoWpH3J906g3od
   q5tAxzcoNFLYoH/a8qWN4EDP/qrwdHGgRJph2l/WP9sTPCrNHP4uQ3h/n
   ZQccvN71fiOktl6pVVHRsLwdGk3/X/6DW+/5kOoWA1s8xtD+gUdTJKhRk
   z0sMCjmbPQuEVfZU9VgvMgvURswoz7hV1pIhT1jHZZEHdExVhp2P+D1oF
   A==;
X-CSE-ConnectionGUID: YjExgjd7SNyHEze2KPkHDw==
X-CSE-MsgGUID: JwTI2H3kSS+fn366Pc43Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87909920"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="87909920"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 21:56:08 -0700
X-CSE-ConnectionGUID: C9LIlCWrQxG5167ohCuovQ==
X-CSE-MsgGUID: dV70D0pVQxmwtKn6F94gqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="294124870"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 01 Sep 2026 21:56:06 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1d11-00000000208-1tnu;
	Wed, 02 Sep 2026 04:56:03 +0000
Date: Wed, 02 Sep 2026 12:55:48 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-s390@vger.kernel.org
Subject: [kvms390:sae 36/43] <instantiation>:1:36: error: too many
 positional arguments
Message-ID: <202609021240.EJLfb3WZ-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae
head:   e3cbc45b3834d68c7e45ba1562f45af312c99d81
commit: abcde5421be2b45c53e0e9516108ff610fdadf80 [36/43] KVM: s390: arm64: Implement arm sysreg managing infrastructure
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260902/202609021240.EJLfb3WZ-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 678058af7da6a20593d8bb23076dc4773f9e55f1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260902/202609021240.EJLfb3WZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609021240.EJLfb3WZ-lkp@intel.com/

All errors (new ones prefixed by >>):

         |                     ^~~~~~~~~~
   <scratch space>:160:1: note: expanded from here
     160 | set_id_aa64mmfr2_el1
         | ^~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:582:2: note: previous initialization is here
     582 |         ID_FILTERED(ID_AA64MMFR2_EL1, id_aa64mmfr2_el1,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     583 |                     ~(ID_AA64MMFR2_EL1_RES0 | ID_AA64MMFR2_EL1_EVT |
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     584 |                       ID_AA64MMFR2_EL1_FWB | ID_AA64MMFR2_EL1_IDS |
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     585 |                       ID_AA64MMFR2_EL1_NV | ID_AA64MMFR2_EL1_CCIDX)),
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:917:2: note: expanded from macro 'ID_FILTERED'
     917 |         ID_DESC(sysreg),                                \
         |         ^~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:890:2: note: expanded from macro 'ID_DESC'
     890 |         ID_DESC_DEFAULT_CALLBACKS
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:884:14: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     884 |         .set_user = set_id_reg,                 \
         |                     ^~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:590:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     590 |         ID_UNALLOCATED(7, 5),
         |         ^~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:931:16: note: expanded from macro 'ID_UNALLOCATED'
     931 |         .visibility = raz_visibility,                   \
         |                       ^~~~~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:590:2: note: previous initialization is here
     590 |         ID_UNALLOCATED(7, 5),
         |         ^~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:930:2: note: expanded from macro 'ID_UNALLOCATED'
     930 |         ID_DESC_DEFAULT_CALLBACKS,                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:885:16: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     885 |         .visibility = id_visibility,            \
         |                       ^~~~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:591:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     591 |         ID_UNALLOCATED(7, 6),
         |         ^~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:931:16: note: expanded from macro 'ID_UNALLOCATED'
     931 |         .visibility = raz_visibility,                   \
         |                       ^~~~~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:591:2: note: previous initialization is here
     591 |         ID_UNALLOCATED(7, 6),
         |         ^~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:930:2: note: expanded from macro 'ID_UNALLOCATED'
     930 |         ID_DESC_DEFAULT_CALLBACKS,                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:885:16: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     885 |         .visibility = id_visibility,            \
         |                       ^~~~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:592:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     592 |         ID_UNALLOCATED(7, 7),
         |         ^~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:931:16: note: expanded from macro 'ID_UNALLOCATED'
     931 |         .visibility = raz_visibility,                   \
         |                       ^~~~~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:592:2: note: previous initialization is here
     592 |         ID_UNALLOCATED(7, 7),
         |         ^~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:930:2: note: expanded from macro 'ID_UNALLOCATED'
     930 |         ID_DESC_DEFAULT_CALLBACKS,                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:885:16: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     885 |         .visibility = id_visibility,            \
         |                       ^~~~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:626:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     626 |         ID_FILTERED(CTR_EL0, ctr_el0,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     627 |                     CTR_EL0_DIC_MASK | CTR_EL0_IDC_MASK |
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     628 |                             CTR_EL0_DminLine_MASK | CTR_EL0_L1Ip_MASK |
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     629 |                             CTR_EL0_IminLine_MASK),
         |                             ~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:918:14: note: expanded from macro 'ID_FILTERED'
     918 |         .set_user = set_##name,                         \
         |                     ^~~~~~~~~~
   <scratch space>:204:1: note: expanded from here
     204 | set_ctr_el0
         | ^~~~~~~~~~~
   arch/s390/kvm/arm64/sys_regs.c:626:2: note: previous initialization is here
     626 |         ID_FILTERED(CTR_EL0, ctr_el0,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     627 |                     CTR_EL0_DIC_MASK | CTR_EL0_IDC_MASK |
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     628 |                             CTR_EL0_DminLine_MASK | CTR_EL0_L1Ip_MASK |
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     629 |                             CTR_EL0_IminLine_MASK),
         |                             ~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:917:2: note: expanded from macro 'ID_FILTERED'
     917 |         ID_DESC(sysreg),                                \
         |         ^~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:890:2: note: expanded from macro 'ID_DESC'
     890 |         ID_DESC_DEFAULT_CALLBACKS
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/arm64/generated/sys_regs.inc:884:14: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     884 |         .set_user = set_id_reg,                 \
         |                     ^~~~~~~~~~
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16255, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16255,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16110, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16110,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -32750, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-32750,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -15616, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-15616,0
         |                 ^
   <instantiation>:1:35: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -8573, 0,
         |                                   ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-8573,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -15728, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-15728,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -14713, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-14713,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16109, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16109,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -32628, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-32628,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16240, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16240,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16256, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16256,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16120, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16120,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -14584, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-14584,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -14848, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-14848,0
         |                 ^
   <instantiation>:1:35: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -8574, 0,
         |                                   ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-8574,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16119, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16119,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16103, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16103,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -15736, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-15736,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -15735, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-15735,0
         |                 ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   47 warnings and 20 errors generated.
--
         |                     ^~~~~~~~~~
   <scratch space>:160:1: note: expanded from here
     160 | set_id_aa64mmfr2_el1
         | ^~~~~~~~~~~~~~~~~~~~
   sys_regs.c:582:2: note: previous initialization is here
     582 |         ID_FILTERED(ID_AA64MMFR2_EL1, id_aa64mmfr2_el1,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     583 |                     ~(ID_AA64MMFR2_EL1_RES0 | ID_AA64MMFR2_EL1_EVT |
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     584 |                       ID_AA64MMFR2_EL1_FWB | ID_AA64MMFR2_EL1_IDS |
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     585 |                       ID_AA64MMFR2_EL1_NV | ID_AA64MMFR2_EL1_CCIDX)),
         |                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:917:2: note: expanded from macro 'ID_FILTERED'
     917 |         ID_DESC(sysreg),                                \
         |         ^~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:890:2: note: expanded from macro 'ID_DESC'
     890 |         ID_DESC_DEFAULT_CALLBACKS
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:884:14: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     884 |         .set_user = set_id_reg,                 \
         |                     ^~~~~~~~~~
   sys_regs.c:590:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     590 |         ID_UNALLOCATED(7, 5),
         |         ^~~~~~~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:931:16: note: expanded from macro 'ID_UNALLOCATED'
     931 |         .visibility = raz_visibility,                   \
         |                       ^~~~~~~~~~~~~~
   sys_regs.c:590:2: note: previous initialization is here
     590 |         ID_UNALLOCATED(7, 5),
         |         ^~~~~~~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:930:2: note: expanded from macro 'ID_UNALLOCATED'
     930 |         ID_DESC_DEFAULT_CALLBACKS,                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:885:16: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     885 |         .visibility = id_visibility,            \
         |                       ^~~~~~~~~~~~~
   sys_regs.c:591:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     591 |         ID_UNALLOCATED(7, 6),
         |         ^~~~~~~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:931:16: note: expanded from macro 'ID_UNALLOCATED'
     931 |         .visibility = raz_visibility,                   \
         |                       ^~~~~~~~~~~~~~
   sys_regs.c:591:2: note: previous initialization is here
     591 |         ID_UNALLOCATED(7, 6),
         |         ^~~~~~~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:930:2: note: expanded from macro 'ID_UNALLOCATED'
     930 |         ID_DESC_DEFAULT_CALLBACKS,                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:885:16: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     885 |         .visibility = id_visibility,            \
         |                       ^~~~~~~~~~~~~
   sys_regs.c:592:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     592 |         ID_UNALLOCATED(7, 7),
         |         ^~~~~~~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:931:16: note: expanded from macro 'ID_UNALLOCATED'
     931 |         .visibility = raz_visibility,                   \
         |                       ^~~~~~~~~~~~~~
   sys_regs.c:592:2: note: previous initialization is here
     592 |         ID_UNALLOCATED(7, 7),
         |         ^~~~~~~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:930:2: note: expanded from macro 'ID_UNALLOCATED'
     930 |         ID_DESC_DEFAULT_CALLBACKS,                      \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:885:16: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     885 |         .visibility = id_visibility,            \
         |                       ^~~~~~~~~~~~~
   sys_regs.c:626:2: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
     626 |         ID_FILTERED(CTR_EL0, ctr_el0,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     627 |                     CTR_EL0_DIC_MASK | CTR_EL0_IDC_MASK |
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     628 |                             CTR_EL0_DminLine_MASK | CTR_EL0_L1Ip_MASK |
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     629 |                             CTR_EL0_IminLine_MASK),
         |                             ~~~~~~~~~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:918:14: note: expanded from macro 'ID_FILTERED'
     918 |         .set_user = set_##name,                         \
         |                     ^~~~~~~~~~
   <scratch space>:204:1: note: expanded from here
     204 | set_ctr_el0
         | ^~~~~~~~~~~
   sys_regs.c:626:2: note: previous initialization is here
     626 |         ID_FILTERED(CTR_EL0, ctr_el0,
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     627 |                     CTR_EL0_DIC_MASK | CTR_EL0_IDC_MASK |
         |                     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     628 |                             CTR_EL0_DminLine_MASK | CTR_EL0_L1Ip_MASK |
         |                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     629 |                             CTR_EL0_IminLine_MASK),
         |                             ~~~~~~~~~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:917:2: note: expanded from macro 'ID_FILTERED'
     917 |         ID_DESC(sysreg),                                \
         |         ^~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:890:2: note: expanded from macro 'ID_DESC'
     890 |         ID_DESC_DEFAULT_CALLBACKS
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   ./generated/sys_regs.inc:884:14: note: expanded from macro 'ID_DESC_DEFAULT_CALLBACKS'
     884 |         .set_user = set_id_reg,                 \
         |                     ^~~~~~~~~~
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16255, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16255,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16110, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16110,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -32750, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-32750,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -15616, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-15616,0
         |                 ^
   <instantiation>:1:35: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -8573, 0,
         |                                   ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-8573,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -15728, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-15728,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -14713, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-14713,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16109, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16109,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -32628, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-32628,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16240, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16240,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16256, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16256,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16120, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16120,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -14584, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-14584,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -14848, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-14848,0
         |                 ^
   <instantiation>:1:35: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -8574, 0,
         |                                   ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-8574,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16119, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16119,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -16103, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-16103,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -15736, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-15736,0
         |                 ^
>> <instantiation>:1:36: error: too many positional arguments
       1 | RIE_H 0xed9b, %r2, %r12, -15735, 0,
         |                                    ^
   arch/s390/include/asm/sae.h:74:3: note: while in macro instantiation
      74 |                 "       EASR    %[r1],%[r3],%[i2],%[m4]\n"
         |                 ^
   <inline asm>:1:3: note: instantiated into assembly here
       1 |                 EASR    %r2,%r12,-15735,0
         |                 ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   47 warnings and 20 errors generated.

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
