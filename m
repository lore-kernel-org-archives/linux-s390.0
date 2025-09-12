Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A753009D5
	for <linux-s390@vger.kernel.org>; Fri, 12 Sep 2025 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676885; cv=none; b=NcPSRhqzUlQxnFxWucT7vgPbO9mwRPPR6rJ6A/XUgIU8KwE4rcBosw4VRlTzHks8Ey8l7Y5DTyK27+Tq3rovSYBp7iJMUbStcPMnBd9T9QbLxj+sh9Ph2FymEefbRDC3tHD15cdLYa9xyLR0T6YMbdplZhcZJ/XuaCzGhoJOtWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676885; c=relaxed/simple;
	bh=2xByMI5F86FXQ/YNzPul1DNfvLb05F0F4wRGQQrq5Fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jhexrwrOJTQ3XGNcL8Uyr0Y8M9Wbk8yUMANr4Mv0QIJeGArZfIYSh8TwWoLKusG7MOFq/WthEPlzTXNr5ATtgq/2oCzOikv0v9yFgPzh7j1F4neBJhjBjMyOTV826AYiUQxQr9Yq/MkFGMUM2B+WBNiXPblheAoiErUIlSBeiDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lz3BmvmO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lz3BmvmO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757676882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ZWd+C+6xlO7ZNnElus07Td372OLIDupg0E/fPHS2G6s=;
	b=Lz3BmvmOLHBg/6PtImScADLSvnkSvbLTJCj/a/WTlvF5gSQUuwTULUQcgYQPULlq0SSYXV
	KqkohEldUl7R36u4fvakdAiYm6vFbloC8I7Y+/SmMv6DaYufEgi7pvlCT3YYcYrvn2ogBE
	cDvzx9W0B/XKTWarrkWnKaKMXn0EjnM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-QPn7EnwMO22_A9ROnvKDRA-1; Fri, 12 Sep 2025 07:34:41 -0400
X-MC-Unique: QPn7EnwMO22_A9ROnvKDRA-1
X-Mimecast-MFC-AGG-ID: QPn7EnwMO22_A9ROnvKDRA_1757676880
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45de13167aaso17418195e9.1
        for <linux-s390@vger.kernel.org>; Fri, 12 Sep 2025 04:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757676880; x=1758281680;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZWd+C+6xlO7ZNnElus07Td372OLIDupg0E/fPHS2G6s=;
        b=MW4lwbg4pjDuJo8TdgBg9RVLrDz/0TmgIdHjJiQfCdTZd/CkmJt2u4fvQmkeqBZzJW
         cD6x60YMeSYCbW31rR6MB27hgB3y9/zvWpLeQZzBom4UzA+ic7nhcBxl2Lls05wFowx7
         JHWR6uObRWcnMsGT5dOPZt+ZJY2S0FmIvc+AzuZ6E4DgwswZ0W9w08HpeKpYnopxjv/Q
         CEgI1alL3b5IhnBqBq/Q+JvqqaRt0D1syXTNI0eSb0NLuQl8sdh+QDkpLVqHGntvZz+n
         zIvF+O0m2v/CjYAKbmnhGIS60GpCPiTFfD0gh9eBQnlpjaTxbGckjxoUscj05AADtxgZ
         o+aA==
X-Forwarded-Encrypted: i=1; AJvYcCVJGBniq/9f2GIRdQCnfTqh86w1/J69v+saYy9HDG0VXZYtPswSRRV5XFTZk9DYC3wiuLhiATSy+q9+@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0W1w9+7tj7cWyQJMNLMPCoTAxdU/Mc6IHIPpjbQxl82xFnIM/
	S8lZAAikaA4dN8JLxoTRk78UaeZtbhKKaEurYq+hLCVoJ562LstVnVw9fhnVkMeFeTdXv9VwGnO
	3L1g5uOCxUubSo2in9sZ1s8LnlglbOUk2zfw18YB80Bq6i3iiUlI0Bodadz+PUsM=
X-Gm-Gg: ASbGncuddtfVq8UjLmYaFSuQPWLGvL9taKKqfwsDu75RNI1ad4R1PrqbdidEM7dT9g4
	orxcvIlXwhVkOTL4tl8As4sIInrx1A1kpGkGX2W4EC9025aDIVcdbjEWqS1mX/plie3FyIuxMMd
	RRhrL3Lh6KahwcyH/RYEwU4W7AuiyjHTL1n2PXGIaOFqwTIP/HO1GsGPDlRIkmfR2eu3WXh41Sc
	adp5JLvFAkkDtIW5abSH5OdZBqJIYRlQGhYc3oNCxGhDtWO34Xv10/PRMlBLRBOq4hbtwUw3V9+
	14rcHX0jNZ3EqGw4EYmvH3IYHCxCKGgazcYTftx9GNeCgojwJOvh56R0mqP/WzikChSnrQB9wMv
	VYmwFoi6V2ciyRREpnDHq0nlhL4zxSmgl7kfRq3k8nktKQGjmdSPitSjflrC90t4z8RI=
X-Received: by 2002:a05:600c:3b85:b0:45d:e285:c4ec with SMTP id 5b1f17b1804b1-45f216696c8mr21980495e9.4.1757676880110;
        Fri, 12 Sep 2025 04:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBCLdYjQPkVnjO0W8XKaGSgjZLsccprLNd6W9/Xe0KR1we4p5qR7REUfvO0pBQsst9YNwS0w==
X-Received: by 2002:a05:600c:3b85:b0:45d:e285:c4ec with SMTP id 5b1f17b1804b1-45f216696c8mr21980295e9.4.1757676879669;
        Fri, 12 Sep 2025 04:34:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607ccf9esm6158472f8f.40.2025.09.12.04.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 04:34:39 -0700 (PDT)
Message-ID: <d7a03a2b-d950-4645-80f2-63830bd84f76@redhat.com>
Date: Fri, 12 Sep 2025 13:34:37 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: next-20250912: riscv: s390: mm/kasan/shadow.c
 'kasan_populate_vmalloc_pte' pgtable.h:247:41: error: statement with no
 effect [-Werror=unused-value]
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 kasan-dev <kasan-dev@googlegroups.com>, linux-mm <linux-mm@kvack.org>,
 open list <linux-kernel@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>, linux-s390@vger.kernel.org,
 lkft-triage@lists.linaro.org, Linux Regressions
 <regressions@lists.linux.dev>, Andrew Morton <akpm@linuxfoundation.org>
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Anders Roxell <anders.roxell@linaro.org>,
 Ben Copeland <benjamin.copeland@linaro.org>
References: <CA+G9fYvQekqNdZpOeibBf0DZNjqR+ZGHRw1yHq6uh0OROZ9sRw@mail.gmail.com>
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
In-Reply-To: <CA+G9fYvQekqNdZpOeibBf0DZNjqR+ZGHRw1yHq6uh0OROZ9sRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 13:32, Naresh Kamboju wrote:
> The following build warnings / errors noticed on the riscv and s390
> with allyesconfig build on the Linux next-20250912 tag.
> 
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
> 
> Build regression: next-20250912 mm/kasan/shadow.c
> 'kasan_populate_vmalloc_pte' pgtable.h error statement with no effect
> [-Werror=unused-value]
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> $ git log --oneline next-20250911..next-20250912 --  mm/kasan/shadow.c
>    aed53ec0b797a mm: introduce local state for lazy_mmu sections
>    307f2dc9b308e kasan: introduce ARCH_DEFER_KASAN and unify static key
> across modes
> 
> ## Test log
> In file included from include/linux/kasan.h:37,
>                   from mm/kasan/shadow.c:14:
> mm/kasan/shadow.c: In function 'kasan_populate_vmalloc_pte':
> include/linux/pgtable.h:247:41: error: statement with no effect
> [-Werror=unused-value]
>    247 | #define arch_enter_lazy_mmu_mode()      (LAZY_MMU_DEFAULT)
>        |                                         ^
> mm/kasan/shadow.c:322:9: note: in expansion of macro 'arch_enter_lazy_mmu_mode'
>    322 |         arch_enter_lazy_mmu_mode();
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~
> mm/kasan/shadow.c: In function 'kasan_depopulate_vmalloc_pte':
> include/linux/pgtable.h:247:41: error: statement with no effect
> [-Werror=unused-value]
>    247 | #define arch_enter_lazy_mmu_mode()      (LAZY_MMU_DEFAULT)
>        |                                         ^
> mm/kasan/shadow.c:497:9: note: in expansion of macro 'arch_enter_lazy_mmu_mode'
>    497 |         arch_enter_lazy_mmu_mode();
>        |         ^~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 


I'm afraid these changes landed in -mm-unstable a bit too early.


-- 
Cheers

David / dhildenb

