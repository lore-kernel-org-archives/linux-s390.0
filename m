Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB3F156E4;
	Wed, 16 Oct 2024 06:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729059607; cv=none; b=DoNEP7ueerjR6C0ubltPApRs0W8h1BtkWkuORDwZS+HNBgIF7uKnmQQexqdg6fbRkv1c05McqXLMHVMW53TX1/dEnU2+OxHMtEv7K1cns5OVkQbncuB1+bwX3/yTntim/JMh8Zyvtx1oOuHYnsJI8ofggKaW8DJFSRxaDjwvBSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729059607; c=relaxed/simple;
	bh=qoQIhnscpiMhEnHFEwY7bxIRzEKmXMR4NV1svM0kguw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQthn8zRA3iTWi2HpCyl/nUlkfobjm9yIo+t4MtyXwPurQNtad57aBa+CqL9lFoD/jXmsDLi5ckYUzofaQda4e1GRaVlnqDcJzBiUNPqSzxRQJXs0KafH5qFzbBCMSG17MOsZ/Qs7S63Ta9cing8E2Ll7ENevhQMaOfl0mkWTrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A2eRYinE; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A2eRYinE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729059604; x=1760595604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qoQIhnscpiMhEnHFEwY7bxIRzEKmXMR4NV1svM0kguw=;
  b=A2eRYinEShSWyvaXYeeiR8E3G6hRyLhn+0vdi420zezs56bEZhC+112L
   sm2fP7Hv0X4UzyPHhZUUW0JqHIegAQPemd2LgbjHdV6IpsdqZwymvxj6j
   N4HnV64XdPE7SXRy52E5/2mW83zLXF3jPKfAkfiL+x+cW/z0yL06o7WiM
   WfsMsk8Is6NHYSze5NNBBinW+dCkoxpRJQFYK6llETDRDTR71BJ0HJk3I
   0V8kluihSWsgDZbTYnHm0PzCYxsiyaSMy+mlbKSKh0+JH3Kwhn/vlwLFz
   b+gvQHtxsuM9bs5jOaHM5cvahNTcvOVyODwoyIOpXcLrKZ3lsNZhvLPSz
   Q==;
X-CSE-ConnectionGUID: E8NT637mTO+qG+F2LEb8bA==
X-CSE-MsgGUID: aHH+HhneThSHHQWFqf5/cQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="31359178"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="31359178"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 23:20:03 -0700
X-CSE-ConnectionGUID: hiR/INNfShqLgmZEeaXA2w==
X-CSE-MsgGUID: ZxHKS3cmSV2OIpmrPJpQVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="78295489"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 15 Oct 2024 23:20:01 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0xO2-000KRX-0i;
	Wed, 16 Oct 2024 06:19:58 +0000
Date: Wed, 16 Oct 2024 14:19:08 +0800
From: kernel test robot <lkp@intel.com>
To: Sven Schnelle <svens@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 3/3] s390/time: Add PtP driver
Message-ID: <202410161414.jC5t2eWE-lkp@intel.com>
References: <20241015105414.2825635-4-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015105414.2825635-4-svens@linux.ibm.com>

Hi Sven,

kernel test robot noticed the following build errors:

[auto build test ERROR on s390/features]
[also build test ERROR on linus/master v6.12-rc3 next-20241015]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sven-Schnelle/s390-time-Add-clocksource-id-to-TOD-clock/20241015-185651
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
patch link:    https://lore.kernel.org/r/20241015105414.2825635-4-svens%40linux.ibm.com
patch subject: [PATCH 3/3] s390/time: Add PtP driver
config: x86_64-buildonly-randconfig-003-20241016 (https://download.01.org/0day-ci/archive/20241016/202410161414.jC5t2eWE-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410161414.jC5t2eWE-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410161414.jC5t2eWE-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/ptp/ptp_s390.c:21:52: warning: declaration of 'union tod_clock' will not be visible outside of this function [-Wvisibility]
      21 | static struct timespec64 eitod_to_timespec64(union tod_clock *clk)
         |                                                    ^
>> drivers/ptp/ptp_s390.c:23:26: error: call to undeclared function 'eitod_to_ns'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      23 |         return ns_to_timespec64(eitod_to_ns(clk));
         |                                 ^
>> drivers/ptp/ptp_s390.c:28:26: error: call to undeclared function 'tod_to_ns'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      28 |         return ns_to_timespec64(tod_to_ns(tod - TOD_UNIX_EPOCH));
         |                                 ^
>> drivers/ptp/ptp_s390.c:28:42: error: use of undeclared identifier 'TOD_UNIX_EPOCH'
      28 |         return ns_to_timespec64(tod_to_ns(tod - TOD_UNIX_EPOCH));
         |                                                 ^
>> drivers/ptp/ptp_s390.c:34:18: error: variable has incomplete type 'union tod_clock'
      34 |         union tod_clock tod;
         |                         ^
   drivers/ptp/ptp_s390.c:34:8: note: forward declaration of 'union tod_clock'
      34 |         union tod_clock tod;
         |               ^
>> drivers/ptp/ptp_s390.c:36:7: error: call to undeclared function 'stp_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      36 |         if (!stp_enabled())
         |              ^
>> drivers/ptp/ptp_s390.c:39:2: error: call to undeclared function 'store_tod_clock_ext_cc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      39 |         store_tod_clock_ext_cc(&tod);
         |         ^
>> drivers/ptp/ptp_s390.c:49:2: error: call to undeclared function 'ptff'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      49 |         ptff(&tod, sizeof(tod), PTFF_QPT);
         |         ^
>> drivers/ptp/ptp_s390.c:49:26: error: use of undeclared identifier 'PTFF_QPT'
      49 |         ptff(&tod, sizeof(tod), PTFF_QPT);
         |                                 ^
   drivers/ptp/ptp_s390.c:64:18: error: variable has incomplete type 'union tod_clock'
      64 |         union tod_clock clk;
         |                         ^
   drivers/ptp/ptp_s390.c:64:8: note: forward declaration of 'union tod_clock'
      64 |         union tod_clock clk;
         |               ^
   drivers/ptp/ptp_s390.c:66:2: error: call to undeclared function 'store_tod_clock_ext_cc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      66 |         store_tod_clock_ext_cc(&clk);
         |         ^
   drivers/ptp/ptp_s390.c:67:29: error: call to undeclared function 'tod_to_ns'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      67 |         *device_time = ns_to_ktime(tod_to_ns(clk.tod - TOD_UNIX_EPOCH));
         |                                    ^
   drivers/ptp/ptp_s390.c:67:49: error: use of undeclared identifier 'TOD_UNIX_EPOCH'
      67 |         *device_time = ns_to_ktime(tod_to_ns(clk.tod - TOD_UNIX_EPOCH));
         |                                                        ^
   drivers/ptp/ptp_s390.c:76:7: error: call to undeclared function 'stp_enabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      76 |         if (!stp_enabled())
         |              ^
   1 warning and 13 errors generated.


vim +/eitod_to_ns +23 drivers/ptp/ptp_s390.c

    20	
  > 21	static struct timespec64 eitod_to_timespec64(union tod_clock *clk)
    22	{
  > 23		return ns_to_timespec64(eitod_to_ns(clk));
    24	}
    25	
    26	static struct timespec64 tod_to_timespec64(unsigned long tod)
    27	{
  > 28		return ns_to_timespec64(tod_to_ns(tod - TOD_UNIX_EPOCH));
    29	}
    30	
    31	static int ptp_s390_stcke_gettime(struct ptp_clock_info *ptp,
    32					  struct timespec64 *ts)
    33	{
  > 34		union tod_clock tod;
    35	
  > 36		if (!stp_enabled())
    37			return -EOPNOTSUPP;
    38	
  > 39		store_tod_clock_ext_cc(&tod);
    40		*ts = eitod_to_timespec64(&tod);
    41		return 0;
    42	}
    43	
    44	static int ptp_s390_qpt_gettime(struct ptp_clock_info *ptp,
    45					struct timespec64 *ts)
    46	{
    47		unsigned long tod;
    48	
  > 49		ptff(&tod, sizeof(tod), PTFF_QPT);
    50		*ts = tod_to_timespec64(tod);
    51		return 0;
    52	}
    53	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
