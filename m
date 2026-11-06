Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985813;
	b=Wrs1pb98eBXheDU485PnN8qbge8bBv5McsiQvs7qddZYSdXZBDslMHQxgOgS1qAMMzwN
	 g+9QMt5q/oAh+CNlTaMaxhUx40PXDCjfMzhtlAQ7/YiSfSPzAJTTjYzBQ5FjS5Ar4VYZ/
	 ERHuyw5WoQ5wP1eoknncuTKMt1+qhOzrP+G2eT+OrbDCQyo5ea8/yuIZxCclowBYomr0U
	 tvvQ9KavBz9RBAn2fbIRDcTfWiHnunq1sNib89SeczzwMYHpVPqZ14M3huYYkYpPLEzux
	 yjbJJdEODSQlf2UmgO0vQ2ykfGnCnrtBvVQ1RSsNkmm5o2tTlDfk5ZEcZzcWC1kq9MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985813;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gh4yQ01R+SsSF7x85nXoYMljrdQ5KgaSHxoHoeitqS4=;
	b=e5kj9CRigHas17Gc//keS4TOBOdbNglhrflHGEEOvK83UYF4nnGpXEUQQs42bMwqcqrb
	 3EO4VM6982tVClhLB1lWv8g/I6LS8VM1SwSysbH0gfwIMTFgdF1qYaehX26asMMgyoQ0b
	 YuAiWJ0RhD8dFqPJ0Y0IWcWwPb+oGbqiKljB1Wa5cmbeiAWzvRst6peVLtr4t4+K5ONat
	 dQbJklvSvs9Ay6Ul/dyxVeZ9WjNTMmNim9Q7oTLbPLvLkRzBLJiU5hcgByrzi404HwfHz
	 fidGAndmfm8vjzF52keDtGalhQQkVDQiUOSpkuy0JwqYIumGX9Ylr9Pwnvc7Ql5nrKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3UhzxLY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7994606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A3UhzxLY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEC851F008A2;
	Fri,  6 Nov 2026 17:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793985812;
	bh=gh4yQ01R+SsSF7x85nXoYMljrdQ5KgaSHxoHoeitqS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A3UhzxLYFnpX0L/wAY484yqb0cc2uw8SyIuIwvyQBMRk99Ge9Ok1PhjgTNMoWcLgG
	 QRBgzNwUJx+YR6gZ+UeygRUzusG2oyo4TsAyxP949CWGK4smh5TDN0B8om0CGa3Y2F
	 WY7AM2s5poo7LCpdW8muDqVD+X0JeqZ4Eobd2ETwShgFyx92na+SmHsgMS4XUHNR6v
	 vKvw/KMPMuqO8v2wlEjd7x1Gv6PbLBRvyKBHyNGLgB2YnAW3dYuKSPwMSYsMlIRPXy
	 8YWc6C6sEsrK0gho2LPge04sQCDczFnpTEgYQ6cQIGUBbQr69rIN0+hiR6gct/mM0t
	 RnS45RWMg75aA==
Message-ID: <sashiko-outbox-201915@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/23] s390: Add range check asm macro
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-10-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-10-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:23:31 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The range check macro turns cryptic assembler errors into an easy to
> understand error if e.g. someone mistypes an input value in an asm
> macro.
>=20
> Add an asm macro that verifies that a given input value is in a specific
> range. Add macros which check for ranges often used when creating
> instructions. While at it, add a range check for the register numbers in
> the GR_NUM and VX_NUM macro.
>=20
> Co-developed-by: Jens Remus <jremus@linux.ibm.com>
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D10

