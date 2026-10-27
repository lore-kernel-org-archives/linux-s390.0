Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111731;
	b=X0/MR24IT5nkmO4uEy4AWsLC1vlaO/sKPcmxDgiTackuPhUnZLiUa9iBOo37b64QcaNf
	 GZqtkLbDTFa5IQ57CTTBv1J/pWFH1JAzlo97WfosmP9wsv7I/zQbwrCJNk7v0XmT7NrEi
	 0VR6bw+ijWJ1px+knQK+qf3xZ5z9uKuroWs40O0i67H7ITEHX4zp80lCdT4EbzTePanaQ
	 9rMuZNbYzn1ba4s6Wy725TrSxZoUzlURvjzdzGGYSB0tftdx726OSwxRcVsXtblc5K+ez
	 EtGH7dHXhGbuu9Hzz2msEJ9De2omgxCUHSfDCxPLJh6NeqBEmGc/whRYTQjZxFaRksA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111731;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iNiRCuod2hMSUdNDgWZZt36vkG4cIxakuHD7FaSnRIM=;
	b=h8GGUhiJFrI6YrC2oLhqINuWF7I9kFapT7+trWZl/16R+jzdM7O1H1s6fOlI1JbML7Vd
	 u00h3QII/dAMCAj8WnOKGJnyavoQAUYBMET41ae53xl4vFBByaxfKR8Ajtr+xh9ZLAVVR
	 6CudR86y00LVPUMshioaGTP38lO9XvO6gJyTzthaM7I/DjpxCLn9v2WYit76tKpysd3Kq
	 DrkqGaTrAShrW9OuE1xCMjuhNy33Z+r1L+/zKqcoHuLpp4COM/TbIqDkqHyoGCF3SyRae
	 NKvxeSGs9F8LF9t1wmFQ3q/o2cP+c1u87yOx/ExzwlqUU0hKRJfbOA26+6AXTbo9siQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TnMcOrkM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272BB606A31A
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TnMcOrkM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B252C1F01825;
	Tue, 27 Oct 2026 14:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111731;
	bh=iNiRCuod2hMSUdNDgWZZt36vkG4cIxakuHD7FaSnRIM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TnMcOrkMxh1gXli82A9csjMWukI0P2e+zz/ulA2x0XbouivlaWuJVj02/AVrqSEuK
	 SLfkCU9UH7LPxh/yQMPWGbb7FHmv8lOazJKAoNDKuQssNZ/FyKISOgSQaOtEzuBp+I
	 bWHtFWjf//61w7fkY2M7gEI9LIA/6AbUhtYVD9jO4F/Zac3X/CC6GI3CHPcMtvtlTz
	 /b6LOUIoMTbPD7OZ93YrLw0sYwlDBIaj2nlwt3XacGKIVbJRIoYBNlsYEMwamACHw8
	 Ml7UX8F1EbPO2Z9CmOZnG/AYKi/JdxmGIurEplzrJGTWU8oJ8pQifkaHXpVrwPcXru
	 9Tr3DJLji4ogg==
Message-ID: <sashiko-outbox-186730@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] s390/nospec-branch: Serialize text patching
 with text_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-8-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-8-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:35:30 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Acquire text_mutex inside __nospec_revert() around the patching loop.
>=20
> Serialization is not required for __nospec_revert(), however this is
> part of larger series where at the end s390_kernel_write() requires
> that callers hold text_mutex.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027143030.3154=
657-1-hca@linux.ibm.com?part=3D7

