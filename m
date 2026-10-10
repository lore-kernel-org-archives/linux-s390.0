Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13E823BD06;
	Sat, 10 Oct 2026 00:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791592670; cv=none; b=SOvvaTMdzjkxrpgrFo6OcWFWqgW38AVBfOe6S2hOP7uqgO4rWBagrelwUKeHTTBj13acg+8C8OatNZPVyBOxwlCfASAkFGjKhtEq+8HFnTYvgID+cJwOau+fGA0TQvfhWvC808DTmCSyGkDHKS8YVgYBPWBETBf2docObnFALAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791592670; c=relaxed/simple;
	bh=p9cyrBB1lb//v3j6VH9pZzZ0tnpAqnbFnAv/R29JFP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kpzdGGL7TMjhXvahDiTgB4QaJMiYaQeh/h1SI65JECOGwZx3lSCS/9/mQEUI0HZChAgykh9jkZSrQ8eG4lDslmo9p7EBHq5pY6gRPF6FrmnPA0LCzwE3jLSZmDlWbhX43ylicmLHaeTma5J71j4j4m3+UbIUB6WlzQUspf8evGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fL9dlnbC; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fL9dlnbC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791592669; x=1823128669;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p9cyrBB1lb//v3j6VH9pZzZ0tnpAqnbFnAv/R29JFP8=;
  b=fL9dlnbC/SqJ+vgmzC5eSiIGGXRtM14hi+/f7oNBP3AwJ3CoLWF1GiXn
   1CSI29XYj88AOvlDBUcFMDbF6EEjc1NCmOInl3c5l+aTAGvUzx+c+pgKp
   YsS5HDr4owUjVnEkmuWPt0YrOSjY8uVCb7vuR/iDIre+F/uZUhScI3kK8
   +UWCyp/J2EtJNXsgZDPjljeYtoyJlJ01lYH84N3CewdBUsRqF+lRujCM4
   RFqB6ZnhGgliTCCBArTwxxHUeED6zB0cHKMI+k7lcnvADQPZEkwU3eI3Y
   oHz7LRH2AgEuMJRftJOMRySyQmxA0fizhm7wGFmg1ICoxgweg/wBwyXCV
   w==;
X-CSE-ConnectionGUID: STxCFGGlRO63O5APfyqbZQ==
X-CSE-MsgGUID: qEJTVAL/TSOLirH2UeiFKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="389653"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="389653"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 17:37:48 -0700
X-CSE-ConnectionGUID: u7ZzZlXSTLSAFknyV2blHw==
X-CSE-MsgGUID: TiUe6H9eSZGDTJKa3iHe2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="526393"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 09 Oct 2026 17:37:44 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xFL5p-000000006LE-0VcL;
	Sat, 10 Oct 2026 00:37:41 +0000
Date: Sat, 10 Oct 2026 08:37:21 +0800
From: kernel test robot <lkp@intel.com>
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	jjherne@linux.ibm.com, borntraeger@de.ibm.com,
	mjrosato@linux.ibm.com, pasic@linux.ibm.com, alex@shazbot.org,
	kwankhede@nvidia.com, fiuczy@linux.ibm.com, pbonzini@redhat.com,
	frankja@linux.ibm.com, imbrenda@linux.ibm.com,
	agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v8 03/15] s390/vfio-ap: Functions to initialize/release
 vfio device migration data
Message-ID: <202610100839.nL7HIPrm-lkp@intel.com>
References: <20261009114244.1213173-4-akrowiak@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009114244.1213173-4-akrowiak@linux.ibm.com>

Hi Anthony,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kvms390/next]
[also build test WARNING on s390/features mst-vhost/linux-next linus/master v7.3-rc6 next-20261008]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anthony-Krowiak/s390-vfio-ap-Provide-function-to-get-the-number-of-queues-assigned-to-mdev/20261009-074230
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git next
patch link:    https://lore.kernel.org/r/20261009114244.1213173-4-akrowiak%40linux.ibm.com
patch subject: [PATCH v8 03/15] s390/vfio-ap: Functions to initialize/release vfio device migration data
config: s390-defconfig (https://download.01.org/0day-ci/archive/20261010/202610100839.nL7HIPrm-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261010/202610100839.nL7HIPrm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610100839.nL7HIPrm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/s390/crypto/vfio_ap_migration.c:238 function parameter 'matrix_mdev' not described in 'vfio_ap_release_migration_data'
>> Warning: drivers/s390/crypto/vfio_ap_migration.c:238 Excess function parameter 'vdev' description in 'vfio_ap_release_migration_data'
>> Warning: drivers/s390/crypto/vfio_ap_migration.c:238 function parameter 'matrix_mdev' not described in 'vfio_ap_release_migration_data'
>> Warning: drivers/s390/crypto/vfio_ap_migration.c:238 Excess function parameter 'vdev' description in 'vfio_ap_release_migration_data'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
