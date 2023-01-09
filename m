Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BDAC61DB3
	for <linux-s390@archiver.kernel.org>; Mon,  9 Jan 2023 19:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbjAITDV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 9 Jan 2023 14:03:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234413AbjAITDF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Jan 2023 14:03:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B13C38AF0
        for <linux-s390@vger.kernel.org>; Mon,  9 Jan 2023 11:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673290937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mHlpuxTK3Q4mXdtUEAjHx/X4tIty+fqRI+m6xngZY9c=;
        b=iYLzfX/+x0gg809zW0TTeakmRwaUF0lw64Q6nF8en1Uul5QIM1GCu8sbmRnTHfpB3HFrp6
        oxhdcO7uTCXXXxk7EsQgQVC/pVAGqjSG9jgNDQdmVvz9akY9LbE16OWkdEv69rUibGbcws
        LgFQhXQxiRIFhsuNJsoft1bsRTeAWt8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-333-UIh-591tO5WSOZz5ZHc_lA-1; Mon, 09 Jan 2023 14:02:16 -0500
X-MC-Unique: UIh-591tO5WSOZz5ZHc_lA-1
Received: by mail-yb1-f198.google.com with SMTP id v4-20020a056902028400b007b075879242so10067697ybh.22
        for <linux-s390@vger.kernel.org>; Mon, 09 Jan 2023 11:02:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mHlpuxTK3Q4mXdtUEAjHx/X4tIty+fqRI+m6xngZY9c=;
        b=M9CbqUD+CeI796vb4n8rXUa/jsl9pGqCRzeo4dJUdhAfmK8CLmkT0QSI4qSp4cK7IZ
         RThTib6DQcHqsOCTjNrvS5oSOWtn2iJ+iML8MP+Em/bGPa2QAZ0dBdEY68O45bjNxF0Z
         6wyyCJrBM1ofMAXCQjRhkx/pm51GsowO+zLJUPPAEY8jUk8TLFWFN/jg+oi+MT9fPrjJ
         MvJRemA2OagGvZOmxfilb52Et7J6UTNOdW05yhA/82T/JR+1+d8Ze5YQS7js7mud9cFJ
         LK2zemejlMOA0RbPIcmMHr43AiJR0nrhrUMFbAoYt7L28IzrtScmqjWyqPquTFxTn98g
         vr7w==
X-Gm-Message-State: AFqh2kpWSl8vuOb1v31fpV+2Jep7AhPYOk0Gu7CcWT0EPOm65TUF7q/R
        ABahuNhpEg49u43yybRgwKbjnvFALhy8odrV/fZSH6qBPnr5Ktig2F/ijDqvLJ/Per/XmW09B9M
        93epq+ImxLx0nXnauc933aw==
X-Received: by 2002:a05:7500:5c96:b0:f0:f14:b4f6 with SMTP id fh22-20020a0575005c9600b000f00f14b4f6mr1334324gab.55.1673290935394;
        Mon, 09 Jan 2023 11:02:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvpgx9uVCbTytxfSzpNGAx1CCCprwK9dYT+w5TdWAjmS9/Yvcm6uASOc9C3qqyAspkLlpcI4w==
X-Received: by 2002:a05:7500:5c96:b0:f0:f14:b4f6 with SMTP id fh22-20020a0575005c9600b000f00f14b4f6mr1334309gab.55.1673290934985;
        Mon, 09 Jan 2023 11:02:14 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id az31-20020a05620a171f00b006fbbdc6c68fsm5795671qkb.68.2023.01.09.11.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 11:02:14 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 3/8] sched, smp: Trace IPIs sent via
 send_call_function_single_ipi()
In-Reply-To: <Y7lRz7oCaAmAhoqS@gmail.com>
References: <20221202155817.2102944-1-vschneid@redhat.com>
 <20221202155817.2102944-4-vschneid@redhat.com>
 <Y7lRz7oCaAmAhoqS@gmail.com>
Date:   Mon, 09 Jan 2023 19:02:08 +0000
Message-ID: <xhsmh4jszedlb.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 07/01/23 12:04, Ingo Molnar wrote:
> * Valentin Schneider <vschneid@redhat.com> wrote:
>
>> send_call_function_single_ipi() is the thing that sends IPIs at the bottom
>> of smp_call_function*() via either generic_exec_single() or
>> smp_call_function_many_cond(). Give it an IPI-related tracepoint.
>> 
>> Note that this ends up tracing any IPI sent via __smp_call_single_queue(),
>> which covers __ttwu_queue_wakelist() and irq_work_queue_on() "for free".
>> 
>> Signed-off-by: Valentin Schneider <vschneid@redhat.com>
>> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> Acked-by: Ingo Molnar <mingo@kernel.org>
>
> Patch series logistics:
>
>  - No objections from the scheduler side, this feature looks pretty useful.
>

Thanks!

>  - Certain patches are incomplete, others are noted as being merged 
>    separately, so I presume you'll send an updated/completed series 
>    eventually?
>

The first patch from Steve is now in, so can drop it.

The other patches are complete, though I need to rebase them and regenerate
the treewide patch to catch any changes that came with 6.2. I'll do that
this week.

The "incompleteness" pointed out in the cover letter is about the types of
IPIs that can be traced. This series covers the ones that end up invoking
some core code (coincidentally those are the most common ones), others such
as e.g. tick_broadcast() for arm, arm64, riscv and hexagon remain
unaffected.

I'm not that much interested in these (other than maybe the tick broadcast
one they are all fairly unfrequent), but I'm happy to have a shot at them
for the sake of completeness - either in that series or in a followup, up
to you.  

>  - We can merge this via the scheduler tree I suspect, as most callbacks 
>    affected relate to tip:sched/core and tmp:smp/core - but if you have 
>    some other preferred tree that's fine too.
>

Either sound good to me.

> Thanks,
>
> 	Ingo

