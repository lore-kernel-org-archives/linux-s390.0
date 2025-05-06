Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC83281500;
	Tue,  6 May 2025 14:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543400; cv=none; b=kRQr7R1uVle233j4J9Z2fbfk6/v5BDa9Yie4+qtJAAL9gKcNddF2QrRjpsBZHaOqxdzq9RB7tNApibyZ7NI+pyjuKSUizGJFOzrQ6px1N8SBP5Y121/Dj+jgpmCrYW+kAx7LuLSrGyXt3zKt1PNp92/brRVypvK69IC/CgHGKLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543400; c=relaxed/simple;
	bh=xRXc4wu/bRY/Kf07/sLHF46eWd3sAL/KwF1CNA0EQoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hLKtzaFHLtd8WcQpL2PjnLniJeKcrJlZf6Yfagagh2hvRc79uHeUPbYILRO6/5n8MnXi8STxK+2hXIKx3dMS62QMBq+Sh+jLZTU2oMoZHFJLBZwl0ToobahHcHN0kx/t1y+vVa/Y4xis8lhTGMxKEVgIgaZF4El4Qztdoi5v41Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FODUeyIm; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FODUeyIm"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5499cca5ddbso765511e87.1;
        Tue, 06 May 2025 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746543397; x=1747148197; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zGl6sg7j0zxSLThVkHoNmDxdriQ/RPO7fP3JuwQs5eI=;
        b=FODUeyImSfmTywq6d08n426ChkyidgezkWq2/y3OQEyfaWrlEDHf4zaRQ7qPIf2Go9
         eXPVI2lBdoTKhCfX2L1WJASCAm5ZBSNqFntVjUQQaPGh1SoW4a7BefCVsVI26/Unx4/t
         toQjFOjgnH6dnwHYyGoAEy8qqkzEORdYrKRmrGeYrgghMHhxI9OTNP0t5F2Tly5WRN2O
         uRnYxc323dmRybyIiHoKtHEi79BSuHF+/gY4xsQR8R3CKamE78TGM2tAWTTjvWUUYMoh
         DGO1BD3LKUgG96aMFK6j+wHrDkxC3Ca3+CTo+IrgNS9X7bh7Bui4q2IIUsutAqhEKFVQ
         STUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746543397; x=1747148197;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGl6sg7j0zxSLThVkHoNmDxdriQ/RPO7fP3JuwQs5eI=;
        b=xENFWIhW8WUlgtIhMZ5eSdGq9W8lF1DCLHUBpV3g0wObEo6Ikl/oETzTnczhxygKWT
         ZKPs4/3gifLSV+njp9mfgvZClAGJ5sxVeiTdm76tfPQf9BwVAgugr8mEIxKJXtom6LZ1
         lzHYHaNI9zmHea15fcerQhQ8dE/C1GisqbjgdQzBsuJd6PqUfpJX+Jb2jWN6jJJRUSVQ
         nvahaN/W2kVALiWmuQFpb1+EpLJKeKlNz1F5WMz3g26luewT9KnqfAgT+5B9lkz7/b3x
         qh7ib1uj069TJAHBUykqzmYz+n4wynXRd03M6WkTgszQhrqCZFLnJZLokXCHlKLPhKXo
         om7g==
X-Forwarded-Encrypted: i=1; AJvYcCVNUCtfSre6U2vZbf42KdWr4oI0NRBObr+Hcz9JFoDoIcicOKXwi/oQwdkPHq1L6zkt/7illWZx@vger.kernel.org, AJvYcCVW1diNtKxAwNtXYYSJ0Y2v6gpI1vSUxxPP4grRck/uU7Q2q7I6kCPL/Jz0S5w9heYbYsosV257zvJNXSc=@vger.kernel.org, AJvYcCVaQSpSVO6J2/kdXAIbKehPzE9Zm0gH4W65hw2kuXXnIgqXz6uY2lOge8aigWNi2NsR3aLkZMB32mFs/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaVj5dSsg4uN68jOhp7BHEP5KrBWQp8x7Ld24qf5V4E/dBdHSY
	NOytddh1PswV0a+vSqHDM9+sJb4j1yN783R41l12JYvCXmvAqQNh
X-Gm-Gg: ASbGnctoMP13PF3cbHghjxRKPPdTo7hbQpbLp+qWOc5DdHSD/EoUH8YTfeEltfmd/oS
	Fe8mLl+Q5uuccp6/n7IiHyXmvCH0GzNiQG2ay9oN7h46vm0PSkYVzCvR6cepH3P92ktmKOyYGBK
	6tjzJqFBHp5rUY20jAvyezYSEtnRDGTsIuqRo5vu4w0XAPJAQyyHQgDxhjDUnEvG5aj52o+gX8H
	hZGwfpUyhmJWbXHRSt2uttlcl3ux+7gLKqdcUrXR2e/3blybtIZFRPZU8AmaBveWxnuuha3/E4v
	knjl/UFKD0pLtamYyxuu8QU1jFIJvDVvKaEPVFD3cKmMk2k=
X-Google-Smtp-Source: AGHT+IHIniqK0Dw2iKq/2KeW3kBL4LRttdpuvsbiEa+Br6r8BEN70vWNoWz8zaAHodNkwnZWIPSYvA==
X-Received: by 2002:a05:6512:159a:b0:549:8f39:3e63 with SMTP id 2adb3069b0e04-54eac20dcbdmr1776226e87.9.1746543396571;
        Tue, 06 May 2025 07:56:36 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ea94b16b6sm2071820e87.12.2025.05.06.07.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 May 2025 07:56:35 -0700 (PDT)
Message-ID: <d77f4afd-5d4e-4bd0-9c83-126e8ef5c4ed@gmail.com>
Date: Tue, 6 May 2025 16:55:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] kasan: Avoid sleepable page allocation from atomic
 context
To: Alexander Gordeev <agordeev@linux.ibm.com>,
 Harry Yoo <harry.yoo@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Axtens
 <dja@axtens.net>, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kasan-dev@googlegroups.com, linux-s390@vger.kernel.org,
 stable@vger.kernel.org
References: <cover.1745940843.git.agordeev@linux.ibm.com>
 <573a823565734e1eac3aa128fb9d3506ec918a72.1745940843.git.agordeev@linux.ibm.com>
 <aBFbCP9TqNN0bGpB@harry>
 <aBoGFr5EaHFfxuON@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <aBoGFr5EaHFfxuON@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/6/25 2:52 PM, Alexander Gordeev wrote:
> On Wed, Apr 30, 2025 at 08:04:40AM +0900, Harry Yoo wrote:
> 

>>>  
>>> +struct vmalloc_populate_data {
>>> +	unsigned long start;
>>> +	struct page **pages;
>>> +};
>>> +
>>>  static int kasan_populate_vmalloc_pte(pte_t *ptep, unsigned long addr,
>>> -				      void *unused)
>>> +				      void *_data)
>>>  {
>>> -	unsigned long page;
>>> +	struct vmalloc_populate_data *data = _data;
>>> +	struct page *page;
>>> +	unsigned long pfn;
>>>  	pte_t pte;
>>>  
>>>  	if (likely(!pte_none(ptep_get(ptep))))
>>>  		return 0;
>>>  
>>> -	page = __get_free_page(GFP_KERNEL);
>>> -	if (!page)
>>> -		return -ENOMEM;
>>> -
>>> -	__memset((void *)page, KASAN_VMALLOC_INVALID, PAGE_SIZE);
>>> -	pte = pfn_pte(PFN_DOWN(__pa(page)), PAGE_KERNEL);
>>> +	page = data->pages[PFN_DOWN(addr - data->start)];
>>> +	pfn = page_to_pfn(page);
>>> +	__memset(pfn_to_virt(pfn), KASAN_VMALLOC_INVALID, PAGE_SIZE);
>>> +	pte = pfn_pte(pfn, PAGE_KERNEL);
>>>  
>>>  	spin_lock(&init_mm.page_table_lock);
>>> -	if (likely(pte_none(ptep_get(ptep)))) {
>>> +	if (likely(pte_none(ptep_get(ptep))))
>>>  		set_pte_at(&init_mm, addr, ptep, pte);
>>> -		page = 0;
>>
>> With this patch, now if the pte is already set, the page is leaked?
> 
> Yes. But currently it is leaked for previously allocated pages anyway,
> so no change in behaviour (unless I misread the code).

Current code doesn't even allocate page if pte set, and if set pte discovered only after
taking spinlock, the page will be freed, not leaked.

Whereas, this patch leaks page for every single !pte_none case. This will build up over time
as long as vmalloc called.

> 
>> Should we set data->pages[PFN_DOWN(addr - data->start)] = NULL 
>> and free non-null elements later in __kasan_populate_vmalloc()?
> 
> Should the allocation fail on boot, the kernel would not fly anyway.

This is not boot code, it's called from vmalloc() code path.

> If for whatever reason we want to free, that should be a follow-up
> change, as far as I am concerned.
> 
We want to free it, because we don't want unbound memory leak.


