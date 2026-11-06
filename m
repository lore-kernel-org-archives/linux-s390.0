Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984812;
	b=3mrNvpZr5XWk7DJ/gX5FdnlMoyhIuAzh4tldIxRxc0DCn/4yLx5S/toXy//dC7svm1hU
	 nebJRONBweO+OlSF+NNIzezt9stuamKtgihAzUOC6cOo4xLBHpu2NAkGffaIwoPMmIvkU
	 uQQ/YHRTmWp94SPux9k2mnL2chdLKu5+RWDCUzr2dYbA4kbuMmBbdPqYG+O17GOt4nIfB
	 Lq82x/bbtDw0SdRrILjRge/TQaHbr9sFGI5Jog/pe11oQl7OKnKPvMM6JgkI5llraR6US
	 eiYEJKFWDRQZdbqeuxCDUAysmC3e4cdwoo+IssyDVDDWY+jzeHN3Gq4Yu8uduNaWNpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984812;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HXGN2+N7Jy2SyCrxCcXnp/hrGpIFZhqz3qAGD3Dun+Q=;
	b=258IdihAJs0naSndvZMjZ1zojjVjvoRTO5LH0FYwH/Y1OZPgldLmVE4cQswDfBDlmjU+
	 AMtEFwUiEb7FGB4GPug8JsTgY+x9iG/zxRjP0OvZmw6xz41amp+r4Gg3LULKLxX4Vv1Sv
	 x7+mM+S9+oVGDxYdji5FBDxdaQyodx7StSeKK8D0PjBr3dNzGNatkM6hsc5ecq9Gu7LJE
	 hIPsO9zPyLl/Uwb8l9PoCpZmEkxPHlNZHDN7CeUV/nOi3YisxK0nmDogZMg1aOwmoZiNQ
	 sQF3C93zKVuU80q6XY/gevF2R0BCmZZcFQu01nkGSwDf51oQz2R4tRWMvPpilMJvuwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A7hWf7+8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9674F606A329
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 17:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A7hWf7+8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2641F0089F;
	Fri,  6 Nov 2026 17:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984812;
	bh=HXGN2+N7Jy2SyCrxCcXnp/hrGpIFZhqz3qAGD3Dun+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A7hWf7+8K6DCcZv4Ua3Q0g05AEfsMyCiucZtVhkVfgjos5UnMzchE/bD8p5avruSf
	 jh3LGJD4xdk792FEg/dc+/+/fFESFGH9RpLGJ6pua9lPxFyqloctEl9zkPjSfcb//v
	 zg0qwUQ9C5ffymeZzdUqjMeHup3qmxOOpBeZCHcjEzNuc8LR5OnvL9RmbzvWxl88j/
	 sERIOrju9y5aYoFYuWPPXX1RbDcZRNDLRqvtiupsrKmhTz+ypYizcsOl+T4CfBUzJj
	 Wl2MBne2q1S7brvV8nhIURebVcaP+6ruqbJfxotVG4ZPdWGQB/aCWzSWcGtBiCELQ7
	 aBxCEeSgEba8g==
Message-ID: <sashiko-outbox-201896@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/23] KVM: arm64: Prepare sys_regs.c for sharing
 with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-7-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-7-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:06:51 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Prepare sharing of sys_regs.c with s390 by moving
> reset_{vm,vcpu}_ftr_id_regs just before the UAPI definitions. Also, move
> kvm_handle_cp14_load_store to other cp functions. This small refactoring
> allows to have less shared sections.
>=20
> No functional changes.
>=20
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D7

