Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE36ECAAA1
	for <linux-s390@archiver.kernel.org>; Fri, 28 Oct 2022 07:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiJ1Hsc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 28 Oct 2022 03:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJ1Hsb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 28 Oct 2022 03:48:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FF31BC16E
        for <linux-s390@vger.kernel.org>; Fri, 28 Oct 2022 00:48:30 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id bp11so5859761wrb.9
        for <linux-s390@vger.kernel.org>; Fri, 28 Oct 2022 00:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U0U3J+Q69fu7o/YQz3q/fMO7g+tmuXGKvEK6KG9JDGA=;
        b=oqmNgqsztuMpLAhNQorP3820L6EJNnJRDoXEb4RgzXZQMfNQDcyVCHVYlvSTb+cksH
         CwJ2aeLsuRGbAg4oUeweMw9W7RVPie8fbQhXZCKgnIXewPhBCQ2D8qNqXYiXfhT76dW6
         xJX6KJ6QR8kf1VFJxGUsMl5/+ENJJ5Wxii90WkOuwZT7HNIb6lID8pp/UFcfXmak4LFL
         jTzzJYzhej1Kn237Slz8BJcwQbdSqVXWEQpinfJlNcbgrjQ4bsMdqNEumXt3CMYlYdSi
         LO4ALfufKLzxVKs824kdxmBew78rDuLIWHvjPbK+3tKTM3XpkrSx4Zr/NWhajts4BWCr
         /L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0U3J+Q69fu7o/YQz3q/fMO7g+tmuXGKvEK6KG9JDGA=;
        b=IUxmAkghZlUuQIlBaVIOKZkllZgkqP78oXt0V/yDjDQF1xz3VPJEcxGBTdc9ADU9/4
         2Y07IscYrREUp2I3wi8bX7JqJmMJ4SpzBtd+9el62X1PmemWeCxpMxdLQ3r1960Mn9vK
         ao+C92mcf7tx3syQpK3eDn0626PcgkWau1WEkWr1UYexSqKvx5d9/FO6a81hgEo5t3dU
         zWemFnxaloAQvVJoOt4QZeWvM4fGLQsGB8JhfbH7o+8KI3RWYvH5OpAsTjjfN0UbOX/f
         ziZ7RjG/lBJvkU2oxI9Z8CdsuPLkUD3EoOAnENvL2QXKh5TXMI29i/OBWk36qt4dj9Qq
         W8sQ==
X-Gm-Message-State: ACrzQf0wMlh6/pzWkI0+i4Da8S6yKovcFKn73mZ9eyZse3WqWGJWHuDN
        vi5CdEv0NijDtrzy4NBQNXb7iA==
X-Google-Smtp-Source: AMsMyM6VIrVFAYX3MFdpAr2A3aolwkCyi7gytgwNOdq5lcvzoSJ4ww9Dhq1bl3mK11pqR8Em7mdPlA==
X-Received: by 2002:adf:ef4e:0:b0:236:6608:f6ce with SMTP id c14-20020adfef4e000000b002366608f6cemr18585925wrp.85.1666943309562;
        Fri, 28 Oct 2022 00:48:29 -0700 (PDT)
Received: from localhost (cst2-173-61.cust.vodafone.cz. [31.30.173.61])
        by smtp.gmail.com with ESMTPSA id h1-20020a5d4301000000b0022efc4322a9sm2989820wrq.10.2022.10.28.00.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:48:29 -0700 (PDT)
Date:   Fri, 28 Oct 2022 09:48:28 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 2/2] x86: Fix /proc/cpuinfo cpumask warning
Message-ID: <20221028074828.b66uuqqfbrnjdtab@kamzik>
References: <20221014155845.1986223-1-ajones@ventanamicro.com>
 <20221014155845.1986223-3-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014155845.1986223-3-ajones@ventanamicro.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Oct 14, 2022 at 05:58:45PM +0200, Andrew Jones wrote:
> Commit 78e5a3399421 ("cpumask: fix checking valid cpu range") has
> started issuing warnings[*] when cpu indices equal to nr_cpu_ids - 1
> are passed to cpumask_next* functions. seq_read_iter() and cpuinfo's
> start and next seq operations implement a pattern like
> 
>   n = cpumask_next(n - 1, mask);
>   show(n);
>   while (1) {
>       ++n;
>       n = cpumask_next(n - 1, mask);
>       if (n >= nr_cpu_ids)
>           break;
>       show(n);
>   }
> 
> which will issue the warning when reading /proc/cpuinfo. Ensure no
> warning is generated by validating the cpu index before calling
> cpumask_next().
> 
> [*] Warnings will only appear with DEBUG_PER_CPU_MAPS enabled.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> Cc: Yury Norov <yury.norov@gmail.com>
> ---
>  arch/x86/kernel/cpu/proc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/proc.c b/arch/x86/kernel/cpu/proc.c
> index 099b6f0d96bd..de3f93ac6e49 100644
> --- a/arch/x86/kernel/cpu/proc.c
> +++ b/arch/x86/kernel/cpu/proc.c
> @@ -153,6 +153,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  
>  static void *c_start(struct seq_file *m, loff_t *pos)
>  {
> +	if (*pos == nr_cpu_ids)
> +		return NULL;
> +
>  	*pos = cpumask_next(*pos - 1, cpu_online_mask);
>  	if ((*pos) < nr_cpu_ids)
>  		return &cpu_data(*pos);
> -- 
> 2.37.3
>

Hi x86 maintainers,

I realize 78e5a3399421 has now been reverted, so this fix is no longer
urgent. I don't believe it's wrong, though, so if it's still of interest,
then please consider this a friendly ping.

Thanks,
drew
