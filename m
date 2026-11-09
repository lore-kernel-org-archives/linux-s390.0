Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263314;
	b=deEkyb8xsgnbEymr4XlOM+0gK2vvSM/S7cMIIJYRbHJUeNwlJM1K0jiuopbu46OqT38K
	 Pn1NuoQgeW/NXWAjbsglkOWSLUcVTxYDkIIWCx4SF7gY+25FIvkx94GIEnMLuwo0oHhBX
	 T8fI0Sp7M0OaXgfMm7sRfxrjqyyzzukwa58Vf34bmdGeo15zvPoAp4BTxkLFf4C2hY1hK
	 +vBDG1Qazv0u9wrv1QC1aYzBfgMTJAECylpMCt7zw8Z+dvYC7zhyu3E8GtwnmlbT92cb+
	 4u75aWC3CT9aRSLtvTvEGAUvGVXZffWWnlKR7caeVNMvmjxFEGi4BC4FlqXOX+F/ilw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263314;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0bIZzPOIxpvyMADOWWedBPO1GI5JI63CSMEIKGy4HPo=;
	b=XBn8+G94wnHXIZe3dkyy3seEcmRVivWnIZFu6o0lcMlNSM73fosv4VYiDkr5Jt1DMm6/
	 iHRaMTyfJVHzEidDDNwygYnWQZbJ3yVOd305Bm1nusGoz2XpGj9s98J16wg8A2UcTyAHP
	 XOe6gZ/YY0gxBDw4/zX3YcqKuBj3Ytn30ot9XArbVPL98wAFJ5wHkMfb5eu6541XL4gvY
	 S5ARcS+GdgpIkXFeacqB+O5gpnMLXYar54KcmJklXe7ZdPTS7JU7MJXFGCwYLUIPHtMl+
	 o1UBlRGAu5bC1frajMeMRZGWeRNdo0bJMZfFqgTuUPvYyCHJ4zRmDJ0Go/2An+nIqWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btCedOX3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F7F606A331;
	Mon,  9 Nov 2026 22:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=btCedOX3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4E31F0089F;
	Mon,  9 Nov 2026 22:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263314;
	bh=0bIZzPOIxpvyMADOWWedBPO1GI5JI63CSMEIKGy4HPo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=btCedOX3Fov58BkxRFwiWId1VilKW+2HPTEG3eDshbquOg0Fq90oSYtSS/+c7yEn7
	 tYlJXfhGKO8/jwYvf5VwU3zooodXfdqzbDSpk66Aw7KXQWTo64Y8CPz5212xWx8l4h
	 qFt3q8Y6vF8IAAdnovSpsRLnq9QIJbUpeDCYVBe5Wcw4o5uc9Z4RDVRWs7S8h+PHPY
	 Dgbs7ZUJuKmffXYG0ZlTzaK0+7KqXcw2ha9D/oL9x8hprHM9BTbHshbnv54RD8WThU
	 D59MAxrnURPdbMcsXsxYTXf4VCx65fGLBd1JnPolHSycs70FNmMhSSA/OcA+v77M2n
	 RedIy89WFyOwQ==
Message-ID: <sashiko-outbox-205737@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/12] KEYS: Remove key_type_dead
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108222719.304712-12-jarkko@kernel.org>
References: <20261108222719.304712-1-jarkko@kernel.org>
 <20261108222719.304712-12-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:28:33 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> unregister_key_type() no longer needs to retype live keys as keys and
> restrictions pin the module while they reference it.
>=20
> Remove key_type_dead and associated code from the keyring GC.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108222719.3047=
12-1-jarkko@kernel.org?part=3D11

