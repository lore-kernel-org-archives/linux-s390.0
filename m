Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416403;
	b=ErjxuaZ8sKtRllxrQL9xE3BhZ1MoWRrZMU39+e6oKJ5964NxzlXhvNPDfmfZxy9TynYr
	 DH+veNgnn87NH8aNqtd1JbVYnvXd5DWtD9qH5gqduFmMNcogustCZ79cOshi9yuzIwptF
	 FQUXwRSe89bJVnPXX4UDvMHwIHH4tb3b9sc8d+fWm2HcaarHw4sVwHgh7QULGhBrpw3MN
	 8d9j48lR3xvBArAfnyIqccqEXmSBsA41UD8xknOqMqvh7768QFElziujmevaCUUwObvxb
	 IE+Bxm86MfT0JRkwFBfI4DrQX8vBZ+j09hcSeWDzyFFA65SBeP1u8BgqOqFF2NjMBTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416403;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uq24XzkF/fy55wUU/goRx3Y5XdxdprLZipHlzeErJcs=;
	b=cSGAkkKlypor+uioY2FhfcxOWOvqQhthrUXt/h+dLoiM9+tQIlDQnXIPgJY2bpQRpz8l
	 95W1WddFlnmNLOTJofIsq69mpdDaxqqhgZcwhT580+iMiOY47goA1zngc9c8lJGcLMpcU
	 HJtcF3r1UyKSGOwqFoMkLDI/OhtZRnjEdlqspSH675b6qwRvdUhwHeQeiYkwzk/UqAvGW
	 stxTV7YW9ha418a9nFvjDOaT1bHIpSmmbxBmNia4ywKxV9sGyFw7lX2ROKDSlIEU4t/42
	 GmhayU/ZpOT2kvp8rbREUX0sgHSSarzQ57nUS2Nv06jYGXJ2q05fFR8EHMC+ug5xqrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvRPcgXL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ADF606A331
	for <linux-s390@vger.kernel.org>; Wed, 11 Nov 2026 17:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DvRPcgXL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EC91F00A05;
	Wed, 11 Nov 2026 17:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416403;
	bh=uq24XzkF/fy55wUU/goRx3Y5XdxdprLZipHlzeErJcs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DvRPcgXLILWoYxUORH9tI/gBrAVXDSaonkQl+AmiL4jRYgfgO4D+hnHS2fkQ9ujWn
	 aWAtX/XbuwekiXOSN0Sz9GJ/zLQkbF0jEkxgdqU1nf8NCZxShnApf7TVW/2b5G0eUO
	 7xzafucnqhl3hGQDUrPvaimUMTf4dDl4cWGvJv5Jck+tm7Ze2VLZBssN3OgOLSgoYQ
	 HdLrKmCg/zH3j/W1YdsDpTBMZtADbUGgjFJ8jIhESKw9LF1AKS1LvXVwPHSm9TXUqS
	 SB+L8v/pRbgyQRDIGuuLEMuzTTHQLhQ7TPdFsCZN15Si/ewdXI6pv6UhCCFs9cwN1p
	 SExHCzqWuJqBA==
Message-ID: <sashiko-outbox-209353@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/5] s390/pci: Hold fmb_lock when enabling or
 disabling PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261111162758.9792-2-oelghoul@linux.ibm.com>
References: <20261111162758.9792-1-oelghoul@linux.ibm.com>
 <20261111162758.9792-2-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 17:00:02 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111162758.9792=
-1-oelghoul@linux.ibm.com?part=3D1

