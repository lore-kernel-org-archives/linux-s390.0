Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451F0C4332F
	for <linux-s390@archiver.kernel.org>; Tue, 11 Oct 2022 15:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiJKPmS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 11 Oct 2022 11:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiJKPln (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 11 Oct 2022 11:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C532CAE23E
        for <linux-s390@vger.kernel.org>; Tue, 11 Oct 2022 08:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665502223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ti1NCFCTzr5YPwBHvg45c+mfaiUwrR60uA7ep6lLZuA=;
        b=K4pQ0OYXfZw9gmWtmovRyU3rUQgPs/dL75NT5aYQ6JUTF7ozC+8fHfO0n5JddibNCSRNHK
        lhri+iNtKV9v1Po8DbWbGKsgRySL3CvP0yNX9fua58cGZQEl2DfTgDD96TOpf3H1u61cxU
        bwJGz/GxWdn3Ma1PPzLwUtK/jJ+/WSs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-483-bjA7JYIzPguGssT6tX4ZSQ-1; Tue, 11 Oct 2022 11:02:10 -0400
X-MC-Unique: bjA7JYIzPguGssT6tX4ZSQ-1
Received: by mail-wm1-f71.google.com with SMTP id 2-20020a05600c268200b003c4290989e1so2313459wmt.2
        for <linux-s390@vger.kernel.org>; Tue, 11 Oct 2022 08:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ti1NCFCTzr5YPwBHvg45c+mfaiUwrR60uA7ep6lLZuA=;
        b=jK5uKCESVDu37JALdUpdTTk7mGHeuHfIYBmXTXH5zODUWapVbHKxxeeVlOQX7N3oDI
         xUADL391U12Y87d9YpAtzrLWHAduSH33FiENfA7q2Ma4JC6x1TDbmQ7NaBIJr+Hj/pQl
         erZQV8JXEQ52kHfEsPB/kdA5X50u//gZdXJyJtqvREbW2gm/ji7FPnMOFrb+kxotIw0y
         ZAex69PmB9Gc4fGUb9sK84bjxXE4DxP3W9dNdHSMygOgPzM2+4eTbSKGy+k1sWGNZmJf
         me89pYNGk/DUXql99kDqIXL+OFdbhsk1KXVOQ8V/Kh92KVzto9EuUO2hcA9NzvXOenS8
         Nl3A==
X-Gm-Message-State: ACrzQf2OWFfVgZtbcKj5z3fUbSxJeeOEao7kJPY9/9AneHp+zbmU2RTh
        bnpWvXpY8AwRHXmKfie6WEjDxc32WMpAfWroRuD+plq+jX2HZdT7xuZEfzcBTpN1pENCOtlzHst
        o1WTzyMl9Mmg7kC0cGJEHjw==
X-Received: by 2002:a5d:59a3:0:b0:22e:4b62:7ceb with SMTP id p3-20020a5d59a3000000b0022e4b627cebmr15699198wrr.90.1665500528711;
        Tue, 11 Oct 2022 08:02:08 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7srUgXRaEVg4Pb59BUs0ShAt8e40s56KQw2lU0G4VdN3sOMR/0VHio2//G+OqnLs1Wx3l7Vw==
X-Received: by 2002:a5d:59a3:0:b0:22e:4b62:7ceb with SMTP id p3-20020a5d59a3000000b0022e4b627cebmr15699160wrr.90.1665500528495;
        Tue, 11 Oct 2022 08:02:08 -0700 (PDT)
Received: from vschneid.remote.csb ([104.132.153.106])
        by smtp.gmail.com with ESMTPSA id bh11-20020a05600c3d0b00b003b49ab8ff53sm13552403wmb.8.2022.10.11.08.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:02:07 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: [RFC PATCH 4/5] irq_work: Trace calls to arch_irq_work_raise()
In-Reply-To: <20221008153442.159b2f2d@rorschach.local.home>
References: <20221007154145.1877054-1-vschneid@redhat.com>
 <20221007154533.1878285-4-vschneid@redhat.com>
 <20221008153442.159b2f2d@rorschach.local.home>
Date:   Tue, 11 Oct 2022 16:02:06 +0100
Message-ID: <xhsmhlepmflox.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08/10/22 15:34, Steven Rostedt wrote:
> On Fri,  7 Oct 2022 16:45:32 +0100
> Valentin Schneider <vschneid@redhat.com> wrote:
>>  }
>>  
>> +static inline void irq_work_raise(void)
>> +{
>> +	if (arch_irq_work_has_interrupt())
>> +		trace_ipi_send_cpu(_RET_IP_, smp_processor_id());
>
> To save on the branch, let's make the above:
>
> 	if (trace_ipi_send_cpu_enabled() && arch_irq_work_has_interrupt())
>
> As the "trace_*_enabled()" is a static branch that will make it a nop
> when the tracepoint is not enabled.
>

Makes sense, thanks for the suggestion.

> -- Steve
>
>
>> +
>> +	arch_irq_work_raise();
>> +}
>> +
>>  /* Enqueue on current CPU, work must already be claimed and preempt disabled */

