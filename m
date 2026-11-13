Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597921;
	b=Kz2Inl6YbDWij3KRTuuTscdSWqgRBFoove/r78u8hBk0zVDmPSn6c5QNqXOHTB36Z3/z
	 nSXle9YYWviQtUYcKb37xUTDv1SNm/Ss8jD6b+ddU2cLKJif4/j1wbRqDH2cdwlVVpJi/
	 6wPzpTFJ6PcjiTkdJZlqWeSXoqbJbX0Pme0xE4miaxfP87XlRs6EGbjTIqTW/BNrby1wQ
	 oIGhRrmsNN+b8flU2JUVV9Excns/dIvKtz55uBWgGyeqyDgB+vEyzqrwFuXHdvtf08U0H
	 lC4HfMNhJXSaQy8AnpUoBSM+adVo9VC2AJS2WYaY90fJQFZA30HrRkCgp9RtLxRauEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597921;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XqFFiXg0waDM2nHN+tCwx8QjipnGWtW/TfsqhTs+5GU=;
	b=Ah2czeBTjDSQujw3MKTNBe5e4Hni77mR4sXkH4DB2w37BbavlhKtD8KVL843ZSAFyAzP
	 NhRZnullEj53QzuwYIbNWTHNTp44a5slgLmLYW9nxooF/39YunfuJUliCIz/m20t52MPm
	 /p12VzGHy1/ZNN7kySDSuyO6P3ZHvISxJJeRt/TNJg1cDk5zxKtrkEZD1RlyI5xdsww1Y
	 X0pRecksKPEFDUMmKf/KZmKRILIMkpiZcXVwywAp/QCXOsvDAp01xDUhxAAhT16Ys9jxt
	 0Im0Tb7Stt2gGHLUyvETttrcix9WMH2QYCL7z7y39QJUmd7dLPZuh2ed2Sih5DasEcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Jr/AeqTT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36142606A334
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jr/AeqTT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 763551F000C4;
	Fri, 13 Nov 2026 19:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597920;
	bh=XqFFiXg0waDM2nHN+tCwx8QjipnGWtW/TfsqhTs+5GU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jr/AeqTTpplEFncZTG97CuWSz/IS7R8/h7WzjlVFlRf5q5WK8KCIWbsKT/D9gYXo6
	 4kkmhNOI9Hiyj6MOeQ1AeITMe6u/ocsiCX03+DjY+7kwJnQf4g/ZTlkKXuKDjl9Cs0
	 ZUr89peEUtiiAYdj/y8FHLyuCYmBp2Hpsumrp2S7NSXPs+Qu/ktR4Hdp5+wS7K5iwm
	 AaX93GjEposEc5bcae2PJ8Uw4mQ0OUCAdQWMPHZbk2Pr0e0TTTWMzFVaPXn3tXbsJ/
	 y68WzHezYGwuDhYhzGVVjCeKB20OXDWQfcK3eblR5kRG2j5DLA1YWYFwisvWZV+tt3
	 mdR3BTLFRHa7w==
Message-ID: <sashiko-outbox-213549@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/7] cpu: make preferred CPU policy writers mutually
 exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261113184257.621707-8-ynorov@nvidia.com>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-8-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 19:25:20 +0000
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
- [Low] cpumask: preferred_cpumask_owned_by(NULL) returns true when
  unclaimed
--

commit 62477968d02f2aaa9afd9c7a8010ab357c98eb83
Author: Yury Norov <ynorov@nvidia.com>

cpu: make preferred CPU policy writers mutually exclusive

This commit adds helpers to claim, release, and check exclusive ownership of
the preferred CPU mask, and updates steal_governor to use them.

> diff --git a/lib/cpumask.c b/lib/cpumask.c
> index 2e16e19a2bdb6..ee710c3c89201 100644
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
[ ... ]
> @@ -170,4 +172,64 @@ EXPORT_SYMBOL(cpumask_any_distribute);
>  #ifdef CONFIG_PREFERRED_CPU
>  DEFINE_MUTEX(cpu_preferred_mutex);
>  EXPORT_SYMBOL_GPL(cpu_preferred_mutex);
> +
> +static const void *preferred_cpumask_owner;
> +
> +/**
> + * preferred_cpumask_owned_by - test preferred CPU policy ownership
> + * @owner: policy identity
> + *
> + * Return: true if @owner holds the policy, false otherwise.
> + */
> +bool preferred_cpumask_owned_by(const void *owner)
> +{
> +	lockdep_assert_held(&cpu_preferred_mutex);
> +
> +	return preferred_cpumask_owner =3D=3D owner;
> +}
> +EXPORT_SYMBOL_GPL(preferred_cpumask_owned_by);
> +
> +/**
> + * claim_preferred_cpumask - acquire exclusive preferred CPU policy owne=
rship
> + * @owner: non-NULL identity that remains valid until ownership is relea=
sed
> + *
> + * Call before starting policy work, normally on module init.
> + *
> + * Return: 0 on success, -EBUSY if claimed, or -EINVAL for a NULL identi=
ty.
> + */
> +int claim_preferred_cpumask(const void *owner)
> +{
> +	if (!owner)
> +		return -EINVAL;
> +
> +	guard(cpus_read_lock)();
> +	guard(mutex)(&cpu_preferred_mutex);
> +
> +	if (preferred_cpumask_owner)
> +		return -EBUSY;
> +
> +	preferred_cpumask_owner =3D owner;
> +	reset_preferred_cpumask();
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(claim_preferred_cpumask);
> +
> +/**
> + * release_preferred_cpumask - release exclusive preferred CPU policy ow=
nership
> + * @owner: identity used to claim ownership
> + *
> + * Call after stopping policy work, normally on module exit.
> + */
> +void release_preferred_cpumask(const void *owner)
> +{
> +	guard(cpus_read_lock)();
> +	guard(mutex)(&cpu_preferred_mutex);
> +
> +	if (WARN_ON_ONCE(!owner || !preferred_cpumask_owned_by(owner)))
> +		return;

[Severity: Low]
Does preferred_cpumask_owned_by(NULL) return true when no policy driver owns
the preferred cpumask?  Checking owner && preferred_cpumask_owner =3D=3D ow=
ner in
preferred_cpumask_owned_by() would also avoid needing the separate !owner
check in release_preferred_cpumask().

Also, the kernel-doc comments for preferred_cpumask_owned_by(),
claim_preferred_cpumask(), and release_preferred_cpumask() do not mention
their locking expectations (holding cpu_preferred_mutex for
preferred_cpumask_owned_by(), and acquiring cpus_read_lock() and
cpu_preferred_mutex internally in the claim/release helpers).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113184257.6217=
07-2-ynorov@nvidia.com?part=3D7
