Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297193AFD02
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 22:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788301063; cv=none; b=o+OQGHUV/MtFvyrd3myS6+236WOU/bKnUdHgJHKUa+dt8Rc1aiG+OV/YIUMPVPMh4CSVVcNPP+Nv+3oWFhiEED1mQYwu117wl2J3aAPNcQFY9LQAItH2+ZyNIWR5sLPqET944r5guNsUL3eHSREk/ieDYvamrsUzMfpdtSVzzyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788301063; c=relaxed/simple;
	bh=fi5+aacIxoyIhHCtTxJSRZq1FobSMzqDFquwJVHzMfU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=PknpvPXx3gyjOtb3U4BNzvLBuom5MLwzaTqHUpUWPMMGNx6M9AXWYrzbXU/JWIM23vis0kNLHFhmvfWp17QDyO+wHkZQ7sPOw7TI/2y+L9F9+MXx2iuf2cAMb8avZIHFfzjer3JM8nakzjW8tdnTCGqSpLH97HzXG7RKirrrLWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=at3zDvC/; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="at3zDvC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788301061; x=1819837061;
  h=date:from:to:cc:subject:message-id;
  bh=fi5+aacIxoyIhHCtTxJSRZq1FobSMzqDFquwJVHzMfU=;
  b=at3zDvC/rnPvy2QCPrqEsTcWyOt4F9ieM5Y8OXsaIpu3LZLyuYJd9gIv
   HAXiLBVrpabEUoAx9fWFA42wQ42IELbvzCB6LQOOeEtooz9t07EX9svWd
   TFNwW78O3yAFdOKfLB5k0qSaqih2ZnXPYfh2v1vM1TPD2KfbGxKvRBLmk
   +6B2CrfOGeQylv5pHC2r6n4/ZWKL4iIfaOEiVlDu3X7Wqib2klMVieirw
   oCpDpIduuV62FWGnRoNZeM4kVhUHAYjCiemFvDKB/FLx/dC5fCpMjq73K
   LRzbEftGbXv9sJjM1egsFixnK1MUyX+RHbWoNPN2YUWIZ5DpoAkdi7wH6
   Q==;
X-CSE-ConnectionGUID: rge2yFKsQjmmb+Fmrz/V6A==
X-CSE-MsgGUID: 9PwevUBeQ8aJKlAeIdeUXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88951848"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="88951848"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 15:17:40 -0700
X-CSE-ConnectionGUID: ZeibHuehSDqVLVlSEszJPw==
X-CSE-MsgGUID: joJuF778QCCD7d5TtVPU6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="294058924"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 01 Sep 2026 15:17:39 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1WnQ-000000001Zq-2y72;
	Tue, 01 Sep 2026 22:17:36 +0000
Date: Wed, 02 Sep 2026 06:16:53 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-s390@vger.kernel.org, Andreas Grapentin <gra@linux.ibm.com>
Subject: [kvms390:sae 34/43] Warning: arch/s390/kernel/aef.c:25
 function parameter 'sa' not described in 'kvm_vcpu_init_save_area'
Message-ID: <202609020610.X8okomyb-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae
head:   e3cbc45b3834d68c7e45ba1562f45af312c99d81
commit: 25a6a0afc2f7d6a10555783deba6300978693a84 [34/43] KVM: s390: arm64: Query Available Arm features
config: s390-allnoconfig (https://download.01.org/0day-ci/archive/20260902/202609020610.X8okomyb-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 678058af7da6a20593d8bb23076dc4773f9e55f1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260902/202609020610.X8okomyb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609020610.X8okomyb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: arch/s390/kernel/aef.c:25 function parameter 'sa' not described in 'kvm_vcpu_init_save_area'
>> Warning: arch/s390/kernel/aef.c:25 expecting prototype for kvm_init_save_area(). Prototype was for kvm_vcpu_init_save_area() instead

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
