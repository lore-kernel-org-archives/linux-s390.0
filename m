Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302844;
	b=0O5b8zAlEMpMATK8Ji2sb+WhBrpD8sqYbsFVV7eXd5/KLUIA9oLKxblezO1IWXJMXHe7
	 nxlBeYWz/nAKMkrapPFEw2gcGaNflEtzgd1INqoHn0xV4RdsBIr4kR+sJlvy9Z8YkYHT9
	 eRx9mu9WZhvc352cKh/w1xkZOCwXsaj+hs0gUtcughdmWXLnT7NM9nOhUTUdXASjJTYSl
	 lTxz7BkPy0IicF3UWzGYBiGSWb4x5wuMnxGjNvoALg5N2nJ2dEc1Q+iA0Y+RmaTDWAR3L
	 CiqiljLzTEx3GWia9aUJjhv3toUjFvJYvzEwSwwUyDa9kSFZpITD39+c7DNjpnbQutg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302844;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pRWURIP1oDsAzkY/9Vt3CfQTKBQltOkiFtGCHb9gf9c=;
	b=ebfIOaOEcH3xx9pTUuJJs865gWvyRLHIGXWSwH1fleqQ5u4Wk3gq5XNIE5tTqdrNw7Wj
	 Kaqm2dYKc4PhUoGIcxPQe0mC2IIL83PLrz60CiX0FGFYKkby7opmLa9B0kB4T1q5dDb1o
	 bB/6W+ZZ73BM8yx/LIVk8cgQP2xHpdHU0xzYt9urjaa735JcIN+fKD7x8WUhPRqOFsURc
	 SmiDdzBg8DW8KFRrKnieJ3uvL9RB+kq/Ks6IwD3Yg1tjTotYvC+glGmO2xjo88dIhT8xB
	 OxRfeU5aoEDrV41IUXIsNW4SDaIAeRHoDkk1kHNoV/qz/aWdBzJYHGT6PRt82PzQUmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rxco2Ats;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E31606B9D0;
	Tue, 10 Nov 2026 09:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rxco2Ats
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58881F0089F;
	Tue, 10 Nov 2026 09:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302844;
	bh=pRWURIP1oDsAzkY/9Vt3CfQTKBQltOkiFtGCHb9gf9c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rxco2Ats09w80eCuI+xOKoV6GFyqFR59GCOOfJz92OSBOV40Rtd4TzA1kpSfRKbKs
	 eeY5KbxpyhAc6RAj5+qHem06n/dprgVy9S1K+8iRoztyLJBhCDjrlo3n5ZPXvC7/xc
	 +Um85ChPqpzbv/yCK+75wO3ab2Ezup9UoUSFzdoLdNsBr2uIbR/8DHnqT834s/WGAV
	 Tju0He00Q0aSYnQ8tISTuX+ANNorwXc0DMWHsnP0XZmr2bC54zDiAunhF4FiuomH7O
	 mrQxMuQYkaXevNgXP0mUhYvwi3to8IzUjG8+7UMyhuNYfHLGMj5892Hei7oa2nVkaS
	 kLP2hec/5lqEQ==
Message-ID: <sashiko-outbox-206753@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 01/41] loop: refuse backing files that aren't open
 for reading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-1-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:27:23 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> loop_configure() takes any file as long as it implements ->read_iter().
> Loop itself never checked whether the file was actually opened for
> reading. Buffered I/O went through vfs_iter_read() which refuses files
> without FMODE_READ. Direct I/O has called ->read_iter() of the backing
> file directly ever since loop grew support for it.
>=20
> Since commit f2fed441c69b ("loop: stop using vfs_iter_{read,write} for
> buffered I/O") buffered I/O calls ->read_iter() directly as well. That
> commit was about O_DIRECT handling and the FMODE_READ check went away
> as a side effect.
>=20
> So whoever can set up a loop device can read a file it was only allowed
> to open for writing. Open the file O_WRONLY, configure a loop device
> with it and read the contents through the loop device.
>=20
> Refuse backing files that aren't open for reading. Loop always reads
> from its backing file so a write-only backing file never made sense in
> the first place.
>=20
> Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
> Fixes: f2fed441c69b ("loop: stop using vfs_iter_{read,write} for buffered=
 I/O")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D1

