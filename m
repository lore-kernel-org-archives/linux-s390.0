Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171BA176FB7
	for <linux-s390@vger.kernel.org>; Thu,  2 May 2024 19:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714677298; cv=none; b=I5IgDlo8T0LwKBffmBPdyNGgfkhBlQxQN8IB3zU2Ts8HlQkUqIygmip4pSEBDJXt+HBeBrVj4nF2o0mTIM3feoOuKYEt3haThDTRKIOyoLlaxjfP48BMpigf2H0XFJVWpnurQJ0CMpCXSzTM1sFTOnBBtYgZUj66/Z8cQcvt3/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714677298; c=relaxed/simple;
	bh=TgiBfvsQP3pwuzwzdLXyDX+4/QuSAnrNHYRKJ4v10Do=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=L0tafLCKYOzK6H7zyNae2ByJdT2Zux0bBmvjloxkg452EkICm0cVqRximbbo0qeOzRfnXf7x0hRRpftFG/1Q9omrkgv1yFQilrJBfcFGIk0ROAhrCNSlVYf2SogNiZ/ZThVQss1kiEA6g11XfctdTKhAp7xVGXVcIp5PP+RkDss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEejJxBZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEejJxBZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714677297; x=1746213297;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TgiBfvsQP3pwuzwzdLXyDX+4/QuSAnrNHYRKJ4v10Do=;
  b=KEejJxBZP3++bdF9jNW6B0L0hET8dlpl7QxTRZSgQ2kLXP6DuuvxRCP1
   6pB5YP4L39bFkoL42MkcYHbCJ6vZ21hzH3XK6pq/PYUmgJ9gpCD/POJrE
   Xex/7zNo2q6/Jcd3wLxmq3hMTNmeAiHpgTGaQ8Tjk/QvM7VylQEvq87hw
   9ZzlvziEIp8JhmstMFnS508HCQSRutPcTW0hVhr6rXdnAwV7PYqw3JDuo
   hTRaxwzFw/QMiJZYnztKaX7hlCj3Z03JDhq5nec91/agzf+zXZwHaGnId
   2uG/1YXfkrErEpqsJHzanFOHh1MTdsbxcqV8ZiuEgXS3GRBfLWRBSekKb
   A==;
X-CSE-ConnectionGUID: XRU13z5RSteO/JeBwRnusg==
X-CSE-MsgGUID: BL5UMRlSQQOSqZrbgMj/oQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="21875899"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="21875899"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 12:14:56 -0700
X-CSE-ConnectionGUID: 66qQVYvLTQG4y5gShzojcg==
X-CSE-MsgGUID: iOQjgrEPTkySgZdQHRj00A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27722793"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 02 May 2024 12:14:55 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2btM-000Auk-25;
	Thu, 02 May 2024 19:14:52 +0000
Date: Fri, 3 May 2024 03:13:57 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org
Subject: [s390:features 50/52] ibm.c:(.text+0x8bc): relocation truncated to
 fit: R_390_PLT32DBL against undefined symbol `dasd_biodasdinfo'
Message-ID: <202405030347.s7RYreRn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
head:   7f20dda18a42526c4ce19c043c5e5f62e6c52d64
commit: 9ecaa2e94e602a3cbcbfe182535f6297f7630b98 [50/52] s390: Relocate vmlinux ELF data to virtual address space
config: s390-randconfig-r031-20211104 (https://download.01.org/0day-ci/archive/20240503/202405030347.s7RYreRn-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240503/202405030347.s7RYreRn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405030347.s7RYreRn-lkp@intel.com/

All errors (new ones prefixed by >>):

   block/partitions/ibm.o: in function `ibm_partition':
>> ibm.c:(.text+0x8bc): relocation truncated to fit: R_390_PLT32DBL against undefined symbol `dasd_biodasdinfo'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
