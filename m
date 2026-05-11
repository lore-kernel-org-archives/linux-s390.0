Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253D6361DC4
	for <linux-s390@vger.kernel.org>; Mon, 11 May 2026 07:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484643; cv=none; b=lyFDZEz6uLukuWFLRwH3JKY3+WN7U6SdDPYB5qMOAC/tzY1Znx0Wq2xwSuQIRPkoV4/e08WTZbFg6uzesm04wJx2Pi0yrklMzs4eNctw/9VB/opWFqoyykGYngRmp+55MxXtaroVFlvrFzfog9F/T2Ipa6db6P2qI9YfO75kWiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484643; c=relaxed/simple;
	bh=CpMvhdo+J60FNpHcDY2ewfcpaNliAezZ79OgZTm6aY4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=heGIDEnaR/wbYpNme4ATJQT+SnnifvJDMBUnKRE+PvFXPCiYOh+1Q5PVFfCxUXsHbCf7zxj+fPkl3a73SlCRXhjkHaVr88mfOK9zNbz7rpDhHtUg1cLdDWJeXpEbYMuLJVigjQDQymKzOewgjtuC35Sc5k5wjutoD7A6DPVnqzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XymnH9gf; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XymnH9gf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778484642; x=1810020642;
  h=date:from:to:cc:subject:message-id;
  bh=CpMvhdo+J60FNpHcDY2ewfcpaNliAezZ79OgZTm6aY4=;
  b=XymnH9gfnGDVVEgIxwlK4qh59ze5vlYtpGKnWJAAVcjboUHUytyQ4IX3
   A0wWlrpDGBNZxpdYJylzFVbVMRDuJaq1bJoGrZFhWV30vqPHAM0WqyyWZ
   REPkkVjNhTS+AL7Ao25JLujhy3IY6+Uw4pDBzb9u2CChZnkzyOla8swNx
   A1Og1h7m7ZAHScDceFv+2Q6xwtvEbx2bn50NWo8uAfCR/cbOM/TgWHx75
   yAtBIv9AiYT1d4kUjXn1HU0TxyM64NfWEHFEH46AOKMvIG+bkzqpFkubx
   v28vryOtT78pbdIBFgGxRoJsqQndKrHNwon4N7FTq9a1ux2gxgI5QDKa7
   w==;
X-CSE-ConnectionGUID: pG5SWJNVS0WGWykPW9n06g==
X-CSE-MsgGUID: XEBKcJuySnu7D0uB+bjF8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="90466818"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="90466818"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 00:30:42 -0700
X-CSE-ConnectionGUID: dxaxsStESu2xijGyUrnARA==
X-CSE-MsgGUID: SIeSLwIVToe3ZNLateefCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="275514498"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 May 2026 00:30:40 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wML65-000000000Hx-0clR;
	Mon, 11 May 2026 07:30:37 +0000
Date: Mon, 11 May 2026 15:30:34 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-s390@vger.kernel.org, Andreas Grapentin <gra@linux.ibm.com>,
 "Nina Schoetterl-Glausch" <nsg@linux.ibm.com>,
 Gautam Gala <ggala@linux.ibm.com>
Subject: [kvms390:sae 28/55] llvm-objcopy: error: invalid output
 format: 'default'
Message-ID: <202605111549.DhlmEfUt-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae
head:   23885833f845ad11c99c4f458692250fc75908c5
commit: 0d010e09246a92968849aa24dbde1e27370b0e1e [28/55] KVM: s390: arm64: Enable KVM_ARM64 config and Kbuild
config: s390-randconfig-002-20260511 (https://download.01.org/0day-ci/archive/20260511/202605111549.DhlmEfUt-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260511/202605111549.DhlmEfUt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605111549.DhlmEfUt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> llvm-objcopy: error: invalid output format: 'default'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
