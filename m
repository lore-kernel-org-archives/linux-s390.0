Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FCBC433EF
	for <linux-s390@archiver.kernel.org>; Wed,  8 Dec 2021 10:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhLHLCR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Dec 2021 06:02:17 -0500
Received: from mga03.intel.com ([134.134.136.65]:10137 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231961AbhLHLCQ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 8 Dec 2021 06:02:16 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237748651"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="237748651"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:58:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="580564513"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Dec 2021 02:58:40 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muuem-0000Rc-4l; Wed, 08 Dec 2021 10:58:40 +0000
Date:   Wed, 8 Dec 2021 18:58:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     kbuild-all@lists.01.org, alex.williamson@redhat.com,
        cohuck@redhat.com, schnelle@linux.ibm.com, farman@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com
Subject: Re: [PATCH 21/32] KVM: s390: pci: provide routines for
 enabling/disabling interrupt forwarding
Message-ID: <202112081717.0Nu4b7a2-lkp@intel.com>
References: <20211207205743.150299-22-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207205743.150299-22-mjrosato@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Matthew,

I love your patch! Yet something to improve:

[auto build test ERROR on v5.16-rc4]
[cannot apply to s390/features kvms390/next awilliam-vfio/next next-20211208]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Matthew-Rosato/KVM-s390-enable-zPCI-for-interpretive-execution/20211208-050204
base:    0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20211208/202112081717.0Nu4b7a2-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/6604d174d51ffe79c280462e77e8f75c107b2076
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Rosato/KVM-s390-enable-zPCI-for-interpretive-execution/20211208-050204
        git checkout 6604d174d51ffe79c280462e77e8f75c107b2076
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

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
   arch/s390/kvm/pci.c: In function 'kvm_s390_pci_aen_exit':
   arch/s390/include/asm/pci.h:27:41: error: 'CONFIG_PCI_NR_FUNCTIONS' undeclared (first use in this function); did you mean 'CONFIG_FAIL_FUNCTION'?
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
   arch/s390/kvm/pci.c:56:26: note: in expansion of macro 'PAGE_ALIGN'
      56 |         size = get_order(PAGE_ALIGN(ZPCI_NR_DEVICES *
         |                          ^~~~~~~~~~
   arch/s390/kvm/pci.c:56:37: note: in expansion of macro 'ZPCI_NR_DEVICES'
      56 |         size = get_order(PAGE_ALIGN(ZPCI_NR_DEVICES *
         |                                     ^~~~~~~~~~~~~~~
   arch/s390/include/asm/pci.h:27:41: note: each undeclared identifier is reported only once for each function it appears in
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
   arch/s390/kvm/pci.c:56:26: note: in expansion of macro 'PAGE_ALIGN'
      56 |         size = get_order(PAGE_ALIGN(ZPCI_NR_DEVICES *
         |                          ^~~~~~~~~~
   arch/s390/kvm/pci.c:56:37: note: in expansion of macro 'ZPCI_NR_DEVICES'
      56 |         size = get_order(PAGE_ALIGN(ZPCI_NR_DEVICES *
         |                                     ^~~~~~~~~~~~~~~
   In file included from include/linux/pci.h:1886,
                    from arch/s390/kvm/pci.c:11:
   arch/s390/kvm/pci.c: In function 'kvm_s390_pci_aen_init':
   arch/s390/include/asm/pci.h:27:41: error: 'CONFIG_PCI_NR_FUNCTIONS' undeclared (first use in this function); did you mean 'CONFIG_FAIL_FUNCTION'?
      27 | #define ZPCI_NR_DEVICES                 CONFIG_PCI_NR_FUNCTIONS
         |                                         ^~~~~~~~~~~~~~~~~~~~~~~
   arch/s390/kvm/pci.c:73:30: note: in expansion of macro 'ZPCI_NR_DEVICES'
      73 |         aift.kzdev = kcalloc(ZPCI_NR_DEVICES, sizeof(struct kvm_zdev),
         |                              ^~~~~~~~~~~~~~~
   arch/s390/kvm/pci.c: In function 'kvm_zpci_set_airq':
>> arch/s390/kvm/pci.c:128:19: error: implicit declaration of function 'ZPCI_CREATE_REQ' [-Werror=implicit-function-declaration]
     128 |         u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_REG_INT);
         |                   ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ZPCI_CREATE_REQ +128 arch/s390/kvm/pci.c

  > 11	#include <linux/pci.h>
    12	#include <asm/kvm_pci.h>
    13	#include <asm/pci.h>
    14	#include <asm/pci_insn.h>
    15	#include <asm/sclp.h>
    16	#include "pci.h"
    17	#include "kvm-s390.h"
    18	
    19	static struct zpci_aift aift;
    20	
    21	static inline int __set_irq_noiib(u16 ctl, u8 isc)
    22	{
    23		union zpci_sic_iib iib = {{0}};
    24	
    25		return zpci_set_irq_ctrl(ctl, isc, &iib);
    26	}
    27	
    28	struct zpci_aift *kvm_s390_pci_get_aift(void)
    29	{
    30		return &aift;
    31	}
    32	
    33	/* Caller must hold the aift lock before calling this function */
    34	void kvm_s390_pci_aen_exit(void)
    35	{
    36		struct zpci_gaite *gait;
    37		unsigned long flags;
    38		struct airq_iv *sbv;
    39		struct kvm_zdev **gait_kzdev;
    40		int size;
    41	
    42		/* Clear the GAIT and forwarding summary vector */
    43		__set_irq_noiib(SIC_SET_AENI_CONTROLS, 0);
    44	
    45		spin_lock_irqsave(&aift.gait_lock, flags);
    46		gait = aift.gait;
    47		sbv = aift.sbv;
    48		gait_kzdev = aift.kzdev;
    49		aift.gait = 0;
    50		aift.sbv = 0;
    51		aift.kzdev = 0;
    52		spin_unlock_irqrestore(&aift.gait_lock, flags);
    53	
    54		if (sbv)
    55			airq_iv_release(sbv);
    56		size = get_order(PAGE_ALIGN(ZPCI_NR_DEVICES *
    57					    sizeof(struct zpci_gaite)));
    58		free_pages((unsigned long)gait, size);
    59		kfree(gait_kzdev);
    60	}
    61	
    62	int kvm_s390_pci_aen_init(u8 nisc)
    63	{
    64		union zpci_sic_iib iib = {{0}};
    65		struct page *page;
    66		int rc = 0, size;
    67	
    68		/* If already enabled for AEN, bail out now */
    69		if (aift.gait || aift.sbv)
    70			return -EPERM;
    71	
    72		mutex_lock(&aift.lock);
    73		aift.kzdev = kcalloc(ZPCI_NR_DEVICES, sizeof(struct kvm_zdev),
    74				     GFP_KERNEL);
    75		if (!aift.kzdev) {
    76			rc = -ENOMEM;
    77			goto unlock;
    78		}
    79		aift.sbv = airq_iv_create(ZPCI_NR_DEVICES, AIRQ_IV_ALLOC, 0);
    80		if (!aift.sbv) {
    81			rc = -ENOMEM;
    82			goto free_zdev;
    83		}
    84		size = get_order(PAGE_ALIGN(ZPCI_NR_DEVICES *
    85					    sizeof(struct zpci_gaite)));
    86		page = alloc_pages(GFP_KERNEL | __GFP_ZERO, size);
    87		if (!page) {
    88			rc = -ENOMEM;
    89			goto free_sbv;
    90		}
    91		aift.gait = (struct zpci_gaite *)page_to_phys(page);
    92	
    93		iib.aipb.faisb = (u64)aift.sbv->vector;
    94		iib.aipb.gait = (u64)aift.gait;
    95		iib.aipb.afi = nisc;
    96		iib.aipb.faal = ZPCI_NR_DEVICES;
    97	
    98		/* Setup Adapter Event Notification Interpretation */
    99		if (zpci_set_irq_ctrl(SIC_SET_AENI_CONTROLS, 0, &iib)) {
   100			rc = -EIO;
   101			goto free_gait;
   102		}
   103	
   104		/* Enable floating IRQs */
   105		if (__set_irq_noiib(SIC_IRQ_MODE_SINGLE, nisc)) {
   106			rc = -EIO;
   107			kvm_s390_pci_aen_exit();
   108		}
   109	
   110		goto unlock;
   111	
   112	free_gait:
   113		size = get_order(PAGE_ALIGN(ZPCI_NR_DEVICES *
   114					    sizeof(struct zpci_gaite)));
   115		free_pages((unsigned long)aift.gait, size);
   116	free_sbv:
   117		airq_iv_release(aift.sbv);
   118	free_zdev:
   119		kfree(aift.kzdev);
   120	unlock:
   121		mutex_unlock(&aift.lock);
   122		return rc;
   123	}
   124	
   125	/* Modify PCI: Register floating adapter interruption forwarding */
   126	static int kvm_zpci_set_airq(struct zpci_dev *zdev)
   127	{
 > 128		u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_REG_INT);
   129		struct zpci_fib fib = {0};
   130		u8 status;
   131	
   132		fib.fmt0.isc = zdev->kzdev->fib.fmt0.isc;
   133		fib.fmt0.sum = 1;       /* enable summary notifications */
   134		fib.fmt0.noi = airq_iv_end(zdev->aibv);
   135		fib.fmt0.aibv = (unsigned long) zdev->aibv->vector;
   136		fib.fmt0.aibvo = 0;
   137		fib.fmt0.aisb = (unsigned long) aift.sbv->vector + (zdev->aisb/64) * 8;
   138		fib.fmt0.aisbo = zdev->aisb & 63;
   139		fib.gd = zdev->gd;
   140	
   141		return zpci_mod_fc(req, &fib, &status) ? -EIO : 0;
   142	}
   143	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
