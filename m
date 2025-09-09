Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC938350D61
	for <linux-s390@vger.kernel.org>; Tue,  9 Sep 2025 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436223; cv=none; b=n1pKynBRBCzdHAo3xj2LoF1W4yMMRiF0POUVqz7xFdMVfqNXy8OFKsa3xjAicZbq4e3b2cUFeRJafq4+ZcA9byM8iEaAK8iMnvlrb3ApbErt/Mz0aGwVKfu/ZmTAAcse7mnlL42rd4wMcdTjMHS5zcEMkcYCqzNcBHRzNk/q7mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436223; c=relaxed/simple;
	bh=QvvxVmrQ6ERDo1A0ifaFO0uKs7uSQdW94E943VWjhCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oWy6bSYu1m8DOKI0vF3y0+Tpk3aJ4Gw5aQOqND7SUJk+ngrmk6OjZxda5G1tqEGaAB4LUOGNVcGa7X2xZwcJkmVz9XKH76MUuvlSswJa7ioLYVqIgnkm/m1lBVWOOasiBKt5pBjXGvxzUsdQQKvJqpl4xO92c3px6amILr0O2eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QzUgrfth; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QzUgrfth"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-61d14448c22so39a12.1
        for <linux-s390@vger.kernel.org>; Tue, 09 Sep 2025 09:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757436219; x=1758041019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9zR1ns6r4tli6kgpMkZXeVyHg9onE4yZmroH/q5x2E=;
        b=QzUgrfthjX+yZze12AQ3vqjYc7zDU+KrFfKFBVIltMYKbRIcSmqKe4BqXoUL+1mQ0x
         LUhNhONY5gXIA3q/XJaSSVid6Ye0sOwiOH4UANYuGqLxpk7ToRf+6XDTDqrJSAYIICls
         oALC3W7ynSYZZvb3peuweLW0tBdTH0GYsxrl1SXhKFwgpzMYlewXlE9i3XpSj8MFopMf
         3EHFGbhcgtFu2NkskmpEm5Va/jVPB8s3M/eqCavOuYeAz+68gIiMvZMI90cpDXzrNBuu
         jhC219nyQZutY/ueKfIO/hqqoSBvADI+JI+wyWdOE9tLz/nysVZeDik40Mys5jGIOKJp
         uDlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436219; x=1758041019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9zR1ns6r4tli6kgpMkZXeVyHg9onE4yZmroH/q5x2E=;
        b=w96sQIlKVkRIVnzlqWdqSjPr0nNpn2A9egRWJhUhEeLNkDVgY107on4rTj/ywERZ4F
         UpqVMsFv9MDsueMOUgxNltWKu6C96c0RbEeZXcCTgpBZc6G4PokOxlzoVSX9tQd9+bt1
         4b/SbjvRanhVf+B75K7vHX+AKchOyIXZTqCMiMvvoUWnw8TbHwTyAmi9iAlfJICx48jh
         GocslhGruPGon7dK1FHjDjDnUaZ8p43nPjDTQeHBlxIcUTRi8rpTLQ0m2fvCvbLaDUpP
         B3LEmzbc1QSeRe0HBcp5HpzTagXX1wyoMWWMgDc4hKiQY3xoNZ2xxJR8HP1rNLXBBn96
         xtXw==
X-Forwarded-Encrypted: i=1; AJvYcCVBDyo/3YUNzM8YiPqm6QuXovI4Z6KjRyJwBCCB6nY1cNG2BbabZ8OXSlaxGqt4XRzQLcYH3lNIJa0O@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+cpmYLy7Ya4vehqXr1ECFPb81PP2V3Yy6+DeXqwiGcTismF6n
	yHUFLmCYEKfVXdcTMgnf1w4nrjt08CEAsp2x8V5o3LoDDQId2Icce/xPKwZoNnIffl1SgZ5mBE3
	e2rQ0Bs/5fqxoqhez/YTzZL3Bq2s0PUYXLeVgB6hm
X-Gm-Gg: ASbGnculjZAJkeW78CBhXHb11EYEnxAtqCPYjPoBhJUpXe7gq/Kso8A9ONe9rvw3D5t
	xSWYHswhLvxVhYi13nnm/666cU2KmCH2iKGqrQgYxKbXevQlkHGt0yDLorQjpkSDBtfKOrQiZOd
	z0i9mDH4EYXpT/VgAoGIPqhyApjAPQLNnfdDwVs+HRtycWyItpbqTBHD76Om+ny2ub9RYXxaalH
	nwyzfCOaDCwlHGd/XF4wCNhl5fQMV1WThjnFGijrN/ji50qfp/qNk8=
X-Google-Smtp-Source: AGHT+IELrtj08JXZeKFczydeIaWz+ZDdGREnJhxstnY5vYYsKxfzgQANvCdFJ1mjoGgstj0WHnOScZjfoo2Pzh65Zfk=
X-Received: by 2002:a05:6402:4024:b0:61c:c9e3:18f9 with SMTP id
 4fb4d7f45d1cf-623d2c4dda5mr356673a12.3.1757436218862; Tue, 09 Sep 2025
 09:43:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <ea1a5ab9fff7330b69f0b97c123ec95308818c98.1757329751.git.lorenzo.stoakes@oracle.com>
 <ad69e837-b5c7-4e2d-a268-c63c9b4095cf@redhat.com> <c04357f9-795e-4a5d-b762-f140e3d413d8@lucifer.local>
 <e882bb41-f112-4ec3-a611-0b7fcf51d105@redhat.com> <8994a0f1-1217-49e6-a0db-54ddb5ab8830@lucifer.local>
In-Reply-To: <8994a0f1-1217-49e6-a0db-54ddb5ab8830@lucifer.local>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 9 Sep 2025 09:43:25 -0700
X-Gm-Features: AS18NWB56jIrhZDM4c-qSVZLOkH6X6dA_iJA_IjgEAuDFh14nG2Q8lK0Ov1ujjQ
Message-ID: <CAJuCfpEeUkta7UfN2qzSxHuohHnm7qXe=rEzVjfynhmn2WF0fA@mail.gmail.com>
Subject: Re: [PATCH 06/16] mm: introduce the f_op->mmap_complete, mmap_abort hooks
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, Guo Ren <guoren@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	"David S . Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Baoquan He <bhe@redhat.com>, 
	Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Dave Martin <Dave.Martin@arm.com>, 
	James Morse <james.morse@arm.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org, 
	linux-mm@kvack.org, ntfs3@lists.linux.dev, kexec@lists.infradead.org, 
	kasan-dev@googlegroups.com, Jason Gunthorpe <jgg@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 2:37=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Tue, Sep 09, 2025 at 11:26:21AM +0200, David Hildenbrand wrote:
> > > >
> > > > In particular, the mmap_complete() looks like another candidate for=
 letting
> > > > a driver just go crazy on the vma? :)
> > >
> > > Well there's only so much we can do. In an ideal world we'd treat VMA=
s as
> > > entirely internal data structures and pass some sort of opaque thing =
around, but
> > > we have to keep things real here :)
> >
> > Right, we'd pass something around that cannot be easily abused (like
> > modifying random vma flags in mmap_complete).
> >
> > So I was wondering if most operations that driver would perform during =
the
> > mmap_complete() could be be abstracted, and only those then be called w=
ith
> > whatever opaque thing we return here.
>
> Well there's 2 issues at play:
>
> 1. I might end up having to rewrite _large parts_ of kernel functionality=
 all of
>    which relies on there being a vma parameter (or might find that to be
>    intractable).
>
> 2. There's always the 'odd ones out' :) so there'll be some drivers that
>    absolutely do need to have access to this.
>
> But as I was writing this I thought of an idea - why don't we have someth=
ing
> opaque like this, perhaps with accessor functions, but then _give the abi=
lity to
> get the VMA if you REALLY have to_.
>
> That way we can handle both problems without too much trouble.
>
> Also Jason suggested generic functions that can just be assigned to
> .mmap_complete for instance, which would obviously eliminate the crazy
> factor a lot too.
>
> I'm going to refactor to try to put ONLY prepopulate logic in
> .mmap_complete where possible which fits with all of this.

Thinking along these lines, do you have a case when mmap_abort() needs
vm_private_data? I was thinking if VMA mapping failed, why would you
need vm_private_data to unwind prep work? You already have the context
pointer for that, no?

>
> >
> > But I have no feeling about what crazy things a driver might do. Just
> > calling remap_pfn_range() would be easy, for example, and we could abst=
ract
> > that.
>
> Yeah, I've obviously already added some wrappers for these.
>
> BTW I really really hate that STUPID ->vm_pgoff hack, if not for that, li=
fe
> would be much simpler.
>
> But instead now we need to specify PFN in the damn remap prepare wrapper =
in
> case of CoW. God.
>
> >
> > --
> > Cheers
> >
> > David / dhildenb
> >
>
> Cheers, Lorenzo
