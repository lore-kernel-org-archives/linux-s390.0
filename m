Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984074;
	b=nrAec3JMg4R2JfPQrcIVQ+SFOYk3N36782W0O6TD0iy9xMFJvotUR1imw7bBaWHQnzjr
	 l+hLZLqYedgTuGmB/rGdE+AO/j2ob+78/zsrWxDlNB1/01RgMCz6CEEVDana4KqX1fWpZ
	 rD2XamxrBjOC74OCwyQBi2qrMhXGN0XcZmH+576rb0Hs5kITLFli1rBiTwv8x28dvWl8L
	 rc6OUD9VGxy0RF8PHfdcOnj4gGHDcdY2tnKHOpgUG6Y97y6yBRRLCCzmIR/JNihyumlE9
	 v3iUPGBI56s3F5FxVo/4VMA6ARHpq/S0hrcDL9cG+WBD4cvlZz+rEXlmabZP0DgayLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984074;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5+iTFyjnocYTY6vOsqfuPYPe/WgZ8kzmshvN327/ZtA=;
	b=wf06G2Z6Ra8nwPbx/w9WI8gEhdnjndj2xBp24updBfJj/Uh2ieu55Ki5VLMvrnpmoqJ8
	 Opf11ruLRh+NLnctL//gomupPhQi21Lo0uHG/Q5mSPtoOhG2NhHWpQL1j2CGJKhWsuxJz
	 v2hjleikogQ/HQCcvoPGhZt9z3QiOWDY+Rr1rFimc2ZVw/EdnmrAidtzNlL8q7tm/fDgM
	 /D/QDNSOr16ObEyIxwp7Ihn4t1aNBP2aXybdMoUyONTghgpiT1Yzy5UUG93reLxWc7aG2
	 dAp64oG3AHPKSMQDo9lepPnKKmcuOttNVT1DqXsFOKbtwGvHNm6hJBprIbvbmsQD0yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QcfaWfAJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8822D606A32E
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QcfaWfAJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46F41F0089F;
	Fri,  6 Nov 2026 16:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984074;
	bh=5+iTFyjnocYTY6vOsqfuPYPe/WgZ8kzmshvN327/ZtA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QcfaWfAJvFG6S0jVXIMIbhsl04UOdF90ARgHt4gHNfnjQzopXwruGjr8UetkBK2dE
	 jGoXdsPkleKUK2r/MbV3AsK9lHt+PIWcno9LErPeh7gJGI7n1iJS9uetOgiV1V3vcK
	 WDRuow06jt1yau7lMJlIi2/ZgK0jzvv4NWdUG8h9KRKiJYKStOQenT1R1MEbvFpW/7
	 pVt8KkHQicX2sWhXfamMGEPXU1Q8fFmL+M+0nESJUvgJ+acZa3FTljJH342ztl9GFM
	 VHRWpbY+vLNw22J9AY51ICxflvuvE5IvhddTItT8Z3NtfQbwZVxs8iNMcTeyM6IhvB
	 PMCMqXGKtgM2w==
Message-ID: <sashiko-outbox-201871@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 2/6] KVM: s390: pqap: fix AP status written to wrong
 half of GR1
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261106164958.431978-3-borntraeger@linux.ibm.com>
References: <20261106164958.431978-1-borntraeger@linux.ibm.com>
 <20261106164958.431978-3-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:54:33 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Gautam Gala <ggala@linux.ibm.com>
>=20
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
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106164958.4319=
78-3-borntraeger@linux.ibm.com?part=3D1

