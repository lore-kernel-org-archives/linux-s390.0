Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279170;
	b=n9OLh0+I0PunbOGsmDCfKJd+alPnRUrH9bg29PikBJcmwV2n32DL0nRdbS2/nYBu1XYR
	 tIizM3bjpkaheg2TRohehrQ9i7lMksIzNA98Ei21KLkMWOH9YVL7NU4O4kXzZJswOPolM
	 +CJ5cljvF8ji8utunAaE2uAjn2qluiKWWpcQt0BQj5RTJnw6iCIqC+bPoe65ZX4rt4p61
	 IlLryYA00RCwH6V09Ria1htH/uyLDQwBJv+sRHSZhkgtWtmlL+Hzov/pKrYpMycI03eJE
	 zfw+z2VUnMIarOoxv2NHxLfYMVmk9ROkTlc7Arcaohvveajp6KvCYIX/8lMGUUuvyXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279170;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9fnpBH1F+cWlY3r5A7dHX5Mktj9uJ9JWHlaJuHpJvxw=;
	b=SLU7NAKQZgKfEs9AifEYf9UVA3N6PlWUAnTl/8Cif4wkWDmqkz1jz5Fgysv/4mb4k74R
	 xLPrtfeH4TcAvbftlxZdslriBw2ahWWOCrIK0KTovwCvLTqJXEGx85TxKfQlGBr9CbISN
	 1lrftJ4C2QyDu999CWQx4jtCi6sKKe0QI+bsPMmNu7hvDIgDtgmiB5PoFsIn7t9AunIQR
	 8uz6b+GeeJ96UzBJCaWGEf00lSsp4ssvpRu1sqKg1Qqz3aHybBxDlQbmcae/9DQgu7WHm
	 mWlRsFhWI48+p+CV9L3Mf2bFligjdfeYkC6zH9OFi4f/e+SPsJV1cAjQfdYWOhckq9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kt7USK5y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4B6606A31C
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 13:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kt7USK5y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAAD21F01825;
	Thu, 29 Oct 2026 13:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793279170;
	bh=9fnpBH1F+cWlY3r5A7dHX5Mktj9uJ9JWHlaJuHpJvxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kt7USK5y4PlY2v+hF5KmRIEi+DUcQoc+XjNM1OByiYvNyqP61fUTwJk61eQJM35Bm
	 qCDaja3/HrTrpLb4vWDi8ITA3+wcuy6GIIBvQabH527yWwKE/aNa0Cw6alyYlGGS6D
	 UTpTRFTSZ+ZMfTfcVb5I0Hkut5s5j/249RqmiL8HDh5FMqMvP0aLUyOA+sWmuBjBTP
	 ZziEoUE/GrFmVVvKuZygniNq/3XxUeaTmAqmLdCW57pSu0xLt7AR7BYmGPP2cLnJrV
	 ecJlf2BlugViColw/d3mnJyBfH7Bfeb2Cocs9JWpoTZz4ICmIgUO5isSHu67qQbsTu
	 hfr7Ixsz9FDFw==
Message-ID: <sashiko-outbox-189350@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/7] KVM: s390: Fix idte_crste() clobber and table
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261029130044.125032-4-imbrenda@linux.ibm.com>
References: <20261029130044.125032-1-imbrenda@linux.ibm.com>
 <20261029130044.125032-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:06:09 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Fix idte_crste() to add the missing table-type bits and the missing
> "memory" clobber.
>=20
> Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functi=
ons")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029130044.1250=
32-1-imbrenda@linux.ibm.com?part=3D3

