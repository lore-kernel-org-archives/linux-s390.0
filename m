Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1237220F55;
	Thu, 19 Jun 2025 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750326825; cv=none; b=Bkp8ZFyeyllvvSvruSIbMs84hf7P/o8Xprbu7RWJBWXk1/v+EMJvJJ0Qit28Gc7GQt9u1Og5oVBwsEmQTsgRhgYd3zpFeLMTUfIajheM3h5r2DnF/+2PgY/n6x7V0OdcMPEGhU0sHIpHSFCaHc3EzrF0p05ezQLPWvVvfZ8UpKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750326825; c=relaxed/simple;
	bh=aoabY3uN68FF/AqK9E73rIZP0Jr9EBrc7Uh6DHc60hk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+aTwNOM2OYF4hva4/R06uhGVGr59rcfUx2v1aJZRv7Te/gaqXz7ytNA/IMrFPX0742/C7ZR0eBm7bpEpcxeYnyRY5NOoRjreYJ7E5FnX/vljFHeMf2C0mPEHr/igHYDfzRrx3huKJ6rDyfPmkza77te+L80pwe99mGrLxvDmpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zk3pzHla; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zk3pzHla"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553b82f3767so509248e87.3;
        Thu, 19 Jun 2025 02:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750326822; x=1750931622; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8lxye2GX1z6QI+SRVMkfZEngbWK9B27pd3eBJcWGrlg=;
        b=Zk3pzHlaRLH5IoKNbeMJ5Zn9Te3qy0PdSP9NsfBOwuZ01ivJ7t1ehT16xDBRyalq2J
         uVk/7lTowQxO4L07rh94RL5k6XZ+kL0FwCzyDru1lk/CsCB3UsSesx7VKCtUoUYpNP54
         Ojq1tlHb5QMaZ5aCO8/G+V3DxCGss8SsboVurcD1CEqvMTcngOkAWcdtOstwoTH3ACVf
         xoTJdPi9724J7Fs+LAPfe22CSSpAimUKWoKfgerREpuKy/yAeFPc1fMW7ft0BhOkdLrw
         H/AbhLELPDKFy46nIGihhAxCVIbW1fniOynRiByM30j5lKfqX6I3y/zgkCYvn9isqQla
         IDqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750326822; x=1750931622;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lxye2GX1z6QI+SRVMkfZEngbWK9B27pd3eBJcWGrlg=;
        b=bkPoxd9sP/ofipb3d44FmrJsmR4iD6mPnzGrkRdXWYp3sdyCAfDTd9+kmvf7OKqOjh
         5QThC8Af8sZNb2mIctjSjWfAuj09lBFJqNFDNPRIrYG+hB+ejNaNoOxG+UepV8kRIlRG
         QVMFCqc2yUeq6u/Y9GoX+xzUfhfLE3I941H5mb722C8+jUxqSc8RmCZVoXubfpFNJFvr
         +5pqoCagiCfjPMgn1IBiHaGWiROnYr/9B5z28z2td+3Jj8K6VEc7CcPDb4aL4bPtT1I1
         nXrCBRE993vo4Q1KJkq+h4yyCpEh2XF/dB2nXQPwF3JTT9LgQfa10iIA23IRkoGbConp
         Rc0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKrnKdv7XZiSyHSKmpy35dQ2espf1Lu0mUvkRsxpRodWz5ANEnAlSwjmINWlZAcZ0dMDl8Dbd2a1Ulx2E=@vger.kernel.org, AJvYcCW5FSDS8B2IRnstf2uI+ZUIfb1vgCYJUADl41ErF4lKpJUpRwtU6fNVMD4IUSqjLVto0n6AZNx2KUMV8w==@vger.kernel.org, AJvYcCWmevpONIsr2FYBLiI7RmXB+YUMPyOIErN4JZS5u2GIt0R+Zktwrmjt8RknYXozjpkQ5MFkZ8OE/mnUAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhmMWOrs+KCb+DqJFIehXACUkYUQRp81HJC0jcjLxwX8TmAijU
	OsoKsXH++5simM6YY8jqbx5gs3v0U2sQIma45xIsOCoU+CdkSoRJ/0Ti
X-Gm-Gg: ASbGnct15wNR1SPSXAjBGgpHoTGCq4zCpKju5/JShPTYRgoZrMo0uhD90PrwO5ZsfkR
	XZ3ht0qQSrNC3JC9PyVItm2Zmo2dKY5dDcw9aJOpNGoeEvfloIOj0Jhqt7AevWhTkhfR/DTOtYr
	2kFHA7liwa97YHgxX1f1Ype3SeQ9RLk/BZQ9sW2yFOJBseK0QF4URUEhfYh6ZY+UnQmFVmaeDkC
	06o+jATAEhkR7o3IeNLxVIX/GV6beNdKsLsrzos3Xy992P9dV85V5np8wQRjsD/v8B/+ro8Nvtw
	JJzZ2gxYQgCbgnjK8DNdmQVBJ1zyC5PrQ6Fuozp6lYWSN5hDDD5yxOXAGkaNrJKJjr5zAu/uk7u
	VuFR/SVsrxXM=
X-Google-Smtp-Source: AGHT+IEJV7RqZa9E1nD948cD6oSgemriE8btKJowGkw8tp48NbrB1jrcDoGclBvee7YrwcLZgS368g==
X-Received: by 2002:a05:6512:1049:b0:553:1f90:cca4 with SMTP id 2adb3069b0e04-553b6e74ae6mr5656846e87.13.1750326821436;
        Thu, 19 Jun 2025 02:53:41 -0700 (PDT)
Received: from pc636 (host-95-203-1-180.mobileonline.telia.com. [95.203.1.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1367e9sm2541889e87.79.2025.06.19.02.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 02:53:41 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 19 Jun 2025 11:53:38 +0200
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild@lists.linux.dev, Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
	xen-devel@lists.xenproject.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, Hugh Dickins <hughd@google.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>, Juergen Gross <jgross@suse.com>,
	Jeremy Fitzhardinge <jeremy@goop.org>,
	Ryan Roberts <ryan.roberts@arm.com>
Subject: Re: [PATCH 2/6] mm: Lock kernel page tables before entering lazy MMU
 mode
Message-ID: <aFPeIisE3ufUGEUq@pc636>
References: <7bd3a45dbc375dc2c15cebae09cb2bb972d6039f.1749747752.git.agordeev@linux.ibm.com>
 <0be7d42e-5898-4b94-829b-59c661c2f07b@suswa.mountain>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0be7d42e-5898-4b94-829b-59c661c2f07b@suswa.mountain>

On Wed, Jun 18, 2025 at 08:32:28PM +0300, Dan Carpenter wrote:
> Hi Alexander,
> 
> kernel test robot noticed the following build warnings:
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-Gordeev/mm-Cleanup-apply_to_pte_range-routine/20250613-013835
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/7bd3a45dbc375dc2c15cebae09cb2bb972d6039f.1749747752.git.agordeev%40linux.ibm.com
> patch subject: [PATCH 2/6] mm: Lock kernel page tables before entering lazy MMU mode
> config: x86_64-randconfig-161-20250613 (https://download.01.org/0day-ci/archive/20250613/202506132017.T1l1l6ME-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202506132017.T1l1l6ME-lkp@intel.com/
> 
> smatch warnings:
> mm/vmalloc.c:552 vmap_pages_pte_range() warn: inconsistent returns 'global &init_mm.page_table_lock'.
> 
> vim +552 mm/vmalloc.c
> 
> 0a264884046f1ab Nicholas Piggin   2021-04-29  517  static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
> 2ba3e6947aed9bb Joerg Roedel      2020-06-01  518  		unsigned long end, pgprot_t prot, struct page **pages, int *nr,
> 2ba3e6947aed9bb Joerg Roedel      2020-06-01  519  		pgtbl_mod_mask *mask)
> ^1da177e4c3f415 Linus Torvalds    2005-04-16  520  {
> ^1da177e4c3f415 Linus Torvalds    2005-04-16  521  	pte_t *pte;
> ^1da177e4c3f415 Linus Torvalds    2005-04-16  522  
> db64fe02258f150 Nicholas Piggin   2008-10-18  523  	/*
> db64fe02258f150 Nicholas Piggin   2008-10-18  524  	 * nr is a running index into the array which helps higher level
> db64fe02258f150 Nicholas Piggin   2008-10-18  525  	 * callers keep track of where we're up to.
> db64fe02258f150 Nicholas Piggin   2008-10-18  526  	 */
> db64fe02258f150 Nicholas Piggin   2008-10-18  527  
> 2ba3e6947aed9bb Joerg Roedel      2020-06-01  528  	pte = pte_alloc_kernel_track(pmd, addr, mask);
> ^1da177e4c3f415 Linus Torvalds    2005-04-16  529  	if (!pte)
> ^1da177e4c3f415 Linus Torvalds    2005-04-16  530  		return -ENOMEM;
> 44562c71e2cfc9e Ryan Roberts      2025-04-22  531  
> dac0cc793368851 Alexander Gordeev 2025-06-12  532  	spin_lock(&init_mm.page_table_lock);
> 44562c71e2cfc9e Ryan Roberts      2025-04-22  533  	arch_enter_lazy_mmu_mode();
> 44562c71e2cfc9e Ryan Roberts      2025-04-22  534  
> ^1da177e4c3f415 Linus Torvalds    2005-04-16  535  	do {
> db64fe02258f150 Nicholas Piggin   2008-10-18  536  		struct page *page = pages[*nr];
> db64fe02258f150 Nicholas Piggin   2008-10-18  537  
> c33c794828f2121 Ryan Roberts      2023-06-12  538  		if (WARN_ON(!pte_none(ptep_get(pte))))
> db64fe02258f150 Nicholas Piggin   2008-10-18  539  			return -EBUSY;
> db64fe02258f150 Nicholas Piggin   2008-10-18  540  		if (WARN_ON(!page))
> ^1da177e4c3f415 Linus Torvalds    2005-04-16  541  			return -ENOMEM;
> 4fcdcc12915c707 Yury Norov        2022-04-28  542  		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
> 4fcdcc12915c707 Yury Norov        2022-04-28  543  			return -EINVAL;
> 
> These error paths don't unlock &init_mm.page_table_lock?
> 
> 4fcdcc12915c707 Yury Norov        2022-04-28  544  
> ^1da177e4c3f415 Linus Torvalds    2005-04-16  545  		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
> db64fe02258f150 Nicholas Piggin   2008-10-18  546  		(*nr)++;
> ^1da177e4c3f415 Linus Torvalds    2005-04-16  547  	} while (pte++, addr += PAGE_SIZE, addr != end);
> 44562c71e2cfc9e Ryan Roberts      2025-04-22  548  
> 44562c71e2cfc9e Ryan Roberts      2025-04-22  549  	arch_leave_lazy_mmu_mode();
> dac0cc793368851 Alexander Gordeev 2025-06-12  550  	spin_unlock(&init_mm.page_table_lock);
> 2ba3e6947aed9bb Joerg Roedel      2020-06-01  551  	*mask |= PGTBL_PTE_MODIFIED;
> ^1da177e4c3f415 Linus Torvalds    2005-04-16 @552  	return 0;
> ^1da177e4c3f415 Linus Torvalds    2005-04-16  553  }
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
> 
This patch introduce a huge performance degrade when testing this by
the test_vmalloc.sh performance tool. We return back to a single, not
serialized global spilock where we spend 90% of cycles:

<snip>
+   91.01%     1.67%  [kernel]          [k] _raw_spin_lock
-   89.29%    89.25%  [kernel]          [k] native_queued_spin_lock_slowpath
     69.82% ret_from_fork_asm
      - ret_from_fork
         - 69.81% kthread
            - 69.66% test_func
               - 26.31% full_fit_alloc_test
                  - 19.11% __vmalloc_node_noprof
                     - __vmalloc_node_range_noprof
                        - 13.73% vmap_small_pages_range_noflush
                             _raw_spin_lock
                             native_queued_spin_lock_slowpath
                        - 5.38% __get_vm_area_node
                             alloc_vmap_area
                             _raw_spin_lock
                             native_queued_spin_lock_slowpath
                  - 13.32% vfree.part.0
                     - 13.31% remove_vm_area
                        - 13.27% __vunmap_range_noflush
                             _raw_spin_lock
                             native_queued_spin_lock_slowpath
               - 25.57% fix_size_alloc_test
                  - 22.59% __vmalloc_node_noprof
                     - __vmalloc_node_range_noprof
                        - 17.34% vmap_small_pages_range_noflush
                             _raw_spin_lock
                             native_queued_spin_lock_slowpath
                        - 5.25% __get_vm_area_node
                             alloc_vmap_area
                             _raw_spin_lock
                             native_queued_spin_lock_slowpath
                  - 11.59% vfree.part.0
                     - remove_vm_area
                        - 11.55% __vunmap_range_noflush
                             _raw_spin_lock
                             native_queued_spin_lock_slowpath
               - 17.78% long_busy_list_alloc_test
                  - 13.90% __vmalloc_node_noprof
                     - __vmalloc_node_range_noprof
                        - 9.95% vmap_small_pages_range_noflush
                             _raw_spin_lock
<snip>

No, we can not take this patch.

--
Uladzislau Rezki
