Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133CAC433F5
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 17:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E23BB60ED4
	for <linux-s390@archiver.kernel.org>; Tue, 12 Oct 2021 17:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhJLRHB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34864 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229510AbhJLRHB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Oct 2021 13:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634058299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zv2suu7TZ2BZjNAY7Fx5N+NNNZcHunY8SSActvahWDE=;
        b=V/h8sVsGe+ckFF2+JGsOwK6MEUwh+yHUdBggfI1zEoT+Zl54C3lMDlatzsOGzJozhSNjAz
        Jmp/46Zp9o2FzLegvLsNt+qy3w325DuoDHshIiPj/pNON6YZcY0wou+ENweX+HQ33mT+Oe
        PzWWdBQGO4ZFjFBmBI3Dssntp2Vufa0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-q_7QuUjUPPKGh37MbhtUfg-1; Tue, 12 Oct 2021 13:04:57 -0400
X-MC-Unique: q_7QuUjUPPKGh37MbhtUfg-1
Received: by mail-ed1-f71.google.com with SMTP id v9-20020a50d849000000b003db459aa3f5so506535edj.15
        for <linux-s390@vger.kernel.org>; Tue, 12 Oct 2021 10:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Zv2suu7TZ2BZjNAY7Fx5N+NNNZcHunY8SSActvahWDE=;
        b=ZmPR0wtLB8cKEWXMf/GzpBGTWq+GBek3IgZJPVJjH+DK63BURGhov0wkoyCIz3ZI3u
         i4AgmX/nVKOXU3J51gz9UqaGeFkzigqA9ahQM22p4L0193rsjvnkibsgjJNXPVkokIoW
         1qTJv590v7yvcOVrS5YzKDgsOyc4HTTddaginGRMjSs5c6SE9YCcEdYixV2wBrKiP+xb
         OX2YBgfkFu2vJ6aQ1mkRr6weoLUSBFiUrxCxnWafyb54sYtH7NLgCmLcTZN0gfmBpeUx
         rOgPm9UilnzT6KsM1ys0dpcYpCLwk6n6J534cWLyO2Md1lOGw6g2nY/vzCyw8ZhiDdhV
         l0cQ==
X-Gm-Message-State: AOAM533ylRDG9MXhEYApRdvgORbHSvN7Me4MUsQDy1i4I/AjvdvkoEiu
        TvKlx8TX7ax5u8IXnt8qGWJHmEdLsxAW4A1E/J2OdKUWUnTdRfY7yVEKRkLF85fbDvRZh9ENVT7
        ZGSgppseD+HSbJ5KzrwEQ+A==
X-Received: by 2002:a17:907:7848:: with SMTP id lb8mr33622162ejc.494.1634058295745;
        Tue, 12 Oct 2021 10:04:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHdjuAiKRrQdj3TGjYYQwVTXm0QdW86MwEWtHVztudehRLFxGkkxaVFB3lvRzbd7INiO0Xvg==
X-Received: by 2002:a17:907:7848:: with SMTP id lb8mr33622143ejc.494.1634058295520;
        Tue, 12 Oct 2021 10:04:55 -0700 (PDT)
Received: from krava ([83.240.63.48])
        by smtp.gmail.com with ESMTPSA id e13sm5226755eje.95.2021.10.12.10.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 10:04:54 -0700 (PDT)
Date:   Tue, 12 Oct 2021 19:04:53 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] s390: DYNAMIC_FTRACE_WITH_DIRECT_CALL support
Message-ID: <YWXANRbkPIE3HtOE@krava>
References: <20211012133802.2460757-1-hca@linux.ibm.com>
 <20211012094852.7f6a59b8@gandalf.local.home>
 <YWWithSCGThguq7s@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWWithSCGThguq7s@osiris>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 12, 2021 at 04:59:02PM +0200, Heiko Carstens wrote:
> On Tue, Oct 12, 2021 at 09:48:52AM -0400, Steven Rostedt wrote:
> > On Tue, 12 Oct 2021 15:37:58 +0200
> > Heiko Carstens <hca@linux.ibm.com> wrote:
> > > This small series adds DYNAMIC_FTRACE_WITH_DIRECT_CALL support for
> > > s390 and is based on linux-next 20211012.
> ...
> > > Besides the architecture backend this also adds s390 ftrace direct
> > > call samples, and slightly changes config option handling a bit, so
> > > that options only have to be selected. This way also additional future
> > > architectures can easily add their trampolines to the samples.
> ...
> > > If ok, I'd like to get this upstream via the s390 tree with the next
> > > merge window.
> > 
> > A quick look at the patches look fine to me. I'll do a bit more digging
> > before adding a Reviewed-by.
> > 
> > One thing you may want to note, we are working on fixing direct trampolines
> > that conflict with the function graph tracer, and have patches that fix it.
> > I'm not that familiar on how ftrace works on s390, but you may want to
> > investigate this, because if s390 has the issues that x86 has, where you
> > can't have both function graph tracing and a direct trampoline on the same
> > function.
> > 
> > See here:
> > 
> >   https://lore.kernel.org/all/20211008091336.33616-1-jolsa@kernel.org/
> 
> I applied Jiri's patch set and the newly added selftest passes.

nice, could I have your Tested-by? ;-)

thanks,
jirka

> 
> Note: s390 will also get HAVE_DYNAMIC_FTRACE_WITH_ARGS support, which is
> required for the new selftest - this is currently only in linux-next.
> See commit 5740a7c71ab6 ("s390/ftrace: add HAVE_DYNAMIC_FTRACE_WITH_ARGS
> support") in linux-next.
> 
> Also manually testing with loading the ftrace-direct test module and
> enabling the function graph tracer seems to work correctly:
> 
>   6) + 15.138 us   |            }
>   6)               |            wake_up_process() {
>   6)               |              my_direct_func [ftrace_direct]() {
>   6)               |                /* waking up ksoftirqd/6-44 */
>   6)   0.944 us    |              }
>   6)               |              try_to_wake_up() {
>   6)   0.185 us    |                kthread_is_per_cpu();
> 
> One thing to note: Jiri adds a new a sample module, which obviously
> will not compile for s390. Not sure if the config mechanism I propose
> with this patch set is the best way to address this - it would then
> require to add a config option for each new sample module.
> 

