Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7F739FCB4;
	Tue, 28 Jul 2026 17:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785258866; cv=none; b=jrxGgAoEV30K6B7XBQc/7/WOzIDdOtJsblwT8GcPMPhILRrIHlMR6lBqZ6dEBLIWgSAawj1Ku9hh3MibukBw7irW4P1aKlmrUPaQH+sLhS0RekhURRgISr50ETMpRGzNKxdSIANMrcA483J5UA/gjlscwb3ZQ8vheiXIgGdsA9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785258866; c=relaxed/simple;
	bh=Ci/vrXQrNRerdGGvxMC9I733D7RVY6m1OBhHDg8aI/s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gkp9/s0SYWHMXWJ/tWZfPGCObZXBXzDQTOshiS24xIdWi3KV6DWOlMujQnTZ96SzqPVdutpJch4vwU117/FtH07n7B8k05c/nhY7mdsIB05FYSRqCSO+gqVYEaVAWo1iSKwXFuEcYiV/hpeWLdqxoff647Dx5SuQ/GNT/5rzbnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7OqSbi5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7OqSbi5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B461F000E9;
	Tue, 28 Jul 2026 17:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785258863;
	bh=Ci/vrXQrNRerdGGvxMC9I733D7RVY6m1OBhHDg8aI/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G7OqSbi50WD663GTFz2MtJtHOISgFP458f3H/uleOSvIKpCHfiLgUNZXyCJHMybpz
	 Qd4ciSZXvoXbjpmjnMXBdSw3W7dq+9FTzFm2cTJQPd4uCyvbLrvA9ZzNz0fEYC5+RN
	 Pc+7k0SAqpzmR3k71pbWeyZ18u2fqOroISGvCE0deT7ivvf38xW7VVQJFamudBOSr6
	 N+mp3bCE+adPm+UtbmVvV+7OxF/s+39vfGEXltgpgnBiR30W6RBB8D/YXxbSlS4esP
	 ObUtnjM1uUOPLK0PvqtLTkuLJmiVgzxVLpa6VJxkaCv7CnfeCsJopzddTQ77sa2DFs
	 K7eHkik1ntSAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/13] KVM: s390: Fix cleanup in
 kvm_s390_pv_create_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260728170708.294400-11-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
 <20260728170708.294400-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:14:22 +0000
Message-Id: <20260728171422.B9B461F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728170708.2944=
00-1-imbrenda@linux.ibm.com?part=3D10

