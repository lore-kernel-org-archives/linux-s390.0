Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B448636B90F
	for <linux-s390@vger.kernel.org>; Wed, 12 Aug 2026 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786519508; cv=none; b=MRQfrEpyw8J9vBz+7HTj1ULU4+HlTH5QR5oM72aaUtGGUt0lhkdILt08cm1A50PPrblbTO1NU0ecmAqvmbtVOt8aN+/DlrWo+6sexxibZMrfE9+hvUhI7b8c1dF5QIp5RP4HnP7++uQ7677CBvqrt63skGrPZhuthWHkQzL1lpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786519508; c=relaxed/simple;
	bh=utnFmZQV3oS3nBI8UzZgkfwAavFbn/u0W9ySwHREDF0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PnGK8NjccuE9C/+/yJfqAeCZht129EULAzNlH7vgOQ0Oh6E8nUft1I2s0AgQkIE1KC7t43rA5SxRM0izuoWs9GveVOHoTizDdL79j15WL0Qje/dmluk/YQGrXZr0rIXj8Vmu+g+6HyLllB5/yehALZzCugQT84X+ud8lCGFrIIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNWKLY4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNWKLY4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008A01F00A3A;
	Wed, 12 Aug 2026 07:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786519507;
	bh=utnFmZQV3oS3nBI8UzZgkfwAavFbn/u0W9ySwHREDF0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VNWKLY4aRS4IYswRXm+Z/4bnntaaiICPEYrKQ8xrP0UgvNZSnf3cPQlpRRHMMVR57
	 8JD/4FaRsoPOcJSURGXPcyGLB9YW2Zp6Mupx/p8lAoDcRd9f8B1ARvwWY6H8mf9D1k
	 +QffqkejPnSROAc/tYnb9Cg2CqIamscWDW4/GXsXyqVpvAhBrNRFVqjMJ0HCJpZicm
	 6RofGiPJJYKa9g78ck5z7DK4OOk2IUEURx1oqM0QFo8XrxYeRRSyFZEYlOqo6z3Clw
	 AYUAFlyoHqZ3s8w2gS8hBHUuzg94584eKd1sEE2q9aD3R9OZKDU/2QVuI4fugzXL3O
	 UNzZij2kLeM2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] net/smc: release the internal TCP sock on IPPROTO_SMC
 socket creation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: Chuyf26 <Chuyf26@linux.alibaba.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260812071538.o7mdtMhZ1eOzDgQnKZduQfWlq0FhL7OCAPLjt9AA11w@z>
References: <20260812071538.o7mdtMhZ1eOzDgQnKZduQfWlq0FhL7OCAPLjt9AA11w@z>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 07:25:06 +0000
Message-Id: <20260812072507.008A01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> IPPROTO_SMC sockets wrap an internal TCP sock ("clcsock"), which is
> created by smc_inet_init_sock() via smc_create_clcsk() from the
> proto->init hook of inet_create()/inet6_create(). When socket
> creation fails after proto->init has succeeded - for example when a
> cgroup BPF program attached to BPF_CGROUP_INET_SOCK_CREATE denies the
> socket - inet_create() calls sk_common_release(), which only invokes
> sk_prot->destroy if it is set. Neither smc_inet_prot nor
> smc_inet6_prot defines .destroy, and the sock destructor smc_destruct()
> returns early unless sk_state is SMC_CLOSED (it is SMC_INIT here), so
> the internal TCP sock is never released.
>=20
> As a result, every failing socket(AF_INET, SOCK_STREAM, IPPROTO_SMC)
> call leaks one tcp_sock. Any unprivileged task able to attach a
> deny-all BPF_CGROUP_INET_SOCK_CREATE program to its own cgroup (or a
> task confined by an LSM policy) can grow kernel memory unboundedly.
> [ ... ]
>=20
> Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
> Reported-by: Abaci <abaci@linux.alibaba.com>
> Assisted-by: abaci:qwen3.8-max
> Signed-off-by: Chuyf26 <Chuyf26@linux.alibaba.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812071538.o7md=
tMhZ1eOzDgQnKZduQfWlq0FhL7OCAPLjt9AA11w@z?part=3D1

