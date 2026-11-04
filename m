Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761387;
	b=Gqzxk/GTVncYwvEAEIUqLT9q8dT4dpWdLHmWCkBwQsEzcYj6eUxJQYJLaFZS2G5E2jc9
	 McQiwZSTbjxQqwoGITOSm/0KKUaOl5vkciFMkuBemhvpIJphMUZMo9d/+bZrFjhrRzOcV
	 4UBx/+QysDos9Urv1LfXkosYfL7EdN4FLD5eJzg2WSzQ23StHW9zLXsOt43bzoqRDwgWa
	 hajgmIJUWYjVtC0P/F5GhICguV/9TPpMSTsWfCifG18wTmm0gzdll9VDbAB3aIaur1beO
	 JVgO23QCEl4YC98m/vQF/zSUdoNAfVSEaPrLVSQDktO2r7cTnklZ6dEJZVSpIfRGBRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761387;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M2H8fq/p0DnSe/H5cA3C1yV2zObpFD5Jy+kby1QkUDQ=;
	b=goSSOr7HGH6eZMdmn65du2juOp3nuRWTD+U/A1voWhDt4heoIVVTBOTR3C8LIuB0oc4q
	 WzxglhifnLTGlvX6A9QX5JBhTwBNANdr6NDi1P4oPkV7L/NGYFhyc6RpwGAOApLVIQ6VS
	 1vTW+oGig5YU8eglX4gJR76fYMuUEyFvJh2JDerbwZr2RZHPkD5fbC3CzZDN/DPz1PQsP
	 P7ovU+pMb8u9b8vaVn7LVFgJUsSr5j9qWxvngy1LG6ulB0MbrVEk182XU4XH15ibggiHZ
	 9aBqh/QNAgbJ2liMsRJ+aKKYJfFY6eLdLTWfGbtzGSFUWPy6TdHhO/e2iGIlwKvmDDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxZmFt2s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34429606A337;
	Wed,  4 Nov 2026 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hxZmFt2s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77751F000C1;
	Wed,  4 Nov 2026 03:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761387;
	bh=M2H8fq/p0DnSe/H5cA3C1yV2zObpFD5Jy+kby1QkUDQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hxZmFt2sUH/hMbiZBMzr8BZkZyfuPvKKj9RXjaaVx0UIdq3dqRxrawnyt+/AveQI8
	 2qO64kmu7VohiNZSPX3sMFaZ33IFqcDflpj1bhCZHYTdo897vOW1wsf5Aozi4clARr
	 V1kE7L5WGAohoQycxcENfvxRDyPkPlAg2tdlYnyvjwk+So7gYSr56ZegVILvcvgpq9
	 Zih/HwB3Erb9fcumxZqozOuwBC0jSM1IEnEDT806gElXFaNfDZU5PC6lmPKAdWOtg+
	 V2yz92KDmXw1nyi2PoMkEyF5ja5Bh9oGOiPiTnzuKNh75rHTiQ3oUhg+sKTG8QWeu5
	 9Rt/0/8AQRoQg==
Message-ID: <sashiko-outbox-196570@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 06/11] s390/cert_store: Track subsystem keys
 instead of re-registering key_type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: =?utf-8?b?b3BlbiBsaXN0OlMzOTAgQVJDSElURUNUVVJF?= <linux-s390@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261103030226.2685251-7-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-7-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:03:06 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> cert_store refreshes its keyring by unregistering and re-registering
> key_type_cert_store_key so key_type_dead garbage collection sweeps old
> keys, while leaving userspace-linked keys behind.
>=20
> The removal of key_type_dead will eliminate that sweep.
>=20
> Register key_type_cert_store_key once during init before creating sysfs
> attributes, and track subsystem-created keys explicitly so refresh
> unlinks and invalidates previous entries directly.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103030226.2685=
251-1-jarkko@kernel.org?part=3D6

