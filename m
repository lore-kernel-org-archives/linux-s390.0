Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793712698;
	b=Rvh1Gf8mmiS3WLYiNVOaPUyq7sS5VI1BbUQRL4xsbJD7IbwiYaH1TmdlB7X4pIbK6c1u
	 nWP9/0QcmPaL59Ssr3UUNGGV40hsxkaEVx0xPvBqhJM0VO9r1VnoNgEhq5uOkQ8+7rWOK
	 E+an4Ntff12zZI/3jnH+CorBZIVRrjRrzg31pkdIQwewvZxYyV1drF5pUjj8v2+VM41bG
	 yERzH0YDXeTUCrarN4LDR9g19oXBK/0ziorVlsTQZMXtHh3H1+xVM9WMzptGBhBcpBl6w
	 Jvm2P3t8ENLPnBBB+iSj20PnSIRZlcRSq30PsRI7r2fxXQ7T3f/Idb/rMCC6nNlZmTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793712698;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=yR/3O7A3SsaRBD6LxCvLJ+wPFFwW99h2zvn4vSUMXZY=;
	b=YW0AR5Rv6UZNYb/BCkxLh+dRwkWWn95FZT5B+N8ezhoK2ACRRtH89Q8YK6pk0PoimtLf
	 S5g77wfznwHG9Uzt7ds1lT2/uI8Z9uhYPp6p+8sw1Am72tB4YetqjxLJDPVX6WUZy9p15
	 zNCrRWsPsxsYKo914Qrwor/VHSrj8+6LQQZhJTK/PsOiHSsHvNgjAGvfxVUIGjh9/ho0s
	 EfJIDbO3KcRNK7yY6sfZh1hnk5XmjySwut1+U5m7wPVUPUWuu89A1rw/AEkuLQXQz5JzN
	 2JrxN4ZGPJklNDra5xUEJmX2w7w8E5sPS90c6ISxRAzOvGi7h2UFTWF7WeIBEZ2dcHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEJYh0Ap;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E92F606D810
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kEJYh0Ap
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B751F00A15;
	Tue,  3 Nov 2026 13:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793712697;
	bh=yR/3O7A3SsaRBD6LxCvLJ+wPFFwW99h2zvn4vSUMXZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kEJYh0Ap4dFunOrkB+XC/FSr1vOTabSQ/2UWRpkRI9mon4dkAUZ28X6oWPGBAZJXm
	 qrp48KRmctfoI+/TRhui103VPYNNkDaskH81a9KTyB0c7rlNBAfUKBHdzU2F849jUi
	 XGXnfNRQ+7A+OSXEJZY7ixnYjhJ36lnRbnFFsS9OoSvY1XRUNY4xKbZYjRwIQsC7nm
	 Ivw5HaJky4/Nn879+Wt5OqcMEpiUCYDLHMbUIXSnfwOupSuWuq1pNhSjC76XIU1vUw
	 EWy9K9jqZYRXKaCa99gBppl3qJcU73Dm3fwub4ebvU60V7Gs1hWIRHFtM/wdlyZx7X
	 tzVmjU/ELbfbQ==
Message-ID: <sashiko-outbox-195352@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] mm/pagewalk: delete the unused member
Reply-To: sashiko-reviews@lists.linux.dev
To: xu.xin@linux.dev
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102132844.301730-1-xu.xin@linux.dev>
References: <20261102132416.300084-1-xu.xin@linux.dev>
 <20261102132844.301730-1-xu.xin@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 13:31:36 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Xu Xin <xu.xin@linux.dev>
>=20
> The 'vma' member of struct folio_walk has never been used since it was
> introduced by commit aa39ca6940f1a ("mm/pagewalk: introduce
> folio_walk_start() + folio_walk_end()").
>=20
> The VMA is always passed to folio_walk_start() as a separate argument,
> and neither folio_walk_start() nor folio_walk_end() ever reads or writes
> fw->vma. I audited all the current users of struct folio_walk (the
> callers of folio_walk_start()) and none of them assign to or read the
> member, so it is safe to remove.
>=20
> Signed-off-by: Xu Xin <xu.xin@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102132416.3000=
84-1-xu.xin@linux.dev?part=3D1

