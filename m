Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638703;
	b=2QV68bCiz/M2gON+AQRAWXHZDXB7crArBHBbu8uZF2zTPoRYbvwmGyfpBrqNSpoTM16B
	 BkVPfT6YrbSR1BgdzS6vJgOkmTjqpg2GvF230GcZMQ6wHFEblZNcR9Yuq2TNrhywl1lEZ
	 34NhHMskSbVLmltgWOly1mC0HaUtYDinDFjb61wpwBjuwOsT4sgdZsP9xR0IAgaKN9qPa
	 uggq8NS1siOuYjiBYANsm0lZA4OUqa7eUcmUDyd/qWEsOxeiK0ly9VTm2weIEJlNy6DEY
	 ZioPWnADTl1mItCFtsGpB8H6CJ8BoWCeZqpSpPSkdurylsfBLPjW5lnCiHUfrs43lSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638703;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sYCKzb2aStV9UVXM08lXkidUwJG6tEEQZcgt/THACA8=;
	b=j7I7B/U7DO4trWFI18NCviGGZA27j13clx3oja33pYetLenSLQXCzZoOW6C1AH/qdHds
	 MaI0QahTdk7ChYxRHjD/PFBaV4xbDQlR+ZkpwzZRzHQo1WxvZCZCSVxUJXNWDqczeoFvf
	 3qsJXaSdrhTaHtykE/5TKLVyOf9aTkVRgroXMgTqGJEP2VmYeTxHJVMbYU7X7JHoXQKRC
	 an0C+XeEjfI2Qs1kguq9mtIuWm2eUEprrOwSFns75odevZdErQmqUwVrxbNhiH58FfNB3
	 9c05ejXfZY1z9CMIFLJKZGKvdOfkbl8+lmG5OSQrAg92qNKmeeuU+mDwgBx7t847gyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZrZpYiD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BAD607BD2B
	for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2026 16:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZrZpYiD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A891F00A1F;
	Mon,  2 Nov 2026 16:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793638702;
	bh=sYCKzb2aStV9UVXM08lXkidUwJG6tEEQZcgt/THACA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aZrZpYiD3cJkHRfNz3BrywVKFQ6bsieLvzmclW5tU+EtXEpMQ5U9zicmJGVg7FtO/
	 KKREmr3OvyhSqoLipPfNSY+7iOrCouGWm63pgjsln+b94fGkxScsdiIbbSXBsTDiNb
	 vHWzAVvsy8MGgYUqN+jWXYXlJd/KWZ9R0REPca4dlIWB+zVj3Fpq7ROmIgLzFCebxR
	 UZw9/hizzfGL1KXoSNdUtrI4YV+hvCT06PfeqzXYeSyZgWocllPZ16P5YNRE0aDNsC
	 QXfvZ1uQwvFioTFt6qislm3J6FIj4Mi3+Hr3UwnI888ek9pJyKnTmuP/6NhpFQGmR4
	 6JkZP7A5xBRYQ==
Message-ID: <sashiko-outbox-193788@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390: Add assembler-level include guard to
 insn-common-asm.h
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261102-insn-v1-1-df048a0be0d5@linux.ibm.com>
References: <20261102-insn-v1-1-df048a0be0d5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 16:58:21 +0000
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
> Add a .ifndef guard with an L-prefixed (local, non-emitted) symbol so
> the file can be include multiple times per assembly unit.
>=20
> Fixes: 495bc70aa3225 ("s390/fpu: Move GR_NUM / VX_NUM macros to separate =
header file")
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102-insn-v1-1-=
df048a0be0d5@linux.ibm.com?part=3D1

