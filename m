Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302700;
	b=HDFh+MHZlhlsCkZ+mbn2k5kKHEZrmIpzZnxnu1XYy4MfjlZSwyj7M3Q8mDL7jefcmhyX
	 lyjeai8MVO2lenl33ExzrbvdSSC+UZkROEqNYrT4ddI8VX5dOcvzIFEdX3H09P7s6YXGk
	 bgcSULcWTSSPUG7348LzdfRzwomLiVbNiJVswFo7LuLxQJ7O/XE/Ny4VUQ9EmeyBWE6k4
	 vImwNsKDKCo6Js+TvBKKxjn9HFFiCtotLeprEWFJZEEJwn28TM5f7rDMXjtgxE9UHiLa+
	 /Oz+nwUDNpJhZbVpkJ0iMtxHGheOoDrTPl+B302kxJSx5sf6ZLOw+cmCIHa3IhybmLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302700;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j8lteZ+BMBKLe/9ViW+TyY9XP/XWyfDGKMEB+rIYxos=;
	b=1fyn9qX5VdOiTCS+o/h68pgWxezWjuHGsxjsE94W9tvdCXmzW6QXjAk3bQjCA7oy6mir
	 mKxC//yZvNS1YnwW3DxFPACC1FavJ9JPfKJlIshST1dsHmqGtq6RvECjoCDVj3F8keuwd
	 /TVPF1Gw1NEuMF458KAZReLv6wUBsJkF3hTEiNlV0EcJ3keWHpPpS7Ilte6o73vjFNJz/
	 kaZky4bumzsQK1fmPIz2OThQmfzFing5/NpD86VgYc/tZGVGSzfMHhvQ/zCNjXV/VZy63
	 Om5FLHNxswefjd+fCA1YqvdQSkushK0A8oEj+dSkcqrhmxg3d1GOhu+jGZ41Oi1Pw8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBzdfV1w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BD76070FEF;
	Tue, 10 Nov 2026 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jBzdfV1w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDA41F008A1;
	Tue, 10 Nov 2026 09:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302699;
	bh=j8lteZ+BMBKLe/9ViW+TyY9XP/XWyfDGKMEB+rIYxos=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jBzdfV1woSrvES6Ki9gi1faqnMMlElxmhCknuHtcUY1B8EqFMdgyynToOawd/v/4s
	 R0eSrN5apPbaLQvNlAs3Kb/bGlCh10VvKYcY4JXWh/ZHAjb/Shj1647kBVepmk0e5P
	 DoZYqTu0W4t7U7/uPyhXwQI8Wryk6QPXhkMZbOx+XqP+hR4G/1CtYg6EmmtKSOUwVL
	 2Ol0omEoXzIysXkxC+lyw5VtJRTQZ0aD0PYaUduUA4rhdpqQTY/xumwN8OEu9Z7cHE
	 z2mSVtk2/t2IVM+BoCXzGNPulhOETIWH3iAqI7/kDgroNd6nMJtgjQB8KqVnklE4Ns
	 jpXE/s1f+C2yw==
Message-ID: <sashiko-outbox-206734@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 19/41] smack: use fc_init_pseudo() for smackfs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-19-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-19-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:24:58 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize smackfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. smackfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D19

