Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4235817F376
	for <linux-s390@vger.kernel.org>; Wed, 10 Apr 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768611; cv=none; b=E9UjEIe5tcuQfzCVK9brSF49JkPkIaytb24Sp0vCQ9erK+9rHgTOw56wXCKrdhyNcBUl3hC1edc/s65S5sy+YLARK6HdifwkN+idAjaiEnJ47yzxQgzHFY4mGPoNYQ11qDMNfO/XX2p7lOo9yXijNoRH2CQeMIl+48SNTjofXEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768611; c=relaxed/simple;
	bh=Ut2vDTMT9EIvi24r8IYFRlj/fja7TOqDJcCkxoAXwd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E1W+RlqHiB+frcUmjm7jdi1+s3OqkyqFBAIztMYVCGX45VsFa5Kk/HFpo72Zo/YUG6VTIf3+on7VtR4/XdXODdskhe5bL7++txOhhzy4iJBhEd7Pq2/okXFQL91/aJm13m9labv24W/VMXn/He08kNEiLhQHjun148oLtHuyEbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4oBZCGy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4oBZCGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712768608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ww/qVYe/6Kgkkz20yNAhsKujT0jjSMMyh5TSWJi9fHs=;
	b=I4oBZCGywDv9vbcNC7fNLVaMx3h3ZSNc9kHtR1WwPakAyT2Ruo0pYvgD/WsS+CgL7rGJO6
	e6ukOtZfKmyA4Wcx5rcF4/kaMsqSj7uU1XwZnuNtUHf7Jj2zI4eZFvdnpD4N1XTBUI3lKP
	q+ivoxG0AzQ/d+dd6b8ZSs98bYi/yqY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-xBxjS5dqODy2OGq0cphpWw-1; Wed, 10 Apr 2024 13:03:24 -0400
X-MC-Unique: xBxjS5dqODy2OGq0cphpWw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-515d139f285so4768753e87.1
        for <linux-s390@vger.kernel.org>; Wed, 10 Apr 2024 10:03:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712768603; x=1713373403;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ww/qVYe/6Kgkkz20yNAhsKujT0jjSMMyh5TSWJi9fHs=;
        b=fPN3LQ+eta2Jbw/bajZKsJxEVO2od9N0oSKrQoGYGGXuRHUwsSURrplcPWfd+K7YE9
         9L1IjMEzFlIqfVPprl+owQabvm3blxpqv/L3H8S/3X0DjQfniKDCe7Bt2OMhiPwMJOYS
         Y/HhQQQzXT1QAKvMLFS2iYvA9Lm5FW07ZyCMjcg3R38YwE2R5ECZKD5Xu33omF9rKYqz
         +tYMPsCCMOQpEcSJCwvoazEoyShiKk5I+YGYvpC68TyjZugtLxFM7mLxc/uxtqkllsBx
         CKVizBqYvRbmYSlNXHSlBG/4UrYh/kdvJi8xmsEpMjBKCy4rGRsYo44T84ekeBcmdZfI
         1PAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8BJplbHMHJGBqOTIINN1uybF9GuOYqeF0hZNUizjTEiZiYaXc1PiCqYmNGmlXABXlBtbA81HvyzhKuEAiPlLrpYonNroQZnDc8g==
X-Gm-Message-State: AOJu0YxNkNfMjcOoUTw4uid5Ty2kStLqajha6ozpjIBYEyusQpuIYVY+
	DTQXAChjy9EH8syIEypeMgtHvw0P7Doec6Hk9JgSuV5xgDSn4IKYNXDtl1y17NKrHHMBCfNdjNP
	R7M7Mk/KwZIm5rD7/t9zeqe6tLh/vo9WYeyn59K64m5s0Y87E9Am9015E1+Q=
X-Received: by 2002:a19:6445:0:b0:516:a04f:d545 with SMTP id b5-20020a196445000000b00516a04fd545mr2011503lfj.27.1712768603493;
        Wed, 10 Apr 2024 10:03:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHROGvC1FhJyfwe5FZdnQ4uQ2M5Zb51/NdYWD3yUQzJQhcyjOH6zWvpivZCOT9IMQfgvkODHw==
X-Received: by 2002:a19:6445:0:b0:516:a04f:d545 with SMTP id b5-20020a196445000000b00516a04fd545mr2011473lfj.27.1712768603004;
        Wed, 10 Apr 2024 10:03:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c712:fa00:38eb:93ad:be38:d469? (p200300cbc712fa0038eb93adbe38d469.dip0.t-ipconnect.de. [2003:cb:c712:fa00:38eb:93ad:be38:d469])
        by smtp.gmail.com with ESMTPSA id j9-20020a05600c190900b004166b960469sm2858722wmq.38.2024.04.10.10.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:03:22 -0700 (PDT)
Message-ID: <79051196-601a-406c-9572-033173848bfb@redhat.com>
Date: Wed, 10 Apr 2024 19:03:21 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/shmem: Inline shmem_is_huge() for disabled transparent
 hugepages
To: Peter Xu <peterx@redhat.com>
Cc: Sumanth Korikkar <sumanthk@linux.ibm.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, hughd@google.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, iii@linux.ibm.com, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
References: <20240409155407.2322714-1-sumanthk@linux.ibm.com>
 <594dbec7-b560-44e5-a684-93dcb8ba85df@redhat.com>
 <Zhavr9NxvayDhU9X@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <29b613a8-f0d5-4f5f-adbc-d64ed8908044@redhat.com>
 <Zha5V0QxODZR4qOW@li-2b55cdcc-350b-11b2-a85c-a78bff51fc11.ibm.com>
 <1ce2fe6c-b56a-4582-a5d8-babc8fccef52@redhat.com> <Zha_auw6yBx0YRWQ@x1n>
 <61a3bd6b-a352-4e02-8357-81ac7b9f2848@redhat.com> <ZhbDoxxFAe0QQYz_@x1n>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZhbDoxxFAe0QQYz_@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.04.24 18:51, Peter Xu wrote:
> On Wed, Apr 10, 2024 at 06:40:55PM +0200, David Hildenbrand wrote:
>> On 10.04.24 18:33, Peter Xu wrote:
>>> On Wed, Apr 10, 2024 at 06:12:34PM +0200, David Hildenbrand wrote:
>>>> On 10.04.24 18:07, Sumanth Korikkar wrote:
>>>>> On Wed, Apr 10, 2024 at 05:51:28PM +0200, David Hildenbrand wrote:
>>>>>> On 10.04.24 17:26, Sumanth Korikkar wrote:
>>>>>>> On Wed, Apr 10, 2024 at 02:34:35PM +0200, David Hildenbrand wrote:
>>>>>>>> On 09.04.24 17:54, Sumanth Korikkar wrote:
>>>>>>>>> In order to  minimize code size (CONFIG_CC_OPTIMIZE_FOR_SIZE=y),
>>>>>>>>> compiler might choose to make a regular function call (out-of-line) for
>>>>>>>>> shmem_is_huge() instead of inlining it. When transparent hugepages are
>>>>>>>>> disabled (CONFIG_TRANSPARENT_HUGEPAGE=n), it can cause compilation
>>>>>>>>> error.
>>>>>>>>>
>>>>>>>>> mm/shmem.c: In function ‘shmem_getattr’:
>>>>>>>>> ./include/linux/huge_mm.h:383:27: note: in expansion of macro ‘BUILD_BUG’
>>>>>>>>>        383 | #define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })
>>>>>>>>>            |                           ^~~~~~~~~
>>>>>>>>> mm/shmem.c:1148:33: note: in expansion of macro ‘HPAGE_PMD_SIZE’
>>>>>>>>>       1148 |                 stat->blksize = HPAGE_PMD_SIZE;
>>>>>>>>>
>>>>>>>>> To prevent the possible error, always inline shmem_is_huge() when
>>>>>>>>> transparent hugepages are disabled.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Do you know which commit introduced that?
>>>>>>> Hi David,
>>>>>>>
>>>>>>> Currently with CONFIG_CC_OPTIMIZE_FOR_SIZE=y and expirementing with
>>>>>>> -fPIC kernel compiler option, I could see this error on s390.
>>>>>>
>>>>>> Got it. I assume on Linus' tree, not mm/unstable?
>>>>>
>>>>> It's not yet upstream.
>>>>>>
>>>>>>>
>>>>>>> However, default kernel compiler options doesnt end up with the above
>>>>>>> pattern right now.
>>>>>>
>>>>>> Okay, just asking if this is related to recent HPAGE_PMD_SIZE changes:
>>>>>>
>>>>>> commit c1a1e497a3d5711dbf8fa6d7432d6b83ec18c26f
>>>>>> Author: Peter Xu <peterx@redhat.com>
>>>>>> Date:   Wed Mar 27 11:23:22 2024 -0400
>>>>>>
>>>>>>        mm: make HPAGE_PXD_* macros even if !THP
>>>>>>
>>>>>> Which is still in mm-unstable and not upstream.
>>>>>
>>>>> Not related to this commit. I tried on master branch.
>>>>
>>>> Thanks! Can you try with Peters patch? (ccing Peter)
>>>>
>>>> If I am not wrong, that should also resolve the issue you are seeing.
>>>
>>> David,
>>>
>>> Do you mean this one?
>>>
>>> https://lore.kernel.org/all/20240403013249.1418299-4-peterx@redhat.com/
>>>
>>
>> No, I meant:
>>
>> https://lore.kernel.org/all/20240327152332.950956-4-peterx@redhat.com/
>>
>> which removes the "#define HPAGE_PMD_SIZE ({ BUILD_BUG(); 0; })" that we
>> seem to trigger here.
>>
>>
>> ... but it's been a long day, so maybe I'm all wrong :)
> 
> Ah..  So I thought it was one step further. :)
> 
> Then that shouldn't be the case; it didn't remove it but defined properly
> with HPAGE_PMD_SHIFT:
> 
> +#define HPAGE_PMD_SIZE	((1UL) << HPAGE_PMD_SHIFT)
> 
> Now we even have that properly defined for HUGETLB_PAGE, while prior to
> that we should hit this issue easier (even with !THP+HUGETLB_PAGE).

Ah, now I spot

#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })

:) sorry for the noise!

To the original patch here

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

