Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E82C43461
	for <linux-s390@archiver.kernel.org>; Mon, 17 May 2021 19:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26A3E61285
	for <linux-s390@archiver.kernel.org>; Mon, 17 May 2021 19:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbhEQTlb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 17 May 2021 15:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbhEQTlT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 17 May 2021 15:41:19 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55952C061573;
        Mon, 17 May 2021 12:40:02 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id k10so10900722ejj.8;
        Mon, 17 May 2021 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PULfJfJ5qOKU+8g4uSUAsIkjuQOIRxgWrBAdTdPI+Uk=;
        b=EhQR8/b83ck5P+6wYArlBXOyeYwBcawOfYl3SE4koUo01Qv3x6aD3I8dfoh6E5wNqE
         VT1EFIuhzab49ldRdl+//elcb/j1fZ4RlFZf3Fn7dPiq6JAnuKK4brdgHlFpNDiR+ltz
         W1uI9nqHSdF0CT2sdXz9P8hYHVNFEPrJPnlNh/SE6S9Ysk3CXQMQy4J3OIYrAfkWlXSW
         tl84LyfrfgNTvo9Ws7lyGKaqKEHOc/PIWgKIGWLgkUp+EGPpbTRJ9PGot5HuojNqSn+j
         cEdQOWOi3iZMbULIx9AgmU8RYMx+GnEpR2EbQORUaHaQjlWX0jx+CdOjKC8eVSrrmO+h
         ivNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PULfJfJ5qOKU+8g4uSUAsIkjuQOIRxgWrBAdTdPI+Uk=;
        b=DsgDVBh/wAiJ9HciW3Zeldidk5tEK9U+EdepIDFpustn6D4Nxy9LPL4Vyr3qjeiOfx
         TlEUJijIrTxDlrq+ySAigvAO6QwBlQhucdeUU7uLasl+OsjhvIP+f0BY3Sma3gnzzcNN
         n+1aSk2K/rEgzF8Dl/Q6qJLpyLFxh8AtGzzPNiXQDjysbz0HZrl+ZOqc4zwdA0k8PljO
         bF7r6D1wB/m+2+UtvdJc6B4XSLzqwj6pEZbPOKULJnJjK47eVy6QOFuSjJj7KWVdM/0w
         tCVpeP2mu0gY9dGinpqIKNLefkbh5YIcMoxGbFqaR+hsPrdbcIcgDenMr3GVWpiNdrME
         GA7A==
X-Gm-Message-State: AOAM532o0qf76NyNKOs349sM3DdTNngUlfsQj56oaBVLKIsGI4DjVwpD
        H7oiMDam40YxwzONY0JzsSkpQecw+5ZtiE/QqA0=
X-Google-Smtp-Source: ABdhPJzaAbYrt1TFzLdEhuKWdbzFAAdK50AJVifrk1nYLfYsCxp64s3Jz5HRDhIUivg/vdrL69hneDrJ557W4A68GaM=
X-Received: by 2002:a17:906:11c8:: with SMTP id o8mr1542940eja.499.1621280401126;
 Mon, 17 May 2021 12:40:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210413212416.3273-1-shy828301@gmail.com> <20210413212416.3273-2-shy828301@gmail.com>
 <20210517150922.GU3672@suse.de>
In-Reply-To: <20210517150922.GU3672@suse.de>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 17 May 2021 12:39:49 -0700
Message-ID: <CAHbLzkoj6Vn_jjWrn99oio1Oi+D4CHw9Z+6Wy4Squz-jCh2DKw@mail.gmail.com>
Subject: Re: [v2 PATCH 1/7] mm: memory: add orig_pmd to struct vm_fault
To:     Mel Gorman <mgorman@suse.de>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, linux-s390@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, May 17, 2021 at 8:09 AM Mel Gorman <mgorman@suse.de> wrote:
>
> On Tue, Apr 13, 2021 at 02:24:10PM -0700, Yang Shi wrote:
> > Add orig_pmd to struct vm_fault so the "orig_pmd" parameter used by huge page
> > fault could be removed, just like its PTE counterpart does.
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
> >
> > <SNIP>
> >
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 25b9041f9925..9c5856f8cc81 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -547,6 +547,9 @@ struct vm_fault {
> >                                        * the 'address'
> >                                        */
> >       pte_t orig_pte;                 /* Value of PTE at the time of fault */
> > +     pmd_t orig_pmd;                 /* Value of PMD at the time of fault,
> > +                                      * used by PMD fault only.
> > +                                      */
> >
> >       struct page *cow_page;          /* Page handler may use for COW fault */
> >       struct page *page;              /* ->fault handlers should return a
>
> Could this be a union?

Do you mean orig_pte and orig_pmd, or cow_page and page? I think
orig_pte and orig_pmd could be union, I don't see that they are used
at the same time from vm_fault.

But cow_page and page can't since do_cow_fault() needs copy data from
page to cow_page.

>
> --
> Mel Gorman
> SUSE Labs
