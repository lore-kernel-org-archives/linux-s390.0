Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB07451983;
	Wed, 29 Jul 2026 18:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785350377; cv=none; b=adC/aN9GAyjwFvmEgC+NrqUl0MAf51k4ZKNTe40JIZ2oW2A6hAb1gvcFDcL2OT2kvkTc+7QCZNapt7NE4rKOXk2m2kRti52Z91abiSRSAg7toBdHO11tzd9wv7I97teRcNhCX5hISnKxMlCUpCDv3PC+igVjcz7eeIR+AFyU+cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785350377; c=relaxed/simple;
	bh=DNfaSsBUK9JXwcSloaxG4CtYyh7RwB5NM2jdE3RLGDA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KGRFiKy2ZNV4Ae1c5714vhBluiAt5RZAiSQH9c8dQWHcj5x6TvYE+WgYlqxfQY5Mf4UhI6ogHQyeNOzyrrj9MwosDeS4kubVe1UoCIszUMfO9iL8t4o8NCsEoI7c0zNSD3AlPFnQ04OZ8PEe58DMjFH6CWm6FqLfdMSNQ9psqg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+caKuUf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+caKuUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304DF1F000E9;
	Wed, 29 Jul 2026 18:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785350375;
	bh=DNfaSsBUK9JXwcSloaxG4CtYyh7RwB5NM2jdE3RLGDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z+caKuUfyUeYle3c55Ci6tDEhOlCJCR1vJL/VSImUn9PEY5b0QvUQU4e9Hcs21fhO
	 xVGZuKoqVpoxiPnpsmNEZOZZ7OhEQEdSuT0rcaJq+xkgqFTXmLEK+OuHkMCm+KCIaQ
	 xHQuVj4BkTLNr4OOkzTkAAYcC0pn44Q+Gc/E2zSuIcOyE8eipeOzXFeu1YYSgnUl3J
	 z8C5d3w7NWgeiNjOxyK1Y2ZX7Ek2I0Lcg4pBT9FpxJRGAu4SB6QUqxF/Y8WDi3es4c
	 IWqH4WUxUSc6uME8uyOc6oGBE+0aWTv1dW1ICLuRI98iDCzW25r2/P8lHZIqVcNPpO
	 fmGQhsxy5NyGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/13] KVM: s390: Fix cleanup in
 kvm_s390_pv_create_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260729152938.782383-13-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
 <20260729152938.782383-13-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 18:39:34 +0000
Message-Id: <20260729183935.304DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If creating a protected vCPU in kvm_s390_pv_create_cpu() fails,
> kvm_s390_pv_destroy_cpu() was called, which checks whether the vCPU has
> a PV handle and exits doing nothing otherwise. At that point, due to
> not having created the protected vCPU, the PV handle will not be set,
> and kvm_s390_pv_destroy_cpu() will do nothing, thus leaking the
> allocated memory.
>=20
> Fix by factoring out the code to free and reset a PV vCPU; call it from
> kvm_s390_pv_destroy_cpu() and kvm_s390_pv_create_cpu().
>=20
> Opportunistically fix the return value of kvm_s390_pv_destroy_cpu() in
> case of errors: return -EIO instead if EIO.
>=20
> Fixes: d4074324b07a ("KVM: s390: pv: avoid double free of sida page")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729152938.7823=
83-1-imbrenda@linux.ibm.com?part=3D12

