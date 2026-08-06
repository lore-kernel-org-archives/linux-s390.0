Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D3F30C637
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021372; cv=none; b=pMu8IfLo8kJmGDS+mKfLHiTcAAoefe1neMw5I39QO95eqpabPV6vjAcgukqH9YH8iFxf119KhLQ/iJcV+I49BBv+vQ0lm7AVKHni6IPcCfba6S39AhGKI+XVvEm9YMk3huRN1YSQc1E9vFa+COgHKhRC5PB8vrXE6FHJTocr5O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021372; c=relaxed/simple;
	bh=CZeowdpzxoJNmC1oEzdUaCfJagWyeGhTLBf1ExVVvZQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fG/QGV84KW5JTaDGUaYtKJxzHbw0VH6+63MJUJQxQ4wJIjCQ1Ie2IMsXjITGy1MM+PDUy1M5fd9dQIRDMCPzjhz8FBKJE4L/DY8fNXJBW4kouA5rEtU5pMY5bxLKt7+CLHlD8Kwm5ullOVxLBAtw87masPZAS3aorqYsE/k+MPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gTTxxgoA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gTTxxgoA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5631F000E9;
	Thu,  6 Aug 2026 13:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786021370;
	bh=CZeowdpzxoJNmC1oEzdUaCfJagWyeGhTLBf1ExVVvZQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gTTxxgoApqVG05TlzQjYkBFYFQCyT31I528U+iSbWps7WYNV77A/gmD5nuPL4+7hl
	 uw0fTJOBcg0783TB96S2+gf0LLMpnwA+EfTcJ1+XV4QXEbLy8cmj93apAAIFSLzvcm
	 qMt8PWWNtacbQuRphCU7DsaM3AM6qZ3SHa4cRmKJxelLS+0hcy5DtzbzVUU1ALMamU
	 c1tnCdEu2XAhXRn3FznzSwmLIV3rQog9xxR0vA7ou4db1gQ3dQVMevCM0k/uCs9Yyx
	 odW5myz3Jt0h9ahQu8oV5Ik2v2n7X91LlX6C4gG0Th+NUARzRxFkjS7r9masn0XFEj
	 5Pzixm5FpvoUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] s390/block: Enable CONTEXT_ANALYSIS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260806130050.2057443-3-hca@linux.ibm.com>
References: <20260806130050.2057443-1-hca@linux.ibm.com>
 <20260806130050.2057443-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 13:02:48 +0000
Message-Id: <20260806130250.7D5631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> All drivers in drivers/s390/block pass clang's compile time context
> analysis. Therefore enable CONTEXT_ANALYSIS.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806130050.2057=
443-1-hca@linux.ibm.com?part=3D2

