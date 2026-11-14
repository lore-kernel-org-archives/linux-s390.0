Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662403;
	b=htn/aCVwy+L9unD68nD5t58MYLSnjZMt+69ejR6oc4WaTXq2ByfCG+B6fh/qBWi/FdID
	 n4DMi5pFPteRc5OFFSjwZaAaLiXp46pmX4rsBCApdXzXKbrGzgdmUGBhsCRZGlzjwj+ho
	 IqOw4qB/TKCJbXR+CQPKp3AEw8M4fRQTNdWlBBlAB4LfT1cn3mbdoNgOelcgz74ozi84F
	 tIYeaqy9MUh1+o4z/MvpooDChVUQZj//Ec9+BW+A8S/RcbDbJK4GEio0VFiPIUuE06z1v
	 g6Rp8XgYrtA29gspOoAsBRHK+cscFTvSk4XJ4CKjuOgpWpELW2mcOpcR/iv3Xb4koYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662403;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HplJtY7Pb0DglkPqVuFHQuOGxJjky8l87odvhxOh/Fw=;
	b=C284XehfB+pKJccPIAz+UTQMmYfqENa83dpmn1RsKP3Quqeu5wLYcV0cO8Nvi9hBVyFx
	 Vt0LTTvuPH4pEtIfe5whn1h34NKkakOkb9JmOKbRgmraaPbSgd6J64EjIJaQVehRcMFrU
	 miFdOrrArcOOxkVcWgQ52LncjZuy/j7nBoxT67FZ8ymOVsApBFFN2VZwmoyltUTsfQFhj
	 p2OCJPQ7NJpTwOqFEKK2U35gRUzR7TcgUYmLKCsj7nwtv23vuV9iyahkk3vNSbZJsGb3G
	 RpEaqO20exaYQ9RTLxk2GHqoJpME4yEXi6GyJF9enm2Qzq9pW2qtjlKEb9bOE8B1uyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4TrZu9w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3F2606A339;
	Sat, 14 Nov 2026 13:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l4TrZu9w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B881F000C4;
	Sat, 14 Nov 2026 13:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662403;
	bh=HplJtY7Pb0DglkPqVuFHQuOGxJjky8l87odvhxOh/Fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l4TrZu9w5Q6/iruVXo7YZIaphZtVIPRLnGxkFzg2NG7Oh1lyUT2842YJuSBlPx0Ns
	 H30gGaIbobG1Q2Pp+aZ5YmxwSYsdGDmCW/D4alt8E5d3nuw9gCXXSKhrl7FW824VFf
	 GVHNFxQdrEiqyBsd0Ghk7UM868F924kl5QsPRbt1BRUBHK+BxuFlVcO3T4qyyic89n
	 JBURZCBlhZCYhz8DMIFmqTPoguExIKcej3d+Y0dyfxnu3NisOwlYC15acGTrpMh0jA
	 TKPZ3Lc/CDMumFCAf3wv0m1ygqF4vdi9O3aEhkIYVlqCpAsGoaHtwG4+8iZhf9DvLK
	 Ia4Jz2TLneCRA==
Message-ID: <sashiko-outbox-214546@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 05/42] kernfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-5-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-5-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:20:02 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize all kernfs based filesystems as pseudo filesystems in
> kernfs_get_tree() instead of raising SB_I_NOEXEC and SB_I_NODEV by hand
> in kernfs_fill_super(). This adds SB_I_PSEUDO for sysfs, cgroupfs and
> resctrl.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D5

