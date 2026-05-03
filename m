Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F3F1A681B;
	Sun,  3 May 2026 01:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777770736; cv=none; b=r1f5s4+xAjqWUVvCSl4e2kzW6FhAd/+iD4q409S6PAWm8AzkQ2K9A2aO1wgKk4cyrrKdRf9VUifPW+juq/5x7MNfhTYSSYWz7Jnmk/sN8IgJILUNS8zkI813ebuj12lGbsIdsLu+iVN471RAPJFMzqsPrQxhvGUehhKDL1vAAdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777770736; c=relaxed/simple;
	bh=qpS8SjBnaz5E52eHWFh24fuGsQHHYzD4VaaKpA3Vs9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGxJ+lxHjSAQy04dO2nPji/5DEBNDW0DB7XW2drymzahWxD9HO8CPhJHabw8q5pOTFYocGU8Rlemcypne8rXbz2Hp3GYl7bb0SG6Vxnj2knc2nRE6SvL/SpletZqZ87GIMMq1vWM5Y19OB/69RopPpF0TVb/XLdu+GcdSEeX8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b5g+WUqa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b5g+WUqa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777770735; x=1809306735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qpS8SjBnaz5E52eHWFh24fuGsQHHYzD4VaaKpA3Vs9c=;
  b=b5g+WUqaiAXioajMRv20nZ6xOH8y2eq1coHHv9LdH4c32/7TxFFxxmmn
   jB5si0vSp9EUqKVF3brKxOIvDpLQpuORSdEcWPXX2ASdAKpizu2soJi0q
   UlDrpL/gV5JS7IbqH7DO1R1I0K6GXADp0uQXpCIdwNOPFuZXjHsGQLF+N
   0vHksoG3c5zqOs6mLPVXkVFLX+wrl/cFaSzYNdo75oTKb8w4y5FaUDrDb
   rtB74pOopH4za/HSCLpk0t1gUVLM+/xyTCadYpzW5X8nK/vVDL0nQRGiM
   Gsw6ajyT/QG8BUYNxn430WGCHKRoC0050bNYrjFl9RRQoSVwOLB2C0Vwz
   Q==;
X-CSE-ConnectionGUID: RZD7P1QLRA+sHawEG0qH3Q==
X-CSE-MsgGUID: HYn+JLi0Tc6jOx2Bxaa6nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="78731770"
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="78731770"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 18:12:14 -0700
X-CSE-ConnectionGUID: 0bBIgP+FTvyE5vxa4Vlkbg==
X-CSE-MsgGUID: QeJ20crlRnqv2grJYk8FJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,213,1770624000"; 
   d="scan'208";a="235070165"
Received: from igk-lkp-server01.igk.intel.com (HELO bdf09bfdbd5f) ([10.211.93.152])
  by orviesa008.jf.intel.com with ESMTP; 02 May 2026 18:12:11 -0700
Received: from kbuild by bdf09bfdbd5f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJLNR-000000005Q5-07DW;
	Sun, 03 May 2026 01:12:09 +0000
Date: Sun, 3 May 2026 03:11:15 +0200
From: kernel test robot <lkp@intel.com>
To: Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, oelghoul@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com,
	schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
	farman@linux.ibm.com, gbayer@linux.ibm.com, alex@shazbot.org
Subject: Re: [PATCH v1 3/3] s390/pci: Fence FMB enable/disable via sysfs for
 passthrough devices
Message-ID: <202605030313.sqrb6Bdr-lkp@intel.com>
References: <20260501192530.9429-4-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501192530.9429-4-oelghoul@linux.ibm.com>

Hi Omar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on s390/features]
[also build test WARNING on awilliam-vfio/next awilliam-vfio/for-linus kvms390/next linus/master v6.16-rc1 next-20260430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Omar-Elghoul/s390-pci-Preserve-FMB-state-in-device-re-enablement/20260502-155729
base:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
patch link:    https://lore.kernel.org/r/20260501192530.9429-4-oelghoul%40linux.ibm.com
patch subject: [PATCH v1 3/3] s390/pci: Fence FMB enable/disable via sysfs for passthrough devices
config: s390-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260503/202605030313.sqrb6Bdr-lkp@intel.com/config)
compiler: s390x-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260503/202605030313.sqrb6Bdr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605030313.sqrb6Bdr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/s390/pci/pci.c: In function 'zpci_fmb_enable_device':
>> arch/s390/pci/pci.c:191:23: warning: unused variable 'flags' [-Wunused-variable]
     191 |         unsigned long flags;
         |                       ^~~~~
>> arch/s390/pci/pci.c:189:33: warning: unused variable 'ctrs' [-Wunused-variable]
     189 |         struct zpci_iommu_ctrs *ctrs;
         |                                 ^~~~
   arch/s390/pci/pci.c: In function 'zpci_fmb_reenable_device':
   arch/s390/pci/pci.c:244:23: warning: unused variable 'flags' [-Wunused-variable]
     244 |         unsigned long flags;
         |                       ^~~~~
   arch/s390/pci/pci.c:242:33: warning: unused variable 'ctrs' [-Wunused-variable]
     242 |         struct zpci_iommu_ctrs *ctrs;
         |                                 ^~~~


vim +/flags +191 arch/s390/pci/pci.c

029a3d529699a0 Omar Elghoul    2026-05-01  184  
d0b0885316ab7a Jan Glauber     2012-12-11  185  /* Modify PCI: Set PCI function measurement parameters */
d0b0885316ab7a Jan Glauber     2012-12-11  186  int zpci_fmb_enable_device(struct zpci_dev *zdev)
d0b0885316ab7a Jan Glauber     2012-12-11  187  {
4e5bd7803bd1e8 Sebastian Ott   2017-06-10  188  	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
92bce97f0c341d Niklas Schnelle 2023-10-04 @189  	struct zpci_iommu_ctrs *ctrs;
4e5bd7803bd1e8 Sebastian Ott   2017-06-10  190  	struct zpci_fib fib = {0};
ecda483339a515 Matthew Rosato  2024-09-10 @191  	unsigned long flags;
4e5bd7803bd1e8 Sebastian Ott   2017-06-10  192  	u8 cc, status;
d0b0885316ab7a Jan Glauber     2012-12-11  193  
0b7589ecca2b6f Sebastian Ott   2016-06-15  194  	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
d0b0885316ab7a Jan Glauber     2012-12-11  195  		return -EINVAL;
d0b0885316ab7a Jan Glauber     2012-12-11  196  
08b421245692f3 Wei Yongjun     2013-02-25  197  	zdev->fmb = kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
d0b0885316ab7a Jan Glauber     2012-12-11  198  	if (!zdev->fmb)
d0b0885316ab7a Jan Glauber     2012-12-11  199  		return -ENOMEM;
d0b0885316ab7a Jan Glauber     2012-12-11  200  	WARN_ON((u64) zdev->fmb & 0xf);
d0b0885316ab7a Jan Glauber     2012-12-11  201  
029a3d529699a0 Omar Elghoul    2026-05-01  202  	zpci_fmb_clear_iommu_ctrs(zdev);
6001018ae8c659 Sebastian Ott   2015-04-10  203  
4e5bd7803bd1e8 Sebastian Ott   2017-06-10  204  	fib.fmb_addr = virt_to_phys(zdev->fmb);
c68468ed3416ea Matthew Rosato  2022-06-06  205  	fib.gd = zdev->gisa;
4e5bd7803bd1e8 Sebastian Ott   2017-06-10  206  	cc = zpci_mod_fc(req, &fib, &status);
4e5bd7803bd1e8 Sebastian Ott   2017-06-10  207  	if (cc) {
4e5bd7803bd1e8 Sebastian Ott   2017-06-10  208  		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
4e5bd7803bd1e8 Sebastian Ott   2017-06-10  209  		zdev->fmb = NULL;
4e5bd7803bd1e8 Sebastian Ott   2017-06-10  210  	}
4e5bd7803bd1e8 Sebastian Ott   2017-06-10  211  	return cc ? -EIO : 0;
d0b0885316ab7a Jan Glauber     2012-12-11  212  }
d0b0885316ab7a Jan Glauber     2012-12-11  213  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
