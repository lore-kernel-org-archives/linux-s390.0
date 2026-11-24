Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795528405;
	b=pmxbMBG7N84AQhx4jCjgKRS9MRT/pyY/Iy2ROD2we9kHC0ycLCleS4jcV6ZCYHqgw9hu
	 b3Ka1qGaMom2P2G175BrZrHvlGYgVu91gY58wKEJcxm/Aqga4NuiV+p5PrmFGFVDZSajI
	 Mf5kFcZf3roUhvRypOY+kWb8XMdxFA5WExR6d7gRvVi6IHFAaWTjDWRmeX/KacNnFTu8r
	 5LLjtMnHShP1BrxoC69/G5sU5azrFsGuE8s02uAbMNG0grezcDfADF7SwO3DYx/Xne+Uy
	 1XVIalZQgtMD1uh4wNkikwHuOc3dT+F3KwzMWQN4TXI296u2n72vHfy1G1WvqAZIK9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795528405;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T2Ff+8zpOQdFdGBJfQN5OYn+ISfT0D3ELniFyTUgQrw=;
	b=1qovBFyHbmFTrO16SDHhvmMw/YsxQUI8enRtfWRiAj66e9D08FWgSPaZvhqmqQ6BHHAX
	 313XJDOcC2UZvHSXKSbswsmTuVlXUL/dMOZxDiBMwHgiBTIHCtW1+fUZuXimG8w+XJ8A6
	 /5cHxVyqVn9SnBD5Q0U/htDnH/WmFZQsHg2DPfu5OI3rAisJ706QvTnUbZT+DjhR9aiy4
	 XHrOEcoVsF0kWeQjBqZf+h6BlC4vF8jvB67txIy5PIVePkcZlHsNgWyZ8FiFoMPaJ3Zo6
	 DrGqiXneEP4jNjq/hrjfCdGnQ/6Ml3CJaXXV/hYHpz0tDHD0lxezQkXNbx8+V8HQ9tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QWCsqsOI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5A2606A31E
	for <linux-s390@vger.kernel.org>; Tue, 24 Nov 2026 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QWCsqsOI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C4201F000C4;
	Tue, 24 Nov 2026 13:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795528404;
	bh=T2Ff+8zpOQdFdGBJfQN5OYn+ISfT0D3ELniFyTUgQrw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QWCsqsOIaZhUp9u0nVmWnel95pD7D4PCrDVVKlG4+2zvCtCVvDPleomHWZ6q8uObd
	 z4WkdlAcJVrzoVeAg0bANzvAppEWAQ07fuv7e4w0nBNSew7i7WwDCFUPHyeVVwdPmQ
	 BHkkqoUEVI2OmPZE42sj4TxbbXnHnApA47jdYbnI3JqpN0OSCQ/ACVqu+I38g2s/qC
	 dPrL9qB+SoR2KVXbeYz7PCv015AKZ6QMAWcdnccNSfnKttOL4nXF6h+iNmVI9FZjbk
	 sAmwSMrK+STdaYgc2u4pCW7KW8Fhxbi0L9QDR1vYReqbnsvKCByjUO5k4q1LPTNabd
	 tDau9fRH9fuFg==
Message-ID: <sashiko-outbox-231266@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 00/11] vdso: Reject absolute relocations during build
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhvbWFzIFdlacOfc2NodWg=?= <thomas.weissschuh@linutronix.de>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
References: <20261123-vdso-absolute-reloc-v6-0-161e218dd217@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 13:53:23 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Sashiko has finished reviewing this 11-patch series:

- Patches 2, 6, 8, and 10: no issues found.
- Patch 1 ("vdso: Add the vdsocheck tool"): 6 potential issues (4
  Medium, 2 Low)
- Patch 3 ("ARM: vdso: Enable the vdsocheck tool"): 1 potential issue (1
  High)
- Patch 4 ("arm64: vdso: Enable the vdsocheck tool"): 4 potential issues
  (1 Medium, 3 Low)
- Patch 5 ("powerpc/vdso: Enable the vdsocheck tool"): 2 potential
  issues (2 High)
- Patch 7 ("LoongArch: vDSO: Enable the vdsocheck tool"): 2 potential
  issues (2 Medium)
- Patch 9 ("MIPS: vdso: Enable the vdsocheck tool"): 1 potential issue
  (1 Low)
- Patch 11 ("vDSO: Automatically enable VDSO_CHECK"): 1 potential issue
  (1 Medium)

Detailed reviews have been sent as separate replies to patches 1, 3-5,
7, 9, and 11.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-vdso-absol=
ute-reloc-v6-0-161e218dd217@linutronix.de
