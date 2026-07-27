Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B8E3E44EF;
	Mon, 27 Jul 2026 10:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146763; cv=none; b=rKp96gwVM+7PHFWUflEF6bfkgLKkkiYtkJpIr0909TgCiE5M0Moxhf+x8a3SBV0tqSxRTZYNwFRE85sSgyk3L33tU+Q8Dgf8ioVWCHf+LuKaynuomGJFUPwxvSp1ykaFU8MH15VA8hMUkgqbTKTMf6y2dmVhhvN/5bqfxEASG8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146763; c=relaxed/simple;
	bh=edPPFSppao7S9lX7cIZh/6+2LOTwQKgOQoY37mNC1gE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Nr7lwaAn1foewTVvE8ogZ1l4J5aLvAenapWI9ecOu2aYJAORIrQJhmc8pPTGIbxhEEPMU7aXjwlxRQC3ncPXjhd+yq4WvRyf0BMto+RhGdu8fE/ThdVpLt8nZbq2Y+KOAE4GVNJAj3sCf0FOTaaVq5NuXkik9M6ZT7cD/w7NF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2A/qqeL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2A/qqeL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC0D1F000E9;
	Mon, 27 Jul 2026 10:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785146761;
	bh=edPPFSppao7S9lX7cIZh/6+2LOTwQKgOQoY37mNC1gE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J2A/qqeLMycyegTgcHlPIWMSAUUKSvA2EkGDynVL3mWJxxmjuJRrdfA6xg1mAl1ow
	 mAgJniwMxzpXtQ3mhKu75BEm+V4+z03UjkUZK9ibgDhKw60jJr+mZht/XmBz8xxImY
	 dgml6NGsfdua/lXo6z1C+bFO88uDbeJEr/rWkJ48Xq6Dd2fXPH9BCttsr4ZRNIJehY
	 jHYCKGStyLh3uhQcFtj5E0ywTj7Huao/DjvT0oZVR2hTeLVXm9L3TUT/1Ubf4r5yjK
	 ddj+6MFdKKMG+b/Ly22l3CBCtA+pICwsS26iHtkptGdALMIz9a5TudTiWWARLVZKmd
	 WVapKpCOH4DjQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 2/5] KVM: s390: vsie: Avoid potential deadlock with
 real spaces
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@de.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org
In-Reply-To: <20260727095359.107671-3-borntraeger@de.ibm.com>
References: <20260727095359.107671-1-borntraeger@de.ibm.com>
 <20260727095359.107671-3-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:06:00 +0000
Message-Id: <20260727100601.0CC0D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
>=20
> The natural lock ordering is mmu_lock -> children_lock, but in
> gmap_create_shadow() the reverse order is used when handling shadowing
> of real address spaces.
>=20
> Convert the inner locking of kvm->mmu_lock to a trylock; return -EAGAIN
> if the lock is busy, and let the caller try again.
>=20
> This path is not expected to happen in real-life scenarios, so its
> performance is not important.
>=20
> Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727095359.1076=
71-3-borntraeger@de.ibm.com?part=3D1

