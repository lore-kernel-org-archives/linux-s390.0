Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302658;
	b=Qfb00OqLQeTKkhi+HgLcbPCtUDHlrgLO0EZS5v7TmFmtciidwiBSIYGh4Dq2qiiyktMA
	 tzDwQIIt6wlN9+oeMLpDX9L2P0rQQ02M9di8PW3wPgwGzF7UBj/9fIY/IFQgvcSCLH/02
	 iJCSAn8scmYcOBCbz9Xx23RZFAIYYUFbKPdP1c5Scs+SNoz5EIGKX+6UAWrCXqSRwEhMF
	 CBkn6ZFQiABXdyTUG/7D0N3L+negoRSa8eGw1efUDO17BB9qvXtYI/Mkavxgx0gmXPrLU
	 Nnu2Rl4Mr19kyY25mQRbKoQr6daM6P5lQ8wcHBk5Go7vTZ9sDUNfNwag+EPMDZmYVUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302658;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eYBKCeRa7gyB/EyvRX9l13A9KnCJyl3SSpj8DXq3nl4=;
	b=tSv5+b0GBYa3pZ6rRGHMDS8FCPaVlbfKII3uyKSp3GzRctgEBcoZcUn7OwfZxFhMAY7g
	 GHmzuV5TWUZrxx+DxHL0oMVITwnPrWc7c7TpjCxIX1EfTB33GEilrZtod2cO3RMMjyo65
	 p6LXse4reVPqqaaJS1kbFGo732+HQyQWS2Xp/8ccF4WrtPX2FKM53ucFR8hRmIdMVKonc
	 AYjndk+oRKoZTX1u70YONVw8cfx5cSPFKGoMnwME5qs6R2uDx+3FwIRm2MXCBiLpkQLMp
	 jBM0Kmkz7U6lcrYyr3g86UqAdGmKHts2muK+dGd0yqUlEf1dNg0uLr4HIsiHhieboVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wbzmkj98;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F820606F970;
	Tue, 10 Nov 2026 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wbzmkj98
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DC51F008A1;
	Tue, 10 Nov 2026 09:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302657;
	bh=eYBKCeRa7gyB/EyvRX9l13A9KnCJyl3SSpj8DXq3nl4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wbzmkj98edgoluUEn1jlJfuEqeE6yO6u7emx0SHZNog04tHxI5E54dtRSBFDzSuHD
	 CZU5xhu47XhWPCiD2WtEqTfwOD60GwiiWmTsBTZqr5bEJ/nQGdgLWfkAW7zj9lYzPm
	 4ep8Jb4IwcirgN55N3hwhcpMYWTd7UMyZOdZ/eaF5WigkdV+BZeIjMIcA08+mjN8JJ
	 Nv7jHpnaiu944TFIBP/r7fEoHY7UAF/kXNWZYvUOX8R4k8OsP1EmWzcl9SQ1Hfc1cQ
	 3IMo/LpGJUlPfNkmKfEvTV/1o6dmWgx3cZaQs7e+HnxvIOO4TwOvE/NpmaEdZg/qNj
	 i/NrzkXXkkrRw==
Message-ID: <sashiko-outbox-206729@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 03/41] target: fileio: check that the backing file
 supports ->{read,write}_iter
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-3-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-3-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:24:16 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> With fd_async_io=3D1 the fileio backend calls ->read_iter() and
> ->write_iter() of the backing file directly. The synchronous path goes
> through vfs_iter_read() and vfs_iter_write() which check for them but
> the aio path doesn't. So a backing file without them calls a NULL
> pointer on its first I/O.
>=20
> Refuse such files when configuring the device. On the synchronous path
> every read or write that needed the missing method failed with EINVAL
> anyway.
>=20
> Fixes: 769031c92c8b ("scsi: target: target/file: Add support of direct an=
d async I/O")
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D3

