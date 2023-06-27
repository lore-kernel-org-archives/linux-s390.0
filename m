Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130BEEB64DA
	for <linux-s390@archiver.kernel.org>; Tue, 27 Jun 2023 03:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjF0DCC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 26 Jun 2023 23:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjF0DCB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 26 Jun 2023 23:02:01 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4ED110C
        for <linux-s390@vger.kernel.org>; Mon, 26 Jun 2023 20:01:59 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-4007b5bafceso92111cf.1
        for <linux-s390@vger.kernel.org>; Mon, 26 Jun 2023 20:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687834919; x=1690426919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dubf60A5K0NzNIP7xjDZqZozn3KVMPgogoe8ASnGAZg=;
        b=PDCiQ+OMm+ZYhItlBm9CJOAjt3arCBaIPefCRV+cRGlKtmTkgJuKH7kAOKyAbCQJzL
         BCdmcPnotA0n4v9avoXLaITUGQgCoZm0BKEirmoOrgdrv8GGmlOoIokTT8s6lPxZIxSr
         eePAgRbrFZroffClytmh37SqL9NSTT2FHr7ZtV7QGlDkmk6KAHHYcWPVhpXKOVGr8Tr7
         Xvj/gX5em4lLmUFwa2ra0Yw/kozeJB+nK/9f/BgOWwSt6jpUIMH8XIdAtL1yeNznNHSz
         i5guqpOz9eCzUhqIk6gXiuPNKiSeUkePu5MwafnJai+nUz1Z0jF1fVOyqLoOaTDwUabC
         0MkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687834919; x=1690426919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dubf60A5K0NzNIP7xjDZqZozn3KVMPgogoe8ASnGAZg=;
        b=dciBJMId6eOa09uOByN3abTYVkJrzFSeQheXqAjYSOpJKXoHNk/RDuIm2g6f63wJ+0
         /8QpQJ3Y45bnCy0VpcV32Wbe9SmJoh7h5nIW0nzTAI0LCTSFOnlESXpMo6eMm5gHGfnD
         +9K1O7MvnSGrtYdqVIOBTCM408uh0zm8Tk+RGBpNPrlQbzERAhPUrqVpfoIMTvuxssI9
         izra6ZTnyQuUeqmWK8p4kibTktdAFFh8qPf73rF7rlb5oz0H7ubNHYkgOcqlDkU2rb8z
         TDa9CP8Mjo2guIfedDSWEzzeq68g8MsQkbnNXrgsAcDdzpMnGjDTp1bd5SgeqiLl6uMS
         k6Pw==
X-Gm-Message-State: AC+VfDw4yl/fJ2hGofRpRasA16TvIoYun9CDKLWlr19tR/GgJjgFpVJl
        aF1h1tZ1tNAB7wYTA5S93AnkIgPXfkBvW/nVFz965A==
X-Google-Smtp-Source: ACHHUZ5kSZ0VxsoAPI4/7ibeP7x8z7uQzBQxZXwrk6r4ft671XydiY3Jw1m0BE4SFdIns2MuaVANBIMzMf5b0M5GeEY=
X-Received: by 2002:a05:622a:1a0e:b0:3f9:a73b:57bb with SMTP id
 f14-20020a05622a1a0e00b003f9a73b57bbmr69998qtb.4.1687834918926; Mon, 26 Jun
 2023 20:01:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230626171430.3167004-1-ryan.roberts@arm.com> <20230626171430.3167004-11-ryan.roberts@arm.com>
In-Reply-To: <20230626171430.3167004-11-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 26 Jun 2023 21:01:22 -0600
Message-ID: <CAOUHufarua_JmnTu5NM-W3K4Togw+24F=Pf0HU0ZOjuwbRMC0A@mail.gmail.com>
Subject: Re: [PATCH v1 10/10] mm: Allocate large folios for anonymous memory
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

On Mon, Jun 26, 2023 at 11:15=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> With all of the enabler patches in place, modify the anonymous memory
> write allocation path so that it opportunistically attempts to allocate
> a large folio up to `max_anon_folio_order()` size (This value is
> ultimately configured by the architecture). This reduces the number of
> page faults, reduces the size of (e.g. LRU) lists, and generally
> improves performance by batching what were per-page operations into
> per-(large)-folio operations.
>
> If CONFIG_LARGE_ANON_FOLIO is not enabled (the default) then
> `max_anon_folio_order()` always returns 0, meaning we get the existing
> allocation behaviour.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  mm/memory.c | 159 +++++++++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 144 insertions(+), 15 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index a8f7e2b28d7a..d23c44cc5092 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3161,6 +3161,90 @@ static inline int max_anon_folio_order(struct vm_a=
rea_struct *vma)
>                 return CONFIG_LARGE_ANON_FOLIO_NOTHP_ORDER_MAX;
>  }
>
> +/*
> + * Returns index of first pte that is not none, or nr if all are none.
> + */
> +static inline int check_ptes_none(pte_t *pte, int nr)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < nr; i++) {
> +               if (!pte_none(ptep_get(pte++)))
> +                       return i;
> +       }
> +
> +       return nr;
> +}
> +
> +static int calc_anon_folio_order_alloc(struct vm_fault *vmf, int order)

As suggested previously in 03/10, we can leave this for later.
