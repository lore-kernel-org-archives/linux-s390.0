Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3011EB64D9
	for <linux-s390@archiver.kernel.org>; Tue, 27 Jun 2023 03:48:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjF0DsC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Jun 2023 23:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjF0DrY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 26 Jun 2023 23:47:24 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2A12129
        for <linux-s390@vger.kernel.org>; Mon, 26 Jun 2023 20:45:58 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bff0beb2d82so4042412276.2
        for <linux-s390@vger.kernel.org>; Mon, 26 Jun 2023 20:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687837558; x=1690429558;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fjlZBX1qjNq+jedwRQxK6KrAOY0dDujar0I40GYxC6M=;
        b=2JuhGNEigaQm6EX1WfiTfYhdUhBPWzJ9vBrcOcHoTp/n19ffj9N3+WygEtVr5u+MEz
         QQdvBU4fbaVlF6XHGAbbN/tfQQT0diWv6pZWwJZrRGFoZ96iIsZB8+gV6aSK1Dxo67Mx
         n/UEnMIgELFsCsjD92duBZrQIAZCDCY6LZLPJk7cC9ULIxFWA2RTz+ztTQzGNJoP3gN2
         fFG6Fdg0eY/HiR5Ocms+Ek1rqz/iQUJRsj0Sc685XSZZpgly57bBLM+m99ijJH9c5KD3
         UtzkTWrIhIpWtC0z6Sq/aA2AGN4l0SYlQ1X3FbvES00xQsKSVpz/tr/YADcVhQbGzapK
         HxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687837558; x=1690429558;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fjlZBX1qjNq+jedwRQxK6KrAOY0dDujar0I40GYxC6M=;
        b=Qg4d67l2KQHOQDuJuhFc2NRy7n+b8DuCyQQFeAO+vpI/E70jFbL4YeSoNcNLAUVJgl
         oLV3npYBB9E6kH/FWCMlQbiP+PdR0Ncp3MrIUYnM1Rcps1lR0T4I+uc+gDI2mJX0jvCK
         l1ZkT6+gCv6jg5ApOcw98tmPzPx+kCmTc8m+rYCxg+0b8Q4AqYMiN1sONuY/3W1blpz6
         HAPGj+Bu3I+SxPm66JRJv2aQpStRBGrvCz69lrgnyp+kq5Xq2SkaQOP+0jJDnW+ZT69u
         9F+9GQy1AoOimuBfJfCLTyP6rycYA8r3lACpXjH2V3b7IgVFyGmYV1O0oZNBpW8vBn4M
         zphw==
X-Gm-Message-State: AC+VfDxfGQzOLUvjuVAqS6aPzyCfAky0EENnJ/lbXFMLT/G3CjkMuLdM
        G3ssqWQPk55ocUgI/0xS8ijwsg==
X-Google-Smtp-Source: ACHHUZ5JzT31gqd567F7h8S6QH8fnxlZlLWgCOYb3xkxgFPz3x+ANfgoNsHVzebn6Vqdj0bQfyydHw==
X-Received: by 2002:a25:8210:0:b0:c13:fdce:7691 with SMTP id q16-20020a258210000000b00c13fdce7691mr7429365ybk.19.1687837557779;
        Mon, 26 Jun 2023 20:45:57 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id e134-20020a25698c000000b00bb1445a4069sm1468618ybc.24.2023.06.26.20.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 20:45:57 -0700 (PDT)
Date:   Mon, 26 Jun 2023 20:45:49 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Alexander Gordeev <agordeev@linux.ibm.com>
cc:     Hugh Dickins <hughd@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: prospective 13/12 s390 pgtable_list patch
In-Reply-To: <ZJmtJEj/kgGS7B0E@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Message-ID: <a97fc4bc-53b7-3c5b-1c5-c19d2869ec4f@google.com>
References: <a69a26c0-ec93-3ad-a443-6655b5e49df2@google.com> <ZJVl7ZJiborhmtYh@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com> <232e20a5-ef6-41cf-4073-92fcb3a01453@google.com> <ZJmtJEj/kgGS7B0E@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-768662770-1687837557=:2578"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-768662770-1687837557=:2578
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 26 Jun 2023, Alexander Gordeev wrote:
> On Fri, Jun 23, 2023 at 01:53:43PM -0700, Hugh Dickins wrote:
> > > Anyway, that is just another option and I will try your patch.
> >=20
> > Thank you, please do, if you have the time: my series does need some
> > kind of s390 solution, depending on whatever s390 has in its tree at
> > the time: for now I should at least be showing the 13/12 (preferably
> > known to build and appearing to work!), even if all it does is help
> > people to say "no, that's too much".
>=20
> Hi Hugh,
>=20
> I took a bit different approach to run it: with and withough HH bits
> in play.
>=20
> IOW (if I am not mistaken) without the three patch serieses these two
> patches on top of v6.4-rc5 alone still should manage page allocation,
> as if pte_free_defer() does not exist/never get called:
>=20
> =09s390: add pte_free_defer() for pgtables sharing page
> =09prospective 13/12 s390 pgtable_list patch

That was a good idea, to try the "bare bones" first.  Yes, I think that
should work okay: with no actual dependence on the preceding patches.

>=20
> These patches appear to work (aka survive LTP MM tests).

And that is very good news, thank you (I was expecting I'd at least
have done some silly typo like last time).

>=20
> The next step would be to try the three serieses on top of v6.4-rc5 plus
> patch 13/12, as you intended:
>=20
> https://lore.kernel.org/linux-mm/77a5d8c-406b-7068-4f17-23b7ac53bc83@goog=
le.com/

There's maybe no difference that matters, but that was the v1 series: v2 wa=
s
https://lore.kernel.org/linux-mm/a4963be9-7aa6-350-66d0-2ba843e1af44@google=
=2Ecom/
series of 23 posted on 2023-06-08.

> https://lore.kernel.org/linux-mm/68a97fbe-5c1e-7ac6-72c-7b9c6290b370@goog=
le.com/

There's maybe no difference that matters, but that was the v1 series: v2 wa=
s
https://lore.kernel.org/linux-mm/c1c9a74a-bc5b-15ea-e5d2-8ec34bc921d@google=
=2Ecom/
series of 32 posted on 2023-06-08.

> https://lore.kernel.org/linux-mm/54cb04f-3762-987f-8294-91dafd8ebfb0@goog=
le.com

Right.

> https://lore.kernel.org/r/a69a26c0-ec93-3ad-a443-6655b5e49df2@google.com

Right.

>=20
> I had to manually tweak this one with a fuzz in order to circumvent 'git =
am' error:
> [PATCH v2 28/32] mm/memory: allow pte_offset_map[_lock]() to fail: fix
>=20
> But in the end it still does not compile for me:

I think perhaps you missed out the actual
[PATCH v2 28/32] mm/memory: allow pte_offset_map[_lock]() to fail
(oh, not exactly, you were working with v1 there) and tried to apply
[PATCH v2 28/32 fix] mm/memory: allow pte_offset_map[_lock]() to fail: fix
instead of it; whereas the "fix" patch is a cumulative patch on top of the
missed one (and the "fix" patch is not at all important for your testing,
since update_mmu_tlb() is a no-op on s390).

(There was other pfaffing around on PATCH v2 28/32, but that was
about applying it to akpm's tree at the time: v6.4-rc5 no problem.)

>=20
> mm/memory.c: In function =E2=80=98zap_pmd_range=E2=80=99:
> mm/memory.c:1561:21: error: implicit declaration of function =E2=80=98pmd=
_none_or_trans_huge_or_clear_bad=E2=80=99 [-Werror=3Dimplicit-function-decl=
aration]
>  1561 |                 if (pmd_none_or_trans_huge_or_clear_bad(pmd))
>       |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   CC      fs/btrfs/dev-replace.o
> In file included from ./include/linux/build_bug.h:5,
>                  from ./include/linux/container_of.h:5,
>                  from ./include/linux/list.h:5,
>                  from ./include/linux/smp.h:12,
>                  from ./include/linux/kernel_stat.h:5,
>                  from mm/memory.c:42:
> mm/memory.c: In function =E2=80=98do_anonymous_page=E2=80=99:
> mm/memory.c:4058:22: error: implicit declaration of function =E2=80=98pmd=
_trans_unstable=E2=80=99; did you mean =E2=80=98pud_trans_unstable=E2=80=99=
? [-Werror=3Dimplicit-function-declaration]
>  4058 |         if (unlikely(pmd_trans_unstable(vmf->pmd)))
>       |                      ^~~~~~~~~~~~~~~~~~
> ./include/linux/compiler.h:77:45: note: in definition of macro =E2=80=98u=
nlikely=E2=80=99
>    77 | # define unlikely(x)    __builtin_expect(!!(x), 0)
>       |                                             ^
>   CC      fs/xfs/xfs_iops.o
> mm/memory.c: In function =E2=80=98finish_fault=E2=80=99:
> mm/memory.c:4388:13: error: implicit declaration of function =E2=80=98pmd=
_devmap_trans_unstable=E2=80=99; did you mean =E2=80=98pud_trans_unstable=
=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>  4388 |         if (pmd_devmap_trans_unstable(vmf->pmd))
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>       |             pud_trans_unstable
>=20
>=20
> Could you please let me know if I am missing something?

I think, start again with the v2 of each of the three series on v6.4-rc5,
including the v2 28/32, and I expect that to work out fine.

What you already tested above has achieved a lot: since my changes left
pte_free_defer() and page_table_free_rcu() sharing __tlb_remove_table(),
so page_table_free_rcu() would already be exercising that list_add().

But you may have difficulty actually exercising the pte_free_defer().
Maybe hack in a counter (I tend to hack on BALLOON events in vmstat,
since normally those would be 0 for me) to check whether running LTP
is actually exercising those paths - if not, we'll devise something more.

Thanks,
Hugh
---1463760895-768662770-1687837557=:2578--
