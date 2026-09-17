Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72567399D0B
	for <linux-s390@vger.kernel.org>; Thu, 17 Sep 2026 19:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673560; cv=none; b=R4KPM3GUlCZ53ZZwYS9HHu3OgCMKFO72OMY3OnOzpe43hmjyKjmrz4NPudOr9wy//wYkB1JR5017pm4xXsTiwmbosg3vrvUGe0+2NGkVhqp6EkyN0lKWaCE5KyjeI7cLzRYsWAQ1/hPvLQucQBUeBBCBs9VyDDaqa41cqdQ26/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673560; c=relaxed/simple;
	bh=1zITJa7txeRATe4z7q4TmLMBnLawWA2+pSq9YFwGyJw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kwFzpH7lbOlu5PToTooSA3jsXdIiJ4rH26DXqpz3KOiYdlytxN/0X1d66+DbJkqMyBGR8xn4Zqn1hC4IyPPWYICbpnUyr3Nm3NU49WQICjSLDOX+0D0rCxRFvPzB1Ho5J6rAFJDnUkrx69A7bChbWsG64o9S/45eRGoLFS3bL+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOyNHCi+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOyNHCi+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A15671F000FF;
	Thu, 17 Sep 2026 19:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789673559;
	bh=1zITJa7txeRATe4z7q4TmLMBnLawWA2+pSq9YFwGyJw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MOyNHCi+GTvIfUfK9TM0ufuNIrWC30Vqsq7Bb7VEwmNnog1guajwafW8FYQy/jHjn
	 qTtSP5XQhffb/UH05qTj70ICQF/Ug/vIesIS4y5OyvVYacJ1MPCDqVOjrpINLbGLzl
	 KFxOiSPtG0DWLyi4ufCjBaUqh9gm8lv1R9k+7wc17gGzZkNPeHjUiQbJ418PSnDGnZ
	 yA59u6tjFUzki6aIrUCUdvcBDpKleSd34vi+p6KDHpL3qhxSTPqpR/ya2SdXBadAld
	 ivoH/SnoanahaYswVipbo44BoAB/yE7gNwJMzHtnbedM5V2P5+z4p27r3kAVrZ2+6/
	 JjRXWsMGtM5og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/12] s390: Add CC_HAS_ASM_M_FORMAT_FLAG config option
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260917192237.638324-12-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
 <20260917192237.638324-12-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 19:32:38 +0000
Message-Id: <20260917193238.A15671F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add CONFIG_CC_HAS_ASM_M_FORMAT_FLAG as an indicator if the compiler
> supports the 'M' operand modifier in inline assemblies. The 'M' modifier
> allows to access the odd register of a TImode operand. Clang support for
> this modifier was added recently to llvm-project [1].
>=20
> The config option can be used to write conditional code depending on
> compiler features.
>=20
> [1] 28c23411e15f ("[SystemZ] Support the 'M' code for the odd register in=
 inline-asm (#215481)")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917192237.6383=
24-1-hca@linux.ibm.com?part=3D11

