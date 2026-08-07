Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197883DD86A
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 10:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098869; cv=none; b=MlJJVB88dp3KjkomJBe5YchjA7vbvMOlka42FxwN8+mEfFqIzyJt2Jl/GbCtCt5+Ijnjma1gciakjxd2/di9uXmgbnc4OS/XHPMirv7jJWdvR03UusdLvEbyoDSVsAtvZzX+PCvNjP4Us3sT3n8D3VpK6C0mghtdGvOO0TsVlV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098869; c=relaxed/simple;
	bh=ldKzpflJkroyTjsFJuxyfX1e0fmtyH23lrbJzdqiAFU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dcDEhzKNZnfM9u1J20GPFr69i8mWdHudSALUTau4N5BaN8F72AQw3Rto0r9hTwAQRVggtqttZeJghRf/StJebosXiuMOU+Th0IWph90+YeX4QUvzv9Cpuues8fpNXc/rfVBr4S64G+YzIW5PG0hmTPKfYhUDvCquDYN41ZK4eXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSfEeuK9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSfEeuK9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782231F000E9;
	Fri,  7 Aug 2026 10:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786098867;
	bh=ldKzpflJkroyTjsFJuxyfX1e0fmtyH23lrbJzdqiAFU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JSfEeuK9y5aawSVhb7aQkCqlcRmuaxAApDwUdZ+14kNpqLswBizQ5i+zAk1DTVKqY
	 MCniIvxLb4xNeqdBISxMla98squ1iCg+IiiM22sBIxJrQwPvtcXv9uQKjgpBFctIqY
	 8Z3P+xjNhuuZZaJFKWHDPyAK71po0hM1y48JlCHW7n8AMQQMSfXt8tC6uLih53X9AN
	 1h8vNo/IKwri3bw39Df2lrMzNnbHK3CDUzbpWx44TqmrfnVZlQAx/8SxivguWdddra
	 SvvYi/Pd+Weps5TgMQiTnhEwTVpeEvcpiKkwK4xLGq94PfbXBnVqA9v69kPfXE3zc1
	 XwKHe2Uxp5B2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/1] s390/zcrypt: Improve zcrypt reply message
 verification checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260807101918.31482-2-freude@linux.ibm.com>
References: <20260807101918.31482-1-freude@linux.ibm.com>
 <20260807101918.31482-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 10:34:27 +0000
Message-Id: <20260807103427.782231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add or improve checks related to buffer sizes and reply sizes to the
> handling of replies from the crypto cards for CCA, EP11 (AP message
> type 6) and ICA (AP type 50) messages. The verification code related
> to reply field length was not designed well and thus firmware
> deficiencies could lead to unexpected behavior in the zcrypt device
> driver. Thus improve the code to more closely inspect especially
> length fields at message replies.
>=20
> Rework zcrypt_msgtype6_receive(), zcrypt_msgtype6_receive_ep11() and
> zcrypt_msgtype50_receive() to validate reply lengths more carefully
> before copying data back into the request buffer. Use size_t for
> length calculations, reject inconsistent reply sizes, and add
> defensive handling for short invalid replies. For XCRB replies,
> validate both reply segments and derive the effective message length
> from the covered range instead of trusting only the second segment.
>=20
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807101918.3148=
2-2-freude@linux.ibm.com?part=3D1

