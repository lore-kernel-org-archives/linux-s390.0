Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA7436BE6;
	Wed, 12 Aug 2026 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550339; cv=none; b=ZiiQUOMknoU/CHYSrUQbljhIJY9d4axCFTaIFsXAI3GJ5K6m3jSaAXBw5cNlwpuFFRyuaqJqrsjOJZ44GANk1NREVrNarpdUn3gbsbPGpzkOaiu+P2DNLlhTKfElEHe0b+eyIovbV2MOAmeuFnTbyHCvW7SZsYzRStsGg64NA3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550339; c=relaxed/simple;
	bh=GA+sbGmP0cadvhaZ6fzAvv41j/rhx5wLP08hJ8nEK9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nls/RKZe/X8013e/APqgH8IYpO1l9PKCF4lY2C1+AjxMNBCTBh2Dq8loXDdK+XLIYSo+ToDf1dscXTbxKBpL+yUyES92n5RLwHmVOudsss3L1PJ8P1Yfzf+gbHcZsxE+nBovbnXNB7Xv05fEoAlvPxlJS1oOlGoo+FKUZKZPdJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S18cA9fn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S18cA9fn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6DAE1F000E9;
	Wed, 12 Aug 2026 15:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550337;
	bh=GA+sbGmP0cadvhaZ6fzAvv41j/rhx5wLP08hJ8nEK9g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S18cA9fnVkH9wTX9FCWcGfyAKnyrDPaReLxRkqfJCmRBCK7BC0bQuQoC7tS4Z6Hwk
	 FTMyZvqQxIm0a9PyVSplZVO3H+yP1PASi5E+QBGXYVU1HOPW8MvTuE3wuzDMQIWUV5
	 r5ZRiMb6Jkv2rxC/1qrOcVKCC+v2UvXSt7TZUDzZPZGkam0Y3n15zTKCqzvV1dSHBF
	 J6N4RzgXeMepRK7Jq9Tolli2RbrBpr5Yz3nhW3oMhICLjYQ6V4WGZIJq9f3Hk9FAyh
	 Wo7tqnOXlKOryHG0G77aO63u0PUtv26tux+Lo6KuEUDD4Uo/d4rlLCrMmbH08u8LTJ
	 MqJxqBYV+i2Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/33] KVM: s390: Rename kvm-s390.{c,h} to s390.{c,h}
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Marc Zyngier" <maz@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-15-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-15-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:58:56 +0000
Message-Id: <20260812155856.D6DAE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Rename kvm-s390.c to s390.c and kvm-s390.h to s390.h for consistency
> with the new directory structure. Update all include statements and
> simplify Makefile ccflags from explicit paths to -I$(src).
>=20
> No functional change.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D14

