Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90466257422
	for <linux-s390@vger.kernel.org>; Mon,  4 Aug 2025 12:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754310447; cv=none; b=MmMIp8YXQ5vtVuUcdhK+YQLLmHmoWLB9VEju2LDWUxD32UuvCQvFpK3TBsg9bgpBxudRoLPGgbcE6N0XzBtpt5TUNSr3aMRu/MV4jh4/RtVv2+dyjshLDJAbPQXQ8f0i9d2Fbuk0nrXN3Ebv8vvVv3LPirB4u0lLC0tFzRp96Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754310447; c=relaxed/simple;
	bh=Qf9ANNjxtl8s7C1ONwU/blp35LZUVGAAsM/ALfz4RYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nefo24FryMAeS/Wo+EThPXWwgq/F4PHey/wmlorjk/M2nLfg5MiWJgFqsqlj4tigNY5JOw0E/vy0ltaZGt+NKYie+sJn88ougJLZB0yiRk+l6x4QFAr5B1hLrLTp7WFJrSs76rZaEeiBk6edFAiookCgk82bskvvTxIqseHAbN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fCMjuonE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fCMjuonE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754310444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RqFNZiXIgVJOZ36O1iRoQqXTFYH8uoGigHQTRA21oeM=;
	b=fCMjuonE4pQnvlfuYoPeVWZSa9PPYWbAm0f/kY1GGQIMuLErwWmYGZabwQEOmYtDn0XM0x
	CHDHVbHnxF7tYTdl9cty1dv4GE8faTfAobx2Q2ZkeWfu351p/O4sCwXh5xJz0zyW9Xk0Nf
	klUnMiajL/kfl340ojr4cDz+TKl6BGA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-zW5pmcy8OpehnjKsMzRShg-1; Mon, 04 Aug 2025 08:27:23 -0400
X-MC-Unique: zW5pmcy8OpehnjKsMzRShg-1
X-Mimecast-MFC-AGG-ID: zW5pmcy8OpehnjKsMzRShg_1754310442
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-458c0c8d169so8025205e9.3
        for <linux-s390@vger.kernel.org>; Mon, 04 Aug 2025 05:27:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754310442; x=1754915242;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RqFNZiXIgVJOZ36O1iRoQqXTFYH8uoGigHQTRA21oeM=;
        b=WvVd9PtDQQ/lJ4LA+ASJyu08sE0o851ITnAxbd7Oq5aEJFE3ArP9FNmd4eDeOG3kku
         1EmbQoAy37DQTvSGhvLD14EcQVBgC9CaR0Gc0RJ/XUssZ0Fsck2TsJ06PalaTBrq660s
         5OnTmjRC/zCNBKuQAF7MAHnjNfvG5rAoaOb8/B49N6Z/WdZw6ehr29/q43WNFSNh7Y/O
         xSIowp4vwSTHC4jwi0lCcHZQYGrdRmEPIRrmqCywqUen84gwxMDLoJHwo3ij9B10GlbB
         U/CDG1OITktwCmLfKDJrWRDggIgl9zBoHFR8W5Enfk0DIlJfhW1nbrHHS3+tHFxsACgX
         FXhQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4+0KTpfcHKv2kdCw5GSfAyXOf+hwwpORo2seDPKTI71ppdPXJh9xspV0I8l7ZTbosH2wyi5X58hau@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5/zlbEz97/+HproPlJrq56WRUsCgOy0/R1a8cCX0mhjEQh8PR
	5lx2dInt7f40eZenmlTMKxrFGJBbfdgs/BVXo3o0ywFF06NPvRpxkBr82C2qHcTw7ZNrvfMaVe9
	9xXhKBhJuRnNhoTSgNSZhUU7VkJX3WZRSqVR9Ia0csLSrjao0dIZX425zirDixno=
X-Gm-Gg: ASbGnctan/Q6G7rOXXFa0rcJrQnwgKyMJ8sMDkHiGxu4ZzEUZeC45KDX455X8z1hIYD
	X6KMfrwnwSnX1qJ4zyStW9ngLo+Djoo0+BHC25ohPEDr4V9JNB1A9KaVjQUESLGV9IBIiPjKCtd
	N1iDz7pZQhEcTGJo/tWT4PU9TETayLjmwgBX7wiAZkjFgCHUFTx4JRIRWa8JLqXHdTOIiyrwkUz
	gPpuSODo7EqrmgikeC7StlFkH20ROfpuXLSHM+Htryh8G+zQXHgrEsop6CjyRBl63Mpr7oV4A2Q
	ed+J6UMeu/byNK7QkTrye/rZ53ujY9bbqJbS/wW0VqDvVKMETsI8gumrv6IKCDuD7shI5RnkTHh
	H7+jrsgbN0ARyUyadRAgN8CnXXbuQq37FY6TmukQrldla8h4Ce29NlMM3MG3kwdwS3As=
X-Received: by 2002:a05:600c:4f94:b0:458:bc3f:6a7b with SMTP id 5b1f17b1804b1-4595cffbec0mr46790465e9.18.1754310442120;
        Mon, 04 Aug 2025 05:27:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPCM5/SLg/IlHDZWJYXx2n14ukB77gslG9uesQCvJ2YvN7U6F/6nCutbjz9bA6HnN1x0X9CA==
X-Received: by 2002:a05:600c:4f94:b0:458:bc3f:6a7b with SMTP id 5b1f17b1804b1-4595cffbec0mr46790185e9.18.1754310441659;
        Mon, 04 Aug 2025 05:27:21 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9? (p200300d82f0e2c00d6bb8859fbbcb8a9.dip0.t-ipconnect.de. [2003:d8:2f0e:2c00:d6bb:8859:fbbc:b8a9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4696c8sm15148041f8f.55.2025.08.04.05.27.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 05:27:21 -0700 (PDT)
Message-ID: <1e259390-67b1-4d08-8174-a65f1fc9eccc@redhat.com>
Date: Mon, 4 Aug 2025 14:27:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: fix accounting of memmap pages for early sections
To: Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>
References: <20250804090859.727207-1-sumanthk@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250804090859.727207-1-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04.08.25 11:08, Sumanth Korikkar wrote:
> memmap pages  can be allocated either from the memblock (boot) allocator
> during early boot or from the buddy allocator.
> 
> When these memmap pages are removed via arch_remove_memory(), the
> deallocation path depends on their source:
> 
> * For pages from the buddy allocator, depopulate_section_memmap() is
>    called, which also decrements the count of nr_memmap_pages.
> 
> * For pages from the boot allocator, free_map_bootmem() is called. But
>    it currently does not adjust the nr_memmap_boot_pages.
> 
> To fix this inconsistency, update free_map_bootmem() to also decrement
> the nr_memmap_boot_pages count by invoking memmap_boot_pages_add(),
> mirroring how free_vmemmap_page() handles this for boot-allocated pages.
> 
> This ensures correct tracking of memmap pages regardless of allocation
> source.
> 
> Cc: stable@vger.kernel.org
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
>   mm/sparse.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 3c012cf83cc2..d7c128015397 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -688,6 +688,7 @@ static void free_map_bootmem(struct page *memmap)
>   	unsigned long start = (unsigned long)memmap;
>   	unsigned long end = (unsigned long)(memmap + PAGES_PER_SECTION);
>   
> +	memmap_boot_pages_add(-1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
>   	vmemmap_free(start, end, NULL);
>   }
>   

Looks good to me. But now I wonder about !CONFIG_SPARSEMEM_VMEMMAP, 
where neither depopulate_section_memmap() nor free_map_bootmem() adjust 
anything?

Which makes me wonder whether we should be moving that to 
section_deactivate().

-- 
Cheers,

David / dhildenb

