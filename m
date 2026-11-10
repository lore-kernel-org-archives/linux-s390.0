Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303095;
	b=f/xs1WecVNqvtodZAHXbsELhuvMr03aVNMIpVPDTUUUynpxc34RoxroLiPcFFRbPl0Mk
	 IY74jNIf6qpl1N6cFTV0S2XmfsQ70vWxFDPEqVZlo8r4+QXwjueTjHiBCESVEf/kSz4vs
	 rSgoY3esz334PmRCNw2zONO/whFO1jeSppn+5LRpn87GN/IMkrxV5M5dPhwi0Wqu40FVX
	 OZfnchfPiTzwuB5ePyYZp1YW3KxJFBRpIHMuRRoqc136bG4CHqbyBPG/ju/YwwNT6am6h
	 kjFyQIY0BMd2zd9m6IuKDgehcBpYYCNmILhCjVMBalp/Ke2XqOBnDBM/ThipJ1JT4Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303095;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=R9V5qd/0WV1dQAwZKzzB0kIbiUZ1Gtg64KjcIh6PVzg=;
	b=xvemdRC/IDE+Agu6P9ZJNhxIuos47l/O2/iBLtoV4dV5pJctICMaB253NLZmREo2RHog
	 bDW9mRX+4I61YtfedbnWbKskXyFZclFN2TG/Evf7ULnY1dT5lbvvh+zX0WmFcJqTc0xnx
	 Co0Zb6MT0FU+IAjxBcAcjBcJY0qWDy0nZkavWOMbxd8AkV31AjqLjPVNQMxHXnASWyspC
	 +Jw9gOO+CeL/9BRrYDgAZSilEIVXOTt0Eb2M9wcRzDEhAjs+DVzvzJ4PZtaYN02NxIlSG
	 BPzJOWlo5eZ9hlUffVdaUO+AOLuQ/dryoyRwPi/BVMNg1ll7fq/JHOcaO8SoA3x0vDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ICv9Y6KP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FEF606C649;
	Tue, 10 Nov 2026 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ICv9Y6KP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB92F1F0089F;
	Tue, 10 Nov 2026 09:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303095;
	bh=R9V5qd/0WV1dQAwZKzzB0kIbiUZ1Gtg64KjcIh6PVzg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ICv9Y6KP0IwZM1q6J3AHTUY5qz996LPHXGFyOediXIDnBPE2f1Xz4zC4ba6IL751I
	 EUbyOIuBk2GlvRwUJ0CcdV7CgMaZ6ElEmxukCL4l/e+bJRB/d4Mzka/zwHXDPfwVpA
	 Aypb4xM4wjpF7XozGsDMJDYs/p9LfLeg+rlA1XYGrc/J2sZYXWDMSHTihDCqmCUIL1
	 1JbIr4uG1sKSd0jQWdmHX9w2/pMC6hn1K1lv1cZQc2te1/QWH/8l7BR0G1nmED+FGM
	 rkaP/vQgAnCl0VA2yGUBwy1V4SGiwB/eX9LppgevfHKF1f1NM04JxOYdXqusEgMRgD
	 NhJTcDub12Wag==
Message-ID: <sashiko-outbox-206764@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 30/41] powerpc/spufs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-30-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-30-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:31:34 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize spufs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. spufs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The spufs files that can
> be mapped expose local store and problem state areas of the SPU,
> nothing the PPU executes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D30

