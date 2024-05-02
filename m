Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453D28462
	for <linux-s390@vger.kernel.org>; Thu,  2 May 2024 23:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714691107; cv=none; b=qdoFt5kCRojSWNnVqnHzszi81zjO5XmrXKxZ4nUYmAITg6EDTOpifDYbuUy25JqlJaQomLJhIXoOzM2BSqENc2RRTGnrf/BCU58qamDw2q/9ow8wRr0qPPJdQDJvQWdDJHMYvqQIZXQIfHk6czo/v7zu1L7C8UZTT6Afps1m84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714691107; c=relaxed/simple;
	bh=MPVcnmZTn5myPy90Yqyb5lNdeL6BG4wP9B/f5s2O3GE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YztIJofnMcoSFD7nRPzTyQ6dm/i0t/JLOdVm55D4vR0X3utcXUCP856MXFP4Oqb0lDvLPoiIIzscnLI7QBLBSUiaIpku5VPiVXwMDgVUL3Sq5n+oGVKZt0/dHYfT/10TWR54nSe1LHcz0oyrQUlaATjYtUwJHkzJzS7oAVQdsq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cjvQ8vcb; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cjvQ8vcb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714691106; x=1746227106;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=MPVcnmZTn5myPy90Yqyb5lNdeL6BG4wP9B/f5s2O3GE=;
  b=cjvQ8vcbzud/2D0h+YY0MTAGcPXMdMVfAEc7z/E5mnUbSJBrUPKppCFi
   q/iYN6wk+mYgEpZsYWCy8OUKPu/p14+2lASEfbw2Don+zPZvuw0P1fuT7
   gq4ctzHnm20zOBtDTg4laUYjSnmZQzE9O+GiY8cVYqk1u6ouep/KM9jlQ
   4NIKaqSZE73/WRy5e9MalHm0rroOVyX2mveuBAS/QP7Ke6A1bPCb9JbqU
   tDUqM7POtdcHMI59Ue0RBrZ4icSZ2Vdd+W+jFs7iVYw5WCodNz5L4hscy
   IXrwfv7g5cwK8vUd78R7yLuVGr9rtestMkE38jZhWaF2YxUVvza6WzGj5
   g==;
X-CSE-ConnectionGUID: a/7fNiDUQQCFo3gOeNdiNw==
X-CSE-MsgGUID: HbDvO5esR1aRiy0Nj9+bnQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="13440054"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="13440054"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 16:05:05 -0700
X-CSE-ConnectionGUID: C4fR4l1RSJ+WdJyhwq+U/g==
X-CSE-MsgGUID: NOD1MESLT+m/Vm1HZ1l08g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27359672"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 02 May 2024 16:05:04 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2fU6-000B7i-1N;
	Thu, 02 May 2024 23:05:02 +0000
Date: Fri, 3 May 2024 07:04:21 +0800
From: kernel test robot <lkp@intel.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org
Subject: [s390:features 50/52]
 arch/s390/kvm/../../../virt/kvm/vfio.c:60:(.text+0x186): relocation
 truncated to fit: R_390_PLT32DBL against undefined symbol
 `vfio_file_enforced_coherent'
Message-ID: <202405030642.Dzc41pZn-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
head:   7f20dda18a42526c4ce19c043c5e5f62e6c52d64
commit: 9ecaa2e94e602a3cbcbfe182535f6297f7630b98 [50/52] s390: Relocate vmlinux ELF data to virtual address space
config: s390-randconfig-r026-20230815 (https://download.01.org/0day-ci/archive/20240503/202405030642.Dzc41pZn-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240503/202405030642.Dzc41pZn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405030642.Dzc41pZn-lkp@intel.com/

All errors (new ones prefixed by >>):

   virt/kvm/vfio.o: in function `kvm_vfio_file_enforced_coherent':
>> arch/s390/kvm/../../../virt/kvm/vfio.c:60:(.text+0x186): relocation truncated to fit: R_390_PLT32DBL against undefined symbol `vfio_file_enforced_coherent'
   virt/kvm/vfio.o: in function `kvm_vfio_file_set_kvm':
>> arch/s390/kvm/../../../virt/kvm/vfio.c:46:(.text+0x346): relocation truncated to fit: R_390_PLT32DBL against undefined symbol `vfio_file_set_kvm'
   arch/s390/kvm/../../../virt/kvm/vfio.c:46:(.text+0x582): relocation truncated to fit: R_390_PLT32DBL against undefined symbol `vfio_file_set_kvm'
   virt/kvm/vfio.o: in function `kvm_vfio_file_is_valid':
>> arch/s390/kvm/../../../virt/kvm/vfio.c:76:(.text+0x7f2): relocation truncated to fit: R_390_PLT32DBL against undefined symbol `vfio_file_is_valid'
   virt/kvm/vfio.o: in function `kvm_vfio_file_set_kvm':
   arch/s390/kvm/../../../virt/kvm/vfio.c:46:(.text+0xa26): relocation truncated to fit: R_390_PLT32DBL against undefined symbol `vfio_file_set_kvm'


vim +60 arch/s390/kvm/../../../virt/kvm/vfio.c

ec53500fae421e Alex Williamson 2013-10-30  37  
ba70a89f3c2a82 Jason Gunthorpe 2022-05-04  38  static void kvm_vfio_file_set_kvm(struct file *file, struct kvm *kvm)
2fc1bec1588353 Jike Song       2016-12-01  39  {
ba70a89f3c2a82 Jason Gunthorpe 2022-05-04  40  	void (*fn)(struct file *file, struct kvm *kvm);
2fc1bec1588353 Jike Song       2016-12-01  41  
ba70a89f3c2a82 Jason Gunthorpe 2022-05-04  42  	fn = symbol_get(vfio_file_set_kvm);
2fc1bec1588353 Jike Song       2016-12-01  43  	if (!fn)
2fc1bec1588353 Jike Song       2016-12-01  44  		return;
2fc1bec1588353 Jike Song       2016-12-01  45  
ba70a89f3c2a82 Jason Gunthorpe 2022-05-04 @46  	fn(file, kvm);
2fc1bec1588353 Jike Song       2016-12-01  47  
ba70a89f3c2a82 Jason Gunthorpe 2022-05-04  48  	symbol_put(vfio_file_set_kvm);
2fc1bec1588353 Jike Song       2016-12-01  49  }
2fc1bec1588353 Jike Song       2016-12-01  50  
a905ad043f32bb Jason Gunthorpe 2022-05-04  51  static bool kvm_vfio_file_enforced_coherent(struct file *file)
9d830d47c7a756 Alex Williamson 2014-02-26  52  {
a905ad043f32bb Jason Gunthorpe 2022-05-04  53  	bool (*fn)(struct file *file);
a905ad043f32bb Jason Gunthorpe 2022-05-04  54  	bool ret;
9d830d47c7a756 Alex Williamson 2014-02-26  55  
a905ad043f32bb Jason Gunthorpe 2022-05-04  56  	fn = symbol_get(vfio_file_enforced_coherent);
9d830d47c7a756 Alex Williamson 2014-02-26  57  	if (!fn)
9d830d47c7a756 Alex Williamson 2014-02-26  58  		return false;
9d830d47c7a756 Alex Williamson 2014-02-26  59  
a905ad043f32bb Jason Gunthorpe 2022-05-04 @60  	ret = fn(file);
9d830d47c7a756 Alex Williamson 2014-02-26  61  
a905ad043f32bb Jason Gunthorpe 2022-05-04  62  	symbol_put(vfio_file_enforced_coherent);
9d830d47c7a756 Alex Williamson 2014-02-26  63  
a905ad043f32bb Jason Gunthorpe 2022-05-04  64  	return ret;
9d830d47c7a756 Alex Williamson 2014-02-26  65  }
9d830d47c7a756 Alex Williamson 2014-02-26  66  
b1a59be8a2b64d Yi Liu          2023-07-18  67  static bool kvm_vfio_file_is_valid(struct file *file)
4b22ef042d6f54 Jason Gunthorpe 2022-10-07  68  {
4b22ef042d6f54 Jason Gunthorpe 2022-10-07  69  	bool (*fn)(struct file *file);
4b22ef042d6f54 Jason Gunthorpe 2022-10-07  70  	bool ret;
4b22ef042d6f54 Jason Gunthorpe 2022-10-07  71  
b1a59be8a2b64d Yi Liu          2023-07-18  72  	fn = symbol_get(vfio_file_is_valid);
4b22ef042d6f54 Jason Gunthorpe 2022-10-07  73  	if (!fn)
4b22ef042d6f54 Jason Gunthorpe 2022-10-07  74  		return false;
4b22ef042d6f54 Jason Gunthorpe 2022-10-07  75  
4b22ef042d6f54 Jason Gunthorpe 2022-10-07 @76  	ret = fn(file);
4b22ef042d6f54 Jason Gunthorpe 2022-10-07  77  
b1a59be8a2b64d Yi Liu          2023-07-18  78  	symbol_put(vfio_file_is_valid);
4b22ef042d6f54 Jason Gunthorpe 2022-10-07  79  
4b22ef042d6f54 Jason Gunthorpe 2022-10-07  80  	return ret;
4b22ef042d6f54 Jason Gunthorpe 2022-10-07  81  }
4b22ef042d6f54 Jason Gunthorpe 2022-10-07  82  

:::::: The code at line 60 was first introduced by commit
:::::: a905ad043f32bbb0c35d4325036397f20f30c8a9 vfio: Change vfio_external_check_extension() to vfio_file_enforced_coherent()

:::::: TO: Jason Gunthorpe <jgg@nvidia.com>
:::::: CC: Alex Williamson <alex.williamson@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
