Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB3B2F7EE0
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 02:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787539148; cv=none; b=VEu6pmwJPLWPHUqkpeoDlvJDYcxeW7w512oWM1OXcsUoBNPtIugLhNIQhSQJ8b8Hqp+YhIJIxC5j6ChYvIQQc3tTguTNx9xHtT329BWpwPMrAd1dCJoEjqjM21re0gXZ+16q4EX2whKCfBrpDAI3m/RB8T335A2rCYYcVcOEIdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787539148; c=relaxed/simple;
	bh=Ixb6aXSsr5Dn6RyyYs03FbDeZEXICuMAF/Aly+8T+Us=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kdtLhq3mh629mrwE9YbsWBEPEiseVy/0FA6u0DfPrbvKwixtFLmdqkqSA9n13qYkx8JETnnaGCGe7DlPxs1a7VcFOHZDqFLuKaXhUx0NKqcK1DKzYblAivVZBCShFR4dAcJdKkBu48eG/Q1hOsCv4yhsvQcHpo/7YrCnSYE2Evc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyLf3L3c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyLf3L3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477C01F000E9;
	Mon, 24 Aug 2026 02:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787539145;
	bh=Ixb6aXSsr5Dn6RyyYs03FbDeZEXICuMAF/Aly+8T+Us=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dyLf3L3c9HyvHJqXLsebDlXlZpZSHaOopx8faNAbbk9FJHFySHa+Enqbk9d6gnZ1/
	 lt4R7iVKed5Z59hBBUxr8lnai0+q65xr0CcMGeOfIRy/XSFI06VYJe9qFxLwfMl/fn
	 vEJH47ThWlhHDgbD5Yv5HMNzwSuPQ/ZA717qdf3cg6JIbJ7T3LWkOJNzCIZhKug3VG
	 SvTJXNTDQKB1bSZAdTUoNaJzlvYtojge6wkmRYZ9PqWBYfCTgA1hMrfK0aGjXFulh5
	 pFlJ9kZSIIQPqNjg8SdXum151VpBabxE923A5JxLhOImEfHWNlpb8yipMLWad6lcHu
	 zoXt+v04+wVDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] net/smc: release the internal TCP sock on
 IPPROTO_SMC socket creation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yifei Chu" <Chuyf26@linux.alibaba.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <178753843966.342810.566471390946765094@linux.alibaba.com>
References: <178753843966.342810.566471390946765094@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 02:39:04 +0000
Message-Id: <20260824023905.477C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> IPPROTO_SMC sockets create an internal TCP sock ("clcsock") from the
> proto->init hook. When socket creation fails after proto->init has
> run - e.g. a cgroup BPF program attached to BPF_CGROUP_INET_SOCK_CREATE
> denies the socket - sk_common_release() only invokes sk_prot->destroy
> if it is set, but neither smc_inet_prot nor smc_inet6_prot defines it,
> and smc_destruct() returns early unless sk_state is SMC_CLOSED. As a
> result, every failing socket(AF_INET, SOCK_STREAM, IPPROTO_SMC) call
> leaks one tcp_sock, so an unprivileged task able to attach a deny-all
> BPF_CGROUP_INET_SOCK_CREATE program to its own cgroup can grow kernel
> memory unboundedly.
>=20
> Add a .destroy hook to both protos that releases the clcsock via
> smc_clcsock_release(). smc_sk_init() hashes the sock into the smc
> hashinfo before the clcsock is created, and smc_diag dumps walk that
> hash dereferencing smc->clcsock without taking clcsock_release_lock,
> while sk_common_release() calls .destroy before .unhash. Unhash the
> sock before releasing the clcsock, as __smc_release() does, so a
> concurrent dump cannot observe the release; the second unhash in
> sk_common_release() is a no-op.
>=20
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Reported-by: Abaci <abaci@linux.alibaba.com>
> Assisted-by: abaci:qwen3.8-max
> Signed-off-by: Yifei Chu <Chuyf26@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178753843966.342810=
.566471390946765094@linux.alibaba.com?part=3D1

