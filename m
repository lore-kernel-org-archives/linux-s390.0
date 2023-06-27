Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E56AEB64DD
	for <linux-s390@archiver.kernel.org>; Tue, 27 Jun 2023 05:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjF0Fac (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 27 Jun 2023 01:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjF0Faa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 27 Jun 2023 01:30:30 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21296D9
        for <linux-s390@vger.kernel.org>; Mon, 26 Jun 2023 22:30:27 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4007b5bafceso112971cf.1
        for <linux-s390@vger.kernel.org>; Mon, 26 Jun 2023 22:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687843826; x=1690435826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr6z7HXoBtRJiy9wIGxM4+Vh8ji4UZ7Pb/0A3wtEW+4=;
        b=RVa8Qm3kb8eoPf1kUKXDt9afcKa8JJGNOR1UFa/0AXvcyyeUBXp0NPK1D2+mSv1Sh5
         rpQwalJ7ERXwii22vOhV4jdreZ71bDgoFL91oi5ZvAytI2TnTqKdZwsJJQksiPAb9F5A
         eMtWcHbSMLPm/8/NAY764PCtLSzNEpaHonyQA9ibN2YB1nec+NhxYXg3DPSBci/Mieiy
         hfXmyBnF32aUNEdMMETSpTgoQF29B/RzDOVAEaK0wjkiw/1dwDOIrB71dOGzSLXH2WRw
         abdGK1RCBPpBQm75z0N+Eb1oHSROhMs00hs7GqWlUPqWns8MaEPXjUrfpNiqrC14TiiP
         ftdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687843826; x=1690435826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tr6z7HXoBtRJiy9wIGxM4+Vh8ji4UZ7Pb/0A3wtEW+4=;
        b=dh4dJ76wDPfp83j8zFx3h/3pGgROEeSh3Lr5XeB21hcAQigXJ/Sy2WhWLuwEEXkoGE
         s/cIuLKWEApjKVOyH/+X8PKYiVya59kZnuWMHz66MVukebh/6tWFihe/pOT0kqTAvN+E
         9fOmusyNZd+FvzB71usmKgRYuu0fhXyZ62M63xv53upgiHbsYOx6RvstFVjUa7Xj2guD
         HWLGKAyh9VzwkPl5kGq2Bx0ZkfJK1Jog9mGF+HlxsOm80pKCUX80lMvYEq3IFqtDdDp6
         O4kf4z/h/kDIx0Q6zUF3gn8ebVINqWrgxUOJglRIjHKjx1CDd0vdQmY8FcpDL5pbbLsF
         b8Bg==
X-Gm-Message-State: AC+VfDwz2sAwvkwOxWzLSaciP2BIkRi5rpU0w75h78bwFIlTUEGMVdih
        fspNRRk3x43IxA21VthfapwxcK9uzmD828NSalJ3WMezPREgGPQQplEIQQ==
X-Google-Smtp-Source: ACHHUZ53Gqj9pbs/heeF8njdErsrbiCtEuLOgb4nbpjNe6JZUe+y5NpTAJ4tEKixwEP+mIc66585aRjMV7mzdReURHY=
X-Received: by 2002:ac8:5708:0:b0:3f3:75c2:7466 with SMTP id
 8-20020ac85708000000b003f375c27466mr100849qtw.8.1687843826024; Mon, 26 Jun
 2023 22:30:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com>
 <20230626171430.3167004-4-ryan.roberts@arm.com> <CAOUHufZKM+aS_hYQ5nDUHh74UQwWipJ27Na5Sw4n+RDqnwyWHA@mail.gmail.com>
In-Reply-To: <CAOUHufZKM+aS_hYQ5nDUHh74UQwWipJ27Na5Sw4n+RDqnwyWHA@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 26 Jun 2023 23:29:49 -0600
Message-ID: <CAOUHufZeFTjzO6nSFz7Y=5rBGPzY+_eeN3f8W+g0u6AqosdmuQ@mail.gmail.com>
Subject: Re: [PATCH v1 03/10] mm: Introduce try_vma_alloc_movable_folio()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 26, 2023 at 8:34=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Mon, Jun 26, 2023 at 11:14=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.c=
om> wrote:
> >
> > Opportunistically attempt to allocate high-order folios in highmem,
> > optionally zeroed. Retry with lower orders all the way to order-0, unti=
l
> > success. Although, of note, order-1 allocations are skipped since a
> > large folio must be at least order-2 to work with the THP machinery. Th=
e
> > user must check what they got with folio_order().
> >
> > This will be used to oportunistically allocate large folios for
> > anonymous memory with a sensible fallback under memory pressure.
> >
> > For attempts to allocate non-0 orders, we set __GFP_NORETRY to prevent
> > high latency due to reclaim, instead preferring to just try for a lower
> > order. The same approach is used by the readahead code when allocating
> > large folios.
> >
> > Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> > ---
> >  mm/memory.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 367bbbb29d91..53896d46e686 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3001,6 +3001,39 @@ static vm_fault_t fault_dirty_shared_page(struct=
 vm_fault *vmf)
> >         return 0;
> >  }
> >
> > +static inline struct folio *vma_alloc_movable_folio(struct vm_area_str=
uct *vma,
> > +                               unsigned long vaddr, int order, bool ze=
roed)
> > +{
> > +       gfp_t gfp =3D order > 0 ? __GFP_NORETRY | __GFP_NOWARN : 0;
> > +
> > +       if (zeroed)
> > +               return vma_alloc_zeroed_movable_folio(vma, vaddr, gfp, =
order);
> > +       else
> > +               return vma_alloc_folio(GFP_HIGHUSER_MOVABLE | gfp, orde=
r, vma,
> > +                                                               vaddr, =
false);
> > +}
> > +
> > +/*
> > + * Opportunistically attempt to allocate high-order folios, retrying w=
ith lower
> > + * orders all the way to order-0, until success. order-1 allocations a=
re skipped
> > + * since a folio must be at least order-2 to work with the THP machine=
ry. The
> > + * user must check what they got with folio_order(). vaddr can be any =
virtual
> > + * address that will be mapped by the allocated folio.
> > + */
> > +static struct folio *try_vma_alloc_movable_folio(struct vm_area_struct=
 *vma,
> > +                               unsigned long vaddr, int order, bool ze=
roed)
> > +{
> > +       struct folio *folio;
> > +
> > +       for (; order > 1; order--) {
> > +               folio =3D vma_alloc_movable_folio(vma, vaddr, order, ze=
roed);
> > +               if (folio)
> > +                       return folio;
> > +       }
> > +
> > +       return vma_alloc_movable_folio(vma, vaddr, 0, zeroed);
> > +}
>
> I'd drop this patch. Instead, in do_anonymous_page():
>
>   if (IS_ENABLED(CONFIG_ARCH_WANTS_PTE_ORDER))
>     folio =3D vma_alloc_zeroed_movable_folio(vma, addr,
> CONFIG_ARCH_WANTS_PTE_ORDER))
>
>   if (!folio)
>     folio =3D vma_alloc_zeroed_movable_folio(vma, addr, 0);

I meant a runtime function arch_wants_pte_order() (Its default
implementation would return 0.)
