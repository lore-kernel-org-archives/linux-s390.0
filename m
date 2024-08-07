Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14E71E4855
	for <linux-s390@vger.kernel.org>; Wed,  7 Aug 2024 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723031410; cv=none; b=CRZwWyuhe+gJ1CEJSKPg5lwQgFCCIQxSAafH51liwoOupb2fnxdi45mVoUsdGu2u7MRPFHq8dYk779Kw95v0pwqZCauv6anJ27hg0OmlO3WUJ4AK5RlQIglkKjoEv5Hn0rEbG6GAqZ0Un4XgaIEDIDrbxxwNKNxMfhi8H86Uwug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723031410; c=relaxed/simple;
	bh=3w7Q/rI9DUDvG1e2nR8emCsrkrhv1WCZyXyFdQ9rIio=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=c2yP1l6qx4uBr7hQhFs28s2cP/G31p2bbTz2gv156Wy4s9s78mNpYcbh7+xl5J3szd4s3tXovFyZ2XUoSObGJiR2VPYNhdbNGrHsNIZ5np48beIf7DDTSwfw4Sqgca9Dh+DhHNvr4Uwaq7O7LK4oRAU7JuNQ0cnUfr1gnxYE3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dxc9ZviL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dxc9ZviL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723031407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kHsQOsrdR14A6Xed8ME9CfHFPFoPxd9qtlZZMGa+ivk=;
	b=Dxc9ZviLksMVLXj5VPIPbkCqE6Ba1oU5MDsrZPxbC5VEBp/ouWiuJWYZ8GK+cB/w9CZpkz
	c6wDKCZoUCrNPptwLmKKGBuckDJs7o7ddGJr8f6ckP1GCjEO00pX5yy9qF+Lmk7SiO7G/+
	AUgJbu2nYJaHWu+vxoqS4xmZOROMfv8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-UwldyxtsNyydVBQm_D5JlQ-1; Wed, 07 Aug 2024 07:50:05 -0400
X-MC-Unique: UwldyxtsNyydVBQm_D5JlQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef2ebe1ec4so17895021fa.2
        for <linux-s390@vger.kernel.org>; Wed, 07 Aug 2024 04:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723031404; x=1723636204;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:to:from:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHsQOsrdR14A6Xed8ME9CfHFPFoPxd9qtlZZMGa+ivk=;
        b=FgNKsjmBU4F7EgdywmHAjaRG1xnOvTYwzNPovHxfRXafq6fVxMcnkWMFsESVDEQ91+
         Ba9QWH0cogbKrJ8+awFSxS1aGAdlhnNTfrbgMBSnIotTYl7xEJli6W5CWGoxIIG4u7/P
         9eaEhTH2kKFr18M+jjeXrn2O89qFj3Vu40wFoRbrNH9oIX+927soZ8sduT+kEKUEkwcD
         FIrA8VotPsqUtwtnb+PL4Yo9SChYMoAZRQl/3WfyrFCbZzz5aWJ+vq2bj+n711bAPFf2
         fl+S80514p+XT7+GxcCdR1BLG3mz3GxLmbjHg0sz/LlAUuslsn4ueqqwu2OCT9jL6g9I
         b5Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVCaNTm3lC4DPG3gpvY6FLqRDhg9VJIdQ5oSLKqJ2B7Wb/pt1WJ71WtT2PbYZo12zUF4FjEumSARAAxXzOdeZc5tV9piqNl5KrpJA==
X-Gm-Message-State: AOJu0YzoD+yzsYgWA1yLYrQz9ZCgC9QKgHm//LoAxtkB7dFvJ3YvD7N4
	kPSGyok+KtsvFUPOOlqZnR1JvPjpXjCAOUfgyQpzg3xH89zkugA3nQnbbkYWrCaT9CQjM8/AyTi
	xzKzxWvcO7GZrjGYOkTGvDpqXMpgKrbuH7UAboKT3nQQSvcGAkMasyDamMds=
X-Received: by 2002:a2e:9e97:0:b0:2f0:25dc:1886 with SMTP id 38308e7fff4ca-2f15aa8348bmr112003981fa.10.1723031404108;
        Wed, 07 Aug 2024 04:50:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWb3FF4xJe7fGHSjGXrwD26crNAvQoaDWoI/JHuX05IhJvtOyXbYnIXdUTK6IRAFf3q6L56A==
X-Received: by 2002:a2e:9e97:0:b0:2f0:25dc:1886 with SMTP id 38308e7fff4ca-2f15aa8348bmr112003491fa.10.1723031403469;
        Wed, 07 Aug 2024 04:50:03 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1a00:df86:93fe:6505:d096? (p200300cbc7081a00df8693fe6505d096.dip0.t-ipconnect.de. [2003:cb:c708:1a00:df86:93fe:6505:d096])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290580c720sm25918655e9.41.2024.08.07.04.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 04:50:03 -0700 (PDT)
Message-ID: <e780e9af-e23d-44ff-ae0f-a8f4ee098a1c@redhat.com>
Date: Wed, 7 Aug 2024 13:50:00 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: keep nid around during hot-remove
From: David Hildenbrand <david@redhat.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>, agordeev@linux.ibm.com,
 akpm@linux-foundation.org, alexghiti@rivosinc.com, aou@eecs.berkeley.edu,
 ardb@kernel.org, arnd@arndb.de, bhe@redhat.com, bjorn@rivosinc.com,
 borntraeger@linux.ibm.com, bp@alien8.de, catalin.marinas@arm.com,
 chenhuacai@kernel.org, chenjiahao16@huawei.com, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, dawei.li@shingroup.cn,
 gerald.schaefer@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com,
 hpa@zytor.com, kent.overstreet@linux.dev, kernel@xen0n.name,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 loongarch@lists.linux.dev, luto@kernel.org, maobibo@loongson.cn,
 mark.rutland@arm.com, mcgrof@kernel.org, mingo@redhat.com,
 mpe@ellerman.id.au, muchun.song@linux.dev, namcao@linutronix.de,
 naveen@kernel.org, npiggin@gmail.com, osalvador@suse.de, palmer@dabbelt.com,
 paul.walmsley@sifive.com, peterz@infradead.org, philmd@linaro.org,
 rdunlap@infradead.org, rientjes@google.com, rppt@kernel.org,
 ryan.roberts@arm.com, souravpanda@google.com, svens@linux.ibm.com,
 tglx@linutronix.de, tzimmermann@suse.de, will@kernel.org, x86@kernel.org
References: <20240806221454.1971755-1-pasha.tatashin@soleen.com>
 <20240806221454.1971755-2-pasha.tatashin@soleen.com>
 <345ba221-e094-47e8-9481-562faf4acd85@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <345ba221-e094-47e8-9481-562faf4acd85@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.24 13:32, David Hildenbrand wrote:
> On 07.08.24 00:14, Pasha Tatashin wrote:
>> nid is needed during memory hot-remove in order to account the
>> information about the memmap overhead that is being removed.
>>
>> In addition, we cannot use page_pgdat(pfn_to_page(pfn)) during
>> hotremove after remove_pfn_range_from_zone().
>>
>> We also cannot determine nid from walking through memblocks after
>> remove_memory_block_devices() is called.
>>
>> Therefore, pass nid down from the beginning of hotremove to where
>> it is used for the accounting purposes.
> 
> I was happy to finally remove that nid parameter for good in:
> 
> commit 65a2aa5f482ed0c1b5afb9e6b0b9e0b16bb8b616
> Author: David Hildenbrand <david@redhat.com>
> Date:   Tue Sep 7 19:55:04 2021 -0700
> 
>       mm/memory_hotplug: remove nid parameter from arch_remove_memory()
> 
> To ask the real question: Do we really need this counter per-nid at all?
> 
> Seems to over-complicate things.

Case in point: I think the handling is wrong?

Just because some memory belongs to a nid doesn't mean that the vmemmap 
was allocated from that nid?

Wouldn't we want to look at the actual nid the vmemmap page belongs to 
that we are removing?

-- 
Cheers,

David / dhildenb

