Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA0B3C10A8;
	Fri, 31 Jul 2026 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504111; cv=none; b=qZ71k8jXlhFOON7JSwCnNPIzQ6zpD9qoSYRqTfx5rFTUMLg+j5MU7EubN/Mn4MKql5bZovb+xvbdPyvjH2AQ/OFaIT7EEX6iqE78Ki1KdAG8QUKJGx9PyTNScyEGxTh854Hrg+DnCKQcOERTwbhLQHxAUg4EmnsFGymtAtSmcqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504111; c=relaxed/simple;
	bh=f3OPLNE1tq117hRM00Hb2iWUVow21I+5bV19MW3TD0I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SYoAp5KVTTfnk5gV1Kkh0lEFap3jc3aV2Wq/K2iADfz8b+YsPcoP1yqBdY1mK7979YVZNaHg+bS/BGbrcxHupQb6P/FQL4IlmCbJuf12V6iWfADpvZA5ScIZyXhiVbf/MJ3YHkMh7jjB/rdtU8j+dJZUS3FKih14cZEuLi3rtfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoJKqXAm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoJKqXAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68D11F00A3D;
	Fri, 31 Jul 2026 13:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504110;
	bh=f3OPLNE1tq117hRM00Hb2iWUVow21I+5bV19MW3TD0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AoJKqXAmif3XdsJY+zDU/OurQZsIWDHbOsDj3iXODhyJ1JRW7LtVDJ/fKmcu1fUhu
	 M7EoAVsd8paEY43dGxwqgA+BLdT866uEpvcQ/AnG5KESz9N/bRpoYof8DH4FZMBrZi
	 KRY08q2LXKFQ/jvDsw6O276NEldV3Rj92UtBiRhXjM7RQF8qIHEwJ6k3pX2pQ8lnzb
	 l0xFAXwC9oZNnxmlkYkq8lIePpUOD3fQXFjFLjo5Z1D6E/2GMmL+aYQN6USiqO6vrD
	 jnZ9imhcBZPsPQpYqNBJ5UqKCKkR8yd+CSws3EjFQZ3SaNm+lJThREw7J8L7OFSGoo
	 wIOvbxtJaHkaQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/14] KVM: s390: Fix cleanup in
 kvm_s390_pv_create_cpu()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260731130138.173983-14-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
 <20260731130138.173983-14-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:21:49 +0000
Message-Id: <20260731132149.A68D11F00A3D@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130138.1739=
83-1-imbrenda@linux.ibm.com?part=3D13

