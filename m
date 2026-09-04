Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D46421235;
	Fri,  4 Sep 2026 06:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502843; cv=none; b=WsZKrBMuA6HlOWw6wwGhw/41WwJrtf6aIiiSYaIloauOX/lgiUIa67GlTH5YCazCuToLss4Etq8+zegDlnQ7A39Xy8lg+RXfl98p7hdVi2IZlhz2A5aERcLb0qnUZ7j/ZfKC4vA9qGGDObgYcby971RZs52fVjC42EkbJOQQOd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502843; c=relaxed/simple;
	bh=zQHUoXjxFXQ7JS2isKHGk6+jcsg7f8D/PBx8eG58yHo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zxh2s1kf03BzeBiYjezk2effUVITiq0hRSsUXrhy+0CUrdNefCB/zDpaPsQgVkw3h3+03MryFfLI3Z+an10xNN8BsGefwtP+rgDcbAhpL8SIZzwqVvPadEtYOO9IjXlR1R0xRdy0dsLoTh5h3r3/TqYxWeBJSWlOJXDvhH0Bxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djULkvxX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djULkvxX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940C31F00A3E;
	Fri,  4 Sep 2026 06:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788502842;
	bh=zQHUoXjxFXQ7JS2isKHGk6+jcsg7f8D/PBx8eG58yHo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=djULkvxXmgX4sz5/BGvRwC8fjMT8cyOZrFs/kznQdcI3BJLuDTSetN7oV37YNlqh8
	 7RWqsLp730wdzsF+rl0LsMaq5jFFmC+akV/Vdp607gNp0vxqSq9r2daGZgLvhbG8N0
	 PlM8ZfFD/6zNcXaiCwbnJBTnAJWVzapu2lDZcC+z3NoVwo4Xnj9f4+QUvnOboIKkCU
	 tdZJlHQpQgCZVLlCgYoQHa6UvsR50ZWftD6s/LFOj/yb2mz17kQWKyLJ618hOfZeeJ
	 NkKrdCkuUr23XaiIhWTNJuSEIioBo4ZTkSQMnbx6SpiXAO3SVY23287CN+io0C5E4x
	 an0GoidI8HJvQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 10/11] s390/uv: Fix loop condition in
 uv_find_secrets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260904060647.562443-11-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
 <20260904060647.562443-11-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:20:41 +0000
Message-Id: <20260904062041.940C31F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Steffen Eiden <seiden@linux.ibm.com>
>=20
> Systems with more than 85 UV secrets got -ENOENT for any secret past the
> first page.
>=20
> Fix this by setting the start index at the beginning of the loop in
> uv_find_secret() and not at the end. First test if there are more
> secrets left by comparing start_idx with list->next_secret_idx, and then
> set the start index to the next secret index.
>=20
> Fixes: 7c9137af2042 ("s390/uv: Retrieve UV secrets support")
> Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904060647.5624=
43-1-imbrenda@linux.ibm.com?part=3D10

