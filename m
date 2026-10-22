Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684848;
	b=O8ExO2sBy4bAxodyiOzhBYdHWpkjNb+WHShkX1FJpfvkOFM0W0oeRrX3b9deOPShhadV
	 sTcTZVs4YvoysSOGlYShk1nqFi0ju6gq0hkxQZqsFtiDMPLyhmFHlM4uzIvzTLeI69NDe
	 24rMY/Mj6U/VdKihP/j5SpLiAjWSToS63ERNrUU7IpAC/VN6e7SK/kvZYuu5r1ITO3Nrx
	 yJ9Kmr6kJDiQ9q9Gu0JyUTXroWmqr/ZejscsKiBm0diNwU34ciB+74OFpFAbM76Twkkta
	 2ADog55C+FsApZONviMo47tRyrXsc0V94MA/W+aEzk3DLV9ZXH9HXNgdux+v7qiZfOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684848;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rnPN6WumWJFNhSycuCBjzxxMjjF0ZsEo1cCRkkxHVps=;
	b=GSee7LH8ZuaFKKByGew+KYjKBka1d2hTY6lvPnWt4gqG63la4pE6deyWm47Q65dt6Pvb
	 mWQncIPfpHIEf8ft1uPJ9SsVM/5JjdmPC7Fjv1NYVBroMTIg2Gmk3KjadcaBF0Q3vIgvp
	 4nI7EB8QX8rPlLUtBMuLnmT56hOjjjlYmaN524dVA9giGn/BHO5zSoMrwQ5SvBa+nn20z
	 FuMWCQ6+Pf0uoYJJtK63tJgCQAk8qrmWluSHdLhlxsGLYecIzCXLkgUPuXpTgmFNFhJMB
	 IlA5tlxevGvDQI+mysyhamResseSid0HXwFPln3KJ/UVOL2OGouKJwmZs+xm3nbaQlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKlDY94M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9166A606A31A
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DKlDY94M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF271F01829;
	Thu, 22 Oct 2026 16:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792684848;
	bh=rnPN6WumWJFNhSycuCBjzxxMjjF0ZsEo1cCRkkxHVps=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DKlDY94MQ9jLMKJvBJT+YTnAjoATxsmb98fBz5TdUReXv6/HVnVqzaoisrwSY9us+
	 NMajYpjjN8BHzZCBNBkgBkuK0HMZP3VNmXZZnhoVZEt1QS2Frc2gGk9y6XBpLhN/hC
	 TgPwHM1uByC4TPFAUcEA8AH9y1L06T3/2bi4GXYVja3+mQ8fgH3UwgHnNMHtqyea3p
	 C85lM/Lm70BnR8XtGCZ9/1s0ZhE/RUjL9ISwvbKk8VrroZf/m4ZU1RgUvaHgLWc43+
	 7nn6XFfsxLrKIe6fUO+luhkKpXn/V0Vfs3PyQHXenS8mi1pIgwFcfOXCnjOKBkXrop
	 6EK8CYtqWdnyQ==
Message-ID: <sashiko-outbox-181748@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/10] KVM: s390: Rework some helper functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022155531.204593-7-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
 <20261022155531.204593-7-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:00:47 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Introduce export_on_unmap() to make the code more readable
>=20
> Move the #ifdef inside is_ucontrol(), make kvm_is_ucontrol() into a
> wrapper around is_ucontrol(). This way the compiler can remove more
> code when CONFIG_KVM_S390_UCONTROL is disabled.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022155531.2045=
93-1-imbrenda@linux.ibm.com?part=3D6

