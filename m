Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597704;
	b=bhRyidShxW689Y7afwCsYBK9kDlfPfICthBaT404uPlquj22K26eKHF3P/8RbHtQx6e0
	 FV2OoZBVxWOujdJ2zYU7zbyAnqTEUEWYsFzKlV6rbqcZv4yNDJvxymH7F94hIwPaGxG/7
	 C39EaQ31cNDF0tT2EcZ0z7APOhE2fM3gUlm2hj1WkU1NDU3oLv6OJ7FzA7X70yBRntHrB
	 e6SPp4SIBQywUNzq8/fyq7ektXaOyWeF+xM3Z26ZhZu04cKRmS24fmf+9oP+0OqEdwPRW
	 FecGGQ4rknDll1OauUMbTqd0pXJZsZ0Nfqohvq+8QG5SUvZkp7lvpu2nVPhAnBp0q5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597704;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HDg0Z1aMRA6BdNjxfmZXkrPyQXk/DTX6fowUNDviSvQ=;
	b=b9GKY23hPbempCi5xTNkFI3Knu1RPi6SrvdC5vm8u9Yr5SAktX1TyVdVrwje5i7s1sTT
	 CN7DdilycCAVAjcODUNhyD8ojypht56JzGzIbwRwNpxgdPYWkCANxx8KLekDcm2atMpDY
	 CN1wryC90IqeI9Y1nH1fPjk93ZejrD07G/31oS7J9e72V1x5ZDXDH4f8zYlDQJSHGoyN5
	 IR74PWNBOKLiYljX+ey0S4wRMkB/VriSbQIvbakWgF/0V6b2MVBKUUrNNsFf4/vrNBKMv
	 3NwzLt+u9iat1AFwaKkgvE971ye/115s1lMbVDbXRygMWPfDsLxamYTCstett9EpBdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+Voe2RQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D23606A332
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+Voe2RQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654541F000C4;
	Fri, 13 Nov 2026 19:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597703;
	bh=HDg0Z1aMRA6BdNjxfmZXkrPyQXk/DTX6fowUNDviSvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n+Voe2RQe+LyCvPfQlK6HVlO9cmGLy5tAVjU5ySLoMO3ghAPmjrZdeuUeSYRJ0G8K
	 W9L3I2/Qqyve5il53cT6BW4OO8RPAv4+R44aW35X1TtAfXVLm8K0+8v2RRv5GckD++
	 33n6vFZWuzauWewdUYRaJj32eOILrdlhnqcesfeYvYRDAwpiIkRbt0HOUGnmTKyoZ6
	 Y94YxVqiA5Wc7TQgkIKPP5N1UHAYYxHN7NO9UIXStzJMit0ecihO1Z7hYYedJ+RefX
	 ijvE8wAdcew3NXHAVlITSx64G7nREDFpymegb2v+FyR5vWBUJ6ZyaTGLm0uQtgMN2s
	 BjG2okfQTU70A==
Message-ID: <sashiko-outbox-213542@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/7] virt: steal_governor: restart sampling immediately
 after CPU hotplug
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261113184257.621707-7-ynorov@nvidia.com>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-7-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:21:42 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] virt: steal_governor: deprecated system_wq use and workqueue
  mismatch
--

commit 71c885eda2b0a72a307fd87b15575e6e5a4178ed
Author: Yury Norov <ynorov@nvidia.com>

virt: steal_governor: restart sampling immediately after CPU hotplug

This commit registers a CPU hotplug callback to invalidate the current
steal-time sample and immediately requeue the governor work when a CPU
goes online or offline.

> diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
> index c34d91267ec1d..f71dbf27e4a9d 100644
> --- a/drivers/virt/steal_governor.c
> +++ b/drivers/virt/steal_governor.c
[ ... ]
> @@ -217,6 +220,13 @@ static bool preferred_cpus_valid(void)
>  	return true;
>  }
> =20
> +static int hotplug_callback(unsigned int cpu)
> +{
> +	sg_ctx.sample_invalidated =3D true;
> +	mod_delayed_work(system_wq, &sg_ctx.work, 0);
> +	return 0;
> +}
> +
>  static void steal_governor_loop(struct work_struct *work)
>  {
>  	u64 curr_steal, delta_steal, delta_ns, steal_ratio;
> @@ -233,6 +243,11 @@ static void steal_governor_loop(struct work_struct *=
work)
>  	sg_ctx.steal =3D curr_steal;
>  	sg_ctx.time =3D now;
> =20
> +	if (sg_ctx.sample_invalidated) {
> +		sg_ctx.sample_invalidated =3D false;
> +		goto requeue_work;
> +	}
> +
>  	/*
>  	 * steal_ratio =3D (delta_steal * 100*100)/(delta_ns * num_cpus())
>  	 * To avoid possible overflow, divide the denominator early.
> @@ -254,11 +269,14 @@ static void steal_governor_loop(struct work_struct =
*work)
>  		return;
>  	}
> =20
> -	schedule_delayed_work(&sg_ctx.work, sg_ctx.delay);
> +requeue_work:
> +	mod_delayed_work(system_wq, &sg_ctx.work, sg_ctx.delay);
>  }

[Severity: Medium]
Should both mod_delayed_work() calls use system_percpu_wq instead of
system_wq?

system_wq is allocated with __WQ_DEPRECATED, so queueing sg_ctx.work onto
it triggers a pr_warn_once() deprecation warning in __queue_work().

In addition, steal_governor_init() queues sg_ctx.work onto
system_percpu_wq via schedule_delayed_work(), which is a separate
workqueue_struct from system_wq.  Because __queue_work() only enforces
cross-CPU non-reentrancy when worker->current_pwq->wq =3D=3D wq, a hotplug
event during the first execution of steal_governor_loop() can queue
sg_ctx.work on a second CPU while it is still running on the first:

CPU0 (system_percpu_wq)           CPU1 (hotplug)
steal_governor_loop()
  guard(cpus_read_lock)()
    (blocks on cpus_write_lock)
                                  hotplug_callback()
                                    sg_ctx.sample_invalidated =3D true
                                    mod_delayed_work(system_wq, ..., 0)
                                      (wq !=3D current_pwq->wq, queues on C=
PU1)
                                  cpus_write_unlock()
  sg_ctx.sample_invalidated =3D false
  ...
                                  steal_governor_loop()
                                    guard(cpus_read_lock)()
                                    (sample_invalidated is false, delta_ns =
~ 0)
                                    increase_preferred_cpus()  <-- bogus sa=
mple

When the second worker runs right after the first finishes,
sample_invalidated has already been cleared and delta_ns is near zero,
yielding steal_ratio =3D=3D 0 and calling increase_preferred_cpus()
prematurely.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113184257.6217=
07-2-ynorov@nvidia.com?part=3D6
