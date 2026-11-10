Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302728;
	b=ye2n8s7kl5HSwEPE1dIXXtOUHk7NjEHt9TSHlHWiH0IFrH2X3evfefLHkCqdAW39nICX
	 YvA6SUwTf85xMlROqodLIdKgNXSh4sSkkGUn6mzmP1ZO8SCHUBpR3IJAoWSKe2ZeB0E3E
	 19ZZshKDOF7CRhU7dbp0WCr14wtHtStvAIdtj2bmgKC9bkhqcHKjI0uVE6Iurd6Jpk3gm
	 Vmbio9WLW0vxK4tW5iCOeguKUpCkhIAwobA5ArJQuSWbJlDGWREjBzx83bAh/XbW5GPhU
	 1rbaKpAF+bufRyj50E8ArG0sQ3fFWpd91j7RrIut/P069GBnmqprxYTOemyAkGN9a6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302728;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V9W76EoMRE7zjEA0jecDj5LwomoKamQFdO/m6a8+xH8=;
	b=t6io7AMDKLz9Fxykr6SWc82ekSskvRs9aapG8hBzIhQU/0nv3ne6Nte2JT+HDYiYa7zE
	 J/oIkMLsm4MgMWyQiqgv7DyDtbo/CCgcWbDLSiDh9TW2qp18LrzR3W7HaDt+U+BWl4Y/e
	 XDYCsLPgxDJvQJ9B0iC36Mvm5AAwl4kC8NSdMdPMPFctSukCEgbb9sMwBbp38b+ndqY7D
	 8q8+9OUzWUlZicTP6fiQy0kvHxOBvICsIhrBb9tufhnvgpXhrdB3RkVrURLG+XMQ0qGIo
	 oLB8j6BWoN/8OVTYmJWvPi19xz87obv/qO5y5dgf+zMRG0jpcASxtv2rB7tDLXbi47Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QricU+I9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBC0606B161;
	Tue, 10 Nov 2026 09:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QricU+I9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BEFE1F008A6;
	Tue, 10 Nov 2026 09:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302728;
	bh=V9W76EoMRE7zjEA0jecDj5LwomoKamQFdO/m6a8+xH8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QricU+I9d+M/oMB281qiRRWPNsKPWoS2KeLCgr/B0e7of+6L/SRPFfA1sqhqrGfIs
	 mGKxf5Nov+cKYzkSnJQxltVCkKjNXXq/LtJ86BZOB2MS4lMpGOXTfmbVstoznmtCWR
	 w8618Cf2M5ZkwlTAPGSMAcJ/l+aoak0Bt5MYDjGCztzvqsJO6rAg07d/Du0zEC/Z10
	 7Wqq20lK4h53Xp3psorTVbmCD0/5neN2FDnsxt1qew9/NvDhlY+gcillq3AbP4Ilmy
	 SZnjhcY3X44eo45t73aOZjfLtw34D+bghKjDHs9sXHDUaY1ISWD2Zpd+5gAsodUnLn
	 fYF7Yl85VFDGg==
Message-ID: <sashiko-outbox-206737@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 21/41] nfsd: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-21-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-21-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:25:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize the nfsd filesystem as a pseudo filesystem. This raises
> SB_I_PSEUDO and also SB_I_NOEXEC and SB_I_NODEV. It never holds
> executables or device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D21

