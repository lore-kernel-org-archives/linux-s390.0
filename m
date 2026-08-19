Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5742E471274
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 11:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787140127; cv=none; b=MLh+FXjojUhldsrNr0I8nr3Oei4dkii1Wzlcd3hTWeZyEC5jx+67aNXkflGY+8ptkMhv6GHV+Dg/C0POik65Shuy4vn6b52OY0RgiULk5XG897XVfvXP8I21WEhhZ0tC16V8hn8/sLcEvozxVmxVDI+fflSz4d2b76nVMDIMV40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787140127; c=relaxed/simple;
	bh=hlqPu8zxYhXjAp0RnMZVNI6hpIt1GyNxw1ypjjho7mg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHTo5vs6W8i+XeZeZB1vNg2RG7tHk7zuqtcMePqROdR76mdo72uElF7MuPllGI0OSzQ9iApoAhCq2znsKhSgDZUBwT8Khjb1UPayeL/z7TdOkbA85siWTS1Eg3TpKrEj4q59dVjnGw5FTnx5ZNErx2Gjr52SOeOJdv7cIoHaRc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qy9iRabv; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qy9iRabv"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b2b92065ffso1051928e87.1
        for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 04:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787140122; x=1787744922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1Neo+1K8ghUMGN3G9vUjB7A1LbHA9OhMwHPbvzVv5Wg=;
        b=Qy9iRabvWhzH7PzgaB4eB9k6CK9pe2v2/mbUtDU4i6yoCI5CmESJAQDtouG7uGDfTU
         wXw2qdqW+EcKN0eM1benvN+Bh0GImVRBXPbZLKRY2RHZuMlZvMPB/VSajbxCivLjC+bq
         L8RPBy8R0tcBOYwxgoats7rF9GkrsAtxB2yFTpcUzdh3++d7sasVE42mw/iQHXsfAkq0
         U+Fx8X2RQvPKquEf9ZI71OB10ChTHx0UAXOP94Of/P8nywze2XSx4ei4q9a2o5Z4Q8cy
         GCVWi28FJviFLWZB5kFCWaA8Hp0B9O0MU1HQb4J+V0Xkw5+Hvl7mdcE6n4afP8AXvSD4
         GCzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787140122; x=1787744922;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Neo+1K8ghUMGN3G9vUjB7A1LbHA9OhMwHPbvzVv5Wg=;
        b=itPkpcjHd0TLU0gLq6kUccY9YDAob4wXLwVN4ZR2f1ad4bbYSHWRU5Bb93nfetiJbj
         zWcxWQdCtqGEP4yI6F6VxeuADT8akHo1tIbqvxQ6PDgzlu3IKCShm9umorSjseTHXba6
         +KDTB20A76VwWeBec+YWP2dLB179t/KtrRRBBBPbnWbkdpjQrthiB+yVcCMj5Y5YVE3F
         Q2wT8pR7Dr1yn6s8BARpbqgK25tmrolD0YjcmCeWI9MifCgt1ZPAO03yu7gWDaX42MHt
         PSErfQEcZ5o9/Iqogx1F1hmDTOPhHiVSlgqUxl//9MgG0s+0FfT4BgcduXhphK5Jei1R
         cpNg==
X-Forwarded-Encrypted: i=1; AHgh+Rp1h8923EUN+7qEC77ThQiaaG0ryOd5jsZr6bbUa8CC+QtZx7mG1fmdZqoaV7pJF+25cVh1jGO/qGwH@vger.kernel.org
X-Gm-Message-State: AOJu0YwQxI5pRp3DavZcO7UYaoOsf91SxptPzTcxO4Rk8NZKsBtEUm1E
	7B5K2BFBc30qykifLqboZEWXx9wH16KVQ41S2vsheCjDJF3Qxss6QbHO
X-Gm-Gg: AR+sD1238ylLn5c/4FzDadkcJddqr2sKtwwvYehaQDxEGNxyi4MyKoCkHJV9nMMM6Dg
	OReqVPYyZA0pOtCR9mlVSpAVuknWSHZIPVo4bas4evFcPaMxlBdwPvA8ckHcC5NwO2+BuRlK0Y6
	3TtREeOJDDSGW10mo65Ie+5WtOocGfmjyWY3ue81zILbvP2Xo0OfKw4nXkehNFRoTp39Ao4JXmk
	dfv7vERlzsUBi6xxx1HAqosK63SXOEYzOKNZ9J6hf2vfnkpk+1gZdG2DAujWfBTeNSzufZbHFfd
	vcAM9ACCoxRm1cck8BD28bOymnwW8YOSIGI53Bywr/tusewRK80iARsuVCq5rffsS/Cu9EwUEjA
	yavgd/TqEcfkWvQXQGhrfyhkLkc8kZ0FVp1xqVaaMKxWwTsvPDwGhbwAJaXbQ6UipSCcPRoR2Fc
	tQ/GgTSkgMxZF6XR8ke7dxbF4dUu/U4m0ygINhcIhhzENdmd1D0LRQrsWkMBLzvCfI2fEXNu1Id
	qToq9acwXgZ+haa+t8JUte4uErq4Q==
X-Received: by 2002:a05:6512:224d:b0:5b2:f453:1073 with SMTP id 2adb3069b0e04-5b478b9070dmr1376566e87.2.1787140121681;
        Wed, 19 Aug 2026 04:48:41 -0700 (PDT)
Received: from pc636 (host-95-193-137-165.mobileonline.telia.com. [95.193.137.165])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b478853971sm482752e87.10.2026.08.19.04.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 04:48:41 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Wed, 19 Aug 2026 13:48:36 +0200
To: Mike Rapoport <rppt@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Adrian =?utf-8?Q?Barna=C5=9B?= <abarnas@google.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexandre Ghiti <alex@ghiti.fr>, Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Len Brown <lenb@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Vasily Gorbik <gor@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH 2/6] mm/vmalloc: set area's page_order after allocation
 succeeds
Message-ID: <aoWYFH_FJXlMK8fw@pc636>
References: <20260816-execmem-set-vm-perms-v0-2-v1-0-90944a3ad43f@kernel.org>
 <20260816-execmem-set-vm-perms-v0-2-v1-2-90944a3ad43f@kernel.org>
 <aoNFZU_QzghDBgbZ@milan>
 <aoVUF2pgl8JYNyIU@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoVUF2pgl8JYNyIU@kernel.org>

On Wed, Aug 19, 2026 at 09:58:31AM +0300, Mike Rapoport wrote:
> On Mon, Aug 17, 2026 at 07:31:17PM +0200, Uladzislau Rezki wrote:
> > On Sun, Aug 16, 2026 at 01:59:25PM +0300, Mike Rapoport (Microsoft) wrote:
> > > __vmalloc_area_node() calls set_vm_area_page_order() to set area's
> > > page_order before actually allocating pages to populate the area.
> > > 
> > > If allocation of large pages in HUGE_VMAP case fails midway, this leaves
> > > the area with elevated page_order throughout the cleanup path.
> > > 
> > > There is no actual issue with this because the only place that currently
> > > relies on area->page_order on the cleanup path is the loop calculating
> > > the direct map alias range in vm_reset_perms() and it anyway skips
> > > unpopulated pages.
> > > 
> > > But having set_vm_area_page_order() in the middle of __vmalloc_area_node()
> > > makes things very obscure, hard to reason about and error prone against
> > > future changes of the cleanup path.
> > > 
> > > Move the call to set_vm_area_page_order() after __vmalloc_area_node()
> > > succeeded where page order is guaranteed.
> > > 
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > ---
> > >  mm/vmalloc.c | 11 +++++++++--
> > >  1 file changed, 9 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index 22566e0b6e38..6822f0fe9583 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3901,8 +3901,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
> > >  		goto fail;
> > >  	}
> > >  
> > > -	set_vm_area_page_order(area, page_shift - PAGE_SHIFT);
> > > -	page_order = vm_area_page_order(area);
> > > +	page_order = page_shift - PAGE_SHIFT;
> > >  
> > >  	/*
> > >  	 * High-order nofail allocations are really expensive and
> > > @@ -4106,6 +4105,14 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
> > >  	if (!ret)
> > >  		goto fail;
> > >  
> > > +	/*
> > > +	 * Set area->page_order once it's known exactly that the order of the
> > > +	 * pages the area contains.
> > > +	 * Even if we succeeded to partially populate the area with large pages,
> > > +	 * still treat the area as populated with order-0 pages.
> > > +	 */
> > > +	set_vm_area_page_order(area, shift - PAGE_SHIFT);
> > > +
> > >  	/*
> > >  	 * Mark the pages as accessible, now that they are mapped.
> > >  	 * The condition for setting KASAN_VMALLOC_INIT should complement the
> > > 
> > > -- 
> > > 2.53.0
> > > 
> > OK, can we just set it right after the:
> > 
> > 	area->nr_pages = vm_area_alloc_pages(
> > 			vmalloc_gfp_adjust(gfp_mask, page_order), node,
> > 			page_order, nr_small_pages, area->pages);
> > 
> > 
> > succeeds?
> 
> Here it's still not clear if vm_area_page_order() succeeded :)
> 
> I can move it just before
> 
>  	return area->addr;
> 
Even better :) For next version:

Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki
