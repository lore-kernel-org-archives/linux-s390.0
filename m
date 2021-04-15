Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB78C433ED
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 22:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1DD661103
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 22:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237341AbhDOWoI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Apr 2021 18:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237292AbhDOWoF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 15 Apr 2021 18:44:05 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F45C061574
        for <linux-s390@vger.kernel.org>; Thu, 15 Apr 2021 15:43:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id b8-20020a17090a5508b029014d0fbe9b64so15227055pji.5
        for <linux-s390@vger.kernel.org>; Thu, 15 Apr 2021 15:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=JY3LY8etXyosEeu5nfWlhvzebGDT/edrkrlKplV2R0Q=;
        b=LGwG/jXjcqstX7vCLunH2tlSTh6FEg3VqmVYhhwaWMbz1gRpN9Dc+pKMBttZG4F2eH
         +nk8aBQ2fPJnJhVZ2Nv5ytsKTlagBaosP37szFwCRj8Ib0f+ZQBXZ6lPne4jFGq86Bs7
         Yl/AWNZNO+DwuQ/A/1FVG7uXMXFQ0Bg71mqpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JY3LY8etXyosEeu5nfWlhvzebGDT/edrkrlKplV2R0Q=;
        b=fXLp+NiXCFhu6nHl1nRJAcl9MJYr+rF1RUbwE1KA88+jUYRjkbTBkGuy5BZxa6muR+
         KigeoO0eV0C9eftP2hpIaPjLKFzgDtefLKXnj2HBgMmFAq9y+rOGDuB0B8K7UEVRLgQ6
         mmT7eEbRFVKWxAT9sygsJs18Rxbf6lBePxUht+sSg+Cyp5taT8msgX5NCEBKLgFz5ugA
         3+BQRzPpagkfuELH8Za4Sl4JO8OXzL9jQU8NgfAeuCaPRU3DD8naspm0VZklw28VXDQt
         9Un/TGY6VLfkB/iyg8+SiLb08dcfU5WhSz1wlu1Aaf6eBW2yd00+Mij56E7VOUK6wEOK
         azNg==
X-Gm-Message-State: AOAM532QgCMdi+mLcoFWDdf3pyRaAVhKytU4ga8s57EAL11dTmhlVGxe
        id/iRqtxAMaYVU7EOEoXh2NTCA==
X-Google-Smtp-Source: ABdhPJyqfJG8J3NRw4PtXWUZy53AS96UfvtUYllUApPaRqPEmjx1X+9e6E5OLIVUTnR/j6EwfW2Icg==
X-Received: by 2002:a17:90a:17a3:: with SMTP id q32mr6358434pja.224.1618526621918;
        Thu, 15 Apr 2021 15:43:41 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-3f8b-a64e-9a27-b872.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:3f8b:a64e:9a27:b872])
        by smtp.gmail.com with ESMTPSA id h22sm2980650pfn.55.2021.04.15.15.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 15:43:41 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 1/5] mm: pagewalk: Fix walk for hugepage tables
In-Reply-To: <733408f48b1ed191f53518123ee6fc6d42287cc6.1618506910.git.christophe.leroy@csgroup.eu>
References: <cover.1618506910.git.christophe.leroy@csgroup.eu> <733408f48b1ed191f53518123ee6fc6d42287cc6.1618506910.git.christophe.leroy@csgroup.eu>
Date:   Fri, 16 Apr 2021 08:43:38 +1000
Message-ID: <877dl3184l.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Christophe,

> Pagewalk ignores hugepd entries and walk down the tables
> as if it was traditionnal entries, leading to crazy result.
>
> Add walk_hugepd_range() and use it to walk hugepage tables.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  mm/pagewalk.c | 54 +++++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 48 insertions(+), 6 deletions(-)
>
> diff --git a/mm/pagewalk.c b/mm/pagewalk.c
> index e81640d9f177..410a9d8f7572 100644
> --- a/mm/pagewalk.c
> +++ b/mm/pagewalk.c
> @@ -58,6 +58,32 @@ static int walk_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
>  	return err;
>  }
>  
> +static int walk_hugepd_range(hugepd_t *phpd, unsigned long addr,
> +			     unsigned long end, struct mm_walk *walk, int pdshift)
> +{
> +	int err = 0;
> +#ifdef CONFIG_ARCH_HAS_HUGEPD
> +	const struct mm_walk_ops *ops = walk->ops;
> +	int shift = hugepd_shift(*phpd);
> +	int page_size = 1 << shift;
> +
> +	if (addr & (page_size - 1))
> +		return 0;
> +
> +	for (;;) {
> +		pte_t *pte = hugepte_offset(*phpd, addr, pdshift);
> +
> +		err = ops->pte_entry(pte, addr, addr + page_size, walk);
> +		if (err)
> +			break;
> +		if (addr >= end - page_size)
> +			break;
> +		addr += page_size;
> +	}

Initially I thought this was a somewhat unintuitive way to structure
this loop, but I see it parallels the structure of walk_pte_range_inner,
so I think the consistency is worth it.

I notice the pte walking code potentially takes some locks: does this
code need to do that?

arch/powerpc/mm/hugetlbpage.c says that hugepds are protected by the
mm->page_table_lock, but I don't think we're taking it in this code.

> +#endif
> +	return err;
> +}
> +
>  static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  			  struct mm_walk *walk)
>  {
> @@ -108,7 +134,10 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  				goto again;
>  		}
>  
> -		err = walk_pte_range(pmd, addr, next, walk);
> +		if (is_hugepd(__hugepd(pmd_val(*pmd))))
> +			err = walk_hugepd_range((hugepd_t *)pmd, addr, next, walk, PMD_SHIFT);
> +		else
> +			err = walk_pte_range(pmd, addr, next, walk);
>  		if (err)
>  			break;
>  	} while (pmd++, addr = next, addr != end);
> @@ -157,7 +186,10 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>  		if (pud_none(*pud))
>  			goto again;
>  
> -		err = walk_pmd_range(pud, addr, next, walk);
> +		if (is_hugepd(__hugepd(pud_val(*pud))))
> +			err = walk_hugepd_range((hugepd_t *)pud, addr, next, walk, PUD_SHIFT);
> +		else
> +			err = walk_pmd_range(pud, addr, next, walk);

I'm a bit worried you might end up calling into walk_hugepd_range with
ops->pte_entry == NULL, and then jumping to 0.

static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
			  struct mm_walk *walk)
{
...
        pud = pud_offset(p4d, addr);
	do {
                ...
                if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
		    walk->action == ACTION_CONTINUE ||
		    !(ops->pmd_entry || ops->pte_entry)) <<< THIS CHECK
			continue;
                ...
		if (is_hugepd(__hugepd(pud_val(*pud))))
			err = walk_hugepd_range((hugepd_t *)pud, addr, next, walk, PUD_SHIFT);
		else
			err = walk_pmd_range(pud, addr, next, walk);
		if (err)
			break;
	} while (pud++, addr = next, addr != end);

walk_pud_range will proceed if there is _either_ an ops->pmd_entry _or_
an ops->pte_entry, but walk_hugepd_range will call ops->pte_entry
unconditionally.

The same issue applies to walk_{p4d,pgd}_range...

Kind regards,
Daniel
