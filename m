Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982326;
	b=C2XXCcB5YbitZ5EtQATByOHU4t5lWUqwHmGx/9hLIhHR0DznYNXkmeUuNH5uClcPk5+p
	 zgBLNe4uRpqWSqPeawkp/VN+NDNr7w9wlGt4XGOcmWWchWHx99gX7tusZ7arbxcF7HfBY
	 yqF3IshRPwrZrWm8eWpcXFNPZqfJFpAWTn5x4f2NwxcvGR/qDaOZ/Q8ni0Gd6IErF0a1M
	 PQE0ns6pPIQ9ZiC/uAnCNRBDGpd0mQtvITlTcWdgTv3kjZRSy1zhI/5U5meLrh1WqlomT
	 Ps1cXQvygnfR997xccLggNtm/WQ1KzsSOC1bmd+q6JFUrv+yf+0ihErHZL2BhljqLvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982326;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3p5mlKl/PckiXDCg6/nBWjYORRFu029BUm/CGhRL04o=;
	b=jFXc4aBb0dEkjlx0dL8BE9vIcZxcWcPyPU28gagWY1W45U5FWI5nxRgGVM92lywELhjG
	 qjLqSAyW94RLq0lw2f0fA2l1NiZKIl6nV+tHkpB8EQZ36fD8Y5mGEDDMAukRpmoVhamhk
	 1wiTw6xpIlL5IIZIFrmj1bNss/OJdxGlceIUtVAOuowdu79+5AENXtn2udSPMnl4NzFQA
	 hKtATYhqkA9pGJaL7Ojc3k5dU+7KCFbMAW1WR7joNVfShFIYCtvlwMWyz3nTjYzHT7zx7
	 MC4eV8o1BEB25kZ4/WYwgUfdUgqLzFvMP3P1yruFlYlHgU9HZUEtVScAz31DuU8aPvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L2WpxG9u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1FD606A329
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L2WpxG9u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401B91F0089F;
	Fri,  6 Nov 2026 16:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982325;
	bh=3p5mlKl/PckiXDCg6/nBWjYORRFu029BUm/CGhRL04o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L2WpxG9u/2+2A3K5x+9mVBdtqX+0UCNzKT5F43/yzrrE+CyoMJrT5WzV29EKelXN7
	 yUJwybVEjDJEXrlMKdlhxehdjQT9YA6EmzD48l365T8zWhOpSg40ZoQ3iBWhofk/XS
	 +SOFCKn+98kyXINhq23Inc2uFfyURN4mfDNC7+gb+8+j6nTgfJmVLHDf6AqFu0o8xP
	 BkX0dTitFyGff/y1JH4dpaOki/EUXAhsTVb95OVoGpBaCL+c2zzJiloLCOxbWWySey
	 r1T+bJoBsVvi2Rwhq9yt6fjhm36Q6KDpVFjtoYRM84rJS3+qG0gd61WHvrA1A0dp6E
	 ge6zzemdJUxhQ==
Message-ID: <sashiko-outbox-201801@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/23] KVM: arm64: Extract number of sys_reg_desc
 into a constant
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-2-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-2-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 16:25:24 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Define the constant `num_sys_reg_descs` which stores the number of
> elements in the sys_reg_descs array. Replace all occurrences of
> ARRAY_SIZE(sys_reg_descs) with the new constant.
>=20
> This refactoring eases the integration of handling system registers for
> arm on s390. s390 needs code from the shared code to define the
> sys_reg_descs. But also the shared code needs the definition of the
> sys_reg_array and we cannot forward declare arrays and use their size
> before it is properly defined. This patch solves this chicken or egg
> problem. For the time being s390 cannot process the full arm64 defined
> sys_reg_descs array.
>=20
> No functional changes.
>=20
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D2

