Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656D121FF21
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 17:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607957; cv=none; b=EzwAd2H9AEVuStkRsCoHLvugdpMvqZdKpdYru1iUiP8OPaEMnmd0/D5Oi+DBnF8f6JvS/8nZUm6C4PgTo9z9GovgAqHeHjI+s1KN+zk/ZyJlpWrivlnH1pEVjwi9IOtnFb9eKKUkK41cseZpGFujgmbrGFW3PZXlnFdUMAkbUns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607957; c=relaxed/simple;
	bh=QMiOXftQsgE92WFbru5pfm4C24Knj1NQvy4huaRXetk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Vzf7XEMp1C3QyHvkVThCkWjaqyFY5H63hMjDM28edOonRoMMwYvHKQMgX8KPsMhQ0kNtA+TMCOyJ9JrOy8ksgRN05cbdz0s5qwe7KiA0dmdydNPazDIX7dsbjNltbDAsYPAqUHJuEPbpMrQQYdAVxnva4yWfICfV3caj9SFpTRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XQ3ZnKaM; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XQ3ZnKaM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778607955; x=1810143955;
  h=date:from:to:cc:subject:message-id;
  bh=QMiOXftQsgE92WFbru5pfm4C24Knj1NQvy4huaRXetk=;
  b=XQ3ZnKaMkbf0EvM08oSQUPcEg+542FOpiVx/pr9yPqSyJkpPsRo0Jilw
   Tt6bnsfW0KKu1DZiA+ckRSIKMKe8D6t4JBycC+egrTGxbYsvKcM79Hfy9
   35STvxr/U6E+gRRJGE1wyb3jQg94w0DU2/M3g26dHk4xq1Qc2fBT+LeVX
   q6gpQKSQ6wrQFUJInCmIr/+aW9/QSL+OQ0Sv3H/OO5Il55WyPnbUtdnNl
   CPvbUkZR5a4+Or/wU0dwPJ2NlNKlruOonjMgEdD2kNoRPg0E035aDeRw3
   36r4wETYoL6IKMZ2cBpbtkQCfHT0rXdUWIaINv5qyXZBUyEJZ1pbtnM2+
   g==;
X-CSE-ConnectionGUID: Fx/dEt76RFGRVLvR13Arag==
X-CSE-MsgGUID: nLAVG/m+T3OXcJ8QR5t60w==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79705744"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="79705744"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 10:45:54 -0700
X-CSE-ConnectionGUID: jA2zEmZfQJ2aCrij/ovo4Q==
X-CSE-MsgGUID: n2PYtZqJQS2KbNa78C+kSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="242181900"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 12 May 2026 10:45:53 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wMrAz-000000002Wx-28Xv;
	Tue, 12 May 2026 17:45:49 +0000
Date: Wed, 13 May 2026 01:45:03 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-s390@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
Subject: [kvms390:sae 2/54] arch/x86/kvm/svm/sev.c:117:27: error: no
 member named 'users_count' in 'struct kvm'
Message-ID: <202605130154.8hoiUlcD-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae
head:   e952fb65773b1e5cd2e5ca409e712db5ef252bb1
commit: 134336e0cba8dd18185738333bc26c1b0b020b6d [2/54] KVM, vfio: remove symbol_get(kvm_get_kvm_safe) from vfio
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20260513/202605130154.8hoiUlcD-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260513/202605130154.8hoiUlcD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605130154.8hoiUlcD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/x86/kvm/svm/sev.c:117:27: error: no member named 'users_count' in 'struct kvm'
     117 |         if (!refcount_read(&kvm->users_count))
         |                             ~~~  ^
   1 error generated.


vim +117 arch/x86/kvm/svm/sev.c

eaf78265a4ab339 Joerg Roedel        2020-03-24  109  
ba903f738249077 Sean Christopherson 2026-03-10  110  static __always_inline void kvm_lockdep_assert_sev_lock_held(struct kvm *kvm)
ba903f738249077 Sean Christopherson 2026-03-10  111  {
ba903f738249077 Sean Christopherson 2026-03-10  112  #ifdef CONFIG_PROVE_LOCKING
ba903f738249077 Sean Christopherson 2026-03-10  113  	/*
ba903f738249077 Sean Christopherson 2026-03-10  114  	 * Querying SEV+ support is safe if there are no other references, i.e.
ba903f738249077 Sean Christopherson 2026-03-10  115  	 * if concurrent initialization of SEV+ is impossible.
ba903f738249077 Sean Christopherson 2026-03-10  116  	 */
ba903f738249077 Sean Christopherson 2026-03-10 @117  	if (!refcount_read(&kvm->users_count))
ba903f738249077 Sean Christopherson 2026-03-10  118  		return;
ba903f738249077 Sean Christopherson 2026-03-10  119  
ba903f738249077 Sean Christopherson 2026-03-10  120  	/*
ba903f738249077 Sean Christopherson 2026-03-10  121  	 * Querying SEV+ support from vCPU context is always safe, as vCPUs can
ba903f738249077 Sean Christopherson 2026-03-10  122  	 * only be created after SEV+ is initialized (and KVM disallows all SEV
ba903f738249077 Sean Christopherson 2026-03-10  123  	 * sub-ioctls while vCPU creation is in-progress).
ba903f738249077 Sean Christopherson 2026-03-10  124  	 */
ba903f738249077 Sean Christopherson 2026-03-10  125  	if (kvm_get_running_vcpu())
ba903f738249077 Sean Christopherson 2026-03-10  126  		return;
ba903f738249077 Sean Christopherson 2026-03-10  127  
ba903f738249077 Sean Christopherson 2026-03-10  128  	lockdep_assert_held(&kvm->lock);
ba903f738249077 Sean Christopherson 2026-03-10  129  #endif
ba903f738249077 Sean Christopherson 2026-03-10  130  }
ba903f738249077 Sean Christopherson 2026-03-10  131  

:::::: The code at line 117 was first introduced by commit
:::::: ba903f7382490776d2df2fca6bf5c8ef2eb4663f KVM: SEV: Assert that kvm->lock is held when querying SEV+ support

:::::: TO: Sean Christopherson <seanjc@google.com>
:::::: CC: Sean Christopherson <seanjc@google.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
