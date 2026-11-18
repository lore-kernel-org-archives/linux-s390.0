Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795014315;
	b=yWnQzQuVNag2bg0Jmaq4G56UGMLDa8ptJx8oNgmFOrYbsdYDK0c32XeaIr3/B/tyC6ux
	 V2aFI+F+kJNxpUuWEk5fGP9yOinrN3rulP2D8C3wkfrmB9luzmuh6KJfgfU0NAO50SHlK
	 9Emt+NjAbtMphAhChBcsmNXHRa5X5Mge0WuL3xWXLXlAUfX4RGl/UhC/1e46xfYKbY6tU
	 4m9xyHx03C4BjX65NpL2GhEwR3KtuhtXSgXVpfQihx3pxKhC4/J8L1PGf8hLJSO07THrn
	 7KwCum8CfKIj0xaXdfaatYGlR+bx8GcVbT2fJrRrxqXmGcskqLy1wDrURydE6vlJnvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795014315;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1DBEgVzCB2zAozA+kZvtZOWRns5cKTgtfqVEyIEa/qE=;
	b=OdsHSha5y+7EHUN2mR8RRgxOA1IVFWMpGii50Ui8KSenLmYk+wI9uC9Dn3Gp3Lw5wLcR
	 R/HY23bRz4+eVMISo3g+wyRXrtqKOOXuvCXL1zr2EKNpX2hjrll37gTbk0EIdmOEoM8Rq
	 9Yef3az2DJ2FvRPC8CmaD1bBdKYDf59u76zJXAsF8l+JJSo7OXl3uKZ2B/lR7y97UXYrI
	 3y90Irf5Jqh7KmDL+x9dVV/LDo8zKJ+XcrgOZ3fo/I+ieS9t4BskKgkzP4PIkNrvDk9v2
	 edm2rDxz3X1BSEgcbwvwlByXZiCGLZIC0g8CVCiHQDNLQXPagMrhbHD8ujmIxyrqGPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijgYJ1gb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47D0606A32C
	for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2026 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijgYJ1gb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354EE1F000C4;
	Wed, 18 Nov 2026 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795014315;
	bh=1DBEgVzCB2zAozA+kZvtZOWRns5cKTgtfqVEyIEa/qE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ijgYJ1gbUEgQUT7dDrVW8gO9Bq1eRK+QUXzef0DMg/GEfqMpsIPUO62NFq9S3ZRyE
	 EC2enzH+Fpa4qgRvnZ2nMDpSJ/NHtb611m8DZ/3B1pYyD8PlwYC7tVRh1o5lvtCQiN
	 LZAtgO2t10Tt6w6e90MZq1NaLDZ6Wl19SgnnTrT6ckEL/B9hmUd374KWFlxGBLJVm1
	 b2Qszp9Y0Q2g3tjnYYwZOxrJDFLZ62wBfhTpJAsc3N4L6mJRM7IwoTQCkcJi1pUtI+
	 1TrVAMZlAOEa8cGzsv5yBMJd2DJhI5PY7k7c+4S9wDCpZ7P9sa6wu0EflR9GwFb7JM
	 i7f2rVnpqu0zg==
Message-ID: <sashiko-outbox-221285@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/8] s390/kexec: Let crash_protect_pages() warn in case
 of an error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261118144709.202520-4-hca@linux.ibm.com>
References: <20261118144709.202520-1-hca@linux.ibm.com>
 <20261118144709.202520-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 15:05:14 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Let crash_protect_pages() print an error message in case set_memory*()
> fails.
>=20
> This doesn't buy too much since a failing set_memory_rw() would result in
> a crash of the caller as soon as a write to the memory area happens.
> Fixing that requires larger changes - for now only print a message.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118144709.2025=
20-1-hca@linux.ibm.com?part=3D3

