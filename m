Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3AC1BB6B8;
	Mon,  7 Oct 2024 12:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728305335; cv=none; b=m/8fD/To49r9ClfzA1O9c7eB3zNTINL25qdisd+4tw2LAetdLTZNLD8ZxVgi8NwovKCShQz3pNfkyxf8KuWf1RvCYxc15v7zocLJCLg9ncyXmDG58UleUPLODklWF+gQY+OnOF+OTBuHP6DkUmmaffSe0l15EwUdqraES+Ag8TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728305335; c=relaxed/simple;
	bh=XWgabam3fhc3PvpjHHnnru1mmimtxFrWT467mkfuww0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqDr3G8mAdijQibrGSab4TuiN4ezcvtV8RAgR5WXAaO7i6milAHYNpizfLFbccGtggcvoO70BLxLeg4KUfLGpDGFzGch2DAyBxeFPwx40cjQQsUWc5e2L86c7YFDFXSuwO4fCd01Ld3tBgEWsWOWL0OeeNZlG7qn7hHjbSXwGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XS3xWXlD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XS3xWXlD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728305335; x=1759841335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XWgabam3fhc3PvpjHHnnru1mmimtxFrWT467mkfuww0=;
  b=XS3xWXlDE9ZlxLVMeGD7SEIq+Kqd1lIUIZXM0S995f4n9RxjZRiSLFdp
   MGxtkUo/qX1yqTOacf2lSD8uaQ/buL15eWzzBrnxt8VbeBRMIMchIpW7k
   /3rSYQ5LzGsbAp+kh79d4XVwOO3HhqBeaMu3fKPxHAE7M5tFFWnBeT2EH
   GPu75DMSHpoF0UQWsJTmHGfgZKkACsSF75C6tBe6CN3agjheZCzmmvKmM
   pg0KV1PTW/RqcdcvH9ZsAfg0kjEljAqP8hPL4gjLFNB4r3Bw0x83cVWT3
   ULkL2SrYAzY+KiMUzw4ty7lUNFKhbeXyyM7hlcTSW453iOSDUBV/SfyFl
   w==;
X-CSE-ConnectionGUID: rnGGckzESDWIRRiffUPziQ==
X-CSE-MsgGUID: E6/UXZ0LTMujkUF3fMLS5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="31152294"
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="31152294"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 05:48:54 -0700
X-CSE-ConnectionGUID: bP6fMKj0RnyrWoAmPTX4GQ==
X-CSE-MsgGUID: rdegqp39TlWWvVoSaAoULg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,184,1725346800"; 
   d="scan'208";a="80055132"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Oct 2024 05:48:50 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sxnAO-0004z2-0K;
	Mon, 07 Oct 2024 12:48:48 +0000
Date: Mon, 7 Oct 2024 20:48:42 +0800
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
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, danielyangkang@gmail.com,
	syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] resolve gtp possible deadlock warning
Message-ID: <202410072002.hT2D7135-lkp@intel.com>
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
config: x86_64-buildonly-randconfig-005-20241007 (https://download.01.org/0day-ci/archive/20241007/202410072002.hT2D7135-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241007/202410072002.hT2D7135-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410072002.hT2D7135-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/smc/af_smc.c:22:9: warning: 'pr_fmt' macro redefined [-Wmacro-redefined]
      22 | #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
         |         ^
   include/linux/printk.h:380:9: note: previous definition is here
     380 | #define pr_fmt(fmt) fmt
         |         ^
   1 warning generated.


vim +/pr_fmt +22 net/smc/af_smc.c

ac7138746e1413 Ursula Braun 2017-01-09 @22  #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
ac7138746e1413 Ursula Braun 2017-01-09  23  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
