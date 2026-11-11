Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419017;
	b=4GaPfDy4rcdjvWtGV5RejeEb/f6bFyNk7fRjSzKySGjeqLlP2KHHJTje9/T4JqB2ri/L
	 YuxzcujEKHjy9br7fxx8oolIw/4GxhILqK9ZFVMEoDrUe2drGalHXwx+tDBlszsBJTkrY
	 HF7nFiPkKazChqJE/E98Dwnl6gcief4bTEp2mOrai09sP4h5IVsqkZzy5Za7oIlk/Okg4
	 ttFFLcbOCD/x79H1klrxzxIXb4ETQFFNoKkh8GCGz6ZA9vor9je8/5nFC11avfwJGvxyP
	 d6ub5Yw1KblU+NSnhVpSXqQ6ZORXHV+N04bxADYbUlEeHGDRqFVs5SreUOvXosl5c9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419017;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lWJiQL9b+KYFzYY8JhBIrkmkgCtD+LDBjZn8gyDvCz8=;
	b=HeK/DJppuKXpwle6urPri+GQ9QAHoZB6g4Hubt3Pj8BOKCkHOwDxFEMNSCAe8ucszP87
	 86uqSrnXQBe3C5POjFhlzPp3kbTaE0KXOOqkm8GfucuQTRIPc60rxy1ArfiGAjmTtyfoF
	 jK8E7fyNahbWTuZaJe6EsbiRgFXEFCS/RG9U3o4YwkUXeEp1KkXS5Fi+egNfbKkHGxiX+
	 xYbVua8V8m3TPbSBwcjnky3HFq2lyIb+xrWw5PiPEghSypgEogQ6kUtw+sHdpp1UlITNP
	 Ij1eXR8MuNJxC3UqcrowBzsGaGHeovzh69cFLCgnhVk0Rk3mSp6yJrqy+4LoTWwuR5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtU6RDIR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CA4606A334
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LtU6RDIR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02451F00A05;
	Wed, 11 Nov 2026 17:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419017;
	bh=lWJiQL9b+KYFzYY8JhBIrkmkgCtD+LDBjZn8gyDvCz8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LtU6RDIR06X8Lft5p4r8e+g8mBg9lkuM9FPHWppPMahqJUDzwxlCoEBxjcb72ncEz
	 T3A9IO0JMtfGHINBOyrfnVdPOo66tNDE3D3sCRM01raxKjJwMs4wOZk/15q4/6TK4F
	 zme4WOg4r4x72er/8Aa1B8fH0CoXGrGgIPDC+rSfqWCzjjuxu7XGdrc/W3WUQPsPFz
	 OXvd0+CYCETEgI92MQGFeFxVLcFjAxyMdYtTNJJUnTN8bh3WPTAoGdohg6pIwANztl
	 KW4h1GVX8tMGLrSlp6rXDARj9kOCydx8NSX18KLk7xOGYx3AGCw4t+eicdfiTs6NHH
	 m2QDWCu2EoMgg==
Message-ID: <sashiko-outbox-209432@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 5/5] vfio-pci/zdev: Add VFIO FMB device features
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111162758.9792-6-oelghoul@linux.ibm.com>
References: <20261111162758.9792-1-oelghoul@linux.ibm.com>
 <20261111162758.9792-6-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:43:36 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Introduce new VFIO features for zPCI devices to provide FMB passthrough to
> userspace.
>=20
> Allow the user to enable or disable the FMB using the SET-only feature
> VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE. Likewise allow the user to read the
> latest FMB using the GET-only feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ
> in the case when the FMB is enabled.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111162758.9792=
-1-oelghoul@linux.ibm.com?part=3D5

