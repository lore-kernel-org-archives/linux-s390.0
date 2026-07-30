Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7822237E2E5;
	Thu, 30 Jul 2026 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430354; cv=none; b=gi8uuDgZPGmMaK1bjG6sxWHBfrVxZYvW46GrmZAMXdcjUnkzVt3hmxuYhel7gBBQn0Yuob3qi1TWtASdK3fa8AwlmzTvzgddWYc3qovDbrf4mYktOjVSPh2c5FWBRhBveEK/33I3MI2UQlo8+4wluApJCPEd86qPRkRlOMY1Ye4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430354; c=relaxed/simple;
	bh=xhPTV3JzEdO3la5JA0cyNQhN0GNQ0TyM7R+fjUzCR6Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uQwAaakGw8+LBka31Of5mZF84ascIGQOyPmkHo/P/xHvHr+xELO5KP27EPsF3sBfdlq07AzPCKdN/CVc/uSwhGyUL87MWZU5IxTh6owgbWILH1k5nu4hI3xCZlu+ONbBsdTAei9w58jeygt6L8RIbhbOINTPeI3PDYhVu60X7Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdUHQEJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdUHQEJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85781F00A3A;
	Thu, 30 Jul 2026 16:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785430353;
	bh=xhPTV3JzEdO3la5JA0cyNQhN0GNQ0TyM7R+fjUzCR6Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cdUHQEJ7xRdPqafXYjyJJDJ871ly5C7EuU7A85P3qFv0GnfjEMlCtkJQR+/V8iUAP
	 G7TWsxCx3NOd/y6MowQAJZfa9XT0Gr8DBn7sJrrCQ3pmurZWCj7Pp+btlZf6HwCB8a
	 3OnOcnZUvaA1wvCDSlrdY99n9HToONhwYZdW8VfFyuPPByPzjtoc7dEzay5O9/Ubch
	 ntL+abQ/s8nOj5avyOhJRWQny3G43zzKrwebqGqNJeUQPj6qhSEVbxREB/32j9hyiR
	 31p+RCGyrTeooFDxUyEN0lJ1p8vjxGVXL7c4eDn4UmvaDs0ETSn+76QWXNFbDj5LJO
	 nrrJqQUPIn/Zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 12/14] KVM: s390: Fix cleanup in
 kvm_s390_pv_create_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260730162714.133327-13-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
 <20260730162714.133327-13-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:52:32 +0000
Message-Id: <20260730165232.A85781F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730162714.1333=
27-1-imbrenda@linux.ibm.com?part=3D12

