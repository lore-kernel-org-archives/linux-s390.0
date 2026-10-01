Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C164D442FAE
	for <linux-s390@vger.kernel.org>; Thu,  1 Oct 2026 10:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790851439; cv=none; b=iS2rNhZVSq/eFl4cbfnP9j+eG9S0CW5sKAIrcfUuSjFgyHuhCU7xrZ385FUMYQrT0LILR/l6VP+mWFHVDVVqzLjUZo1gd1EVx8Cbls/p+E+Vtrrt5G/pyi3kx8xUN3cVHc/uEoOSWcARr94UqbS0JKUBpNaN7Rvb6Mgdc+Hr6p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790851439; c=relaxed/simple;
	bh=fFXu3schUqNBgBCKTjpkfVaIVAqpNX9k5FOw1lZ4Wac=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mu2MlyMF0GmpazFuRMSnJOoXUDnQ6aFtKs5oqw5S3xV8KzLL6/D/1Zk2JNjX71naMCKoMOES9w91C4qc8XDd3Q1U3TqGlLX5+nck0nhxxr3Z1Aajo/B+XcdSkh6ulIcoA8bGUgMGJ8XPm/fN/wbKwcOa3YgmE6tJo3cACOvLvqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJ4vQrC7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ4vQrC7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC311F00898;
	Thu,  1 Oct 2026 10:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790851438;
	bh=fFXu3schUqNBgBCKTjpkfVaIVAqpNX9k5FOw1lZ4Wac=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hJ4vQrC7ipQG7ArfmgUscdBdUmdii7y8JVkdyqSAYUUaNgnmPs7O0ML2d0SX8x6My
	 pYNFiTCwHYzHDvjSoZRYHhk+KWHpZn4nEvDVtdKjaAQEW34rj5W+JJZnHhy5gS93qK
	 nc5Di/Mt5EIXBOsYWyJVng26lex+dI6psM5a6JqOExetIPJlZfl9wFWxhPEzXkpEA7
	 yl0PxuOl0dkOVgPKhKmv2rk5wJCgTQrPLn6hE0HTwxb/SCqCjlrGDiWhZBEHVR/5Ts
	 IaupjQqx2eo2kkyVxvlAosBmAaPtCrcFwu7fVXuYbWXM1kTnwj4qf+KrT6ODQ8KerT
	 R7HiSVCZrjQTA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 14/32] s390/diag: Convert inline assembly to
 EX_TABLE_INSN
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-15-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-15-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 10:43:57 +0000
Message-Id: <20261001104357.EAC311F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Convert all diag exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so duplicate entries and nopr padding are no longer needed and removed.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001103247.1989=
111-1-hca@linux.ibm.com?part=3D14

