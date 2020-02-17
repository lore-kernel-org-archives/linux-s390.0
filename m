Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726267AbgBQHzx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 17 Feb 2020 02:55:53 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01H7nKSw017190
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 02:55:52 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y6dh3j528-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 17 Feb 2020 02:55:52 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 17 Feb 2020 07:55:50 -0000
Subject: Re: [kvms390:pv_worktree 5/40] arch/s390/kernel/setup.c:563:6: error:
 'prot_virt_host' undeclared; did you mean 'is_prot_virt_host'?
References: <202002151214.QFguG3zT%lkp@intel.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 17 Feb 2020 08:55:46 +0100
MIME-Version: 1.0
In-Reply-To: <202002151214.QFguG3zT%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <85febaae-c9ac-5060-5458-64287ec43774@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kbuild test robot <lkp@intel.com>, Vasily Gorbik <gor@linux.ibm.com>
Cc: kbuild-all@lists.01.org, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>

my bad due to a late change to fold in some last minute review. 
Will fix. 

On 15.02.20 05:33, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git pv_worktree
> head:   6a8cbdf8a1bdd3a4dff307780f9c00eeb2300adb
> commit: 76f352baed9166481516cfaf88968883635b931c [5/40] s390/protvirt: add ultravisor initialization
> config: s390-zfcpdump_defconfig (attached as .config)
> compiler: s390-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 76f352baed9166481516cfaf88968883635b931c
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=s390 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arch/s390/kernel/setup.c: In function 'setup_memory_end':
>>> arch/s390/kernel/setup.c:563:6: error: 'prot_virt_host' undeclared (first use in this function); did you mean 'is_prot_virt_host'?
>      if (prot_virt_host)
>          ^~~~~~~~~~~~~~
>          is_prot_virt_host
>    arch/s390/kernel/setup.c:563:6: note: each undeclared identifier is reported only once for each function it appears in
>    arch/s390/kernel/setup.c: In function 'setup_arch':
>    arch/s390/kernel/setup.c:1140:6: error: 'prot_virt_host' undeclared (first use in this function); did you mean 'is_prot_virt_host'?
>      if (prot_virt_host)
>          ^~~~~~~~~~~~~~
>          is_prot_virt_host
> 
> vim +563 arch/s390/kernel/setup.c
> 
>    544	
>    545	static void __init setup_memory_end(void)
>    546	{
>    547		unsigned long vmax, tmp;
>    548	
>    549		/* Choose kernel address space layout: 3 or 4 levels. */
>    550		if (IS_ENABLED(CONFIG_KASAN)) {
>    551			vmax = IS_ENABLED(CONFIG_KASAN_S390_4_LEVEL_PAGING)
>    552				   ? _REGION1_SIZE
>    553				   : _REGION2_SIZE;
>    554		} else {
>    555			tmp = (memory_end ?: max_physmem_end) / PAGE_SIZE;
>    556			tmp = tmp * (sizeof(struct page) + PAGE_SIZE);
>    557			if (tmp + vmalloc_size + MODULES_LEN <= _REGION2_SIZE)
>    558				vmax = _REGION2_SIZE; /* 3-level kernel page table */
>    559			else
>    560				vmax = _REGION1_SIZE; /* 4-level kernel page table */
>    561		}
>    562	
>  > 563		if (prot_virt_host)
>    564			adjust_to_uv_max(&vmax);
>    565	
>    566		/* module area is at the end of the kernel address space. */
>    567		MODULES_END = vmax;
>    568		MODULES_VADDR = MODULES_END - MODULES_LEN;
>    569		VMALLOC_END = MODULES_VADDR;
>    570		VMALLOC_START = VMALLOC_END - vmalloc_size;
>    571	
>    572		/* Split remaining virtual space between 1:1 mapping & vmemmap array */
>    573		tmp = VMALLOC_START / (PAGE_SIZE + sizeof(struct page));
>    574		/* vmemmap contains a multiple of PAGES_PER_SECTION struct pages */
>    575		tmp = SECTION_ALIGN_UP(tmp);
>    576		tmp = VMALLOC_START - tmp * sizeof(struct page);
>    577		tmp &= ~((vmax >> 11) - 1);	/* align to page table level */
>    578		tmp = min(tmp, 1UL << MAX_PHYSMEM_BITS);
>    579		vmemmap = (struct page *) tmp;
>    580	
>    581		/* Take care that memory_end is set and <= vmemmap */
>    582		memory_end = min(memory_end ?: max_physmem_end, (unsigned long)vmemmap);
>    583	#ifdef CONFIG_KASAN
>    584		/* fit in kasan shadow memory region between 1:1 and vmemmap */
>    585		memory_end = min(memory_end, KASAN_SHADOW_START);
>    586		vmemmap = max(vmemmap, (struct page *)KASAN_SHADOW_END);
>    587	#endif
>    588		max_pfn = max_low_pfn = PFN_DOWN(memory_end);
>    589		memblock_remove(memory_end, ULONG_MAX);
>    590	
>    591		pr_notice("The maximum memory size is %luMB\n", memory_end >> 20);
>    592	}
>    593	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
