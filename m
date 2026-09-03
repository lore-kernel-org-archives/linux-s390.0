Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9062F9D82
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 01:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788399321; cv=none; b=jqz34PPmaSE4LXd1TzP+BIi5D4L4gTfJnGed2JjG5bfHX59mf02kfrrG5kvKrv93PaWKeFS3tDxT5WvYBqa8uzu6WPsiUeKtf9txlMHXP5ZNRn65kKdz80Mni/4/iBduHaSTtFDJc6REVTRFxxnT3JCXgTQTbYQ273/1LsMqUAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788399321; c=relaxed/simple;
	bh=BiclmM8iw6AMEgvSeIq0Hkwnb1G9XjDo4lHjSIYyXNM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=taMSPXG4M0fn07PTYYXsHAMBN/dmBGjun95Pap8SRFzVs+FV25rmWdg7Hbo/mpa0ZENCUrL9477aCpHhCmBLQabYsiGFfzVCEUeJmlS2SNE3X1o7Y74TnbsT/FU6uQw0HxKBi9Sfc8rbLKdN15ZIIFBhK3It5U2CIISUMaz9zoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBYSlifH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBYSlifH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788399318; x=1819935318;
  h=date:from:to:cc:subject:message-id;
  bh=BiclmM8iw6AMEgvSeIq0Hkwnb1G9XjDo4lHjSIYyXNM=;
  b=EBYSlifH6MSlmtyLlNdm+M8/Fn1a/oGL/hrqCuYBce/NWpbmdx7ogJZX
   7UM+S1L1QHGzJKmX3GQrjDSeiIo87VznB6wdfW30TnRwN+otEkN1JCMiu
   RmguRUTvc6ALVcFPR7AQZgHb1KsEMV15S1jgOzjRMVNSrvzZmvLgDx5aW
   PMcOR69c25GuGpYxZjtZalE3TOHHSYAI3mes9iRJmrhcQP4tztukkSDTb
   3Lu1A8sdoQ9dmFq5b+WZGgxrSdqvZWJTYL5SMlXTQuzBbd4QVn4M6AlDe
   f/3x9Et5DTJFgfPRb+TZ0iPfafNAgYM4/huN6tLFvZiwAoiQsZbIykiDn
   g==;
X-CSE-ConnectionGUID: NQhYDKfzSOeU82uhGF7pPw==
X-CSE-MsgGUID: kV9Flk1GScKpTPVc3MdP0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88902799"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="88902799"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 18:35:17 -0700
X-CSE-ConnectionGUID: mlhbUa6OT12nQKyzN6/4Bg==
X-CSE-MsgGUID: nhWirXL+RDOA6g1ahJq2yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="299439800"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 02 Sep 2026 18:35:16 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1wMD-000000003aC-13CH;
	Thu, 03 Sep 2026 01:35:13 +0000
Date: Thu, 03 Sep 2026 09:34:27 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>
Subject: [kvms390:sae 1/43] drivers/vfio/vfio_main.c:1554:29: error:
 incompatible pointer types passing 'struct file *' to parameter of type
 'struct kvm *'
Message-ID: <202609030916.sgfe1yXN-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae
head:   e3cbc45b3834d68c7e45ba1562f45af312c99d81
commit: 457efc947019e9f93ce012b857f567189b9d382d [1/43] vfio: Use file-based reference counting for KVM
config: hexagon-randconfig-r063-20260903 (https://download.01.org/0day-ci/archive/20260903/202609030916.sgfe1yXN-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260903/202609030916.sgfe1yXN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609030916.sgfe1yXN-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/vfio/vfio_main.c:1554:29: error: incompatible pointer types passing 'struct file *' to parameter of type 'struct kvm *' [-Werror,-Wincompatible-pointer-types]
    1554 |                 vfio_group_set_kvm(group, kvm);
         |                                           ^~~
   drivers/vfio/vfio.h:168:77: note: passing argument to parameter 'kvm' here
     168 | static inline void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
         |                                                                             ^
   1 error generated.


vim +1554 drivers/vfio/vfio_main.c

34aeeecdb3357f Yi Liu        2023-07-18  1539  
b1a59be8a2b64d Yi Liu        2023-07-18  1540  /**
b1a59be8a2b64d Yi Liu        2023-07-18  1541   * vfio_file_set_kvm - Link a kvm with VFIO drivers
457efc947019e9 Steffen Eiden 2026-08-12  1542   * @vfio_file: VFIO group file or VFIO device file
457efc947019e9 Steffen Eiden 2026-08-12  1543   * @kvm: KVM file to link
b1a59be8a2b64d Yi Liu        2023-07-18  1544   *
b1a59be8a2b64d Yi Liu        2023-07-18  1545   * When a VFIO device is first opened the KVM will be available in
b1a59be8a2b64d Yi Liu        2023-07-18  1546   * device->kvm if one was associated with the file.
b1a59be8a2b64d Yi Liu        2023-07-18  1547   */
457efc947019e9 Steffen Eiden 2026-08-12  1548  void vfio_file_set_kvm(struct file *vfio_file, struct file *kvm)
b1a59be8a2b64d Yi Liu        2023-07-18  1549  {
b1a59be8a2b64d Yi Liu        2023-07-18  1550  	struct vfio_group *group;
b1a59be8a2b64d Yi Liu        2023-07-18  1551  
457efc947019e9 Steffen Eiden 2026-08-12  1552  	group = vfio_group_from_file(vfio_file);
b1a59be8a2b64d Yi Liu        2023-07-18  1553  	if (group)
b1a59be8a2b64d Yi Liu        2023-07-18 @1554  		vfio_group_set_kvm(group, kvm);
34aeeecdb3357f Yi Liu        2023-07-18  1555  
457efc947019e9 Steffen Eiden 2026-08-12  1556  	if (vfio_device_from_file(vfio_file))
457efc947019e9 Steffen Eiden 2026-08-12  1557  		vfio_device_file_set_kvm(vfio_file, kvm);
b1a59be8a2b64d Yi Liu        2023-07-18  1558  }
b1a59be8a2b64d Yi Liu        2023-07-18  1559  EXPORT_SYMBOL_GPL(vfio_file_set_kvm);
b1a59be8a2b64d Yi Liu        2023-07-18  1560  

:::::: The code at line 1554 was first introduced by commit
:::::: b1a59be8a2b64d00409dc7c9d523572ed32bcff8 vfio: Refine vfio file kAPIs for KVM

:::::: TO: Yi Liu <yi.l.liu@intel.com>
:::::: CC: Alex Williamson <alex.williamson@redhat.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
