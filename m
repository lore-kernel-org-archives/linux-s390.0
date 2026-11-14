Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662612;
	b=tfxOaMi40lFq8v262WvA/KA3lQFFJKTNyuGcWUdoFOLuPYCH0kQ6R6wK8TJGvusU4tjd
	 OVWfqkvIL4FBoJsL0mBSPlWnHbug0qTzJwAPgvWBfUIDHL/Uxm37N03ZcQOQjVT7rbpAL
	 wtQhUii+IFn1f9wgSM04hp+W0ImFxk5thB4BtKOIo8IIWlf2vgejDqNBucy+hFsLKZVYi
	 ZUwkZJYkoX7UzvfuTXByUkUkqoaPNYuGXg2V9eZaSLmSUBfUEtzB0DyeV5hUCWdHqw9Vo
	 NQXWCI4DaXq97cr+Iay+17GiCndkl9w3joVVjcG4dPeblJCVLlDKMTtnqGBNjnYvw6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662612;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rAYE3ZlA1oniTS+v152iAEVNU9N1kWlr8yBz2fGdzDk=;
	b=unWfMKlkpVL9U9h54KVRJ9K76LRnlf5Ji5rDTTyICM6f0iETPZZ7i9PxgID93+5hUH7u
	 t1QsVfvxNwqr61jXiqU0RH4W/JjN5W0dycmvtvrUtExxkEtaPjWGl0iKdDoMT/KKiNiA5
	 LrSZ/KJ+9cKHvRTe3/rMj725EIkeflnlU+cNFqNv3ZU5++nmAEBjQYQpxqkgPar9TI6lN
	 lKcKn/7aB+xT8HCH5UCKEJaKp7LMXZcG8SZlggwJwS84a9QrI/loLZ1Rp6M0QLu2tn5g/
	 TT7Szr6omdtih0k2LTfD7GI68IaUOWAgNDgZj+xzbzb4tt5RvM/BHmDGHij0uL5RNXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZZgDRZq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B20A606A323;
	Sat, 14 Nov 2026 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZZgDRZq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B9F1F000C4;
	Sat, 14 Nov 2026 13:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662611;
	bh=rAYE3ZlA1oniTS+v152iAEVNU9N1kWlr8yBz2fGdzDk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZZZgDRZq+Y0UxNII1AERVy9I2xnyGlSLj0Ylrhnd6t3a9oZMxo+ymyHfluKj38U4d
	 DzW8bHDJHqlIQhrXp5LxYDR6Q4H2z+uIQEZjxOeZ3kV09YqyQV45qq02JV0WJvlsza
	 zZL4CU2dZsQq4DamtOCNCqLsNkfvN1Crv8fDduJ5JpGv/pY7Llnvgm0k4L6AbGYiLk
	 IIATq0ddETgGEYzmZpq5nJbJxBVe2z5jZkw2q04ayBJHY/3bbNq/m2kbu4hHKNufFL
	 VWuEycvyyYUHP22kw14PdZ8SM9jniC18JYNIS5aVl+EONps/mtDeWKNvgLVki7ZCP0
	 f1BuTKfAXrIEQ==
Message-ID: <sashiko-outbox-214560@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 41/42] acct: refuse files on pseudo filesystems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-41-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-41-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:23:29 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> acct(2) already refuses to write its records to files on kernel internal
> filesystems and to procfs and sysfs files. It recognizes the latter two
> by FS_USERNS_MOUNT_RESTRICTED which misses every other pseudo
> filesystem. So a cgroup2 or binfmt_misc file is accepted as the
> accounting file.
>=20
> The records are written with the credentials of whoever turned on
> accounting so this isn't abusable the way loop is. But files on pseudo
> filesystems aren't a place to store accounting records. Use
> file_check_backing() to refuse all of them.
>=20
> SB_NOUSER doesn't need to be checked separately anymore. It is only
> raised by pseudo filesystems and by tmpfs instances that are either
> kernel internal or can't be mounted.
>=20
> Suggested-by: Alexander Mikhalitsyn <alex@amutable.com>
> Link: https://lore.kernel.org/r/ae189903d4cda27130317a9312d94b53d07415ba.=
camel@amutable.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D41

