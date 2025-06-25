Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5E8273D86
	for <linux-s390@vger.kernel.org>; Wed, 25 Jun 2025 16:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750870069; cv=none; b=Kd7ro3Z98UfsxTmg8aZvDJSaaYSpes7tKgcr0bGGxiAH0DVvCWY7FOa+i7RXIeoNtvoGRoHdhjBAwX6wSJ91HO86SSEWrgQ/l7TQRQjRPjf9CbsME+zpqqCn3+8qB3wiQhjnfKHcXXVmlfUFJ3Is6926D3E0OLb7Y31eiNbjsDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750870069; c=relaxed/simple;
	bh=ZIcwd55I+y4/P3j3gLsFy59kLpT72V5RSK8H+BKGMpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jYZvgB2dfYEN7jM9ZZ9XOgqpM3ZpQo4tp3yxvoC86uM3M+rW5WrxQ9sWHO3sCnhIOXLUjVMkR6dcY4F/Yu0/WqH5iiIapPKbfkFz3kfekpA7qjxmozUvbdTzntsBP/YJq+xBZMc0iUK8jzOT99h0DaqJNhi1g9kbu/5BiMo3BEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RSO/sub5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RSO/sub5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750870066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9M1vHfXIFS9l+R39Mf9youJQuWwRJBkeTDzWO25k2Ts=;
	b=RSO/sub57C+r+0vNeYcck2XsZV1aGNPvqusCKQhiYGVF6TjX0xokuSKqNrEDwUmiG1JZB8
	ses1cuQRqD8/aMe+rvTZb+Vv04n8XM8oFWuUlyGcIpllFB0vbvcl3Eko1n5tZUfI6DkOR/
	1zryi/3SYb+usMhHS7NiZpdzNslY8NA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-H4XdQCNEPKeLOMSXRvXSyA-1; Wed, 25 Jun 2025 12:47:45 -0400
X-MC-Unique: H4XdQCNEPKeLOMSXRvXSyA-1
X-Mimecast-MFC-AGG-ID: H4XdQCNEPKeLOMSXRvXSyA_1750870064
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a523ce0bb2so17634f8f.0
        for <linux-s390@vger.kernel.org>; Wed, 25 Jun 2025 09:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750870064; x=1751474864;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9M1vHfXIFS9l+R39Mf9youJQuWwRJBkeTDzWO25k2Ts=;
        b=fGAguTNRAXlLza8lnmuheyzqBKxCcrmZsdv+rp6LPMG8fCl3OJ63HAspUcgpQ4qTrK
         t8TfJfI8hW36Ei0PvNxa8peXbimgVhL+onlWiNLQUgLMWKs25BO1cHro8y5KM9lJcXg7
         77xJcAbnySenFfEG7vtxxPpccsjfmyHTdIF9bUjhRA3dOfSTCfUz+z6G/vVrxvQpvElv
         rjwsM0DYKoJ85d+yTF1boyXsLWUHwstLSaPECDQNkjx37+xxKxz1SUs7K/MlCAfqjXQV
         OCamLdpyEUdASdAYXIXl/1s/ElUA75jwVobSMXyVSsNxhpYLkKNulSo+68IQ4U7FiXmd
         rdJA==
X-Forwarded-Encrypted: i=1; AJvYcCUAfoBLhSNvEG+ZcJWg9bIeXqr1bge9aOXEfrlS0WBeXzme+Z0EV5X7CxTu2JLjs1+41tykXi45+TIA@vger.kernel.org
X-Gm-Message-State: AOJu0YxUK6toQKnSHGmEgRZiGbTAlxnMW5nfNMABLDukH5mevFp7CQBu
	V66mdEl2D/Vp4d9L6j2s8YNBQGlMGvyUAo7KHK8C26zbbq4ndIWrcDxa6FRJIG03w/DC2T3hhOG
	Tv6SgfTY52TtUojNaZLiNZRB6dHAWjhrChsERWBHoewGWpsAay639Yzb/fofMgHk=
X-Gm-Gg: ASbGncudCpYcL7w5NKdXAAPdJIdnv+PGWnFAnQRgouH4Sxui0v3N+hNBWmtl23g/e5W
	3X8QhJQ8ojKCG1RBlFtJ9Dakexcvn6nW0rg+Lxr+XPALJ5VloHQZ5EEyog/zRblYqNTQw0CbWRU
	NgCBaxBUaGRTyfJq3aEZola9k//N8NGDkta6nqAw60vTV/2OVUmZ1yZEfTHSJF280Ugh6rcVeQ3
	3BdP/r0uLRkYw7QqmxCKJYFejSNHblLy2mhiiGuZ0UsTd4rfyduP7LXju5V97d3p1d3mp5RxR+4
	7WFVEGEKJABqhKzAYZkt5hekrkwLphDV1VUEt/Uq7fSnHgaLlDJ8FVgTGyDBnG637qFZ0xMKEni
	HaakAoOH0DRcyJUfoVFTHfHNevNxDARS4nWbGiS9jFtwE
X-Received: by 2002:a05:6000:1888:b0:3a4:f038:af74 with SMTP id ffacd0b85a97d-3a6ed65b664mr3237859f8f.51.1750870064310;
        Wed, 25 Jun 2025 09:47:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF9YekvGRPkYe/kZTrXaL/81esEkFz4ElnXXiExctA2VcZJSnui1u8qYRsgiNhzuyyjmJbBvg==
X-Received: by 2002:a05:6000:1888:b0:3a4:f038:af74 with SMTP id ffacd0b85a97d-3a6ed65b664mr3237838f8f.51.1750870063878;
        Wed, 25 Jun 2025 09:47:43 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f12:1b00:5d6b:db26:e2b7:12? (p200300d82f121b005d6bdb26e2b70012.dip0.t-ipconnect.de. [2003:d8:2f12:1b00:5d6b:db26:e2b7:12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f2b8fsm5089801f8f.59.2025.06.25.09.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jun 2025 09:47:43 -0700 (PDT)
Message-ID: <db8ab8d0-20f5-4922-a1e2-6f7409747664@redhat.com>
Date: Wed, 25 Jun 2025 18:47:42 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/1] mm/debug_vm_pgtable: Use a swp_entry_t input
 value for swap tests
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>, linux-s390@vger.kernel.org
References: <20250623184321.927418-1-gerald.schaefer@linux.ibm.com>
 <20250623184321.927418-2-gerald.schaefer@linux.ibm.com>
 <9fb04185-5b71-46c0-b62c-0e0e6ee59e6e@arm.com>
 <20250625182846.5bce1aaf@thinkpad-T15>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250625182846.5bce1aaf@thinkpad-T15>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> [...]
>>> @@ -1166,6 +1173,7 @@ static void __init init_fixed_pfns(struct pgtable_debug_args *args)
>>>   
>>>   static int __init init_args(struct pgtable_debug_args *args)
>>>   {
>>> +	unsigned long max_swap_offset;
>>>   	struct page *page = NULL;
>>>   	int ret = 0;
>>>   
>>> @@ -1248,6 +1256,11 @@ static int __init init_args(struct pgtable_debug_args *args)
>>>   
>>>   	init_fixed_pfns(args);
>>>   
>>> +	/* See generic_max_swapfile_size(): probe the maximum offset */
>>> +	max_swap_offset = swp_offset(pte_to_swp_entry(swp_entry_to_pte(swp_entry(0, ~0UL))));
>> Why not directly use generic_max_swapfile_size() which is doing exact same thing.
>>
>> unsigned long generic_max_swapfile_size(void)
>> {
>> 	return swp_offset(pte_to_swp_entry(
>> 			swp_entry_to_pte(swp_entry(0, ~0UL)))) + 1;
>> }
> 
> Good question. I just moved this code here from pte_swap_exclusive_tests(),
> see above, and did not think about that. Now I also wonder why
> generic_max_swapfile_size() wasn't used before.
> 
> But it is not exactly the same thing, there is an extra "+ 1" there.
> Maybe that is the reason, but I don't really understand the details /
> difference, and therefore would not want to change it.
> 
> David, do you remember why you didn't use generic_max_swapfile_size()
> in your pte_swap_exclusive_tests()?

Excellent question. If only I would remember :)

generic_max_swapfile_size() resides in mm/swapfile.c, which is only 
around with CONFIG_SWAP.

It makes sense to have that function only if there are ... actual swapfiles.

These checks here are independent of CONFIG_SWAP (at least in theory -- 
for migration entries etc we don't need CONFIG_SWAP), and we simply want 
to construct a swap PTE with all possible bits set.

-- 
Cheers,

David / dhildenb

