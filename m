Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FE0C6FD1C
	for <linux-s390@archiver.kernel.org>; Wed, 22 Mar 2023 12:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjCVMWO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 22 Mar 2023 08:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCVMWN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 22 Mar 2023 08:22:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8373AB8
        for <linux-s390@vger.kernel.org>; Wed, 22 Mar 2023 05:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679487645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hPXFCTl8qif3OA4s3YNypS2WhS0XvH7qdHBOusQ/gQI=;
        b=LuP4fBvVzRS/lTwhhaJB3MHbL8v9PKaN/VEeE+JpK2VjR8oC7FyYUY/NXL9eO1WWy6EA5/
        ps1g32RrPlEk/+w5xBz13iyPHZtQzBH3/j+1kTi9sVA3yvv6npQ6koVKdlAjXtqig/YofD
        Faq1HCNt1DCcdP5xTWxp8Hv/bxn7Y00=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-jwvyKGUsMsiWhttT5Mo5jA-1; Wed, 22 Mar 2023 08:20:36 -0400
X-MC-Unique: jwvyKGUsMsiWhttT5Mo5jA-1
Received: by mail-qt1-f198.google.com with SMTP id h6-20020a05622a170600b003e22c6de617so5199444qtk.13
        for <linux-s390@vger.kernel.org>; Wed, 22 Mar 2023 05:20:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679487636;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hPXFCTl8qif3OA4s3YNypS2WhS0XvH7qdHBOusQ/gQI=;
        b=tElcg9mH8Yrn3fFr12DRzAeKDpjpD+wgtDWQCBKAhbs1AC4L8CSyOqRmZ4XrnVNz4H
         z4CIwEvx14C4YMCL9htZhUx9cwxoqQLL6ZkCYLvu/9eSDRD6cT9WOcZf+Eu2xNjSrR9J
         9ZKazf13lcowcRQyj6zoHCKZZ52DpzhT9lc9JTrs77CxJwa68os6SUAOSQPDVk2slStW
         3giTpZS7u7XbdHFu2/D1CYeCd56dAWMP43AqnOE2pB/H0xeBsTx7BQ0OqGLUywGfsgh4
         LVGVuDV6RkrzvyckW2U1xBjACWK80QAmwMZ2/sz97pe5mv+u5CRyQ4Y1XmuNaXx8QtCM
         ojMQ==
X-Gm-Message-State: AO0yUKW8N3TcGpWuiw/O9grgfWa+hPtRh1g2tIazNW7ZOccntrokpHa1
        sdW0WGlhVLzEfoiU3NRPxXRV4PURU+VLON0DTEPjeNgeLDv8movM/yqc+7fkaxfv6/+WpalzqtW
        rShP1ZnK+WOVzsizpgBEoqA==
X-Received: by 2002:a05:6214:e6e:b0:5c5:95db:858a with SMTP id jz14-20020a0562140e6e00b005c595db858amr5249084qvb.31.1679487636118;
        Wed, 22 Mar 2023 05:20:36 -0700 (PDT)
X-Google-Smtp-Source: AK7set+c4qgqaBQUslatTuVuP/CBQYeSmWHcWFFuVnFTR+yoMggQM+H4NTuj8PmuW7zmUDZ2oj+NWg==
X-Received: by 2002:a05:6214:e6e:b0:5c5:95db:858a with SMTP id jz14-20020a0562140e6e00b005c595db858amr5249039qvb.31.1679487635822;
        Wed, 22 Mar 2023 05:20:35 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id d185-20020a37b4c2000000b007425ef4cbc2sm11175799qkf.100.2023.03.22.05.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 05:20:35 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
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
        Steven Rostedt <rostedt@goodmis.org>,
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
Subject: Re: [PATCH v5 7/7] sched, smp: Trace smp callback causing an IPI
In-Reply-To: <20230322095329.GS2017917@hirez.programming.kicks-ass.net>
References: <20230307143558.294354-1-vschneid@redhat.com>
 <20230307143558.294354-8-vschneid@redhat.com>
 <20230322095329.GS2017917@hirez.programming.kicks-ass.net>
Date:   Wed, 22 Mar 2023 12:20:28 +0000
Message-ID: <xhsmhmt45c703.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22/03/23 10:53, Peter Zijlstra wrote:
> On Tue, Mar 07, 2023 at 02:35:58PM +0000, Valentin Schneider wrote:
>
>> @@ -477,6 +490,25 @@ static __always_inline void csd_unlock(struct __call_single_data *csd)
>>      smp_store_release(&csd->node.u_flags, 0);
>>  }
>>
>> +static __always_inline void
>> +raw_smp_call_single_queue(int cpu, struct llist_node *node, smp_call_func_t func)
>> +{
>> +	/*
>> +	 * The list addition should be visible to the target CPU when it pops
>> +	 * the head of the list to pull the entry off it in the IPI handler
>> +	 * because of normal cache coherency rules implied by the underlying
>> +	 * llist ops.
>> +	 *
>> +	 * If IPIs can go out of order to the cache coherency protocol
>> +	 * in an architecture, sufficient synchronisation should be added
>> +	 * to arch code to make it appear to obey cache coherency WRT
>> +	 * locking and barrier primitives. Generic code isn't really
>> +	 * equipped to do the right thing...
>> +	 */
>> +	if (llist_add(node, &per_cpu(call_single_queue, cpu)))
>> +		send_call_function_single_ipi(cpu, func);
>> +}
>> +
>>  static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
>>
>>  void __smp_call_single_queue(int cpu, struct llist_node *node)
>> @@ -493,21 +525,25 @@ void __smp_call_single_queue(int cpu, struct llist_node *node)
>>              }
>>      }
>>  #endif
>>      /*
>> +	 * We have to check the type of the CSD before queueing it, because
>> +	 * once queued it can have its flags cleared by
>> +	 *   flush_smp_call_function_queue()
>> +	 * even if we haven't sent the smp_call IPI yet (e.g. the stopper
>> +	 * executes migration_cpu_stop() on the remote CPU).
>>       */
>> +	if (trace_ipi_send_cpumask_enabled()) {
>> +		call_single_data_t *csd;
>> +		smp_call_func_t func;
>> +
>> +		csd = container_of(node, call_single_data_t, node.llist);
>> +		func = CSD_TYPE(csd) == CSD_TYPE_TTWU ?
>> +			sched_ttwu_pending : csd->func;
>> +
>> +		raw_smp_call_single_queue(cpu, node, func);
>> +	} else {
>> +		raw_smp_call_single_queue(cpu, node, NULL);
>> +	}
>>  }
>
> Hurmph... so we only really consume @func when we IPI. Would it not be
> more useful to trace this thing for *every* csd enqeued?

It's true that any CSD enqueued on that CPU's call_single_queue in the
[first CSD llist_add()'ed, IPI IRQ hits] timeframe is a potential source of
interference.

However, can we be sure that first CSD isn't an indirect cause for the
following ones? say the target CPU exits RCU EQS due to the IPI, there's a
bit of time before it gets to flush_smp_call_function_queue() where some other CSD
could be enqueued *because* of that change in state.

I couldn't find a easy example of that, I might be biased as this is where
I'd like to go wrt IPI'ing isolated CPUs in usermode. But regardless, when
correlating an IPI IRQ with its source, we'd always have to look at the
first CSD in that CSD stack.

