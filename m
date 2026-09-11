Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF82D44E66B
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156311; cv=none; b=s62jkF5o9vb7zkKNj1kHv8vQswk8JYXRXDSE6yd7x20OpMTeJZRK276pjvoPlH2nLuQQuWXMQ/E6nStW1ICB1ljZy+7SofkDNsFxhYA+Odw1JzZ3qkb1hnn/iRlKP/uMo3U57h28mFTBw5mA5qp/MDHl5DAUlWhPRqzDfSp0WxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156311; c=relaxed/simple;
	bh=KazcmoqQWbgXeTgVVhmBacpcFjWZh9zPGAoagEUMbBI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SRtrz0ZhtAf97lDwVTKqWoAyIk27ceetLLMhucfvK67sXwgNbL3FhDFwg20ZmZwbnO9rSBl7P5NQ565Ybs8er26JVPTmM2lSrhcG2ve/uO2B8ZpTqbLCU+GRYEyz70tsdHKVCVaKugjUzSbQFCGDmlUeAtQwyqxByu3/HFNuD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkxtVDGZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkxtVDGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D251F00899;
	Fri, 11 Sep 2026 19:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789156292;
	bh=KazcmoqQWbgXeTgVVhmBacpcFjWZh9zPGAoagEUMbBI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HkxtVDGZyRamRSpUX36pRR/gedXZab89tjF3WoPl3nH02IgfB0Dd9jWzb3APpJLqS
	 R1cdU3i+yHhkODRAd8qqU9koZQ8VMbjtvYqvAberajY61QJfr3r7BYuS5YjAqguHjh
	 62JU0d69h6VkCpyp14cfOuPRUHmTiKY7fikfXxv8pqQ7OsZDJL1f7t6C3YMLcZAkc8
	 gnZNVXJ0gLaDR6rreOdcauufcxeCsfWJILPkFe038F/tOhXmDUZ3/Pe/4l524RhYYq
	 SIS+k24NRiq2issT37AbqtazxX5xUKI1zUx7M9gdCerQ5nA/gM77ULSdOJXh2vvqfE
	 czlZ4bvrzc+nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 sparc64
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260911-rcu-pagetable-freeing-v3-6-7b8c86103821@kernel.org>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
 <20260911-rcu-pagetable-freeing-v3-6-7b8c86103821@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:51:31 +0000
Message-Id: <20260911195131.B1D251F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit 4a0100f7546f ("sparc64: use RCU page table freeing") enabled
> CONFIG_MMU_GATHER_RCU_TABLE_FREE for SMP sparc64 architectures, expressly
> for GUP-fast page table walkers.
>=20
> Naturally, UP systems do not have to worry about concurrent GUP fast
> operations.
>=20
> However, CONFIG_PREEMPT_RCU is also available even on a UP system, so a
> future pure-RCU page table walker requires MMU_GATHER_RCU_TABLE_FREE to be
> enabled on UP, even if concurrent GUP fast is not possible there.
>=20
> To enable future pure-RCU page table walkers, enable
> MMU_GATHER_RCU_TABLE_FREE unconditionally.
>=20
> With this change, it is no longer necessary to have !CONFIG_SMP
> pgtable_free_tlb(), so also remove this now dead code.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-rcu-pageta=
ble-freeing-v3-0-7b8c86103821@kernel.org?part=3D6

