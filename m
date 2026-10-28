Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202857;
	b=xPHFsIB7uqMxqP8DGr6s0avgo8uCfpfRl+G8efTirIn9OmY/d6Lf0fke1v9sbDBI8zS8
	 Vrc9F/i6CWtWs/j8pTHyoaOGu98enhnjSIROrML5vKOWpDJ2zr9nSfIe1rjsyDD2BvXAj
	 h7YHcIyBpW6nNp9Uqn/2YkYt2SENP4HHSXVjJQzaljRANaJ5jl1s+ZwNuLfiTsr4Fxmo2
	 a8ttj6vuy4ttA3xathrg2QEBcx5YSyamCUzntzPGqUnnjLQXh4OEpexyckiM0UQ7XV2sG
	 96LPK/x2p5hqfSKsozDXPAp+MUPAX+z5KDvGDVdNwXTWjQWN4GN6Kps92VbUfdui2gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202857;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5+s1B30VoRx138+jJ+TrUp3epO+7TpRZstf7YxrC0m8=;
	b=jV8KcPZ+cH/o6eaEMOvwN3VhNc+bJkc5LVBFF4pNkQl4Di7SJ76oeAXm7Es/UJ5jMdDM
	 3EERD4u26FG3vl0SOdViC9eMP6TxpXl/9j57ODd+vM3LxV3eI06R13XbI7n/bB12KEkRR
	 xobS1D9IxxuqE285e+YyBT7VoXwqmLphrQvTcjlwIq8Hl6y9xD22GIP6pENs9b5RvNYQd
	 aL7ziLOIxfka6t5XMqayH6E5TlKi8wIQhujcIcT3haNynE39zdBulsM7EXpPHwkRpqhaZ
	 ho3AEQyg4bPbj5/XP2gQdl4auoif/qAPMEKrykaihPWJNmNik0d+1RQPJDKNgMVrAXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cyt41k27;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A82606A31A
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cyt41k27
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D392D1F01825;
	Wed, 28 Oct 2026 15:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793202857;
	bh=5+s1B30VoRx138+jJ+TrUp3epO+7TpRZstf7YxrC0m8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cyt41k27ty02iDhmhBjXiBq3KyCqxI0jTwvWWQ9lIPLK/+dPqhYJYYEak1tbEklvy
	 Ukguj3dpgI78OgAeNshLcGM5CTXj9ZN3YA0pXy3L9Jl0U/ncMSF35/Auyg9+yqcwex
	 xTQEgEimomJYuovxBRv4UdqHSyacqTdg6ITTJZXQRBGd0EDLLpsBoAu4lQzKG02p+L
	 AUXbFV/KWJ6iZ4Kyab1WAJWkjT+PvbO1KOhKXNgUwSwoEiOhz3VlfC/jdrgP0+qxgD
	 vXAGHLoHR4e7E8CUTLshiXIGsPyxb80qZ7Uyctf3eoXskiUHh++opq1USevtmHtw8Y
	 nApqCgQ7BDjWg==
Message-ID: <sashiko-outbox-188101@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/5] s390/pci: Hold fmb_lock when enabling or
 disabling PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028154352.15108-2-oelghoul@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
 <20261028154352.15108-2-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:54:16 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028154352.1510=
8-1-oelghoul@linux.ibm.com?part=3D1

