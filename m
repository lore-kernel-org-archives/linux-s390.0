Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2091534E6;
	Mon,  7 Oct 2024 11:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728302214; cv=none; b=jCOIqsJCCoS0JPy7Kayt64TSQ7X2tMMzZKgx+3jUfTeLw1rWoq1luDmG/opnKn2bBVS/ifWkzJBpHifQtJ71fUbKGXaarx3lNvoyqUmyVf/6lpKpQ85JESCuFRioqRf5Oxrrovq0KDHj5fOE6eoRfROMpRZOhCHjsi3T1CEM1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728302214; c=relaxed/simple;
	bh=e/hYXfaMp9AxjhYF6SyFGgQP6z/DT34maWpVHJiBtBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb+d16VORfzPT228bt+5BPhM6ry14cWpzh3sbdP5wzYDm8bL1yG3Seq1MlQdYFL+Preurs9Z4HKQJwJKUwwqPlvt9IaxeUtBrR0kxctDHTQzjCJNAuJnvo76g4uQ5MIM3mAEATCbCfyRH+6+nNKY7r7eWsUjcZY/Nk6hgloiy5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzQIEgMj; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzQIEgMj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728302212; x=1759838212;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e/hYXfaMp9AxjhYF6SyFGgQP6z/DT34maWpVHJiBtBQ=;
  b=MzQIEgMj5SmpxnjeaIgiiGRCPQfhP1qRK1QN22ShfY+awz+t2fJG+Bgk
   mW9MXxSfVd1HsTrWn+m0Xt60EtJuvkYmR87o4645Lhx70Hvit8JNjlokP
   jI+9RC6P5JD80UI9sE2TFllzB1hPI19Di1FpHboMp0Stam/MayJHOtCWN
   hRv6t0Wh1UTWvS2fBNwdlVtcZXn2Kl2ptgLHmfGsmZhMaTxVwmJdmrb/S
   u40PGy0cPy3Bp+234bS8AldzqtF6Uwj0BA1aGrw4ZRZsmFVLw0cwfJdH8
   tz/7So0lfMyiFAodxW/a6pTMc5Ihvwy0nCb1Dd/UjM+jY80uCvMEE1uk+
   A==;
X-CSE-ConnectionGUID: xJxgttXeR3KkmTdpYmOxRQ==
X-CSE-MsgGUID: vxqVLmOQTL6X37XK36ICvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11217"; a="31148596"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="31148596"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 04:56:51 -0700
X-CSE-ConnectionGUID: bHj2Lw4wStejy5l4Gyq+AQ==
X-CSE-MsgGUID: dIB0D4UzQgCgiz7EUB5jGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="75285451"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 07 Oct 2024 04:56:48 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxmM2-0004wy-07;
	Mon, 07 Oct 2024 11:56:46 +0000
Date: Mon, 7 Oct 2024 19:55:51 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Yang <danielyangkang@gmail.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	danielyangkang@gmail.com,
	syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] resolve gtp possible deadlock warning
Message-ID: <202410071937.ikrY4umF-lkp@intel.com>
References: <20241005045411.118720-1-danielyangkang@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241005045411.118720-1-danielyangkang@gmail.com>

Hi Daniel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.12-rc2 next-20241004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Yang/resolve-gtp-possible-deadlock-warning/20241005-125510
base:   linus/master
patch link:    https://lore.kernel.org/r/20241005045411.118720-1-danielyangkang%40gmail.com
patch subject: [PATCH v2] resolve gtp possible deadlock warning
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241007/202410071937.ikrY4umF-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241007/202410071937.ikrY4umF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410071937.ikrY4umF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/smc/af_smc.c:22:9: warning: "pr_fmt" redefined
      22 | #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
         |         ^~~~~~
   In file included from include/linux/kernel.h:31,
                    from include/linux/uio.h:8,
                    from include/linux/socket.h:8,
                    from net/smc/af_smc.c:20:
   include/linux/printk.h:380:9: note: this is the location of the previous definition
     380 | #define pr_fmt(fmt) fmt
         |         ^~~~~~

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/pr_fmt +22 net/smc/af_smc.c

ac7138746e1413 Ursula Braun 2017-01-09 @22  #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
ac7138746e1413 Ursula Braun 2017-01-09  23  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
