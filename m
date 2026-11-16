Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828429;
	b=aU4jGD78RJIK4Aaye0JZkMAjBC6XXLFCPffU+Ro+Gg81CppLqzeOIHsPLGCYVa/lh1ia
	 OK88yvQMYXU5/w4mEPNaNuRQiFAKRbIBe7IeeVT+Y2kyS6syCfe9EjIM01pyrdJhMtbCD
	 /Mrvt4DfLFsu4vwSTj7xmIT5nUHNrOSf300OgVvMIRgbkMATWCHKq1/h32AwyRehBZ5au
	 /Ye/vNNhP93jo/qEZmYI4Kolelx8kVkgUU10BMjPvdS1jxJDxJNVSZp0yi5wBYJPM9QSV
	 /qsBJp9Hw0P2eHW9z2kksl8rJX6x8j5EiJ30o+rZ8adg9zI7Vbe3Ho4owCS6cyfGVgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828429;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jz4t3WOQkSkTS4kQNZ2ugxakIpvx5zhDmJxiymP2g0I=;
	b=5FvO+5drDxt2J6pe3Dzt1ub7EIBAfcEQZvxqGsgZorZaouwU1OllrEat+7TmGnH5HqF9
	 EtN1FA1SBF1ObSRhV4GF1WcO+7129WthhFHDBwQiUdl9bA6rzZOZaanyabSzDtzinn7SJ
	 4Sl7KDTJBRjGevT76i2bjUYnaQPWjGjebpXxsmgqOmC3i7bS/43gzsRjHd+pY4TyIaKQn
	 dat7G/7hAJRoOgGlMo/jlR+o/AizRss0COdQ7T+9XdVgUdGSzfAA4GqNe5Hp4/8YUPjzX
	 3P2TJcI/KJ4RuER+1zih898IDyj/SAVAAPHQc1oF+yk25bu+PX6amXqLqas5R6TXR8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVSQEjy5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBC3606AB71;
	Mon, 16 Nov 2026 11:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVSQEjy5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6301F000C5;
	Mon, 16 Nov 2026 11:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828429;
	bh=jz4t3WOQkSkTS4kQNZ2ugxakIpvx5zhDmJxiymP2g0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HVSQEjy5n2NKW/QikjdEFirMYa/3798iUcfab48nmg3+XAbkbedwX0GlKxx9o9sX/
	 M96mWmYg63MuEirVqQLxuekXMEoeSG0xRXEaucwsjGKfaaMIwdF8OyKfJy9xa8FQWF
	 KNNxdXN+SJBF0LtH0+8NgzBoaYDsut3J/u/Qj9MUw8Y7spgXNsLMs2tPbWfFbF17GQ
	 98KdvA5Bl5rZEO1i6UkFEpBtGSTghpIl6rhBztV83aEi7Rwn19SIVZoLd7J7HfyoqR
	 1GzRIoSD8H6RombM1Buw63hmH6m2wCXWI5ZKiAlPAGj5ynmUUEz+2ceCKdl64JL3Ly
	 fZI/8K0HK+5XA==
Message-ID: <sashiko-outbox-216923@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 33/44] ovl: refuse data-only layers on pseudo
 filesystems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-33-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:27:08 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The data of a metacopy file can live in a data-only layer. overlayfs
> doesn't look that data up when it looks up the file. It only remembers
> the absolute redirect and looks up the data lazily the first time
> someone needs it. So until then nothing can tell which filesystem holds
> the data of such a file.
>=20
> But a data-only layer has no business being a pseudo filesystem in the
> first place. All it does is hold the data of metacopy files and the
> regular files of a pseudo filesystem are kernel interfaces, not storage.
> So let's refuse data-only layers on superblocks with SB_I_PSEUDO at
> mount time.
>=20
> Data-only layers can be added via the "::" separator in "lowerdir=3D" and
> via "datadir+" by path or by file descriptor. All of them end up at the
> end of ctx->lower. So a single check in ovl_get_lowerstack() covers all
> of them.
>=20
> Note that regular lower layers on pseudo filesystems are left alone.
> Stacking overlayfs on top of sysfs keeps working.
>=20
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/all/CAOQ4uxhGxpBtMZ5kfuzR1tQAewiecoX7UjXQRo=
91QjJHH9T_Yw@mail.gmail.com
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D33

