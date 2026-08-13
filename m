Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5EC413D69
	for <linux-s390@vger.kernel.org>; Thu, 13 Aug 2026 06:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786601694; cv=none; b=inshXFKRzZOWxl4PCNOVhHCVejftMDk2F3XXCARAvqYsoLce3uuH9pmZlGO89YfcvuvmyeNpF3wVDgv22BKwp7NKcNcECDnRmqd1riGvo/yRwClxbBzPrki77lWjokP4dwGJ2K+2afVtdDnKNT0rp4f8utxZ8NTLSQ5a2L+KS34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786601694; c=relaxed/simple;
	bh=5MDxXsMhVEZEPTLlm1eEuKCsSjWDTSe3PiIJ8doIMqo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OWUml+nxTSkUiZDMpETcbScoVVRBiZ9WkJ4BBq9MpJm1xxzIySxOihJ659shIBpZr6SfWmhW+KcyXXkX7U5XfwxXv5gEG33hS3Z56e5xYeQbPu5V7yQ8kiUJsNQnjtCBm2IwagcledCJHhOtvxVe2Wqiwx88x4fRykMOty5fzmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYNWQLuK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYNWQLuK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1261F000E9;
	Thu, 13 Aug 2026 06:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786601693;
	bh=5MDxXsMhVEZEPTLlm1eEuKCsSjWDTSe3PiIJ8doIMqo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CYNWQLuKsoIwjrZ+py/DS3h/bNXYwJXfFfuR3NhrIVb3UAfG6OSWh/ELgxK7X5LwQ
	 cCAcOgzJsSZpcnwp1999L8Gk5trzFtJ9VPMWARjrPBFnlFCfLvxuwrS6WYXprJEiyA
	 ImDRGsvjFszi1SWZMu1YpjCCjv6VEgJubPhTfzvieC6fIIMVOS5OhKxTv48a92sykQ
	 ZjRnluuyGs7vW1ve4hB6rpGouivRk/89DRvDI7kXmEB/g/lO3W7eKnx1n+f7mfaF3g
	 mT5RUAxwi1cwK1C4c/8jWHw52BlKNcGvIM2bwzzSLx9sGclmNmmrGv0O45OkzRgq4G
	 SBPUqikEF9sYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] net/smc: release the internal TCP sock on
 IPPROTO_SMC socket creation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: Chuyf26 <Chuyf26@linux.alibaba.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260813060456.b48HqF9m6NTfFXvq_PL9w_Ih493OogqAqxfAHAfU74A@z>
References: <20260812071538.o7mdtMhZ1eOzDgQnKZduQfWlq0FhL7OCAPLjt9AA11w@z>
 <5c80dd63-80bb-424b-894e-2f4ca3a5568b@linux.ibm.com>
 <20260813060456.b48HqF9m6NTfFXvq_PL9w_Ih493OogqAqxfAHAfU74A@z>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 06:14:53 +0000
Message-Id: <20260813061453.7E1261F000E9@smtp.kernel.org>
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
> smc_clcsock_release(), which is safe here because it skips a NULL
> clcsock under clcsock_release_lock. Also initialize clcsock to NULL
> when setting the sock up: the smc_sock slab is SLAB_TYPESAFE_BY_RCU,
> so recycled objects are not zeroed.
>=20
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Reported-by: Abaci <abaci@linux.alibaba.com>
> Assisted-by: abaci:qwen3.8-max
> Signed-off-by: Chuyf26 <Chuyf26@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813060456.b48H=
qF9m6NTfFXvq_PL9w_Ih493OogqAqxfAHAfU74A@z?part=3D1

