Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985641;
	b=qU3Th+z2pbYQDnXq+Fg7HfD/u739PHe8izHlCWMx8QBX9EEBSi7VLh51w0Ute+csCMOt
	 fZ1Q3Guwx8xiaVVwz6gpI78+qVgsMLhBcci5uqVslmHEm7IFIt2mx5Wfqx9xHiLG7RydM
	 23A50xTRUWAREf8N3rROAQpEx9rmoJbymsayzupZUAr9Ahg21GZcvR+GOxhOVcjHyp/RC
	 g/afj1mZSvLrgfLcV0/UBVQ6OHGVxAKpeySra7C6BJwHnPX8cgpLXOPdZImLUe+aEtDDX
	 S8L7F8O6KtPoGH0xmVdXMMeXh+2UNFfkSUyzWuzYRFkDKDEcSNF3OjkN4gIKSZmiq8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985641;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uYAlztwjGNXyZpKdw+si6ZmKl+PMhywGUKn3OaVv9ZY=;
	b=n22M5Q9JKnN2eo6WXqIKOh1UvYmRw+oJwiOtx+ZoGRcCl/aUfJJl/iIo99ed2vptZOgZ
	 1fVU+fnsrpi5zTc6s4jqfM6MKV+0Qp99/DSf3hQlwIGExpoNYV8xBL97j9R2soaWV7tLK
	 YE3eybrIBIWw9Ri8oDMbnSfEeIt1qnA7xXnuc4VxjnZgZ+RQGUr+SwLlHa5/5087V8AFP
	 zppemMZVYJzjnMCDeQvAxlKcAVRWTsP2+uj+YrXjwvOmz1adXDnX78FL2oJ9EQbQEtVqO
	 e8r8IyVB3gW/DJ+plnyzFyi8L33YdPB0S0AYroTagM+IjYb1WUc+R4kwHmD9+XJBiJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3FXkIE1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE1E2606A32C
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3FXkIE1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50C21F0089F;
	Fri,  6 Nov 2026 17:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793985640;
	bh=uYAlztwjGNXyZpKdw+si6ZmKl+PMhywGUKn3OaVv9ZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T3FXkIE1CqMR7/DYidDl1rLBCynIY/4P2uJ1fjdMczOxGKDP3cFk65tFnz79KnqYl
	 O05NSs2+JK+dUYkPs9FJXGLXDfdKOYvJi45JyteeGCaoazQbO9VwVrbp8mV59G/h9k
	 YlnkfNq4J862EVEDT14ZeCa1ORTCYZtEa9cKNntKcHbElqyPfbutnCmiDz2pe/k++Q
	 TB5Q2UAFUiVKy9KM5/C33rftxHjAnN7IfifP27LqK3i+5C2nqC0cY+iZXZA5LIxKMD
	 RzcCnFdJftrKQZmG6t8QJHPPehp5DvXgZ/rOMdJb12jEGx1EfvRZHldfoyRzmY9pBe
	 LPEuFjowH+V6g==
Message-ID: <sashiko-outbox-201913@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/23] s390: tools: Share arm64/kvm headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-9-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-9-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:20:39 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> In addition to sharing headers in arch/arm64/include/{asm, uapi/asm}
> also allow to share headers in arch/arm64/kvm which provide local KVM
> definitions.
>=20
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D9

