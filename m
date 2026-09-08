Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C3375F7B
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 06:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788850127; cv=none; b=AjfdDYz00M9IcjhOzGvMYmkqB8Tnz8IopsHB9ZGF4dV+Vb6RK+UVjmaMgKTw56Or6NAtJIH4HH2li5Fhop1dx7RAS5FSJRrbytajqnySAXtgUWVjz1vE8npGtDsOnVNWbBVI6A4HCGq2Wo4LL0+XEm7vmPNituLi6KV5h2ojvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788850127; c=relaxed/simple;
	bh=yDAMH8V0NE5czfyntHy9+/IPD00Vpt1AFqA+V7dgpnk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NflKisfu9kGWhx/gN8prIMjD5OTNeSb7Pipujxf0mLO8yJpMP13oUwTs7GRm2vIzQnqFYaKq3Xw2L3yo9Zs9ehCPGHfmfLDp62BIURQrc82wP+HhGM7wDd3BGWsw7wSzUoiVfQmAJki4z4VpP+qOr6w2PUzsBNxOu49WGKj2PpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N6lGAaLL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N6lGAaLL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D921F00A3D;
	Tue,  8 Sep 2026 06:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788850125;
	bh=yDAMH8V0NE5czfyntHy9+/IPD00Vpt1AFqA+V7dgpnk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N6lGAaLLQQM/yZyBcVMhFOJYEP5abiswitBslo1sM1MjIcNFPxy8zqklQzMHVLuND
	 VeN8xFb9igKI9E6HPI2sW2JT4I6AAkjhPq3Wa93CRhBDczxNVddMxhfZeCi/3jwm5l
	 ROL86utOCkUguxUdES70zSRbjSwlfRh5dc8Fly4xOI6jOVcnywEhPn7n1mj8YvxIt3
	 2WypQ5v+84HGDLO0Z/RtQJSAqK8d+JRPUSisC5TMl4Q1UD8wzlzU2S05oLBaS9Te0l
	 OZzbb9bxIq8Nq1YcCTM3nKyz62QUyGqzHBIRd6rutcmmT/waXDvfb/ijmMBlXLbVjW
	 ag2yRT0+6vHUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/24] sparc: elf: Move relocation constants to UAPI
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, ojeda@kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260908-vdso-absolute-reloc-v5-10-3a93791af1cf@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-10-3a93791af1cf@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 06:48:44 +0000
Message-Id: <20260908064845.49D921F00A3D@smtp.kernel.org>
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
ute-reloc-v5-0-3a93791af1cf@linutronix.de?part=3D10

