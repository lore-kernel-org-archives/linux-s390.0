Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795845137;
	b=yWf+A+oF8nMBZl+AIV6+k5zKU3EyBxh92iMcSZMrHMJzxM30TLlUN1kf1hqOnu29BRZQ
	 XuB8X7qf1wOb3PHVnoy/EZs0pQIX2ivhGU+dT6jYElBGVv+N8BP6DvnfA00EddxHmOctQ
	 dRMzE0RpmHd8Wc47UbLepRrFFmjj8OzHX85TXS29rUWlqinABmldgESB5fDHTSdG3AJRR
	 yVnEnzg0RqUcbl+GD+RCfTWQ4YUsHKT9XqBufzJDJaT9pjNv95HvY859j9fmG7lWVYApp
	 KYGhORYRo66Bliy8tWK+Sg2FdYz9fWsOULCjEtpSiPrfWW0NEyDhpdx09OVKREnPWag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795845137;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:User-Agent;
	bh=ab+lSdPJaU2a4nuLI1R1HyzlOGrxxkzdOiE4XIkUwes=;
	b=kShKM2pFmDyXUu+MBEGaKEIaIDZXLjfxzKH+3+GVZxpgxWGEKLOwnrp40vGvaQa2KK40
	 JMLmyTy+qGP3A5/Kf6V3MPUtpb5VmqTEt8NiLWDACI+hjgbUuVV8v9g3gD7BdmfFfqQsx
	 KSSzsjjIZYOxyGJ4ua7whNkY1ln0v88p9qbwA/kIxDqCyMDwDdEEHyOw75Vf+TP68pfsK
	 5aYbTQf90W9iU6Pwy2YdCppz/+lcpUJ1XwtBZrNxaYmBbYUj7K6Il845fFiLMeBWH4lx6
	 tA3+t0TJbRFkPDF/B+90k5QPxMWinrO4vgtt6cJI3+c7/F7sRBFdL7SiLFOXNcwCQpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="BRy8Gr/g";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EDE606A31C
	for <linux-s390@vger.kernel.org>; Sat, 28 Nov 2026 05:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48EDE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BRy8Gr/g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795845136; x=1827381136;
  h=date:from:to:cc:subject:message-id;
  bh=/MeIyFIjjUYrlGHYXOz9kG56tnOateDy4/A4wCUYnO0=;
  b=BRy8Gr/gvKfG4RSQQ7IG6ZxvXiwlIo8VBcgtGYlUtzPE59VxLUFgMyFi
   RnlOxv7eyeFAqeC4Iy1XTtaXJ2ng/WyZkyBga/SY8hDe2IF4KmhKXPeJq
   4cfpRKzdcJ/W2MVjnE3S/uwmtaR+7zpqVZ2ZCymthrcT6+bUtN7S1AAEc
   Z5TSK7tYwimAAfRBxCympOxd99XDbDNkqp1/D5gWxgq/YVrCiT5u/ZimQ
   m80TGY0jT4Teo75HaebOi+OJUp9Qh1X3mGesFy9+okUDwMT85ZoZn2Ljp
   qdgJtVgZY/AZaIlCpiZgON9z22nKc8JVUPZnUf0EJesxdm0eBqnOGIyvZ
   g==;
X-CSE-ConnectionGUID: z3a8hE2wRb+BnkdfA/NwOQ==
X-CSE-MsgGUID: RalheOq4Spil9Ajiy7uxhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4761306"
X-IronPort-AV: E=Sophos;i="6.27,238,1787036400"; 
   d="scan'208";a="4761306"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 21:52:16 -0800
X-CSE-ConnectionGUID: BwOIQU14TH6r2+JfsC6IIA==
X-CSE-MsgGUID: UAyH73qMTYy3xqEW1qmXeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,238,1787036400"; 
   d="scan'208";a="12513993"
Received: from igk-lkp-server01.igk.intel.com (HELO 146cf1e082f1) ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 27 Nov 2026 21:52:14 -0800
Received: from kbuild by 146cf1e082f1 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xXBM3-000000000WQ-3toi;
	Sat, 28 Nov 2026 05:52:11 +0000
Date: Sat, 28 Nov 2026 06:52:07 +0100
From: kernel test robot <lkp@intel.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [s390:for-next 2/3] arch/s390/kernel/machine_kexec.c:162:17:
 warning: ignoring return value of 'set_memory_ro' declared with attribute
 'warn_unused_result'
Message-ID: <20261128064234.Tufw6OTb-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-next
head:   e8f20a7b5952e0d5f12f11af4966092242ce7f81
commit: fd5d165900beb00e33763af707cb9be32367e217 [2/3] Merge branch 'features' into for-next
config: s390-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20261128/20261128064234.Tufw6OTb-lkp@intel.com/config)
compiler: s390x-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261128/20261128064234.Tufw6OTb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261128064234.Tufw6OTb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   arch/s390/kernel/machine_kexec.c: In function 'crash_protect_pages':
>> arch/s390/kernel/machine_kexec.c:162:17: warning: ignoring return value of 'set_memory_ro' declared with attribute 'warn_unused_result' [-Wunused-result]
     162 |                 set_memory_ro(addr, size >> PAGE_SHIFT);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/s390/kernel/machine_kexec.c:164:17: warning: ignoring return value of 'set_memory_rw' declared with attribute 'warn_unused_result' [-Wunused-result]
     164 |                 set_memory_rw(addr, size >> PAGE_SHIFT);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +162 arch/s390/kernel/machine_kexec.c

2d0af2247906cf Heiko Carstens            2016-05-31  151  
4e042af463f806 Heiko Carstens            2016-05-31  152  static void crash_protect_pages(int protect)
dab7a7b1538fec Michael Holzheu           2011-10-30  153  {
a07bc01bec2337 Mike Rapoport (Microsoft  2026-11-17  154) 	unsigned long addr, size;
21f8d19ddeb3c0 Heiko Carstens            2026-11-18  155  	int rc;
dab7a7b1538fec Michael Holzheu           2011-10-30  156  
4e042af463f806 Heiko Carstens            2016-05-31  157  	if (!crashk_res.end)
4e042af463f806 Heiko Carstens            2016-05-31  158  		return;
a07bc01bec2337 Mike Rapoport (Microsoft  2026-11-17  159) 	addr = (unsigned long)__va(crashk_res.start);
4e042af463f806 Heiko Carstens            2016-05-31  160  	size = resource_size(&crashk_res);
4e042af463f806 Heiko Carstens            2016-05-31  161  	if (protect)
a07bc01bec2337 Mike Rapoport (Microsoft  2026-11-17 @162) 		set_memory_ro(addr, size >> PAGE_SHIFT);
a9fbf1a53836d4 Michael Holzheu           2012-05-18  163  	else
a07bc01bec2337 Mike Rapoport (Microsoft  2026-11-17 @164) 		set_memory_rw(addr, size >> PAGE_SHIFT);
21f8d19ddeb3c0 Heiko Carstens            2026-11-18  165  	if (rc)
21f8d19ddeb3c0 Heiko Carstens            2026-11-18  166  		pr_warn("Failed to %sprotect crashkernel memory: %d\n",	protect ? "" : "un", rc);
dab7a7b1538fec Michael Holzheu           2011-10-30  167  }
dab7a7b1538fec Michael Holzheu           2011-10-30  168  

:::::: The code at line 162 was first introduced by commit
:::::: a07bc01bec2337151166442b15047b8861c4b23e s390/kdump: Write protect the crash kernel memory by its virtual address

:::::: TO: Mike Rapoport (Microsoft) <rppt@kernel.org>
:::::: CC: Alexander Gordeev <agordeev@linux.ibm.com>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
