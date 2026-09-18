Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D02E42E410;
	Fri, 18 Sep 2026 17:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789750846; cv=none; b=RPKCXn+Y9jvsDLnj+X782JvRG6pZuAsdkZ81TOs5JqCgj7oNmGxgwAvJNNoMAn2xuTG+AWthvzW3QXPuFqofvTzrFjeMVE/tAVvd2JYczt1CDVFj2S449PBE0JtVVaIUrNSB7rxvpV1Tb/cdLpvI5YLHwQT3cBsTDsqWjFBypZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789750846; c=relaxed/simple;
	bh=Tgy8itAFPDulQ7rFphGWMtZnG2tlTpWupHXoQMw6S5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MRk8QG5cwCGdPGoWM2qIeKauCi8N441OUe1kS+D+qFAdO5hiBdjiIh3Sut3yM2gCjFasXyQX9FfbQsJdnbU4Xjc/fsZPECPDxAqgw88ptpTJuz0NwuVH9xx9Kx7Vc7WzYV8p/PqaaHdoN/BMPtOmiYvXaCmBWM/ffrYTMEeSNgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWYMBS9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWYMBS9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565381F000FF;
	Fri, 18 Sep 2026 17:00:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789750844;
	bh=Tgy8itAFPDulQ7rFphGWMtZnG2tlTpWupHXoQMw6S5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWYMBS9dmg3/hWf1vupEz+0DaFluhwS8IXCm99Rz2jzU4oDzo44SPr6nmC40u+FKb
	 piRCENg6ao5C3LeNvqegT+s0a2oshndjSlqr+6WGOAEL5ZW8L0VNeD7oTm4xE1dQcD
	 dhgDMZi+lg9objiD0NxedTiDpXxklSZBT3qKlJdKH5gtehe0pnj6ngI5WX6FLLoWz1
	 nCP500WdCs8gVLE4h5EBQOomFviZ6+FbO0ndn1u+eNelNRu7myXSuhlA1sU675joIs
	 Svss5nTuBgeznUSr4WNkjsCN9hQNnJaMgfeQi2dxjT0KEO3+d0QZBCsRClIuUAgHOS
	 t/PuqtV0roN2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 23/29] KVM: s390: Add basic arm64 kvm module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, "Oliver Upton" <oupton@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260918133107.1042730-24-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-24-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 17:00:43 +0000
Message-Id: <20260918170044.565381F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add basic code for the new arm64 on s390 KVM implementation.
> Add kernel module boilerplate code and trivial functions.
> Add tracing scaffolding.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D23

