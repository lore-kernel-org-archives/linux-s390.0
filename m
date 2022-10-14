Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55827C433FE
	for <linux-s390@archiver.kernel.org>; Fri, 14 Oct 2022 15:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiJNPg5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbiJNPg4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Oct 2022 11:36:56 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDE017939D
        for <linux-s390@vger.kernel.org>; Fri, 14 Oct 2022 08:36:53 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id k2so11344384ejr.2
        for <linux-s390@vger.kernel.org>; Fri, 14 Oct 2022 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzAEfnL4mtMg/tM957Pkn44V+yKBMaEVMqeb7ERPvSM=;
        b=Vwp8oOPYW6e7d6nef2GP2ky9KZAOvc1qwLWuFGs50ZnWl3C9Ann06l9h0iRZQ5qZeA
         87yipSXi2rHdIBFH7tUxzOlBRyewSjdpas/gsBXBhDUtD8RD3KoaPifnShtEYQs+25kJ
         IC8am5svGeQe46khlknMrulPkd1nEjgO0W7bkYVIMTwQ04Ghlrr88Ams1UtkfFK9dK/T
         wIht5L2lLecN+EQgF2xhG+zy5bLrWQyqp15l7YOOpxyBWEluSbhFDMNd6zLl4C+MX9UH
         zRHuBXOd6GO7EYwmwGars9KCmyfXq/CMImsrqx5Pipfwl6aaxvcLyCJWurCHfigEaXYl
         JWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzAEfnL4mtMg/tM957Pkn44V+yKBMaEVMqeb7ERPvSM=;
        b=0NbLaI1oSE5rsGRd3OAmrPlid6Td2Iq0qiv0tOnGubjfebz2971Q4i8m9vIhp2iUiR
         Vak/h3ZhIx7lONLaYS0BzdmeHQ1JBHkkUgUcQqD3GdlftOolZRFthlqHSplxDNOCwTcE
         SnlnqFAVnThUD1Ojt1zMtnZIAMCZfYNGsttrLxY6jpU4EjqyQG4mP8dW1s0CGvGgaQ6V
         hFwCuSGlgRyr54vR7mbILEK2b6aU1rtv2q9aCYT+Dw0pLSVVC1QzdH0r4OVnL6JCUHR8
         z9NJV8GiekZvF9VWRsqwE0h+BnvkBKKZSuIOa5BeDoDltD9fHQrXR+f+emC7GxehRAmD
         x2Mw==
X-Gm-Message-State: ACrzQf1DU4IWDc2HTH/jfpY6COp4tsQgoQnMbQKPF6gRzGuK9fyS7D0W
        PXqMvkEo7Y+fWAgqqMCkD0btrQ==
X-Google-Smtp-Source: AMsMyM7QZN4NrFy81gnq4SFQEac+f8yeGdYJbivHQQC5q+N9x/v6JUR86aq87TBZ+2xorxeEuJNfhQ==
X-Received: by 2002:a17:907:2c44:b0:78d:4e67:ca5d with SMTP id hf4-20020a1709072c4400b0078d4e67ca5dmr4006358ejc.397.1665761811528;
        Fri, 14 Oct 2022 08:36:51 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b00779cde476e4sm1703326ejt.62.2022.10.14.08.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 08:36:51 -0700 (PDT)
Date:   Fri, 14 Oct 2022 17:36:49 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/cpuinfo: prevent warning when reading /proc/cpuinfo
Message-ID: <20221014153649.6yu7foo5j24s6pcf@kamzik>
References: <20221014142611.1145407-1-agordeev@linux.ibm.com>
 <CAAH8bW8Uvb-GzoZiPVEeNGQL-y1cF90sGs99_PRetmcpisF81Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH8bW8Uvb-GzoZiPVEeNGQL-y1cF90sGs99_PRetmcpisF81Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Oct 14, 2022 at 08:06:41AM -0700, Yury Norov wrote:
> On Fri, Oct 14, 2022 at 7:26 AM Alexander Gordeev
> <agordeev@linux.ibm.com> wrote:
> >
> > Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
> > started issuing warnings when reading /proc/cpuinfo and config
> > DEBUG_PER_CPU_MAPS is enabled. Avoid calling cpumask_next() with
> > the cpu index equal to nr_cpu_ids - 1 and ensure no warning is
> > generated.
> >
> > Link: https://lore.kernel.org/r/20221012081905.1800640-1-ajones@ventanamicro.com
> > Reported-by: Andrew Jones <ajones@ventanamicro.com>
> > Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> > ---
> >  arch/s390/kernel/processor.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
> > index a194611ba88c..908a0be900ea 100644
> > --- a/arch/s390/kernel/processor.c
> > +++ b/arch/s390/kernel/processor.c
> > @@ -334,6 +334,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
> >
> >  static inline void *c_update(loff_t *pos)
> >  {
> > +       if (*pos >= nr_cpu_ids)
> > +               return NULL;
> >         if (*pos)
> >                 *pos = cpumask_next(*pos - 1, cpu_online_mask);
> >         else
> 
> This silences the warning entirely. If you don't need it, I'd suggest
> using find_next_bit()
> instead. But from the discussion to similar patch, I think you need to
> allow nr_cpu_ids
> only:
>  +       if (*pos == nr_cpu_ids)
>  +               return NULL;

Yes, and I'll post my v3's with this change for x86 and riscv now.

Thanks,
drew
