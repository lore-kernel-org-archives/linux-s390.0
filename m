Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161433;
	b=ukmHyBTFBPN1GXRN83FXbWIY4YZA4N+vXFDscbLm1JnugsB0vkOzFK6ysqA1WUmj1m+l
	 AxovXmwmDF4Nq2wr5MMjv3PiAFDwY6wO5kJ+Z/WomkhWWJ1XWCg0FxzkbJvkHMmKLNMMi
	 5BchMXWHZ2tuJI4eC/thbv1vJdRLWDYjQd6RsSzHSH0LQIn+ADm1UDug0EKiZt0oauFo5
	 G51NTpHSop3WPx/cQ8B1OgTsFb6aDIMBuoiE35PUpe1uGzzc9oMQ6PcVmpU2xZnoR8PV1
	 5TeiEdgie7DkCmR3n/uNfZn06iV5ZdDbBJqbR+N6BEVBrmhxPnw4IvQ0AucPn72/4iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161433;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zmTiDFqB7fT5xCUKV57ZDV34seIpLLSoGNZaf+pI7F0=;
	b=gnzR9q8N5UVOA9Z76BLIICkxoFabfkHXtWuysYUIT9TQaav4QIWiPhmWnKyPjfAFnJFs
	 fbVxdc1kH+fmmOo7yJDeT9VNHbwhTrGw2Y8nlwH2B7BwBQxGPdb3ogVLPTXSOQPKva+SF
	 Yxc3FvvkU0hbQ4Jl9QQ0K9jysF5MrCtgiuKGM9iPE/YA0Exq0cDkbyvDQDthAy+rcg59g
	 V07HlvuWMGPORzuK98Ng9rfoPFuKPRWtAd0Px2oJVNACVlwwSDaq3Ha8Dvtd4R7VyJ+Ci
	 nYMnjzbiOvnZA1eH9E8Ad3ENaxgJTqBsXLFjpUgyE3Fr7699KhSDsBS/A5Jjrvh6GQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARh0TpQh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E99606A320
	for <linux-s390@vger.kernel.org>; Fri, 20 Nov 2026 07:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARh0TpQh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 610A41F000CF;
	Fri, 20 Nov 2026 07:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795161432;
	bh=zmTiDFqB7fT5xCUKV57ZDV34seIpLLSoGNZaf+pI7F0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ARh0TpQhdBSEH7CI0Insd5qb+bxIQiNMn/STyNKnwffdWrVSm/L9TmZTgLZWvjB80
	 SLhDgs2/Ize6GKd6h2OQuuVsA/KKZ9TiokWPh55qzCsFPhrreQjER4WEr+c8jc7cbl
	 cKvhPqVTX9CnjXG+tZFQk3NWUY6I4hbmhHSjxn0gPupM71BpoRdbMdoXO0dnfYIdVA
	 Ycs0PuX/Hcua1YSFZfbvwfw4MwDMCLaqWnbOCnjYU2PqtzbjTyW3Q/LNFHp6MWv2mH
	 8Ou5pG3KwEhQnSBHWl+OXu3kXdi+23E7etnDT4rR2qV1kMZwWaNdTWd0wO9gQsLAKx
	 ZyylvLtYbCWRg==
Message-ID: <sashiko-outbox-224666@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] KVM: s390: reserve mmu cache before stopping
 migration mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Gala" <ggala@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261120075345.116521-2-ggala@linux.ibm.com>
References: <20261120075345.116521-1-ggala@linux.ibm.com>
 <20261120075345.116521-2-ggala@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 07:57:11 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Creating or moving a memslot without KVM_MEM_LOG_DIRTY_PAGES stops
> migration mode in s390_kvm_mmu_prepare_memory_region(). If the mmu
> cache reservation fails afterwards, the ioctl returns -ENOMEM with
> the memslots unchanged, but migration mode stays stopped: the CMMA
> state cleared by kvm_s390_vm_stop_migration() cannot be restored,
> so an in-flight migration aborts over an unrelated allocation
> failure.
>=20
> Reserve the mmu cache before tearing down migration mode so the
> error path leaves both memslots and migration state untouched.
>=20
> Fixes: 19192a404327 ("KVM: s390: Move all code into s390_kvm_mmu_prepare_=
memory_region()")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120075345.1165=
21-1-ggala@linux.ibm.com?part=3D1

