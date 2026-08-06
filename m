Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D968D3D1ABA
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 19:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043701; cv=none; b=k3CBtKdb8q5d+TvPpr5XtR28nZaVuozJyuLy5U0YC85Y0pbfaZxCy70x3qXtHXK/Bv+y7g9Lih+uL4dmgHqW4fHq+7fG0y0UjvoF3TAgqPrfDt18B0uZCoSNKtTpnUC0FvG0HbGu/y2ES2ayt/3JUnRk9HbZQbhINvGwy/E9anA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043701; c=relaxed/simple;
	bh=Tp+FSOVaEFZ4EqpJr8R9tcCqhdzs+N8+7K0rkYS2Z9M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bcTjDwn/SSbnVwklLflmN4ThCP4DaiKZLwbNfje3CBaaltSjiRg9BzzLCqPbNftzFJdbV3z/aRtsjnOx3sR8a1tDmza6hYOMrIhI/4mDTzo5St2gHlchX6HWrqAjnoXO2i6l/3GBxFc3xpQ2rUSyq/kjXecrkUC/7WRSPCoq4XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bw2mYfmX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw2mYfmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AEE1F00A3D;
	Thu,  6 Aug 2026 19:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786043689;
	bh=Tp+FSOVaEFZ4EqpJr8R9tcCqhdzs+N8+7K0rkYS2Z9M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bw2mYfmX4FwscYvfcT/hKP7fkhwNfPeNV54mallpj37lPbEAxMUMuukp4AuzedEEL
	 XwEUGrmbP12/sFScxd0fnyMTSHTRXFLwXREwe2tBXt7+dF2hH8eispIQKdb77TMR+i
	 PGkP1n4x8iGqBglVHRhRTvHQFP2C6q63xvSuJAI0R2eUd3qI7ML/qDMfuf05JgFRii
	 01sd4sb3qklZRSyAryyHw0fzKyQxc5X4X2MUwUCTmDhx23sDDwk+O+5tTI1JQefhcM
	 Naov18mohok7RDFTGlXBAC/JYQCwUoo3jnejqXgDut2XUb9xvkq+I+H6hgGf/Q6DZn
	 YpM6tM0t4IftQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] s390/irqflags: Add out-of-line definitions of
 arch_local_irq_*() for KMSAN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ilya Leoshkevich" <iii@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260806190500.3293578-1-iii@linux.ibm.com>
References: <20260806190500.3293578-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 19:14:48 +0000
Message-Id: <20260806191448.E2AEE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Inline KMSAN arch_local_irq_*() definitions run afoul of
> -Wstatic-in-inline. Move them out-of-line. Make sure decompressor and
> non-GPL modules see the out-of-line definitions.
>=20
> Cc: Boqun Feng <boqun@kernel.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202607131219.euJHPSJ5-lkp@i=
ntel.com/
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Fixes: 1b301f5f28ba ("s390/irqflags: do not instrument arch_local_irq_*()=
 with KMSAN")
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806190500.3293=
578-1-iii@linux.ibm.com?part=3D1

