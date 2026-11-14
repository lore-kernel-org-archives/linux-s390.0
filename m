Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662437;
	b=Wf/qEFxvSpbb0P7nh0WxlBwzhDT6IE0vtO5NwepWdTtEoev/tXa3mqY008nK8cAhipVZ
	 SAPQ3ODLdRprrAL4aSS+V1mtHBz3FNfnNGQwiepS4uaVfuvVj5Ryd/r2/1lCGLJReOMXq
	 4CFjAIhJstTc7CVhoKBr6Bi7xmUoq9KGKrqo71+qylujhZ4NlJ2LyevpE0zVlQoKySLET
	 LCmVb5EIB3qyfidwrV8kx5mBI4qRZGGSzzuCv9rirYHVmcWDsHGAjR/X7HFDxAAYFvfwa
	 fWCeglP/0CDk/GRIXufiS248FxA9g3J40Oyn3zXr4JfXDRASxYrxJxCOCaCwWr8M1Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662437;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UzYv/g06vmEKd7xr31TKziNmDfgIzGCnXrSCg8tbYgM=;
	b=oYlTIOnWwCMy59J0tCxkb1odEX/juorT7ZyBZ5zp7+OizzkkyLgZTrvXUsVpPI1+8YCB
	 6FH4/gSRcfgCZKghO5vFvhuCDM1BAQenO2U5jxRIsXDWmEupbvU0uLsksMJGBuXSWUhnt
	 54se51oH8SEcI/N0k4n7o5Ewf+rxsqmG5OyjNX+1uEjBxlD8nXL8xNN56b6HlQHrpf5rG
	 oinXKRZ82TDywER2a/7OP6B31ycyidf8/ERJ1LOnvXvb2ITVOj2p/C5+yxF37mE3euwfk
	 b8S1/Kk/LQVLthH2Zh0ZbgXw/j982F0bLITp5sTPWk/kZ+YH9SVrHxbtQyC/wv0VZmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maQnprN2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C07606A323;
	Sat, 14 Nov 2026 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maQnprN2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6CA1F000C4;
	Sat, 14 Nov 2026 13:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662436;
	bh=UzYv/g06vmEKd7xr31TKziNmDfgIzGCnXrSCg8tbYgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=maQnprN2zL0hABNIxP134zh4vmkBiH/RZ9VagPJQqF+8EvetgwzfZ+77zGVTD26/K
	 s5/0ZjWMlhYHzF8lpDMOb30qtNgucKCWZgTZAko5ycvTPU8UPxFPdiAauyOKAxIYKq
	 p1JP0uasbheQg9DU7lYxGFdw1nEywXPsyopIeulB6D36Upik/zjgaB2LZWFwehfoZI
	 5chd8f1iFT5mLFmfL+WUphRwU2hb79UMpYrGMhSO1zybgAu9+staBE6/btZKH7iiJx
	 9JlnmLxB5LLa4quEchkNjGOPe2acsObbLeedmr+ETIJ2wtNmfhX7SBqi56mJ5vvjhl
	 8rcP//JXRaPUg==
Message-ID: <sashiko-outbox-214552@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 26/42] xenfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-26-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-26-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:20:35 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize xenfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. xenfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. xenfs maps the xenstore
> page and guest memory through privcmd, both data.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D26

