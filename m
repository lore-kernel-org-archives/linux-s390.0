Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2831E766E;
	Wed,  6 Aug 2025 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471004; cv=none; b=L/uJ5awwppYqSX21AibbvbQMx1QGw2kOVL+Z4iUtohbwCAzbuWJvTknWhi98ChzZUpEKioGI3keCD12MMI6oQlKqjEmVPKWsx3icCfqUBEic/aUNhbifJkbif0G6/2ZX3snT5J2XHAGzXn6ckbboOyR2XrIIkWJ9IA1GGdEzldk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471004; c=relaxed/simple;
	bh=3o7NlWh5GslLq8gFtc/dnRSaMerNmIwx5vLw1ZOTjiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIone9+S6Uon8fC7BJylgRTPYI29S4DMKoII782zwkB9GRVYUXwDfzdp076w8BOimUFb9gsSGJJF0/gVgUI7ZFoW3G9M/Pc8o+1EimEZt8vORzNr6ZI6FSNmxzNMd28HUsYpWsGhHkUsU74F1mAiQsmm519VA2Eny3HLt6DCxlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZ/lh3tP; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZ/lh3tP"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61568fbed16so8410212a12.3;
        Wed, 06 Aug 2025 02:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754471001; x=1755075801; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X7VlvHodp5bmcUXkA6dSTDBa8OaE5M3KbiDKEm7c3mA=;
        b=VZ/lh3tPTlXGiSPKQCHXk36zNkNiOaAQYztxxKG6PEbMkgCxL8+m1USP8Byg6PvxBJ
         xyxHcLzR/Sv+VW9RBqmBzP42s+UbbYKxFb9GMBcJ+7pIR5UcK1zleZm+GZMVJNxLIGUq
         E8t1QSjs88kmqMzk3vl73ubfb/VqmvNl9MAifdYPs6lgP3U7TSH7Eb8ZWyb1bWl2IOqI
         Wb56lCf/pQZp8U13SrZILCAieR9NSqL26gY0WPeLeURnmvszhk/ihPS8b4DOfbufkE46
         1bVXZkXDW09BeDGE8ujn9D9pFXnGj8CqFcB1VgWHfBhcQMo7F7cvxm0JupcMdl7apSIk
         AAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754471001; x=1755075801;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X7VlvHodp5bmcUXkA6dSTDBa8OaE5M3KbiDKEm7c3mA=;
        b=ucg6uz/mjg1b4OUHedLLfixT282QtQRBuq9ZRXoJCkJ1zBynjIpBidvue5lMUdPx/3
         6i+BLc3xsGLu5XqRrKJ4t/tvlkzrvBfY9sqYGBJoIk0FOOsxqHgRL1tw80mTEntKurho
         xbSy8ok/rls5/ViEIOHXrG0nIsqgT25UfFv49qK93RZ91uYQY7qFdkMXlMgD2pPxHrVg
         b0gSEx2ooQBjKcWlX2pZiyleoOz4rrJEnDeDTzrIK4EocDIjU7Y+EyplgNTFx5xNlf6+
         MQqXtLbOfXNXxiyR/t5HIWItgthF50JVnH/1DxnlMK06/HwPjmekoMeTH1JaTUiP8F4A
         iuxQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+OLDs3I5PvM51gmCeQASyizBTEM9DiWz2q6I3hqBWxgMXeMQS91YEd/lEjc6WeHrYWdWdUOlbQMz9pg==@vger.kernel.org, AJvYcCXpcUY8YNwt1OFf4EzEGWhMnibp9721YLixboal+n0lXOUlSA80ilYkylyfeRDTuEwYD7w3BrCgO/P1rzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUxUZEOJXdr6A/x1Uwjasq6JcEAaOLniUhcpslrmNs5p+NVoti
	wDr6okflEElsJcZvLBDCtaLlaGG2vIC0MwFXNYSK2djgc8aENCKi3wzLQw/OpqSd
X-Gm-Gg: ASbGnctCs2hk1V1CoL4XXvRX/bQXULV1pJpxGesTSYVGPYaB5tkWZrHamIhxJMHg3+s
	Sas6Ko5fnIILjdRV5RJugTb15DPF6Oh8cHTXp2Y92QMYijKXD/CFO1tmMXAXvxd6EEIS1CnAEuL
	es4ZraRGBNFs1LgaUDImv+2SFhugruU5k1+n5OsJoerT66DGeaEFmqAuADMGkUIQaZoyF+cgsJp
	qsgADhcOLt9zujZXXximCyqaP6q4Ba+NfLlmD0LBBxhCHGogOVvUE/eJN66RmU7OpPbJ1xiG8dX
	kHZkpJ5OpljONG2CrzPUS2jpj0C5XjQLGSw4a9JejfsnCb+p4hxgC4Gg3ywlcyoOqQGFfzy8Li9
	svD4KHBQHHKAHlUXNlOP6dw==
X-Google-Smtp-Source: AGHT+IGKQsNAIUh+xJlHzy3nN2xphCyw1az4JEJ6yq9Qx4/Oq6uuF5spFilgh+DFG3Lfh7up2OBaUA==
X-Received: by 2002:aa7:d386:0:b0:615:481c:7e03 with SMTP id 4fb4d7f45d1cf-61797de13b0mr1103751a12.21.1754471001035;
        Wed, 06 Aug 2025 02:03:21 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8ffbd97sm9780487a12.53.2025.08.06.02.03.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Aug 2025 02:03:20 -0700 (PDT)
Date: Wed, 6 Aug 2025 09:03:20 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	linux-s390 <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v2] mm: fix accounting of memmap pages for early sections
Message-ID: <20250806090320.wdt4zsfiambtgkvy@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20250804151328.2326642-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804151328.2326642-1-sumanthk@linux.ibm.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Mon, Aug 04, 2025 at 05:13:27PM +0200, Sumanth Korikkar wrote:
>memmap pages can be allocated either from the memblock (boot) allocator
>during early boot or from the buddy allocator.
>
>When these memmap pages are removed via arch_remove_memory(), the
>deallocation path depends on their source:
>
>* For pages from the buddy allocator, depopulate_section_memmap() is
>  called, which should decrement the count of nr_memmap_pages.
>
>* For pages from the boot allocator, free_map_bootmem() is called, which
>  should decrement the count of the nr_memmap_boot_pages.
>
>Ensure correct tracking of memmap pages for both early sections and non
>early sections by adjusting the accounting in section_deactivate().
>
>Cc: stable@vger.kernel.org
>Fixes: 15995a352474 ("mm: report per-page metadata information")
>Suggested-by: David Hildenbrand <david@redhat.com>
>Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
>---
>v2: consider accounting for !CONFIG_SPARSEMEM_VMEMMAP.
>
> mm/sparse.c | 9 ++++++---
> 1 file changed, 6 insertions(+), 3 deletions(-)
>
>diff --git a/mm/sparse.c b/mm/sparse.c
>index 3c012cf83cc2..b9cc9e548f80 100644
>--- a/mm/sparse.c
>+++ b/mm/sparse.c
>@@ -680,7 +680,6 @@ static void depopulate_section_memmap(unsigned long pfn, unsigned long nr_pages,
> 	unsigned long start = (unsigned long) pfn_to_page(pfn);
> 	unsigned long end = start + nr_pages * sizeof(struct page);
> 
>-	memmap_pages_add(-1L * (DIV_ROUND_UP(end - start, PAGE_SIZE)));
> 	vmemmap_free(start, end, altmap);
> }
> static void free_map_bootmem(struct page *memmap)
>@@ -856,10 +855,14 @@ static void section_deactivate(unsigned long pfn, unsigned long nr_pages,
> 	 * The memmap of early sections is always fully populated. See
> 	 * section_activate() and pfn_valid() .
> 	 */
>-	if (!section_is_early)
>+	if (!section_is_early) {
>+		memmap_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page), PAGE_SIZE)));
> 		depopulate_section_memmap(pfn, nr_pages, altmap);
>-	else if (memmap)
>+	} else if (memmap) {
>+		memmap_boot_pages_add(-1L * (DIV_ROUND_UP(nr_pages * sizeof(struct page),
>+				      PAGE_SIZE)));
> 		free_map_bootmem(memmap);
>+	}

The change here is reasonable. While maybe we still miss the counting at some
other points.

For example:

a. 

  sparse_init_nid()
    __populate_section_memmap()

If !CONFIG_SPARSEMEM_VMEMMAP, and sparse_buffer_alloc() return NULL, it
allocate extra memory from bootmem, which looks not counted.

b. 

  section_activate()
    populate_section_memmap()

If !CONFIG_SPARSEMEM_VMEMMAP, it just call kvmalloc_node(), which looks not
counted.

Do I missed something?

> 
> 	if (empty)
> 		ms->section_mem_map = (unsigned long)NULL;
>-- 
>2.48.1
>

-- 
Wei Yang
Help you, Help me
