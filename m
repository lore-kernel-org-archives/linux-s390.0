Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718575;
	b=ELZinK98FjJk6MKb9DfEZsdaLc5UqoF01m1H2wGqmpNfOVw3sHytqFGGQVRxoko1AuZe
	 ue1iIPlQHAZtM054UAAEaEk+CsgZOrb1xl04RhXikzFznXyLAztAg+JLtfoMwQ9oYIEBd
	 cxHg05/W47B+pTTcjFuLsf8k7vYAF0B2toofE4x7dCs6KlCOgMmPG94syUx0N4BCWe+ou
	 pPqH8UOIB43rqw2pGiDbr/1UZpFJ+IedcooOyM0XrVogZ/OCbxXKzOZ/AgEI0x+xkUw8P
	 MAfqk10yAGQotAYcIsZpzSQZGH2PIB7KfQEM2K6T5Y6x0uf8EJ8sAvADft2iYqNuxEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718575;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jPGztp8+jYoE8f5hFI+6lsKdZ3YhilYGP49bBF8x6Dk=;
	b=UMtVlMFmP8nWnx0D6a853y6f67gFnp2DWkhZqCLHj+aJG271n7Z2SH3l+FwcXqWqA7OG
	 Y6S0rA0mBfSmZHVuiI1rTpdy2dutkrJichC2RhFFTIw42x41wLrJpfuLy364n1JMC1yBW
	 /P/HPMuRU3k9k9JJEfSPwAGY656f1A6UxPzMIfKHonm5YLp8MTmAupctt+CDth4iIKYFz
	 VsT+4l4rFyhtef2m3YMnpKjVgzyMevNttbD9AEMImvin5L3dEPO6r6492mkTCZHner8/Y
	 rxYVcfjn8BGBscRM92MMpu7l3Y066Pp1eNLrd3B1CCI6ZS3HpQFK8twE2KJ3rGcqySg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6Gg7sUc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647DC606B25F
	for <linux-s390@vger.kernel.org>; Tue,  3 Nov 2026 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6Gg7sUc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07A01F0093A;
	Tue,  3 Nov 2026 15:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718575;
	bh=jPGztp8+jYoE8f5hFI+6lsKdZ3YhilYGP49bBF8x6Dk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F6Gg7sUc/dZvVcfAEl+VxQnyy2K3JKEVnhkyOYcbE59XG+HKqGdhJM6UoKk26sl6N
	 GDQiOOjhD4Ikq4vSaSMI5CqpN8PD3XwGv0MD3UTTRrhWo9WNhfqeO/DgRFfAP7oF01
	 mk/LVMY9t4fFrVrOYMy1k4yvDqpUhDoGJjcBjEXc8x1HdIV+tVYFvVcR/CRp/MIWIv
	 wAuDh4IZp45+fkmru//I2SyxGMXFCwCQSyxE7Hh4ZxN/DUX097RUpb84C4/rSnXO1P
	 Us1EU+hNj82R5CW8HTfxs8+c0dRlno+HG6je4EKRLtiBza8n0uhSTt+cRISvCn86BR
	 ve6Zt57j8idCQ==
Message-ID: <sashiko-outbox-195561@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 1/5] s390/pci: Hold fmb_lock when enabling or
 disabling PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261103150114.68873-2-oelghoul@linux.ibm.com>
References: <20261103150114.68873-1-oelghoul@linux.ibm.com>
 <20261103150114.68873-2-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:09:33 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Ensure that fmb_lock is held by pcibios_enable_device() and
> pcibios_disable_device() when calling zpci_fmb_enable_device() or
> zpci_fmb_disable_device(), respectively. Additionally, assert that the
> fmb_lock is held within the latter two functions to prevent future race
> conditions regarding new callers.
>=20
> Fixes: af0a8a8453f7 ("s390/pci: implement pcibios_add_device")
> Fixes: 944239c59e93 ("s390/pci: implement pcibios_release_device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103150114.6887=
3-1-oelghoul@linux.ibm.com?part=3D1

