Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1015618A920;
	Wed, 16 Oct 2024 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063929; cv=none; b=Yi/RmZiXFiNkWNYqgngJ33e4fRlQHIz6oXvxZmGx/gP7/wWekJK0SxgkeH0UPyCsbs5ZPHutqVuOF6owH7OG8Z6p6EnfIlsgMNHKQuyEyK0M6kcbw4AjQDCWygXPaPPuNcF269N5NR1iPLX7vJA7asSb7PpiIZU49jWyEv3pro0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063929; c=relaxed/simple;
	bh=AHk2vdSUD+Do2ZG+9KdqrMbolJvWEs6at+edKVbNgCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hOElJRxsTY8PI5i/YYezp4ORqs1KDd4/EEOVjfGEl2wto5GYhKbtwhvm+Z0qrqy9A4x2uQ77oSiqWm2U/6P2ZNPT9E5hbPznL6lO3tGf3vgxvkt2E5hlpXXOtMY8PkRcwopgV6FOf2gprNhvgm5XDvu+4mAI/f5DPWKx0g7xBQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=McINNvz3; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="McINNvz3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729063928; x=1760599928;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AHk2vdSUD+Do2ZG+9KdqrMbolJvWEs6at+edKVbNgCI=;
  b=McINNvz35rvzd74iDAal7LBZ7QrpoEqnbzCjDkaRzP2iZWHymg83GYHP
   Dm7dapft6OlsNkdT4/jFTcsFm1RwNRWoWCwkb0YAmkePiFv7r2zj6fx/I
   M46puWT6eh0xBpKnIHBJtKMfX+QGcCT1Gz39qp7xmLfiWWWkNSEJV9rLt
   Gv2z7WsRJFFwg8q1QEEn8iQdH7GzqWyhdlUVdIkNztfmnRufnLir8mdPn
   sXNN/MI9ZWQLFHW9ZKRh8UuZOxOmh5cb8r3eNCzFa1WU8Zk02tMuv/iWj
   GKH2I46bYDB7gVrUP2LVJh/KojblnWnuoeW01MD/trZtY40kQ47g1jI1z
   w==;
X-CSE-ConnectionGUID: jcGKAY+gQ1SWaI4VdVklKw==
X-CSE-MsgGUID: KTT/4hBIR++kOhcJ5JiENw==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="27969617"
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="27969617"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2024 00:32:07 -0700
X-CSE-ConnectionGUID: /zNp/SbITcG1BXQ5YuXVww==
X-CSE-MsgGUID: qYFFeLchQwCPh8S8WXlGcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,207,1725346800"; 
   d="scan'208";a="77762291"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 16 Oct 2024 00:32:04 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t0yVm-000KVz-0p;
	Wed, 16 Oct 2024 07:32:02 +0000
Date: Wed, 16 Oct 2024 15:31:05 +0800
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
Message-ID: <202410161404.V66COAYS-lkp@intel.com>
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
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20241016/202410161404.V66COAYS-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241016/202410161404.V66COAYS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410161404.V66COAYS-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/ptp/ptp_s390.c:7:
   In file included from drivers/ptp/ptp_private.h:16:
   In file included from include/linux/ptp_clock_kernel.h:15:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/ptp/ptp_s390.c:7:
   In file included from drivers/ptp/ptp_private.h:16:
   In file included from include/linux/ptp_clock_kernel.h:15:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/ptp/ptp_s390.c:7:
   In file included from drivers/ptp/ptp_private.h:16:
   In file included from include/linux/ptp_clock_kernel.h:15:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:693:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:701:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:709:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:718:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:727:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:736:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   drivers/ptp/ptp_s390.c:21:52: warning: declaration of 'union tod_clock' will not be visible outside of this function [-Wvisibility]
   static struct timespec64 eitod_to_timespec64(union tod_clock *clk)
                                                      ^
>> drivers/ptp/ptp_s390.c:23:26: error: call to undeclared function 'eitod_to_ns'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           return ns_to_timespec64(eitod_to_ns(clk));
                                   ^
>> drivers/ptp/ptp_s390.c:28:26: error: call to undeclared function 'tod_to_ns'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           return ns_to_timespec64(tod_to_ns(tod - TOD_UNIX_EPOCH));
                                   ^
   drivers/ptp/ptp_s390.c:28:42: error: use of undeclared identifier 'TOD_UNIX_EPOCH'
           return ns_to_timespec64(tod_to_ns(tod - TOD_UNIX_EPOCH));
                                                   ^
   drivers/ptp/ptp_s390.c:34:18: error: variable has incomplete type 'union tod_clock'
           union tod_clock tod;
                           ^
   drivers/ptp/ptp_s390.c:34:8: note: forward declaration of 'union tod_clock'
           union tod_clock tod;
                 ^
>> drivers/ptp/ptp_s390.c:36:7: error: call to undeclared function 'stp_enabled'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           if (!stp_enabled())
                ^
   drivers/ptp/ptp_s390.c:36:7: note: did you mean 'cpu_enabled'?
   include/linux/cpumask.h:1163:29: note: 'cpu_enabled' declared here
   static __always_inline bool cpu_enabled(unsigned int cpu)
                               ^
>> drivers/ptp/ptp_s390.c:39:2: error: call to undeclared function 'store_tod_clock_ext_cc'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           store_tod_clock_ext_cc(&tod);
           ^
>> drivers/ptp/ptp_s390.c:49:2: error: call to undeclared function 'ptff'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           ptff(&tod, sizeof(tod), PTFF_QPT);
           ^
   drivers/ptp/ptp_s390.c:49:26: error: use of undeclared identifier 'PTFF_QPT'
           ptff(&tod, sizeof(tod), PTFF_QPT);
                                   ^
   drivers/ptp/ptp_s390.c:64:18: error: variable has incomplete type 'union tod_clock'
           union tod_clock clk;
                           ^
   drivers/ptp/ptp_s390.c:64:8: note: forward declaration of 'union tod_clock'
           union tod_clock clk;
                 ^
   drivers/ptp/ptp_s390.c:66:2: error: call to undeclared function 'store_tod_clock_ext_cc'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           store_tod_clock_ext_cc(&clk);
           ^
   drivers/ptp/ptp_s390.c:67:29: error: call to undeclared function 'tod_to_ns'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           *device_time = ns_to_ktime(tod_to_ns(clk.tod - TOD_UNIX_EPOCH));
                                      ^
   drivers/ptp/ptp_s390.c:67:49: error: use of undeclared identifier 'TOD_UNIX_EPOCH'
           *device_time = ns_to_ktime(tod_to_ns(clk.tod - TOD_UNIX_EPOCH));
                                                          ^
   drivers/ptp/ptp_s390.c:76:7: error: call to undeclared function 'stp_enabled'; ISO C99 and later do not support implicit function declarations [-Werror,-Wimplicit-function-declaration]
           if (!stp_enabled())
                ^
   13 warnings and 13 errors generated.


vim +/eitod_to_ns +23 drivers/ptp/ptp_s390.c

    20	
    21	static struct timespec64 eitod_to_timespec64(union tod_clock *clk)
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
    34		union tod_clock tod;
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
