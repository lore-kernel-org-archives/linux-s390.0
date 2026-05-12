Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E1B49253D
	for <linux-s390@vger.kernel.org>; Tue, 12 May 2026 08:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778574458; cv=none; b=f66jxnb2XqynUdCHMGn22nyh8ULbU7HPBH88vXlXuyK4aO7QYfAfgQ34gat7iGSdDEaVuWyDu61pEOZyQh7jTNp7bk4zB2gTHtE4RqMzJ6nnykrPNBkTwtrG6Ly0bCEcF48yUtXJ1Jby0+8ZnvtlwkHxCS3QCCdB0tBaYHiffbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778574458; c=relaxed/simple;
	bh=3f3TWl/FMyDabHUfcf1LYXSNUp/KGmnxIWuBbs4atEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l0cxDwHdcImUsZ2WiPjiAzsTqInjIKJweIe1KOp1Edh3q2788nyXIqCBW/yhogkQIqS62mB+LyTK0SL6mx+wi1jPyZY5ZtNeTuFOOixUWU+fcYnRbXiTwYiP1mZ8fscZ2SMbTxObbmn1qnBvdQiAenEDYR0jZwCFUuuOY172CHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GoM7TNvn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GoM7TNvn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778574455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNx0TFbbiCBLwtVn8Zame8DbRPfhYzAJuNIRgs2yuOA=;
	b=GoM7TNvnn35I1AY3ANZMqf3CYujh/MmoZZG1TEyy8OUY1oeQ4i51L7P3b0fV4iUK1rd9xA
	9Vudwjgw/JI6XEanLsd+HshCqmZ43gjUF2BPjDcNdZkqE7c9k89UyMdME3rLPJV3vhejH9
	I4JuVN1sx0FAoOQcQeq5nfRPeQctsVw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-226-pdQZZTbpP0WDI5-TwzXooQ-1; Tue,
 12 May 2026 04:27:34 -0400
X-MC-Unique: pdQZZTbpP0WDI5-TwzXooQ-1
X-Mimecast-MFC-AGG-ID: pdQZZTbpP0WDI5-TwzXooQ_1778574451
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E7851956095;
	Tue, 12 May 2026 08:27:31 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.142])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 797D418004A3;
	Tue, 12 May 2026 08:27:25 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: alibuda@linux.alibaba.com
Cc: davem@davemloft.net,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	mjambigi@linux.ibm.com,
	horms@kernel.org,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com,
	pasic@linux.ibm.com
Subject: Re: [PATCH net-next 2/2] net/smc: reduce TX slot contention with exclusive wait
Date: Tue, 12 May 2026 10:26:43 +0200
Message-ID: <20260512082643.89020-1-pabeni@redhat.com>
In-Reply-To: <20260508063718.101622-3-alibuda@linux.alibaba.com>
References: <20260508063718.101622-3-alibuda@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net/smc: reduce TX slot contention with exclusive wait

This patch replaces the non-exclusive wait_event_interruptible_timeout()
in smc_wr_tx_get_free_slot() with an open-coded exclusive wait loop via
prepare_to_wait_exclusive(), so wake_up() on a freed TX slot wakes only
a single waiter instead of the entire wait queue.

> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index 48037a3d97a3..0a6f2befb0e2 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
> @@ -171,17 +173,27 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
>  		if (rc)
>  			return rc;
>  	} else {
> -		rc = wait_event_interruptible_timeout(
> -			link->wr_tx_wait,
> -			!smc_link_sendable(link) ||
> -			lgr->terminating ||
> -			(smc_wr_tx_get_free_slot_index(link, &idx) != -EBUSY),
> -			SMC_WR_TX_WAIT_FREE_SLOT_TIME);
> -		if (!rc) {
> -			/* timeout - terminate link */
> -			smcr_link_down_cond_sched(link);
> -			return -EPIPE;
> +		rc = 0;
> +		for (;;) {
> +			prepare_to_wait_exclusive(&link->wr_tx_wait, &wait,
> +						  TASK_INTERRUPTIBLE);
> +			if (!smc_link_sendable(link) || lgr->terminating ||
> +			    smc_wr_tx_get_free_slot_index(link, &idx) != -EBUSY)
> +				break;
> +			timeout = schedule_timeout(timeout);
> +			if (!timeout) {
> +				/* timeout - terminate link */
> +				smcr_link_down_cond_sched(link);
> +				break;
> +			}
> +			if (signal_pending(current)) {
> +				rc = -ERESTARTSYS;
> +				break;
> +			}

[High]
With exclusive waiters, wake_up() on link->wr_tx_wait wakes only one
task per freed slot. If that waiter is about to exit via the
signal_pending() branch, can the freed slot be lost to the remaining
sleepers?

Consider two exclusive waiters A and B asleep in schedule_timeout():

  1. smc_wr_tx_put_slot() -> wake_up(&link->wr_tx_wait) is effectively
     __wake_up(..., nr_exclusive=1).  default_wake_function makes A
     runnable, autoremove_wake_function pulls A off the queue, and
     __wake_up_common stops -- B is not woken.

  2. A signal is delivered to A before it actually runs.  Because A is
     already TASK_RUNNING, signal_wake_up only sets TIF_SIGPENDING.

  3. A returns from schedule_timeout() with timeout > 0, so the
     !timeout branch is skipped.  signal_pending(current) is true, so
     the loop sets rc = -ERESTARTSYS and breaks without re-testing
     smc_wr_tx_get_free_slot_index() and without issuing any wake_up()
     on the way out.

  4. B stays asleep on the wait queue even though the wr_tx_mask bit
     for the freed slot is still available.  With no further
     completions, B sleeps until the full SMC_WR_TX_WAIT_FREE_SLOT_TIME
     expires, at which point smcr_link_down_cond_sched() tears down an
     otherwise healthy link.

The previous wait_event_interruptible_timeout() was non-exclusive, so
every waiter was woken on each wake_up() and re-evaluated the
condition, which avoided this class of lost-wakeup.

Should the signal path re-check the slot condition before returning,
or issue a wake_up() on exit so another exclusive waiter gets a chance
at the slot?

[Medium]
The commit message says this is a contention optimization and that
"teardown behavior is unchanged", but does it also change the errno
returned to callers on signal delivery?

Before this patch, wait_event_interruptible_timeout() returned
-ERESTARTSYS on signal; that value is non-zero, so the old if (!rc)
branch was skipped, control fell through to the trailing
if (idx == link->wr_tx_cnt) return -EPIPE, and callers saw -EPIPE.

After the patch, the signal path does:

    if (signal_pending(current)) {
        rc = -ERESTARTSYS;
        break;
    }
    ...
    finish_wait(&link->wr_tx_wait, &wait);
    if (rc)
        return rc;

so -ERESTARTSYS propagates up through smc_cdc_get_free_slot() (which
only remaps rc to -EPIPE when conn->killed is set),
smcr_cdc_get_slot_and_msg_send(), smc_cdc_get_slot_and_msg_send() and
smc_tx_sendmsg(), meaning userspace sees syscall restart / -EINTR
instead of -EPIPE.

Note that the sibling smc_wr_reg_send() in the same file explicitly
converts -ERESTARTSYS to -EINTR.  Should this return-code change be
called out in the commit message (and possibly split out), given that
the stated intent of the patch is purely to reduce contention?

[Low]
On timeout expiry the new loop takes the teardown path without
re-testing whether a slot became available:

> +			timeout = schedule_timeout(timeout);
> +			if (!timeout) {
> +				/* timeout - terminate link */
> +				smcr_link_down_cond_sched(link);
> +				break;
> +			}

The old wait_event_interruptible_timeout() expansion re-evaluated the
condition via ___wait_cond_timeout after schedule_timeout() returned
0, so a wake_up() racing with timer expiry could still report success
and let smc_wr_tx_get_free_slot_index() claim the slot.

In the narrow race where a slot is freed at the same instant the
timer fires, does this now tear the link down even though a slot was
actually available?

>  		}
> +		finish_wait(&link->wr_tx_wait, &wait);
> +		if (rc)
> +			return rc;
>  		if (idx == link->wr_tx_cnt)
>  			return -EPIPE;
>  	}
-- 
This is an AI-generated review.

