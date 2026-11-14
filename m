Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662312;
	b=jZI868UFF04BhrOpclk4HLl7h0uQl5kzmUDY2M4qxtEjpYj4e7dazsfTnQE0Ze0sxnJj
	 3KCcitJQi+i5gfJ4z4ar68fNVxp2ovXkN6pX/zpr1+kGsCXW+3j7SzkX8xJT1DZHAb3VS
	 pn1yhtiwGgVfnhSUheYkSc51FEQV3HA1DTKENKDZ5pec/xN4q8EcwpBzNJxZiu9hzaY5J
	 GkBSopcHLyYvB+lDSa78h8eCsS/i5v9ThkLItw/1FXvQBOwRbfhN5WkQ6Lh8rr+wjAfQD
	 /IpMoUq8NxwBXTL3SWENH+sQpDNueST9mNOdE6SlH5fd+jZq5/K2xUKn+kk38KxwM1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662312;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=z1VOFsflHfTc2v0hoxbVhXYV7IlHEXoKCLWrtYYLvX0=;
	b=kzyFfPrWSdK2kUQoJguqL5L1cUN+xjo91lkVvzWLSc0mm9k+dB92vcVdGSCTUopOdAJV
	 qHWMmsUognSsB9oIEPUZOKinFxWCu1fx/UMUcAPgd8wvIX3ko7F3YITW1dub2l2vP/gv2
	 7twXOUMdD2PFUCzvzSimD5SOBQujScxfSXYKl330ONHFz5esuXdMJfg23fy3LMQY6mApd
	 aaxdq9M8Ov5hsN5bjkb/Z9yeRDUjrZ0Wk4yR/OwWu/qSpxqemV3iutOZL6FdtTQof6CAS
	 lcHbmFjHhxNDHoK/hK9PE9r+vkeRQ87SDtqZkPwzWJjBCaGvCFrkhrQhahlbJZlWmnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGrvkO9x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7248D606A8A0;
	Sat, 14 Nov 2026 13:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VGrvkO9x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89851F000C4;
	Sat, 14 Nov 2026 13:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662312;
	bh=z1VOFsflHfTc2v0hoxbVhXYV7IlHEXoKCLWrtYYLvX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VGrvkO9xQayHMqUQc8dtgQLa/BGPqQai2av9asEW3vIVBVAs/bHPsK5I24VY+PhR2
	 I/lGtgbwQGW901nb6lXdYfCW9wKilt5Z2wzHDpcqd198/w14OJix/dBEDIuvigw7u4
	 2sNJRKNzaEV/17Voq/EXH/aAd/HbriXw9jHhnJCSXHtnzw7cTSMW1XYrDYNRDV0WPn
	 6ojDOcd2TE3UG8mZcutJoRxk0e6OCjyOkGYMTxYq/kfKwiHZVQAyg/xEh2KQpuiQqq
	 JDWyJkiWb3x7xpS7bY/JtYHG/mkfWIMSEdiuGpOgBhNW6MTPgdQBfuPWwggfAivF15
	 Z6LqAoUUHZ3Yw==
Message-ID: <sashiko-outbox-214530@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 09/42] bpf: use fc_init_pseudo() for bpffs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-9-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-9-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:18:31 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize bpffs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D9

