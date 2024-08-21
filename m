Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052706FA8;
	Wed, 21 Aug 2024 00:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724199972; cv=none; b=B3H+avXwIj/oJi6LHHj7os5uu67GJH3YeH1Gzyx6X7Ql8AwxX8773CPgxBf+whY6Q8WFi7hXQuz0H1S7q2fsULu94nio2Uu767PTZYqgha2duoZIvwnA5HTtX2dk18R8Yp+2zRrBuZ7OM3Tco6eQ0vEE4gu9AUTZJCP20cNieLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724199972; c=relaxed/simple;
	bh=CJIRiNwm7uwI5y07ByutZfo3/ptSFwLJ4eprJVUi6t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfQioPgS62356Pv9Xd3vUUbJ6jWQ7m2WReSSMHeH8xy1JPVBFcqhamISxMynqCcp6K24YK8e9w+KKmC+GiB4pOAtSWE7WjJ7hmQHKq9af1JatT2SgSd2Y08sEr4ykHpoDGPHkIYaNqZiAm33X45NpURUeCI63JbcwPq8apUFRZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Igx0vuc6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Igx0vuc6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724199971; x=1755735971;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CJIRiNwm7uwI5y07ByutZfo3/ptSFwLJ4eprJVUi6t4=;
  b=Igx0vuc6nhor1FbnNMo+L3wr85x1/eLDMOMjTdXOTvvsjuj+Rm7uy/DT
   ufYMREo42Fbd1VrKJqq0EPs7wWJk9yKtEIwn2oEgfmht53fXlHGbSuwRv
   IlrnCLthoOjrbN8sSs71Hsg3tykUPB5G88nPniX02VqNTVpOdAWQZIMY4
   kxFi2T2/YNWKRuoFX7Q5sV3jwXPPv9TzRSj8vSvjCnVCy3AGq/O9tjTLH
   Ijuu+eOuPbCDhF+4kjmbnvwqQ65S3h0+GPXmUcyR4t06kyKygr9cVGwQq
   ZYQKSUoj8Fha2Pa1q9syq6gxA6dtSDd02OiWhkpaNUtgAxSQMIquDtpva
   g==;
X-CSE-ConnectionGUID: Z0lShXkjRsSWWTRkq25Eyg==
X-CSE-MsgGUID: ddKWbeK5Rf6KHrAwxj0dSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11170"; a="33102259"
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="33102259"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2024 17:26:10 -0700
X-CSE-ConnectionGUID: QYpm+HL7Rt+vlbg+hWK2Tw==
X-CSE-MsgGUID: e/41dBwxQO+o7TlyHWjfxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,163,1719903600"; 
   d="scan'208";a="61679440"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Aug 2024 17:25:58 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sgZAi-000Aiq-0Q;
	Wed, 21 Aug 2024 00:25:56 +0000
Date: Wed, 21 Aug 2024 08:25:16 +0800
From: kernel test robot <lkp@intel.com>
To: Jeongjun Park <aha310510@gmail.com>, wenjia@linux.ibm.com,
	jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, utz.bacher@de.ibm.com, dust.li@linux.alibaba.com,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller <syzkaller@googlegroups.com>,
	Jeongjun Park <aha310510@gmail.com>
Subject: Re: [PATCH net,v6,2/2] net/smc: initialize ipv6_pinfo_offset in
 smc_inet6_prot and add smc6_sock structure
Message-ID: <202408210856.G9xvGcdD-lkp@intel.com>
References: <20240820121548.380342-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820121548.380342-1-aha310510@gmail.com>

Hi Jeongjun,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.11-rc4 next-20240820]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeongjun-Park/net-smc-modify-smc_sock-structure/20240820-201856
base:   linus/master
patch link:    https://lore.kernel.org/r/20240820121548.380342-1-aha310510%40gmail.com
patch subject: [PATCH net,v6,2/2] net/smc: initialize ipv6_pinfo_offset in smc_inet6_prot and add smc6_sock structure
config: i386-randconfig-003-20240821 (https://download.01.org/0day-ci/archive/20240821/202408210856.G9xvGcdD-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240821/202408210856.G9xvGcdD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408210856.G9xvGcdD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/smc/smc_inet.c:78:56: error: unexpected ';' before '}'
      78 |         .ipv6_pinfo_offset      = offsetof(struct smc6_sock, inet6);
         |                                                                    ^
   1 error generated.


vim +78 net/smc/smc_inet.c

    67	
    68	static struct proto smc_inet6_prot = {
    69		.name		= "INET6_SMC",
    70		.owner		= THIS_MODULE,
    71		.init		= smc_inet_init_sock,
    72		.hash		= smc_hash_sk,
    73		.unhash		= smc_unhash_sk,
    74		.release_cb	= smc_release_cb,
    75		.obj_size	= sizeof(struct smc6_sock),
    76		.h.smc_hash	= &smc_v6_hashinfo,
    77		.slab_flags	= SLAB_TYPESAFE_BY_RCU,
  > 78		.ipv6_pinfo_offset	= offsetof(struct smc6_sock, inet6);
    79	};
    80	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
