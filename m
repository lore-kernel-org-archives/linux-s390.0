Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C43B36B921
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785857140; cv=none; b=Vz64RkDx9yY57Oze7IWp/D7arulwyCritonTt+cMzHBAnqwuTs1m9oLwLga+YDMhmNUyDYrKVFYgKfBcByDBxkOEqLL11cc2DKr79XhKq4Be3ewWabebL2c0l9/9rY4NKmyST8gCXxyLqa0E5UODd2i2bZv1MX0xfrf5Hojogb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785857140; c=relaxed/simple;
	bh=4cxew0LY1Jh1iVkP+NaGMgaWtVL9c23fQ5a08NMM/Ho=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C+eeE5s7wG5XBK0kBdJc2PllzrdbogozMK7x896zteRmCfbnUF+MQTlfWDH1koM3K5prwbJTCFcKnTiNu0hfXJPSJY10jpUfwBH+Ljf2cRf76UVb0ByqTAPikNULFq9JGZWhVvSTPj/CCzabWE1ZUu/2ymQRkttL/OJkVhhQKEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiQoAIBI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiQoAIBI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63031F000E9;
	Tue,  4 Aug 2026 15:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785857139;
	bh=4cxew0LY1Jh1iVkP+NaGMgaWtVL9c23fQ5a08NMM/Ho=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HiQoAIBIbU/CHLyqY+jUFfPTEhATPvWeaQNlHt9beKW2yReXYy6hmZYp79eG6wXMB
	 BavEIANIIlvFiI4vGm4Rl0RHQnBaL+VJJ7D2LFxHPpoSiUSGOM6f6ZdR2YqvhZDf9L
	 EYarawYJu1Wt7oITKK+S0k1J2+p805vCpE6nY1SF4owFYHNJLiswdQS6yis+EYnnwn
	 2w6kF07Nlk7ld8pXTXmlJvD2/2Yl6UbvUncon5iXrGJVotZbHwS6CdXCZv4iQd6qtg
	 pHPZi9dQsxMrkLtYX1JgZLkeFE+Dv3K61Ot7Jb+borzrxn4lgdzrVGRFgBZiDOBRDD
	 zuZgky2QoT7tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/1] s390/zcrypt: Improve zcrypt reply message
 verification checks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260804144926.241039-2-freude@linux.ibm.com>
References: <20260804144926.241039-1-freude@linux.ibm.com>
 <20260804144926.241039-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 15:25:38 +0000
Message-Id: <20260804152538.D63031F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804144926.2410=
39-2-freude@linux.ibm.com?part=3D1

