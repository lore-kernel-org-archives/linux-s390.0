Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7B379949
	for <linux-s390@vger.kernel.org>; Wed,  7 Aug 2024 15:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723044237; cv=none; b=cfgnrZDuRzXGD0pRFFub+L26WY9O14FSavWdAya10+EtSnxRD/X+Ucanj/Ysce3gOjukVFyWxqwfiV/HFcSxB4f+7yzHda0VVe0VViDXPUB9DlZ1H9QxL3upKFbsx3c+nimZa+xG6t4Fll4dMjaHUlG3/huNbgpkLtHmB48nM+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723044237; c=relaxed/simple;
	bh=N3TqnWDEW9ST+nOuxREQVCu2Ne8ray+kVdB5BRj3zMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XUffUJMBsAeuSCpMzTtAzFiqjQdsURMXDOsqaOB+nZTn5h4YTv1MLZgaiz8tJfvQWTQ2PS1imK8FCkgjhPzcjA3LW8Nz2PBI6dk8/TMMSRnt9QCgQRwUJ9yID+bLCvUCkm+FUh91odTOmlED4Idr063tkJR86mxdi99ZyuQLVb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqSCu5oo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqSCu5oo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723044235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=aAgxFInvvWwKV0z4+0KCeJqRg0kMvcuUocrtSkGNRkQ=;
	b=FqSCu5oo/WGW48ky7tsrWZP7mNDVgevkW3zRuqkDJqOnH9DK3q/WdaqkZlWzd6efmcmJ+l
	VS76ennw1zgQu9/MtB0gXVVj7aLQ1pvyNX2WhHNUQkHo6sxy2ztIAjGOU6unw6QFjDLnHY
	dZ4oeo6XB+RORrvBuTEFDnj2y1Q5v+0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-LL1mYoIvO7ui8DrRElOHlQ-1; Wed, 07 Aug 2024 11:23:54 -0400
X-MC-Unique: LL1mYoIvO7ui8DrRElOHlQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4281310bf7aso13386305e9.1
        for <linux-s390@vger.kernel.org>; Wed, 07 Aug 2024 08:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723044232; x=1723649032;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aAgxFInvvWwKV0z4+0KCeJqRg0kMvcuUocrtSkGNRkQ=;
        b=TEuVdjeicxavNHg4X55Cfx1qXOE6njTlEUMND1j5R9C8vlErF88iB7xCJxuXcFFq6k
         /rYzKg/jjFW3dTPk6GL7aUybC8jZYxcSaQYX+l2oN/gEreXtEOftBB7YDjtLzN1p7n/u
         Jgl+eFXpkYoSDZE8B5BxmY4iI4V+nxUnSnPgC2d+EHVQRSgXRpSW/KLqBRnY+jz9/VQY
         bfipnV2M8/O4IJz4spjiygQPyfk9htUwVLjAWkc1ax4IJhTn4IyEwbk25L4XN/tjLPdI
         6QPTbCnzJOXzg2SmOo3h7qSOEdGsfpj7brZUCXTav93fkJFKymBUHu2sI2cfiyU2rUhU
         pPUA==
X-Forwarded-Encrypted: i=1; AJvYcCUQyuadYKzlz/oVrrWSuytYmZNu8WxSLdp+LEC+fqQTeoDDQfDXK3iqRY5mCMTYONYROAMDAnx4N2ks3MwvrBQZDcpEsXR4TZ2qiQ==
X-Gm-Message-State: AOJu0YyJ413nAggfWI+A51fxlpQyQALu+Yi4hc/AjGwsJtASHoC8SGjH
	rkGHhB3luh+dOPcbPPT1W5BWM9lnjLgJTcBiDWZDdPWAge9KUliuzDRuHSibUq7+oIt9Cj40RJR
	TxW3dpjxyEEMW5aIL0SGGxXauT6oqfB0ndASeCigGDYg8+yLdUeIxOhkGe6M=
X-Received: by 2002:a05:600c:4fc9:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-428e6b08fc5mr123410895e9.13.1723044231708;
        Wed, 07 Aug 2024 08:23:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEa1u7xsFpjJO/UW4dKCxZ81wLwqoTylnMlnIcAzev3Z83n1ZIinArOgcYN+yAGW9Rj8jfltw==
X-Received: by 2002:a05:600c:4fc9:b0:426:6f27:379a with SMTP id 5b1f17b1804b1-428e6b08fc5mr123410535e9.13.1723044231149;
        Wed, 07 Aug 2024 08:23:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1a00:df86:93fe:6505:d096? (p200300cbc7081a00df8693fe6505d096.dip0.t-ipconnect.de. [2003:cb:c708:1a00:df86:93fe:6505:d096])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42905971ad7sm35137405e9.17.2024.08.07.08.23.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 08:23:50 -0700 (PDT)
Message-ID: <936f8adf-a8a5-45eb-b5a3-297773918f7c@redhat.com>
Date: Wed, 7 Aug 2024 17:23:48 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: keep nid around during hot-remove
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: agordeev@linux.ibm.com, akpm@linux-foundation.org,
 alexghiti@rivosinc.com, aou@eecs.berkeley.edu, ardb@kernel.org,
 arnd@arndb.de, bhe@redhat.com, bjorn@rivosinc.com,
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
 <e780e9af-e23d-44ff-ae0f-a8f4ee098a1c@redhat.com>
 <CA+CK2bBuDu-3XeeAsy4zggOrxTrp84bcZp9p6mQipzc3NqpcSg@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CA+CK2bBuDu-3XeeAsy4zggOrxTrp84bcZp9p6mQipzc3NqpcSg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.08.24 16:40, Pasha Tatashin wrote:
> On Wed, Aug 7, 2024 at 7:50 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 07.08.24 13:32, David Hildenbrand wrote:
>>> On 07.08.24 00:14, Pasha Tatashin wrote:
>>>> nid is needed during memory hot-remove in order to account the
>>>> information about the memmap overhead that is being removed.
>>>>
>>>> In addition, we cannot use page_pgdat(pfn_to_page(pfn)) during
>>>> hotremove after remove_pfn_range_from_zone().
>>>>
>>>> We also cannot determine nid from walking through memblocks after
>>>> remove_memory_block_devices() is called.
>>>>
>>>> Therefore, pass nid down from the beginning of hotremove to where
>>>> it is used for the accounting purposes.
>>>
>>> I was happy to finally remove that nid parameter for good in:
>>>
>>> commit 65a2aa5f482ed0c1b5afb9e6b0b9e0b16bb8b616
>>> Author: David Hildenbrand <david@redhat.com>
>>> Date:   Tue Sep 7 19:55:04 2021 -0700
>>>
>>>        mm/memory_hotplug: remove nid parameter from arch_remove_memory()
>>>
>>> To ask the real question: Do we really need this counter per-nid at all?
>>>
>>> Seems to over-complicate things.
>>
>> Case in point: I think the handling is wrong?
>>
>> Just because some memory belongs to a nid doesn't mean that the vmemmap
>> was allocated from that nid?
> 
> I believe when we hot-add we use nid for the memory that is being
> added to account vmemmap, and when we do hot-remove we also use nid of
> the memory that is being removed. But, you are correct, this does not
> guarantee that the actual vmemmap memory is being allocated or removed
> from the given nid.

Right. For boot memory that we might want to unplug later it might be 
different. I recall that with "movable_node", we might end up allocating 
the vmemmap from remote nodes, such that all memory of a node stays 
movable. That's why __earlyonly_bootmem_alloc() ends up calling 
memblock_alloc_try_nid_raw(), to fallback to other nodes if required.

> 
>> Wouldn't we want to look at the actual nid the vmemmap page belongs to
>> that we are removing?
> 
> I am now looking into converting this counter to be system wide, i.e.
> vm_event, it is all done under hotplug lock, so there is no
> contention.

That would be easiest, assuming per-node information is not strictly 
required for now.

-- 
Cheers,

David / dhildenb

