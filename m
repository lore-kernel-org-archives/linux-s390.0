Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626315;
	b=NTeJRKOi9iGruLvcs2qVg7ONE8sFD3GIxiKNHIkpNG0LEjNJQ8ZEVMfokvz5IScmwo5L
	 Bo/FLwh0ohbkDYy/U2eMo3ZUzo7nk8ZfmEEF0zejuSA6sXO1z+EgIBHvhzsZI5ZoYr06V
	 NK2nXw0QyGL8arz29Ia4FIGRDVZnR0p9AY/hID7KtTxbmc+JwrxuAEdurIIBGBnNG+23N
	 OZh6o6VZelnH50K7NIUJRuDiXQR4YvY9TzkaEKAmlCS4FZnNxIRZN3ZbM4KOPocLyYGS8
	 QWdsGPa6acu6HidNneqmwapB/tAjH6k14rmpurtoCQfiQQy7WOA5KdAGmyHzeXT4eNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626315;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=G/ckL3Tg118Bphe47TmHcjESXKHeojB/LURGubDUH30=;
	b=zIefaRett1Km7tCnyWu/VdyHpIK9K2sTCyiuObnkAPpYXKz4YI+f5gtef7kO2yON2/S5
	 O5N5uBZjD3A3Uz/jbD9/7syPTZ2YmCELL+Gj6W9ZnYUlCfXhgITkGGwTpbOPBzZW2/Czu
	 FL03iIWuyHjZsvrzf4RGvqyYA/aFEiCV3HOMg51BjAEopSrWkcyo+EVDX9PMSSFHUX/ui
	 nwiI73QBqTgME3EE4f1me6lJEqoCo3s5FOEB8HBHrtERbOx0HzVPqx8+j5CbSWAenR9xw
	 vHKCiEtZ6Vcan509TFU84lhXGn8SzTX2RaStSSeK4H50cRt3aEMCqVqBJq01xQP2tHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifAaUcYB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09E8606A323
	for <linux-s390@vger.kernel.org>; Wed, 25 Nov 2026 17:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifAaUcYB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 443BF1F000EE;
	Wed, 25 Nov 2026 17:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795626315;
	bh=G/ckL3Tg118Bphe47TmHcjESXKHeojB/LURGubDUH30=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ifAaUcYB5lLgr7Bk3PKdWUxsD4ALK/ow0FfALG6tDVwsI6XpaTxODvPMxEjycKc09
	 P32iw76On8Yd1gWto4MiFG+JIBWrilPPLAy24bm16BeNUyTJxeHyvgZp8OZUCZ02iB
	 JA/2xEXe5WAEThdLV6loFI1MRenDG/HlJjkdOBWWSHGSCYuQs//3WU+vdHQRkZuvYS
	 DSlNqlAzcWv/GZFSg6+YqQGVJTDjl4wT08kyCLbifhPA8GMdFy9Zn1BRM1ZPYsAHFD
	 x29FeqbMcgx5NfIcMy6oQd3CtAAtQaU6yMIHui5+PWq1szttFJ6qjI0Z3Uo3rsR72h
	 ZhdSw4f4vhFkQ==
Message-ID: <sashiko-outbox-233796@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 0/2] KVM: s390: vsie: fix instruction retry for
 nested guests in ESA mode
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yvan Janssens" <yvanj@cyber.gent>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261125165604.3074595-1-yvanj@cyber.gent>
References: <20261125165604.3074595-1-yvanj@cyber.gent>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 17:05:14 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Sashiko has reviewed this 2-patch series and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125165604.3074=
595-1-yvanj@cyber.gent
