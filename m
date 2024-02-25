Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E648748D
	for <linux-s390@vger.kernel.org>; Sun, 25 Feb 2024 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708888574; cv=none; b=jD/yH3LgfCub2TCjH9dwhxyk9Y5WaLjaIsadQhP0PGiZl9qUcQKan6Q9U4xZo+MD29DSgUgmVoMo9B4SfMdE4E8mzVs3nYYwwRhPrdRM3tTiseYjaJiTj1oTWP0B0HrlV4Q/n73AcVmgphuOcQZW7QWEOV/zIlP2IpSRotCIXw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708888574; c=relaxed/simple;
	bh=mdAf8wXvnUHSwBDrS3gsY7qZSZFEwB4VK+apMleUkhY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KNPI48d+ZWyo9EIKelCvcHjKNWf3Erlf6rY2gCMNNcX8jcovKALh22ndFB+Q3KyRG4J974N7bNVZDneS8XnmpwWtxi5ejHL5faom+CaQJcFYOKnnxxMwwpj+5UZiLTB8sWNao9hr3Gzm0ZvzQ9QMzag5C9kgPl3TVbujjaw9P+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EDfdaaK1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EDfdaaK1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708888573; x=1740424573;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mdAf8wXvnUHSwBDrS3gsY7qZSZFEwB4VK+apMleUkhY=;
  b=EDfdaaK19kM3TtNR54fzQtZSptQZj7nWPQkU+iy/1YhX+gAldmrSQxCQ
   glLWLV5KsZBJI3BEg/ZuPAvLa4I6nMFRrNRlAQethYTvyD9jplZYh6oim
   Qi5zbvKbjLWPZkeN3F0GcfWdJCJk76nAZ959mcd7rf7IAdgFAHKB0nC1Y
   J8zrezjt1mUuUhGX0x8v5bj84ylNj4LGEeJlslMwJ+hr01OHcRBeoGpL5
   +0T2We1pzCcRRVhAQra+GCsTwByY1+oFhoKVJhBniCo8fcv35H9AAFctI
   /EmpF9QfIQmkbfWxybE/k2569kdckVuvEqQZVJzEnqJtIgLFPjilL50p6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="13862987"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="13862987"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 11:16:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="11158441"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 25 Feb 2024 11:16:05 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1reJyk-0009kK-0e;
	Sun, 25 Feb 2024 19:16:02 +0000
Date: Mon, 26 Feb 2024 03:15:26 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [s390:features 97/102] arch/s390/boot/startup.c:180:5: sparse:
 sparse: symbol 'vmlinux_relocs_64_start' was not declared. Should it be
 static?
Message-ID: <202402260305.0Kp1dQiZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
head:   a795e5d2347def129734a7f247ac70339d50d8c2
commit: 778666df60f0d96f215e33e27448de47a2207fb3 [97/102] s390: compile relocatable kernel without -fPIE
config: s390-randconfig-r122-20240225 (https://download.01.org/0day-ci/archive/20240226/202402260305.0Kp1dQiZ-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project edd4aee4dd9b5b98b2576a6f783e4086173d902a)
reproduce: (https://download.01.org/0day-ci/archive/20240226/202402260305.0Kp1dQiZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402260305.0Kp1dQiZ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/s390/boot/startup.c:180:5: sparse: sparse: symbol 'vmlinux_relocs_64_start' was not declared. Should it be static?
>> arch/s390/boot/startup.c:181:5: sparse: sparse: symbol 'vmlinux_relocs_64_end' was not declared. Should it be static?

vim +/vmlinux_relocs_64_start +180 arch/s390/boot/startup.c

   175	
   176	static void kaslr_adjust_got(unsigned long offset) {}
   177	static void rescue_relocs(void) {}
   178	static void free_relocs(void) {}
   179	#else
 > 180	int *vmlinux_relocs_64_start;
 > 181	int *vmlinux_relocs_64_end;
   182	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
