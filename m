Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795093086;
	b=s1ZtWqR9qK1QeUlUruZuSbTvFAmhcI2Mya2bcH7Oy/b7zwthmNlB4FU6a8tZlTZzBdxo
	 u5ETFzZaUCR3PbZGwtoxeb0uvCkKCe1S29UY526xB7n1w5JcJ+cDD8nWP5aKLaCxQNGIY
	 H67c46s1wkcE2JzDOlaQabor1sVZH1GhqlmlE7HqGBiaDT5b6UvtneETALtKSoFEjA9wK
	 UC0CuGX+qHREVcOKZP4eHKUSXNDniwmvnZjEjs3uRJpLVFIy1oxfeM3NRktZBZbEc0S87
	 s0iJnjC1qKNxypZ/4EnWeXlo5KrgyeTzu8araI8MZLv0ibu9GIMb06gk7wl8CBcQ9JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795093086;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lM88TxdmzrvxGgSKsPTafF1Ixpi7japL3r8pF6i6ejo=;
	b=0eMqnWq15gbcq3YozP+D+9PEViPPecEYDBCyfTeiJGZG2c0G02xFrwZF7KH1B58/4ip7
	 irah3rNJ/TQ1D1UyEBnmN3mbgE4+9Z4TEl2mG/pcvBQRdrDTgA2v8lux+wPL45RA/fCGU
	 Zn0OxP7947ZJB7f+eKtySMC2lOG49wYFDLwdLD4p4oOSyB+xh3P/ST4BBrBxm1ohU4f68
	 qq5lQtdOW+P06NhI8Jxr2RCLcSgZT2Vp0PveVceit4ugzWYmgsV3+Af3BVLxpwqnH4aR4
	 eWVEqvHMkhVn7yvPxgu9nJek1nYeVAQl7zYe3iFc/W1ZcCzav9QQJK6SY+s2HemY3MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eG6byf3h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD1E606A33C
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 12:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eG6byf3h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDF21F000C4;
	Thu, 19 Nov 2026 12:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795093085;
	bh=lM88TxdmzrvxGgSKsPTafF1Ixpi7japL3r8pF6i6ejo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eG6byf3hjyF0NL4jIFG8Xf8nSzofjGy2JU9ZAQy4nUPsrIBVsC9Na1wLyAWoiNb0C
	 E0SEdKcX4HcinIIrkFcmeTqgGemWyUJDZi4jfNOPClli+zJhh7yLRCsMSl/W8qW/ZB
	 DivSVK2rkPnj2GW0yT8IvUoRtqubDZGtsszKnyjvscGSsqmCRHVljzXIXRRBx0qcDG
	 4nbn2p0AK0Puen7uY9gNlhJpcYc4e88RbH1Q3c4HIRXRw8b0wonDnQF0UeRyDoiHKi
	 hp6DPpiq9eze17w79ZEF1kNUQukmF9K9wGM2oxY1vbSniKDyGuGh5UU7SqpuZbZEDh
	 bziAKNbJj30BQ==
Message-ID: <sashiko-outbox-223127@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] KVM: s390: selftests: Add vsie validity
 interception tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Gala" <ggala@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119124936.33396-3-ggala@linux.ibm.com>
References: <20261119124936.33396-1-ggala@linux.ibm.com>
 <20261119124936.33396-3-ggala@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 12:58:04 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add tests for validity interceptions raised during vsie shadow SCB
> setup. An interception raised before any guest 3 state has been copied
> into the shadow SCB must report only the interception data (icptcode,
> ipa, ipb) to guest 2. It must not write back guest 3 state, in
> particular cpuflags, ihcpu and icptstatus.
>=20
> Check the early validity interception with a new and a cached vsie
> page, for the RRF, SLSV, GED+GED2 and ESA mode cases. The cached case
> leaves stale state in the shadow SCB (for example a non-zero
> icptstatus), so that a bogus write back to guest 2 is detected.
>=20
> Also check that a valid guest 3 still has its state written back, and
> that validity interceptions raised later (shadow_crycb(), pin_blocks(),
> unmapped prefix) still report the reason code and leave the SCB
> unchanged.
>=20
> The early validity cases fail without the preceding vsie fix. Skip the
> test if SIEF2 is not available, and skip the GED+GED2 and CRYCB cases
> if facility 78 or 76 is missing.
>=20
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119124936.3339=
6-1-ggala@linux.ibm.com?part=3D2

