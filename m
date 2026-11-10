Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302768;
	b=T2fZNv4NBjjwFLH45QtqHEDlSnH2b179rj0k9HsETlEWwyqJNr4B8LcJWc4yWsGcL4H9
	 UsRXh3ksRxeHMx12KeAwgpR8Ry1bggcEmIl/LI9HLfhL+qzc8gKU3GTTaAr6QlYW2v15g
	 O4nVfgekyVrl1T7CmMD+R5nrR9NMvM3l9J0qmj1LkgHbTVaiJlcgHTMi9s4sbJosxYXBx
	 oxUQ7jMTC8rLq5UvUXKutG2qWRy/hawxAF68tbluWoeKtof104wI/G5oJ5usGctz/wG40
	 KO3MXzBaSsd3YcweLFQ6Z2yFm5r8oNMI07gLbEZ1NfM32OnN8A1NvL6vswaA9Rvs/xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302768;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NlgyBiNzvX3/Ejigf4d0CtN/p+2FEsI7EL8LOloNgNY=;
	b=Zm1/F1ydYf5C43vEa6lsxwBL1BdgtFzHWl6x8dJanj07beju2wnY3cvvbfo/h8Yg3DTe
	 qLEbCVT+333dt3RlDUtlks1CGuLRxA0jQEWrGbBdpzFMn6FdJmfuz3Wqkd4nCNZqkj6as
	 0sqh6IihbocbG/d6gOtdPcVxKibMsLUFWR+Mil2YgsuYuZVDa7bu89KruFNinJTDO6Vgc
	 kIXd/9edUd9E3YbvmI09Rvz4UCjFkIzMFof4HfhGiamqke+OVLOHuTemtgKfjp0VCfzyH
	 dNptl37/PLHkzwjaCH8djdueAeC5zUjZeZYindGF+iUGfgcOOmGAfe+y8wJrts9TkOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KB94nAtC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE21606B16E;
	Tue, 10 Nov 2026 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KB94nAtC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B721D1F00936;
	Tue, 10 Nov 2026 09:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794302768;
	bh=NlgyBiNzvX3/Ejigf4d0CtN/p+2FEsI7EL8LOloNgNY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KB94nAtCT1AU884JQiJ0F9dhpY2buX6lxPcV0SsiWNvI7Je9tCBhwZ46VehCiXVnG
	 drXnEgCZ05LUhreI3fPIL/y/9Kr36owAocKJd3k7eIDQWQ4ATboJ7EFBxlhtHqBaR9
	 FCTYPAmo5zxwa+lHt46NMmeCb9B3Fvw34D6z/b1zfTfdF1tCiYyUdumyXPm6XuwmG2
	 tUpzhzf0zcGYGwIEEtIohGm9JHBQGH15txjkW6yDgK/m0Om6jFFwSEVYqp/suM68Az
	 NEeZltxKnUSCJTSgjf5iVf9IHl6seUl4QhsOWyhTFyl1CKRLqT4u6FUwOt89a8pXm2
	 I73aJwGvny8uw==
Message-ID: <sashiko-outbox-206744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 29/41] s390/hypfs: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261110-work-loop-pseudo-v1-29-4c998976c6c7@kernel.org>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
 <20261110-work-loop-pseudo-v1-29-4c998976c6c7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:26:07 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize hypfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. hypfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-work-loop-=
pseudo-v1-0-4c998976c6c7@kernel.org?part=3D29

