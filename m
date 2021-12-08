Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C58C433F5
	for <linux-s390@archiver.kernel.org>; Wed,  8 Dec 2021 07:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244592AbhLHH6O (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Dec 2021 02:58:14 -0500
Received: from mga07.intel.com ([134.134.136.100]:51676 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244593AbhLHH6N (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 8 Dec 2021 02:58:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="301162514"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="301162514"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 23:54:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="461607560"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 07 Dec 2021 23:54:35 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1murmc-0000FS-Tx; Wed, 08 Dec 2021 07:54:34 +0000
Date:   Wed, 8 Dec 2021 15:53:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     kbuild-all@lists.01.org, alex.williamson@redhat.com,
        cohuck@redhat.com, schnelle@linux.ibm.com, farman@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com
Subject: Re: [PATCH 14/32] KVM: s390: pci: do initial setup for AEN
 interpretation
Message-ID: <202112081547.UVwzE8hh-lkp@intel.com>
References: <20211207205743.150299-15-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207205743.150299-15-mjrosato@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Matthew,

I love your patch! Yet something to improve:

[auto build test ERROR on v5.16-rc4]
[cannot apply to s390/features kvms390/next awilliam-vfio/next next-20211207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Matthew-Rosato/KVM-s390-enable-zPCI-for-interpretive-execution/20211208-050204
base:    0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20211208/202112081547.UVwzE8hh-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/a4580b9cbc02e756b893862d072f264af6f8d30d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Rosato/KVM-s390-enable-zPCI-for-interpretive-execution/20211208-050204
        git checkout a4580b9cbc02e756b893862d072f264af6f8d30d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/s390/kvm/pci.c: In function '__set_irq_noiib':
   arch/s390/kvm/pci.c:19:15: error: variable 'iib' has initializer but incomplete type
      19 |         union zpci_sic_iib iib = {{0}};
         |               ^~~~~~~~~~~~
   arch/s390/kvm/pci.c:19:35: error: extra brace group at end of initializer
      19 |         union zpci_sic_iib iib = {{0}};
         |                                   ^
   arch/s390/kvm/pci.c:19:35: note: (near initialization for 'iib')
   arch/s390/kvm/pci.c:19:35: warning: excess elements in union initializer
   arch/s390/kvm/pci.c:19:35: note: (near initialization for 'iib')
   arch/s390/kvm/pci.c:19:28: error: storage size of 'iib' isn't known
      19 |         union zpci_sic_iib iib = {{0}};
         |                            ^~~
   arch/s390/kvm/pci.c:21:16: error: implicit declaration of function 'zpci_set_irq_ctrl'; did you mean 'zpci_set_irq'? [-Werror=implicit-function-declaration]
      21 |         return zpci_set_irq_ctrl(ctl, isc, &iib);
         |                ^~~~~~~~~~~~~~~~~
         |                zpci_set_irq
   arch/s390/kvm/pci.c:19:28: warning: unused variable 'iib' [-Wunused-variable]
      19 |         union zpci_sic_iib iib = {{0}};
         |                            ^~~
   arch/s390/kvm/pci.c: In function 'kvm_s390_pci_aen_exit':
   arch/s390/kvm/pci.c:39:25: error: 'SIC_SET_AENI_CONTROLS' undeclared (first use in this function)
      39 |         __set_irq_noiib(SIC_SET_AENI_CONTROLS, 0);
         |                         ^~~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/pci.c:39:25: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/vdso/const.h:5,
                    from include/linux/const.h:4,
                    from include/uapi/linux/kernel.h:6,
                    from include/linux/cache.h:5,
                    from include/linux/printk.h:9,
                    from include/asm-generic/bug.h:22,
                    from arch/s390/include/asm/bug.h:68,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/percpu.h:5,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/kvm_host.h:7,
                    from arch/s390/kvm/pci.c:10:
>> arch/s390/include/asm/pci.h:27:41: error: 'CONFIG_PCI_NR_FUNCTIONS' undeclared (first use in this function); did you mean 'CONFIG_FAIL_FUNCTION'?
      27 | #define ZPCI_NR_DEVICES                 CONFIG_PCI_NR_FUNCTIONS
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   include/uapi/linux/const.h:32:44: note: in definition of macro '__ALIGN_KERNEL_MASK'
      32 | #define __ALIGN_KERNEL_MASK(x, mask)    (((x) + (mask)) & ~(mask))
         |                                            ^
   include/linux/align.h:8:33: note: in expansion of macro '__ALIGN_KERNEL'
       8 | #define ALIGN(x, a)             __ALIGN_KERNEL((x), (a))
         |                                 ^~~~~~~~~~~~~~
   include/linux/mm.h:224:26: note: in expansion of macro 'ALIGN'
     224 | #define PAGE_ALIGN(addr) ALIGN(addr, PAGE_SIZE)
         |                          ^~~~~
   arch/s390/kvm/pci.c:52:26: note: in expansion of macro 'PAGE_ALIGN'
      52 |         size = get_order(PAGE_ALIGN(ZPCI_NR_DEVICES *
         |                          ^~~~~~~~~~
   arch/s390/kvm/pci.c:52:37: note: in expansion of macro 'ZPCI_NR_DEVICES'
      52 |         size = get_order(PAGE_ALIGN(ZPCI_NR_DEVICES *
         |                                     ^~~~~~~~~~~~~~~
   arch/s390/kvm/pci.c: In function 'kvm_s390_pci_aen_init':
   arch/s390/kvm/pci.c:60:15: error: variable 'iib' has initializer but incomplete type
      60 |         union zpci_sic_iib iib = {{0}};
         |               ^~~~~~~~~~~~
   arch/s390/kvm/pci.c:60:35: error: extra brace group at end of initializer
      60 |         union zpci_sic_iib iib = {{0}};
         |                                   ^
   arch/s390/kvm/pci.c:60:35: note: (near initialization for 'iib')
   arch/s390/kvm/pci.c:60:35: warning: excess elements in union initializer
   arch/s390/kvm/pci.c:60:35: note: (near initialization for 'iib')
   arch/s390/kvm/pci.c:60:28: error: storage size of 'iib' isn't known
      60 |         union zpci_sic_iib iib = {{0}};
         |                            ^~~
   In file included from include/linux/pci.h:1886,
                    from arch/s390/kvm/pci.c:11:
>> arch/s390/include/asm/pci.h:27:41: error: 'CONFIG_PCI_NR_FUNCTIONS' undeclared (first use in this function); did you mean 'CONFIG_FAIL_FUNCTION'?
      27 | #define ZPCI_NR_DEVICES                 CONFIG_PCI_NR_FUNCTIONS
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/pci.c:69:30: note: in expansion of macro 'ZPCI_NR_DEVICES'
      69 |         aift.kzdev = kcalloc(ZPCI_NR_DEVICES, sizeof(struct kvm_zdev),
         |                              ^~~~~~~~~~~~~~~
   arch/s390/kvm/pci.c:95:31: error: 'SIC_SET_AENI_CONTROLS' undeclared (first use in this function)
      95 |         if (zpci_set_irq_ctrl(SIC_SET_AENI_CONTROLS, 0, &iib)) {
         |                               ^~~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/pci.c:101:29: error: 'SIC_IRQ_MODE_SINGLE' undeclared (first use in this function)
     101 |         if (__set_irq_noiib(SIC_IRQ_MODE_SINGLE, nisc)) {
         |                             ^~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/pci.c:60:28: warning: unused variable 'iib' [-Wunused-variable]
      60 |         union zpci_sic_iib iib = {{0}};
         |                            ^~~
   cc1: some warnings being treated as errors


vim +27 arch/s390/include/asm/pci.h

cd24834130ac655 Jan Glauber     2012-11-29  25  
c840927cf5f24d0 Sebastian Ott   2019-02-12  26  #define ZPCI_NR_DMA_SPACES		1
c840927cf5f24d0 Sebastian Ott   2019-02-12 @27  #define ZPCI_NR_DEVICES			CONFIG_PCI_NR_FUNCTIONS
969ae01bab2fe93 Niklas Schnelle 2020-03-17  28  #define ZPCI_DOMAIN_BITMAP_SIZE		(1 << 16)
c840927cf5f24d0 Sebastian Ott   2019-02-12  29  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
