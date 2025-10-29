Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4159B19F12D
	for <linux-s390@vger.kernel.org>; Wed, 29 Oct 2025 12:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761740154; cv=none; b=d07hcop5zKJcLrKKDirQdMifF7q8ffqFLoDmuFObPPb3G/eQSZ0ADmG8MmZPvZBOwkRhCcwpufBN8N+lub+wRDblDyLCyUiCAiEtxvx5UxSyDFiTVOZenb0C7+iT8enfrD0DC46DUJDUG51OWrmyxibSlSD6wvhSCJuQfV5rm8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761740154; c=relaxed/simple;
	bh=x9vrTfvNIqZkKoJz89lC/ZZ2ItECz4sP6HThMv4kSak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DS5uJa3hqv09RrdKvh6uvVaqcc6fjZJrBjCKNXLqHzeocJTRN2LVOJDNL3N2MO0FR1Dk5obO7hM85K9+Pk/XiZ3iGyx+ElP3Ucwp4WITqvPVYx6r400Se5aoR59UwmHqDh5EBCYa+Jyv2AuDSNlXWrVT0XhF0q/Vwso89THpPmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CHJ/EKKU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHJ/EKKU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761740151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=A2LLGcK+hTB7diSRVPmDLBi0AA16yQBkapdsK4RLPno=;
	b=CHJ/EKKUOueG/YiZzP1oxYa0CWFfbBqBZJVKEEqf6poIeknqzwa0rEGZuszf7g6I5Y1ct2
	ebXFOHj5xRJsPCRCBjmZlriNbE8seBOTR1seWFuzU/ar5S8UXaj/LtflrHCHI1nh1zKyF8
	hLzkNAhSynR8RPwsEqsZlNU1QclxgGY=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-256-nIytOtOYNqynP0nRJBMU1A-1; Wed, 29 Oct 2025 08:15:49 -0400
X-MC-Unique: nIytOtOYNqynP0nRJBMU1A-1
X-Mimecast-MFC-AGG-ID: nIytOtOYNqynP0nRJBMU1A_1761740149
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8911e5befa9so189339385a.1
        for <linux-s390@vger.kernel.org>; Wed, 29 Oct 2025 05:15:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761740149; x=1762344949;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2LLGcK+hTB7diSRVPmDLBi0AA16yQBkapdsK4RLPno=;
        b=EPUG34hupom7Unc4KaMT+XdO04pQEAzY5NxmFhao9CSrd48uyh6hpj8CWfKcnc1Cdr
         quosD91Y6FJkX/FIZSoovULTDFu/jhImO6UtMs37lxD1FUNOaoDhdtNSTXts7eT3sAFW
         PYBUMAPKOcRatJMYFoylCFNLQsOtUEorKMVv6uNlo4Xwhh6K8utTjlk5YXT6IMMh7S7p
         ICynTSzXV5CEjaE4W8rBqwxFJgLgEKfr+m14U5gnNIq6f7gkkXGBYeLfQzTM4YFolo1Y
         4VkNnAXhxGWxq9/03qWAvtVvOVP8Adxudi0pby51Kuh5uCwT5JiDCGPHXjb4ShGJ+zr+
         xavw==
X-Forwarded-Encrypted: i=1; AJvYcCXp+gc1k6lC6JsauOT40UPws8o2KCSrZbaCL4Rrlonkaqa73w+nVxzKCi1K9ImwtSnTBcwJZLQZY7lh@vger.kernel.org
X-Gm-Message-State: AOJu0YwHPKdO7lYsv0FDKaPdtLJuRxHH7yfjafr2Y8SbLGtX7SzmAAvh
	4keNMz80lmuQoIQ6XQVKdJqLCFY1ITkZU60QS1D6LAFwmB4iF26JQyjA1ygyWkJ112vIfpjkMnu
	hchU/hlKD2O56bLB0UGmPhZXOgSzJ1sUkzJ+W9Dr3RzmQFp0Qu3TL4cT1zk7VAYo=
X-Gm-Gg: ASbGncuytIrOk5MW8jHzKkWfcm7EKT0qs/ULDE5hHrYyeOwqrPAUKiPUWmGB7fKO8DR
	4t73hFnrgE66mIzl8+NiJ1bFu8TDJe1dVyNS9/9RBQYHl5kN8VK/LgzhuYB595t9PDg9MkxuaAo
	N6OjCC/gfeiIejTeqeUhepMI94SrFpUZ+wjGCezOpP6u3XpHjBnvLGkoylwdd6/SzbOhhiJnUNy
	j6qmWbPQh3xXiibNtKiUv8FO+CyH6MWANm1V/+UhlBK+f6CfIWj8VPjfPmBQzZBiFwg2ykuw8kn
	Zrb1TmQpwh+8Gc9ymxMYJQHGC6N/EaG/s7FnO0lKObJ/dnMKmtfY9KBtqAK68RtiruoLaCCQJfL
	B2CLDKQAw8A1lVTTroNHjdg==
X-Received: by 2002:a05:620a:4629:b0:892:6e93:e029 with SMTP id af79cd13be357-8a7276580a1mr862370185a.30.1761740149086;
        Wed, 29 Oct 2025 05:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyumHWc8S9UaG4uGmnoGLKBMBA0S/1xJaGK1g8R1NYRMtc9AQHCDzfiJJ6iyUcmiHht4va/g==
X-Received: by 2002:a05:620a:4629:b0:892:6e93:e029 with SMTP id af79cd13be357-8a7276580a1mr862364885a.30.1761740148609;
        Wed, 29 Oct 2025 05:15:48 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8a8025fc8cesm328725385a.23.2025.10.29.05.15.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 05:15:48 -0700 (PDT)
Message-ID: <9a8254b9-92f8-4530-88e8-fca3b7465908@redhat.com>
Date: Wed, 29 Oct 2025 13:15:44 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] s390: fix HugeTLB vmemmap optimization crash
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Luiz Capitulino <luizcap@redhat.com>, borntraeger@linux.ibm.com,
 joao.m.martins@oracle.com, mike.kravetz@oracle.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, gor@linux.ibm.com,
 gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com, osalvador@suse.de,
 akpm@linux-foundation.org, aneesh.kumar@kernel.org
References: <20251028211533.47694-1-luizcap@redhat.com>
 <6bbdf4ce-10e3-429b-89fc-ef000f118fec@redhat.com>
 <20251029104457.8393B96-hca@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251029104457.8393B96-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.10.25 11:44, Heiko Carstens wrote:
> On Wed, Oct 29, 2025 at 10:57:15AM +0100, David Hildenbrand wrote:
>> On 28.10.25 22:15, Luiz Capitulino wrote:
>>> A reproducible crash occurs when enabling HugeTLB vmemmap optimization (HVO)
>>> on s390. The crash and the proposed fix were worked on an s390 KVM guest
>>> running on an older hypervisor, as I don't have access to an LPAR. However,
>>> the same issue should occur on bare-metal.
> ...
>>> This commit fixes this by implementing flush_tlb_all() on s390 as an
>>> alias to __tlb_flush_global(). This should cause a flush on all TLB
>>> entries on all CPUs as expected by the flush_tlb_all() semantics.
>>>
>>> Fixes: f13b83fdd996 ("hugetlb: batch TLB flushes when freeing vmemmap")
>>> Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
>>> ---
>>
>> Nice finding!
>>
>> Makes me wonder whether the default flush_tlb_all() should actually map to a
>> BUILD_BUG(), such that we don't silently not-flush on archs that don't
>> implement it.
> 
> Which default flush_tlb_all()? :)

What I meant is: all such functions that an architecture doesn't expect 
to be called because they are effectively unimplemented.

Taking a look at flush_tlb_all(), there is really only a dummy 
implementation on s390x and on riscv without MMU.

So yeah, there is no "default" fallback one :)

BTW, I'm staring at s390x's flush_tlb() function and wonder why that one 
is defined. I'm sure there is a good reason ;)

> 
> There was a no-op implementation for s390, and besides drivers/xen/balloon.c
> there is only mm/hugetlb_vmemmap.c in common code which makes use of this. To
> me it looks like both call sites only need to flush TLB entries of the kernel
> address space. So I'd rather prefer if flush_tlb_all() would die instead.

I'd assume that we only modify the kernel virtual address space, so I agree.

> 
> But I'm also wondering about the correctness of the whole thing even with this
> patch. If I'm not mistaken then vmemmap_split_pmd() changes an active pmd
> entry of the kernel mapping. That is: an active leaf entry (aka large page) is
> changed to an active entry pointing to a page table.

That's my understanding as well.

> 
> Changing active entries without the detour over an invalid entry or using
> proper instructions like crdte or cspg is not allowed on s390. This was solved
> for other parts that change active entries of the kernel mapping in an
> architecture compliant way for s390 (see arch/s390/mm/pageattr.c).

Good point. I recall ARM64 has similar break-before-make requirements 
because they cannot tolerate two different TLB entries (small vs. large) 
for the same virtual address.

And if I rememebr correctly, that's the reason why arm64 does not enable 
ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP just yet.

-- 
Cheers

David / dhildenb

