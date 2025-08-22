Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F35B2E2F1F
	for <linux-s390@vger.kernel.org>; Fri, 22 Aug 2025 06:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755843530; cv=none; b=ftufO3B6s2pekTZAMiZ8f0+bSUg6wryJcoRiMdZ5EX6S2g0OWhB/1n7HJvwcXplCQgBFmCVmULrmvMP0yads3axYvTVHdq/qtlMlHdIN/aY0emIR1W6xm/XoffNmk2HrOkxU5MAywEqFyz/DtSXqagD2cW+zGY4Vd7j5Lp5z4Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755843530; c=relaxed/simple;
	bh=Ipdvs+TlyksrM4l/hJDMakLp93JAanz9a9w+7zx003g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMYK0zUxKjcLsXIwJ5bE06V4z1ixw2BV9fHOULQWb2Czq7o0u8k62to4IT4N5F3QzwqO8GScfiyUTpmfysO+2IX0ooB9KAeK+d6zHXSalxe091F8cdLJjjvjh3UgDnfyub0P1aQAzsaBw6cv7MrDVVTxluISabovs58hcklEHJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkzQtCvu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkzQtCvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755843527;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=niXcAgzmbCLTQjKBYxU2ktBBprjtNy5MGdyac9sGLRc=;
	b=OkzQtCvu9K0jp5DStkMTdwMA41eVci/U5ckfSs6Qy3WNZ1I0HE989EckcUIH9KSIF0R/Yh
	baOXVdPAZU9+LBdZ62c3QXJXS1JSk+N5QQY6jXOfFX+gKhIKnV7HNP3lzC3ysQgeGfZQ7c
	GvLABDi6HOkPsA2Ep9awNdNGhYAdnEs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-4SDTaWR0PjekPRNwCdZxhA-1; Fri, 22 Aug 2025 02:18:45 -0400
X-MC-Unique: 4SDTaWR0PjekPRNwCdZxhA-1
X-Mimecast-MFC-AGG-ID: 4SDTaWR0PjekPRNwCdZxhA_1755843524
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45a1b0098c0so10729515e9.0
        for <linux-s390@vger.kernel.org>; Thu, 21 Aug 2025 23:18:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755843524; x=1756448324;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niXcAgzmbCLTQjKBYxU2ktBBprjtNy5MGdyac9sGLRc=;
        b=L084U4Y9Flp2BQEX5tJiwZeQ8DP6/jHSDy7IpUMULPtT6BNnErdfPxxYTsGQcQ9wJN
         sd7bpUEbbXXIsbU3zOnqLkcFGGZ+EIfvy6FITOiTUmLBEf3RI5ACFG1Nc5bqb+ohZljv
         p5cd5gSvNADB0R2ne5XWBUXTwOVql5OR24GIQda1taDfRPWSud3hgrSZA43oReAJev71
         5QtuKyYPap0GHXyvOC3HOuWeLMaQbuT4K1DfJa8kxnFB5x6a5DVfu06FGaRvlRsjDyCi
         kWlIavpDAD5MmapZRBuEDm1YKOR8I29vBhOc37CHB+mw6tIG7Pkur9WKBbh89XuzQ+t3
         dTyw==
X-Forwarded-Encrypted: i=1; AJvYcCWWpCLhOMU0CaxnN+n5K0RPXCrI2KILltDKcrqorFKIx+rbjbQclzyf2UvYECd8f437Nd/YLS9JAIih@vger.kernel.org
X-Gm-Message-State: AOJu0YyP/qGI7p4wnlcavI8YOhRD9QEI8cQIv5FTfNTM8cWtXYH1vNDh
	RE+lVvZauFlgdG4IGSnCH9iHfKjNN9Gdi9gIaUOLX91G4END0QPvP8PffeWezY0AC+qEblnCMPD
	kIpkK4xRMmX5O7dsK0z59Zw0UzGef63ktP5G4SdDzHc9zXjC2MCYaPuvSZzxBj8A=
X-Gm-Gg: ASbGncvdgMCvkK8DAYn5DaI6T8ydEperss6aDijUFbt4M7a+M9uuN9irzPVk7wQM8+S
	61Ci82yGGus872MDpBtYb6/X35oZmTNQmd4r3HYsUBrc1ws/g7+lZVrVmwP/5M7P4EQZuee+V19
	STVdVpJfkFL+aQDEKyMpD8psJp8J63Dx5KGdRlfdbVfmpxBFzxuUC/HgiOPAmO5bGCVrl/3oKIC
	6BcCyfDvnjMA9BJONI7LO2wGq8UaRrrfT7aIdnmM/DLczGo9HtnZgtLndLe6H3bJMV7b1+evzb2
	zuJ7WPfuNE5bfKfilvEDShlTd0qMtFBjZ/ouXLhv4LXX+uegLatCBNmU4GrIqbCoSpHL6A==
X-Received: by 2002:a05:600c:4e8c:b0:456:1ac8:cace with SMTP id 5b1f17b1804b1-45b5179e7e8mr12435775e9.12.1755843523918;
        Thu, 21 Aug 2025 23:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdnIqi4Hq3cqdHCtXLM1BskgbP/iNxi6JCTe3b4/5WxUiRcTB1IoXLbvfQ3J7NKdKWtFg41A==
X-Received: by 2002:a05:600c:4e8c:b0:456:1ac8:cace with SMTP id 5b1f17b1804b1-45b5179e7e8mr12435175e9.12.1755843523431;
        Thu, 21 Aug 2025 23:18:43 -0700 (PDT)
Received: from [192.168.3.141] (p4ff1f25c.dip0.t-ipconnect.de. [79.241.242.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50d62991sm24078285e9.0.2025.08.21.23.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 23:18:42 -0700 (PDT)
Message-ID: <6bff5a45-8e52-4a5d-81cb-63a7331d7d0b@redhat.com>
Date: Fri, 22 Aug 2025 08:18:40 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 24/35] ata: libata-eh: drop nth_page() usage within SG
 entry
To: Damien Le Moal <dlemoal@kernel.org>, linux-kernel@vger.kernel.org
Cc: Niklas Cassel <cassel@kernel.org>, Alexander Potapenko
 <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>,
 kasan-dev@googlegroups.com, kvm@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, netdev@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Tejun Heo <tj@kernel.org>, virtualization@lists.linux.dev,
 Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, x86@kernel.org,
 Zi Yan <ziy@nvidia.com>
References: <20250821200701.1329277-1-david@redhat.com>
 <20250821200701.1329277-25-david@redhat.com>
 <3812ed9e-2a47-4c1c-bd69-f37768e62ad3@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <3812ed9e-2a47-4c1c-bd69-f37768e62ad3@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 03:59, Damien Le Moal wrote:
> On 8/22/25 05:06, David Hildenbrand wrote:
>> It's no longer required to use nth_page() when iterating pages within a
>> single SG entry, so let's drop the nth_page() usage.
>>
>> Cc: Damien Le Moal <dlemoal@kernel.org>
>> Cc: Niklas Cassel <cassel@kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   drivers/ata/libata-sff.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
>> index 7fc407255eb46..9f5d0f9f6d686 100644
>> --- a/drivers/ata/libata-sff.c
>> +++ b/drivers/ata/libata-sff.c
>> @@ -614,7 +614,7 @@ static void ata_pio_sector(struct ata_queued_cmd *qc)
>>   	offset = qc->cursg->offset + qc->cursg_ofs;
>>   
>>   	/* get the current page and offset */
>> -	page = nth_page(page, (offset >> PAGE_SHIFT));
>> +	page += offset / PAGE_SHIFT;
> 
> Shouldn't this be "offset >> PAGE_SHIFT" ?

Thanks for taking a look!

Yeah, I already reverted back to "offset >> PAGE_SHIFT" after Linus 
mentioned in another mail in this thread that ">> PAGE_SHIFT" is 
generally preferred because the compiler cannot optimize as much if 
offset would be a signed variable.

So the next version will have the shift again.

-- 
Cheers

David / dhildenb

