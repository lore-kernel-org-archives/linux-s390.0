Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18160C433B4
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 23:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E853F6113D
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 23:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbhDOX3w (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Apr 2021 19:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237842AbhDOX3u (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 15 Apr 2021 19:29:50 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3ABC061574
        for <linux-s390@vger.kernel.org>; Thu, 15 Apr 2021 16:29:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id w8so10638186plg.9
        for <linux-s390@vger.kernel.org>; Thu, 15 Apr 2021 16:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=jw2PSbrXAEN39rMTtQwepRsUrzSF/PJDp6qJKD1maOQ=;
        b=Fni1JOOo4PrUzlzK7TjMF4v5KQ8JMEB8GQFvJdoCIs85gQ7hkEMknpG3xaXPhS80Fg
         xJbRmZBxuaLCaLsDL4AVpD5/12galNW2GkHBhD13nBI/qZ+kzKtFLFCZKRtePFqUO/Re
         Zz++4+ACyGOOamm7Y7acj4xF6H4JSsTKL7jUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jw2PSbrXAEN39rMTtQwepRsUrzSF/PJDp6qJKD1maOQ=;
        b=oiS52KgXqiVp4m/2yC4VEHVYuW3dHiEfovnbVSkuh2gTXvsduVSchlRE6JNoCrxQvU
         eeHomf7YYStnjJA5ZJQ5Gtziej4MuennsmBeSrE/+1No5cOlJiVnS+L/gn+Togp+PViE
         nZb1tpXHcOyDRmnt2Gl9iliRGt++j2RLQOMFpGC2pZpQWm8qKuYsXB9N4v0+gKqj2unK
         K68CIG6YtH0F6apDICaSbv0rte0G19zGOhw4QTwFQW2XHtWRzjqPZNuk/YdkGBRZtOvN
         Ogz/9dx8ogS7c8gOXRicjUT8EqqAmR52fmwg9GIAbGpHvbW9JeuUPKWfNOiEgNlj6mhc
         zekA==
X-Gm-Message-State: AOAM531JBzt7DTgMxU33IWGRQtxJnBr9Y9C7FclHd449FmOkVr5KMd79
        Yf9n/v/nattNvHfVg+WfQDfueQ==
X-Google-Smtp-Source: ABdhPJxSv6iVBSeJJdGrfMFvazb0EusrLGidlTGj83XpU/NnbzX7T+WOwAI5+RKJlavNfX48j0XS8Q==
X-Received: by 2002:a17:90a:6c88:: with SMTP id y8mr6713418pjj.38.1618529364161;
        Thu, 15 Apr 2021 16:29:24 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-3f8b-a64e-9a27-b872.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:3f8b:a64e:9a27:b872])
        by smtp.gmail.com with ESMTPSA id nv7sm3342006pjb.18.2021.04.15.16.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 16:29:23 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 4/5] mm: ptdump: Support hugepd table entries
In-Reply-To: <f41a177a0fd5a71db616e586a9ec5c51102c6656.1618506910.git.christophe.leroy@csgroup.eu>
References: <cover.1618506910.git.christophe.leroy@csgroup.eu> <f41a177a0fd5a71db616e586a9ec5c51102c6656.1618506910.git.christophe.leroy@csgroup.eu>
Date:   Fri, 16 Apr 2021 09:29:20 +1000
Message-ID: <87zgxzyvn3.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Christophe,

> Which hugepd, page table entries can be at any level
> and can be of any size.
>
> Add support for them.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  mm/ptdump.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/mm/ptdump.c b/mm/ptdump.c
> index 61cd16afb1c8..6efdb8c15a7d 100644
> --- a/mm/ptdump.c
> +++ b/mm/ptdump.c
> @@ -112,11 +112,24 @@ static int ptdump_pte_entry(pte_t *pte, unsigned long addr,
>  {
>  	struct ptdump_state *st = walk->private;
>  	pte_t val = ptep_get(pte);
> +	unsigned long page_size = next - addr;
> +	int level;
> +
> +	if (page_size >= PGDIR_SIZE)
> +		level = 0;
> +	else if (page_size >= P4D_SIZE)
> +		level = 1;
> +	else if (page_size >= PUD_SIZE)
> +		level = 2;
> +	else if (page_size >= PMD_SIZE)
> +		level = 3;
> +	else
> +		level = 4;
>  
>  	if (st->effective_prot)
> -		st->effective_prot(st, 4, pte_val(val));
> +		st->effective_prot(st, level, pte_val(val));
>  
> -	st->note_page(st, addr, 4, pte_val(val), PAGE_SIZE);
> +	st->note_page(st, addr, level, pte_val(val), page_size);

It seems to me that passing both level and page_size is a bit redundant,
but I guess it does reduce the impact on each arch's code?

Kind regards,
Daniel

>  
>  	return 0;
>  }
> -- 
> 2.25.0
