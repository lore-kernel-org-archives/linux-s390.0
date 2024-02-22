Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16056FBE
	for <linux-s390@vger.kernel.org>; Thu, 22 Feb 2024 06:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708585007; cv=none; b=dg0Y6Nm2hUHdklVYH0axW2YDXkS0vG1hwTQQug+rbbd0dDM1HQzWmYKj0Wdx0Xzm4hUy8EoGUYWPDVg4qKllF+GbOaXDZTHnkZ9SbcXMrHjlFdXZN/Ge5BCY2lWSzBbUKEvYs2AMwF3WIkwLYHQDNKrGNK60WDsqL59QVQsI+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708585007; c=relaxed/simple;
	bh=UrnIyP5J6FZk/SauAMa776NEQujzaCpwGwWr45hwrRs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NtwGLhPScFUh1xfsHeKSRzcc2cTA8C5bKXMHVALvdXXz697gElxGR3w/llVUVtmQAvoEO+Oz2I9ebNMVAmspcAFzsvVGNTVqOLnpbhH0VCB9VbFNOHj/BdJXyjS7z8Z/x9GLa/RzEGbS7DD3L9pI+bbxJWR4O+eHX1JrY0qsJO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jyN4HCHu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jyN4HCHu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708585006; x=1740121006;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UrnIyP5J6FZk/SauAMa776NEQujzaCpwGwWr45hwrRs=;
  b=jyN4HCHupv3gLPZFchIDBCs1rZeJ6rKSy/0q35KogL8wNwNYPBfNsTjh
   7HFhtIH4JAmTQqcR469/Q9sgA80LRu2xc6V7UlZrbuhlOEoQ2bFKvygyl
   8/8Eh0GHenOFAWPTLeu+tL1w4CNynoXTpecvxdVYlrPgrANfdJw7HhYFc
   NkDZo1wZx2LRjliM80M0v5FoXHuue2ZeC/JkxAuHw+HQYRXsyi58KnRh4
   v+gcB2kq7rzz80duwOc+cXNqGPat3akWEPHoh7dTgqKQ3fXpw7Yv5g1cQ
   vk+LD1ykxXsV75L5bwT7stDuUSneVsXDnTAzNQMOUQ5ecpZucYp9MoIqs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="20341761"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="20341761"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 22:56:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10078885"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 21 Feb 2024 22:56:43 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rd2y2-00063W-1w;
	Thu, 22 Feb 2024 06:55:54 +0000
Date: Thu, 22 Feb 2024 14:42:01 +0800
From: kernel test robot <lkp@intel.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Sumanth Korikkar <sumanthk@linux.ibm.com>
Subject: [s390:features 97/98] Unsupported relocation type: 21
Message-ID: <202402221404.T2TGs8El-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
head:   4a5993287467d2d0401503256dc9d2690c7f2020
commit: 778666df60f0d96f215e33e27448de47a2207fb3 [97/98] s390: compile relocatable kernel without -fPIE
config: s390-randconfig-002-20231016 (https://download.01.org/0day-ci/archive/20240222/202402221404.T2TGs8El-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240222/202402221404.T2TGs8El-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402221404.T2TGs8El-lkp@intel.com/

All errors (new ones prefixed by >>):

>> Unsupported relocation type: 21

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
