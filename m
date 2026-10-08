Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4203E8351
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449128; cv=none; b=dnXzyOhepaHjE1wj4cOcEgQ99YCaRdO2/AP1qbeXANcv0W3saqUnWZn45+8g0orYMX0a55MeL1nWt6uYOoEzXd9dCFZk1TfmjYCdkyuLMMLA4YErhrr2Twa2sf/FjOhouMD/GCp+VnHjy8GPqQQ40rBfHhrFWvnk8wHcx5pRXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449128; c=relaxed/simple;
	bh=MEmd7hDk4aRqIG5K7Czjs0twuIe/SkjKQWB+Hgv0Rlk=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=SxOXuUDJd9/8+vouAw9sVhGIFLaH9Cf+vqA7lw3a3v52Cr4o7MzwxlsGzIW1aHtjKPBMiWiRk2R44iwf4cbJjcVaTyzXRnZ8fE9DnOclZaOGOlRQUG23t2MCePSt3O+dk1ksguEhqUtleiR0AtB4XP+DYQR2TPR1vl6sPsTYk4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErpH59hy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErpH59hy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C294B1F000FF;
	Thu,  8 Oct 2026 08:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791449127;
	bh=3VuDHmYrgF8nZfcIg274JbQWl9zQ7I/Q50M9J8CpJDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ErpH59hy/i78mCBGjHLp+/6+mT4VEj1WnmkFJziyATmBSMADHJN9GKOn6mZ9ybw4t
	 3bXG20JZQWXNhm6j+EdpkPLUAqrovcycWRtR46SOoUSEmd04a9CktvzZp1uShyEPSW
	 rEUu8VpbpEG6Zcj0FfwoG7WwqW6Cn6UWjT+Ycw8OTPctuN0KXnCggMb6r9amKV3qR1
	 K4F2VSAUg4MrJjAdj1Oi/Q580yOvq7LjkAs87DfucdGbJxWsvVCBQSt69LdCDPVT4C
	 P1YC8H6RFUfgZ9xXnaQVlkF5x2ULAGbdsNfep9q0AmIAVy+spcb4VrgkmYkuvcAg7x
	 ubcXHxYK2KKow==
Message-ID: <sashiko-outbox-163852@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 1/2] kernel/sched: Introduce idle SMT priority
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261008-hiperdispatchfix-v1-1-73fe41081070@linux.ibm.com>
References: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
 <20261008-hiperdispatchfix-v1-1-73fe41081070@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 08:45:26 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] sched: Unintended loss of SMT balancing within same-capacity clust=
ers during wakeup
--

commit e7b6978e87f4966f837633079b0ad5b78914e3c2
Author: Mete Durlu <meted@linux.ibm.com>

kernel/sched: Introduce idle SMT priority

On systems with asymmetric CPU capacities and SMT, this patch introduces
SCHED_IDLE_SMT_PRIO to allow architectures to prefer idle SMT siblings of
busy high-capacity cores over fully idle low-capacity cores.

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7455a83a6a990..3e21233ee2ce2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8813,11 +8813,14 @@ static int
>  select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int=
 target)
>  {
>  	/*
> -	 * On !SMT systems, has_idle_core is always false and preferred_core
> -	 * is always true (CPU =3D=3D core), so the SMT preference logic below
> -	 * collapses to the plain capacity scan.
> -	 */
> -	bool has_idle_core =3D sched_smt_active() && test_idle_cores(target);
> +	 * On !SMT systems or when idle SMT thread priority is active,
> +	 * has_idle_core is always false and preferred_core is always true
> +	 * (CPU =3D=3D core), so the SMT preference logic below collapses to the
> +	 * plain capacity scan.
> +	 */
> +	bool has_idle_core =3D sched_smt_active() &&
> +			     !sched_idle_smt_prio_active() &&
> +			     test_idle_cores(target);

[Severity: High]
By unconditionally setting has_idle_core to false here when
sched_idle_smt_prio_active() is true, does this bypass idle core detection
system-wide for all capacities?

[ ... ]

> @@ -8860,8 +8863,8 @@ select_idle_capacity(struct task_struct *p, struct =
sched_domain *sd, int target)
> =20
>  		/*
>  		 * Perfect fit: capacity satisfies util + uclamp and the CPU
> -		 * sits on a fully-idle SMT core, this is a !SMT system, or
> -		 * there is no idle core to find.
> +		 * sits on a fully-idle SMT core, this is a !SMT system, idle
> +		 * smt priority is active, or there is no idle core to find.
>  		 * Short-circuit the rank-based selection and return
>  		 * immediately.
>  		 */

[Severity: High]
Since has_idle_core is now false, preferred_core will evaluate to true
for all CPUs scanned.

Could this cause the loop below:

    if (fits > 0 && preferred_core)
        return cpu;

to short-circuit prematurely and return an idle SMT thread of a busy core,
failing to scan for fully idle cores of the identical capacity? This appears
to lead to an unintended loss of SMT balancing within same-capacity clusters
during wakeup.

[ ... ]

> @@ -8936,15 +8939,17 @@ static inline bool asym_fits_cpu(unsigned long ut=
il,
>  		 * Return true only if the cpu fully fits the task requirements
>  		 * which include the utilization and the performance hints.
>  		 *
> -		 * When SMT is active, also require that the core has no busy
> -		 * siblings.
> +		 * When SMT is active or idle SMT priority is disabled, also
> +		 * require that the core has no busy siblings.
>  		 *
>  		 * Note: gating on is_core_idle() also makes the early-bailout
>  		 * candidates in select_idle_sibling() (target, prev,
>  		 * recent_used_cpu) idle-core-aware on ASYM+SMT, which the
>  		 * NO_ASYM path does not do.
>  		 */
> -		return (!sched_smt_active() || is_core_idle(cpu)) &&
> +		return (!sched_smt_active() ||
> +		       sched_idle_smt_prio_active() ||
> +		       is_core_idle(cpu)) &&
>  		       (util_fits_cpu(util, util_min, util_max, cpu) > 0);
>  	}

[Severity: High]
Does bypassing the is_core_idle() check here when sched_idle_smt_prio_activ=
e()
is true inadvertently allow the early-bailout candidates (target, prev,
recent_used_cpu) to further exacerbate same-capacity SMT packing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-hiperdispa=
tchfix-v1-0-73fe41081070@linux.ibm.com?part=3D1
