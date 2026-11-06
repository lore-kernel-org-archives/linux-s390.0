Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996746;
	b=QYNSaRDtKn8/r+7LVI2uAqR5w5Z0wxmhY8kr8SI49saRuCs67kusYwJjHXo6HM8tZMuW
	 fdhYuRXpyESKYTmkr7eMhWHGdsPgnjITbfOsvrDvrb4R/oYU31jVMr4lFlU814vox5ac8
	 BwuVQxU0K5x3nkRfnQaWojCIQxFrgStuM/4lxVh0DoyGjZV/TCpbaE9+cT9HSNNng6EVz
	 W0C4D7gnTCHM5uOYlsmQryeFgEDZAQN+tyg1FZzNXOI1CBwDjXEu7CsXJwkmrRK0F9SUt
	 jaU/P/Whottd7s/RkrGOGLeaIPZlT6a6bhl0DabORb8wK/AmYA8aYyyKRVMs8Ruh9Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996746;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=QhFcsLLnB++mo2/a0YhVaJp8wkFEnypJf3lEJtNyqsc=;
	b=ZSi30DnsZZTMshBswQLmQFXVQ88uSL6/XFwQTapgNAB6aPNuuwoer8gAsYoXnDfY3K69
	 l9zuRpw3+pWCeV45efuLhzVPurp3X3eibGx4vi4tWXO61IgQn68DIUpHGr1wsBeK58sbV
	 RHNDPkxJ+pXhokUYOYNjN8Jyzc5WEmzzxebgepCo/N6gXtR4XbK5bgLEHfCfEDLUcDjZZ
	 Z3uTtjikcvFSxExcA2qVKdIOzpXjcEEcW4F2v8nksMBlpCtrEhZWs8MJWIRU78ItlyZz4
	 6lysSIYhQk+7KvN8Ad2XmwN3/2qXUe4hDj3HEDEfJjIDEebsGIPNonSzh4t1QtQKmgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cJj2qcXY;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC322606A329
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 20:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC322606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cJj2qcXY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793996744; x=1825532744;
  h=date:from:to:cc:subject:message-id;
  bh=nNz9siGQ5XNEw53eICMoL5n3Mo5gr5t+NPlX6tMefnw=;
  b=cJj2qcXYAatAeiuOI7RwXruuVJ8ngm7QyHGuEr8a6McqtIuW/hXTEH7L
   KACjj46gOeeHY4XAGO0pGjZFYglMyrHlYdYen4Bq9UBnTSLMo28t+ZECd
   JIPuOuDAsEQhsCWL+4XEm+t+dXQbYIIb9kUK6T7qRJj/bgHlKhLuwK8E9
   5+yJz1hpGlW8EmtbueASSwzVnjsmSpxD3LUML3yRiyMosUnmiLc/k4tso
   Mj4hMuMfuhmE0KFZNmPDV+lWVHRSSWqST7WFHObEojU9BMORS6/WaMN2z
   WYjAVZX7Z36lfqEVu6TGCfI+qF3DJdNHpjO4BPqECHeS238ZfB2R05MuB
   Q==;
X-CSE-ConnectionGUID: wDBm2qCeRqmmgmUuRLJ3pQ==
X-CSE-MsgGUID: YNZFgLNxTWixKqddMzcmuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2852792"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2852792"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 12:25:43 -0800
X-CSE-ConnectionGUID: PSyru8BgS+G1ZCTVQm+MXA==
X-CSE-MsgGUID: +6jh/7vlSWWC/Y3hj3aDXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7486537"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 06 Nov 2026 12:25:41 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPQVG-00000000ALv-0eAM;
	Fri, 06 Nov 2026 20:25:38 +0000
Date: Fri, 06 Nov 2026 21:25:23 +0100
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
 Andreas Grapentin <gra@linux.ibm.com>
Subject: [kvms390:sae 21/28] arch/s390/kvm/arm64/sys_regs.c:505:9:
 sparse: sparse: Initializer entry defined twice
Message-ID: <202611062149.5NgzRi9H-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae
head:   2abfa741008fd96c3684c316a2f5f37d3bb7bd8b
commit: 7625efa0418c385c0f90a900730b85209a04dcce [21/28] KVM: s390: arm64: Implement arm sysreg managing infrastructure
config: s390-randconfig-r2307-20261106 (https://download.01.org/0day-ci/archive/20261106/202611062149.5NgzRi9H-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
sparse: v0.6.5-rc1-21-g84ec0658
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611062149.5NgzRi9H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611062149.5NgzRi9H-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/s390/kvm/arm64/sys_regs.c:505:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:505:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:506:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:506:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:507:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:507:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:508:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:508:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:509:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:509:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:510:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:510:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:511:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:511:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:512:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:512:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:515:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:515:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:516:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:516:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:517:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:517:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:518:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:518:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:519:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:519:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:520:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:520:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:521:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:521:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:522:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:522:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:525:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:525:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:526:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:526:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:527:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:527:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:528:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:528:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:529:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:529:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:530:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:530:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:531:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:531:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:532:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:532:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:536:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:536:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:541:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:541:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:549:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:549:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:554:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:554:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:556:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:556:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:557:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:557:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:573:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:573:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:579:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:579:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:580:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:580:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:581:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:581:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:582:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:582:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:583:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:583:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:584:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:584:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:596:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:596:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:597:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:597:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:598:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:598:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:599:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:599:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:602:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:602:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:608:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:608:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:616:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:616:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:617:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:617:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:618:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:618:9: sparse:   also defined here
   arch/s390/kvm/arm64/sys_regs.c:669:9: sparse: sparse: Initializer entry defined twice
   arch/s390/kvm/arm64/sys_regs.c:669:9: sparse:   also defined here

vim +505 arch/s390/kvm/arm64/sys_regs.c

   475	
   476	/*
   477	 * Architected system registers.
   478	 * Important: Must be sorted ascending by Op0, Op1, CRn, CRm, Op2
   479	 */
   480	static const struct sys_reg_desc sys_reg_descs[] = {
   481		/* Op0 = 2 */
   482		{ SYS_DESC(SYS_MDSCR_EL1), access_rw, reset_val, MDSCR_EL1, 0 },
   483		{ SYS_DESC(SYS_OSLAR_EL1), trap_oslar_el1 },
   484		{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1, reset_oslsr_el1, OSLSR_EL1,
   485		  OSLSR_EL1_OSLM_IMP, NULL, set_oslsr_el1 },
   486	
   487		/* Op0 = 3 */
   488		/* Op1 = 0 */
   489		/* CRn = 0 */
   490		/* CRm = 0 */
   491	
   492		{ SYS_DESC(SYS_MIDR_EL1), NULL, reset_midr, 0, GENMASK_ULL(31, 0),
   493		  get_id_reg, set_imp_id_reg },
   494		{ SYS_DESC(SYS_MPIDR_EL1), NULL, reset_mpidr, MPIDR_EL1, 0, get_mpidr,
   495		  set_mpidr },
   496		IMPLEMENTATION_ID(REVIDR_EL1, GENMASK_ULL(63, 0)),
   497	
   498		/*
   499		 * ID regs: all ID_SANITISED() entries here must have corresponding
   500		 * entries in arm64_ftr_regs[].
   501		 */
   502	
   503		/* AArch64 mappings of the AArch32 ID registers */
   504		/* CRm=1 */
 > 505		ID_HIDDEN(ID_PFR0_EL1),
   506		ID_HIDDEN(ID_PFR1_EL1),
   507		ID_HIDDEN(ID_DFR0_EL1),
   508		ID_HIDDEN(ID_AFR0_EL1),
   509		ID_HIDDEN(ID_MMFR0_EL1),
   510		ID_HIDDEN(ID_MMFR1_EL1),
   511		ID_HIDDEN(ID_MMFR2_EL1),
   512		ID_HIDDEN(ID_MMFR3_EL1),
   513	
   514		/* CRm=2 */
   515		ID_HIDDEN(ID_ISAR0_EL1),
   516		ID_HIDDEN(ID_ISAR1_EL1),
   517		ID_HIDDEN(ID_ISAR2_EL1),
   518		ID_HIDDEN(ID_ISAR3_EL1),
   519		ID_HIDDEN(ID_ISAR4_EL1),
   520		ID_HIDDEN(ID_ISAR5_EL1),
   521		ID_HIDDEN(ID_MMFR4_EL1),
   522		ID_HIDDEN(ID_ISAR6_EL1),
   523	
   524		/* CRm=3 */
   525		ID_HIDDEN(MVFR0_EL1),
   526		ID_HIDDEN(MVFR1_EL1),
   527		ID_HIDDEN(MVFR2_EL1),
   528		ID_UNALLOCATED(3, 3),
   529		ID_HIDDEN(ID_PFR2_EL1),
   530		ID_HIDDEN(ID_DFR1_EL1),
   531		ID_HIDDEN(ID_MMFR5_EL1),
   532		ID_UNALLOCATED(3, 7),
   533	
   534		/* AArch64 ID registers */
   535		/* CRm=4 */
   536		ID_FILTERED(ID_AA64PFR0_EL1, id_aa64pfr0_el1,
   537			    ~(ID_AA64PFR0_EL1_AMU | ID_AA64PFR0_EL1_MPAM |
   538			      ID_AA64PFR0_EL1_SVE | ID_AA64PFR0_EL1_RAS |
   539			      ID_AA64PFR0_EL1_GIC | ID_AA64PFR0_EL1_AdvSIMD |
   540			      ID_AA64PFR0_EL1_FP)),
   541		ID_FILTERED(ID_AA64PFR1_EL1, id_aa64pfr1_el1,
   542			    ~(ID_AA64PFR1_EL1_PFAR | ID_AA64PFR1_EL1_DF2 |
   543			      ID_AA64PFR1_EL1_MTEX | ID_AA64PFR1_EL1_THE |
   544			      ID_AA64PFR1_EL1_GCS | ID_AA64PFR1_EL1_MTE_frac |
   545			      ID_AA64PFR1_EL1_NMI | ID_AA64PFR1_EL1_RNDR_trap |
   546			      ID_AA64PFR1_EL1_SME | ID_AA64PFR1_EL1_RES0 |
   547			      ID_AA64PFR1_EL1_MPAM_frac | ID_AA64PFR1_EL1_RAS_frac |
   548			      ID_AA64PFR1_EL1_MTE)),
   549		ID_FILTERED(ID_AA64PFR2_EL1, id_aa64pfr2_el1,
   550			    (ID_AA64PFR2_EL1_FPMR		|
   551			     ID_AA64PFR2_EL1_MTEFAR		|
   552			     ID_AA64PFR2_EL1_MTESTOREONLY	|
   553			     ID_AA64PFR2_EL1_GCIE)),
   554		ID_UNALLOCATED(4, 3),
   555		ID_WRITABLE(ID_AA64ZFR0_EL1, ~ID_AA64ZFR0_EL1_RES0),
   556		ID_HIDDEN(ID_AA64SMFR0_EL1),
   557		ID_UNALLOCATED(4, 6),
   558		ID_WRITABLE(ID_AA64FPFR0_EL1, ~ID_AA64FPFR0_EL1_RES0),
   559	
   560		/* CRm=5 */
   561		/*
   562		 * Prior to FEAT_Debugv8.9, the architecture defines context-aware
   563		 * breakpoints (CTX_CMPs) as the highest numbered breakpoints (BRPs).
   564		 * KVM does not trap + emulate the breakpoint registers, and as such
   565		 * cannot support a layout that misaligns with the underlying hardware.
   566		 * While it may be possible to describe a subset that aligns with
   567		 * hardware, just prevent changes to BRPs and CTX_CMPs altogether for
   568		 * simplicity.
   569		 *
   570		 * See DDI0487K.a, section D2.8.3 Breakpoint types and linking
   571		 * of breakpoints for more details.
   572		 */
   573		ID_FILTERED(ID_AA64DFR0_EL1, id_aa64dfr0_el1,
   574			    ID_AA64DFR0_EL1_DoubleLock_MASK |
   575				    ID_AA64DFR0_EL1_WRPs_MASK |
   576				    ID_AA64DFR0_EL1_PMUVer_MASK |
   577				    ID_AA64DFR0_EL1_DebugVer_MASK),
   578		ID_SANITISED(ID_AA64DFR1_EL1),
   579		ID_UNALLOCATED(5, 2),
   580		ID_UNALLOCATED(5, 3),
   581		ID_HIDDEN(ID_AA64AFR0_EL1),
   582		ID_HIDDEN(ID_AA64AFR1_EL1),
   583		ID_UNALLOCATED(5, 6),
   584		ID_UNALLOCATED(5, 7),
   585	
   586		/* CRm=6 */
   587		ID_WRITABLE(ID_AA64ISAR0_EL1, ~ID_AA64ISAR0_EL1_RES0),
   588		ID_WRITABLE(ID_AA64ISAR1_EL1,
   589			    ~(ID_AA64ISAR1_EL1_GPI | ID_AA64ISAR1_EL1_GPA |
   590			      ID_AA64ISAR1_EL1_API | ID_AA64ISAR1_EL1_APA)),
   591		ID_WRITABLE(ID_AA64ISAR2_EL1,
   592			    ~(ID_AA64ISAR2_EL1_RES0 | ID_AA64ISAR2_EL1_APA3 |
   593			      ID_AA64ISAR2_EL1_GPA3)),
   594		ID_WRITABLE(ID_AA64ISAR3_EL1,
   595			    (ID_AA64ISAR3_EL1_FPRCVT | ID_AA64ISAR3_EL1_FAMINMAX)),
   596		ID_UNALLOCATED(6, 4),
   597		ID_UNALLOCATED(6, 5),
   598		ID_UNALLOCATED(6, 6),
   599		ID_UNALLOCATED(6, 7),
   600	
   601		/* CRm=7 */
   602		ID_FILTERED(ID_AA64MMFR0_EL1, id_aa64mmfr0_el1,
   603			    ~(ID_AA64MMFR0_EL1_RES0 | ID_AA64MMFR0_EL1_ASIDBITS)),
   604		ID_WRITABLE(ID_AA64MMFR1_EL1,
   605			    ~(ID_AA64MMFR1_EL1_RES0 | ID_AA64MMFR1_EL1_HCX |
   606			      ID_AA64MMFR1_EL1_TWED | ID_AA64MMFR1_EL1_XNX |
   607			      ID_AA64MMFR1_EL1_VH | ID_AA64MMFR1_EL1_VMIDBits)),
   608		ID_FILTERED(ID_AA64MMFR2_EL1, id_aa64mmfr2_el1,
   609			    ~(ID_AA64MMFR2_EL1_RES0 | ID_AA64MMFR2_EL1_EVT |
   610			      ID_AA64MMFR2_EL1_FWB | ID_AA64MMFR2_EL1_IDS |
   611			      ID_AA64MMFR2_EL1_NV | ID_AA64MMFR2_EL1_CCIDX)),
   612		ID_WRITABLE(ID_AA64MMFR3_EL1,
   613			    (ID_AA64MMFR3_EL1_TCRX | ID_AA64MMFR3_EL1_S1PIE |
   614			     ID_AA64MMFR3_EL1_S1POE)),
   615		ID_WRITABLE(ID_AA64MMFR4_EL1, ID_AA64MMFR4_EL1_NV_frac),
   616		ID_UNALLOCATED(7, 5),
   617		ID_UNALLOCATED(7, 6),
   618		ID_UNALLOCATED(7, 7),
   619	
   620		/* CRn = 1 */
   621		{ SYS_DESC(SYS_SCTLR_EL1), NULL, reset_val, SCTLR_EL1, 0x00C50078 },
   622		{ SYS_DESC(SYS_ACTLR_EL1), access_rw, reset_val, ACTLR_EL1, 0 },
   623		{ SYS_DESC(SYS_CPACR_EL1), NULL, reset_val, CPACR_EL1, 0 },
   624		{ SYS_DESC(SYS_ZCR_EL1), NULL, reset_val, ZCR_EL1, 0,
   625		  .visibility = sve_visibility },
   626	
   627		/* CRn = 2 */
   628		{ SYS_DESC(SYS_TTBR0_EL1), access_rw, reset_val, TTBR0_EL1, 0 },
   629		{ SYS_DESC(SYS_TTBR1_EL1), access_rw, reset_val, TTBR1_EL1, 0 },
   630		{ SYS_DESC(SYS_TCR_EL1), access_rw, reset_val, TCR_EL1, 0 },
   631	
   632		/* CRn = 5 */
   633		{ SYS_DESC(SYS_AFSR0_EL1), access_rw, reset_unknown, AFSR0_EL1 },
   634		{ SYS_DESC(SYS_AFSR1_EL1), access_rw, reset_unknown, AFSR1_EL1 },
   635		{ SYS_DESC(SYS_ESR_EL1), access_rw, reset_unknown, ESR_EL1 },
   636		/* CRn = 6 */
   637		{ SYS_DESC(SYS_FAR_EL1), access_rw, reset_unknown, FAR_EL1 },
   638		/* CRn = 7 */
   639		{ SYS_DESC(SYS_PAR_EL1), access_rw, reset_unknown, PAR_EL1 },
   640	
   641		{ SYS_DESC(SYS_PMMIR_EL1), trap_raz_wi },
   642		/* CRn = 10 */
   643		{ SYS_DESC(SYS_MAIR_EL1), NULL, reset_unknown, MAIR_EL1 },
   644		{ SYS_DESC(SYS_LORSA_EL1), trap_loregion },
   645		{ SYS_DESC(SYS_LOREA_EL1), trap_loregion },
   646		{ SYS_DESC(SYS_LORN_EL1), trap_loregion },
   647		{ SYS_DESC(SYS_LORC_EL1), trap_loregion },
   648		{ SYS_DESC(SYS_LORID_EL1), trap_loregion },
   649	
   650		/* CRn = 12 */
   651		{ SYS_DESC(SYS_VBAR_EL1), access_rw, reset_val, VBAR_EL1, 0 },
   652	
   653		/* CRn = 13 */
   654		{ SYS_DESC(SYS_CONTEXTIDR_EL1), access_rw, reset_val, CONTEXTIDR_EL1, 0 },
   655		{ SYS_DESC(SYS_TPIDR_EL1), NULL, reset_unknown, TPIDR_EL1 },
   656		{ SYS_DESC(SYS_SCXTNUM_EL1), access_rw, reset_unknown, SCXTNUM_EL1 },
   657	
   658		/* CRn = 14 */
   659		{ SYS_DESC(SYS_CNTKCTL_EL1), access_rw, reset_val, CNTKCTL_EL1, 0 },
   660	
   661		/* Op1 = 1 */
   662		/* CRn = 0 */
   663		/* CRm = 0 */
   664		{ SYS_DESC(SYS_CCSIDR_EL1), access_ccsidr },
   665		{ SYS_DESC(SYS_CLIDR_EL1), access_clidr, reset_clidr, CLIDR_EL1,
   666		  ~CLIDR_EL1_RES0, .set_user = set_clidr },
   667		IMPLEMENTATION_ID(AIDR_EL1, GENMASK_ULL(63, 0)),
   668		{ SYS_DESC(SYS_CSSELR_EL1), access_csselr, reset_unknown, CSSELR_EL1 },
   669		ID_FILTERED(CTR_EL0, ctr_el0,
   670			    CTR_EL0_DIC_MASK | CTR_EL0_IDC_MASK |
   671				    CTR_EL0_DminLine_MASK | CTR_EL0_L1Ip_MASK |
   672				    CTR_EL0_IminLine_MASK),
   673	
   674		/* Op1 = 3 */
   675		/* CRn = 13 */
   676		{ SYS_DESC(SYS_TPIDR_EL0), access_rw, reset_unknown, TPIDR_EL0 },
   677		{ SYS_DESC(SYS_TPIDRRO_EL0), access_rw, reset_unknown, TPIDRRO_EL0 },
   678		{ SYS_DESC(SYS_SCXTNUM_EL0), access_rw, reset_unknown, SCXTNUM_EL0 },
   679	
   680		{ SYS_DESC(SYS_CNTFRQ_EL0), NULL, reset_cntfrq, CNTFRQ_EL0, .set_user = set_cntfrq },
   681		{ SYS_DESC(SYS_CNTPCT_EL0), .get_user = arch_timer_get_user,
   682		  .set_user = arch_timer_set_user },
   683		{ SYS_DESC(SYS_CNTVCT_EL0), .get_user = arch_timer_get_user,
   684		  .set_user = arch_timer_set_user },
   685		GUEST_TIMER_REG(CNTP_CTL_EL0),
   686		GUEST_TIMER_REG(CNTP_CVAL_EL0),
   687		GUEST_TIMER_REG(CNTV_CTL_EL0),
   688		GUEST_TIMER_REG(CNTV_CVAL_EL0),
   689	};
   690	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
