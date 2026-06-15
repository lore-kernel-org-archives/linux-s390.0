Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2937FF5D;
	Mon, 15 Jun 2026 18:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781549273; cv=none; b=XzZhOAVbT3u2u3Awec2wI8D3EyMgIO9uWnwMOHsCTA/RyNhNQXhcjObMhzgKdShtj/4rf9ps0qwVkx3TrWGtUIku2QBpoB/ObqX2SYZiTJprhn7ytX16zofzxiIDtfD3ESS3WMUVEV4ZiMygtE+pMDhX3tnaVdinplCCZaVHcng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781549273; c=relaxed/simple;
	bh=Zqf0W9BX95gVsrn+zed0nO/8V1ohm4bxSr1iEajbe4s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QDMoqHh12WBZL/H3Neje67qIIgZ0EqS2nP09WrE+Ga/qyXNzO9+KIDZheqOb/ru2dQ/kLxPiNaiScVJEia7FqLj0mV/NCbqywvimovPC7gJcuOVEr1MMYhdP7F8TmEO60A76P4J6k0WDzz84GWG0cV5xFm+HoojoQZtppT10vy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOETbii/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOETbii/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8892A1F00A3A;
	Mon, 15 Jun 2026 18:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781549271;
	bh=UO3UHVlFn8lUUjEDD/wfmBNE3TL0G23ge1rM3YbA0p4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aOETbii/5mVMsXtpMDUzzksKiZNVWYMF72YLOsDtivr2jERzpOXkOOadCYrcESx5n
	 QR2xyavpxPrkWXlSqjsk+3PoF3zUO0nT59NHiMTeK82p1fxeISgWAlx/y9FFMUk7ev
	 IvCGS2TyKt6ydS/LixtbhlmVGydc9f9KWIIcHIvvdfjsgQ7dg/CgaNQg/O9LUOhqg4
	 J7O+R35W6JSokZ5FFw553i5QGB1hYLUC3b+a41BDwjm9dX2u7KUuc8TYw8az4wtNBH
	 gAIaDQr53a1PRcZh4YK9RbKQszb9K9bGSRMHFKLCNYBNxrClXl0ySI3sWkix5mIzjT
	 LJVuRSBhqCfmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 1/3] s390/pci: Store PCI error information for
 passthrough devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-pci@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260615183616.2902-2-alifm@linux.ibm.com>
References: <20260615183616.2902-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 15 Jun 2026 18:47:51 +0000
Message-Id: <20260615184751.8892A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> For a passthrough device we need co-operation from user space to recover
> the device. This would require to bubble up any error information to user
> space.  Let's store this error information for passthrough devices, so it
> can be retrieved later.
>=20
> We can now have userspace drivers (vfio-pci based) on s390x. The userspace
> drivers will not have any KVM fd and so no kzdev associated with them. So
> we need to update the logic for detecting passthrough devices to not depe=
nd
> on struct kvm_zdev.
>=20
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260615183616.2902=
-1-alifm@linux.ibm.com?part=3D1

