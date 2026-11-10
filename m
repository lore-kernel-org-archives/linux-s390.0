Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302817;
	b=37H1dVyqI1VexsgxHpRPhfR1ehrYGuexy+cqu/57sOzX7f6xS4KzqtRY/Fc6rocNZfZa
	 SyHH7Sv5O7U0jM+PpZ+gMgKgda3D10Ll2ob1hwqQeZ7Qx9mKO2Lw9YNhpAzWE8fLJO6Nq
	 VzVkqfGBm9lcVtKkV/irvaHuPXUZCOcKAnxz0qv3AHpDveHjy3/4F0R7meYd/akBdxdIT
	 mE+ZBsmGgK6Ijs0nwfG8gakdcxf7vym+jLgXkdGKUm9k4Qn/U9FOl3UGNh31gyatQCTel
	 Lsv1xqCz7JR0IVrxE7vYl2+LZaKX8hAhUlTJzN4qJPKG1DR4DNaWRNm/UyF0iC75V7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302817;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HjnlkokQmHOZ5V8EMktTyW1dXc/6KaBQ4zPaNJ13LBk=;
	b=HBh3n4mZ1Fo06kcpVf4gD8RkERYfbhCEAuy5JXIxY/Fjho5Ld4DGdgfWQ7eEycZqKAX0
	 pLiu2Lzf6knK7J91f/Jvyp6DihzyNbQlueoa4PkWucCyNYbqYGw80EDRS8RZ7ei7guwDX
	 XUWLZTpOPZDP7LSAJJYwx1RmItv3fmBlJi6RPWUTys9AoNXVTJEMpDYgfC8J9CY7hixK/
	 rmfaqfuQM5G5V12qfJamKj2xu4Oy6Il8sgvX6KHXRJsV7nvL3qw52pcsUJI75PbJLiXS/
	 uqudSodX/ZbUovV6yVvAcKgaslslH0hZtzfAvI3vlIFmgC7IkQBGi6jOAJchnKPy+fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0tS6L9d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20552606A938;
	Tue, 10 Nov 2026 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R0tS6L9d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591B01F0089F;
	Tue, 10 Nov 2026 09:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302817;
	bh=HjnlkokQmHOZ5V8EMktTyW1dXc/6KaBQ4zPaNJ13LBk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R0tS6L9d315uJfefowis6QubXKRb7ttxNkiLWhrIvxmWeFOOdrGb9m70QX5fgUX4/
	 zBnjtYO/dhW6lKEsxcczC8sZW2JoeduatJcGlW8WBKEtdSniV3IzkoVdSs12Ya+fom
	 aKAETKPutnO94wvxri1rPzlKW2xKg3wQz11SKQaZCnpeKMtLeAmhb9niEUFScvMu0a
	 50IacVTrucb82OYb04MiPor/ME05C/KJvPrd+GdFv/jjLoYwEsWveF2esyLP3mpnTP
	 qChddkLX9e1XUxFj+A0CcldsZFfIUdBCoRT1pScH+/ScRWkXzAoWwHTgj34pVrkq6P
	 mSakjw16fNKjw==
Message-ID: <sashiko-outbox-206751@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 31/41] usb: gadget: f_fs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-31-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-31-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:26:55 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize functionfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. functionfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D31

