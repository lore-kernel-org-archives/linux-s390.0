Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563DB468C28;
	Wed, 12 Aug 2026 15:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549941; cv=none; b=YsZK0UhyujOMmU+7Ysu82zXW8stoW156gV7qqSpGlg7BGUR2wWEICT1Vk39xHC61us/eCtdeA77zHZbILhxXfv3FMeB2PHxVxdUuS+GYZQmgjaUpGXpF2D9ZVprh8Ki0lXVWu8jEGreZQo2+7I3QRQdeGVbsQSe31hM+ZPPURIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549941; c=relaxed/simple;
	bh=1qWu/KKkSGlcke481rAtgyYzkboCyVjc8HnoVQ6CZ+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rI55aX1FJLviqZ9dgmjm7RWUs2oCMClHOmZmf+q2eY6YKOGQGOY4fwo9ui8RG7v7IrY7f1cdaVxLReVRL7i+yfZ1UBXvCXmGFyRdmTJhepwX9Kjkf0+KJsHbqXKZgXBxWtSXa/9/y5VKtgL/3Dueqn843Ujlq+Me3pTYVAvnWaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LVThpi0Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LVThpi0Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720C21F000E9;
	Wed, 12 Aug 2026 15:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549940;
	bh=1qWu/KKkSGlcke481rAtgyYzkboCyVjc8HnoVQ6CZ+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LVThpi0Yxj+q4duqbVEcFky1xpj5Hwv6qQjwfECsLbdevjFsUPTiWpk//wsPs7S6A
	 hwdqDqtASijDZUXA+7EJMrALCpJ+aTJQHGZicMeKrynL02T3asohMqV9EpkO6RmPIj
	 U7Peolve5qlTNFkDFYFAFmhq7Go+Ql88gZAQ/iqwTwaIHiZ61YgEpL4sT5MFt+MbaN
	 zugbDqu1eaxTL8o7VRRhwaeKZlUs91olUlJwUD2YiNDonmJwC9ZDSWgpk/qSbMi8jZ
	 NbUx+wB5w0hYCTG4R8tesLkoJNAhgNFY//ybS1pSoqp1TA2i8ZSftzgXi9iBEo32Dy
	 dRRSqaC/Zu4vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 04/33] arm64: Use proper include variant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Oliver Upton" <oupton@kernel.org>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260812153631.3376090-5-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-5-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:52:18 +0000
Message-Id: <20260812155219.720C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use <> for including the sysreg header as it is not discoverable from
> the current directory.
>=20
> Fixes: c07d8017bceb ("arm64/sysreg: Enable automatic generation of system=
 register definitions")
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D4

