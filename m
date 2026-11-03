Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724100;
	b=0nMmqKVx5BiVdgy3bKIHIOSl87OvfApz8n5pX3/hHaV7+pC9XXacAum63/WJ9jZRUJix
	 GQNaCl0Ho7BzNmEPOV88AhDSn/gKEuaUrdxhpewvGhzVa8S/UF0nzXencPRu53PDCQLy6
	 FDb7hyEHs7yDHk+3Tlr72d+f0OJ0Aw5UyIenDuwBHBRBQLXI7KqFk+KV4TaPemhYTXWLc
	 5UTaWXynqZriSyus2TXM64Wwd29if4Ppoa2aypjEdO19iJ+fWxSdSrqECYNv5oEMoGgX0
	 kcd70vROjXHOv8jXJ5GF/0xRNzi018UViXYL4hya8OIbpDhK8fj11aX9VBItfsLvebw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724100;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2UHe8GV6qrWFww8R+gsw8Morgtw+clciSS9oFLsTDnI=;
	b=zZeNMviW7e/BUDqocjIiBDydqKvQJzZGfU1+pUqSnFYfuJoLd3CyZzR75AAl6uVG6p8N
	 IjlT6161e9OaBDSZGJxt1vwGO0AaftWz6w9CRlc3Zk1IeLst0v1Rvf4TQ4n0++NxuWUET
	 bdeBdQRSJEvFIom218VixOE5Ujb8cdkfhdt7+Q25sktNkQqUbAnJcPPeiBV6u1KLklkKX
	 7trooJr85Mm15UeXRz1ZglLYCvggWGqTk5ACADy6bHA0UkrQxPHRisG+HG8eFWytEGXaZ
	 I7J0Y+UU3r2HX+z2MqNpgCmqi+hgs8Zg0SNt3axcBP6rEbmMBjwULgz3C0f3sWQBn8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFK94bqS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9844860A260B
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 16:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kFK94bqS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A0C1F000C1;
	Tue,  3 Nov 2026 16:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793724100;
	bh=2UHe8GV6qrWFww8R+gsw8Morgtw+clciSS9oFLsTDnI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kFK94bqS2pShW5DGC2rngxhS3HymcR0vYLjIreZ0px04uBgZJHnLtXg/z6DrVl7G+
	 n7VV/IPwvnXD7Hdke9Bmgf2JwXTO7M8xNbbe1SJXX2ll+bViIdvXrroNX8HFMLmJQe
	 z3VXFNfWuE2W/GR9nUj+emZ4bULQGfTxRBoSG4Fe/YKdoYpyOl8tIgihnTLC0H8JNw
	 5nC49eN9IeeMBg+bUKZauFwOnVh+mFDToRnP6fuJ0kI0eFoV6xvRvITOiYvKcF5ykF
	 YL7mBhWXigWUfWd19evsn/5XrRXV36hRsgEu0ae8nUaWLbTTJrQ7YH4rQlDVhZnBbD
	 0s9Jd4Tmpe7XA==
Message-ID: <sashiko-outbox-195739@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] KVM: s390: arm64: Declare enum vcpu_sysreg
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Grapentin" <gra@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261103-s390_arm64_kvm_fixups-v1-2-21c36fedd878@linux.ibm.com>
References: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
 <20261103-s390_arm64_kvm_fixups-v1-2-21c36fedd878@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 16:41:39 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Forward-declare enum vcpu_sysreg in kvm_host_arm64.h. This should have
> been included in the first iteration of the header, since we will need
> it to talk about system registers.
>=20
> Since the definition of enum vcpu_sysreg is not shared yet, and not used
> on the s390 side, this should not cause any functional changes.
>=20
> Fixes: e6c329180d1d ("KVM: s390: arm64: Introduce host definitions")
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-s390_arm64=
_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com?part=3D2

