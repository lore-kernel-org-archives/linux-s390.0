Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561303;
	b=yJNEkZw4sOiTkLMNtQzlns9rJBOKKfXoBVWwzG2m0kOYi/nriqEIXp42sJp3a9Ad54dg
	 dAtTXnpg1+TdCQYg8PrJfCm8JC/qSMvaPr9l/Av8+en1JZwJZwBMdibsvsyMS3UKWAc+o
	 7Bue1ZI3DWaEzKI/a8uzJ+ELUHZZPSUmuM95AGuUGh+1RFJ7CSL0f2fXStOggPsUkQWhQ
	 uHuIjJJhmzrX5WoPFRLprKgNtT2hOB6dWKBy46x5hO8JQL23ku0nQrniLGeUboAWEDT7o
	 yQjseK0KMo9FatWndx4KrRy6udjIOBWYYEWukwEfrihP43bNTW2UM3AipPWX1xffXJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561303;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1IJbC5yxkF5RoJz/WbzYNDYrG6ytZftFBSzpKVpThO0=;
	b=x0zvsZzw6Ghhu9Whs63EAciK3opZFjlmlrLwXBq00ueBvj17B1Uy2uXnu2s3KRW9m4uh
	 KIjuz3wvthvVfvbgME7u36bVxoCR8TCGSKAY6Ck2v4ICTiizvtd1gMT/ptiXvvYY2PYCv
	 NGE7vPEpB83WhapzKXKZRqw1HEQXz7PujCy0PjoWgEj5rJeDLjoiIojlSWR3Lk/9ddjdH
	 J9dvRKdgH1QV+fiAzcgLr5lcNCm9XqHQIv6TSb5r0kyqg9FELmEjfLBc4rM3xQd0XdOP2
	 C4AWGCfgfSeWT4JDjnTv085vNfQS9cp6jb8c5y57ocxU4vgrU323JDAh6+lL8sIij4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTCPStcG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C84606A331
	for <linux-s390@vger.kernel.org>; Sun,  1 Nov 2026 19:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTCPStcG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E2A1F00A18;
	Sun,  1 Nov 2026 19:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793561303;
	bh=1IJbC5yxkF5RoJz/WbzYNDYrG6ytZftFBSzpKVpThO0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bTCPStcGG+o+KuXsUGcRWfyMPxS/Y/0GSmLTpgDgQ/68prix35mFRwhnviI8wxj/0
	 5aWIY1aQJgS8vSdKDVW0WhSGY+68T/avhOswV5KWqNfJ4gzxo14Nd43N+SXzvLYPAA
	 30my5Gz9adRuEczRBemZZxAC7sQscQMUeLpxhIXSeyQsfzQ+XXaNppqXINPX7MDO5M
	 s8iqjTDYuzBg4VvZjSVg8WZCnk4vug0hGCWGLLamodg+4PFSKUsvfgeyoS7gfX57ga
	 vhqRiAJbN9Lb/Bay5Ld7779zO8PPkf5ucsrkL1BgMukujd+f/zbPMDvQqQMhkIhh0e
	 1d8HLwQLkxrDQ==
Message-ID: <sashiko-outbox-192600@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] cpumask: Add reset_preferred_cpumask() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261101192203.6979-3-ynorov@nvidia.com>
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <20261101192203.6979-3-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 19:28:22 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> This series adds more flexibility to control the 'preferred' status of
> CPUs. As a preparation, move the steal governor's preferred-mask reset
> into cpumask.h to make it globally available.
>=20
> While there, rename it to shorter "reset_preferred_cpumask()".
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101192203.6979=
-1-ynorov@nvidia.com?part=3D2

