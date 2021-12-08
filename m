Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64ECC433EF
	for <linux-s390@archiver.kernel.org>; Wed,  8 Dec 2021 08:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240425AbhLHIIL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Dec 2021 03:08:11 -0500
Received: from mga09.intel.com ([134.134.136.24]:10250 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244637AbhLHIIL (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 8 Dec 2021 03:08:11 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="237587617"
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="237587617"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 00:04:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,296,1631602800"; 
   d="scan'208";a="612013346"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Dec 2021 00:04:35 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1murwJ-0000GF-2Y; Wed, 08 Dec 2021 08:04:35 +0000
Date:   Wed, 8 Dec 2021 16:04:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     kbuild-all@lists.01.org, alex.williamson@redhat.com,
        cohuck@redhat.com, schnelle@linux.ibm.com, farman@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com
Subject: Re: [PATCH 23/32] KVM: s390: pci: handle refresh of PCI translations
Message-ID: <202112081537.qiFqvLb1-lkp@intel.com>
References: <20211207205743.150299-24-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207205743.150299-24-mjrosato@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Matthew,

I love your patch! Perhaps something to improve:

[auto build test WARNING on v5.16-rc4]
[cannot apply to s390/features kvms390/next awilliam-vfio/next next-20211207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Matthew-Rosato/KVM-s390-enable-zPCI-for-interpretive-execution/20211208-050204
base:    0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20211208/202112081537.qiFqvLb1-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/84cb5df859beb99f52b3d3b133ff1f9b5a459558
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Matthew-Rosato/KVM-s390-enable-zPCI-for-interpretive-execution/20211208-050204
        git checkout 84cb5df859beb99f52b3d3b133ff1f9b5a459558
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 SHELL=/bin/bash arch/s390/kvm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/s390/kvm/pci.c:179:16: warning: no previous prototype for 'dma_walk_guest_cpu_trans' [-Wmissing-prototypes]
     179 | unsigned long *dma_walk_guest_cpu_trans(struct kvm_vcpu *vcpu,
         |                ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/dma_walk_guest_cpu_trans +179 arch/s390/kvm/pci.c

   178	
 > 179	unsigned long *dma_walk_guest_cpu_trans(struct kvm_vcpu *vcpu,
   180						struct kvm_zdev_ioat *ioat,
   181						dma_addr_t dma_addr)
   182	{
   183		unsigned long *rto, *sto, *pto;
   184		unsigned int rtx, rts, sx, px, idx;
   185		struct page *page;
   186		gpa_t addr;
   187		int i;
   188	
   189		/* Pin guest segment table if needed */
   190		rtx = calc_rtx(dma_addr);
   191		rto = ioat->head[(rtx / ZPCI_TABLE_ENTRIES_PER_PAGE)];
   192		rts = rtx * ZPCI_TABLE_PAGES;
   193		if (!ioat->seg[rts]) {
   194			if (!reg_entry_isvalid(rto[rtx % ZPCI_TABLE_ENTRIES_PER_PAGE]))
   195				return NULL;
   196			sto = get_rt_sto(rto[rtx % ZPCI_TABLE_ENTRIES_PER_PAGE]);
   197			addr = ((u64)sto & ZPCI_RTE_ADDR_MASK);
   198			idx = srcu_read_lock(&vcpu->kvm->srcu);
   199			for (i = 0; i < ZPCI_TABLE_PAGES; i++) {
   200				page = gfn_to_page(vcpu->kvm, gpa_to_gfn(addr));
   201				if (is_error_page(page)) {
   202					srcu_read_unlock(&vcpu->kvm->srcu, idx);
   203					return NULL;
   204				}
   205				ioat->seg[rts + i] = page_to_virt(page) +
   206						     (addr & ~PAGE_MASK);
   207				addr += PAGE_SIZE;
   208			}
   209			srcu_read_unlock(&vcpu->kvm->srcu, idx);
   210		}
   211	
   212		/* Allocate pin pointers for another segment table if needed */
   213		if (!ioat->pt[rtx]) {
   214			ioat->pt[rtx] = kcalloc(ZPCI_TABLE_ENTRIES,
   215						(sizeof(unsigned long *)), GFP_KERNEL);
   216			if (!ioat->pt[rtx])
   217				return NULL;
   218		}
   219		/* Pin guest page table if needed */
   220		sx = calc_sx(dma_addr);
   221		sto = ioat->seg[(rts + (sx / ZPCI_TABLE_ENTRIES_PER_PAGE))];
   222		if (!ioat->pt[rtx][sx]) {
   223			if (!reg_entry_isvalid(sto[sx % ZPCI_TABLE_ENTRIES_PER_PAGE]))
   224				return NULL;
   225			pto = get_st_pto(sto[sx % ZPCI_TABLE_ENTRIES_PER_PAGE]);
   226			if (!pto)
   227				return NULL;
   228			addr = ((u64)pto & ZPCI_STE_ADDR_MASK);
   229			idx = srcu_read_lock(&vcpu->kvm->srcu);
   230			page = gfn_to_page(vcpu->kvm, gpa_to_gfn(addr));
   231			srcu_read_unlock(&vcpu->kvm->srcu, idx);
   232			if (is_error_page(page))
   233				return NULL;
   234			ioat->pt[rtx][sx] = page_to_virt(page) + (addr & ~PAGE_MASK);
   235		}
   236		pto = ioat->pt[rtx][sx];
   237	
   238		/* Return guest PTE */
   239		px = calc_px(dma_addr);
   240		return &pto[px];
   241	}
   242	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
