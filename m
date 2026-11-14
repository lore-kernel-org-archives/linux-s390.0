Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794663079;
	b=X3bpvAoR2u/DUZt3OuDrcyeltDoaJv4MF2pXYsLUFJDXfs9Mof/LpwBlJydt4UJRJ6Ws
	 hq0JI9sQcqKLG/oxnwtaWjT9y6U45BmOq9racfs7JoPHLmqph1jOpAFO4oRFbjLM9y0Mu
	 St3W3d6a9crVWxW525JCru07XjJuS5GgGZ0FUkomhwPXNfVECWJZg5rhE993xYXBtzYvs
	 BFQdWf/O9ruKoKKDm5AJmU5PA03TeRd7mmXBs9O90QxzU7fMMl4VPp15sg8mG9soilba+
	 JRp7/i8folsJ41YR50hCgVU1qf5yD+duyDAoFLkGw2wHKMoARbNGB/JTdCd1ZnGVC6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794663079;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=346dRqehwOqwf5SYCP6ZFxXurWvAlWTtKGD49+ll0pQ=;
	b=XJ/cqJuicJLg4XTRcxKNvSydvhp7oYEXAersZ5xRhE4TFaK+qJSE49j0fjlo6Whe7vt0
	 ZPZRmWLCzQhYj3j7n0XIBJZEeHYnj/xMuvbEtiQlDj/C6fLUslMl2V6nfJgGaL6CnMvD0
	 aYCVoNezeY6R5avZ4mnYgwAXwbcmQ+3UsQk7WMm6aQkfh99Y3uemKKo9mchbc11UmM6m5
	 2lKrgJu377kiGNobpdEvCJaQZs0VBboVlSirhPgfBz8+nmKBFvl4zAy64Eh2/U3idUDXF
	 49y16uSCnWLWZ0MgAccBHNI3GjnrELPCIc4AZCU4c1xu1qSu7OdJUn7bPpQ/g369ucg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+JCfTct;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9C6606A327;
	Sat, 14 Nov 2026 13:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+JCfTct
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 779551F000C4;
	Sat, 14 Nov 2026 13:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794663079;
	bh=346dRqehwOqwf5SYCP6ZFxXurWvAlWTtKGD49+ll0pQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J+JCfTct3wMUD4A8tTxKXqWieDH8CnAnCYQ8R6i7PgbKCChOu5oRlhcFsoB/vBopQ
	 JXP0YaY/PVaafLyqaL2UFEasBKfpvrR5RbdJyceynxVvrxL0NVn+esAIVr6Q72mIUD
	 K5tHQtRfOOsXm4uCcvXcmZRlMgpKflykz54SprTALSbqcorbrR6vHiOjDaGH9hwBXr
	 Rw5bAl/wCIGsXwyqCqDrdBdim5mhRX8Br0NRLSuBdhUQWZgTxsdBsejDkPMFJpHWDt
	 JaDTuzf5jvaKMGCne1LwfeJ62My4R+JyEAIusoUUm7MHyocBQtUP9ZPKYvBHR9KJ7s
	 XITnbYK2XrNYw==
Message-ID: <sashiko-outbox-214573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 35/42] zloop: refuse zone files on pseudo
 filesystems
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-35-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-35-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:31:18 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> zloop opens its zone files by name below the base directory but a bind
> mount can put any file there, including a procfs or sysfs file. Refuse
> files on pseudo filesystems as zone files just like loop does by
> switching to file_check_backing().
>=20
> Note that the helper only accepts regular files. So far zloop took
> anything with ->read_iter() and ->write_iter() as a zone file. That
> includes character devices, FIFOs and block devices if someone put them
> where zloop expects a zone file. Zone files are created by zloop itself
> and zloop truncates them to size and to reset and finish zones which
> only works for regular files. So refuse everything else.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D35

