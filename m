Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143785;
	b=pMUxNZk5P8upxMexUA68MhG4xyHQ8VtvRdTzSbeiXsBPJCN7+8bVPRF8KR6OPbltZr+G
	 vXVTKl0EcQUHgRC4Lroa8vQIiFKrthxhRuzMtav2lLBRzyLKZbuV8xNyQL+xIrO8OGK+q
	 cgPiS/Qdupwcywe8Xk4Nc+b50p3Qq7PKHKvfBTsGUiwHj8QJRKonuQObdp99IS4yHR5QF
	 LmiLHDXV8G6Nb1FDOfhiBWxzXy3aKq90kbdmO8bTMl4rCfe3I1+M5HFloodlYpCnpLj+8
	 sumB51MXeP0wqWqG3/P5inFhtPeOIAtF94SvZ1gmWKeV3x8uTyT0joY6vb7t5ygzPHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143785;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SL/OwjzPoNUil9HwoepHC0IwSfRTesmXZf+yORcg8YU=;
	b=dnGaOqdL5Fxu+ThqYlc9TIxKWzAAVTYeLEXKpG/bsBwELHOHJE5pttfsSmMHF8M7W0dT
	 rI9JiAXCUgW6MAyu3okXU+lRdkMKEPFoyVXkscBHa5wBzFk3FtmXmSDBFq2d/RR/QeTNQ
	 qBKKRALT7CTpuUl2oLwHF7bZVFKXRaN0C4YQbOaAjslisdUuFOB4elitYgeZ+Yx2+MeNE
	 cofSUtS3zelfJ0uV2qwk+Gw2zku/8CFd2SOWbtrxOAUCiJlasHfKnYgqTfs4pHSbVerRy
	 91rCTuBB7WhXWQhUg+r5psqNxeUWdum2FBp0BZ2qjDZ4e75AvL8iCFeworq6R4ApaTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RB/uxR/j";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CA5606A322;
	Sun,  8 Nov 2026 13:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RB/uxR/j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01161F008A1;
	Sun,  8 Nov 2026 13:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794143785;
	bh=SL/OwjzPoNUil9HwoepHC0IwSfRTesmXZf+yORcg8YU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RB/uxR/j2rcR160gfYXMwek7MArFaYxePTLmrGl5pqyYt/JI5Yo3H06d9pS3LOfMc
	 +mqnTf/qpWQ1LxOEHo4IDomdgdeiLzUKtkXtNajLOl/sx0Ud2A56lKbwdiBtZERfAS
	 iMXQYkK8Zvb2Wv1xvHLkmyjYejWiI+WsPNYydGyf2OnM5gCgNlDn/iulKPida9lAzW
	 ElqL9sho3dDv2wexpW8uSboGNcnLPV/TNqJBNVI4rL4d+kuLOre5Kr9yLfglE0tx07
	 7Zy9OXLQulpHWTdUl5wkTRAAXjO15F2wHdKS2sMfHv+rKegunveKjp5vjBCu+xS/Tz
	 4fkdwLU/CcROg==
Message-ID: <sashiko-outbox-203768@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/11] KEYS: Pin the backing kernel module for a key
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261107131512.3603168-10-jarkko@kernel.org>
References: <20261107131512.3603168-1-jarkko@kernel.org>
 <20261107131512.3603168-10-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:16:24 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add the owner field (populated with THIS_MODULE) to struct key_type.
>=20
> Pin the module in key_alloc() and keyring_restrict(), and release it in
> key_gc_unused_keys() and keyring_destroy(), which are wires to the keys
> and restrictions.
>=20
> Reject module owners still in MODULE_STATE_COMING so that the failed
> module_init() paths cannot leave behind referenced keys.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107131512.3603=
168-1-jarkko@kernel.org?part=3D9

