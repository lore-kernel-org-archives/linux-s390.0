Received: from iad-out-015.esa.us-east-1.outbound.mail-perimeter.amazon.com (iad-out-015.esa.us-east-1.outbound.mail-perimeter.amazon.com [44.210.169.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F56A3D9DB1;
	Fri, 10 Apr 2026 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.210.169.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775834718; cv=none; b=ZD42OO9fwRn+qwoLr2mwGI0jDxqAgWhkiN9Sj5Rvg89RYiWj7/9k+juNbqLVhQnr5L2YoDsHPW9WikHrF0YeLKm+VsKA4pYWodCgVW8L2o0T6rZbatp77H2oQ5dsVUDilPBvm0+7u+azMWsvFOJT1IMdRiqYGYkrX3xUl0QPGew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775834718; c=relaxed/simple;
	bh=qLat/NXGPSo+W2Hw0yRLSKyQzx/0WH+EOUCRwQ63RjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Y7ID9gk9XGlOpIZNqOuBT5+rFb7aRgLgt4+0lWfQuUii35FWG2ZGGy5gMgtCj0tVJmzDlD4rp3wnJt26B/pZj8EYOKVfoapyiPta9USevJ0093kvlYdwYdnsGK8SEkNOkwKKxOCK+4D+wmv5BI4xuywo7XqBdesT7aDI0pyKZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=QOaOamUz; arc=none smtp.client-ip=44.210.169.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="QOaOamUz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1775834716; x=1807370716;
  h=message-id:date:mime-version:reply-to:subject:to:cc:
   references:from:in-reply-to:content-transfer-encoding;
  bh=GnVTAq+Vwl6iHj2Q375I7ZXv1+5p652RGq37btep3G4=;
  b=QOaOamUzw1di6lQGLrCChdu7UVS7EOf4QL+RNOlD3q4pFLkxiUnZHczC
   RyGyb+zC8vwMU2qFzURVVO+EtaZltdlBY4dPKiXo78O+NloD9ttmFXeIg
   8fFJLxchxBxdZmF7NbqYayYrf4LC+gg/LBRRSv643/bLNKlgg3r4DlO3a
   j1/7dcqtf1e9YPqEppzQce8JogubbZYUPcwTJ1DXslkL9+qT3VlC4yhM0
   UH9VpN5ebtJebh+96Y3GVZU8IcJ9ziMadDlrxfOjoFnAQjqHcTu8oD9qn
   Cqh0n8h51KHkxvVGrVXPnuv+/A6tHN6ueSGxAwVzLbmlbqBjN2g3yZEMg
   Q==;
X-CSE-ConnectionGUID: tSN4jR+yQUCwENmmcNhX5g==
X-CSE-MsgGUID: VRlTbueXRTGizFwW/rpitQ==
X-IronPort-AV: E=Sophos;i="6.23,171,1770595200"; 
   d="scan'208";a="15419965"
Received: from ip-10-4-13-79.ec2.internal (HELO smtpout.naws.us-east-1.prod.farcaster.email.amazon.dev) ([10.4.13.79])
  by internal-iad-out-015.esa.us-east-1.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2026 15:25:15 +0000
Received: from EX19MTAUEC002.ant.amazon.com [52.94.133.138:27160]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.91.247:2525] with esmtp (Farcaster)
 id 788f29e3-7b60-44a3-97cf-eb3ae81457f6; Fri, 10 Apr 2026 15:25:15 +0000 (UTC)
X-Farcaster-Flow-ID: 788f29e3-7b60-44a3-97cf-eb3ae81457f6
Received: from EX19D027UEC003.ant.amazon.com (10.252.137.250) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Fri, 10 Apr 2026 15:25:14 +0000
Received: from [192.168.12.97] (10.106.82.30) by EX19D027UEC003.ant.amazon.com
 (10.252.137.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Fri, 10 Apr 2026
 15:25:02 +0000
Message-ID: <547aa730-8cc9-4fd9-94d5-e669aa7bcf87@amazon.com>
Date: Fri, 10 Apr 2026 16:25:00 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <kalyazin@amazon.com>
Subject: Re: [PATCH v11 01/16] set_memory: set_direct_map_* to take address
To: Ackerley Tng <ackerleytng@google.com>, "Kalyazin, Nikita"
	<kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"kernel@xen0n.name" <kernel@xen0n.name>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org"
	<oupton@kernel.org>, "joey.gouly@arm.com" <joey.gouly@arm.com>,
	"suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, "yuzenghui@huawei.com"
	<yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>,
	"tglx@kernel.org" <tglx@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org"
	<willy@infradead.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>,
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>,
	"vbabka@kernel.org" <vbabka@kernel.org>, "rppt@kernel.org" <rppt@kernel.org>,
	"surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>,
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net"
	<daniel@iogearbox.net>, "andrii@kernel.org" <andrii@kernel.org>,
	"martin.lau@linux.dev" <martin.lau@linux.dev>, "eddyz87@gmail.com"
	<eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org"
	<kpsingh@kernel.org>, "sdf@fomichev.me" <sdf@fomichev.me>,
	"haoluo@google.com" <haoluo@google.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "jhubbard@nvidia.com"
	<jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>,
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "riel@surriel.com"
	<riel@surriel.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"jgross@suse.com" <jgross@suse.com>, "yu-cheng.yu@intel.com"
	<yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, "coxu@redhat.com"
	<coxu@redhat.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>,
	"yosry@kernel.org" <yosry@kernel.org>, "ajones@ventanamicro.com"
	<ajones@ventanamicro.com>, "maobibo@loongson.cn" <maobibo@loongson.cn>,
	"tabba@google.com" <tabba@google.com>, "prsampat@amd.com" <prsampat@amd.com>,
	"wu.fei9@sanechips.com.cn" <wu.fei9@sanechips.com.cn>, "mlevitsk@redhat.com"
	<mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com"
	<agordeev@linux.ibm.com>, "alex@ghiti.fr" <alex@ghiti.fr>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "borntraeger@linux.ibm.com"
	<borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>,
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com"
	<gor@linux.ibm.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "pjw@kernel.org" <pjw@kernel.org>,
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>,
	"svens@linux.ibm.com" <svens@linux.ibm.com>, "thuth@redhat.com"
	<thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "urezki@gmail.com"
	<urezki@gmail.com>, "zhengqi.arch@bytedance.com"
	<zhengqi.arch@bytedance.com>, "gerald.schaefer@linux.ibm.com"
	<gerald.schaefer@linux.ibm.com>, "jiayuan.chen@shopee.com"
	<jiayuan.chen@shopee.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"osalvador@suse.de" <osalvador@suse.de>, "pavel@kernel.org"
	<pavel@kernel.org>, "rafael@kernel.org" <rafael@kernel.org>,
	"vannapurve@google.com" <vannapurve@google.com>, "jackmanb@google.com"
	<jackmanb@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack"
	<jackabt@amazon.co.uk>, "Itazuri, Takahiro" <itazur@amazon.co.uk>,
	"Manwaring, Derek" <derekmn@amazon.com>
References: <20260317141031.514-1-kalyazin@amazon.com>
 <20260317141031.514-2-kalyazin@amazon.com>
 <CAEvNRgFUXsO4HLVvyjfU=UX9cO6UrRppyTu1X0_+6SXLhDEN=w@mail.gmail.com>
Content-Language: en-US
From: Nikita Kalyazin <kalyazin@amazon.com>
Autocrypt: addr=kalyazin@amazon.com; keydata=
 xjMEY+ZIvRYJKwYBBAHaRw8BAQdA9FwYskD/5BFmiiTgktstviS9svHeszG2JfIkUqjxf+/N
 JU5pa2l0YSBLYWx5YXppbiA8a2FseWF6aW5AYW1hem9uLmNvbT7CjwQTFggANxYhBGhhGDEy
 BjLQwD9FsK+SyiCpmmTzBQJp2NfjBQkGQlIzAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQr5LK
 IKmaZPPNDAEAvsw8vEWj8ArWQ1QJNufjrvobU/cE8MLKdBxbSE8CyZQA/0BldKxNAtAwG4qw
 wCLxsZ5vBL3Zkh/PdvtFCj/VGscGzjgEY+ZIvRIKKwYBBAGXVQEFAQEHQCqd7/nb2tb36vZt
 ubg1iBLCSDctMlKHsQTp7wCnEc4RAwEIB8J+BBgWCAAmFiEEaGEYMTIGMtDAP0Wwr5LKIKma
 ZPMFAmnY1+MFCQZCUjMCGwwACgkQr5LKIKmaZPPQKgD/f3FtERbJ+LYHLSG/ZbLNAOLngUlQ
 qo5VfIyJOzeLzC0BAP2PIUFIHo7vmia/PXEmT+ve4c5rx+EkH/Dx1GRpjWoI
In-Reply-To: <CAEvNRgFUXsO4HLVvyjfU=UX9cO6UrRppyTu1X0_+6SXLhDEN=w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D004EUA001.ant.amazon.com (10.252.50.27) To
 EX19D027UEC003.ant.amazon.com (10.252.137.250)



On 23/03/2026 18:00, Ackerley Tng wrote:
> "Kalyazin, Nikita" <kalyazin@amazon.co.uk> writes:
> 
>> From: Nikita Kalyazin <kalyazin@amazon.com>
>>
>> This is to avoid excessive conversions folio->page->address when adding
>> helpers on top of set_direct_map_valid_noflush() in the next patch.
>>
> 
> I can't take credit for what Sashiko [1] spotted.
> 
>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
>> ---
>>   arch/arm64/include/asm/set_memory.h     |  7 ++++---
>>   arch/arm64/mm/pageattr.c                | 19 +++++++++----------
>>   arch/loongarch/include/asm/set_memory.h |  7 ++++---
>>   arch/loongarch/mm/pageattr.c            | 25 +++++++++++--------------
>>   arch/riscv/include/asm/set_memory.h     |  7 ++++---
>>   arch/riscv/mm/pageattr.c                | 17 +++++++++--------
>>   arch/s390/include/asm/set_memory.h      |  7 ++++---
>>   arch/s390/mm/pageattr.c                 | 13 +++++++------
>>   arch/x86/include/asm/set_memory.h       |  7 ++++---
>>   arch/x86/mm/pat/set_memory.c            | 23 ++++++++++++-----------
>>   include/linux/set_memory.h              |  9 +++++----
>>   kernel/power/snapshot.c                 |  4 ++--
>>   mm/execmem.c                            |  6 ++++--
>>   mm/secretmem.c                          |  6 +++---
>>   mm/vmalloc.c                            | 11 +++++++----
>>   15 files changed, 89 insertions(+), 79 deletions(-)
>>
>>
>> [...snip...]
>>
>> diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
>> index f5e910b68229..9e08905d3624 100644
>> --- a/arch/loongarch/mm/pageattr.c
>> +++ b/arch/loongarch/mm/pageattr.c
>> @@ -198,32 +198,29 @@ bool kernel_page_present(struct page *page)
>>        return pte_present(ptep_get(pte));
>>   }
>>
>> -int set_direct_map_default_noflush(struct page *page)
>> +int set_direct_map_default_noflush(const void *addr)
>>   {
>> -     unsigned long addr = (unsigned long)page_address(page);
>> -
>> -     if (addr < vm_map_base)
>> +     if ((unsigned long)addr < vm_map_base)
>>                return 0;
>>
>> -     return __set_memory(addr, 1, PAGE_KERNEL, __pgprot(0));
>> +     return __set_memory((unsigned long)addr, 1, PAGE_KERNEL, __pgprot(0));
>>   }
>>
>> -int set_direct_map_invalid_noflush(struct page *page)
>> +int set_direct_map_invalid_noflush(const void *addr)
>>   {
>> -     unsigned long addr = (unsigned long)page_address(page);
>> -
>> -     if (addr < vm_map_base)
>> +     if ((unsigned long)addr < vm_map_base)
>>                return 0;
>>
>> -     return __set_memory(addr, 1, __pgprot(0), __pgprot(_PAGE_PRESENT | _PAGE_VALID));
>> +     return __set_memory((unsigned long)addr, 1, __pgprot(0),
>> +                         __pgprot(_PAGE_PRESENT | _PAGE_VALID));
>>   }
>>
>> -int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>> +int set_direct_map_valid_noflush(const void *addr, unsigned long numpages,
>> +                              bool valid)
>>   {
>> -     unsigned long addr = (unsigned long)page_address(page);
>>        pgprot_t set, clear;
>>
>> -     if (addr < vm_map_base)
>> +     if ((unsigned long)addr < vm_map_base)
>>                return 0;
>>
>>        if (valid) {
>> @@ -234,5 +231,5 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>>                clear = __pgprot(_PAGE_PRESENT | _PAGE_VALID);
>>        }
>>
>> -     return __set_memory(addr, 1, set, clear);
>> +     return __set_memory((unsigned long)addr, 1, set, clear);
> 
> Sashiko also spotted that there is a hard-coded 1 here. Before this
> change, it was already hard-coded to 1. Not sure if this is a
> bug.
> 
> Could this be addressed in a separate patch series?

Yes, I agree, it looks out of scope for this series.

> 
>>   }
>>
>> [...snip...]
>>
>> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
>> index 40581a720fe8..6aea1f470fd5 100644
>> --- a/arch/x86/mm/pat/set_memory.c
>> +++ b/arch/x86/mm/pat/set_memory.c
>> @@ -2587,9 +2587,9 @@ int set_pages_rw(struct page *page, int numpages)
>>        return set_memory_rw(addr, numpages);
>>   }
>>
>> -static int __set_pages_p(struct page *page, int numpages)
>> +static int __set_pages_p(const void *addr, int numpages)
>>   {
>> -     unsigned long tempaddr = (unsigned long) page_address(page);
>> +     unsigned long tempaddr = (unsigned long)addr;
>>        struct cpa_data cpa = { .vaddr = &tempaddr,
>>                                .pgd = NULL,
>>                                .numpages = numpages,
>> @@ -2606,9 +2606,9 @@ static int __set_pages_p(struct page *page, int numpages)
>>        return __change_page_attr_set_clr(&cpa, 1);
>>   }
>>
>> -static int __set_pages_np(struct page *page, int numpages)
>> +static int __set_pages_np(const void *addr, int numpages)
>>   {
>> -     unsigned long tempaddr = (unsigned long) page_address(page);
>> +     unsigned long tempaddr = (unsigned long)addr;
>>        struct cpa_data cpa = { .vaddr = &tempaddr,
>>                                .pgd = NULL,
>>                                .numpages = numpages,
>> @@ -2625,22 +2625,23 @@ static int __set_pages_np(struct page *page, int numpages)
>>        return __change_page_attr_set_clr(&cpa, 1);
>>   }
>>
> 
> I agree that in arch/x86/mm/pat/set_memory.c, __kernel_map_pages(), has
> calls to __set_pages_p() and __set_pages_np() that seems to have been
> missed out in this patch. Those calls still pass struct page *. Maybe
> that's because __kernel_map_pages() was guarded by
> CONFIG_DEBUG_PAGEALLOC, so if you were using an lsp-guided refactoring
> that call was missed.

Fixed, thanks!

> 
> Should probably try a grep to see what else needs replacing :)
> 
> [1] https://sashiko.dev/#/patchset/20260317141031.514-1-kalyazin%40amazon.com
> 
>> -int set_direct_map_invalid_noflush(struct page *page)
>> +int set_direct_map_invalid_noflush(const void *addr)
>>   {
>> -     return __set_pages_np(page, 1);
>> +     return __set_pages_np(addr, 1);
>>   }
>>
>> -int set_direct_map_default_noflush(struct page *page)
>> +int set_direct_map_default_noflush(const void *addr)
>>   {
>> -     return __set_pages_p(page, 1);
>> +     return __set_pages_p(addr, 1);
>>   }
>>
>> -int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>> +int set_direct_map_valid_noflush(const void *addr, unsigned long numpages,
>> +                              bool valid)
>>   {
>>        if (valid)
>> -             return __set_pages_p(page, nr);
>> +             return __set_pages_p(addr, numpages);
>>
>> -     return __set_pages_np(page, nr);
>> +     return __set_pages_np(addr, numpages);
>>   }
>>
>>   #ifdef CONFIG_DEBUG_PAGEALLOC
>>
>> [...snip...]
>>

