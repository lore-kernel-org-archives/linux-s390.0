Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B5CC433FE
	for <linux-s390@archiver.kernel.org>; Fri, 14 Oct 2022 15:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiJNPGz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 14 Oct 2022 11:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiJNPGy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 14 Oct 2022 11:06:54 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5276D1D3740
        for <linux-s390@vger.kernel.org>; Fri, 14 Oct 2022 08:06:53 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id h3so5174463vsa.4
        for <linux-s390@vger.kernel.org>; Fri, 14 Oct 2022 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OKKLw5KpOFoEDU+ZMbJdxpdxk4I3yUTB+hx1+wLggXc=;
        b=Lo0431jxonAdepGgqX8MNbJQG/9lk+Jo1Skvxvs+XgGDdAD6WX6wrSZxetKmcew3tY
         19Xx0kCMjF4sHRVdJ9Kq4G3bPdqKi+DWJbVPx9nlA1u/fmsRAeCfEFsQ2QvU32HaA3Oo
         /kgZCZILkzjYimgvp16lnffpf3V6T9IgQ2Fvxhe3BAApX6Am4mhKiy31lBWdEgarzCD1
         P+ki0XPcLsM0PriDiO9cUdRp11wDMu15I1sxpHVPhk1l570z1T/sQKeeucXUl8PIw5MU
         TLlRHTbjPeRDB6eJTGhvxUftSeiA8j+Y3F14rmQh+CBC624j6sjh2ygvrwsd9dzmjlZl
         6dTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OKKLw5KpOFoEDU+ZMbJdxpdxk4I3yUTB+hx1+wLggXc=;
        b=lXUwQpu+TGODuuCq1hbZHDN6hzmGYTBPa7F60ewJGkfMB/nt8VTevjx5upgfk3fsY3
         G/YxWQJD4thYhh1Npe5oby1/BmlkKBbCkhONnUshxB8KR0jIKNcW60N2sNq4xaIwoyM4
         dRp0Yd3Hwmo2ufYMEd96+LCXJf3PGphjcwndV14Wtbmd4AJS9mizU6QFc7x/7WjAjXFI
         JvLvyE2E4OVbidRuJmepYWaBKnbp1piSjPymQFWm2rUnFIiv9IO0hGXGcwEt4Cr10c5r
         sKUvO71KFeHQIyEKw8uvjAxVUDivHuaVAviVAwGVJOIWm38bY407df8ByQZjXd8DCisD
         CbQg==
X-Gm-Message-State: ACrzQf3ES6xeZ/JUywCoVT0/+bPdLl+terE6Lc6KlkcA2L08ttUHgVEX
        /bO9MhzCYq5x0dtLzAnp4r4003FrTjXdYWbR7FQ=
X-Google-Smtp-Source: AMsMyM65HaFUoTyt2rdXaI9Ho3KvMqvx0YRQtYeHx2EiCzHFGakoF2fTTRp9LWxQ/EMVow6z+ye4Pfx8tn3YGebtPwM=
X-Received: by 2002:a05:6102:31b6:b0:3a6:eeec:a566 with SMTP id
 d22-20020a05610231b600b003a6eeeca566mr3240056vsh.28.1665760012241; Fri, 14
 Oct 2022 08:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221014142611.1145407-1-agordeev@linux.ibm.com>
In-Reply-To: <20221014142611.1145407-1-agordeev@linux.ibm.com>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Fri, 14 Oct 2022 08:06:41 -0700
Message-ID: <CAAH8bW8Uvb-GzoZiPVEeNGQL-y1cF90sGs99_PRetmcpisF81Q@mail.gmail.com>
Subject: Re: [PATCH] s390/cpuinfo: prevent warning when reading /proc/cpuinfo
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, Andrew Jones <ajones@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Oct 14, 2022 at 7:26 AM Alexander Gordeev
<agordeev@linux.ibm.com> wrote:
>
> Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
> started issuing warnings when reading /proc/cpuinfo and config
> DEBUG_PER_CPU_MAPS is enabled. Avoid calling cpumask_next() with
> the cpu index equal to nr_cpu_ids - 1 and ensure no warning is
> generated.
>
> Link: https://lore.kernel.org/r/20221012081905.1800640-1-ajones@ventanamicro.com
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  arch/s390/kernel/processor.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
> index a194611ba88c..908a0be900ea 100644
> --- a/arch/s390/kernel/processor.c
> +++ b/arch/s390/kernel/processor.c
> @@ -334,6 +334,8 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>
>  static inline void *c_update(loff_t *pos)
>  {
> +       if (*pos >= nr_cpu_ids)
> +               return NULL;
>         if (*pos)
>                 *pos = cpumask_next(*pos - 1, cpu_online_mask);
>         else

This silences the warning entirely. If you don't need it, I'd suggest
using find_next_bit()
instead. But from the discussion to similar patch, I think you need to
allow nr_cpu_ids
only:
 +       if (*pos == nr_cpu_ids)
 +               return NULL;
