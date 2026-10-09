Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572174DDB55;
	Fri,  9 Oct 2026 11:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546745; cv=none; b=P/68GG6oS7XMak9lh0XceQpC1AoV9zIuHKNecCI4eEiU3jv2GykMOyIU3VvzEs7E8dUowbRdUiBEuJwNhpFUVDNdcShOxk9J5LTwZHUIN+uBv4cBA4MvN5FRwTDB9poCRAk0ZIBskyhbjdpVwx61S6dYt+pmPAHGsILO7NeUjw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546745; c=relaxed/simple;
	bh=GyJ0HY2yQfQdkEzN+p9rMgVkM2hpcacvFNeh20atJkg=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=qIRK5fcG37zZGVQUXIIwWpGlYtXevPfufkdDpMsXWka7ZeasYPjmMLUsT7yf4dx70sWrDd5E3tGA2Nm8gB7erltfzJxA49WC2kXzp2gkOGxoHKBn4diKhVKOHQwAqg02nstzs64BaaCwkLp83zfPAmaPKg5TqhGu6WamF/X6xW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHVFKK+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHVFKK+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 707A81F000FF;
	Fri,  9 Oct 2026 11:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791546732;
	bh=GyJ0HY2yQfQdkEzN+p9rMgVkM2hpcacvFNeh20atJkg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eHVFKK+GS34a8xKIOMIZzUUu6RlATo8Fz7IcaZpKTMjoAjqrP0BLbqbiXe5dh6L1M
	 2MWBuv6GsgmK5EJt3C+27lWVkXabzbhOnx2XBlOx0ukxONR33azKww2BgAAaJDb7qk
	 0GnVwUNl3QFnvsEwF8UiCKtQtu4ti1+TJOtynEiQPomESJnPWdKPiGNkiMYgrFLuaR
	 twcL1aTvbgpdJpt4qa2GHovh+FfCyTYlyxV0lmR07k30Ww2UaMSJLy6XuCqHA8Mlw7
	 8lgUhX7URW5JAbqoUyPgvlhIotruv+QDDZF5Exkvv7T6wNlLktRAhRYvMY/Vle5/Dm
	 BQktzvi7JAoYg==
Message-ID: <sashiko-outbox-165438@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 08/15] s390/vfio-ap: Transition device migration
 state from STOP to RESUMING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261009114244.1213173-9-akrowiak@linux.ibm.com>
References: <20261009114244.1213173-1-akrowiak@linux.ibm.com>
 <20261009114244.1213173-9-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 11:52:12 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Transitioning from VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RESUMING
> starts a process of restoring the device state of the vfio device on the
> target system. To prepare for restoring the device state, open a file
> stream to receive the guest's AP configuration saved when the device state
> on the source system transitioned from VFIO_DEVICE_STATE_STOP to
> VFIO_DEVICE_STATE_STOP_COPY.
>=20
> Note:
> This commit introduces the file operations structure for migration state
> files with a stub implementation of the write operation. The complete
> implementation is provided in the subsequent commit.
>=20
> This incremental approach allows for easier review of the migration
> infrastructure setup separate from the actual implementation logic.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009114244.1213=
173-1-akrowiak@linux.ibm.com?part=3D8

