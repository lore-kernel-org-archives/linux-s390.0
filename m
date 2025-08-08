Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878EF246BCD
	for <linux-s390@vger.kernel.org>; Fri,  8 Aug 2025 14:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754663040; cv=none; b=kRVUgjmY6iXWeW6XytqWjPnAimpfgssLeYSIrk395su49mgWJJ0yQ0bRo4nrcxEaoWPnsLPkODLJN7/TnM9nOd5O9Bvbe/93sOqeRL2mFCOzoHnLJXT1CvfXAleuPx01h0VbdjMxC2hC6Ox9TaZM4FI0zKxmZtNuhuCacyjgQdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754663040; c=relaxed/simple;
	bh=f//vz9Qs9jg8eWEct2NufONUab9hKpWK5ssFy61Garo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ifW9Vgr3BRrrVJheSzmvhgC7ouZ12ZI2tQK/7RGcDKKKW9CRRfSb3xByqICGIuU0CGO4ANd5gEuw7z7JmFWP5uZIC96X/iRJjFfGQqInSbgpV/oRuTsCcu/o5t8chdYOKK5Nt1I88HwHtp1LickK8NkzWiOXXXsPDyWmdRJRVnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YkblCeHt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YkblCeHt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754663037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XoatM0Ku2K5SI5xfNAI9cK1iS0HhuHQQ3g0x13YtE24=;
	b=YkblCeHtVIhnR14HoJzyzp760gsDQeSp57IWZCGp9qCyA2EI3OXyJYiWIuAV3gLRwYPtnO
	uwzEtuK4JcDqXNZN9fUUQmqEHkGWMr4fMG2pB1TK0zDHphe3P5L6cRT5NrwLj9o/S1WO56
	ZlohG1d5U4GPX0jD27w0SeN4t/I+cIM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-VvxY3jzmPayjLvX-jwjlfA-1; Fri, 08 Aug 2025 10:23:56 -0400
X-MC-Unique: VvxY3jzmPayjLvX-jwjlfA-1
X-Mimecast-MFC-AGG-ID: VvxY3jzmPayjLvX-jwjlfA_1754663035
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b604541741so1063426f8f.3
        for <linux-s390@vger.kernel.org>; Fri, 08 Aug 2025 07:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754663035; x=1755267835;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XoatM0Ku2K5SI5xfNAI9cK1iS0HhuHQQ3g0x13YtE24=;
        b=Ex7LxDj1cpijtVH97cT95MaQmwA30i5/W1EJQ2zO0U8R+Wsx7nodEI5ZXWAljQU2AL
         gYan834/1h2ITwluvMpLz0YsgTg8M0lZ6y4CbrwC+PUHveL+1OzoJM7xLZpZaaTaNcsv
         Z+bnpOTspRG50U3DdJKlLJ+91cTT2WU4+fSBoKOO6EExtNB/V19V+fBhNtGh5Hs1O/pW
         pIPZ0YquE0BwHACy86EEKf0RO0t1iCsAnL75cPaNjH+n+C72yRWYxiLJiVpMLik/D7cR
         as4WoMDWSTR/BjJm8xMZRQlW8j9EgUIRMcEAOAxlmrDtl0SQ+ZcWswsyp3ZxrznOBZED
         KeHA==
X-Forwarded-Encrypted: i=1; AJvYcCWV46SD19ooceX+AuWrLZ1WWt9zzKRYAiNVcR+adrANGRsLoswNI5I/Kvd1cc/BRcFphUjfB/lAtDng@vger.kernel.org
X-Gm-Message-State: AOJu0Yypqk76O+79/q5ofmdHe8sCzkYrwHmp/LDAelIZQMkiTWS6TQXZ
	F3GTqkbj4V120ZUvFkj3qoKIX8qUaF7MKOl0TbyW5Biy/Stw90grHV4nupeEItR8dbVcZgNhHrO
	vLH/tdvTldkUaGg2JBBDURr9s3HLjLRZD2cKaE9HIrOXuWrewAdCzbhDQ2WmKw5I=
X-Gm-Gg: ASbGncvRBn/uV5Lambk3+X/8ROHjn3ZF6f2kW6YNvzEHS2ibwpw1h9EwTFh0hTV3CiA
	WFcYAs5cAOGP/G5WtXx6wbh3wuGzKmrhHLrRO+PQ5XbNAvaHrRYddymT8Yf2fO0mxtrEbUsuL8H
	Cvrm8EbQ7cfE8LW5b5dQbXvwiiN/oikRYli5CA6hx5NiFa00XWu1TF70DxuH22kKqVHoIx/cdq9
	J7vxse73HI7ozKW1cfF6zbr7c0BVCOvcnXTZASjGBOYQBF9V63dGrOfpizqfJJsnMA7fywUDD2T
	LGMx/hGcIbFnm/vNf455i9wqSwTw5p15QLq01w84qMxM9j6hyXu+Pf5S+0n4ZJoDhddPVTzICXe
	nBuEEHKrTl3MADNV0vPyIAplJLKHlWg3G/ew/UlCvVuioLIdE1OzIEVlU7EFw4W9k
X-Received: by 2002:a05:6000:2f84:b0:3b7:9dc1:74a9 with SMTP id ffacd0b85a97d-3b900b7aea4mr2535166f8f.42.1754663034462;
        Fri, 08 Aug 2025 07:23:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEePpZjK2UFX8XfHhLL2C/dDb4Nzd1zVHG6VBTgVmPIHVSFXe9BgmOEmO8a7NQY0B0WsA+mWQ==
X-Received: by 2002:a05:6000:2f84:b0:3b7:9dc1:74a9 with SMTP id ffacd0b85a97d-3b900b7aea4mr2535140f8f.42.1754663033969;
        Fri, 08 Aug 2025 07:23:53 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f25:900:2e1e:d717:2543:c4d6? (p200300d82f2509002e1ed7172543c4d6.dip0.t-ipconnect.de. [2003:d8:2f25:900:2e1e:d717:2543:c4d6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8fc28a830sm6142600f8f.16.2025.08.08.07.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 07:23:53 -0700 (PDT)
Message-ID: <687b556e-0196-4a38-986a-2e7b0308e03d@redhat.com>
Date: Fri, 8 Aug 2025 16:23:52 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] mm: fix accounting of memmap pages
To: Sumanth Korikkar <sumanthk@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, richard.weiyang@gmail.com
Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 linux-s390 <linux-s390@vger.kernel.org>
References: <20250807183545.1424509-1-sumanthk@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250807183545.1424509-1-sumanthk@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07.08.25 20:35, Sumanth Korikkar wrote:
> For !CONFIG_SPARSEMEM_VMEMMAP, memmap page accounting is currently done
> upfront in sparse_buffer_init(). However, sparse_buffer_alloc() may
> return NULL in failure scenario.
> 
> Also, memmap pages may be allocated either from the memblock allocator
> during early boot or from the buddy allocator. When removed via
> arch_remove_memory(), accounting of memmap pages must reflect the
> original allocation source.
> 
> To ensure correctness:
> * Account memmap pages after successful allocation in sparse_init_nid()
>    and section_activate().
> * Account memmap pages in section_deactivate() based on allocation
>    source.
> 
> Cc: stable@vger.kernel.org
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> ---
> v4:
> * Add fixes and suggested-by.
> 
> v3:
> * Account memmap pages for !CONFIG_SPARSEMEM_VMEMMAP and only when memmap
>    allocation succeeds. Thanks Wei Yang.
> 
> v2:
> * Account memmap pages for  !CONFIG_SPARSEMEM_VMEMMAP in
>    section_deactivate().  Thanks David.
> * https://lore.kernel.org/all/20250804151328.2326642-1-sumanthk@linux.ibm.com/
> 
> v1:
> * Account memmap pages for early sections.
> * https://lore.kernel.org/all/20250804084015.270570-1-sumanthk@linux.ibm.com/
> 
>   mm/sparse-vmemmap.c |  5 -----
>   mm/sparse.c         | 15 +++++++++------
>   2 files changed, 9 insertions(+), 11 deletions(-)
> 
> diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
> index fd2ab5118e13..41aa0493eb03 100644
> --- a/mm/sparse-vmemmap.c
> +++ b/mm/sparse-vmemmap.c
> @@ -578,11 +578,6 @@ struct page * __meminit __populate_section_memmap(unsigned long pfn,
>   	if (r < 0)
>   		return NULL;
>   
> -	if (system_state == SYSTEM_BOOTING)
> -		memmap_boot_pages_add(DIV_ROUND_UP(end - start, PAGE_SIZE));
> -	else
> -		memmap_pages_add(DIV_ROUND_UP(end - start, PAGE_SIZE));
> -
>   	return pfn_to_page(pfn);
>   }
>   
> diff --git a/mm/sparse.c b/mm/sparse.c
> index 066cbf82acb8..24323122f6cb 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -454,9 +454,6 @@ static void __init sparse_buffer_init(unsigned long size, int nid)
>   	 */
>   	sparsemap_buf = memmap_alloc(size, section_map_size(), addr, nid, true);
>   	sparsemap_buf_end = sparsemap_buf + size;
> -#ifndef CONFIG_SPARSEMEM_VMEMMAP
> -	memmap_boot_pages_add(DIV_ROUND_UP(size, PAGE_SIZE));
> -#endif
>   }
>   
>   static void __init sparse_buffer_fini(void)
> @@ -567,6 +564,8 @@ static void __init sparse_init_nid(int nid, unsigned long pnum_begin,
>   				sparse_buffer_fini();
>   				goto failed;
>   			}
> +			memmap_boot_pages_add(DIV_ROUND_UP(PAGES_PER_SECTION * sizeof(struct page),
> +							   PAGE_SIZE));

IIRC, we can have partially populated boot sections, where only some 
subsections actually have a memmap ... so this calculation is possibly 
wrong in some cases.

-- 
Cheers,

David / dhildenb

