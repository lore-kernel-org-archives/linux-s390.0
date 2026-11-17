Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924422;
	b=hyeFYbatoqTq1e6nRKMPdj4AayPTsHFGqIyCsRt7FPsNwwNPMDp+vMSQRAyHzLp87jOz
	 x0J4MHfxesEjKN8QUZqQYAndRofaiss3ah15TzPwAquywqD+7gOiw6q5Lgime32Wt2M+H
	 39eOSsFJFT+ZtXtnGWIin90coqcDVNMY/ysi5UHJqIo3jPHsl1wkHuD4hN3cQlmvC197i
	 1xrzjjvoCjQjtkKmaurdyvNITdB86+9/55WLUTXh3Rzp5yb9SgVCEW3GRk8E4UzH8JkF8
	 dKBt9fRt/cUvRD5zYGguPFIARa/LIS4wr1Pn+h57ArkDAjVIfpLdapbR4H29EwZXs8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924422;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S8MjHIY0gcsrAlvihG2XRZtIFFhpbhL/7JmvMZUzC6s=;
	b=Por/i/sbn9JkHI9VgvwB36N8rIMvkuph+26jX7oMwqDj02WrwGTkUCFiE3hRr4NYaDbh
	 k/gmK5FF5DvhT7PgJX/QfRlO2/Pv97dJ2VnC2gCPPF+SLflsmlIiPtzOZsNWtF5fGvV4M
	 1hunE1XXjILnsCBEMMOKksRmN4tDfmNspHQFs31yIMkgPwJyCG1opFzBms4dgk3eqkwxo
	 lZvRzJ1fE80UabGYGHcUDR3UdNQAFEVpNZFtP3C02ZlWGjDfR0f/rOagpwPNImrEFzgtP
	 w8bwPK1AxsTmRSQW7dTr2/+nMjVcyZGSRP+Y2DSCLsaq9iAak3FtrHUNpdWaC5vOu8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnPYrTex;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C79606A329
	for <linux-s390@vger.kernel.org>; Tue, 17 Nov 2026 14:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hnPYrTex
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D601F000C6;
	Tue, 17 Nov 2026 14:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924422;
	bh=S8MjHIY0gcsrAlvihG2XRZtIFFhpbhL/7JmvMZUzC6s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hnPYrTex2RmGpTs/T/Z1OXL/Pcs6LLM5JvXsGpoQd8aDJKn0/vhn8cabgIDFim8We
	 k0/G4dnZHHHpIO9adrCKj9UH/nWXO/iTe6yUwlEPJm3oNQERvk43s9mqHsFSvVCXyP
	 23HsLFlCgJss8qg2getBMreL3GNnFho/X/GIXA8BhanQRYwDuEWCscTxvcNz1DlosL
	 xk0/BqQC2C/iX60bLn/WuRvIMNTyX+80RsIZW5J6KnWGkw7I+i/6etZ6rUz9Qugn3l
	 yJtQ5XDjNtn85JX2a8O+5HbDvf3natYH1t5cWDVIpMN/23y3QJfQESsbsFF1HX296G
	 GZdw5Y+vQ7ERQ==
Message-ID: <sashiko-outbox-218922@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/kdump: write protect the crash kernel memory by
 its virtual address
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261117-fixes-s390-v1-1-2d9d04ca0072@kernel.org>
References: <20261117-fixes-s390-v1-1-2d9d04ca0072@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:07:01 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> crash_protect_pages() passes crashk_res.start to set_memory_ro() and
> set_memory_rw(). That is a physical address. Since the identity mapping
> may start above zero, it is not the address of the crash kernel memory
> in the kernel page tables.
>=20
> With CONFIG_RANDOMIZE_IDENTITY_BASE the page table walk finds no mapping
> at that address and fails. The error is ignored, and the crash kernel
> memory stays writable after "kexec -p" loads it.
>=20
> Use the identity mapping address of the crash kernel memory.
>=20
> Fixes: c98d2ecae08f ("s390/mm: Uncouple physical vs virtual address space=
s")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-fixes-s390=
-v1-1-2d9d04ca0072@kernel.org?part=3D1

