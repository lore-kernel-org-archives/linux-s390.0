Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302675;
	b=iDjQTIwRm4lSR9hOBDsIw7fB0qnPsjxs6h7JOg18pPqnGs1up0gFd/uNjxbayTOgFagd
	 LIzfISgQgifAzuqHadhayEkUSlpvcv5npQ0MkqVitxCydR+m22VER15upUEvPl+CFN/eU
	 HZ37Gf3fhQHsAgX5ialwJ9q21fpzN1Jyld0BrBswJukScqKEJ5rrUfRjDwSzgNUBEpKLq
	 68kiPPuTWvzaGudso98hF6k2YEUIylMr5BKeFYvHsyui309te2sGPddkxwOEo+OArMy+c
	 i7CAosL04iOx8/yA72AhVaVxCekXq43lSB+PCtRwjZnfiU6b4asJWbnvfElu8az4qrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302675;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lWPErNWD0N8k5bulR1h4oC3wPQ5ojTAc7qPdbzHiOAI=;
	b=BICLiDdYFz/ZQDv00O2R2DsRKO+CiWfziS+SZxqIvgdkLkVOiQNBf7IPgjKai5YAq4nw
	 fOX0TQ2ddpbsGiSDSiOBNhiLyGUW6GW84S34gE7+ep1+8rfSAgB0vOefko3jsZkyT8s3n
	 HgNWT7ojP51R+VoOGXHkKkJsTV4vN7eZnP744Zot3QZZ3qVVfHM3Z6NkK+PuYlGfjgKyl
	 raic7Zf3+fAhSy2u6maqX6AJflJK2O4KZakUiq8TbTT5vGhpYeE5XZwjKXnmBOCSLOZQs
	 Rt2Zg3mWQyMhF4rd+lr1BiJ/HPGRGRvwEpFzzkY30O3zGF02plyCln4z4z90f9AFqvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nNHTpi9t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819D86070B01;
	Tue, 10 Nov 2026 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nNHTpi9t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809381F0089F;
	Tue, 10 Nov 2026 09:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302675;
	bh=lWPErNWD0N8k5bulR1h4oC3wPQ5ojTAc7qPdbzHiOAI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nNHTpi9tiDq4UKsZ+fsnXSi5uPEIKreHop4k/1oZnNVG9fH1Kgh5hif+lU90Fd+zj
	 TEax5becYcCfCVTX4jS0s0qUPr5fVhvFZI8r+eTYfOE8Ra/9OkbGTfbM/09K7jJkFV
	 Cqq00GgSzHAr0ONqxNvTMOe6tKOCXeuoETZT/PcZ3AVe28Q0t5kr1mmNIuhfVoa0nK
	 HCe+sUHYcEvtfJtRwWQCDJJxLVchpGGqzsk4YAV/MPcfomtVaIzcqeAGokPDDjaG/Q
	 Y1s6LUhdILcvsNZlHMRiCaZB58HuigPp21WcdZ+Bt6831LJ7/XH9F7yo2LWWTQqpTS
	 knrT4A46GdeIA==
Message-ID: <sashiko-outbox-206731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 16/41] configfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-16-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-16-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:24:34 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize configfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. configfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D16

