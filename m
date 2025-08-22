Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD0A2BE039
	for <linux-s390@vger.kernel.org>; Fri, 22 Aug 2025 18:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886205; cv=none; b=GnX9/gZh6T7y74Wj+8HtFdwlhGDqhQD5rBd645yeHI/+SSjPnpFQksiryG0ItEjicwmhIF4mP24FqPpuXR9plTn0swoHJEKTbAMnSQhrhCkEV84cd/f+u3w7XOeSh636voY9ZzaJ+HDfi2Wt8w3uip9JdHWbpWxZHvcaE+1S7gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886205; c=relaxed/simple;
	bh=zK8pF8aK+jklAJeqG0PrEjqoY+YHkla9jsDYNWkvT68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOsmFZoMRRyxnV4Ot3lybTW+IFCQ7dpZtcPOlbAfXBXcFECUdrsnYWogNTVPllyFusY3oNsZXq14Ve42Ryh3e4etspYPptawB1DBrg4v9YFWWAYNdpwrKKj6BkzVmdrttgPmWFsNJUncBiNpb8fGla7nci8SSHCwg3QNm5Ge5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NIdGcyDJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIdGcyDJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755886200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4Qgw45kgIvklypQIdjW4WKJClwzbVj1vFIwI4+ABCxY=;
	b=NIdGcyDJgCcIFOcCzDrWMG+Isy+eVOFGZlpWnHftHr9DTyZMBLOHWnOft93ylUKPFqFAM5
	+CSHQoTv92HH2FDkPU0dyWHPZ+W/G+TLfNnaNP+Q7+A7kJy/C+6mID4KuHMFwyV3SgQQki
	GQmUhnfwGWTjNMXI9Rjo9WSt9aF4TSY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-yOvYyTgHN-2DbQfWaMHRDg-1; Fri, 22 Aug 2025 14:09:59 -0400
X-MC-Unique: yOvYyTgHN-2DbQfWaMHRDg-1
X-Mimecast-MFC-AGG-ID: yOvYyTgHN-2DbQfWaMHRDg_1755886198
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3c6abcfd1c0so248264f8f.1
        for <linux-s390@vger.kernel.org>; Fri, 22 Aug 2025 11:09:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755886198; x=1756490998;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4Qgw45kgIvklypQIdjW4WKJClwzbVj1vFIwI4+ABCxY=;
        b=aQDv7oRn9C6MlyPkpFMYXzdQxPLy/C9kQU73y5tEguF/Nq0CwQkDqntEjE4UkQ75N2
         +kgYoYvE29Nw9WAubg8t0nYuy4A5sZlfdMcLxk2/NJmtKFEUh5wg/tp3hTVK39GPmIMz
         e4EN618tAmYQG2X+pCyh7uU9Ukkeip8gQ8rN0OfUAVBOL2RkB2d6285KNFfYdcTBeGYz
         pKI9nl0sH+fFhwo2zGRokXuZQ4cM8mXYz6U9DrPDhT7Yw/3XzjHAgCUVFrtI8A/EiFot
         5aZxDRTVDRfuVhD+EVMG9LWKyzLFqkUEcJAouEOLIpX+eMT/X7o8MCBJ+nzI5u8Um3HV
         nn6A==
X-Forwarded-Encrypted: i=1; AJvYcCXxfLJJt9AqBYhMoi4fdGInDl0YVw/ikxEUwwWtnMt3eKGEwk2GCfQB8xR3y3EpjRQ79s2LJWbOkU4h@vger.kernel.org
X-Gm-Message-State: AOJu0YykWT6WsMdVUw0saEFBbfDvQAOdhYHU1kB+tG+01m1+9tLDOZqb
	0lLq+hxsRvZUydThGOHqkc5AdB02MlPyDhQV5hfhfqaJ3qSq/vG6FaLJuqdZBNN5suoXgliDIfa
	GZweEO8Sof58JSbrHT7UGHckD03Ys+HEUjG0lupo7XToNNgYlH8Joa0sUhuGfpx4=
X-Gm-Gg: ASbGnctxvlHP73RItszryXe348QibfuCM+/fcPGrwSEyBiRntCH227ZdpFKOCrwsO5p
	fKOTa6ap2k2/Ea7ZKUlw/39WWyNdFwlt+rZW7rUXNmxEB5po9WcwkAxDPdoGbY/R33njKT0+KZd
	VUJnIZWRDUxaNfZcgs/7w5tz4zVjQXNda+24+NZJVg2g002mHTw7rSJ0YyeG2xKmLklcDO47D8N
	vKtaxEMEmF1v1b+z6yk576VruqkuQe6QWurI/1yGOByVMxuep+GIkYmOFPCZ1/vDS/Cbr4ncP5d
	TCXKwvQaVREHzqhNyK4vQIjSgkQ2wxqTZYOj8bJGosKXThACaDdib+zXc34hpjQfpE1jUs8r7tL
	fRLMY086SjKpV/jSstJb7cK2SCxH31UTZHGxtmFx/SWglDnTCjri0NTi663E0VRJ3Tmc=
X-Received: by 2002:a05:6000:4011:b0:3a4:f50b:ca2 with SMTP id ffacd0b85a97d-3c5da83bbdfmr2672660f8f.8.1755886197913;
        Fri, 22 Aug 2025 11:09:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGihO/MfCjEADxWF8Q8DVVHHoqn0Rg/Ikr9pZDPhG5cKysecyGKSziAj6ohTWcg7Hwh15RzFg==
X-Received: by 2002:a05:6000:4011:b0:3a4:f50b:ca2 with SMTP id ffacd0b85a97d-3c5da83bbdfmr2672603f8f.8.1755886197412;
        Fri, 22 Aug 2025 11:09:57 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:6100:d9da:ae87:764c:a77e? (p200300d82f2e6100d9daae87764ca77e.dip0.t-ipconnect.de. [2003:d8:2f2e:6100:d9da:ae87:764c:a77e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b5753ac36sm7608875e9.6.2025.08.22.11.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 11:09:56 -0700 (PDT)
Message-ID: <1a3ca0c5-0720-4882-b425-031297c1abb7@redhat.com>
Date: Fri, 22 Aug 2025 20:09:54 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 09/35] mm/mm_init: make memmap_init_compound() look
 more like prep_compound_page()
To: Mike Rapoport <rppt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
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
 Michal Hocko <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
 Peter Xu <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
 wireguard@lists.zx2c4.com, x86@kernel.org, Zi Yan <ziy@nvidia.com>
References: <20250821200701.1329277-1-david@redhat.com>
 <20250821200701.1329277-10-david@redhat.com> <aKiMWoZMyXYTAPJj@kernel.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aKiMWoZMyXYTAPJj@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 17:27, Mike Rapoport wrote:
> On Thu, Aug 21, 2025 at 10:06:35PM +0200, David Hildenbrand wrote:
>> Grepping for "prep_compound_page" leaves on clueless how devdax gets its
>> compound pages initialized.
>>
>> Let's add a comment that might help finding this open-coded
>> prep_compound_page() initialization more easily.
>>
>> Further, let's be less smart about the ordering of initialization and just
>> perform the prep_compound_head() call after all tail pages were
>> initialized: just like prep_compound_page() does.
>>
>> No need for a lengthy comment then: again, just like prep_compound_page().
>>
>> Note that prep_compound_head() already does initialize stuff in page[2]
>> through prep_compound_head() that successive tail page initialization
>> will overwrite: _deferred_list, and on 32bit _entire_mapcount and
>> _pincount. Very likely 32bit does not apply, and likely nobody ever ends
>> up testing whether the _deferred_list is empty.
>>
>> So it shouldn't be a fix at this point, but certainly something to clean
>> up.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/mm_init.c | 13 +++++--------
>>   1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/mm_init.c b/mm/mm_init.c
>> index 5c21b3af216b2..708466c5b2cc9 100644
>> --- a/mm/mm_init.c
>> +++ b/mm/mm_init.c
>> @@ -1091,6 +1091,10 @@ static void __ref memmap_init_compound(struct page *head,
>>   	unsigned long pfn, end_pfn = head_pfn + nr_pages;
>>   	unsigned int order = pgmap->vmemmap_shift;
>>   
>> +	/*
>> +	 * This is an open-coded prep_compound_page() whereby we avoid
>> +	 * walking pages twice by initializing them in the same go.
>> +	 */
> 
> While on it, can you also mention that prep_compound_page() is not used to
> properly set page zone link?

Sure, thanks!

-- 
Cheers

David / dhildenb

