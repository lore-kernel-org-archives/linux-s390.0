Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685213;
	b=zNk5ngvQRLexWIc6qQaxMo+dvPczLSEttZbm5tgCa43rqYQrHyHcaRifUQSylX2+/CB4
	 TaNiNVdTb70vVE2KheHQhCefX+qjfqBgihpi1fqkirDkHjljs80pDCx6xgzPrjE3UoKJX
	 ZzMORKsrcTO6HshKR5J2s55DEaSC/4XPgA/zgdJOpZPccFtQzU+VtzB3Mp0WBBIwLSnp1
	 ciS0Oq9HsQsHkxYIr1zvdAiQrnWrpgFfxMUJjoMrmg4N/z7jGfpEeFkG4vUnhjj9qfBA3
	 GqON+o/HyCCVl4BtXg+G/DbJ6EesvvgcloZ4JNqwWJ3Zx4ZzX16JaOxHhKHXsaNPtwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685213;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NGlekNHJU20gv6Kdcn84YRCPC+h2JRzrRUr1S22usmk=;
	b=OxISyKtW6D9N2Qni024BNUtNfX+ZurOYrqO8dhGQrGyqtQ8Pz9EPynOu0kTs/s0Nv4H2
	 ecHcZ6y9jQoTgbb9EJV88AmLY5SSLT0Xr3DW/qvMPSfr+BwLAWCi16yglrXyS8DOW3ncZ
	 48MK3vEOSIoJvcnC5oTrlv4rxXNzbKyMGD+VHrkAsIXpDn9eHsqKIk94vVYTPAbjL12W3
	 7U+o23eETj+Nhxrp5ZljvACJ2WxkYYmGZoIbj0mSQWp1ALL7sMBq8ikqPfUIat82KjX3y
	 mVwVvY2rljQEiPs5UK/BOIiZFCw7GwfDTljKvQ5gAc2C7S7NEddsG9Sz6/pSQf3zFNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jS46fG97;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96855606A31A
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jS46fG97
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D301F01825;
	Thu, 22 Oct 2026 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792685213;
	bh=NGlekNHJU20gv6Kdcn84YRCPC+h2JRzrRUr1S22usmk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jS46fG97lG22bLgsZim/Ml/SMOw7NTzNb58EcsxZp/RDNCVpWkiynwaYaZI+KDB6c
	 v3s47t32BU54Ci5q6CSOH/pzFpWdomYcGGMnHw/ioVLo/93dQbNxiNdTCVk3eRpzZJ
	 zHSzGHWfHPJVFTUX7LsPhr9y1QrskBHF4GP95/yd25WuAO0UA3+D2SpmOZwBgCHbuf
	 S9xT/Ox27QAUB6TenWlJPwmqyPvMIPKm3ds9PSmA0ffX4Oro4oWfSF1lmpi7lT244e
	 kuTqX/3gZIwXI7dzTE5zoA3E5ZrjxtI6/6Jg6f8Z2XLcTEOnAoaW7az/1a6UXGGZOf
	 e65PfkuO1gFpQ==
Message-ID: <sashiko-outbox-181755@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 03/10] KVM: s390: Move prefix marker from PGSTEs to
 PTEs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261022155531.204593-4-imbrenda@linux.ibm.com>
References: <20261022155531.204593-1-imbrenda@linux.ibm.com>
 <20261022155531.204593-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:06:51 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Move the prefix marker from PGSTEs to PTEs; this is a preparation for
> PGSTE-less guests.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022155531.2045=
93-1-imbrenda@linux.ibm.com?part=3D3

