Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302623;
	b=4EGiDAE6cBIN4q7aD1KXRb3jj0RypIspBdyxQHDCrUiHnth4A3v9dHkutBLqnz8vjvaJ
	 ps/RrvNZJajzzlzt5r9eKY9umJ7eEuDcaycri/G5Cxv5qwKBJxgsHyYSmcGteKZ1o4Hq3
	 uY5OKQGm6yE7hewbHwD9CgxouSwv9/VAXlJCBYeiJ5ktgz2KGgBGGvKmwMWNwE3OS/nEx
	 fQnjqbFsozR+A/AMweRM/iRS+6+/hqVYqaNT4JyU/Bs8551pE48CNboDlfod1BBaYH0xI
	 POv5HL/Uem6fEN3Zy3TuYRQ/OaNDkCW7DTXFLb4IjCXPSMudtlpMNmy6dY2dyXnuYqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302623;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rN+to8+upgyOYCK4fcZCFY63ySYe1ZVDvGbaP8aeLX4=;
	b=aG0h4x8TLMgmZE2ieaQbnsHcUW/OVQPIelmQjfIr3LSrgnnsUnWa8S2QF0FmvJUD9DGG
	 SIXaeUcRdcs2caBeMwHWsresquDTRXupb/VcgGhD4wGC351jgdkea8maFyZIeCcexveef
	 mdLKV1J3BGE+PIPynu3LfPr8ISdTI/saJFD4VbVTRBQVCp1UhoDLiWCuwLaVOOydmQGS/
	 adZ3VbfQYyJNMDdJRKLZ7njtj3s2/ShGXmBYW8/fLSg/9KF8faTbqTkHJpJRfq+s7mHYt
	 /W3+F4yNPW+YylgXjtCgZPDQwZK8LYbbuH/z/tpXpDPDlzIZJXtEQhOLMKlPtmwSzzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PllRZ6eb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A8F606A335;
	Tue, 10 Nov 2026 09:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PllRZ6eb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C761F0089F;
	Tue, 10 Nov 2026 09:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302622;
	bh=rN+to8+upgyOYCK4fcZCFY63ySYe1ZVDvGbaP8aeLX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PllRZ6ebiJtaLo6ikPBqXQ/NOJdOHKTiczeLI7QpjiMlPcU5FpvqNiipajTgharu0
	 2NBbOoECIyjI6jAcomy9UtZjc5xrHIldWV6YN+0v10xhgqz95IVYLPRPNIdRR5k2FP
	 UgspItY6Qiu4ukyUHCb1HGIOEzDQ93pvMSnLlYEJAQmfylNwAda/TmT0f3uw6QpHpe
	 uE0Uzhbdq4rB6oOqUpTkXhrM1ozyQJGOK9QbsCQOUuhHproryE5G1oVKqH4kNElzrs
	 VBn6mp3F377I/oCD/SJl4RNrT2ufZVJKAyV2zG4Sr039KakwpAfCX65yAcOdw/WrXe
	 RYKhgvLdWhdmg==
Message-ID: <sashiko-outbox-206724@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 10/41] nullfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-10-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-10-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:23:39 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize nullfs as a pseudo filesystem instead of raising
> SB_I_NOEXEC and SB_I_NODEV by hand. This adds SB_I_PSEUDO.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D10

