Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A036B41F5CC;
	Mon,  3 Aug 2026 17:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785777591; cv=none; b=ALoOUYDhzNeY7b/Pj5e3svjj/uwrgdfRkxkpdTgLJ/uir9rUIXGl18xfdqspDGoWAOD475LO3XeTSNsrbWYEmX3wjNwhPWlVNpzQL1ImcDgRC62DnT2A9Bu7f6OZDWWPa3H9v95V2YFJT6iZgVj7odl4oTEbkzoPkEp/h4DuhF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785777591; c=relaxed/simple;
	bh=0UreRjRtvsw6OtgwpKpMrs71Wx0yq0SV1G7wVYQMGEo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=a22MvVBX7I42t+9ghkObZktPEI7BcqX0w/X8huS4wpQNB03MqAa4Xs8NULukm0XyvGsoHkhhu0J4oIpAYBUN6NUVZDCnx6EzsYYSSD3x5Fk2DgD3HQCpHeTwiRep9UzThhFUzTtw67/rtQILqEQBPXnQxuhW+/tKaB4TnuG5rEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLvpfiQP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLvpfiQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4FF1F000E9;
	Mon,  3 Aug 2026 17:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785777589;
	bh=0UreRjRtvsw6OtgwpKpMrs71Wx0yq0SV1G7wVYQMGEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nLvpfiQPwCqC3yaIlWRd3nA0+NsIdPMmsEWqePv0HBYmQcybIDLLXe+C9MkFA76dF
	 u0zzplpJaYWiCGba96ruZR/nhDDfaZ9VfrYatq9VbJT4FWcYHST0I2MqTJz/opKbfq
	 gC9ITqrJ+nQHUNc+FC13DnqCaKEHMKu4f9S6fk3/xdjBl+A9BkVBWbVtfRJfPfCC/X
	 FUOaLg9fkrvCSnscMAnAFHdaFsxBHHcb3Fr1TO/t9CpxSCP09L0cY7QO2IRLTjvrco
	 AZumMJWunPR1JE8II3AvAnPluRcE7POxmSQGoutDh9sQU7o6C/ISfZadTIGklM2u6p
	 zkFeh2BAM/NUw==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 23/23] KVM: s390: Fix cleanup in
 kvm_s390_pv_create_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260803160924.236807-24-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-24-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 17:19:47 +0000
Message-Id: <20260803171948.8A4FF1F000E9@smtp.kernel.org>
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
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D23

