Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302687;
	b=y61rBkyZ0ew+yo6l4wm1GiiADNWO3YKooTS6cNew2VeHY6U+H4IXvS2bVMWEzcVtBeYd
	 LJ4RoE1ambXegolca4tO0u4gjgrAWVr2Af+TGoNmzkE0i6DulwggRTsGbxWNxXTQbi4CN
	 2VkNwF1TQreq9nkAXF4IjU/cDYU56yEl+JTNgVBymLzSDpNqnc7Uo9FYuymUjMFD6acGP
	 4hqBsrQn0zsb0R2PmVzFFopPG4Kwl+H8CVVIOUW4hspsPVnpUBOiSv9emprdZE9MuKsWj
	 7X4SmqWNrw0xiXNwc0wj7RUZRJgeI/50irdgrEVCEzHXHg50jRGpmaKp2bH7SZFt/TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302687;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AmIjAJ2uzJGR0Lx/aqDf9/dKM9qcxCbO3Z4OXkrPNeY=;
	b=v8AycbUpI5B9x9VP01f8WNF0icGf9Xc124t56ROT+M9QKB6548ql/Jf6Uqa7RpPXzl92
	 6630NJdgd05ogZRIJYWVqcsjGeqBcEpf4mj1ofcdCh/sSI99hI65LaQsPAz+bMhRa/UlD
	 53Y0OGECVOMxAdI66UZBRDcFZ9NsGVhBXcq8Gbf5JhG7roWcqxEukQIJ4mq1Qduksm1ee
	 v1LQ/mNZxq6yaMh1NeJK/EmnWHDc+pgZaCpuR1w8IppW/p6zZN+ODSpy6244XXQbilYCJ
	 M1bBo3eSG9cwItRIANI0RFHl0dI5MfPohH1c8b5KiOlwdEeG5oNKYDdB9AQwxQ6QNKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNyLU+eV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD92606A931;
	Tue, 10 Nov 2026 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oNyLU+eV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF60F1F008A2;
	Tue, 10 Nov 2026 09:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302687;
	bh=AmIjAJ2uzJGR0Lx/aqDf9/dKM9qcxCbO3Z4OXkrPNeY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oNyLU+eVc0uNGaJ7uFGiZa1VOGyhdB6g7oIsVboquyBkVe1PIg1vYJ4AFUa1/daKH
	 JKrQgr48LWV7KzSlpgwdxMoqUCrchjN1vk1f6nsXnP/75+7jLqD6ymWo4dt3/e4Twk
	 uy/etSIINt3AASZs+6xAk70OaC6txHAEuihTynGecG9WvAboXErXVOqGRSHH4T0cMD
	 pJn1zrAKggE6pVcNLXCpbHP6soUgfgE0PP8+EZn9sIQ0YR3TI0C53VQKOmKX2uSstU
	 BoJUUksHrNM3INixwX1MrvWui6UG8voNS4pUqtaUp6HETW1bDPm/ibuRx4EMJB8k8u
	 clafeyfUuiK0Q==
Message-ID: <sashiko-outbox-206733@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 13/41] devpts: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-13-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:24:46 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize devpts as a pseudo filesystem. This raises SB_I_PSEUDO and
> SB_I_NOEXEC. devpts never holds executables. devpts_fill_super() keeps
> clearing SB_I_NODEV for the pty device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D13

