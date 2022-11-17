Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD451C4167B
	for <linux-s390@archiver.kernel.org>; Thu, 17 Nov 2022 14:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239823AbiKQOqn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 17 Nov 2022 09:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239979AbiKQOql (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 17 Nov 2022 09:46:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0082C3B1
        for <linux-s390@vger.kernel.org>; Thu, 17 Nov 2022 06:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668696339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8gmgQPGvV0Pdco46Use918rHcFMun1FBq8lcqpGuipk=;
        b=JIkZ+PoPbDTs6IOvihBjf0dSg2BvW8WDnX0L97EwWn6AJgbiv8hHFvUqj22eopPnNPCNkb
        951xgL6qrsVfxiEXhSWhQEp0Bsbgfug4W/9y0oPisc+ZuqkhqLoWRMGa/vvna0hJlN8fN3
        dbm1976lozhX50Qu9WvM4u6YrixS8Jg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-22-SQmLdRUsP7Oh6fXNMba5TA-1; Thu, 17 Nov 2022 09:45:36 -0500
X-MC-Unique: SQmLdRUsP7Oh6fXNMba5TA-1
Received: by mail-wr1-f71.google.com with SMTP id v14-20020adf8b4e000000b0024174021277so790969wra.13
        for <linux-s390@vger.kernel.org>; Thu, 17 Nov 2022 06:45:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gmgQPGvV0Pdco46Use918rHcFMun1FBq8lcqpGuipk=;
        b=SnmxFb1ymL3LzzETgh0W5C+s5Aflr7WI3u1x7P4yeU7XytN1zBMmpF99eR0GckYih/
         bcAUA5jX2Ww9yrTPPElpwsp7RzbhK2flyIBm/fHGrug41IybA9aMbo50raPPCqeoabJ9
         iaaLfvF35F8NFf1DUqaKWiN8ZlJdrE7KK1gejR0eNe/NlbMPpI0i2Ic5dqzc+f7Odqzl
         x0kiKFJEq23gzx7qfju1WIwtRYwdVx2rftjMWVlM/pahK7lv8Ah0PDUq+3CXoR0gXaZd
         J8i4V2GlkN93upJNkxsTzWlWdBMVYALiX4X288eHrGW6+lTGB4vpW3vGhFAM4dgjY9mg
         16/A==
X-Gm-Message-State: ANoB5pmUYpyWPCaFRfTJlMVFtJ0Ke2eh2AmNYPYP2pDgLl6DAsSN/SUl
        u4JHwPH4gIUPZjXJPVNEmiWxWPM3lmjxghZjZAjjQCmL7CCHOwakQe1idVDA2doq/9kXuXOwiFH
        A5GRb6kN+l5G70Bwezy1K7w==
X-Received: by 2002:a5d:4683:0:b0:23a:43b7:cdd5 with SMTP id u3-20020a5d4683000000b0023a43b7cdd5mr1645377wrq.387.1668696335545;
        Thu, 17 Nov 2022 06:45:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf64NPDvBapwgGSgB2P5pH25AfOA35vY/3ogR7keZELycX3grFeKUdCp0vRGXy3K3A08o5vlDw==
X-Received: by 2002:a5d:4683:0:b0:23a:43b7:cdd5 with SMTP id u3-20020a5d4683000000b0023a43b7cdd5mr1645351wrq.387.1668696335309;
        Thu, 17 Nov 2022 06:45:35 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id t18-20020a5d6a52000000b00236740c6e6fsm1069950wrw.100.2022.11.17.06.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 06:45:34 -0800 (PST)
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
Subject: Re: [RFC PATCH v2 8/8] sched, smp: Trace smp callback causing an IPI
In-Reply-To: <Y3ZBUMteJysc1/lA@hirez.programming.kicks-ass.net>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-7-vschneid@redhat.com>
 <Y3ZBUMteJysc1/lA@hirez.programming.kicks-ass.net>
Date:   Thu, 17 Nov 2022 14:45:29 +0000
Message-ID: <xhsmhfsehy706.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 17/11/22 15:12, Peter Zijlstra wrote:
> On Wed, Nov 02, 2022 at 06:33:36PM +0000, Valentin Schneider wrote:
> *yuck*

:-)

>
> How about something like so?
>
> ---
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
> @@ -24,6 +24,8 @@
>
>  #include <trace/events/ipi.h>
>
> +#include "sched/smp.h"
> +
>  static DEFINE_PER_CPU(struct llist_head, raised_list);
>  static DEFINE_PER_CPU(struct llist_head, lazy_list);
>  static DEFINE_PER_CPU(struct task_struct *, irq_workd);
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3763,16 +3763,17 @@ void sched_ttwu_pending(void *arg)
>       rq_unlock_irqrestore(rq, &rf);
>  }
>
> -void send_call_function_single_ipi(int cpu)
> +bool send_call_function_single_ipi(int cpu)
>  {
>       struct rq *rq = cpu_rq(cpu);
>
>       if (!set_nr_if_polling(rq->idle)) {
> -		trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, NULL);
>               arch_send_call_function_single_ipi(cpu);
> -	} else {
> -		trace_sched_wake_idle_without_ipi(cpu);
> +		return true;
>       }
> +
> +	trace_sched_wake_idle_without_ipi(cpu);
> +	return false;
>  }
>
>  /*
> --- a/kernel/sched/smp.h
> +++ b/kernel/sched/smp.h
> @@ -6,7 +6,7 @@
>
>  extern void sched_ttwu_pending(void *arg);
>
> -extern void send_call_function_single_ipi(int cpu);
> +extern bool send_call_function_single_ipi(int cpu);
>
>  #ifdef CONFIG_SMP
>  extern void flush_smp_call_function_queue(void);
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -163,7 +163,6 @@ void __init call_function_init(void)
>  static inline void
>  send_call_function_ipi_mask(const struct cpumask *mask)
>  {
> -	trace_ipi_send_cpumask(mask, _RET_IP_, func);
>       arch_send_call_function_ipi_mask(mask);
>  }
>
> @@ -438,11 +437,16 @@ static void __smp_call_single_queue_debu
>       struct cfd_seq_local *seq = this_cpu_ptr(&cfd_seq_local);
>       struct call_function_data *cfd = this_cpu_ptr(&cfd_data);
>       struct cfd_percpu *pcpu = per_cpu_ptr(cfd->pcpu, cpu);
> +	struct __call_single_data *csd;
> +
> +	csd = container_of(node, call_single_data_t, node.llist);
> +	WARN_ON_ONCE(!(CSD_TYPE(csd) & (CSD_TYPE_SYNC | CSD_TYPE_ASYNC)));
>
>       cfd_seq_store(pcpu->seq_queue, this_cpu, cpu, CFD_SEQ_QUEUE);
>       if (llist_add(node, &per_cpu(call_single_queue, cpu))) {
>               cfd_seq_store(pcpu->seq_ipi, this_cpu, cpu, CFD_SEQ_IPI);
>               cfd_seq_store(seq->ping, this_cpu, cpu, CFD_SEQ_PING);
> +		trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, csd->func);
>               send_call_function_single_ipi(cpu);
>               cfd_seq_store(seq->pinged, this_cpu, cpu, CFD_SEQ_PINGED);
>       } else {
> @@ -487,6 +491,27 @@ static __always_inline void csd_unlock(s
>
>  static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
>
> +static __always_inline
> +bool raw_smp_call_single_queue(int cpu, struct llist_node *node)
> +{
> +	/*
> +	 * The list addition should be visible to the target CPU when it pops
> +	 * the head of the list to pull the entry off it in the IPI handler
> +	 * because of normal cache coherency rules implied by the underlying
> +	 * llist ops.
> +	 *
> +	 * If IPIs can go out of order to the cache coherency protocol
> +	 * in an architecture, sufficient synchronisation should be added
> +	 * to arch code to make it appear to obey cache coherency WRT
> +	 * locking and barrier primitives. Generic code isn't really
> +	 * equipped to do the right thing...
> +	 */
> +	if (llist_add(node, &per_cpu(call_single_queue, cpu)))
> +		return send_call_function_single_ipi(cpu);
> +
> +	return false;
> +}
> +
>  void __smp_call_single_queue(int cpu, struct llist_node *node)
>  {
>  #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
> @@ -503,19 +528,28 @@ void __smp_call_single_queue(int cpu, st
>  #endif
>
>       /*
> -	 * The list addition should be visible to the target CPU when it pops
> -	 * the head of the list to pull the entry off it in the IPI handler
> -	 * because of normal cache coherency rules implied by the underlying
> -	 * llist ops.
> -	 *
> -	 * If IPIs can go out of order to the cache coherency protocol
> -	 * in an architecture, sufficient synchronisation should be added
> -	 * to arch code to make it appear to obey cache coherency WRT
> -	 * locking and barrier primitives. Generic code isn't really
> -	 * equipped to do the right thing...
> -	 */
> -	if (llist_add(node, &per_cpu(call_single_queue, cpu)))
> -		send_call_function_single_ipi(cpu);
> +	 * We have to check the type of the CSD before queueing it, because
> +	 * once queued it can have its flags cleared by
> +	 *   flush_smp_call_function_queue()
> +	 * even if we haven't sent the smp_call IPI yet (e.g. the stopper
> +	 * executes migration_cpu_stop() on the remote CPU).
> +	 */
> +	if (trace_ipi_send_cpumask_enabled()) {
> +		call_single_data_t *csd;
> +		smp_call_func_t func;
> +
> +		csd = container_of(node, call_single_data_t, node.llist);
> +
> +		func = sched_ttwu_pending;
> +		if (CSD_TYPE(csd) != CSD_TYPE_TTWU)
> +			func = csd->func;
> +
> +		if (raw_smp_call_single_queue(cpu, node))
> +			trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, func);

So I went with the tracepoint being placed *before* the actual IPI gets
sent to have a somewhat sane ordering between trace_ipi_send_cpumask() and
e.g. trace_call_function_single_entry().

Packaging the call_single_queue logic makes the code less horrible, but it
does mix up the event ordering...


> +		return;
> +	}
> +
> +	raw_smp_call_single_queue(cpu, node);
>  }
>
>  /*
> @@ -983,10 +1017,13 @@ static void smp_call_function_many_cond(
>                * number of CPUs might be zero due to concurrent changes to the
>                * provided mask.
>                */
> -		if (nr_cpus == 1)
> +		if (nr_cpus == 1) {
> +			trace_ipi_send_cpumask(cpumask_of(last_cpu), _RET_IP_, func);
>                       send_call_function_single_ipi(last_cpu);

This'll yield an IPI event even if no IPI is sent due to the idle task
polling, no?

> -		else if (likely(nr_cpus > 1))
> -			send_call_function_ipi_mask(cfd->cpumask_ipi);
> +		} else if (likely(nr_cpus > 1)) {
> +			trace_ipi_send_cpumask(mask, _RET_IP_, func);
> +			send_call_function_ipi_mask(mask);
> +		}
>
>               cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->pinged, this_cpu, CFD_SEQ_NOCPU, CFD_SEQ_PINGED);
>       }

