Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D123C6616
	for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2026 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774288851; cv=pass; b=JkRjJlAGw7mJjpEtrYUKlw29qktq09DnxaLoW2jAncQiNtNQ65Ssrs3j1uMClabVIiKgq0StnlT7JioHekWGfHRJwv29xHvTg/lHxLFZX1yntsh6SI+7dNOG0U0e0diPrdBwoFDKkcHng9f8PJVEpsOVGUjfBF/PHsU21f82cCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774288851; c=relaxed/simple;
	bh=Av/Hzs9eLTjG4ms8BX5BJrPk9H3e7lGVAMhv9gUaz4g=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M9rlCWpuAr689dIZ/d8ujQ5H6zIK57qJfzjt4kwcvoIeCCb8oIcQK9xVx9IPD0O7+72yRvhePBKni8MP7hgJEnQhjXlZuLbQ46prqIKeN0YtLPjvOol/PkcFxuXXT0x5kYPAvekX4CzIlVpaaDvvf/fCr9Wse9xEEVBHqoO16jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eUQNE4P7; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eUQNE4P7"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-9516296b730so172614241.2
        for <linux-s390@vger.kernel.org>; Mon, 23 Mar 2026 11:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774288847; cv=none;
        d=google.com; s=arc-20240605;
        b=L4rab9z1eoBRT/QANb/+ms40YBHISxCSQPBGkGnkO9jro/+HUrqWWYNH7YcXwsn3uf
         sA+1FDbDkLbDcpCvpP7wZY7Ol4aLDv7ImczKfsySqFEzgI4MxxGgYNrrmzsh7F1U/SZO
         86imuFRAhrRmq5mr7Iq/NwJhSTI10obR6urr+YACmoxjNKkBg57b5WNVuD8M+9CWueW1
         2kw/TCjw5LlmiX2QR8uy9nyu1cvaiJvfXGo0Gj1Pdnq41jrAvy9wBVy31FHh4vgu+PGN
         wCjSMe2K0YVqvhrpCN9W+ILFqEHzuiE1EkwiyWCkcOQSpBfISZQSUP3HqZJSEmi0z2ja
         fImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=dhS8A80UKHVBBONMyyB3JNJOZLsQWUQ/neWlg69pPXo=;
        fh=3fImy+Qv+B8SbFogboJUldVz0fZjsJj6ZYTo3Wh8I3E=;
        b=MZ3jmwqvKrNOiXy2OhYU5DRr3574oFUhQ3Bx8LHgmoBTPabJ5Y4cUKQXx63v0rVlMT
         rhbmP0jvL6Hz7hor1U+abl+tT4+e8oV42d08SMpT3fJGUD2gSaPUJRWwxrtTI0kjYqoh
         NH/pfL/FwRtPd2361L1Xr6SBBRqSFS3mjDFSIZ8myAUo+0+RYMZLzgsh6msGUf3duSmD
         DRRggYPe8kVH4inZg+NX4IZercL3F9aXD/b+y5nOqQxtzEn3dM7ejY7uFjHD7Eiq208t
         eULGPTwj1p29Z6HOeiGRQ9CZUtoz2WjPxtHo3FU5c5xXZcH6yMUPs7QrtEqumc3zisOA
         +3dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774288847; x=1774893647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dhS8A80UKHVBBONMyyB3JNJOZLsQWUQ/neWlg69pPXo=;
        b=eUQNE4P7biLt2eAONOmtEe79HVwC2/1agWlcB+A2LGm0M6NYO0zNZvFY7lOrkcsjSA
         Kl07m16nc1636QHs9WpGhX+EhvKM7m/6IvsaqQxnXOa1nhtvSI10HgQiKc//7yjDJTsp
         zXj7jc/N/MwY4g1OX4kk3zpaovAwflE0YsaArUkb/oF8+2WZPQ+dlWy4jxleCmB37/xB
         2vbxBlAiMCFohUqxyl8/xAUp1HlZOOb933jj9mS6Wvky1yayspMhMydJSnUiii1a6Jdv
         BYBf43cBY2u/Qsa0SI8VCERJon7BgqAcen5lI3IsE6PVhs/H6dU3ibc2RAkjlvUNGtSt
         pkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774288847; x=1774893647;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dhS8A80UKHVBBONMyyB3JNJOZLsQWUQ/neWlg69pPXo=;
        b=YMNtIiedGVhPIulnzM8Dz+/P7rot7ZMkQgfhQQKguTYX/gHaQ4kTQAepgx7LaWfc5u
         55TcDHlw0yiE0t1cZLjlgPvJmJqKyRzl7tCF8bFWZGKFkZDEbgexvL/dluX6AccG7UYp
         D7N3+Ddp0OpHQTErJ5PazPtCEYyYE64DOmt0oQR3yfFFOr+HuZbZ6kUhpJaxqCTcEGFG
         5xla3mzY88keq11cufX2avvLV2L71lrD3ZgS7/1ooecXPe01pGpCqD6ehE/wrSvf5exG
         h/YFvDHaQZCScYaFCG5hsUY3CWl1XDOGJ/HVNVfZfQlHPgpD+HpQp04m7FKLdK+ZBdrb
         +xZw==
X-Forwarded-Encrypted: i=1; AJvYcCX/xAJ5GJf7Qp6ztJtlE2y7bbuBuC34xJEE38ah7HbiErhtKVo0SLwCP3/TQ3LZgQkOaDOGVUgad580@vger.kernel.org
X-Gm-Message-State: AOJu0YzxLaMncW+gQ0yYEgMP7ef0LQwvn9RjhiBFubtZC0J7TG6a6NEZ
	K+LMizwG7beA7XRgVl6Oo3RQuQErgroNy7DOJiJOt7aRaxHI5iAcA50qWf326G+sEXIU3Zqe2mh
	tAFWet7baezvoQowxmua71+2Melg25Tw1JYFi1YXD
X-Gm-Gg: ATEYQzy1CS4BYLI9u7nTxbZL7EwbplTx0Tq6AhV6OaDqMpufISrZyzhnnShFNSMf3Ts
	MISgf/5A+uUoqZVFKhSG6N+eTiRL0a/A++fk+C0kcyw5In+0Et3N73VLNW32QvlPFYeiFF+ChXX
	u6EYKOauln0iPNlXbRF/OD0zlmV8nC/ucmUis4aaHT17KTEnHyVHpgKyBzqhBu4q4l90OOKpNi3
	Q7V8gQqCc3tJs4hhAnVNRqIcJCA1JX3Wh7Nnd4wRJLqa65jvvPfhYtKwZoqif9Thx8w3ZDkWsYP
	cwPwAP9l0gtMNpjmsHWuQZCkFxgUWNPaQedItZqksyLCO0xUcjt83XxmUV7XIIq332w0lw==
X-Received: by 2002:a05:6102:26d1:b0:5ff:ea89:44b5 with SMTP id
 ada2fe7eead31-602aed5357cmr6709465137.32.1774288846075; Mon, 23 Mar 2026
 11:00:46 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Mar 2026 11:00:45 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 23 Mar 2026 11:00:44 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260317141031.514-2-kalyazin@amazon.com>
References: <20260317141031.514-1-kalyazin@amazon.com> <20260317141031.514-2-kalyazin@amazon.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 23 Mar 2026 11:00:44 -0700
X-Gm-Features: AQROBzCftGX5aQ7J_uujSzbFVwlRhmdq4pmEC-kWuwHc-7ThhwmICNIjXxt4gxA
Message-ID: <CAEvNRgFUXsO4HLVvyjfU=UX9cO6UrRppyTu1X0_+6SXLhDEN=w@mail.gmail.com>
Subject: Re: [PATCH v11 01/16] set_memory: set_direct_map_* to take address
To: "Kalyazin, Nikita" <kalyazin@amazon.co.uk>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "kernel@xen0n.name" <kernel@xen0n.name>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, 
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, 
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"maz@kernel.org" <maz@kernel.org>, "oupton@kernel.org" <oupton@kernel.org>, 
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "suzuki.poulose@arm.com" <suzuki.poulose@arm.com>, 
	"yuzenghui@huawei.com" <yuzenghui@huawei.com>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>, 
	"will@kernel.org" <will@kernel.org>, "seanjc@google.com" <seanjc@google.com>, "tglx@kernel.org" <tglx@kernel.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "willy@infradead.org" <willy@infradead.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "david@kernel.org" <david@kernel.org>, 
	"lorenzo.stoakes@oracle.com" <lorenzo.stoakes@oracle.com>, "vbabka@kernel.org" <vbabka@kernel.org>, 
	"rppt@kernel.org" <rppt@kernel.org>, "surenb@google.com" <surenb@google.com>, "mhocko@suse.com" <mhocko@suse.com>, 
	"ast@kernel.org" <ast@kernel.org>, "daniel@iogearbox.net" <daniel@iogearbox.net>, 
	"andrii@kernel.org" <andrii@kernel.org>, "martin.lau@linux.dev" <martin.lau@linux.dev>, 
	"eddyz87@gmail.com" <eddyz87@gmail.com>, "song@kernel.org" <song@kernel.org>, 
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>, 
	"sdf@fomichev.me" <sdf@fomichev.me>, "haoluo@google.com" <haoluo@google.com>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>, 
	"jhubbard@nvidia.com" <jhubbard@nvidia.com>, "peterx@redhat.com" <peterx@redhat.com>, 
	"jannh@google.com" <jannh@google.com>, "pfalcato@suse.de" <pfalcato@suse.de>, 
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>, "riel@surriel.com" <riel@surriel.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "jgross@suse.com" <jgross@suse.com>, 
	"yu-cheng.yu@intel.com" <yu-cheng.yu@intel.com>, "kas@kernel.org" <kas@kernel.org>, 
	"coxu@redhat.com" <coxu@redhat.com>, "kevin.brodsky@arm.com" <kevin.brodsky@arm.com>, 
	"yosry@kernel.org" <yosry@kernel.org>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>, 
	"maobibo@loongson.cn" <maobibo@loongson.cn>, "tabba@google.com" <tabba@google.com>, 
	"prsampat@amd.com" <prsampat@amd.com>, "wu.fei9@sanechips.com.cn" <wu.fei9@sanechips.com.cn>, 
	"mlevitsk@redhat.com" <mlevitsk@redhat.com>, "jmattson@google.com" <jmattson@google.com>, 
	"jthoughton@google.com" <jthoughton@google.com>, "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>, 
	"alex@ghiti.fr" <alex@ghiti.fr>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, 
	"borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "chenhuacai@kernel.org" <chenhuacai@kernel.org>, 
	"dev.jain@arm.com" <dev.jain@arm.com>, "gor@linux.ibm.com" <gor@linux.ibm.com>, 
	"hca@linux.ibm.com" <hca@linux.ibm.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>, 
	"pjw@kernel.org" <pjw@kernel.org>, 
	"shijie@os.amperecomputing.com" <shijie@os.amperecomputing.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>, 
	"thuth@redhat.com" <thuth@redhat.com>, "wyihan@google.com" <wyihan@google.com>, 
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>, 
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, 
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "urezki@gmail.com" <urezki@gmail.com>, 
	"zhengqi.arch@bytedance.com" <zhengqi.arch@bytedance.com>, 
	"gerald.schaefer@linux.ibm.com" <gerald.schaefer@linux.ibm.com>, 
	"jiayuan.chen@shopee.com" <jiayuan.chen@shopee.com>, "lenb@kernel.org" <lenb@kernel.org>, 
	"osalvador@suse.de" <osalvador@suse.de>, "pavel@kernel.org" <pavel@kernel.org>, 
	"rafael@kernel.org" <rafael@kernel.org>, "vannapurve@google.com" <vannapurve@google.com>, 
	"jackmanb@google.com" <jackmanb@google.com>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>, 
	"patrick.roy@linux.dev" <patrick.roy@linux.dev>, "Thomson, Jack" <jackabt@amazon.co.uk>, 
	"Itazuri, Takahiro" <itazur@amazon.co.uk>, "Manwaring, Derek" <derekmn@amazon.com>
Content-Type: text/plain; charset="UTF-8"

"Kalyazin, Nikita" <kalyazin@amazon.co.uk> writes:

> From: Nikita Kalyazin <kalyazin@amazon.com>
>
> This is to avoid excessive conversions folio->page->address when adding
> helpers on top of set_direct_map_valid_noflush() in the next patch.
>

I can't take credit for what Sashiko [1] spotted.

> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Nikita Kalyazin <kalyazin@amazon.com>
> ---
>  arch/arm64/include/asm/set_memory.h     |  7 ++++---
>  arch/arm64/mm/pageattr.c                | 19 +++++++++----------
>  arch/loongarch/include/asm/set_memory.h |  7 ++++---
>  arch/loongarch/mm/pageattr.c            | 25 +++++++++++--------------
>  arch/riscv/include/asm/set_memory.h     |  7 ++++---
>  arch/riscv/mm/pageattr.c                | 17 +++++++++--------
>  arch/s390/include/asm/set_memory.h      |  7 ++++---
>  arch/s390/mm/pageattr.c                 | 13 +++++++------
>  arch/x86/include/asm/set_memory.h       |  7 ++++---
>  arch/x86/mm/pat/set_memory.c            | 23 ++++++++++++-----------
>  include/linux/set_memory.h              |  9 +++++----
>  kernel/power/snapshot.c                 |  4 ++--
>  mm/execmem.c                            |  6 ++++--
>  mm/secretmem.c                          |  6 +++---
>  mm/vmalloc.c                            | 11 +++++++----
>  15 files changed, 89 insertions(+), 79 deletions(-)
>
>
> [...snip...]
>
> diff --git a/arch/loongarch/mm/pageattr.c b/arch/loongarch/mm/pageattr.c
> index f5e910b68229..9e08905d3624 100644
> --- a/arch/loongarch/mm/pageattr.c
> +++ b/arch/loongarch/mm/pageattr.c
> @@ -198,32 +198,29 @@ bool kernel_page_present(struct page *page)
>  	return pte_present(ptep_get(pte));
>  }
>
> -int set_direct_map_default_noflush(struct page *page)
> +int set_direct_map_default_noflush(const void *addr)
>  {
> -	unsigned long addr = (unsigned long)page_address(page);
> -
> -	if (addr < vm_map_base)
> +	if ((unsigned long)addr < vm_map_base)
>  		return 0;
>
> -	return __set_memory(addr, 1, PAGE_KERNEL, __pgprot(0));
> +	return __set_memory((unsigned long)addr, 1, PAGE_KERNEL, __pgprot(0));
>  }
>
> -int set_direct_map_invalid_noflush(struct page *page)
> +int set_direct_map_invalid_noflush(const void *addr)
>  {
> -	unsigned long addr = (unsigned long)page_address(page);
> -
> -	if (addr < vm_map_base)
> +	if ((unsigned long)addr < vm_map_base)
>  		return 0;
>
> -	return __set_memory(addr, 1, __pgprot(0), __pgprot(_PAGE_PRESENT | _PAGE_VALID));
> +	return __set_memory((unsigned long)addr, 1, __pgprot(0),
> +			    __pgprot(_PAGE_PRESENT | _PAGE_VALID));
>  }
>
> -int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
> +int set_direct_map_valid_noflush(const void *addr, unsigned long numpages,
> +				 bool valid)
>  {
> -	unsigned long addr = (unsigned long)page_address(page);
>  	pgprot_t set, clear;
>
> -	if (addr < vm_map_base)
> +	if ((unsigned long)addr < vm_map_base)
>  		return 0;
>
>  	if (valid) {
> @@ -234,5 +231,5 @@ int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
>  		clear = __pgprot(_PAGE_PRESENT | _PAGE_VALID);
>  	}
>
> -	return __set_memory(addr, 1, set, clear);
> +	return __set_memory((unsigned long)addr, 1, set, clear);

Sashiko also spotted that there is a hard-coded 1 here. Before this
change, it was already hard-coded to 1. Not sure if this is a
bug.

Could this be addressed in a separate patch series?

>  }
>
> [...snip...]
>
> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index 40581a720fe8..6aea1f470fd5 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2587,9 +2587,9 @@ int set_pages_rw(struct page *page, int numpages)
>  	return set_memory_rw(addr, numpages);
>  }
>
> -static int __set_pages_p(struct page *page, int numpages)
> +static int __set_pages_p(const void *addr, int numpages)
>  {
> -	unsigned long tempaddr = (unsigned long) page_address(page);
> +	unsigned long tempaddr = (unsigned long)addr;
>  	struct cpa_data cpa = { .vaddr = &tempaddr,
>  				.pgd = NULL,
>  				.numpages = numpages,
> @@ -2606,9 +2606,9 @@ static int __set_pages_p(struct page *page, int numpages)
>  	return __change_page_attr_set_clr(&cpa, 1);
>  }
>
> -static int __set_pages_np(struct page *page, int numpages)
> +static int __set_pages_np(const void *addr, int numpages)
>  {
> -	unsigned long tempaddr = (unsigned long) page_address(page);
> +	unsigned long tempaddr = (unsigned long)addr;
>  	struct cpa_data cpa = { .vaddr = &tempaddr,
>  				.pgd = NULL,
>  				.numpages = numpages,
> @@ -2625,22 +2625,23 @@ static int __set_pages_np(struct page *page, int numpages)
>  	return __change_page_attr_set_clr(&cpa, 1);
>  }
>

I agree that in arch/x86/mm/pat/set_memory.c, __kernel_map_pages(), has
calls to __set_pages_p() and __set_pages_np() that seems to have been
missed out in this patch. Those calls still pass struct page *. Maybe
that's because __kernel_map_pages() was guarded by
CONFIG_DEBUG_PAGEALLOC, so if you were using an lsp-guided refactoring
that call was missed.

Should probably try a grep to see what else needs replacing :)

[1] https://sashiko.dev/#/patchset/20260317141031.514-1-kalyazin%40amazon.com

> -int set_direct_map_invalid_noflush(struct page *page)
> +int set_direct_map_invalid_noflush(const void *addr)
>  {
> -	return __set_pages_np(page, 1);
> +	return __set_pages_np(addr, 1);
>  }
>
> -int set_direct_map_default_noflush(struct page *page)
> +int set_direct_map_default_noflush(const void *addr)
>  {
> -	return __set_pages_p(page, 1);
> +	return __set_pages_p(addr, 1);
>  }
>
> -int set_direct_map_valid_noflush(struct page *page, unsigned nr, bool valid)
> +int set_direct_map_valid_noflush(const void *addr, unsigned long numpages,
> +				 bool valid)
>  {
>  	if (valid)
> -		return __set_pages_p(page, nr);
> +		return __set_pages_p(addr, numpages);
>
> -	return __set_pages_np(page, nr);
> +	return __set_pages_np(addr, numpages);
>  }
>
>  #ifdef CONFIG_DEBUG_PAGEALLOC
>
> [...snip...]
>
