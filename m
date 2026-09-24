Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE196442FC5;
	Thu, 24 Sep 2026 09:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240795; cv=none; b=tqeQKobTDsvk0dSDiSb6wMR9OTm2zbyyDMcDjzWBWy3MLMezD32Oynm2/s9FGLzvgcfI2G7ODEYlalfnv1Dj43pHu2EobascdQp6MncM+9314gRoZjjos4dVNl7DR7b5NDVqZgkOEQym6m4AXlxnivEd5jGzcq+EqrGL1OwhEeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240795; c=relaxed/simple;
	bh=Os19DGE1wFeyqpT8x3cqnCHqcXoPE4JQSqtxles1G4g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=usaPdn3z1WHCsQlMRfHMr1i5uTZl0z2NU8YyTyHOC00D11u6y4SiEFSZav3xVwHWx6H8BRtl6mQa1ihrV5iYRmggkl+mbCOywLT8sXGUa+YAZut21wT+JWEUFWAhSGXXxotBZIdssGyUeMEQtxzTJ/EWzCx9KM7kpQvs/tHDLkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HRaaGaPu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRaaGaPu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7451F000FF;
	Thu, 24 Sep 2026 09:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790240791;
	bh=Os19DGE1wFeyqpT8x3cqnCHqcXoPE4JQSqtxles1G4g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HRaaGaPuN7//LJ+2z9qiZ/SKBAPGayMpy0Iz0kDfpT6bP2PR5uZ/PuNSquJqKWcM2
	 btXFYlnzBZATEnmwxdePkSDq9Z8U/HJ4tZ1RI1Ea3bvqn/RfaOuRmMa2tBqp3OT3ea
	 qUAqgEPFLhLHcYVXxw4xYylDWpwF91/W0EnaqOfO++wqii9ZWuBeDYtFr9m5cabjly
	 1OU9uQ89Ka1EVrSbM0vQDPmDeVErsXDeJfEVwvb6pEQPL9EUd/SKh2dIViNQuJnuy2
	 5hyqITdUnTp6QY2wPGo7KIDkMNElBbM3RxJoyDLFlsD14gyUi2e1SuoHmGl5tBfGRy
	 REWwVjUMnD/ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/5] KVM: Introduce file_to_kvm_<arch>()
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260924-vfio-v3-1-4a294307797b@linux.ibm.com>
References: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
 <20260924-vfio-v3-1-4a294307797b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 09:06:30 +0000
Message-Id: <20260924090630.EA7451F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add a macro mechanism that generates an opt-in and arch-namespaced
> file_to_kvm_<arch>() to convert a file reference to a kvm object if the
> file handle represents a kvm handle.
>=20
> Activate for x86 and for s390 (native KVM only).
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-vfio-v3-0-=
4a294307797b@linux.ibm.com?part=3D1

