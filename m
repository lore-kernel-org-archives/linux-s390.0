Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013672;
	b=DLT8y611tjVShcUZcFpOP2oh3IcLu3D5KNIE1Ak7D+ctSIVve7ELQRzL13G3Qiny3hhr
	 4fOmvZTGa4YJHTs8kfeh9bMMh47XXtupJURxnqlJ0x2+tavWGBuMuwGhPslRdNBU/yvcM
	 ewamymeToImQX4+gFigSTUsK3Mb8HfLIYIrWgeII9eu1LGd60wyEOAQtRttgLwucp6WPw
	 l2oF5p0utdkOaBYdvqV3dfIaIa8mV+Xh8vKGMjsq9bA75HUnH+/XXQ5E+bzJMSrwfSKCV
	 5u7mYXpaRwl7HqQJvSZ6CkgCflWi5pa6b9+fVqwx1JL7lNOdR2yi9ECQnxJcQepCNeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013672;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SM4k2ocA8QwmynLejQ1V3beRMqrcS72kSVBm77PA7Yk=;
	b=hBt5GQw+WSIQgb4Fs1xTOkTtyqY+RjQeXdKtMMX/WNvg0q3E7+MKIljCX4G3NHMVsmBX
	 cLXbkosvEjfe7YtrV7v8CsIptDWQeLXz3Nn1ydH48qLV+15Mv8SvfjscFCVTm/e1QmEcG
	 WFd5vmXwYeaO34pNnaTq4nMf3sV2TqEZAIWHIvD7XlE5PWq3w1TI5UgLyjNjFkepPcdA2
	 3c+/dPs8keJcL2fGBqe+k2HTNyKejXjI6+4ZDhRkIFsfpFbjOvGh/6Vtt90a2XLbQYEFm
	 wua9wcZ4glkLhfNGMfFr3PXKYxNBukVsJnAaAQIWTaRMNEEGJX8ewvg60F4rojIQGRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzwHK1x0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332CA606A32A
	for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2026 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzwHK1x0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C5A1F000C4;
	Wed, 18 Nov 2026 14:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013671;
	bh=SM4k2ocA8QwmynLejQ1V3beRMqrcS72kSVBm77PA7Yk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gzwHK1x0ah7BoUSuLLYlh/0ui/F4kOdlvVIbzu88Lk+QX9ZTSXcyrrIJNz60+46Q4
	 UDYxDwYvnGb2Jyp6rUl+rCxfQZ/7k9ikrnuY/nymaVT54dDWB/oLxPVdMYmt4hM7NA
	 eLzQ2yL3xQegfP6JcshAns6cwniAvZcw+/v0OHi/2iX/Wfpbc3k/foSL8Tp/MfHReK
	 qm8EPf6bbh1SCgxbfpqXynv0DpqLR/uJ1g5jDH0h679QCeuA9SjLN0R4l0LWaquuIE
	 r2Hxpayd19ij1ySTlpNbgiRJhFNO4+QAbtsmx4qdywjQ5WAy4KxTs13LdcDIWAv7Eq
	 wJD1HIUn6toxw==
Message-ID: <sashiko-outbox-221264@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/8] s390/kprobes: Add error handling to
 alloc_insn_page()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261118144709.202520-3-hca@linux.ibm.com>
References: <20261118144709.202520-1-hca@linux.ibm.com>
 <20261118144709.202520-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:54:30 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> If set_memory_rox() fails, let alloc_insn_page return NULL, instead of
> a pointer to a not executable page.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118144709.2025=
20-1-hca@linux.ibm.com?part=3D2

