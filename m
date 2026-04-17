Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC1238D6B1
	for <linux-s390@vger.kernel.org>; Fri, 17 Apr 2026 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776431334; cv=none; b=uwFvKrxlJnbAhTRQs4JF0TZK1U9zaFhBDk7QEY8CgdTXOq7efh3TfVsR7ddgphVa1SOctTdcqu+bvpKLhfd6cxfKdLo8LJN+9y2XAZS1ihi8OVnM6ET3zAvZszaRS1zvYlZmoMxFceRCMveWBibExLe8xAyHI5s1uPmzA0Qh/C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776431334; c=relaxed/simple;
	bh=6PSYpeiHptreFUSS8SAlG+Y/DSKJODD2AQRo7Rpwdds=;
	h=Date:From:To:Cc:Subject:Message-ID; b=K0QUd8vsYK7Mc94fK9oOOoT0ZHo6kGq/AccFJVuxclkVYTUr0bprDvuC+4RW6M66Tua3AdUTm4HwWxdismzuhd4jm+LC6BFhT8vt6PDwC1kocpGl2CMYlZepIeWYhJnVJ8kysRxgnrVm2nm/K0Q9LY9ubfNCLb892HEz701hS6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRmucmM9; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRmucmM9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776431333; x=1807967333;
  h=date:from:to:cc:subject:message-id;
  bh=6PSYpeiHptreFUSS8SAlG+Y/DSKJODD2AQRo7Rpwdds=;
  b=iRmucmM9zTO7W9lPX3snGaoGRB4TyhqZoi0hXr4T+KJgJmEPn5lrlE5j
   /lZ+JH2l57eMIziOKu2u9SBQpz5SMEKHTyhb+LXVKcNvqYJ07GDouRwOn
   mJDda2qVHX6IfqHjYl1+VkWiWg344zUTz6X5EViKdzFhPgAVJtWt4SWJf
   HAtNf5St6Tr3GD/wjTIDEFnf50w+Jl1QHfQj7eBl2DjRZID7QhvCmQO1Y
   0BX5z/x7c/Ze5Dq9906NvJ9apfY7GphZD8G9kJzDtBni4jQxeSs9Kf89k
   uvw+y9Q2vKPOM3m6ARYf45K/cxS34TG0pKjgBibU13swRqo2bwkrn49j7
   g==;
X-CSE-ConnectionGUID: Lg4hQWcVQ5ySd+evtIabvg==
X-CSE-MsgGUID: yqjJJOgWSvyin+9jBS8pnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="87746810"
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="87746810"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 06:08:53 -0700
X-CSE-ConnectionGUID: 7X2MwBsYSJCptEf5BWmOiQ==
X-CSE-MsgGUID: ZkbHolvCQ7enxYtCT8zulQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,184,1770624000"; 
   d="scan'208";a="230954002"
Received: from lkp-server01.sh.intel.com (HELO 7e48d0ff8e22) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 17 Apr 2026 06:08:51 -0700
Received: from kbuild by 7e48d0ff8e22 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDiwC-000000000NW-2FQp;
	Fri, 17 Apr 2026 13:08:48 +0000
Date: Fri, 17 Apr 2026 21:07:48 +0800
From: kernel test robot <lkp@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
 Steffen Eiden <seiden@linux.ibm.com>
Subject: [kvms390:sae-part1 1/27] Warning:
 drivers/vfio/vfio_main.c:1516 function parameter 'kvm_module' not described
 in 'vfio_file_set_kvm'
Message-ID: <202604172036.augJ2Yj2-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae-part1
head:   c8ef958593be02ec09131a1f5e2744a98b6c01a1
commit: 1846164a1854e4d1b047de7d300e3213eab53e5d [1/27] VFIO: take reference to the KVM module
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20260417/202604172036.augJ2Yj2-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260417/202604172036.augJ2Yj2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604172036.augJ2Yj2-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/vfio/vfio_main.c:1516 function parameter 'kvm_module' not described in 'vfio_file_set_kvm'
>> Warning: drivers/vfio/vfio_main.c:1516 function parameter 'kvm_module' not described in 'vfio_file_set_kvm'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
