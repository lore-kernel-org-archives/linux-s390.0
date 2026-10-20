Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486104;
	b=yQb/kz1xOnGZ8PN9fpt+2bs8ouKHFSUnWGE5jaSO9WawT03HnPhrpqGuK9QQYN1hyqbY
	 57BePEbraLcCkFh6HoBvKcGd80CepizT1iFj6XhF1G2El/Luuwu7AyrlDuXv8JegIth3D
	 t4DupPIJ2/RTpxIJQAAxqozgQJEECCFJwiFKbLyzARhZQgVesEKdRE3FubKJHJ84Ez8EQ
	 IZMPSkaoeBhUP3q3ifF07HgNLxn8ab4rVgL4bf/tlh5ckmmSMMYvxZavm/s2QBdD/naAu
	 slAn4QHfbmdAu8XP7VJwAVqcF/HL/OZYOll6g8x7P1D62FpOat/UPqx7K22eIqEbKqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486104;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cKi4GeWfq1fvE5N2B48wXce/9Ul3ZLK5kWU+NlyG4F8=;
	b=brJwo47wN+CUYPE4NKD4GLg6Q813UdVJDiWFPaEFUgTVziMH77PMAE5ARFXKjI9iqGNM
	 9aTgB0UI0n0q1EggG60eoOsQoj1KMZuBCb4Zgh41de9eoNoZhcDQKvLopBPTMFABeEfbm
	 gUbT71np+/8xK1FYHwISCPbWUWSjv6Rda/PNobgy2KEw9gX6b8dsL4Op9f2xyxnaVNyAP
	 HyACAq9mlQUbd6bMaaikBNkZVomqB5IS9NCOaArynB3k1bXjIcHSkLOX1MBJQV7uoqnLn
	 mgY474+BzKPBNda1AQSzQgX4LnNjKvwLqhBGT+SLtC6di6DlOnzmxLYq356qT/z2YnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b/LCGxA7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF28760A3803
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b/LCGxA7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B531F00ADF;
	Tue, 20 Oct 2026 08:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792486103;
	bh=cKi4GeWfq1fvE5N2B48wXce/9Ul3ZLK5kWU+NlyG4F8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b/LCGxA7nDaJJDl8ls4MJTWxSj+K+CtMI5hxrNk2uTR8lTrmVAiy7S++GgraYOfnm
	 zivpuzcwXKxnCwH0vfgZBvql10RdqxD+Zs49Ds6RmV9h2fzXxJH4mkwerP2X004BYi
	 MJtQ9FBtZYmRszbY0H3ueiFFayG69++c+sF3EQKVWfiW1TiB/gXmCmpLoeMeS4flyE
	 wDYxGXd2R284um1c/Lfn5grmiSdIocNfAeazLfHyLPL3Iatsl1ws+d1SNlsOhbEGWD
	 QIlTE2cF0aUaoG35PnBFGglHN7rPJlbaM3ByJ0ir2gIWPU4EaYydAnYpqIBrHO8E7g
	 Pg1ErtD7CHZZA==
Message-ID: <sashiko-outbox-178626@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/1] KVM: s390: pqap: fix AP status written to wrong
 half of GR1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Gala" <ggala@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261020082534.481867-1-ggala@linux.ibm.com>
References: <20261020082534.481867-1-ggala@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 08:48:22 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The AP Queue Status Word (APQSW) occupies bit positions 32-63 of GR1,
> i.e. the low 32 bits of the 64-bit register, while the upper 32 bits
> are reserved.
>=20
> The no-hook fallback path in handle_pqap() synthesizes an APQSW and
> copies struct ap_queue_status directly into GPR1 using memcpy(). On
> big-endian s390 this places the APQSW in the upper 32 bits of the
> register rather than in the architecturally defined APQSW field.
>=20
> Use union ap_queue_status_reg and assign its value directly to GPR1.
> This places APQSW in the correct half of the register and aligns the
> fallback path with the register layout used by the AP infrastructure.
>=20
> Fixes: e5282de93105 ("s390: ap: kvm: add PQAP interception for AQIC")
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020082534.4818=
67-1-ggala@linux.ibm.com?part=3D1

