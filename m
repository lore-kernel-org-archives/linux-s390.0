Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302657;
	b=uTTckI7fvVOKtNFEgG3HGRNrl3T7MVrnciidyQ3fgv2Ku8uI5k9CiT822yNroBBByK5A
	 e5+di0bp+NzQ3cmQqe38dnOY6VYnn9E5FtgobfoIsyYi30z9AYjx/Gv7sF2DmlZqTtEJg
	 dL+R8QMEP2EL+xTmGuzBTPzRQ/FhJH6d3/7TTil88MCaove+mitEWLCU+usfzQfwccmGF
	 l65UIKs5vnJPmznmTQKzOAcerBBDu6sfzTpyNntrxKSkTMiiCnFx8zyplZu6FR2KDE+DY
	 o1IEKuNFxaDw/zM5FpuaJYCnNsrmEP13Cn7n/f3z6k03F+ShLaGok2wwu2OBW5AIWjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302657;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=k6XK2eDGoGIrC3yRDf3WBOf9vzXRFuGgszS+NQS9KTQ=;
	b=NGA0S7tKvL0FaLyl2ETieN/5WFQNcUV0/2lCeBzQXlQvjgNzDi0ydbDbrczl3wh98zpT
	 6l+evbLaBwKVk/R7/56CqDM7VqKtlu15eyBA8XynDyjRS4qBNvDjFQEPMc0ND3Mpz7qqi
	 mrKSvuj+hA9XySp+0qWSzfroA8occnDlu/oQgOiDG79JLeV3NynRHHIRrWdvHhhfFnhQI
	 /bpFeBq9/djmCt5YXWt4cZe1H706EP6RShOOb3IkWFfhNAXSBGnVKRYTPio7zqyO8mCfh
	 2sodCqablKo9Ocs8QJeyKNwEpVSSmAp9sgMpA4zPb/VuQ4rP1rrCKS85Eb83gxxemsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+bEOiMx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AA9606A939;
	Tue, 10 Nov 2026 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U+bEOiMx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CD961F0089F;
	Tue, 10 Nov 2026 09:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302656;
	bh=k6XK2eDGoGIrC3yRDf3WBOf9vzXRFuGgszS+NQS9KTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U+bEOiMxMu0+ijXpMgrp1X/M1ft0jqZ4G2YztKx0gbM4ID+9tmrQf1MfzQ+iyUuIa
	 GQ5/bNBEMxrRfq0524VUO7NRneNyuc1OTBRYjdMnG4uDnUYC0gj8f7vl0yEEg7no7c
	 g3a02Xtlb1WxKmgmyM2fxhgnF5ijn0vYNY9xvjVSX7WzpNfz1KgGHvDJwZJ7b/ido3
	 2fxqBvNiLLw+JZ7Ru7cVSZwH/2DdOOfEaP3NmYRfmTWloJD+7kl5Yd8FUAy6Ni7B6F
	 kB+ttqsqaQ+V6X30kWE2o84KCG4YsR9gxmmO0sjkpQFnqJREDHcp7LlBNUbYqa1qHG
	 F9GJ90bVTyk+g==
Message-ID: <sashiko-outbox-206728@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 14/41] debugfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-14-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-14-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:24:15 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize debugfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. debugfs never holds executables or
> device nodes.
>=20
> SB_I_NOEXEC also refuses PROT_EXEC mappings. The debugfs files that
> can be mapped, kcov, relay channels and powernv's memtrace, map data.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D14

