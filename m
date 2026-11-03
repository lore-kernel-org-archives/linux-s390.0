Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724088;
	b=amJj9+36cqUJVOtkM398QwXBUHBkIjGILv5TUXU76taGsgAR0TuF8x2Xa+IzK2ylRgJ+
	 6R9HTlYSkJVtwSlE6hEmmX70R9NfY43IgndnQfGIWKxJTU+ApK2OhMci0f3JptQCwTnxe
	 ZuJzdpcEr28ZaUnrY6gESNvHaoSmLPeAGC0VEEh6JbWWecGN14XjYplE7+1iIzMp1XaI3
	 Tp/THJBPxPnfcU6qKdJ7WTEcbgLqx4692gW4YvbcIbhthaKLbBKD1svzH5CYaXiA3uUMM
	 0AeVbHBLLZhkrIdQwB7PWI/3alBEVNwrst1FWrB89WmKlG1NaMqflgkHSvz97/AsPUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724088;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9kHg9nNA5vhD1AAPFVtpoy01o5mPZIm5bM/rQr7WDMM=;
	b=Jk0fIRzYSo+tZBgYWpvK4k9eXsv1o/5d61IZVWE09viKtb4LjWIHaPFcJa4SnOPuoGdi
	 +MkeVPmRzB4uYr6aNaX6bCJ9WVbtcbt3nj/uhiKf658NrPsj7pnb7wZ1YDFtw0hfyjFM5
	 adDuSYBG6N8vpvCbX0TQky0GURGRQq6WGWCsa9/iOEk9aExlX8uxBuAthFxiqvpcVjgPN
	 Ev8aqmHWVl6AankEdYEGd0SHlARtx6xaDAm3UwZD4YeTyLLSTu5/k8KVnzmQVBDsGJBIP
	 rNa2iE5g09ZndUvmchZgMHJJnOZs1ZAebdEIAJj0IWs4r49iwgp/1uha2OqhuRlwfOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkAsjW0+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61528608361A
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kkAsjW0+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CAE1F00A16;
	Tue,  3 Nov 2026 16:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724087;
	bh=9kHg9nNA5vhD1AAPFVtpoy01o5mPZIm5bM/rQr7WDMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kkAsjW0+hOgjbj3XCfgwetx0fxv9K//mB5LAzpmCfkvlPNQ/SEeMWP8VZkmtdQvF6
	 kHiHHY7B3rIgz3EBdOOg2qmSApZ/eBSkDp0wZnkHk7nK1z1g804Shq5DKwQVB4Lguf
	 TrlMFgvDz15Vl/wWs1N9gatMLU7WLxscVelPjwHhDh1Ldt3tT2IhO3/3aBm7JUxqsT
	 ZsWa5xQhXlsAAX5BttM0hsHkEIu6NvlKDJtwT2ovkcOR9gQf3uNeZhiaAMozV3i9Jl
	 C+Epvq7SGN7azVjoAAbO1KfJOX/P8Gf4mE4SP5atMEuPSRQmgTYHSU0qqOM1m9SF05
	 xZN4nCu049GiQ==
Message-ID: <sashiko-outbox-195736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] KVM: s390: arm64: Fix kvm_arm64 module naming
 consistency
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Grapentin" <gra@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261103-s390_arm64_kvm_fixups-v1-3-21c36fedd878@linux.ibm.com>
References: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
 <20261103-s390_arm64_kvm_fixups-v1-3-21c36fedd878@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:41:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> the module build for the kvm_arm64 module produced kvm-arm64.ko, fix the
> Makefile to produce kvm_arm64.ko instead, so the output file name
> matches the module name.
>=20
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-s390_arm64=
_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com?part=3D3

