Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561807;
	b=BvTp+wtIdCSFpdoQQWrPxilNR5/HsWGW6t6JOsz6rbLbQqsI22m9Is2tqWkiVz223CvP
	 gi3ZzUbrhHJoqgeBI37UhVpVr50Ym7gQ1ZIg9MI4qn5g7uLnGs/nbM3YpWqV8WbbJmHso
	 BoOKG9Cw608dM7E1CPeDXpzBUwmmSNCfWcJpi84aufu2tjqYVqFVklW5r1igmoo9Twkz+
	 YTpk0zoQDhR+5GptKIlk9o1n4t7oaDE3kxbvO+wgdNXoDB+fMt/H+G409r4CqTQFXGqQ0
	 Jh1lWAsIZJA1CBjVemLyTWqvJAgJg6Ylku0FHBAWFw3XwfXVH6fNZ8MfseenuFjCB9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561807;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tI1B5GsYdwBzx+bmM8Fk2nf13tOEeTVDCFsGK3YvUVI=;
	b=VWULqTA4xvCX370qFKGR9AfU6JTrZiVkOt51jhN+FR1hfXIpI4OPb0QtO8oeKGHTyosX
	 4YpQajivkcFP6WpUsXp84F2HhTJS/z+KO6ifLVRUzHF7IJoXLQnBAKzGLc5do6gRl6dCX
	 1+aCAEKGlATvPWT2Gf3l1+bMG7jhIiUzDVrI8sMxSL6cSMJfa0Ee/YGH3q9l4+H9BUgMa
	 zGySTroYEcYDfvCii60JOOekqx54qXiZ5dwgt03cGmb/VM1iSA+9CzsRLeN8+rKyD/Sgd
	 7LPoeY+1q+EyX62o2TgYEclMB08IXmOcwNtFjvhgctkf8RAU1OePuDOUY0t/bxvlLlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jz3kqnNq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EBC606A324
	for <linux-s390@vger.kernel.org>; Sun,  1 Nov 2026 19:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jz3kqnNq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795941F000C1;
	Sun,  1 Nov 2026 19:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793561806;
	bh=tI1B5GsYdwBzx+bmM8Fk2nf13tOEeTVDCFsGK3YvUVI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jz3kqnNqiiJ7XPQStufaBrnZS3FoagJk7TDmcYQvQTmYEYLPXCgANFZozcSB17yM/
	 84mTN13OBPyxD+k/y1spRyGnCzWGFw16cFP09+4QeWFyiXQg0vM7iiDW54gXBvfKYz
	 t0jsoErEK/+SwNdG5+KGqoTDxBA0pu3bvKxm69uHE3NQSTU6AQbb/uOVvT+tuWsTkf
	 JhWlN0h24g/BP059EPy69A8hs3PpZl+ET+frC3Q/SURcB68oGSrgRtdvmOzrgBm6at
	 yq9Syq14lRXIKI2FXm8xBvfZMilNql8byUa8sDCk4qiG9dk6boIzDjq+a/Iw+phO1C
	 Iq/P2vziwtTOg==
Message-ID: <sashiko-outbox-192624@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] virt: steal_governor: Warn on unexpected preferred
 mask states
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261101192203.6979-6-ynorov@nvidia.com>
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <20261101192203.6979-6-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 19:36:46 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] virt: steal_governor: unreachable WARN_ON() in decrease_preferred_c=
pus()
--

commit 735c9f0cd33ee22cf920d749e3d1bde33a6cf851
Author: Yury Norov <ynorov@nvidia.com>

virt: steal_governor: Warn on unexpected preferred mask states

This commit adds WARN_ON() checks in decrease_preferred_cpus() and
steal_governor_loop() to warn if cpu_preferred_mask enters an unexpected
state.

> diff --git a/drivers/virt/steal_governor.c b/drivers/virt/steal_governor.c
> index bc3936e69eed9..5679b7ddc078f 100644
> --- a/drivers/virt/steal_governor.c
> +++ b/drivers/virt/steal_governor.c
> @@ -145,7 +145,9 @@ static void decrease_preferred_cpus(void)
>  	/* Always leave first housekeeping core as preferred. */
>  	first_hk_core =3D topology_sibling_cpumask(cpu);
>  	cpu =3D cpumask_last(cpu_preferred_mask);
> -	if (cpu >=3D nr_cpu_ids)
> +
> +	/* We can't end up with no preferred CPUs under normal conditions. */
> +	if (WARN_ON(cpu >=3D nr_cpu_ids))
>  		return;

[Severity: Low]
Can this WARN_ON() in decrease_preferred_cpus() ever be reached?

Just above this check in drivers/virt/steal_governor.c,
decrease_preferred_cpus() already checks whether the intersection of the
housekeeping cpumask and cpu_preferred_mask is empty while holding
cpus_read_lock() and cpu_preferred_mutex:

	cpu =3D cpumask_first_and(housekeeping_cpumask(HK_TYPE_KERNEL_NOISE),
				cpu_preferred_mask);
	if (cpu >=3D nr_cpu_ids)
		return;

If cpu_preferred_mask is empty on entry, cpumask_first_and() returns
nr_cpu_ids and decrease_preferred_cpus() returns early before reaching
cpumask_last(cpu_preferred_mask). Otherwise, at least one bit in
cpu_preferred_mask is set, so cpumask_last(cpu_preferred_mask) is guaranteed
to be less than nr_cpu_ids.

Should this check be removed, or should the warning be placed on the earlier
check if an empty preferred mask is what this is meant to catch?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101192203.6979=
-1-ynorov@nvidia.com?part=3D5
