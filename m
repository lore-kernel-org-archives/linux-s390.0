Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD903CCFC4;
	Wed, 25 Mar 2026 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774441116; cv=none; b=jsQzbBN+8gwC0sgoY4Je577OFjDEOg8ZjmJYRTwL77FfocpiWxXkGZ8P8ew2TWt4ihGWhrKt4gcYO4yoQyRdSNmoA04IE+rxBfkAEXIcssHSWeXt9qLX9DyfoezHehGNqdxOcHu/oqnRTPpnqGNpnLhJRGq5nxuZIqDRD38bhlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774441116; c=relaxed/simple;
	bh=JGE39YxQ0nxW3TreMOoAiPOjtCFSRAiNbRwjPQ5P61o=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KFFFaBPzhShqINhhd9f4pC6ebh5ORw2V1yxGaWhw6tKi78E8KCRM0Td1AD8HqeJEVxj5MojhVdnEVldA5Iv4wvYg2U+Thynu0dIxyEsoO86mseqmyZOv4I/LnWvWS2lZgj2jEES1Q75Z94jyxXGCLGCVozNHix4cbPZKxSetzIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/lxbSXU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/lxbSXU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774441114; x=1805977114;
  h=date:from:to:cc:subject:message-id;
  bh=JGE39YxQ0nxW3TreMOoAiPOjtCFSRAiNbRwjPQ5P61o=;
  b=g/lxbSXUBEMyvIMTffAgI34Q+1po330M54gKLePXSkLoxguQ1eSfm5J0
   6Kd/RSkwFj6ikPMFAiRJdWBe8bEpfiNTbajqfa6dByAL182COWM3x/jY3
   BCGLAt9N4Ff5yKU0jjNeR/qTiv4jxP6xQBHXHa20AA0mk8cNdz7icj3YX
   4y05WrzLSFIn2Ha+f0TPs7uGQpdU3JBR9CHmknkSFFG9IWrOkGONgHg6e
   nlQZ8PJQ9QgG1U3ZXHSit4f6s2kxlMJF3uUpFN2wIdMLSE+Rgq6Wz6RGK
   vIIyZ0ptE5SHqyFkKT6TMptBkPf3Z/pPWq0lgmVOGzm0rrYN5F4XDUEOX
   Q==;
X-CSE-ConnectionGUID: Y/lncvXYTV+qd1oYrPKZCQ==
X-CSE-MsgGUID: KGcHv+69QwGITDdHZjVHTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86553464"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="86553464"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 05:18:34 -0700
X-CSE-ConnectionGUID: dDxz0SJ/RZmOF9+kCWoxoA==
X-CSE-MsgGUID: zYe+N82fTC+djKnhNXPqgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="248183384"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 25 Mar 2026 05:18:32 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5NBt-000000006nJ-3xpa;
	Wed, 25 Mar 2026 12:18:29 +0000
Date: Wed, 25 Mar 2026 20:18:17 +0800
From: kernel test robot <lkp@intel.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
 Holger Dengler <dengler@linux.ibm.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>, linux-doc@vger.kernel.org
Subject: [s390:features 6/11] Warning:
 drivers/s390/crypto/zcrypt_msgtype6.c:1253 This comment starts with '/**',
 but isn't a kernel-doc comment. Refer to
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202603252022.vEojGo3V-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
head:   2a0a1db5081df02d6753deb1826fd3932a1ab168
commit: 23a4757d6d699e602b358808359149d0e8be6db9 [6/11] s390/zcrypt: Move inline function rng_type6cprb_msgx from header to code
config: s390-randconfig-001-20260325 (https://download.01.org/0day-ci/archive/20260325/202603252022.vEojGo3V-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 054e11d1a17e5ba88bb1a8ef32fad3346e80b186)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260325/202603252022.vEojGo3V-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603252022.vEojGo3V-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/s390/crypto/zcrypt_msgtype6.c:1253 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * Prepare a type6 CPRB message for random number generation

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
