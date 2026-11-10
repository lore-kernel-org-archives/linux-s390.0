Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302856;
	b=IGbCxYSLaH+zTo7iLjAqZYghEIP5Skcl+ti5iqumyo1Lt1GdpPvjOBP43ACvX1YSbaDz
	 OIeEIEaw+anS5qzDlKsxv7nVXhP7X8vYM0z6IGwrk9wvOnt0ZAlqKgyz4LvPTUVcVi0Hv
	 QJ9/0W/6ZwSuwXhZxjY1JNhzbuw+5vpE+0XpDGSkETuB682bWls0wD1oxvx3FWUvKBtMd
	 fiBSL8tVPcmgKVpZOLTw++F3OTS4er9j9HRSQ4cOHlsOJ+lTrvwtqP/sxAFqnlntE/mMv
	 T5NqEzpDjOl44PDDeO67Fw6Ap82+EmJsz6yDYeJHSCPKR7YOOUw38UUTNrTbRX8u82g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302856;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YIuJGKKOh0o3b5XJqPYycYRbafk9oSXqOW/aSS962qA=;
	b=EfWcdLkLafpt6gElCNzQ0gloK9n3kARqR6PKxoYyQBFDPstGEHsbKN4fqyFKs5Ue0oR+
	 LkfOk9mJhd94UMpx1HklUKb8cjp7Pve9DHY4UkkIx09+E3yhU3NhF3zrYM4/1S0oeH2Ak
	 OOEnpz0KJvz/NSeIoE3yLHBuKbBL6cbCAuwhEcJD4iLDmhVoh/bROZmYo9fuTGpEW3fq7
	 a6REW6+FDD9xzY4CWql+kF0iEiRhvIWZwlz/dHi1lB58f2y783fukdA3/Zr2/k056POSK
	 FnLtR6QD8DS0vB/qpq8UQG3LVB2dPNYZvea08qNx9psYV+fJJMeQV6deX5Wdd10maUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hSK/v2B3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8A1606B9E6;
	Tue, 10 Nov 2026 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hSK/v2B3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436EE1F008A3;
	Tue, 10 Nov 2026 09:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302855;
	bh=YIuJGKKOh0o3b5XJqPYycYRbafk9oSXqOW/aSS962qA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hSK/v2B3TUnRt5ANTKcquqgg+lga/4m4AWkSomOyV40RWNly4nDEKLT/GRG0evWt1
	 BkivGmLFLgpAz/sgSPd1RQH8UclAg8Q5Fr1NbA+lC+IPmyNOrrxWUQaXjRIsbFZLg2
	 ErQ0y5xvlfkdlvhOPepHX4gvBmuT5CQi3Nij2w20RVRDy6QWIm2yeARlUZvMwsh9me
	 YCGDz7Y+x2qvWDPFGUzIklx6Now+DCnDWKrRIVF3gMeDx2w6vyuPPYvJp9ghS1K4bv
	 pgF6M0H+ktC6kQL9uwk/57rBMEw7N4/eMte7hFwKoVE5wt4qJqyOIypy112TtU7VF7
	 Zl136PPG0MmTQ==
Message-ID: <sashiko-outbox-206754@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 17/41] securityfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-17-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:27:34 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize securityfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. securityfs never holds executables or
> device nodes.
>=20
> AppArmor puts a .null device node into securityfs but only ever opens
> it via dentry_open() which doesn't care about SB_I_NODEV.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D17

