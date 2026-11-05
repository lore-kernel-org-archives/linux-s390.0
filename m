Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886598;
	b=zXMa4iwjbi8xLo/RgruP8dDl7BioEdzJlm5uy4SCZzlkEBIHt3/vnfL8M15yPAe2TIKG
	 bbWKDWvZcNIdjfjZd1pPejpNMHyA/Px571zwTRMCbOQyI36tz2bXAIgXQT/2E3AkXqXfq
	 gJLaps5TmwcQnYv1pOilZ9oKZgGNeiEfQzf4bGc01YnivrdXI8rhxSyd37xzLPscdUToB
	 heTfAYvFD8e7bDszf/XuiTwjnqa5OUqFa6zbNetcwnw8g7ibLdCTSl0c2dM5OHIhIi0fC
	 dWFpraKbq6d1bYiup5u3CXzU+WFO8pry3gYwtHN8HmHpbfSP4Rahnaaukac8nY27rsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886598;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fNlLSeU0O34IM/bbDw1Cf+NR1s5cHwa22cdriuVirQA=;
	b=3gDXXRbwzHpL0+c6r1gm2JS547RkO6F9rFjEgf9JV//UR/v+qMF/JH2oOF6pDNpRyFNd
	 C3IxQMeMnA/io1zvwe8+TcSmndKFbmzdkjhiKqOqc0Wqg7jVeVy9NKHGeCQ9d85twVij4
	 h5zfOmodWyo6300Tht4zLhbDXxQO6tZJBhuKnCFLtC4s9FdqfDtPjokhaGkLMOXEDYNDV
	 ODGztgOAVd6fbSXpxLQZXS0dAc7KgpPrH6ILq4i7wLi7ykw8DQCLp/osnbh/yAkg8oOx0
	 G9YzCkD8MXZT+LHce1r+pe9GKqU/3fC0r2AtXk7tSbPt1+QJf61hYfcHeM3wxs8RPyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpSXVZgc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A23606A326
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpSXVZgc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63F21F000C1;
	Thu,  5 Nov 2026 13:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793886598;
	bh=fNlLSeU0O34IM/bbDw1Cf+NR1s5cHwa22cdriuVirQA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mpSXVZgc8B+Ksg71kLK5ynRQka8lcoAxm4vqDkbi1lX87lUlGcclJXq+/IEc+6Cje
	 OwdD480/sFg75Ro76RuP8sbjZZ+OUvo5X32zMPmJPt0defTguqxj6WfrwryA8UyKyy
	 Hz49NvFVrJxK57fa6Tlg+BV+zh71DHWPKhfWH5ngqQSoT0m0Uzr2HVmSdICtrFi27n
	 yNUe57sR7Is4FthcCxny5W8/QKP2rFYUdxYoYQng2vdtXQ5boOwWHyNCf6zZZxzEGs
	 U6dDFa3fEzjtAC8qcgPxWNwZATB1iUOqmKKDyxanTeUo50MBJq0K/7oSKgbtHzcIHy
	 N6XDORri9u9yg==
Message-ID: <sashiko-outbox-199177@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390: Guard emitting assembler macros for
 insn-common-asm.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105-insn-v2-1-ff27987aa212@linux.ibm.com>
References: <20261105-insn-v2-1-ff27987aa212@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 13:49:57 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The CPP include guard of insn-common-asm.h is ineffective when the file
> is read via a gas-level .include from inline asm. The assembler ignores
> all '#' lines, so every .include redefines GR_NUM/VX_NUM and fails with
> "Macro was already defined" if a translation unit emits more than one
> such include. This is not the case right now but may lead to future
> build issues.
>=20
> Add a header 'asm/insn-common-asm-emit.h' that can be used by C/H files
> which want to emit those macros. The header guards the GAS include to
> prevent multiple includes in one compilation unit.
>=20
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-insn-v2-1-=
ff27987aa212@linux.ibm.com?part=3D1

