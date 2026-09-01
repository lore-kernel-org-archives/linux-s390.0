Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464A948986D
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284285; cv=none; b=UYDUK9P8pKzGXMCR+2TEM42/wJhGtrW3c3hc+6mUncyApNRMykSy1FJOy2+pqJGje71RVAWyUxFYbH5cpXl5rn3H21tfd1R2zNY86Hc0tEBlifCpypjDn2vP1EPpACHy2Dzu7KHzHPYe1W4q2UEJmifTVjXPPL2xoKWxGBYoMwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284285; c=relaxed/simple;
	bh=zLYAaP5GFzY+PsV4IeN/6hr8beE2sM5911bxHxD2+QM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KxFvgnP3+/6YUerlIE2wgucd3/1tUlHjuZ/+SFTDL9hX3afxfwQK9LugaPEr1NGGxRV8am5dKaq8+bcr7YzFI6qo8uTcnNlyxlroXKM0MmXEfgZQCH7ztqnNS86eZM18WbuIP1MKJKmfJKuGqO6jABOrn7OQKClpFzulIRHl/8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KRUEDRAq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KRUEDRAq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788284283; x=1819820283;
  h=date:from:to:cc:subject:message-id;
  bh=zLYAaP5GFzY+PsV4IeN/6hr8beE2sM5911bxHxD2+QM=;
  b=KRUEDRAqYpXAEpLrfK403g2G0s0bF6Pe5Mjiv5SsXKHbCH/hQXDFccUD
   oVbUAu28KWgYfn3SZrXt3tlPQpZfaJK/6/7U3ETOvRSzKeyTyWKGbG58n
   TA/PHnKc7GI+LeWNQEkYWtm7RFnciHSTi7JHcSQ4A3sy61cJQubIM2IzK
   6L3U9t1RO6xKJizHELEFU/ZYjjYz1ERCbx/AJMOg/k0w78mVeD5wHwYtS
   s5JlssNIB5leyNEanh/h9ByGfaAjmAahAXJKn7ik5nV4VrYdFytpU7Co8
   XzQYQ1A3+F0+qlZWwhq9le8uQInJO9NL9tqB9V0ssd5XnX44/wXo/1ag5
   A==;
X-CSE-ConnectionGUID: wveEtWuWROuQ1rEU935wdA==
X-CSE-MsgGUID: uHhT17mfSimW1JwSDpGaPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87863258"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="87863258"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 10:37:58 -0700
X-CSE-ConnectionGUID: WxF1J6DGSiOr6/CVF9quRw==
X-CSE-MsgGUID: 6IgSfiVTQrueuLyzWkEe8w==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 01 Sep 2026 10:37:56 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1SQj-000000001EZ-2aQd;
	Tue, 01 Sep 2026 17:37:53 +0000
Date: Wed, 02 Sep 2026 01:37:13 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
 Andreas Grapentin <gra@linux.ibm.com>,
 "Nina Schoetterl-Glausch" <nsg@linux.ibm.com>,
 Gautam Gala <ggala@linux.ibm.com>
Subject: [kvms390:sae 23/43] arch/s390/kvm/arm64/mmu.c:76:23:
 warning: variable 'esr' set but not used
Message-ID: <202609020104.1kohlgzl-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae
head:   e3cbc45b3834d68c7e45ba1562f45af312c99d81
commit: ab80750cee6e09e0036ac43f257059122a05a71d [23/43] KVM: s390: arm64: Add KVM_S390_ARM64 Kconfig and Makefile
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20260902/202609020104.1kohlgzl-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260902/202609020104.1kohlgzl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609020104.1kohlgzl-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/s390/kvm/arm64/mmu.c: In function 'kvm_handle_guest_abort':
>> arch/s390/kvm/arm64/mmu.c:76:23: warning: variable 'esr' set but not used [-Wunused-but-set-variable=]
      76 |         unsigned long esr;
         |                       ^~~


vim +/esr +76 arch/s390/kvm/arm64/mmu.c

b6715b85f7e1318 Steffen Eiden 2026-04-02  70  
b6715b85f7e1318 Steffen Eiden 2026-04-02  71  int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
b6715b85f7e1318 Steffen Eiden 2026-04-02  72  {
b6715b85f7e1318 Steffen Eiden 2026-04-02  73  	struct kvm_memory_slot *memslot;
b6715b85f7e1318 Steffen Eiden 2026-04-02  74  	bool translation = false;
b6715b85f7e1318 Steffen Eiden 2026-04-02  75  	phys_addr_t fault_ipa;
b6715b85f7e1318 Steffen Eiden 2026-04-02 @76  	unsigned long esr;

:::::: The code at line 76 was first introduced by commit
:::::: b6715b85f7e131823057ea487cb4d9985427beec KVM: s390: arm64: Implement basic page fault handler

:::::: TO: Steffen Eiden <seiden@linux.ibm.com>
:::::: CC: Steffen Eiden <seiden@linux.ibm.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
