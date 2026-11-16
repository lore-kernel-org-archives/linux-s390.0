Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794792569;
	b=broBj2OY+ixxARBh4M0fFHKwfKPY+2Y7PBtlo2HfFrLMa6cRpBGXyhrDRiBCTiyPo/SX
	 b6yndsHldusp3ZXfc4XTY9LTU/sgtafd+u2PVdhMK2yfB55aGUEehbTN9QqShECp71oGc
	 WTIkAb37yTKb8edynSteA5j8b/cx+1bVbro0EOXc1Bf1zTo64Y9eeK+Unls9vl0Bsr/JF
	 2ZUPyMv0HJnz1JG1RfHMza71P1EGly1054cJPoC4Vr5Xb7bs+LAS3dcArIAp8cCmF7fG9
	 sGVC2Flav3eo4M3vsAHKo52/KFxKC4jUmHfYkbjqrLQ7XhXGJyn2kQaC7AOj2DG63fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794792569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jB7o1G7AOWjrZK/c5X+i78jL9xoZhPcVMHJoAgfgVng=;
	b=zZBS+1vOc3jjaxmtef4BWJej7GEbGqafA4ySjxJBlqFP7HhG527j42DZLiP8qFLdlyO0
	 G539d32UImFKyOh7Oz+uUy5/MG3EYenRadhv1YeEfBLyZ3eRMCEVsvLQb6viyODpEouIu
	 lFW0TENc00trRrGz2mfkYvvKf0o+chehfTeEkX42nzIPJBYDS+Qps2DNaTG2/mBhZstgK
	 jFD/3tczsSVQ3DM5pXYDz/JpRqhyr5wugcvTpld+K2NiZOiPyw5iXmP9X0sM+S60Ho3Wk
	 pJpkk0/Z55iRveup8U7ztbpf8ZnR3EoVSM2dsmAvtf6PsvC/GJc7npKPUuC+FFsTs+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhLSX3aI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DB9606A31C
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VhLSX3aI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5708A1F000C4;
	Mon, 16 Nov 2026 01:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794792568;
	bh=jB7o1G7AOWjrZK/c5X+i78jL9xoZhPcVMHJoAgfgVng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VhLSX3aIAwjhVfNxdORqV6k72THk7IxtXDqB2MkOlDkaGAQnQqaLkEaKZvab3nWfm
	 N4qaoB2UELtZ3Gl7teMXHZo7kGqBy+1MXh1XzzEknLhwgaC5UIOn9CPJ6UalKh7DY4
	 tXzLneyYmyYDiZKSar7TSq2w1hcKw7ao7Q9Bsc6O6TlTlxNg48B6RmFf1nTeX9GBAN
	 ya5YqWvgtC53zd2sEYkVDRbSkLPQSyAEvZRS2N8ehhJo7jucSyfAMc96vaNBSlKWRP
	 CzB59F3ZdrLO0sPqK3Xr8ykNEVGcwUTDm2iIh1Ssge/arU94FQUfLpdO5FQFGi0vMw
	 1fZVFC+GMCisw==
Message-ID: <sashiko-outbox-215998@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v4 7/8] net/iucv: set RCV_SHUTDOWN under the
 socket spinlock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261114-b4-disp-fc0634a3-v4-7-f96c506447ce@proton.me>
References: <20261114-b4-disp-fc0634a3-v4-0-f96c506447ce@proton.me>
 <20261114-b4-disp-fc0634a3-v4-7-f96c506447ce@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 01:29:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Bryam Vargas <hexlabsecurity@proton.me>
>=20
> shutdown(SHUT_RD) sets RCV_SHUTDOWN and purges the receive queue under
> lock_sock() alone, and nothing orders that against a HiperSockets data
> frame: a frame that tested RCV_SHUTDOWN before the bit was set is
> queued after the purge, and recvmsg() returns its data after
> shutdown(SHUT_RD) returned.
>=20
> Since the previous patch such a frame is received under sk_lock.slock,
> also while a task owns the socket; one that waited for the owner runs
> when it releases the socket, which shutdown() does only after the purge.
> On HiperSockets, set the bit and purge under that lock. recvmsg() sets
> the same bit under lock_sock() only, when it reads a zero-length record,
> which is how the peer's SHT arrives; that write and the frame's test are
> marked WRITE_ONCE() and READ_ONCE(), and only a frame the peer sent
> after that record can race with it. The z/VM branch is unchanged, less
> a line that was commented out.
>=20
> Without the previous patch this one changes nothing: the frame then
> takes no lock that shutdown() could share with it.
>=20
> Fixes: 82492a355fac ("af_iucv: add shutdown for HS transport")
> Reported-by: Hidayath Khan <hidayath@linux.ibm.com>
> Closes: https://lore.kernel.org/netdev/b3fea2ca-25ff-42c0-812c-f8cc6bb666=
7e@linux.ibm.com/
> Cc: stable@vger.kernel.org # 6.18.x, with the previous patch only
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-disp-fc=
0634a3-v4-0-f96c506447ce@proton.me?part=3D7

