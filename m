Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D384324B0A;
	Wed, 10 Dec 2025 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765372220; cv=none; b=Uj/tqF091J4GTN4kL2YTKpww1SBw4MB6LjkDpXV+ej7gcqmIWIm6dsGbuXBd9vaPc3DWYoTiyxruYHinxAbeh1ERX/qreIzPZlQ5slVtgY/3UtcYXKdqiyIrqksFLU9uB0PWp/g3D7nSy7J7ZBRIJYH7HIvx8kPcd0/pWgeaXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765372220; c=relaxed/simple;
	bh=QAidEA//GkJT7W2g7BriSWgjYhM81oSbVaSAiKnI1Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7eAQdRlzcaFrog6A5+fIxX151ZIVJ3J/EgahqBjLnMWwiG0a6VQFpq7yNzoPQg1giljQg96ePoZq/w75WwvE6B84gqs4oS2qcsmemCqvXmDQzLjNU3HjEpShnGw6KR4tetgnIc3koau/ar/vqQVey9TE2tUeWGwf8b3r81KSNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxCesqKn; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxCesqKn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765372219; x=1796908219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QAidEA//GkJT7W2g7BriSWgjYhM81oSbVaSAiKnI1Eo=;
  b=UxCesqKnOjzT+CFY/TIx/xECiTfIqIGr7t3Uen7rCErP7hqvEIEzmHPQ
   PbAo2POByH3nrTl7OvBzb4p9Zfjt5qjNfZCtVZGy4MKKu4a6rASFXuuyp
   tLnkhys4PPTmSWsNFnE7/sfqvPLzJip+4N6BREVdHZww2QvAZz+y32opO
   DHlQpXoP/P8JTGOKLX4rvNU7W3/Y0qf8Q4LREmAOruDT/1RJGAdWgC/OO
   4twqm5jmTQxAH2IgGmhcH2xV6Ad2k/w9LikEToFqBGmN84OmU6KCTtuRV
   r6viz1bIjwKWzUcxpB2yTamzivwQwMZJt/VG1U+tGDHE91Dfx+oJu5A9X
   A==;
X-CSE-ConnectionGUID: 3Y1f7UjdTJeKQ6kFHCymaQ==
X-CSE-MsgGUID: xrTFlptsSueX5wnQoOdn+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="70964480"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="70964480"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 05:10:18 -0800
X-CSE-ConnectionGUID: +AV3EDH7Qi+YI2FEUHqjdg==
X-CSE-MsgGUID: pySygRGfSAuUui8Q8gMp7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="196109294"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Dec 2025 05:10:15 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTJxM-000000003Cr-43sL;
	Wed, 10 Dec 2025 13:10:12 +0000
Date: Wed, 10 Dec 2025 21:09:17 +0800
From: kernel test robot <lkp@intel.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
	Jens Remus <jremus@linux.ibm.com>,
	Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
	Juergen Christ <jchrist@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH 6/9] s390/bug: Implement __WARN_printf()
Message-ID: <202512102049.3FCpsgLh-lkp@intel.com>
References: <20251209121701.1856271-7-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209121701.1856271-7-hca@linux.ibm.com>

Hi Heiko,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 70075e3d0ca0b72cc983d03f7cd9796e43492980]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiko-Carstens/kbuild-Require-gcc-9-for-s390/20251209-202647
base:   70075e3d0ca0b72cc983d03f7cd9796e43492980
patch link:    https://lore.kernel.org/r/20251209121701.1856271-7-hca%40linux.ibm.com
patch subject: [PATCH 6/9] s390/bug: Implement __WARN_printf()
config: s390-randconfig-r062-20251210 (https://download.01.org/0day-ci/archive/20251210/202512102049.3FCpsgLh-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251210/202512102049.3FCpsgLh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512102049.3FCpsgLh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> arch/s390/kernel/traps.c:224:26: warning: 'struct arch_va_list' declared inside parameter list will not be visible outside of this definition or declaration
     224 | void *__warn_args(struct arch_va_list *args, struct pt_regs *regs)
         |                          ^~~~~~~~~~~~
>> arch/s390/kernel/traps.c:224:7: warning: no previous prototype for '__warn_args' [-Wmissing-prototypes]
     224 | void *__warn_args(struct arch_va_list *args, struct pt_regs *regs)
         |       ^~~~~~~~~~~
   arch/s390/kernel/traps.c: In function '__warn_args':
   arch/s390/kernel/traps.c:243:13: error: invalid use of undefined type 'struct arch_va_list'
     243 |         args->__overflow_arg_area = stack_frame + 1;
         |             ^~
   arch/s390/kernel/traps.c:244:13: error: invalid use of undefined type 'struct arch_va_list'
     244 |         args->__reg_save_area = regs->gprs;
         |             ^~
   arch/s390/kernel/traps.c:245:13: error: invalid use of undefined type 'struct arch_va_list'
     245 |         args->__gpr = 1;
         |             ^~


vim +224 arch/s390/kernel/traps.c

   223	
 > 224	void *__warn_args(struct arch_va_list *args, struct pt_regs *regs)
   225	{
   226		struct stack_frame *stack_frame;
   227	
   228		/*
   229		 * Generate va_list from pt_regs. See ELF Application Binary Interface
   230		 * s390x Supplement documentation for details.
   231		 *
   232		 * - __overflow_arg_area needs to point to the parameter area, which
   233		 *   is right above the standard stack frame (160 bytes)
   234		 *
   235		 * - __reg_save_area needs to point to a register save area where
   236		 *   general registers (%r2 - %r6) can be found at offset 16. Which
   237		 *   means that the gprs save area of pt_regs can be used
   238		 *
   239		 * - __gpr must be set to one, since the first parameter has been
   240		 *   processed (pointer to bug_entry)
   241		 */
   242		stack_frame = (struct stack_frame *)regs->gprs[15];
   243		args->__overflow_arg_area = stack_frame + 1;
   244		args->__reg_save_area = regs->gprs;
   245		args->__gpr = 1;
   246		return args;
   247	}
   248	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
