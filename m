Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810D187346
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 05:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216888; cv=none; b=NeBXbzmsWch+K1LyWn3c1TmqU2qBHAAr4twQpBwtAvDdPxpJhC92sfozp4/m0M+GVZD+Kdr6JJO+TGxNVt+f6A589+HSkXLRaViVij0if93aBIAlmMoBQKpK7vLGxWGq4Ke0EkcbyH3w5C0CpSl4Tm4sebs1nryja0/9yS34YLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216888; c=relaxed/simple;
	bh=JKjT4iPzq+RNqtvvJN75oTZJfsVQ/C0cLelbyuSaJHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EYnDTk3FgFhRxv5WSEaOzwgAUpRGbzzbw5VIIXShFOxWGBhHymuBREFioMODD0+UMfdd+aDrpLmHhiu08ETZKCoCJzq1kLYRcdVo+C0Ngt/vcNz89gxJ+5yZaNqW4d6qWeYGPRXvsKgzt1huN5hWUkrTsu7fznIfpznWNR2Fa70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8qKXUW6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8qKXUW6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1D611F000E9;
	Tue, 28 Jul 2026 05:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785216887;
	bh=JKjT4iPzq+RNqtvvJN75oTZJfsVQ/C0cLelbyuSaJHM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A8qKXUW6hh/p9+w3+VQm67JodSva1+3gWJ7HF0DD5O4vl/7LY9S7YcB78aj52xL/B
	 WLADzznMY/nDcdVQUCYqBsv9iWcjJKsZsqGQ6kzbaojgQReCfeFzgmpi5zAo3tKTtf
	 IaCp+1n9ai5wn4cAy1I0V4OjvfsSJ79L0xrr0L56yctVt5wFG25IYq+h0AJ5AHf9Wr
	 tLe4i9WtxXior17uiImDaamZMIiR6IFGkC+8veq1J4cHQFThlWBapJG+mj6k6Szd29
	 G1EkCk5e6vRd7NY/KBPBO4C3rjVNkysVNmjV5YjmoU1UTnUXbBc63mlRt7e3UQdQkm
	 9978t/s81hVMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/8] riscv/runtime-const: Replace open-coded
 placeholder with RUNTIME_MAGIC
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260728052540.4728-5-kprateek.nayak@amd.com>
References: <20260728052540.4728-1-kprateek.nayak@amd.com>
 <20260728052540.4728-5-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 05:34:46 +0000
Message-Id: <20260728053446.A1D611F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Define the placeholder used for lui + addi[w] patching sequence as
> RUNTIME_MAGIC and use that instead of open coding the constants in the
> inline assembly.
>=20
> No functional changes intended.
>=20
> Suggested-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728052540.4728=
-1-kprateek.nayak@amd.com?part=3D4

