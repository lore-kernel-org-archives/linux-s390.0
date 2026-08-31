Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26359370AE2;
	Mon, 31 Aug 2026 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201910; cv=none; b=ivd5z68HT6/at5qnDdx2FCJbgbQW3j8JfhcPidRGFqxMjHU1VYhN/DpKK0L5NbMP5wbu2z3U80rQuHiL2dDkyTS/ST7qDaSLMrJ0ZlRo6/cSuY2ZtezlXyLDtIbiubp+qNMhSKj0MvLg963OgYONqY8bbaI2Qhctran6ykW5UX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201910; c=relaxed/simple;
	bh=XbIkjkX8Q8525o58/IBIdLGgybInhjGX+7c5Tym3VaM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=O76ZLGQEWkMqtOncHQyO8vl2s1A0py9R7YesRjd3HLnFpHSOjmEgAcm5gNfWC89/eYCAA/r8pMeFNtzWgm5RvLlgneYmQqIRMYlBtpa8jJy0DyNiLwqqRRLn2DtMSn0sBf4eBkP22J2jglDajuozITgV38ymL611h4AdRaDUikk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o03lZrvX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o03lZrvX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEC11F000E9;
	Mon, 31 Aug 2026 18:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201908;
	bh=XbIkjkX8Q8525o58/IBIdLGgybInhjGX+7c5Tym3VaM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o03lZrvX+EmbpcRpjdXKcTbhcLXYYrSTRKBIeBxZKfwEdUo8Km3Bg94Wuz8nDQQ63
	 aAw+AaIB2Xq26molHjmX0paszbVwmg11U0aebMUu1I4ea4Lv0uQBE5N45CTVVbbITf
	 B7Tlcd2OOEDPXYNapf4U3rMDbb0Rj/Vour4Z4UMoPwiwEzXNdgYDQHlqC21Sc/l+6E
	 N+sACLiLTZZjMqA5vnmFiS9XzFUfZZUbixXjwq95KEOlsCED3oqaPPUkW6J8sYQpdT
	 lxit8vzt0auisRBd1umzvROh7KWZyX7/x2Td/VFj0JM7TotNVoXDszaNSt5i3lFWbd
	 T8ivDOcX+TE6A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/20] KVM: arm64: Prepare sys_regs.c for sharing
 with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260831145536.913567-7-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-7-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:45:07 +0000
Message-Id: <20260831184508.2EEC11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Prepare sharing of sys_regs.c with s390 by moving functions to another
> location inside sys_regs.c. This reduces the number of shared regions.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D6

