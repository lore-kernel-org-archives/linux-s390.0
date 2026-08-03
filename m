Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2A3CD8A9;
	Mon,  3 Aug 2026 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785762313; cv=none; b=fe4B44ji6xBYrGXM4rR0EYa0u5Y60IgeH1CKunVkxFuLfdUHgNjBhp4XCL72047gKifuNEV6Y+paBsxpRo91LrPu3+Vwl/gm58RdCe0cieGV4dv8FqbeIVfjat5FZjxVFz9OeKJk+uUx/934Asuku1OJ25uulTZaQ7qqZRdlf0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785762313; c=relaxed/simple;
	bh=yy6n3Dhs9ya4mMhInxonzz7t84HuIEncLwPAYFCx+HA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ICZLIE2CWC4ulm3ZqYh+V7U+CqhR0GSrpLWWwkWXLzfYVg+2KDrVtRhFVxthfiMZBteuBkIBU5h0IB4ZofjViWrSLJhRlKmHdFOJHmvKoOQSgbH6XhCjfzTulJTWVr+ejhUpPRFyEotZcFY1jnMwImd7b7wdHmstpGk+WlerOT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz+d+n0q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz+d+n0q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2845B1F000E9;
	Mon,  3 Aug 2026 13:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785762312;
	bh=yy6n3Dhs9ya4mMhInxonzz7t84HuIEncLwPAYFCx+HA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tz+d+n0qVVjOEAy6MJSX6hKk04u032JzXC00vVbKI89RZZSGAfWvJvBop7DzpOS9A
	 q7hL6mdA4ujec/s0Itk0IWYsHqNb/+dqc7m41c84SoTZ7kvfD/MULOkJkllf5z74oi
	 t2RHmmmpl3NH7tz2sjUsiLpJSF4WRwAO5StZajBpOZde/Nn+JHpRrxEesD7H2l+epg
	 4ZcexUW7I4NxyHFSMILWy6uTH50l29kOk0LyGBNViwJISkCKpT+35R4ufX3M1RUAvi
	 JYlz750ZFi9L+udnrRJcul93zP7bwq+i6zU0G1Oymk9hv5Un13Q8Zg0KNh4k6i8GOF
	 9jv/YuhFe20gQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 13/13] KVM: s390: Fix cleanup in
 kvm_s390_pv_create_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260803124040.126471-14-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
 <20260803124040.126471-14-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 13:05:10 +0000
Message-Id: <20260803130511.2845B1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803124040.1264=
71-1-imbrenda@linux.ibm.com?part=3D13

