Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A373318EC4
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 06:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788849851; cv=none; b=TDhfGOJLb10Qb4Np4sDrLLdjjMwvyN9BPiyI4y74bsUWQRabMFjlFCr82q05mcW/b2jh26gmGV/avoWIcLQfzBQxrAUWKBsNiIVxq+q4lxj8WWCOQFytfX57SSksUWPPsYDfPMdyFBV4FjeQrfEaUSH6iRM1KeJYoH0CnoNkFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788849851; c=relaxed/simple;
	bh=OZ6+o5sC+oSFQxyRtSSLXIwkwiLVTf4MfYAS1hyAQcw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oKTjHelKaEnbFU3XfYhnn0s67Xkjw4MlX6s26pazAum9cdCzfAvl6FI3VT6ef/PvazfrL5JeagNIVlxRoBw5TSBRQwq8QsVOHiMbpnTD95OC9C6RTf5cADTQIBs7NSjqvIIzqZs1+8M1dbY9smgRni4P8rNSVGwFlwiuAdvIZ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgJqlYqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgJqlYqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C181F00A3A;
	Tue,  8 Sep 2026 06:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788849849;
	bh=OZ6+o5sC+oSFQxyRtSSLXIwkwiLVTf4MfYAS1hyAQcw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NgJqlYqnsfxGga/Y26/qnQEuCjabnUHsiCM8P2q1vY/ug+n7cd+UYF3rEKISmsdFJ
	 7NZ3VdgYuEDU118P3D8MV6lrWWIy9u2DTYXwZiQDElRXh97aiAheVZnexAb4LNh2UR
	 WWFm41BDWQHSH1ugbOXcKrVezpf94XuN4EoayUQiKM9Re8/7UZwp6RkkXgPX9mbp/u
	 wPm/6uApURyDFvyKFI/Q0IXaVJdTqRvw1kV1q/ooD4y+rH1hr5ysbK4NqK4OZyMCjb
	 atDq3c7xKKGlOZWkeXa7lP1VuaKlsgNEjzRjwBBSVTg221E2ckpKy5AMWaBRewk8Od
	 kdEop5OvTS3Hw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 07/24] LoongArch: Move relocation constants to UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, ojeda@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-7-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-7-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:44:09 +0000
Message-Id: <20260908064409.77C181F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> These constants are useful for cross-platform userspace, for example to
> process ELF files during kernel cross-compilation.
>=20
> Move them from the kernel-private architecture-specific header to the UAP=
I.
>=20
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-vdso-absol=
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D7

