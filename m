Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662361;
	b=T95gY/uyCkR5BQGKMANRcE7NA7qgCJ2furI5PCWFoL6/HeiAt5o5lq6zTFj9NGcfQpo8
	 qrzIm/3u/mfZ8VZ5Ab9PNw0PxbZoSktBrso/hMa0QULvLU/6gbxslFDYXl2YpYvprhvZj
	 fQbzZPZ2gIyxKXAHOm4OgSm1i8F8Iga26C2XPTVxP634N/KtrAiD6CqmfO8MYUU7kKny4
	 6iOnzZiBYpkHJGov5C7xG6gd6vvYwRWx8o8KmQ0G0HogdOy/OUoLZ2hPZdOfuTX9jt6WR
	 PRwd98KgWXKjqV/277fFMrPLiBicQ4WwV5RbNX0DpNacYXapZckO+SUvvrM+u3cLAzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662361;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Gv3tonStxQGuytXzZSOt/vdMRQit9HVmKcHDaQIY75Y=;
	b=muf+K4vmLtSbBIAJ45a2FMFoqUP2BEgfReuTTDWXvL+Tgxb3PLqUta5GNq1RPZyeCoFg
	 b+XjGBdinvV9KM897IoDhNkNxd9WP4NBlDCf6UB6DHQZaYfaCLTuKUz/OeyPn40kUHk1J
	 iMpwKbShsTH+liQv8t+0VInzyRzvU3M2Ed5f5AbQm2xHZYK3LE7Bo8zL/2yQpGDKiEHi1
	 b+5tt8M3B+T5CcWJXtpLsLjha9LW/nEiE1N0+oUuXxGauRxWjz3jJ8YIm4UwzXzQwTe/+
	 3/DBrM5/vSb7mlaE7UM8RY/NDEuDk/KzrSON7cYZPS9c9PtbSgBsA9MAglJBFy72YTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XmK8xI1T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3592F606A331;
	Sat, 14 Nov 2026 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XmK8xI1T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4578D1F000CA;
	Sat, 14 Nov 2026 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662360;
	bh=Gv3tonStxQGuytXzZSOt/vdMRQit9HVmKcHDaQIY75Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XmK8xI1Tb8RYTgfPiun//jun8pzXxFIR0ZtnvjNdWBsozo20a37vJD1RH/22JLUWg
	 Ozzzcviucz+T0047xJbPv3r1NDo5CZxwgTyZsLQNOG+QX5f3R2PhR0V6739NCYYQy+
	 sf9HuUbfGJGItlFamEfZtHqCnWYi7GBQ1qycz001L6Pr/fVACrroYuuulyGbZ2g8L0
	 JqDFKaUXr0101qdujA4Gy6tUtBBOybxRvwcK5HuBU5Tcn/geqn4oiZ8nNbeANb4Fc+
	 f408gIGrz40DPEL1zcgEZCKoBrgOhpmXbD8AJUvwpRyNkpDqKqbCUcqEkvMZLEqV/y
	 vtfd7ydi5Rjog==
Message-ID: <sashiko-outbox-214539@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 14/42] debugfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-14-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-14-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:19:19 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize debugfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. debugfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The debugfs files that
> can be mapped, kcov, relay channels and powernv's memtrace, map data.
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D14

