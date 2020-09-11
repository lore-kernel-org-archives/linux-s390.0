Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57231 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725779AbgIKIUh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 11 Sep 2020 04:20:37 -0400
Subject: Re: [PATCH v3 3/7] mm/memory_hotplug: prepare passing flags to
 add_memory() and friends
References: <20200910091340.8654-4-david@redhat.com>
 <202009111020.boR8gVOT%lkp@intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ae0bfdea-bef6-f6e4-6ce6-2bf68e44292c@redhat.com>
Date: Fri, 11 Sep 2020 10:20:25 +0200
MIME-Version: 1.0
In-Reply-To: <202009111020.boR8gVOT%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc: kbuild-all@lists.01.org, clang-built-linux@googlegroups.com, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On 11.09.20 04:21, kernel test robot wrote:
> Hi David,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on next-20200909]
> [cannot apply to mmotm/master hnaz-linux-mm/master xen-tip/linux-next powerpc/next linus/master v5.9-rc4 v5.9-rc3 v5.9-rc2 v5.9-rc4]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/David-Hildenbrand/mm-memory_hotplug-selective-merging-of-system-ram-resources/20200910-171630
> base:    7204eaa2c1f509066486f488c9dcb065d7484494
> config: x86_64-randconfig-a016-20200909 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 0a5dc7effb191eff740e0e7ae7bd8e1f6bdb3ad9)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    WARNING: unmet direct dependencies detected for PHY_SAMSUNG_UFS
>    Depends on OF && (ARCH_EXYNOS || COMPILE_TEST
>    Selected by
>    - SCSI_UFS_EXYNOS && SCSI_LOWLEVEL && SCSI && SCSI_UFSHCD_PLATFORM && (ARCH_EXYNOS || COMPILE_TEST
>    In file included from arch/x86/kernel/asm-offsets.c:9:
>    In file included from include/linux/crypto.h:20:
>    In file included from include/linux/slab.h:15:
>    In file included from include/linux/gfp.h:6:
>    In file included from include/linux/mmzone.h:853:
>>> include/linux/memory_hotplug.h:354:55: error: unknown type name 'mhp_t'
>    extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
>    ^
>    include/linux/memory_hotplug.h:355:53: error: unknown type name 'mhp_t'
>    extern int add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
>    ^
>    include/linux/memory_hotplug.h:357:11: error: unknown type name 'mhp_t'
>    mhp_t mhp_flags);
>    ^
>    include/linux/memory_hotplug.h:360:10: error: unknown type name 'mhp_t'
>    mhp_t mhp_flags);
>    ^
>    4 errors generated.
>    Makefile Module.symvers System.map arch block certs crypto drivers fs include init ipc kernel lib mm modules.builtin modules.builtin.modinfo modules.order net scripts security sound source tools usr virt vmlinux vmlinux.o vmlinux.symvers [scripts/Makefile.build:117: arch/x86/kernel/asm-offsets.s] Error 1
>    Target '__build' not remade because of errors.
>    Makefile Module.symvers System.map arch block certs crypto drivers fs include init ipc kernel lib mm modules.builtin modules.builtin.modinfo modules.order net scripts security sound source tools usr virt vmlinux vmlinux.o vmlinux.symvers [Makefile:1196: prepare0] Error 2
>    Target 'prepare' not remade because of errors.
>    make: Makefile Module.symvers System.map arch block certs crypto drivers fs include init ipc kernel lib mm modules.builtin modules.builtin.modinfo modules.order net scripts security sound source tools usr virt vmlinux vmlinux.o vmlinux.symvers [Makefile:185: __sub-make] Error 2
>    make: Target 'prepare' not remade because of errors.
> 
> # https://github.com/0day-ci/linux/commit/d88270d1c0783a7f99f24a85692be90fd2ae0d7d
> git remote add linux-review https://github.com/0day-ci/linux
> git fetch --no-tags linux-review David-Hildenbrand/mm-memory_hotplug-selective-merging-of-system-ram-resources/20200910-171630
> git checkout d88270d1c0783a7f99f24a85692be90fd2ae0d7d
> vim +/mhp_t +354 include/linux/memory_hotplug.h
> 
>    352	
>    353	extern void __ref free_area_init_core_hotplug(int nid);
>  > 354	extern int __add_memory(int nid, u64 start, u64 size, mhp_t mhp_flags);
> 

add_memory() and not protected by CONFIG_MEMORY_HOTPLUG, but the new
type is. Will look into it.

-- 
Thanks,

David / dhildenb
