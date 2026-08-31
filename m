Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBBA36F911;
	Mon, 31 Aug 2026 18:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201935; cv=none; b=dFgcGNrAMINAqCxweBItUGdD7P8SvvNIq4qt5Yls/cZ6wX7Vbs3ZfKooikP2aQRYk9HxTcFmkNscKpIBjCR5KFyf1BmOxEflFmtbSDY8jkRu67vY+BBdLzyBWkbBoT0neXNa2cTMu6UzYB2I8KyYrDqBtOpm/4oAkDIdpBSKpTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201935; c=relaxed/simple;
	bh=Z5QTGuu2uDb7xJ2LeGbEDi8Uv0ssPrDTLNd7xaugiX4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g6Hiqx2AMSTOk6kifWZIpvegb7mg9++OXssd9qUMD6r/rI+pHpfnLSebqMoCLqMkgyliRSlotILFUrxpTmhd7ZA91xxCJLvjF1Gef0IVFFbd2onPJyQYg5nKto1+1m1Afj1d9BboSbMv7ZFWtqz21pIDaoYxu4D5sgIJcH1TV2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JsgfVUEX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JsgfVUEX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412951F000E9;
	Mon, 31 Aug 2026 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201934;
	bh=Z5QTGuu2uDb7xJ2LeGbEDi8Uv0ssPrDTLNd7xaugiX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JsgfVUEXTztWUxXxg/xGZoHBnSAbfiz/wATvR1725FohdhYTyle7FYZSNBoWKwtaB
	 Fd/30Puo2OH1hT4O/qexeg6kHKetoUu3l6nO9QSaA/kBbxSAYxsQuE5Gfb/8tBxM0e
	 vqPpWI806fU9ZS/ArmiBfN1GqUkwReKBXOwa6CW9rZslztEm6jfIzD7RKuR34JI6SN
	 Rvl04NzR331xBsCYO+fF9ESsRQWg4blWVNRjpj353VZ9VDsWb174EK+UDnmUsQikA3
	 rTeNRz8O1n3EdOaGwgBOGHO/3Q/xin55wN1DTw2lShXiM2bt5YLlzFK8HGRgF2IQPB
	 du0BUeBct1jUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/23] KVM: arm64: Use accessor functions for core
 regs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260831144802.834315-9-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-9-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:45:33 +0000
Message-Id: <20260831184534.412951F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Instead of accessing the value directly use assessor function that
> abstract the actual location of the register values. Add a helper
> function to reset fpsimd registers. Enable other KVM implementations to
> reuse this code.
>=20
> No functional changes.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D8

