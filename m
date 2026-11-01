Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561572;
	b=U9LhlqOKk65zGCmsdhJS+r0+wU/SzLsQjvr5B2BuULFDBN9WmpOmvsM3AUc5ncmwXobx
	 QnxvN2kEuRO0a8wB4L3vxJwdK3kAg84Stb4EJlXi9O4TRCymYpeedJMQm7W3KGVeIplLw
	 N60F8jKpurRZlUS1BHKssw9eltyBHHATbrXtm3vufm693c0p8Qu2Sa94KIRBRQ3u9grua
	 5jBjy9YRgwiqbRUfFSLnBjRha92gtWtmaJXNDYwyPYIpDB8jikNctD7eNQffsnQ6FePAQ
	 ODhGxnvs7L9xnVxHIS4/a1mYFEhxO2ejKHr7wbae4b1UidiOGOYpFySXprMPC268evw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561572;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GibSDogJL29M2tk+n2kzQK6Ae7jztTplR5FFwKNoNaA=;
	b=Ue3zj16X7U5ieI4XUPjKoM5+T0/SrsE0rnfa5zrb+/EUfTmy3I5bsw2NVj/bJkUmvIYD
	 wGkWcAMKQxxWJX4v1Zo6sfw68qSaHUQWIZqw7YOV2Zf+RuLi+qgNPoE8tlKYUF9j20BSN
	 Ivl0orJ3vNKxnikDNWVDNVMqHxRD6kQDYXMkt5x2l63XEybqvm2SmKg6o9wI7QCcZ7mij
	 VLRPY9xAsA59USlLJSUgG+GyqtMlcyMpGx71vpzR0DmUa8ez8Lu1GT/nqEJMLJtHW5l9v
	 b/AUaPn4i2X9QrLg1Je5c7nf518YLxRieoTfdmN7/s2zWXRJ1eGYY/lDMXIVFRvz92w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eln6/kZt";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D40606A324
	for <linux-s390@vger.kernel.org>; Sun,  1 Nov 2026 19:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eln6/kZt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A178F1F00919;
	Sun,  1 Nov 2026 19:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793561571;
	bh=GibSDogJL29M2tk+n2kzQK6Ae7jztTplR5FFwKNoNaA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eln6/kZtqYq93hsTm9gBGYDrBkiTeqkJYV8wPwpu4UukpI16UGAICKzh7QGsOjKDk
	 DEiFLy3kolPlEzBv0pwbeHO6AMy0gVAePCr+l4/Mz9xP8TAi2P8TY9pH9oqO0BlNYu
	 MV2WLcaL8qz9TnhY3Yt3CuehFVJpIUxpJPlv9vE7eExmUa32+0qTNw16NXdeugiSdn
	 AJkZeTRyOfvDwiwW9vH1IP66WyTwyKYkPpLfR5PyRCE8W+N3so9urWdSaRMtD6PlnR
	 /oXEqR5VmldYKwtT3hFRPtfZX7FXgCgQVP5y6p/BL44l0aS7w6ojn3OCI3ewkTM4tu
	 AvygLJ2MS7P8w==
Message-ID: <sashiko-outbox-192615@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] sched: Restore preferred CPUs when hotplug removes
 the last one
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261101192203.6979-4-ynorov@nvidia.com>
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <20261101192203.6979-4-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 19:32:48 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Offlining the last preferred CPU leaves cpu_preferred_mask empty. Normal
> fair load balancing stops, potentially leaving CPUs idle while tasks
> remain queued.
>=20
> Currently, the steal governor is the only module that may modify the mask,
> so it takes care of this by resetting the mask to mirror the active
> cpumask, but stops sampling after that.
>=20
> This series adds more ways to control the preferred cpumask, so steal
> governor may not be active.
>=20
> Restore all remaining active CPUs as preferred in sched_cpu_deactivate()
> path, without relying on the steal governor to recover.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101192203.6979=
-1-ynorov@nvidia.com?part=3D3

