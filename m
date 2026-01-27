Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC4933BBDF
	for <linux-s390@vger.kernel.org>; Tue, 27 Jan 2026 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769541536; cv=none; b=HZnevrBQ5loXKJu9QJ0GM+qsfigpfp2KrZ5X2VHREi7qMoGRra+HjwcSe5vQBBrshIMruOKsbCaYoWO1uaOwHI3AWH7cXCxhcJM9Vm1jO4dKuq/HipQjPhBndaxz2wwMiGaXIsd+8f1gBZC1JUcFhuCgPTw/99eOxWp1U8sDhDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769541536; c=relaxed/simple;
	bh=6wCl/uGDdAxwNuwGhTFeLBr37I6ykNnRVaX8dgkMG+g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OG1AxXvLRmYoJQGMOyq+fUIEgZkRe7Dp2OKQlXcu0S9YvCrLVj+G4lonMSFCc+fuopkNApfIQ/DeLGwbL5XvlFPZfOiM+GB5gUoKRIBuK+1SHw5oKS3NOFz2gfGx7J+UF4CfkqjMJMirgaTmqBLTedPF7MDtZWusWuFe5j5Uj3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZdBznfLs; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZdBznfLs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769541534; x=1801077534;
  h=date:from:to:cc:subject:message-id;
  bh=6wCl/uGDdAxwNuwGhTFeLBr37I6ykNnRVaX8dgkMG+g=;
  b=ZdBznfLs1KLUjVZUkDgSXWz/BfgC8y3TqNPsaujnZTOC78v9pzn6BDnn
   43GB17Aq+6FMvQCXIXVDs3TC2jhWWSPly7E1h9nlF3o3WYoMITlvID/wq
   EP9bbCjf28up/nKwE0X5vPFd3UYgBQ0LB81ElZMX35XzDfIg5Yq+Hnn0p
   cCySRc7IjvbsGbo86mOLakwKfso9Z5SsekVC/si6tYSylW3u9QDMTVKIZ
   Yx0C+2Xl9mTd9at5dJgd+aQqPk4AtEZQSTUecgv+STjkatWNah969YEfP
   YtmUfwWzMtR0sVt5rG0KhAF39dugROZWtZHx2sgAYiYaZJs2ZFeIrZLfO
   Q==;
X-CSE-ConnectionGUID: JyXvQ9J0Stuiv07BR27VuA==
X-CSE-MsgGUID: nikzIfe5SNGZO+kf6CMI8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70648988"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70648988"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 11:18:53 -0800
X-CSE-ConnectionGUID: bYObomZkTDWY/5GHpB/wFA==
X-CSE-MsgGUID: Nl6PzGUITHCzlnztrfQbSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="245678980"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 Jan 2026 11:18:52 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkoaP-00000000YsU-1tj6;
	Tue, 27 Jan 2026 19:18:49 +0000
Date: Wed, 28 Jan 2026 03:18:27 +0800
From: kernel test robot <lkp@intel.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>
Subject: [s390:for-next 19/27] lib/bug.c:190:22: warning: diagnostic
 behavior may be improved by adding the 'format(printf, 1, 0)' attribute to
 the declaration of '__warn_printf'
Message-ID: <202601280339.1xH8iSrP-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-next
head:   d06f05df104d3cefd48cbf8d2eb76b8e73f39ae1
commit: 04dabb4261c387318affbdb22c15c31138a989f5 [19/27] s390/bug: Implement __WARN_printf()
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20260128/202601280339.1xH8iSrP-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 9b8addffa70cee5b2acc5454712d9cf78ce45710)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260128/202601280339.1xH8iSrP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601280339.1xH8iSrP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/bug.c:190:22: warning: diagnostic behavior may be improved by adding the 'format(printf, 1, 0)' attribute to the declaration of '__warn_printf' [-Wmissing-format-attribute]
     179 | static void __warn_printf(const char *fmt, struct pt_regs *regs)
         | __attribute__((format(printf, 1, 0))) 
     180 | {
     181 |         if (!fmt)
     182 |                 return;
     183 | 
     184 | #ifdef HAVE_ARCH_BUG_FORMAT_ARGS
     185 |         if (regs) {
     186 |                 struct arch_va_list _args;
     187 |                 va_list *args = __warn_args(&_args, regs);
     188 | 
     189 |                 if (args) {
     190 |                         vprintk(fmt, *args);
         |                                           ^
   lib/bug.c:179:13: note: '__warn_printf' declared here
     179 | static void __warn_printf(const char *fmt, struct pt_regs *regs)
         |             ^
   1 warning generated.


vim +190 lib/bug.c

7664c5a1da4711 Jeremy Fitzhardinge 2006-12-08  175  
d36067d6ea0082 Brendan Jackman     2025-12-07  176  __diag_push();
d36067d6ea0082 Brendan Jackman     2025-12-07  177  __diag_ignore(GCC, all, "-Wsuggest-attribute=format",
d36067d6ea0082 Brendan Jackman     2025-12-07  178  	      "Not a valid __printf() conversion candidate.");
5c47b7f3d1a9d7 Peter Zijlstra      2025-06-07  179  static void __warn_printf(const char *fmt, struct pt_regs *regs)
d292dbb5640c5b Peter Zijlstra      2025-06-02  180  {
d292dbb5640c5b Peter Zijlstra      2025-06-02  181  	if (!fmt)
d292dbb5640c5b Peter Zijlstra      2025-06-02  182  		return;
d292dbb5640c5b Peter Zijlstra      2025-06-02  183  
5c47b7f3d1a9d7 Peter Zijlstra      2025-06-07  184  #ifdef HAVE_ARCH_BUG_FORMAT_ARGS
5c47b7f3d1a9d7 Peter Zijlstra      2025-06-07  185  	if (regs) {
5c47b7f3d1a9d7 Peter Zijlstra      2025-06-07  186  		struct arch_va_list _args;
5c47b7f3d1a9d7 Peter Zijlstra      2025-06-07  187  		va_list *args = __warn_args(&_args, regs);
5c47b7f3d1a9d7 Peter Zijlstra      2025-06-07  188  
5c47b7f3d1a9d7 Peter Zijlstra      2025-06-07  189  		if (args) {
5c47b7f3d1a9d7 Peter Zijlstra      2025-06-07 @190  			vprintk(fmt, *args);
5c47b7f3d1a9d7 Peter Zijlstra      2025-06-07  191  			return;
5c47b7f3d1a9d7 Peter Zijlstra      2025-06-07  192  		}
5c47b7f3d1a9d7 Peter Zijlstra      2025-06-07  193  	}
5c47b7f3d1a9d7 Peter Zijlstra      2025-06-07  194  #endif
5c47b7f3d1a9d7 Peter Zijlstra      2025-06-07  195  
d292dbb5640c5b Peter Zijlstra      2025-06-02  196  	printk("%s", fmt);
d292dbb5640c5b Peter Zijlstra      2025-06-02  197  }
d36067d6ea0082 Brendan Jackman     2025-12-07  198  __diag_pop();
d292dbb5640c5b Peter Zijlstra      2025-06-02  199  

:::::: The code at line 190 was first introduced by commit
:::::: 5c47b7f3d1a9d7589026a201abb8ad445f029246 bug: Add BUG_FORMAT_ARGS infrastructure

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Peter Zijlstra <peterz@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
