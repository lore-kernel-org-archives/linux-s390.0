Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FED9423786;
	Mon, 27 Jul 2026 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172737; cv=none; b=mb5UHhNwtAqPkY6nBlo0WmpltdrLAySsLFa6uBmTeGgIOm++oNJpb+w4xQzBxJl7P+O76+dTVuPJ1wYPvPJWLAAp/c5dd8LiT9znTAl4bvDUGS+K/70+EJQjQJDCqyFh2CEHlF897kBqXm/esc6n2M5PqprdeAluPN6/BGBPSuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172737; c=relaxed/simple;
	bh=+3NXJCXCfqthMg4QCHwHU5Uo13Dy1SHD+pIzHmDxtSw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YSPAIqD7kozx6mojg0KBAxz9S2c428yBem+iWBucpIt2TD+nXC2il14+/P5yaylRcQDDS4T502eEJ3jlFvDdqJvjZWrF00qtj+bXUdeH8lIk8LEVAFUz05G+0I7wlwgpeD9QnUI29fF5cVnEqchlLjQlPS4GYRFO/uCTWxZ8HKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REcEILzG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REcEILzG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798181F000E9;
	Mon, 27 Jul 2026 17:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785172735;
	bh=+3NXJCXCfqthMg4QCHwHU5Uo13Dy1SHD+pIzHmDxtSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=REcEILzGzxDaG6kHZZvyn41VOyTQAZbw91hynxd5gBlEfsU6ZhbMn7mOLuY/2xkr7
	 zSo53QrIzBm+4AzuTVStWiXPfAGAiWGMp9ks/GZDgoGMV75mF8MlWiPxkiqzkKXOdM
	 R7OQBM7657GSWARkO8zOJ8LPp67fMpJhHwjz1c+OkUw8+gxXCkIK1ywcCd0A1B0pPH
	 m56wBwT7Z88doGMp1XtUZarCpAkWdfE1Zq2sRR4azieP5KBRvRl009sKZelBZeEqkv
	 Ig/ItRqbWT/8MDo/tCYXV3GJXHgKhrAOKEu+AUAb5fHc19HQcptOq967CgdNbC7Sjj
	 wqFgQC62ET+/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/10] KVM: s390: Fix cleanup in
 kvm_s390_pv_create_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260727150254.236021-11-imbrenda@linux.ibm.com>
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
 <20260727150254.236021-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 17:18:55 +0000
Message-Id: <20260727171855.798181F000E9@smtp.kernel.org>
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
> Fixes: d4074324b07a ("KVM: s390: pv: avoid double free of sida page")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727150254.2360=
21-1-imbrenda@linux.ibm.com?part=3D10

