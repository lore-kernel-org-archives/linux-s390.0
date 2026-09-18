Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3522B503BD6;
	Fri, 18 Sep 2026 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752258; cv=none; b=jL9nkkHgGM/5Ks/cL3TIvDgQzN0JLGBYWunz4tm2p7Rvjx3dxMIf5yJ/fFOFypx41zO5TXhCNidpzrGofcJ8l52HgLzTtdlCKTUAS8mA0QYV8eLHCHNGJTt9yZAT7982mTZegpuidf28i0ibD25x5NtiQQStLI91nx2ADd9KtZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752258; c=relaxed/simple;
	bh=E+5BHLQzJ8NYFZvp+FrKyQk2TcmRvyQ6VG6NBTKR4h4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gi0412V2I4fPAmbKOKcWgIBW0jyec+fLYC1xjQbHtkUM41Kj4gNJr46rRJ0XJJhN7A3RqaTxNB44SyOg65QcqdBfYW0r/i+RJq5gGG5nK94z7+A2mjkurDbrVP9LT5rZd1fZ3n6ixrWoixZpRHOwdMH3pQZwlIQUp9MOlD/eTHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzL3iRKG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzL3iRKG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FC91F000FF;
	Fri, 18 Sep 2026 17:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752256;
	bh=E+5BHLQzJ8NYFZvp+FrKyQk2TcmRvyQ6VG6NBTKR4h4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hzL3iRKGLjO1hLi4vPFwZssQXRdTB9OfboWIiGAl8HKZ8La9JUW1ze6XKqw6TkDz8
	 cdf93Y+w0cUDwGnBsNrBMsQuKaP5vhlNqsVphYMoN7FEhZFoD/GqSnWjDzFO0AIK76
	 fvodOZ8XJ9Jbs7vtagDMtZczGltThqJQSqzkPhDqb3NqHzAkFnxZi03Foe6JxN1u9N
	 5Et1GYZKd8VzOSKtj1QIt8S0E/ag5cDZvPWK+wJfJfcKGuVEXGf0qafGl2G4rNhxg7
	 TMUku2BbzTgaF2LxeJpeV7ysTe5xwbQX3CLh8n5liAEug/rLsTL0BN74THSwmOhY8u
	 XoV3PXATdtiSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 25/29] KVM: s390: arm64: Implement vm/vcpu create
 destroy.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260918133107.1042730-26-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-26-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 17:24:16 +0000
Message-Id: <20260918172416.67FC91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Implement init and destroy IOCTLS for vcpu and vm.
> Implement arch vm IOCTL. Use s390 gmap and gmap plumbing.
> Implement function (stubs) required by gamp.
>=20
> Co-developed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D25

