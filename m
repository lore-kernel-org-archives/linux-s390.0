Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561523;
	b=LSgGQ6noCFIChOL08LYnXjWvZrIja3NgwwceGDvhL3tMbSYfBF5jHIQKOS/pHJmhAEk6
	 5AYr7fdw7YmMTc/K8i2xnInXmiEF3bV8RCVfFjT3rrPNPskvqhY/nETMmVEp4dfZZDFcG
	 2/+4YIv20qDWU0z8Avftm9YU82f8HjPnEMjXIUQ11pT/NMsdl6Kqoo5tvydLw7HHIDgRb
	 tVfzLb8r8x2AR096n7dGodLElKJBqqde3cLHOQoKqI4jDInGrEmF+yTKpP9YS2f2EAwBU
	 z6Imv0ZbU5vMYP5QbVgFiAv9Qy856Deh/IXMjwfSu4RVz6Vg5qx3YK0Z2d5rtEp2wSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561523;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dI8j9rAU6H9CY0WbjferJkJl5XCza5sh/G//Ly8dr+s=;
	b=5s2qc6C0wbH9ldoRS9wXW7rZJdJr88JS9lYJIeTEa5h2J2fyBrk3yE4mOntlJ1yLNhFY
	 bxKo77UiGnHIxqbEVs990J85VC2GBClKgTIt8M9FnYcUfgpwNkCSHe5KC7hVPm5Ooh6Sw
	 Urszei6viBsnKGVtSH297LU2VmAsdPneGkssBG05eHZx/ffgITqUzpM7QksuObQvLj4Jg
	 YQhiNGaTbi1mdTyyMZ2gzsGprU0/ufsxr9J9aipki2XDeYJGXtPzK4S+xHukq5vne+TGS
	 S4mr7Viv9IvPwS+c7rriy/mgvLC+aBhfUdrlqJ8VsmWh/SNOAOJxfvlQ1/zKe8RkOfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ifk3/qyH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1DB606A324
	for <linux-s390@vger.kernel.org>; Sun,  1 Nov 2026 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ifk3/qyH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1C21F00919;
	Sun,  1 Nov 2026 19:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793561523;
	bh=dI8j9rAU6H9CY0WbjferJkJl5XCza5sh/G//Ly8dr+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ifk3/qyHFXEQW3PtCR6hD6r8ryywPIhmAXqViBfr/8fU9N78pPeO6AeoAn/S3nvt9
	 vFDZqxZ+mwfUdix/lpxE82kTvV2s5H6cqQtW9B54Lr5uKXUI5GESp65CyhlV1K5b58
	 WZUZCzQnloovC5DMyX2HqbjrNvrj2fNg0ihMpfbtK1iNizhZ4nhqvSLKil1jMJbnL5
	 sOUYZIB29PEO4XB8hngw55NZPM5CY7E5YJ/+PVXrDqDIg6FuZoS4hihjjfmkNXdBjq
	 iQZ+5mAW6pWF5kCQIuG9iFdzYutmB7SEuLiJkPe6jE1tLGmTCxPJB5/Yn0cxNF7XVM
	 RnzDUVk1qGNbg==
Message-ID: <sashiko-outbox-192612@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] sched: serialize preferred cpumask update better
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261101192203.6979-5-ynorov@nvidia.com>
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <20261101192203.6979-5-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 19:32:02 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> This series adds more flexibility to control the 'preferred' status of
> CPUs, so that multiple modules may access the mask concurrently. Thus,
> add the cpu_preferred_mutex.
>=20
> With that, the scheme would look like this:
>=20
>  - if your code takes cpus_write_lock(), it's enough to write-access
>    the preferred cpumask;
>  - if your code takes cpus_read_lock(), you'd also take
>    cpu_preferred_mutex in order to modify the preferred mask.
>=20
> This approach also fixes the existing race between steal governor
> sampling and hotplug/unplug.
>=20
> Fixes: 27d47ebce4d6 ("virt/steal_governor: Implement steal_governor polic=
y loop")
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101192203.6979=
-1-ynorov@nvidia.com?part=3D4

