Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0242B38E8CC;
	Mon,  3 Aug 2026 16:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775789; cv=none; b=Gcu6N+DrL7bxwVAJW+jx2paSzrjQynFksuyTYFZUS7TwdIW0GaU2fLXufr/WXLu8lZ+PI/cZiy1CIusWZS5jOij/jSQvIcny1/R69aUoCK6jOvXJjz1vyaian50XDGZa0DA5us3vyPcub4ZN/uvOaDYLIJGldGY9s5L31CLOJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775789; c=relaxed/simple;
	bh=iazHTkNqyD2q+f/w12LYDaRn9D/zRE8mLzBMNDzKVyQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cNIG/YNzH3P7TWZzdbghQl3qr9APXv3nj37pSAFtWF9zGw/3bqk6LKenPkk7N+IdfLYwFFcGtIu79RrLJ9PX3dzbE+8Y6SNbu/yD26olBQdAZvj3+8jNJoBT78hkxU1onUonsUaJgBlczQdo3VYHh8jjHv21amLH7T2sQiIEcTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9N2RqFk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9N2RqFk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A771F000E9;
	Mon,  3 Aug 2026 16:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785775787;
	bh=iazHTkNqyD2q+f/w12LYDaRn9D/zRE8mLzBMNDzKVyQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a9N2RqFkDoH2uBrHEzsDFa65dRXjvIzLU69cz7xveCe4Zvuc5iUPFpoZph44osDtW
	 bm+P5OLrVLhuDxsYyEKwB/9Iyky35zRoWhxo6jTJ4r+bqJXOfo1+nEKC6A22unc94q
	 NGmFcxWUqNbQpoEzHrKuMV8MZCkVG7leSSAG83HCtG3EG53uRDgRhI/wEEN47KUG/g
	 O6YA72ik763+nsobzJb7gWSUHzti1sDcLHQ5iKGyy3TODIDiKxgQUYuHJMCqLq7opX
	 ZV5vvOKIiCY0VsTj4zzgYN3BRjDYxjX8XSDbY5vJR+Cj1q6XI/EodfwfsMQev+M/0L
	 /Xaz+sIK1h6uw==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 12/23] KVM: s390: Do not free SCA if it was not
 allocated
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260803160924.236807-13-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-13-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:49:46 +0000
Message-Id: <20260803164947.75A771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> If VM creation fails early in kvm_arch_init_vm(), the cleanup code
> tries to free up the SCA, even though the address is 0. Due to using
> free_pages_exact(), only the first page is skipped, accidentally
> freeing pages 1, 2, and 3.
>=20
> Fix by checking whether the pointer is NULL before attempting to free
> the SCA in sca_dispose().
>=20
> Fixes: e72753ed1267 ("KVM: s390: Use ESCA instead of BSCA at VM init")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D12

