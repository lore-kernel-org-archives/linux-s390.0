Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792825927;
	b=hwOmfOUvbywrdgVYglnwvrjvcUSvIQUeDNg8WNwBUn1eJNgl18acYQYX5Rj1RPfDNniZ
	 kUltmXOK0fuRdoElP1uR4v7BQiXNLrOwEiJUQqFNBwHk1S/tl8GGBpN8+nsdGPwpyaNS1
	 ubOGij43JDDqCIkkaocYMrAs+NJrxjpTRp5Ug+Ia+vz/buPkdfS/Q4nc1uvyZGBUlXSSN
	 YWk8e4Z53Dwjq3Wafk877+wYuziFgGlTOWrRKofTuvvpOMFjW0DkKD3NkfRgQYxrqXEC8
	 KQSA4p/FW/zpMBoO/v4Qobk2erafocQ+B3BVeJ9xymAgebT9+APaqfEdq7Wxvz3+c7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792825927;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=otfkf6rc7A5WQHwhvMROMVfUxygEeJtP9xIeX+eUDt4=;
	b=438i026CpB5/N3U7OpynqFBSpCPafTtc5AOYq9kl09uIv19qHr9CQcnbSgjtYd2zkrys
	 c5fcS+05lggfLaD84xVjYO6en+etANFT2jSyenUrRiqOn4qBwf9BzV2s2O0WiTQpvVe2E
	 MjmAwQOMh8xqVQbhIcPHmNLqu9kTNoH7P1/VzBeGJc9GdTBv4sBaejVWys+IK4nA3GwdQ
	 uAVwx55QR4gGxH6GOLZUVvdvrSqUD/phzUKGU/pzyU119Ccf198Lz+JxVwiBb44sdsXfL
	 buQimr7cIfnN7mVfI2xAXzU7q7xqjWd3WGjFrQgy3klpglHUIgHQ3ygPxJDjbbltN/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LHbcmEsM;
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061AD606A31B;
	Sat, 24 Oct 2026 07:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 061AD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LHbcmEsM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792825925; x=1824361925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yucRPs4LIhMNBkyP/DPPwoQWxYx/4Wb6D9pPnif927w=;
  b=LHbcmEsM/JwhaswfODWcSpGJvKB7Hijjv5z495C00ZDl7hk2CvacMjlN
   mQcMdy42JIauAhcNHOGq2rj9H5sMOrc4cf7Ngtvr/Pgw93yRSgD8NF503
   GD4U/HvP51Q/dGz7Audb3frcDYc7yBN0HZjrD9VIzPWx2kQE1yYCPffn3
   sU0dDVBBmB90/Wflblo0wp+p7qMoI7NLAPfVdWq5+6im7WRUYrtCXAJ/p
   rhfLigQFEEShJ/BCOORV58JomEvE9q/gyPe6GcVv7AzcR9ogynd60trkh
   OApLDDDKGyP52yvY+unF9ZqwM6z6/i/S9mtETurQvXQS5AMRuuzlD4PbW
   Q==;
X-CSE-ConnectionGUID: F+hNUzzmSoWOhWzL4hNIUw==
X-CSE-MsgGUID: 2L+m66yQRKa4JzteJijmiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1586322"
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="1586322"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 00:12:04 -0700
X-CSE-ConnectionGUID: 8zf1lucFTPGicnLAeXhs/w==
X-CSE-MsgGUID: fZPdmY6PQbSmcI3d8MPkkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,175,1787036400"; 
   d="scan'208";a="3927203"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 24 Oct 2026 00:11:59 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xKVv1-00000000Tew-3wEu;
	Sat, 24 Oct 2026 07:11:55 +0000
Date: Sat, 24 Oct 2026 15:11:15 +0800
From: kernel test robot <lkp@intel.com>
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	jjherne@linux.ibm.com, borntraeger@de.ibm.com,
	mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
	kwankhede@nvidia.com, fiuczy@linux.ibm.com, pbonzini@redhat.com,
	frankja@linux.ibm.com, imbrenda@linux.ibm.com,
	agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v10 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
Message-ID: <202610241421.XoTPxllD-lkp@intel.com>
References: <20261023174349.3545941-4-akrowiak@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023174349.3545941-4-akrowiak@linux.ibm.com>

Hi Anthony,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvms390/next]
[also build test WARNING on s390/features mst-vhost/linux-next linus/master v7.3 next-20261022]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anthony-Krowiak/s390-vfio-ap-Provide-function-to-get-the-number-of-queues-assigned-to-mdev/20261023-134335
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git next
patch link:    https://lore.kernel.org/r/20261023174349.3545941-4-akrowiak%40linux.ibm.com
patch subject: [PATCH v10 03/15] s390/vfio-ap: Functions to initialize/release vfio device migration data
config: s390-defconfig (https://download.01.org/0day-ci/archive/20261024/202610241421.XoTPxllD-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261024/202610241421.XoTPxllD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610241421.XoTPxllD-lkp@intel.com/

All warnings (new ones prefixed by >>):

   Warning: drivers/s390/crypto/vfio_ap_migration.c:208 function parameter 'matrix_mdev' not described in 'vfio_ap_release_migration_data'
>> Warning: drivers/s390/crypto/vfio_ap_migration.c:208 Excess function parameter 'mdev' description in 'vfio_ap_release_migration_data' (did you mean one of: 'matrix_mdev')
   Warning: drivers/s390/crypto/vfio_ap_migration.c:208 function parameter 'matrix_mdev' not described in 'vfio_ap_release_migration_data'
>> Warning: drivers/s390/crypto/vfio_ap_migration.c:208 Excess function parameter 'mdev' description in 'vfio_ap_release_migration_data' (did you mean one of: 'matrix_mdev')

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
