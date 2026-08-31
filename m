Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF439CCEA;
	Mon, 31 Aug 2026 18:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201294; cv=none; b=gGeTpa2Au9PWP4RhuxRFAbPLN6PnfucWXhVvCZatDYz734xUesIFYzHA4XbXrAPuWzNXZIW85OPrHfPC9+BMFx5xMqNxt+kdzvIFOITWgOi3RPn6mNSOzEguc01R92whcT93AKKaE6rp4Z784MyR6vO/CRXDrVwd9f63HIPZ14g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201294; c=relaxed/simple;
	bh=OTTwvW/5JrCuVtrjFZCSRAbNbF3g7Cpur2CCZzPMSA4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=j3bPBk3t8HihuUC3B7UFWUZv2gFFoYwcZdsZ9AVKARUKjlikiAJPT+2huXqhTLF+6WMeBp3PJKM0uanMmh4+AVZRRqttmR6e/6QxJzVVRG9Jw5I5byF9e48BYiNMvCpENcsv3iK8ig1KxEXGHbKhh+jhE/0TnIPXdCFBiK2BQok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QL6BsrAb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QL6BsrAb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4CF1F000E9;
	Mon, 31 Aug 2026 18:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201292;
	bh=OTTwvW/5JrCuVtrjFZCSRAbNbF3g7Cpur2CCZzPMSA4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QL6BsrAbo4K7CYlqDQtE8xEr8I3D9EaYt9GbkVvoXkBBCWlr1DuszOU2t2vGJPH5s
	 4U+nKaBtMjre3du0JgLfEdG8C3zOU3WyKLNThpj0kfhHG9cCvh3q1+55ecH3a2mLrG
	 c4LnkhVcnAMieZW6jRqVmIde8ymCm23+JV10zlC15+jdHGCKoA0qegQE19UJDx5QQp
	 2rsMAy8UJYeRDJR1gtFhH0P/ABCC7XPKSizlrgH7y4E4kCMX8+DBYxujWn3ZMsVD7D
	 rCbprknXd23IeZvHgFLlW9zoI4Tc3kjeUWg4hM2SbS6MlQTSK731thXQUEvBud8K5T
	 46uMuXOpPXIPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/23] arm64: ptrace: Use constants for compat
 register numbers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831144802.834315-6-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-6-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:34:51 +0000
Message-Id: <20260831183452.2C4CF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Define an enum to determine the register number for the mapping from
> AArch32 and AArch64 registers. This allows for a more flexible use of
> the register mappings.
>=20
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D5

