Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280100;
	b=lao4lvF8b46ix3+9dxJu85gsG3v8F+arH5TRFBk85vNWO2oKzfIXnhjSYmbbJj+4oDe9
	 151nl/M9RqTFxleD2IzyT9vQ7jrwysJWLx1Ryje6AmF7XxfLiTCNX+6d1vSDNFh/OxC8G
	 rW8vKfpDd6r2HJkIr6AR79RS5oIDc16JpDn4Su9fgfcJk+cR6d81OVS8dRToe+sdsMSaa
	 VbsQH/CfXFBS5FWnTpz+U51GQhdZF/k0JcYHC+dGd3ayN5Wd4amKQK6Qlexl8oLKH3yRL
	 DUKnCD4qz5vXeR1g+PYVx6x815NVW0vf7DRLA0gHC2yzZKtrX8Y7DueAgAe3sSRWZ5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280100;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=j09tgUCIgwNwCYm5cTcLA2T2KBgvwV/XJ1oP7OBxZNE=;
	b=Lx8XwFeiS6GqxIoWgs2vwgt8E5FHI+DXpjjghrjcybxqSen0Ouk1rhcoyeHSp0yVJKxS
	 8q1Ki54+vRUgtdHI5zErgfWNZtLcMGHpFFMXKtwhTWQ0TVDPDNOT+g1Z2sVJf4ph75uL7
	 vrKjltPDkPK/GomuG1YkPtwuWD42oSk9z4G1RxJfYC1/K2Gcqb+gFIOh18swQSuiSeZ3E
	 OKhi5OOChGMx6RPAqKUmZ1Ytdd1TRZ/Ugrtj2EKJaNoKkrGMHGS/4nmaSryK4kJir6E8m
	 T71BTZ/k8+1A4LxlOXqdw4R2a4aqo+5IzOuQ4u8FPG19Ip36VIQ1HQqaO2Q4NVNLCdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6eYRf5e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8A7606A31C
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 13:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6eYRf5e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B70091F01828;
	Thu, 29 Oct 2026 13:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793280100;
	bh=j09tgUCIgwNwCYm5cTcLA2T2KBgvwV/XJ1oP7OBxZNE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d6eYRf5eHWWOWXBovVO1ylmGxYPVd1ypB7FWQ7HOMnRi1EkJGIjwqIAdiiqUv04xt
	 SKkx3LMgqpGAX0AJJ4QZzysKg0XdlRSpA7jrPJ1m0JVmP/wCUays1TzS/KjPCMDJu9
	 FLjxshy0dLM4xrCQ70w9NFvrLyqx7ibA+8RSGMsN2CpOGkWUkg6+uEkdzycg7lXol7
	 7gzs8Fn5EWXXshe38aLcgNTPAwf48a5ccfp1bRg7gf6CdxS8MlKxaUyOW4H+5yV4P6
	 bp6iWN2x2oKkcH77HOzo3fP4wO97ijoH4bEaEo9TWrTPIc6ogPjafNgwU3AX1h+Ejx
	 84VbDXUqpZ79Q==
Message-ID: <sashiko-outbox-189370@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/7] KVM: s390: Improve unmapping of large ranges
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261029130044.125032-5-imbrenda@linux.ibm.com>
References: <20261029130044.125032-1-imbrenda@linux.ibm.com>
 <20261029130044.125032-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:21:39 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> When unmapping guest ranges, each individual leaf DAT entry is
> invalidated. When unmapping large ranges, this results in a very large
> amount of invalidations, which is time consuming. Moreover, since the
> unmap callback is called by KVM while holding a spinlock, this also
> leads to stall warnings.
>=20
> Improve the situation by invalidating DAT entries higher in the tree,
> instead of each leaf individually.
>=20
> For small invalidations (up to 1 segment =3D 1M of guest memory), and
> special cases (like protected VMs) regardless of the size, the old and
> slow invalidation is performed; all leaf entries are invalidated one by
> one.
>=20
> For large invalidations (larger than 1M of guest memory), the new
> strategy is used:
>  - Invalidate prefixes on the whole range, extending start and end to
>    1M granularity
>  - Iterate through the page table pointed to by each pmd and unshadow
>    entries as needed
>  - Detach (invalidate) the pmd
>  - Save storage keys as needed
>  - Invalidate each (now detached) pte by simply overwriting it
>  - Reattach the old pmd to point to the updated page table
>=20
> Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029130044.1250=
32-1-imbrenda@linux.ibm.com?part=3D4

