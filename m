Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773164;
	b=1Ex3UXCoOOpiLxxNis+Sy0lTlZ5LPyVyyYWQEDNBSt+o2+KiHWX9TRU75jpAOe9pmCrc
	 MxU8oOAuUoZimgUJPSOpAnhKgzPyedvIlh/6FisHjUhJ5KcJRlt88WKDtqOW0Jb15olO8
	 C/2MwUXv5WTn6rMd/Bi0HPZzX5V52TGpBuaK2XrNMZIDWsGWdRozNS3rw4TfzeoU6UWy/
	 ERvw2CMukp98RzMdgTZtU/GGaq2mwGKuScKC3AzGA3iStAPa86bD+R8Foql9bja7PlxSj
	 YQkBvEtUz+w2JKK6+KIyd4MbN391Smp5a4rqG7JMvfN1IliD0qs0vsvCA/awosBwFBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773164;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0q4GCh7EP1pb1H+DF9xQ6jCPhF8rMGz/Gfg5Fx3vTos=;
	b=izpVwqG7K5VxteBL1bxLxh6N0WDIzQugxh5ULU0o5FQ9yB14yEMP2NxLpGaSe4oi++0I
	 UsDj63sgQV70F9r1kP932+6OfcepwfZN8GUJ3U2tXtf06oIIHpo5/kxCX70PMRkaEgIO8
	 p3xCbsixlG64+TzraWxJa18zcRxTJYjJ4PeK01DPSXCWFaeTru0qIlG29u8L5BUv8ZeOw
	 PHeZyA8pgirlQ+amvBprVZjTlwqMdEqmzFgA/f8Ha1g4gmJENLedS33YCqREjC4XqoC9h
	 BrMVPM0AGxJptZAPF1ed9JWZpV5814X0ax2kHp1mJA1TMmFbP/1o+LFlT39htbxXGVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6b2NlDa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D68C606A31E
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F6b2NlDa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDBE1F01828;
	Fri, 23 Oct 2026 16:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792773164;
	bh=0q4GCh7EP1pb1H+DF9xQ6jCPhF8rMGz/Gfg5Fx3vTos=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F6b2NlDaSjBDRUEHP0vuNc9dg8d4RvyTAC6r4qy/Q1UV+udyoYp6TJi6PH3o5zpAD
	 o5nz2+4RHxS9reM2MiC+m4sB5ur7B82g6GPTA9zEUdgKm6LebIyukv97V8nFKyCh4R
	 4LhYhhB8rI7a9pVRCKNpdl88O3bXoEN6eAeafWrFLiUxMO/KHjNxpuitd/mvF4E7pb
	 V9/oqhuwApMKhwx3ghpJJaRcrBn93jss2AnD/UASzq0iDzZJ38B2HhG+2pEPY4AsBo
	 I806QSWj+4CVSITj1ZMv0+Fj3YnHmb2yf8m7Q00XuSmSDPHErRZkdThDTIotTsG9T7
	 HVIhMz6Q/DNLA==
Message-ID: <sashiko-outbox-182951@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/10] KVM: s390: Automatically enable storage keys
 for UCONTROL VMs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023155531.206113-5-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
 <20261023155531.206113-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:32:43 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Automatically enable storage keys for UCONTROL VMs upon creation. There
> is no point in leaving it to the lazy initialization, as storage keys
> will almost surely be used very early in the boot process of a UCONTROL
> guest. Furthermore, if storage keys initialization fails, it will
> prevent the VM from starting, instead of failing at runtime.
>=20
> Opportunistically improve error handling if the fake memslot cannot be
> initialized properly.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023155531.2061=
13-1-imbrenda@linux.ibm.com?part=3D4

