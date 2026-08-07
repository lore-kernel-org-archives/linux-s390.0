Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACAF44D6BB
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 06:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085000; cv=none; b=kenZEHQTt2IIuhEFb+gkg1PB/+Ylj/PCKMvG/y9C/i+w+0/ALCPu3/+iI0YbT04Gr/aMo84OBkZQ9fEPDe7ERdY4zAjG2j/+HM6LmuAf8zgScXZaBpG+F4l2i1J+86KsuOlYic4HJ2saHXZV0M5UCq2rwNr59JrqsJNW6YS1PQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085000; c=relaxed/simple;
	bh=l4hchkhj/AbwtN1P2FRNMcVa62106kqLMJs5XRUVVjI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YClK0cWEnWbHpayZkFDGitr4ocCHe6jkYvU5HsPaRf1z39P/Hn9PgFyu5J4n+zSXuq82sew9OoYiVfvjTVXULnFCS37v7kGzMikmgaNLTm6x7v5A3L9z9Q8wbSbSwf7rUhO4YfBakKOSVQkobtRW1yGuVAtcADidxecjvDP5BmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jpl2H8wm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jpl2H8wm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F701F000E9;
	Fri,  7 Aug 2026 06:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786084996;
	bh=IedOI36L9K8BOGeBPHv2UO1I3EqMtNgfAmRBs2zlTUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jpl2H8wm57D+Jil9rRUbfQf/RHBlJIfzSeavUTY+XbwJM+f5BiDPAlid3FyOsFrmM
	 NyygA1yJklIZ3VtAStRu3gmsmJ9O/jpsWc8RQgvz9eAOTRepzfQfC8N9QAkylN/Oee
	 syfPfxi32KLU9StY8PW30VS92hyL33zMJtl69rlAFEDB5/Py9N5fg7Mj2/nmol6Ajh
	 WzeytXx0+NaBluSxr0Rlh1wc5ab6ZfVQfjWo+9oNWC0aIO2OAXWXdY/CFnFELpamZF
	 6CMJ21IVDxSeTaM8b825cg50ZtJdgzM2OqwWVGbnkbHFSOkbdMzqg8pAzU8u5z8bQQ
	 sLX2kfS+2Dq4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v1 2/2] net/smc: reduce TX slot contention with
 exclusive wait
Reply-To: sashiko-reviews@lists.linux.dev
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260806064252.39180-3-alibuda@linux.alibaba.com>
References: <20260806064252.39180-1-alibuda@linux.alibaba.com>
 <20260806064252.39180-3-alibuda@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 06:43:15 +0000
Message-Id: <20260807064316.11F701F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The open-coded exclusive wait loop introduces a lost wakeup vulner=
ability by failing to check the condition before enqueuing.

Pre-existing issues:
- [High] Returning -ERESTARTSYS from smc_wr_tx_get_free_slot causes silent =
data stalling because the caller does not schedule tx_work to retry, and th=
e error is ignored by sendmsg.
--

--- Patch [2]: [PATCH net-next v1 2/2] net/smc: reduce TX slot contention w=
ith exclusive wait ---
commit bcc5b21bf03b53f401940337c34d2ab052835d45
Author: D. Wythe <alibuda@linux.alibaba.com>

net/smc: reduce TX slot contention with exclusive wait

This patch modifies smc_wr_tx_get_free_slot() to use an exclusive wait loop=
=20
using prepare_to_wait_exclusive(). It also updates the return value on a=20
pending signal from -EPIPE to -ERESTARTSYS to match standard wait semantics.

> diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
> index 6b5add9229937..2cdd4063c13d6 100644
> --- a/net/smc/smc_wr.c
> +++ b/net/smc/smc_wr.c
[ ... ]
> @@ -212,17 +214,31 @@ int smc_wr_tx_get_free_slot(struct smc_link *link,
>  		if (rc)
>  			return rc;
>  	} else {
> -		rc =3D wait_event_interruptible_timeout(
> -			link->wr_tx_wait,
> -			!smc_link_sendable(link) ||
> -			lgr->terminating ||
> -			(smc_wr_tx_get_free_slot_index(link, &idx) !=3D -EBUSY),
> -			SMC_WR_TX_WAIT_FREE_SLOT_TIME);
> -		if (!rc) {
> -			/* timeout - terminate link */
> -			smcr_link_down_cond_sched(link);
> -			return -EPIPE;
> +		rc =3D 0;
> +		for (;;) {
> +			prepare_to_wait_exclusive(&link->wr_tx_wait, &wait,
> +						  TASK_INTERRUPTIBLE);
> +			if (!smc_link_sendable(link) || lgr->terminating ||
> +			    smc_wr_tx_get_free_slot_index(link, &idx) !=3D -EBUSY)
> +				break;

[Severity: High]
Does this open-coded exclusive wait loop introduce a lost wakeup regression?

By calling prepare_to_wait_exclusive() before checking if a slot is availab=
le,
the task is unconditionally added to the waitqueue. If it then finds a free
slot immediately and breaks, it remains on the waitqueue until finish_wait(=
) is
called.

If another slot is freed concurrently, an exclusive wake_up() could wake th=
is
exiting task and stop iterating. This absorbs the wakeup and starves other
threads that are actually sleeping on the queue.

This could cause a 10-second stall for the starved thread, leading to a link
termination via smcr_link_down_cond_sched().

> +			timeout =3D schedule_timeout(timeout);
> +			/* re-check */
> +			if (!smc_link_sendable(link) || lgr->terminating ||
> +			    smc_wr_tx_get_free_slot_index(link, &idx) !=3D -EBUSY)
> +				break;
> +			if (!timeout) {
> +				/* timeout - terminate link */
> +				smcr_link_down_cond_sched(link);
> +				break;
> +			}
> +			if (signal_pending(current)) {
> +				rc =3D -ERESTARTSYS;
> +				break;
> +			}

[Severity: High]
This is a pre-existing issue, but does returning -ERESTARTSYS
here cause silent data stalling if the caller does not schedule a retry?

If we look at smcr_tx_sndbuf_nonempty() in net/smc/smc_tx.c, it only schedu=
les
tx_work if the return value is -EBUSY:

	if (rc =3D=3D -EBUSY) {
		...
		mod_delayed_work(conn->lgr->tx_wq, &conn->tx_work,
                                 SMC_TX_WORK_DELAY);
	}
	return rc;

And in smc_tx_sendmsg() in net/smc/smc_tx.c, the return value is ignored:

	if (!smc_tx_should_cork(smc, msg))
		smc_tx_sndbuf_nonempty(conn);

If the syscall is interrupted by a signal, and the data was already copied =
to
sndbuf, smc_tx_sendmsg() ignores the return value and returns success to
userspace. Since tx_work is not scheduled for -ERESTARTSYS, the data could =
be
permanently stuck in the buffer.

>  		}
> +		finish_wait(&link->wr_tx_wait, &wait);
> +		if (rc)
> +			return rc;
>  		if (idx =3D=3D link->wr_tx_cnt)
>  			return -EPIPE;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806064252.3918=
0-1-alibuda@linux.alibaba.com?part=3D2
