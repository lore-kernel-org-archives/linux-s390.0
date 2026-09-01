Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5E93A381C
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788297881; cv=none; b=ubVgXbdXOHmmXjjEipre+OcBY0gNW5/RrqtIQkabUFA+Y7+tWZrkMTuGBrc2+VH1vwd12pQVRXMFN8pRV8kUAiy3w1Q0l/LT+1Z1I3sN1mLpJoglj/yUChfUS8aZ8wP/V0h8Ghu/YaCqb40LYZ/i4LMHk1JgW6f/qLPqGprmO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788297881; c=relaxed/simple;
	bh=1TaDDlib/ind8bEndJR97bfpyKBISIC1rLJNN0pTeIw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Wdbq9AHn1/56KpKQsl2hPCvDh8cy58/CuoB2aX1efbwW2MPtggVSPD+xRnR3oWDH8Rd3fceAj3xvYwZcIrgTNLgoUKP8Mhh+rQAyl/v2JnDdZupHxTj6nXrVXmDgwHPDmKaiHasdksSBr0SjqRdt4NI3rzigIupGR/teAVP1Vos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QJSGofUj; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QJSGofUj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788297879; x=1819833879;
  h=date:from:to:cc:subject:message-id;
  bh=1TaDDlib/ind8bEndJR97bfpyKBISIC1rLJNN0pTeIw=;
  b=QJSGofUjUrUxJb6rWIjh3icS+2kTflglTfo9yX+0oweGknaElnNh7YM2
   h1r6boat/kYHTTIFYF4BCIYQ2U0yN9pIY/l7ylBREDSrtDAcVTLTMNoje
   LxYPnwW7Wg+sGhFu5tsISRCdYPBx+yuxJpxVCDo3kxCtuZvcc07Iibjie
   OJo6xupTHFmSFONQzWvPmPSI5YIZkAWMqks1kKXN2tnLZf7+xQu6tHOpi
   b65N8Wea+OZq2NJMH/EChi2AAmhEaOKEmO6Kgw6V1ToZvJpBmrf29uxWM
   fUM6hb1AGBl12l3DxnOyw+jFRSDSurKZjSsxfDwNmDT0zTQI6IuQ76GB0
   Q==;
X-CSE-ConnectionGUID: adTHWDkTTjqwXYcAcHW5qA==
X-CSE-MsgGUID: m7KJ/aoUSFS4rmjR/0Xmfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87683339"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="87683339"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 14:24:38 -0700
X-CSE-ConnectionGUID: QrWQJvoFTSeErf5ilgAInQ==
X-CSE-MsgGUID: TwDpVbSLTgGNpq+I3EMcXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; 
   d="scan'208";a="272989775"
Received: from lkp-server01.sh.intel.com (HELO bfac249b2189) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 01 Sep 2026 14:24:37 -0700
Received: from kbuild by bfac249b2189 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x1Vy6-000000001X8-0ut6;
	Tue, 01 Sep 2026 21:24:34 +0000
Date: Wed, 02 Sep 2026 05:23:57 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
 Sean Christopherson <seanjc@google.com>,
 "Jason J. Herne" <jjherne@linux.ibm.com>
Subject: [kvms390:sae 1/43] drivers/vfio/vfio_main.c:1554:29: error:
 passing argument 2 of 'vfio_group_set_kvm' from incompatible pointer type
Message-ID: <202609020524.2vsc6rBO-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git sae
head:   e3cbc45b3834d68c7e45ba1562f45af312c99d81
commit: 457efc947019e9f93ce012b857f567189b9d382d [1/43] vfio: Use file-based reference counting for KVM
config: arm-randconfig-r051-20260901 (https://download.01.org/0day-ci/archive/20260902/202609020524.2vsc6rBO-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260902/202609020524.2vsc6rBO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609020524.2vsc6rBO-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/vfio/vfio_main.c: In function 'vfio_file_set_kvm':
>> drivers/vfio/vfio_main.c:1554:29: error: passing argument 2 of 'vfio_group_set_kvm' from incompatible pointer type [-Werror=incompatible-pointer-types]
      vfio_group_set_kvm(group, kvm);
                                ^~~
   In file included from drivers/vfio/vfio_main.c:43:
   drivers/vfio/vfio.h:168:77: note: expected 'struct kvm *' but argument is of type 'struct file *'
    static inline void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm)
                                                                    ~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/vfio_group_set_kvm +1554 drivers/vfio/vfio_main.c

34aeeecdb3357f9 Yi Liu        2023-07-18  1539  
b1a59be8a2b64d0 Yi Liu        2023-07-18  1540  /**
b1a59be8a2b64d0 Yi Liu        2023-07-18  1541   * vfio_file_set_kvm - Link a kvm with VFIO drivers
457efc947019e9f Steffen Eiden 2026-08-12  1542   * @vfio_file: VFIO group file or VFIO device file
457efc947019e9f Steffen Eiden 2026-08-12  1543   * @kvm: KVM file to link
b1a59be8a2b64d0 Yi Liu        2023-07-18  1544   *
b1a59be8a2b64d0 Yi Liu        2023-07-18  1545   * When a VFIO device is first opened the KVM will be available in
b1a59be8a2b64d0 Yi Liu        2023-07-18  1546   * device->kvm if one was associated with the file.
b1a59be8a2b64d0 Yi Liu        2023-07-18  1547   */
457efc947019e9f Steffen Eiden 2026-08-12  1548  void vfio_file_set_kvm(struct file *vfio_file, struct file *kvm)
b1a59be8a2b64d0 Yi Liu        2023-07-18  1549  {
b1a59be8a2b64d0 Yi Liu        2023-07-18  1550  	struct vfio_group *group;
b1a59be8a2b64d0 Yi Liu        2023-07-18  1551  
457efc947019e9f Steffen Eiden 2026-08-12  1552  	group = vfio_group_from_file(vfio_file);
b1a59be8a2b64d0 Yi Liu        2023-07-18  1553  	if (group)
b1a59be8a2b64d0 Yi Liu        2023-07-18 @1554  		vfio_group_set_kvm(group, kvm);
34aeeecdb3357f9 Yi Liu        2023-07-18  1555  
457efc947019e9f Steffen Eiden 2026-08-12  1556  	if (vfio_device_from_file(vfio_file))
457efc947019e9f Steffen Eiden 2026-08-12  1557  		vfio_device_file_set_kvm(vfio_file, kvm);
b1a59be8a2b64d0 Yi Liu        2023-07-18  1558  }
b1a59be8a2b64d0 Yi Liu        2023-07-18  1559  EXPORT_SYMBOL_GPL(vfio_file_set_kvm);
b1a59be8a2b64d0 Yi Liu        2023-07-18  1560  

:::::: The code at line 1554 was first introduced by commit
:::::: b1a59be8a2b64d00409dc7c9d523572ed32bcff8 vfio: Refine vfio file kAPIs for KVM

:::::: TO: Yi Liu <yi.l.liu@intel.com>
:::::: CC: Alex Williamson <alex.williamson@redhat.com>

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
