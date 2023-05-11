Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B954C7EE2D
	for <linux-s390@archiver.kernel.org>; Thu, 11 May 2023 02:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjEKC6D (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 May 2023 22:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236036AbjEKC6B (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 10 May 2023 22:58:01 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ED15255
        for <linux-s390@vger.kernel.org>; Wed, 10 May 2023 19:57:59 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-b9e2b65d006so11900925276.3
        for <linux-s390@vger.kernel.org>; Wed, 10 May 2023 19:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683773878; x=1686365878;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VKY0MPg+ixVSR7jOZPK9uKssH+HTM4GRvqWKWUn/BFA=;
        b=A/8Yl5mLDDyzpMzxH/65tVA6ZiqBtbA3d9RA8fCNCX4cspZ3FSeBdW0oUC/QrOwu05
         JoxxoIZTWWZvG9sUA5Kt4j/mCk5PbrWXYCjVoAOE6DA24+iPz85mkYE73LNDr0oFWCdT
         rH/bRk56/wMHo6z0qHtG+YSqxp4dd4t3ZJ8DxDyJqTsMSx9i6fBtQEQ4PO2NHpeCsaUL
         CWzLaMlncwyqAXylxS2D1Zyo1qpYkgLrxXJlwsKj/b67fZ4WppqlP9S5HEb7GRAykDlw
         k/Vb5i8FWzhnGt6pe/zFYyUpDBBrPTmJLrRKIFY1WW7hoXogJGukSIZoffaAETEPY/4t
         xZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683773878; x=1686365878;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VKY0MPg+ixVSR7jOZPK9uKssH+HTM4GRvqWKWUn/BFA=;
        b=PLp5YVKhIcYAZKDFm3KGL5tKDJOk0zYqNq4bLyPTA9rQVEwcdx+AG8OimSseQ23tVj
         NIK6RaQobzpGLfDWu/EtTO01nKZp0xldQvzzbgAHvEaGyXQVIwXG8EGybcj6eLCJ2EC5
         q54ybzUaxkGaoL/xuRpRSHWDTC+KC+gjV42xpubXTm+QhXA4DTNXET/D8blYwkkMHhXU
         QvxW9TDNTaqtMZDvvXst0MP9+Ma7XQNCeCiEPr6FnDVDeb7vCcXtg7iTb93IldFK72em
         MRAzbVgb2VocWfOx7lSlTUosMrcob8sQH/UsCazbqzN1uPIZvTOEOTg3oU8dRbDbZQG2
         tIfg==
X-Gm-Message-State: AC+VfDz1nOEZcAfs2NZkuAjgohKH7E8TiOvK4akNYE68PlIIcsu3OV3I
        +rbta5VhrnibloS1pwfM8y8pvQ==
X-Google-Smtp-Source: ACHHUZ6C0n0sBeLY7gcn1OD5R2jloe8ods8pFVDt6dBMBTUUJpoOKztQObF61f5mEv/MRTTUjmAJWA==
X-Received: by 2002:a81:d54b:0:b0:55a:2102:1699 with SMTP id l11-20020a81d54b000000b0055a21021699mr20828006ywj.11.1683773877637;
        Wed, 10 May 2023 19:57:57 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q6-20020a0de706000000b0055a07e36659sm4496591ywe.145.2023.05.10.19.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 19:57:57 -0700 (PDT)
Date:   Wed, 10 May 2023 19:57:46 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        John David Anglin <dave.anglin@bell.net>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/23] m68k: allow pte_offset_map[_lock]() to fail
In-Reply-To: <CAMuHMdWb0SrEs=cDzKW1Ai2UywnnpZip4pk9mOkiVGivPpj8sg@mail.gmail.com>
Message-ID: <b4a5f11-68ee-7bba-b362-10ef7c9b956@google.com>
References: <77a5d8c-406b-7068-4f17-23b7ac53bc83@google.com> <237c8410-ce61-94c-4260-7318ad6a4f3@google.com> <CAMuHMdWb0SrEs=cDzKW1Ai2UywnnpZip4pk9mOkiVGivPpj8sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-840625160-1683773877=:9548"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-840625160-1683773877=:9548
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 10 May 2023, Geert Uytterhoeven wrote:

> Hi Hugh,
>=20
> Thanks for your patch!

And thank you for looking so quickly, Geert.

>=20
> On Wed, May 10, 2023 at 6:48=E2=80=AFAM Hugh Dickins <hughd@google.com> w=
rote:
> > In rare transient cases, not yet made possible, pte_offset_map() and
> > pte_offset_map_lock() may not find a page table: handle appropriately.
> >
> > Restructure cf_tlb_miss() with a pte_unmap() (previously omitted)
> > at label out, followed by one local_irq_restore() for all.
>=20
> That's a bug fix, which should be a separate patch?

No, that's not a bug fix for the current tree, since m68k does not
offer CONFIG_HIGHPTE, so pte_unmap() is never anything but a no-op
for m68k (see include/linux/pgtable.h).

But I want to change pte_unmap() to do something even without
CONFIG_HIGHPTE, so have to fix up any such previously harmless
omissions in this series first.

>=20
> >
> > Signed-off-by: Hugh Dickins <hughd@google.com>
>=20
>=20
> > --- a/arch/m68k/include/asm/mmu_context.h
> > +++ b/arch/m68k/include/asm/mmu_context.h
> > @@ -99,7 +99,7 @@ static inline void load_ksp_mmu(struct task_struct *t=
ask)
> >         p4d_t *p4d;
> >         pud_t *pud;
> >         pmd_t *pmd;
> > -       pte_t *pte;
> > +       pte_t *pte =3D NULL;
> >         unsigned long mmuar;
> >
> >         local_irq_save(flags);
> > @@ -139,7 +139,7 @@ static inline void load_ksp_mmu(struct task_struct =
*task)
> >
> >         pte =3D (mmuar >=3D PAGE_OFFSET) ? pte_offset_kernel(pmd, mmuar=
)
> >                                      : pte_offset_map(pmd, mmuar);
> > -       if (pte_none(*pte) || !pte_present(*pte))
> > +       if (!pte || pte_none(*pte) || !pte_present(*pte))
> >                 goto bug;
>=20
> If the absence of a pte is to become a non-abnormal case, it should
> probably jump to "end" instead, to avoid spamming the kernel log.

I don't think so (but of course it's hard for you to tell, without
seeing all completed series of series).  If pmd_none(*pmd) can safely
goto bug just above, and pte_none(*pte) goto bug here, well, the !pte
case is going to be stranger than either of those.

My understanding of this function, load_ksp_mmu(), is that it's dealing
at context switch with a part of userspace which very much needs to be
present: whatever keeps that from being swapped out or migrated at
present, will be sure to keep the !pte case away - we cannot steal its
page table just at random (and a THP on m68k would be surprising too).

Though there is one case I can think of which will cause !pte here,
and so goto bug: if the pmd entry has got corrupted, and counts as
pmd_bad(), which will be tested (and cleared) in pte_offset_map().
But it is okay to report a bug in that case.

I can certainly change this to goto end instead if you still prefer,
no problem; but I'd rather keep it as is, if only for me to be proved
wrong by you actually seeing spam there.

>=20
> >
> >         set_pte(pte, pte_mkyoung(*pte));
> > @@ -161,6 +161,8 @@ static inline void load_ksp_mmu(struct task_struct =
*task)
> >  bug:
> >         pr_info("ksp load failed: mm=3D0x%p ksp=3D0x08%lx\n", mm, mmuar=
);
> >  end:
> > +       if (pte && mmuar < PAGE_OFFSET)
> > +               pte_unmap(pte);
>=20
> Is this also a bugfix, not mentioned in the patch description?

I'm not sure whether you're referring to the pte_unmap() which we
already discussed above, or you're seeing something else in addition;
but I don't think there's a bugfix here, just a rearrangement because
we now want lots of cases to do the pte_unmap() and local_irq_restore().

Hugh

>=20
> >         local_irq_restore(flags);
> >  }
> >
>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20
> --=20
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>=20
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
---1463760895-840625160-1683773877=:9548--
