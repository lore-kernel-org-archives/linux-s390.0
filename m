Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794303063;
	b=VEzaL6gA2BGjjDZs7Wq113NRlcozWbFx2Ijp+os2PCBJu1emA2chjw+VJiGrcEmIXLU0
	 CUiDt3NKFKkfWaY9qLLsY7shHOFQm4YRkyJOJ9LQ7R2Fj/WxnP6M35GlW99b2nZicEBtn
	 rdEArMyyAHCEMNi9a1NoZzz0MV2YVg5/jCHM5pKagsvXxt4YrMkoPZcHyBiWBwsRkgz6L
	 YBAz2bUC1lwrH2QJkBs+/RDg7S5wSPUmYk1TxLkHyaOzVvAHpA1PP6si9UROAY8Xb7FfW
	 QnNxe3J4mhgkncfXUuXGIlNNrx6SytF5qIPEhU4VoVgc9UKF30Qi2iNMr4uezz5taPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794303063;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=09T1C6bTzBCHfNfqMRGbCjs+vGV2+Nfe3Pd6ELYK1Q8=;
	b=dWsQiZXY4BjoLbJnqTJ93B08zd8Xte1kLxsUaRgW6rIFNXr7vJX65NZcZpZC4jcJic0F
	 tzsIBrqLFnZByCx9djgeCxYDZHu95PAbuezw7Py5gkEQFNHw11LJnEM4IZgc87tgBcuOu
	 4A32ZXSNcDZ+lM7AwOqGqe50d4UQNtODHeFx6it23ZY8wbn5NzZPpTgn9OeYnuFgJ8a78
	 tAWR2I4q3RnOF/Y8lKP3icjCx7t16mj5ZCBu93QuTZWiZaEHmbfNGwBZMulHnhXkoZJFl
	 NllpffPJ5PKy68505iIDRyHAgvgkYmjBi0Fj39klU+6aLRQcmbC8jkxDk6xt4ibn1Lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gItwbqiy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76004606C658;
	Tue, 10 Nov 2026 09:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gItwbqiy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA451F0089F;
	Tue, 10 Nov 2026 09:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303063;
	bh=09T1C6bTzBCHfNfqMRGbCjs+vGV2+Nfe3Pd6ELYK1Q8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gItwbqiyiweQt3gUklQrnlyH/TVt4YGFeDoWypuiiFHFHYuKPecwlVlR2i8R/Bvxr
	 7pALKbtcDbt46iClDz3Ngq4AEMXO1o8US5Q9K2tyyqxmtWscrtDFcHboyQOK+wJrjo
	 GJdh0WWeWcgU6jTntlteEg/3Znkm6FaPheN9EoSqV0xtiMcNL1TelPGXT0ejDla5J8
	 TRlem2BPE17oXQdf23Odq65Ev7/z9pYNniRSlPeNEiyJ91GOPCFk/lyirwJ70Oo3FJ
	 qQyh2Aycl7hxlQXD9sG0aa//idZOOYcKivapPn5Teo3YlkDBdi8/QCI8SR3rOOllqc
	 5XWqwpKg1+cYw==
Message-ID: <sashiko-outbox-206763@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 36/41] nvmet: refuse files on pseudo filesystems as
 namespace backing files
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-36-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:31:01 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The file backend takes any path that isn't a block device. With
> buffered_io=3D1 that includes files on procfs or sysfs which then get read
> and written by a kernel worker on behalf of the host. Refuse files on
> pseudo filesystems just like loop does.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D36

