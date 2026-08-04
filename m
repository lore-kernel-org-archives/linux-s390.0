Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B703F54AA
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868080; cv=none; b=C1vzq3Pv+NT9OIYql9DjIBVcpuWZSfL3PEouLHjebWH9xVMFk/aoU6EOr139wMVdHiXDikMUXCUgWaKfj+wMlcBLh7xv3h8FniQDpI+idQ2oMv3ZWynU6gHhPvWlo5ASuhHf7MhEgRxaHbWv1f+7cLRwSIeNeIPdhggzexE+P7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868080; c=relaxed/simple;
	bh=e7V1PITXS5tUg/XuB0Wc6WcZ4i096u26cy9UTaN1T8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CnDaZs3AD3Ed2UPyTasuRsbXlGhlM00OogBaemxK0AHJxmRQoHl8AxoUjiptfYimP+j9xgqr5dWzmZ9+0UL6pijCQteWBXQWvv2OCObu8b37rlUek9nChas3tGcKm8yWa/qKQ5jBOk7LxyF63KxtNWUXdnR6NTeH0/76kWeOga0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JBRcbPMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JBRcbPMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19221F000E9;
	Tue,  4 Aug 2026 18:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785868079;
	bh=K3W5HzSb5MhZhe1zvY2wuHfeFfAC2TgUoHwXRF0R1wI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JBRcbPMA/GycwInyFH7/0m7JQyqAHE1oFGoY57S7zP7tpRFdDHelx516Jy+xPVaa2
	 LuZ8X7rR0NbjVzEykk2fKxA3/Df09TcLYzJycTY4I6872mIGXkVd1K2FE4vVtppMrY
	 gmvXovK71mH4n1wowrqbAADll3rLNoLtH/s7K0Ybyd7Scs64QEGcTQrDMufbXIwpXe
	 dGfMR7qyygYynJ3iX52R050uIksXA4Md6NyuECkPyEL05Vjz/HKoMI+dhuscW+0Qrp
	 Ti8sLhaH2r1nXdu0qpJEwmcbkjqhlLIShCEgZZuGYjHUQlKw9igiW2qBWy1zdpIfel
	 tt7xj7/aewsxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] s390/ctcm: Convert fsm.h to proper kernel-doc
 format
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nagamani PV" <nagamani@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260803182736.2356374-1-nagamani@linux.ibm.com>
References: <20260803182736.2356374-1-nagamani@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:27:58 +0000
Message-Id: <20260804182758.C19221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] `fsm_deltimer()` uses non-sync `timer_delete()`, which can lead to=
 a use-after-free when timers are freed during teardown.
- [High] `fsm_addtimer()` unconditionally calls `timer_setup()`, which corr=
upts the timer wheel if the timer is already active.
--

--- Patch [1]: [PATCH net-next] s390/ctcm: Convert fsm.h to proper kernel-d=
oc format ---
commit 2780dcd525cc21b0863567563af1ccbda9bf1645
Author: Nagamani PV <nagamani@linux.ibm.com>

s390/ctcm: Convert fsm.h to proper kernel-doc format

This commit converts function declarations and comments in drivers/s390/net=
/fsm.h
to proper kernel-doc format. It changes debug macros and internal comments =
to
use standard block comments and removes redundant extern keywords.

> diff --git a/drivers/s390/net/fsm.h b/drivers/s390/net/fsm.h
> index 16dc071a2973c..6a0b47ca87f0c 100644
> --- a/drivers/s390/net/fsm.h
> +++ b/drivers/s390/net/fsm.h
[ ... ]
>  /**
> - * Clears a pending timer of an FSM instance.
> + * fsm_deltimer - Clears a pending timer of an FSM instance
> + * @timer: The timer to clear
>   *
> - * @param timer The timer to clear.
> + * Stops and removes the timer. Safe to call on an inactive timer.
>   */
> -extern void fsm_deltimer(fsm_timer *timer);
> +void fsm_deltimer(fsm_timer *timer);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for this
non-synchronous timer deletion to cause a use-after-free during device
teardown?

Looking at fsm_deltimer() in drivers/s390/net/fsm.c, it uses timer_delete().
During teardown in ctcm_free_channel(), the driver calls:

ctcm_free_channel() {
        fsm_deltimer(&ch->timer);
        ...
        kfree_fsm(ch->fsm);
        kfree(ch);
}

Since timer_delete() does not wait for a concurrently executing timer
callback, could fsm_expire_timer() still be running on another CPU and
dereference ch->fsm after it has been freed by kfree_fsm()? Would it be
safer to use timer_shutdown_sync() or timer_delete_sync() here?

>  /**
> - * Adds and starts a timer to an FSM instance.
> + * fsm_addtimer - Adds and starts a timer for an FSM instance
> + * @timer: The timer to be added (timer->fi must point to the FSM instan=
ce)
> + * @millisec: Duration in milliseconds after which the timer expires
> + * @event: Event to trigger when timer expires
> + * @arg: Generic argument provided to the event handler
>   *
> - * @param timer    The timer to be added. The field fi of that timer
> - *                 must have been set to point to the instance.
> - * @param millisec Duration, after which the timer should expire.
> - * @param event    Event, to trigger if timer expires.
> - * @param arg      Generic argument, provided to expiry function.
> + * Starts a timer that will trigger the specified event after the given
> + * duration. The timer must have been initialized with fsm_settimer().
>   *
> - * @return         0 on success, -1 if timer is already active.
> + * Return: Always returns 0
>   */
> -extern int fsm_addtimer(fsm_timer *timer, int millisec, int event, void =
*arg);
> +int fsm_addtimer(fsm_timer *timer, int millisec, int event, void *arg);

[Severity: High]
This is a pre-existing issue, but does fsm_addtimer() risk corrupting the
timer wheel if called on an already active timer?

In drivers/s390/net/fsm.c, fsm_addtimer() unconditionally calls
timer_setup():

fsm_addtimer() {
        timer_setup(&this->tl, fsm_expire_timer, 0);
        ...
        add_timer(&this->tl);
}

Since timer_setup() zeros out the list entry fields, calling this on a
currently pending timer will corrupt the timer wheel list. While many
callers delete the timer first, there are paths like mpc_action_side_xid()
in drivers/s390/net/ctcm_mpc.c that invoke fsm_addtimer() without a
preceding fsm_deltimer(). Should this use mod_timer() instead to safely
handle already active timers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803182736.2356=
374-1-nagamani@linux.ibm.com?part=3D1
