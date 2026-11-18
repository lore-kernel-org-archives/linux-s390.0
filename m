Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013593;
	b=0kPD3o2cu6PF3IzUKOs5aH7EV7G/qjFF5F3jh8UFhFkinfA01g3a9ePUNd8j57jKX5fz
	 mlrorl10J1sZ00a9YLYpuiMT3ig0VCLrPbX/Q5LBEyaCV9bQDVNdt2D/l1iGuvutjFt4j
	 lSDtMFmQ0lEXmkCaGgRgsl2LATD3uTf5d8jwUlIeoyPvdp3k46lK5KlykL7Z/03QYTpki
	 C/NHLQqoyvoEDTtMrJk5SBDXlrWhHosJP1M0qEBN2DGVO46tB6nmjRSQBqq5dkYTwkD7e
	 mOsla3fwRWhXHUkghwJ4mvEDChxXhnBO+1smDzg36nQFf1U+5Hx55Xl9avUQZ7eJTjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013593;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UM6W4d9daygjS7gZiggZTZ5l6ZQllHl0NwVVu6vbr38=;
	b=HXiMTYMFhZIdjo4BSH+m2QEmJyYHbtWt6N6do3KfDW0nr9oJjdBqROUd5JjtPmgitjXI
	 Jz6/s5LWuEobkMA9NzZFOcu2I3DhLEcLSLdEzb6tz0gTtAvGcgVIGN46rm/GbX/XIa/IO
	 xIJktFw0SHzCKUUnkOjRq0EQgWzulcerDkdeohpdjXq2lwmoO2W9bGdW4S+zc63ZgPF1y
	 DJYghnK4W8GiGm0BHcx2Hv3INSlFhC3Or1oqVS+HfE614NWQ6/AISqk4gT0PrlHi76IQu
	 TF3x5GzLNI3J3zGxSPkOGrn0GkcAcLscaYwJFhL8QUh9HLsdXLN06Hj7ZE94zzSE3TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6YNtZrM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2E606A31C
	for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2026 14:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N6YNtZrM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2D9F1F000C4;
	Wed, 18 Nov 2026 14:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013593;
	bh=UM6W4d9daygjS7gZiggZTZ5l6ZQllHl0NwVVu6vbr38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N6YNtZrMOM7nvdbHr3PsoxNv3E+QHKEdW09TR73YdojCntxKmVaLWBr+TgaXMb8Rd
	 qjEu6kn0DTdnN6YTuJnEgGWByk08a0BiHz89nK94qn6kNIEkbFyYsyR801HQwd+hiP
	 wIS54DBcO3jxWyZObhYXV8faTZO12Twy4O9UiFjCYUEA/mIN4wSC0kUiFZFi/VT+gO
	 bBG2/eiFvTdFLKH3Fju1A2T4Cm1Y3cvvTD4E3B71uruGVDaC87Gh+ME2EtIp46WuAk
	 fixAPnnxbvWv4MLOe2wnyVmBMnWDiUH83KOhZlJaWWAHDQ5hv7J6E10UcW6OyhZuJy
	 XRiLvsEm+BcGw==
Message-ID: <sashiko-outbox-221261@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/8] s390/kfence: Add error handling to
 arch_kfence_init_pool()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261118144709.202520-2-hca@linux.ibm.com>
References: <20261118144709.202520-1-hca@linux.ibm.com>
 <20261118144709.202520-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:53:12 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> If set_memory_4k() fails, return false from arch_kfence_init_pool()
> instead of silently ignoring.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118144709.2025=
20-1-hca@linux.ibm.com?part=3D1

