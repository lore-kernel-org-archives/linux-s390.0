Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8BE1E287F;
	Wed,  7 Aug 2024 12:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723032285; cv=none; b=QruYn/TdwulgOTEYEgblILhd0e5jfGaL378GtN3ZbETF/ybqUeZw/8lx0QXGruLnKnvX/JdfCA4J979Jw1rrfEQ8OThM8CSuCak9qDpvxvCDT0nUHlXCSXG5R4ddCv69XZsLRSlbHgsgxEjGzt6BJJDGMNZUqFsGniWXkxUut7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723032285; c=relaxed/simple;
	bh=GLRNF2HuoLjUQ6w4jpeRIInoZ8CgfoqNgjV1++re138=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lAQ+xVtPLrGI9SSDmWRhVJEFVRhrrpwqLTYUm+Ctv5I/oUnw0XkcP4XlUzlBEnNJ7SNYZV463v1T0mD/UQHI/aWESsgDlXhxOUZWMHGiGZwIwuFoOGbzc4Onp5B9q1tq8g/6N1oRndi8Rq1A6gp718TDVJ5ImBAbxYHh6G8Mz+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aMC5hu6k; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aMC5hu6k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723032282; x=1754568282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GLRNF2HuoLjUQ6w4jpeRIInoZ8CgfoqNgjV1++re138=;
  b=aMC5hu6kArj+1mIr5DPcuBwE9wICSfVekUgAHOxBVihgdLnNme5H6t7h
   NBO9u7ajz4Gr8sg482NWbBNK3Mu+evH88Gi9//72Dr6kgfp5e+VrQqHj1
   483m2bQIxzKwratTqUJa+Jr64QtRWmr08z9Qhy0EOYqZaRHYHjvse50EH
   F/LRHMTT9n5giFb7NPf2QXwaARrmN60S1Ynwh/l5Cotu/E2pZ0eK69Qlo
   DiyM4IZ19V4YPBwuzqRWr3TC9KNEdTRcPdeZnDcDrNrkBYD6EBt+FJ/Ls
   i7jr1qc9+KLjDckHP4uJxPqVt5iI6ecyWRQ/eisHphXMmqP7OtPAwMKiI
   g==;
X-CSE-ConnectionGUID: XoJR10mQQfOb9uuaZuilCg==
X-CSE-MsgGUID: Yirz4XL0T+ekW8tCp8oY5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="46501028"
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="46501028"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 05:04:41 -0700
X-CSE-ConnectionGUID: C1Hv3b0wQkGnZhuTvKV2xg==
X-CSE-MsgGUID: WCCbT51kQy6D3mvYnNd/Dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,269,1716274800"; 
   d="scan'208";a="60956213"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 07 Aug 2024 05:04:39 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbfOm-0005Lo-1T;
	Wed, 07 Aug 2024 12:04:18 +0000
Date: Wed, 7 Aug 2024 20:04:12 +0800
From: kernel test robot <lkp@intel.com>
To: Baruch Siach <baruch@tkos.co.il>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, Baruch Siach <baruch@tkos.co.il>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v5 1/3] dma: improve DMA zone selection
Message-ID: <202408071931.W1GA8Ee2-lkp@intel.com>
References: <5200f289af1a9b80dfd329b6ed3d54e1d4a02876.1722578375.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5200f289af1a9b80dfd329b6ed3d54e1d4a02876.1722578375.git.baruch@tkos.co.il>

Hi Baruch,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 8400291e289ee6b2bf9779ff1c83a291501f017b]

url:    https://github.com/intel-lab-lkp/linux/commits/Baruch-Siach/dma-improve-DMA-zone-selection/20240803-074651
base:   8400291e289ee6b2bf9779ff1c83a291501f017b
patch link:    https://lore.kernel.org/r/5200f289af1a9b80dfd329b6ed3d54e1d4a02876.1722578375.git.baruch%40tkos.co.il
patch subject: [PATCH v5 1/3] dma: improve DMA zone selection
config: i386-randconfig-063-20240807 (https://download.01.org/0day-ci/archive/20240807/202408071931.W1GA8Ee2-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240807/202408071931.W1GA8Ee2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408071931.W1GA8Ee2-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux: section mismatch in reference: __dma_direct_alloc_pages+0xcc (section: .text.__dma_direct_alloc_pages) -> memblock (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: __dma_direct_alloc_pages+0xd2 (section: .text.__dma_direct_alloc_pages) -> memblock (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: swiotlb_alloc_pool+0xa0 (section: .text.swiotlb_alloc_pool) -> memblock (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference: swiotlb_alloc_pool+0xa6 (section: .text.swiotlb_alloc_pool) -> memblock (section: .init.data)
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/bpf/preload/bpf_preload.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_userspace.o

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
