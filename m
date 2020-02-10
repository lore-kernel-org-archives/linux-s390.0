Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:22014 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbgBJUgu (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 15:36:50 -0500
Date: Tue, 11 Feb 2020 04:36:09 +0800
From: kbuild test robot <lkp@intel.com>
Subject: [s390:fixes 4/6] arch/s390/kernel/processor.c:158:42: error:
 implicit declaration of function 'topology_book_id'; did you mean
 'topology_core_id'?
Message-ID: <202002110402.y8ETTTo6%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="je3bqj6ujcqp2m4a"
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: kbuild-all@lists.01.org, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>


--je3bqj6ujcqp2m4a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git fixes
head:   2ae14b57fa3e7c783ba36de4965634839d706690
commit: 5ef2d0f973e7b1ff50a12c48b0e8214fdc5e5182 [4/6] s390/cpuinfo: add system topology information
config: s390-allnoconfig (attached as .config)
compiler: s390-linux-gcc (GCC) 7.5.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 5ef2d0f973e7b1ff50a12c48b0e8214fdc5e5182
        # save the attached .config to linux build tree
        GCC_VERSION=7.5.0 make.cross ARCH=s390 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/s390/kernel/processor.c: In function 'show_cpu_topo':
>> arch/s390/kernel/processor.c:158:42: error: implicit declaration of function 'topology_book_id'; did you mean 'topology_core_id'? [-Werror=implicit-function-declaration]
     seq_printf(m, "book id         : %d\n", topology_book_id(n));
                                             ^~~~~~~~~~~~~~~~
                                             topology_core_id
>> arch/s390/kernel/processor.c:159:42: error: implicit declaration of function 'topology_drawer_id'; did you mean 'topology_die_id'? [-Werror=implicit-function-declaration]
     seq_printf(m, "drawer id       : %d\n", topology_drawer_id(n));
                                             ^~~~~~~~~~~~~~~~~~
                                             topology_die_id
   cc1: some warnings being treated as errors

vim +158 arch/s390/kernel/processor.c

   153	
   154	static void show_cpu_topo(struct seq_file *m, unsigned long n)
   155	{
   156		seq_printf(m, "physical id     : %d\n", topology_physical_package_id(n));
   157		seq_printf(m, "core id         : %d\n", topology_core_id(n));
 > 158		seq_printf(m, "book id         : %d\n", topology_book_id(n));
 > 159		seq_printf(m, "drawer id       : %d\n", topology_drawer_id(n));
   160		seq_printf(m, "dedicated       : %d\n", topology_cpu_dedicated(n));
   161	}
   162	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--je3bqj6ujcqp2m4a
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--je3bqj6ujcqp2m4a--
