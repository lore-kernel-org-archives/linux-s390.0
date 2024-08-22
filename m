Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCCA13B586
	for <linux-s390@vger.kernel.org>; Thu, 22 Aug 2024 19:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724354224; cv=none; b=s8kuDOZzrOk8ikmjO8OuZOqt9E73dDLADCLGfUs0zDVxmIpOtp/wJEUG4FJ7YV47zhycv0uRw4TZgRbN0/ASuKe3Yz8GT7zgTBsQBHQdUHD7XgpfG7KE69c8K9S+pW9rsbgxMEfezBclWvX84qOBhGLJTjuIEco0AmScDTw1kUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724354224; c=relaxed/simple;
	bh=uSB46zVUu3Qp45AXNGJYl4M4u3m0klZyVOj9SqTKm/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/zZxrUyAXMYLA8wPGqXIF4rCMhAYAmkVNbaHw6scUoolZcc2oLlIoYUriOAPViPxEOMWeg8G6MuCsrW78JRgkzcn+HWrkcyq/XLNpOjcB+Gq5OqDyLgPA5D6D6hRXSx4Y0HxpNZqdK1e5aiHDzGrFzDIETIVM8LLQPNVmS+8U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bsE7Juvx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bsE7Juvx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724354221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8YIGGOCAzyFLMegU+7vlNDExeBWij0GRi4vYqrn2fMA=;
	b=bsE7Juvxqdfr7b385vESNRNAv5wUuV2nAXdUwxP/BZZYnpQqLicGAzH/1H/NKiGqcTbKdk
	uAK+Q8PjiHlT4/4UXgTArrKv/dgcIixQINGkSLEk+85lR/kd6lpZX6Epy2ydh97orvqyXA
	Z5CSHk/HkOEZUiBvVeStdB9iNdrOux4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-TowhOhsPPJic9W6wgnpxoQ-1; Thu, 22 Aug 2024 15:17:00 -0400
X-MC-Unique: TowhOhsPPJic9W6wgnpxoQ-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6bf6e8187c7so12954656d6.1
        for <linux-s390@vger.kernel.org>; Thu, 22 Aug 2024 12:16:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724354219; x=1724959019;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YIGGOCAzyFLMegU+7vlNDExeBWij0GRi4vYqrn2fMA=;
        b=W4cz4keTqPIlm7/TzEZSaOkq6H5IqIDn+fHIRhZLN7iMsC3ljCzzq38uHcsl6zjUaT
         BT8YdfG2mBxi2xA99YDsCz+DkH0lXcxkfBGItPlDS8OyqFQd+VWsmYkC95j2EM7FRIet
         otkqLZmKPXU5Nh2OanKnNEJbpYYdou/ojGASvFEQnjXHM0b55aM/5VViH7qCQUMZs+EV
         3H0puQOsfCrEskXg+1xupUflahlKZYw/gaaxJrEuCzd66CKGa+jh/FukKgGIMrit7UDr
         kAcascZ9TClj3WY+uiXNCE5iAo7bBHIHaIJkW8v9Gl5f9/RA+E/11pIaUABj0sKmFZS4
         RBbA==
X-Forwarded-Encrypted: i=1; AJvYcCUNm61TiubD5Hc+DpbrDi9gRYjmf9AaVZfag07CvIkuHHbhenR75On+IzyGJwrk/Zm8roVC8X/VbCRj@vger.kernel.org
X-Gm-Message-State: AOJu0YzGXNUWttZNs8lKmMaS/E4FDPusuhMsHlfoF4OxgDEwIOTRCabV
	v0ukRmytD0S7v2t4D+t9Q0hUIwtMEpfNkNfCZL8mHvZY6X7M3uPrtqtfTTyyM4JdBLZfmGEQ2Xw
	6bC58/vSR8AuYzoYoh4YSbYcwmBUKjdtFt+UeudoR9kWJGAJhh2RnW1/BuX4=
X-Received: by 2002:a05:6214:5d0b:b0:6bf:77d2:bd1b with SMTP id 6a1803df08f44-6c155d50b2cmr98300266d6.1.1724354219386;
        Thu, 22 Aug 2024 12:16:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFFYSGXCSjeDYuhWfImPH5iwMXkcbcR5SnsnH9Y1R2sqbG+oUFa29LZaEVT2+yBaXWcgJ2DTA==
X-Received: by 2002:a05:6214:5d0b:b0:6bf:77d2:bd1b with SMTP id 6a1803df08f44-6c155d50b2cmr98299806d6.1.1724354219032;
        Thu, 22 Aug 2024 12:16:59 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db0986sm10643056d6.97.2024.08.22.12.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 12:16:58 -0700 (PDT)
Date: Thu, 22 Aug 2024 15:16:55 -0400
From: Peter Xu <peterx@redhat.com>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>, "x86@kernel.org" <x86@kernel.org>,
	Alistair Popple <apopple@nvidia.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH RFC 2/6] mm: PGTABLE_HAS_P[MU]D_LEAVES config options
Message-ID: <ZseOp7M9AmZtW4jw@x1n>
References: <20240717220219.3743374-1-peterx@redhat.com>
 <20240717220219.3743374-3-peterx@redhat.com>
 <dcdde9fc-7e7c-45a8-8dc7-7f7ed13b81ec@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcdde9fc-7e7c-45a8-8dc7-7f7ed13b81ec@cs-soprasteria.com>

On Thu, Aug 22, 2024 at 05:22:03PM +0000, LEROY Christophe wrote:
> 
> 
> Le 18/07/2024 à 00:02, Peter Xu a écrit :
> > Introduce two more sub-options for PGTABLE_HAS_HUGE_LEAVES:
> > 
> >    - PGTABLE_HAS_PMD_LEAVES: set when there can be PMD mappings
> >    - PGTABLE_HAS_PUD_LEAVES: set when there can be PUD mappings
> > 
> > It will help to identify whether the current build may only want PMD
> > helpers but not PUD ones, as these sub-options will also check against the
> > arch support over HAVE_ARCH_TRANSPARENT_HUGEPAGE[_PUD].
> > 
> > Note that having them depend on HAVE_ARCH_TRANSPARENT_HUGEPAGE[_PUD] is
> > still some intermediate step.  The best way is to have an option say
> > "whether arch XXX supports PMD/PUD mappings" and so on.  However let's
> > leave that for later as that's the easy part.  So far, we use these options
> > to stably detect per-arch huge mapping support.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   include/linux/huge_mm.h | 10 +++++++---
> >   mm/Kconfig              |  6 ++++++
> >   2 files changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 711632df7edf..37482c8445d1 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -96,14 +96,18 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
> >   #define thp_vma_allowable_order(vma, vm_flags, tva_flags, order) \
> >   	(!!thp_vma_allowable_orders(vma, vm_flags, tva_flags, BIT(order)))
> >   
> > -#ifdef CONFIG_PGTABLE_HAS_HUGE_LEAVES
> > -#define HPAGE_PMD_SHIFT PMD_SHIFT
> > +#ifdef CONFIG_PGTABLE_HAS_PUD_LEAVES
> >   #define HPAGE_PUD_SHIFT PUD_SHIFT
> >   #else
> > -#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
> >   #define HPAGE_PUD_SHIFT ({ BUILD_BUG(); 0; })
> >   #endif
> >   
> > +#ifdef CONFIG_PGTABLE_HAS_PMD_LEAVES
> > +#define HPAGE_PMD_SHIFT PMD_SHIFT
> > +#else
> > +#define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
> > +#endif
> > +
> >   #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
> >   #define HPAGE_PMD_NR (1<<HPAGE_PMD_ORDER)
> >   #define HPAGE_PMD_MASK	(~(HPAGE_PMD_SIZE - 1))
> > diff --git a/mm/Kconfig b/mm/Kconfig
> > index 60796402850e..2dbdc088dee8 100644
> > --- a/mm/Kconfig
> > +++ b/mm/Kconfig
> > @@ -860,6 +860,12 @@ endif # TRANSPARENT_HUGEPAGE
> >   config PGTABLE_HAS_HUGE_LEAVES
> >   	def_bool TRANSPARENT_HUGEPAGE || HUGETLB_PAGE
> >   
> > +config PGTABLE_HAS_PMD_LEAVES
> > +	def_bool HAVE_ARCH_TRANSPARENT_HUGEPAGE && PGTABLE_HAS_HUGE_LEAVES
> > +
> > +config PGTABLE_HAS_PUD_LEAVES
> > +	def_bool HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD && PGTABLE_HAS_HUGE_LEAVES
> > +
> 
> What if an architecture has hugepages at PMD and/or PUD level and 
> doesn't support THP ?

What's the arch to be discussed here?

The whole purpose of this series so far is trying to make some pmd/pud
helpers that only defined with CONFIG_THP=on to be available even if not.
It means this series alone (or any future plan) shouldn't affect any arch
that has CONFIG_THP=off always.

But logically I think we should need some config option just to say "this
arch supports pmd mappings" indeed, even if CONFIG_THP=off.  When that's
there, we should perhaps add that option into this equation so
PGTABLE_HAS_*_LEAVES will also be selected in that case.

-- 
Peter Xu

