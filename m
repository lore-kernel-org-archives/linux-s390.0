Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B5F450EE;
	Tue, 30 Jul 2024 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722305532; cv=none; b=m830IkGJTASmSu6TFVP5EXBcDdoSDsVO2gaRzFhXmf6/eXnutKQ7QxjmbC7zA1z76J314onthBlRb1anSs9qjJ4h5Viol+AITbIdHltFyAi6gMcOk3t6DzPiqWq2I0Ni0D6qXS4aPmer/Ihtp8sv2HL/jGa8ki05VWcEYg0O48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722305532; c=relaxed/simple;
	bh=eA77p9u5560PhQ2+Qo/vv+lMkVA7visV3V6tX1tIebU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQDFQ4wXkGC44Avc0h7jStrQVG1RjR70h3ZGu7TABS2NKwcBKW+pdNVMX2j9n5KIqiQdgc3myCTXDuxHf+75gMn3oGlJI7soeax8QzwaT4ak25OfyaBxyL8sZnmsk7Q5NGxGWEdEGMMCqMRo2KvFF49ShcRfTBxEgqKjA2d/XKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r+UNl4+P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r+UNl4+P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71295C4AF07;
	Tue, 30 Jul 2024 02:12:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722305531;
	bh=eA77p9u5560PhQ2+Qo/vv+lMkVA7visV3V6tX1tIebU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r+UNl4+P+aBuEwCi15lh1dI0u61rlCGxvYKiC8Zrfg70eL6OZ14UxHwX5V+nkWD4z
	 GTFvLQSr4vhQWjMHSOW4qqkck+CW+Ua6QZTZVGlIr74fy8uIKQCAONj0BFE16P3Mjf
	 PUMPQcm2k6Ctw0LU2whXelX1qpLnAA/Mmc6qofQwdBAQEcKPH0U69fx2wYOV4BGT2f
	 xaO+O9X8TAf6iJM4cllGx1cbjKuKnW39T/oRbBP/PwPoYidP4yvYQ/xLzsaHaVetrO
	 M+eNYMDFWibewkBkHuLOaWbXQ0sbtQMeKcV4b+vIzgNfje4gxnYr4f3dhxaboZrIpC
	 MwD+65uq+A1bA==
Date: Mon, 29 Jul 2024 19:12:08 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: Baruch Siach <baruch@tkos.co.il>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
	Ramon Fried <ramon@neureality.ai>,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Elad Nachman <enachman@marvell.com>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] dma-mapping: replace zone_dma_bits by
 zone_dma_limit
Message-ID: <20240730021208.GA8272@thelio-3990X>
References: <053fa4806a2c63efcde80caca473a8b670a2701c.1722249878.git.baruch@tkos.co.il>
 <202407300338.oaUo6jtB-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407300338.oaUo6jtB-lkp@intel.com>

On Tue, Jul 30, 2024 at 04:20:51AM +0800, kernel test robot wrote:
> Hi Baruch,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on arm64/for-next/core]
> [also build test WARNING on powerpc/next powerpc/fixes s390/features linus/master v6.11-rc1 next-20240729]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baruch-Siach/dma-mapping-improve-DMA-zone-selection/20240729-211018
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> patch link:    https://lore.kernel.org/r/053fa4806a2c63efcde80caca473a8b670a2701c.1722249878.git.baruch%40tkos.co.il
> patch subject: [PATCH v3 2/3] dma-mapping: replace zone_dma_bits by zone_dma_limit
> config: arm-allnoconfig (https://download.01.org/0day-ci/archive/20240730/202407300338.oaUo6jtB-lkp@intel.com/config)
> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project ccae7b461be339e717d02f99ac857cf0bc7d17fc)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240730/202407300338.oaUo6jtB-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202407300338.oaUo6jtB-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from kernel/dma/direct.c:7:
>    In file included from include/linux/memblock.h:12:
>    In file included from include/linux/mm.h:2253:
>    include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
>      514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
>          |                               ~~~~~~~~~~~ ^ ~~~
> >> kernel/dma/direct.c:23:46: warning: implicit conversion from 'unsigned long long' to 'phys_addr_t' (aka 'unsigned int') changes value from 18446744073709551615 to 4294967295 [-Wconstant-conversion]
>       23 | phys_addr_t zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
>          |             ~~~~~~~~~~~~~~                   ^~~~~~~~~~~~~~~~
>    include/linux/dma-mapping.h:77:40: note: expanded from macro 'DMA_BIT_MASK'
>       77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
>          |                                        ^~~~~
>    2 warnings generated.

FWIW, this is likely a false positive due to an issue in Clang with the
control flow graph for global variables:

https://github.com/ClangBuiltLinux/linux/issues/92

DMA_BIT_MASK() has been the biggest offender :/ If there is any way to
refactor this code to avoid this, that would be great (as that has been
one of our longest outstanding issues and getting it fixed in the
compiler does not seem super easy at this point).

Cheers,
Nathan

> vim +23 kernel/dma/direct.c
> 
>    > 7	#include <linux/memblock.h>
>      8	#include <linux/export.h>
>      9	#include <linux/mm.h>
>     10	#include <linux/dma-map-ops.h>
>     11	#include <linux/scatterlist.h>
>     12	#include <linux/pfn.h>
>     13	#include <linux/vmalloc.h>
>     14	#include <linux/set_memory.h>
>     15	#include <linux/slab.h>
>     16	#include "direct.h"
>     17	
>     18	/*
>     19	 * Most architectures use ZONE_DMA for the first 16 Megabytes, but some use
>     20	 * it for entirely different regions. In that case the arch code needs to
>     21	 * override the variable below for dma-direct to work properly.
>     22	 */
>   > 23	phys_addr_t zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
>     24	
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
