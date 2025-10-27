Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AB430FC17
	for <linux-s390@vger.kernel.org>; Mon, 27 Oct 2025 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584406; cv=none; b=QafFZh6TUk4J+xbV+BpkFu0qgGjGz72v7YxJtRf8bwT89yt7QqeZCZB283/KjmqK4Z7Fzc/hLnDfbeLq7cmL887OzMdL/n0IbbX8kDeJR6F3+t5BBOIB1ugcWQe7FjZedSYn4Masdyfu6kPOz4u4l7SBjxcxQY2cJlevoirl228=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584406; c=relaxed/simple;
	bh=11FvH37vXLygcrLKcfABZ05+0WkAcgOd1O+yThJgZi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLjQtxCtba0CcNm6MufZ+FlROxfCSDUkVrJJWVX/k7MGZV37HvV3ZSfIJEJyqCpBI9Hk3NNSH5c5dNpQPc6GC3wnD/+g3Wg1u7J6pHZwsThxyLzIVWxTWHYF/hc2Z+XXQbsUr1DnvSTdg2mju+nfmXx9lft1i9zz5Ps61BE58Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VB+2++4U; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VB+2++4U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761584403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VPdePOfud/gTRbDwaWlddH91CzCWm669JLEOi7t0B7k=;
	b=VB+2++4UDFb5pIO5k4MKCw6+GSLKo5rul4aoIa6EihVxI5hdspebWIEtZmJ3kCyV/zFsj/
	exsNz9lOPxSKlG/lQJJiyw7BG4uqqEiduU9vRaTx3Yzg3eqnHjCbAw2E52rNfAi++b+xx4
	3nZTFT4GKzxZJymMgMFrn2ZEb23JT0A=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-r0qVQenPPD-iXTbTohPVAQ-1; Mon, 27 Oct 2025 13:00:01 -0400
X-MC-Unique: r0qVQenPPD-iXTbTohPVAQ-1
X-Mimecast-MFC-AGG-ID: r0qVQenPPD-iXTbTohPVAQ_1761584401
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-475ddd57999so20233915e9.1
        for <linux-s390@vger.kernel.org>; Mon, 27 Oct 2025 10:00:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761584400; x=1762189200;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VPdePOfud/gTRbDwaWlddH91CzCWm669JLEOi7t0B7k=;
        b=TR7EDUahUKrNEWfZIWHmsnBdjyRvOuCn8qkEME5d6+WzkQCTdIMlZc+1iyLXNazAna
         PvzzujH5BeuoVdviVYFoq3gxcHj7r5Ku/fb+2yoeoWEWAUwtQ+HLnt1y6Jm9Oh68hisH
         ArWe64Ca9Dyv187KAIMjCtuX4PzT0OcWxB3wnSi2dURItcGpeiKLjOXLZ++1oeg6fCSR
         0YqHleGd+S0Uk07zAJUcQQ/UcNUS0YfZb3uZ7XGas7TRV4CFIGFeKoWc4y/V+ei7PbAW
         D2mQOpoSoi2HJS26H5SZ9rpoFH9Qhp/f8jCmHdIVkcsymEPo/yT1HNWTGpXhsmtSdhwX
         Kbrg==
X-Forwarded-Encrypted: i=1; AJvYcCWFKWpBkOnDUM4KSdoSf9uJk6IuwSneHEv8kqcvKkQDUycKf7kvbiTdoNJqQVXnZInM0BL47Wb+Meo8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7L3Rau5/s1v4+E70zNjbhDbkbNuVOWc+K+TZqYl/qSjZMZRcU
	5FOyDsns57d316DMwuMtDhrLyH1TatWeGlUFfHLz0SuzNztCYVPOZLiLeNzY4jjmmbYWkoOXibS
	RO7wqL9403wm62uRqsO2IyDuOrxokhw2ZTuwWleilJeqa02oQN7JK6c4i9+m/JH8=
X-Gm-Gg: ASbGncv6GjwKBn1uyDXGj36gx2ib/XVpW+VJP4QTR7PJ1unNKYxQ/qoU6wDOhMqQ7/T
	22pKV3CowXmd8wV8eBXC4cUx4XXKo1QfDXBWhlbG9mqKi4WCJrOGo8LN64fJCtLkWRBCIvtiSL0
	+Kz4nWUSoxc+ahtn072ajhK7QNGTUWR76AQdzgA45il8gYn/wOG/vZy3gyrWFIB+/QVXPZFF27n
	eKfuMuVZOSYS0aH56+VHMDnvO2wAgGGevptCxncQlP1254fs3UtsVf8MXQX4sO1k7nTXbr5pO09
	FNPiI/DCDRBcSJ6S/NtD+tKL9Y+DsMd4M5tZo2vypsST33x+tyqKAV8fjrrBy7S/jHhWXyxwc6x
	uKN2KPZeqSiGdlS44G+rfXtm13QrYfgN0sNe7LDTiNmnPW93k1biBpgRBV0+AGKMKEHYY6Cs281
	vRwztBTtXGZx7+9QyRlRKb6/pLDVc=
X-Received: by 2002:a05:600c:6215:b0:471:16b1:b824 with SMTP id 5b1f17b1804b1-47717e3f3b5mr3497725e9.28.1761584400500;
        Mon, 27 Oct 2025 10:00:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1punvjQGH5qjORoP9iHJACPCMWv2X1DQYdUT6Rf/tzl5ujUWNGjF8uD9GnRgJxgCJIA9BGg==
X-Received: by 2002:a05:600c:6215:b0:471:16b1:b824 with SMTP id 5b1f17b1804b1-47717e3f3b5mr3497205e9.28.1761584400037;
        Mon, 27 Oct 2025 10:00:00 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169? (p200300d82f3f4b00ee138c225cc5d169.dip0.t-ipconnect.de. [2003:d8:2f3f:4b00:ee13:8c22:5cc5:d169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd489e6dsm144533855e9.6.2025.10.27.09.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:59:59 -0700 (PDT)
Message-ID: <ab29d7f1-f129-4b99-80c0-abfa8a6498bd@redhat.com>
Date: Mon, 27 Oct 2025 17:59:57 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: KVM/s390x regression
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Balbir Singh <balbirs@nvidia.com>, Liam.Howlett@oracle.com,
 airlied@gmail.com, akpm@linux-foundation.org, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
 dakr@kernel.org, dev.jain@arm.com, dri-devel@lists.freedesktop.org,
 francois.dugast@intel.com, gourry@gourry.net, joshua.hahnjy@gmail.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, lyude@redhat.com, matthew.brost@intel.com,
 mpenttil@redhat.com, npache@redhat.com, osalvador@suse.de, rakie.kim@sk.com,
 rcampbell@nvidia.com, ryan.roberts@arm.com, simona@ffwll.ch,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, linux-next@vger.kernel.org
References: <20251001065707.920170-4-balbirs@nvidia.com>
 <20251017144924.10034-1-borntraeger@linux.ibm.com>
 <9beff9d6-47c7-4a65-b320-43efd1e12687@redhat.com>
 <c67386be-5278-411d-97e7-43fc34bf7c98@linux.ibm.com>
 <8c778cd0-5608-4852-9840-4d98828d7b33@redhat.com>
 <74272098-cfb7-424b-a55e-55e94f04524e@linux.ibm.com>
 <84349344-b127-41f6-99f1-10f907c2bd07@redhat.com>
 <c9f28d0c-6b06-47a2-884d-7533f7b49c45@nvidia.com>
 <f5debf87-0477-4d6a-8280-0cd95cd09412@linux.ibm.com>
 <748cdc18-e32d-41bd-90d1-a102b1c51e06@redhat.com>
 <20251027174726.5d8fcce7@p-imbrenda>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20251027174726.5d8fcce7@p-imbrenda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.10.25 17:47, Claudio Imbrenda wrote:
> On Mon, 20 Oct 2025 10:41:28 +0200
> David Hildenbrand <david@redhat.com> wrote:
> 
>> On 20.10.25 09:00, Christian Borntraeger wrote:
>>> Am 17.10.25 um 23:56 schrieb Balbir Singh:
>>>    
>>>> In the meanwhile, does this fix/workaround work?
>>>>
>>>> diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
>>>> index 0c847cdf4fd3..31c1754d5bd4 100644
>>>> --- a/mm/pgtable-generic.c
>>>> +++ b/mm/pgtable-generic.c
>>>> @@ -290,7 +290,7 @@ pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
>>>>     
>>>>     	if (pmdvalp)
>>>>     		*pmdvalp = pmdval;
>>>> -	if (unlikely(pmd_none(pmdval) || !pmd_present(pmdval)))
>>>> +	if (unlikely(pmd_none(pmdval) || is_pmd_non_present_folio_entry(pmdval)))
>>>>     		goto nomap;
>>>>     	if (unlikely(pmd_trans_huge(pmdval)))
>>>>     		goto nomap;
>>>>   
>>>
>>> Yes, this seems to work.
>>
>> Right, but that's not what we will want here. We'll have to adjust s390x
>> gmap code (which is getting redesigned either way) to only take the page
>> lock.
>>
>> In the end, we'll want here later a single
>>
>> if (!pmd_present(pmdval))
>> 	goto nomap;
>>
> 
> this seems to do the trick:
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 8ff6bba107e8..22c448b32340 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -599,8 +599,9 @@ int __gmap_link(struct gmap *gmap, unsigned long
> gaddr, unsigned long vmaddr) | _SEGMENT_ENTRY_GMAP_UC
>                                          | _SEGMENT_ENTRY;
>                          } else
> -                               *table = pmd_val(*pmd) &
> -                                       _SEGMENT_ENTRY_HARDWARE_BITS;
> +                               *table = (pmd_val(*pmd) &
> +                                       _SEGMENT_ENTRY_HARDWARE_BITS)
> +                                       | _SEGMENT_ENTRY;

Probably worth adding a comment. I remember we don't reuse this bit as a 
SW bit in gmap code, right?

>                  }
>          } else if (*table & _SEGMENT_ENTRY_PROTECT &&
>                     !(pmd_val(*pmd) & _SEGMENT_ENTRY_PROTECT)) {
> 
> 
> 
> it marks non-leaf gmap segment (pmd) entries as present, just as normal
> pmds would be.

Yeah, I looked into hand-coding the PTL lookup but it just gets nasty 
real quick.

> 
> I think it's a good enough fix for now, pending the rewrite, which I
> hope to get in the next merge window

Agreed.

-- 
Cheers

David / dhildenb

