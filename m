Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DEBCC77B7C
	for <linux-s390@archiver.kernel.org>; Wed, 24 May 2023 16:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjEXQln (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 24 May 2023 12:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbjEXQlj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 24 May 2023 12:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7596132
        for <linux-s390@vger.kernel.org>; Wed, 24 May 2023 09:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684946452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YU48hv50mXOheNgtwLXvm6BL0As/IRm4S4+H7EFvY6A=;
        b=eAByMmhDT9ISbPNj1Qw5cbCnnFT/hY0TyC39VLVPFoNQscpr/SRwGzDFk24t6cWgxq4v2w
        Mg3czBRwtRBBqGHfzqc5W49F8MK90Ua6u3pBYJF9EeeolcNORy0iOoPsa7Smj8vH4Ew3iM
        JKNGR9OOeHdaIwYMDeeOM9wZsrhcPDU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-_qZr_O_UM7GzY3vY1TRCwg-1; Wed, 24 May 2023 12:40:50 -0400
X-MC-Unique: _qZr_O_UM7GzY3vY1TRCwg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f5fa06debcso7911075e9.0
        for <linux-s390@vger.kernel.org>; Wed, 24 May 2023 09:40:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684946449; x=1687538449;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YU48hv50mXOheNgtwLXvm6BL0As/IRm4S4+H7EFvY6A=;
        b=jL4QtDPz8/HFj431M4fQrin4IjIyxHs40yrv0J/devTRYgFZ/OK6e6PMVchiI4gs6w
         4jvD3LkLdzdhuA2Os7dfgmYTq5L76ve5+c/Asj1xNyMA4DHGFzcpf010V6ivGHLWCtdk
         SO0aPKcADHEmLEmGIYxlI/GECJbNIihQ1lxz18y8XWhnkZfksZX24E0RThhMvPPhXrtN
         DF8ai1uaAKCi6dfvEWulaT7YXhCduyHlvPD/SyLIThu7rdRtrEtsErCWhxxr5lRo+puB
         mIVnDKXVrvuifqW8+sxTHkwP89OeqJWiNJzo1h12m2fvLtFbbqsS35ZrWe4kutCOCj3W
         p+Bw==
X-Gm-Message-State: AC+VfDyMZgz77kFkqXw0jQb3Td3aMOc16gCqo917l43weyth/Rc572LQ
        qJtjSq5bmyUoofoOmlAqwaPDvkaeNSlsoCzaz11l5u8JCfTjgP+UoOEGIdwscjQK4F41WRIPqhO
        mRnM7T1xl8Tef0gQOeX4LMA==
X-Received: by 2002:a5d:4b8e:0:b0:306:3b78:fe33 with SMTP id b14-20020a5d4b8e000000b003063b78fe33mr295782wrt.32.1684946449591;
        Wed, 24 May 2023 09:40:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4Eq4QeR9/BJ3B8RRkdoVpa79HYvap1nF06Mugaau72o6IHjT2PaOeIJyaUKVC9H0K24yEeVg==
X-Received: by 2002:a5d:4b8e:0:b0:306:3b78:fe33 with SMTP id b14-20020a5d4b8e000000b003063b78fe33mr295772wrt.32.1684946449333;
        Wed, 24 May 2023 09:40:49 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id e9-20020adffc49000000b003078a3f3a24sm15120399wrs.114.2023.05.24.09.40.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 09:40:48 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>, bigeasy@linutronix.de
Cc:     mark.rutland@arm.com, maz@kernel.org, catalin.marinas@arm.com,
        will@kernel.org, chenhuacai@kernel.org, kernel@xen0n.name,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        pbonzini@redhat.com, wanpengli@tencent.com, vkuznets@redhat.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        jgross@suse.com, boris.ostrovsky@oracle.com,
        daniel.lezcano@linaro.org, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        rafael@kernel.org, peterz@infradead.org, longman@redhat.com,
        boqun.feng@gmail.com, pmladek@suse.com, senozhatsky@chromium.org,
        rostedt@goodmis.org, john.ogness@linutronix.de,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, jstultz@google.com, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 04/13] arm64/arch_timer: Provide noinstr
 sched_clock_read() functions
In-Reply-To: <20230519102715.435618812@infradead.org>
References: <20230519102058.581557770@infradead.org>
 <20230519102715.435618812@infradead.org>
Date:   Wed, 24 May 2023 17:40:47 +0100
Message-ID: <xhsmho7m9ptrk.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 19/05/23 12:21, Peter Zijlstra wrote:
> With the intent to provide local_clock_noinstr(), a variant of
> local_clock() that's safe to be called from noinstr code (with the
> assumption that any such code will already be non-preemptible),
> prepare for things by providing a noinstr sched_clock_read() function.
>
> Specifically, preempt_enable_*() calls out to schedule(), which upsets
> noinstr validation efforts.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/arm64/include/asm/arch_timer.h  |    8 ----
>  drivers/clocksource/arm_arch_timer.c |   60 ++++++++++++++++++++++++++---------
>  2 files changed, 47 insertions(+), 21 deletions(-)
>
> --- a/arch/arm64/include/asm/arch_timer.h
> +++ b/arch/arm64/include/asm/arch_timer.h
> @@ -88,13 +88,7 @@ static inline notrace u64 arch_timer_rea
>
>  #define arch_timer_reg_read_stable(reg)					\
>       ({								\
> -		u64 _val;						\
> -									\
> -		preempt_disable_notrace();				\
> -		_val = erratum_handler(read_ ## reg)();			\
> -		preempt_enable_notrace();				\
> -									\
> -		_val;							\
> +		erratum_handler(read_ ## reg)();			\
>       })
>
>  /*
> --- a/drivers/clocksource/arm_arch_timer.c
> +++ b/drivers/clocksource/arm_arch_timer.c
> @@ -191,22 +191,40 @@ u32 arch_timer_reg_read(int access, enum
>       return val;
>  }
>
> -static notrace u64 arch_counter_get_cntpct_stable(void)
> +static noinstr u64 _arch_counter_get_cntpct_stable(void)
>  {
>       return __arch_counter_get_cntpct_stable();
>  }
>

I tripped over the underscores when reviewing this :( This must be
getting close to the symbol length limit, but could we give this a helpful
prefix or suffix? raw_* or *_noinstr?

> @@ -1074,6 +1092,13 @@ struct arch_timer_kvm_info *arch_timer_g
>
>  static void __init arch_counter_register(unsigned type)
>  {
> +	/*
> +	 * Default to cp15 based access because arm64 uses this function for
> +	 * sched_clock() before DT is probed and the cp15 method is guaranteed
> +	 * to exist on arm64. arm doesn't use this before DT is probed so even
> +	 * if we don't have the cp15 accessors we won't have a problem.
> +	 */
> +	u64 (*scr)(void) = arch_counter_get_cntvct;

So this bit sent me on a little spelunking session :-)

From a control flow perspective the initialization isn't required, but then
I looked into the comment and found it comes from the
arch_timer_read_counter() definition... Which itself doesn't get used by
sched_clock() until the sched_clock_register() below!

So AFAICT that comment was true as of

  220069945b29 ("clocksource: arch_timer: Add support for memory mapped timers")

but not after a commit that came 2 months later:

  65cd4f6c99c1 ("arch_timer: Move to generic sched_clock framework")

which IIUC made arm/arm64 follow the default approach of using the
jiffy-based sched_clock() before probing DT/ACPI and registering a "proper"
sched_clock.

All of that to say: the comment about arch_timer_read_counter() vs early
sched_clock() doesn't apply anymore, but I think we need to keep its
initalization around for stuff like get_cycles(). This initialization here
should be OK to put to the bin, though.

