Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF93002C8;
	Wed, 12 Aug 2026 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786550644; cv=none; b=h/0lFX/ezwLnpZY0cWZT0Tbu5wnoRDvkdSWfQHra3eqSjomoxvwImdNGeMtn/NkRwyJmXW8Uru3CZGX+qja50IWG9C/t9paPLOM74CzgG8JcueOFw5ZzfRHQhCAlShQDfgX4gj2blCKR43jLLCXrOBtLn7aQcF1IRTLVbhrY4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786550644; c=relaxed/simple;
	bh=14Bx2+JOKSUZJUwmx71Q1LD9J2TXUuYwMUiG5fYlQek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ak9MBO7FE6QWYdWp238kl4r4NzALzPrt+jPMYGVrCMeVrw4G9MIHiLD/wD/c4AV026jXey45pNfC42TWUtDXXScXqBw0GkYZWp1LkqCYoxwS/rjVe2p+fYES1GQ0oszcrA8jZLTVKaQCEU26+jMI3w2iJQVKidg+gGnyAd7hPAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8FMcnNc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8FMcnNc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0129D1F000E9;
	Wed, 12 Aug 2026 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786550643;
	bh=14Bx2+JOKSUZJUwmx71Q1LD9J2TXUuYwMUiG5fYlQek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E8FMcnNcU3Ur1Jm9Irz7RqW7mHrkclFLd8GzX0ErAyPWo4JnT9OK2TzNZoZmyLVVn
	 zJFdegI2e+73w7oTqYNgZ5x3bXNubOB7K8jLxj2ZaNW5pc24QiR6FTY2qbwxFkbRP/
	 iOTC1a3Tgu5pn3fGlPcD2LtewSDyVjY+LvzLa+CduYV4zBN5XtKE/u4xkexbIVNfJK
	 PxVKTnBlxRA4fKa9XBvcZuewlL7zguk4PDT9ex8ytk0fCe6/7nx8u2El3p+vPWNF81
	 vAnHEktwtR6CJ8qmc7WFLzMJ2u5wmA/l531P5e5l6QGtiE2IIzir1NRkDFMT0QlrOq
	 TFfzLsk+qDh/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] s390/uv: Fix loop condition in uv_find_secrets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812-uv_secrets_fix-v3-1-a85bd29e0666@linux.ibm.com>
References: <20260812-uv_secrets_fix-v3-0-a85bd29e0666@linux.ibm.com>
 <20260812-uv_secrets_fix-v3-1-a85bd29e0666@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:04:02 +0000
Message-Id: <20260812160403.0129D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

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

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-uv_secrets=
_fix-v3-0-a85bd29e0666@linux.ibm.com?part=3D1

