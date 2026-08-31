Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853C6440A34;
	Mon, 31 Aug 2026 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788201100; cv=none; b=fuLcmXvddGnbH0Tw2lKPr0Gxi/CR11HxqpV+hhtnXO+58TwF5kLVsO8HmwkfAsJU6XdyV4kk7oYG+b0dX1VWpS1rF0tQtZ0b1hulg9QtrF/upRYAYHpbZf02LeOcErrH3AYLHm36OM8xWIoyWwibQwaTgRj+0tih7LXiNpMS5ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788201100; c=relaxed/simple;
	bh=eD8eDtIiz9rQ0ERT/AV/3gjAc+UneoUbjTwiLdazZ20=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OOXmQ+8ZxCKwxM1uUsF/t8s8i54B3GnvroyAiyf2ta//F5zY0vsSvva3/bCeaWDfGlcS//QVqgaikQVCl8P5EYL634AtQ0cUGkCDp1rI1ZeIH7Dsn5TYqpKDxpidBYiIkAITdg0+Qw5NVG0NRK54IZxhjR0CBQ+gwU4gfe3k4qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OXfBZSTc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OXfBZSTc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AD561F000E9;
	Mon, 31 Aug 2026 18:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788201099;
	bh=eD8eDtIiz9rQ0ERT/AV/3gjAc+UneoUbjTwiLdazZ20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OXfBZSTc6S1Q/v5di7iHk/ioASZz7PkzoXE6yhUQB45uq2z/jihOIVZX03+Tjtlp/
	 hDCSL8Ic2Y7jvznf7DFJahu6j4u9uyOcO/clCGcMKnE+MsRdWdi5GkFdj/RCNqcrhO
	 kpYjhWoAyZ7ANCbQcYOB4kKnk3Wk9Y3BGjoAPaeeBoZefVVib4vLxKc3kMj9ZZgEXt
	 lcc1w6zIpXnjLqvIhTvj6aL141lodEkTUqE9LY72SkDFHbSYqTY26xL3qJD+ugcftv
	 juicYMpuDKq7ny1TynQ8MTFfKRuEVAiAyR3DZu+uB9fnKl2iwnh0zZQnFi2ljLuk0U
	 M2pY4L86EBV9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/23] KVM: Allow KVM implementations to switch off
 MMIO independent of Kconfig
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831144802.834315-4-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-4-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:31:38 +0000
Message-Id: <20260831183138.8AD561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Only defining KVM_MMIO is not flexible enough for multi-KVM systems
> where one KVM implements MMIO but others do not. Solve this by
> additionally testing for the non-existence of KVM_NO_MMIO before
> including MMIO code to KVM.
>=20
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D3

