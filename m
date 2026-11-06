Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997239;
	b=sw2yLbIlOAKxhkioUP2a2BF+lGet9yPQPNtIhOzxV2kMIelqyPVtyCRjwy4fN1GdeS05
	 NxKmLMY3rJNaVuVoqqrF4g6WAl2YP/9dIO8FO+WqvDCBdS1H3p/Vwm4xFLMOn12Jmp1Kk
	 7t4tp1PMkhH3qT1pJk1aVFLj4Li0nm6GcVrqW2Lup9t59q6xw/hyx1quEn9a8fnWe+KHm
	 I14W6n0R54MGB3HO+gMWz4+GndHxREgm9HnBTJd9TjRLS4hzR5c2d/KjLk6GDa6yNLKNb
	 LrtGaFPg1FdDBADBoYIrARe2yYI5E7iVBJCxCLKFDQiohaCKgLlQPM/PQpTuLj88MTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997239;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OO/vtY6tdty8SOM1+Rqijm+ljzdpOHAC9mECOE/pJ9M=;
	b=EVyi/uax512fezQdqSRkdkLUvc6iRjCPZ80aNYulWC912tVJdAE/rF1Nk8Y4JWdE3PJN
	 6Si7HQCWueWros8RpcrSj2FH7wAzqsdRwBUZ3+xoSILBrydAAyfZWywUpRlTUvrmXIWdX
	 xXq3asX8JjmWEec/QqVfEK3P5mbDbifh+FkY6HYH9ID6fBF6OMKb/3sPd+3OydHceunEz
	 Oja8noNhaXzIybT4HuiirTH8VpxFPKlDO4eV4t2buW+V1oS9AGA20nQAzglFhpXvLRuh3
	 mteokjLkw+2m15gE1AhcLdeks02Bw2z8cy/hiePkJpGGgshxflb9lkcvsqlP99N/8PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWYlBrff;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A04F606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 20:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZWYlBrff
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906A41F0089F;
	Fri,  6 Nov 2026 20:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793997238;
	bh=OO/vtY6tdty8SOM1+Rqijm+ljzdpOHAC9mECOE/pJ9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZWYlBrffq196YPz9OTaGV38nnZMs0vevEdsUTCcOXyTRYqLlVGIO/z3+3clZt1NEX
	 TXaR/ksjjzUN+rRhQa17N2rSN3dZ8+kbbKwhgQ88sR/4o1q3Q/NtwrDOB8xJqcY3pm
	 OfCDqQbOznjplqj9yQS6P+M4N1difPcgwrdbWm7FB07qtaJ/Npv01gHIVXCRJjSp3v
	 eX5om8bajU9ErnueLU+1J/y7xF/R0Ti/sWj0JIPfkPKTz/7UYK32Pf8IrMD3g6iluN
	 gnVIEQkDaaGEpR+pUfmsS0A3SbytBk7CUbv5izfcKZw/7Ql7Gkz+qkyfZmm4MUJ7mm
	 im7w3kJkM+cjw==
Message-ID: <sashiko-outbox-202230@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 22/23] KVM: s390: arm64: Promote PTRAUTH capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-22-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-22-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 20:33:58 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Promote the pointer authentication capability if supported by hardware
> and allow userspace to access those.
>=20
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D22

