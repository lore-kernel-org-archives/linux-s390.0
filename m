Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E825B08E
	for <linux-s390@vger.kernel.org>; Tue,  2 Jun 2026 20:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430427; cv=none; b=r9qbUJZm1LOtXLci6VVM9w9VvwpVa2CQ0fwVK7xZ2uv+SphewhSJ3z9P8ATZe933PRqvK7P9CWgEwX2puM4Dj5JSRk4oYOOLhq1O5JiWQyp2YDPeFWlVKShaxq5nUXkdqnph4Mfepkc8r0XWux2jQsGr4wNDAadiXmXDOeDuWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430427; c=relaxed/simple;
	bh=lK2diTQ7WYsqU69YLgP0pQMWQM951AyXllcoz3PSW0M=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kBWwuRromuKO2COU4r7TJZnjCI1IinXkjZAjCoQIvEE6YEzJQDE1MkXbv/KZXegrcrMj12vaKUAsAMJjrP2fO9JaxfaPZ6K40oXV4+rqMWbR27Ft5ZQEjKVcwkCoEP1goTC/eHrm5WNrIsmHVUBLGDtg9fWh4uG/Pzf9qDRR/Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ir06JiKr; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ir06JiKr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780430426; x=1811966426;
  h=date:from:to:cc:subject:message-id;
  bh=lK2diTQ7WYsqU69YLgP0pQMWQM951AyXllcoz3PSW0M=;
  b=ir06JiKriu0bPxntnaEgtlVbwV6EwyMR82YpVH81BWbO4zJf5vrm3CO2
   CU6fcTKTqft82atWi3giDgaJXNhIvnJWzxyHGeA1k1SwHtHTpt7qEntpS
   MG4Mly8ST3hxzJrlmskpFVMV9GaLpl293+gWtOnA1RxsUNT/o9kIzwuYm
   70nnqIwg9SXLOxWGXohcwwK3ZXZ3WssTjomd3GCc5gFu+B7WTwC3zE3Bd
   cyDe00aQ1w4g2D/qtrMo+nHsEXmJQuLPpt6zqsXG+YoSmc8XeXQlduQRf
   n0LfVnXEee0gGzRVFU45VMG+sbw59bA8NPfy05YdATCIvdKx8Y1vz3/Il
   w==;
X-CSE-ConnectionGUID: Z1PCYZt/SDGZs53oOvFloA==
X-CSE-MsgGUID: qcLf8E4oQ8CUfAWfHKO+iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="83810264"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="83810264"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 13:00:25 -0700
X-CSE-ConnectionGUID: ZW0gpInKSXi96I/SWwPwJQ==
X-CSE-MsgGUID: SyYqsr0eR7SUEf6HZb+cHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="239839814"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 02 Jun 2026 13:00:23 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wUVHh-00000000CT8-0oTj;
	Tue, 02 Jun 2026 20:00:21 +0000
Date: Wed, 03 Jun 2026 03:59:33 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
 Andreas Grapentin <gra@linux.ibm.com>,
 "Nina Schoetterl-Glausch" <nsg@linux.ibm.com>,
 Gautam Gala <ggala@linux.ibm.com>
Subject: [kvms390:sae 27/53] arch/s390/kvm/arm64/mmu.c:77:23:
 warning: variable 'esr' set but not used
Message-ID: <202606030330.XgpQG5Zh-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae
head:   f33dbafc8623f6c22ac90428a03f29019940b157
commit: 4095afb932d1a98a6fcb3f4f490964949d0de338 [27/53] KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20260603/202606030330.XgpQG5Zh-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260603/202606030330.XgpQG5Zh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606030330.XgpQG5Zh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/s390/kvm/arm64/mmu.c: In function 'kvm_handle_guest_abort':
>> arch/s390/kvm/arm64/mmu.c:77:23: warning: variable 'esr' set but not used [-Wunused-but-set-variable]
      77 |         unsigned long esr;
         |                       ^~~


vim +/esr +77 arch/s390/kvm/arm64/mmu.c

d39977ecf998d3 Steffen Eiden 2026-04-02  71  
d39977ecf998d3 Steffen Eiden 2026-04-02  72  int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
d39977ecf998d3 Steffen Eiden 2026-04-02  73  {
d39977ecf998d3 Steffen Eiden 2026-04-02  74  	struct kvm_memory_slot *memslot;
d39977ecf998d3 Steffen Eiden 2026-04-02  75  	bool translation = false;
d39977ecf998d3 Steffen Eiden 2026-04-02  76  	phys_addr_t fault_ipa;
d39977ecf998d3 Steffen Eiden 2026-04-02 @77  	unsigned long esr;

:::::: The code at line 77 was first introduced by commit
:::::: d39977ecf998d3a0991112c03c9bc91d739b2e14 KVM: s390: arm64: Implement basic page fault handler

:::::: TO: Steffen Eiden <seiden@linux.ibm.com>
:::::: CC: Steffen Eiden <seiden@linux.ibm.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
