Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794002458;
	b=UfAN2Q1bGdPzpWgZps+ifHgVfbvCNIqg45UxPYNNIi7Q5eGBJBQkTbiMqYQ2UXF+aSiI
	 tV5BiQscW2Z4h7GVjs/x8TOOGz6HFTa6ykHk1gUK+3ktYji+FMQzqxk72vcKiAqEXZKtl
	 QSmxlKYM+gIABYg5xq7s6CLd/5MLiqQCfwN8rlrdhkdfrp/Lt0dqmFnJXTTMhXGGm5ugh
	 S5T6ls4+obxmzzvgB7Cac07IWYZ9bra/3aZ9kvRMuLRYK37IYjQklgaqk3bOAnEyGQT14
	 bBXmvk6E5a/tg/cadQ4SCei5eZ1GMOeKkes9pshbOdRIuWFutAAHr01VnE25ffHzhlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794002458;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=GpB22hhUY2zvJPZHm3rXXr6BOtUtdqjdOzRABACpRsA=;
	b=wOGgTyII7lqIt1rGrT+IXQiEZbqgtGBG6qtcGWyQcACfwh2XyuDUAkvWwfJ5K1k3wY8D
	 LDpYWkk5uqL/AJKRdcXTNh1yQQbZVSUB0Ijki8sLRzW8/Vk5m5Ej+CJyw3Zf+Zneq7m9I
	 1t4JzlQyFFvLTiTiXY1gYNAtST60tQuw0p+yJsOoxdsv4PK/KJh/z3aZdzWc253HIc4Sy
	 3qUMA+UJzx87BZ39bduHTZewqcp5MYGhp8UI9Tl93ryx/mVKXvBR/vO6FUFNX3na4zRxN
	 gVjzejOGF1KFP7ffTx9Hqk5JhjRIEy4VkUW5Wh6USv/VoxqW5AnKQupUCSKnKU0tuxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kssO6CkJ;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD093606A32C
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 22:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD093606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=kssO6CkJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794002458; x=1825538458;
  h=date:from:to:cc:subject:message-id;
  bh=aAp6Tu7QcFopIFffjieEDnZkJKOKlsAtEygrBAHSvy8=;
  b=kssO6CkJzQXpWs++EcSsJpHsNQndv5F74nVfg1KoOgMASFE0bgm8tYHj
   0oBcWMg5r8Cm+CiAMvs5tiLxiCuRYlHoaaIoiXisMatFOYCzqvRdjCOe+
   3GPeyfH72FikAoYbLFXw+0pc3QsulKoZHw+I5l8Q03Xk7I7hhAvb0yJrw
   6S3FWQZAN76lMF+6A2SrTsslYeTeoJ0mpxmI72irpAGGKjLMQ7btL3Tl4
   ANt99CzlMnyINQZg73ZDNAkILo5rhpfdwfsh67Rb9Wi+s6rr50DvmG812
   31vY+j63Op3yGQfyoBdnE5v+QrVKhr5025qqt8oRyVmIf/q9KsZcYleAm
   g==;
X-CSE-ConnectionGUID: AVb9B5pVQOmxxnSppk2DQg==
X-CSE-MsgGUID: xtFW6bYoReCW5mrXxkx01Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2813319"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2813319"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 14:00:57 -0800
X-CSE-ConnectionGUID: jlRyCy4wSmirlNzBw9ed7w==
X-CSE-MsgGUID: kiloUs9BR4+6YZjzcOEAYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="9147850"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c) ([10.211.93.152])
  by fmviesa011.fm.intel.com with ESMTP; 06 Nov 2026 14:00:53 -0800
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPRzN-00000000ANH-48dX;
	Fri, 06 Nov 2026 22:00:49 +0000
Date: Fri, 06 Nov 2026 23:00:36 +0100
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
 Janosch Frank <frankja@linux.ibm.com>,
 Andreas Grapentin <gra@linux.ibm.com>
Subject: [kvms390:sae 28/28] arch/s390/kernel/aef.c:79:1: sparse:
 sparse: symbol 'bin_attr_qmc' was not declared. Should it be static?
Message-ID: <202611062241.QRhwhHK0-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae
head:   2abfa741008fd96c3684c316a2f5f37d3bb7bd8b
commit: 6f0139f1ab685b923aadef3e1653c6f3b2f963c0 [28/28] s390: Report AEF features to sysfs
config: s390-randconfig-r2307-20261106 (https://download.01.org/0day-ci/archive/20261106/202611062241.QRhwhHK0-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
sparse: v0.6.5-rc1-21-g84ec0658
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611062241.QRhwhHK0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611062241.QRhwhHK0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/s390/kernel/aef.c:79:1: sparse: sparse: symbol 'bin_attr_qmc' was not declared. Should it be static?
>> arch/s390/kernel/aef.c:89:1: sparse: sparse: symbol 'bin_attr_save_area' was not declared. Should it be static?

vim +/bin_attr_qmc +79 arch/s390/kernel/aef.c

    78	
  > 79	BIN_ATTR_RO(qmc, sizeof(qmc));
    80	
    81	static ssize_t save_area_read(struct file *filp, struct kobject *kobj,
    82				      const struct bin_attribute *attr, char *buf,
    83				      loff_t off, size_t count)
    84	{
    85		return memory_read_from_buffer(buf, count, &off, &save_area,
    86					       sizeof(save_area));
    87	}
    88	
  > 89	BIN_ATTR_RO(save_area, sizeof(save_area));
    90	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
