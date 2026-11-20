Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795161534;
	b=ORPlMP5rIykqNji5TnrrL5boIyXpX+m9CPg5y1CZJTmsjDikZpJznEtv8UsiT+WdNkn4
	 JQDhVBfoQXZj11+CX+1F0cwvAFAeSkZIClsnuFf5C/Vks/Mffytkt+6haZuLR5t+rjpOV
	 mpvpwvAwk/u0jPxJlaJXeS7WX1zalHANnhNUkzliejK9+q92E7qoNI2ysUzNd3hmRzPr7
	 G8zS4UFQZHL9iB1+PKfH8jicAkST/HBLLOb7mYPyT35mBRRw65wbnHbGD7a4d1TAC25UD
	 Jp3GkOnGxTtUzV/P680qjUJaoU+bAdssb79q6D1rG2C/qkQxDh4AIH+orVTzyUxJ5fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795161534;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=cLS0+67Xm6j4O0DreFVUaojbZIk1TVHWDp6f/l3Xicw=;
	b=H/QFBFGSv6RihhatN5NoI+hfwiFnltBu8NHSfgD9eSEBeCkw2EB5hJYnvbklAJmFb7XM
	 MuCw1/VOEDOwWb1c3RDHcJlTkDDHeImnJNkQ7D+owLiY4/b1RMWAItjxx7bypSSvvwqZs
	 nM80OkAOEh3jrahF6mom7t48cpHeU4q71DG1F+Bi7F7JjUXi82mfcPEK9LDgCUYoZmDC6
	 mvvV2ETEYt0y9VupoNvgI7cmM/MTi71qtygI8Um9JfkfZQ6xzYjfYN/oZwqMwr9Tva3VQ
	 zGbZBmqFYK+qO3QHG/m0tUiL0acpOlkFVB6MOzKl2js9uSRKvsDYO5lc+LUrOiRLEpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmvH2DDX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F844606A320
	for <linux-s390@vger.kernel.org>; Fri, 20 Nov 2026 07:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LmvH2DDX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADF601F000C4;
	Fri, 20 Nov 2026 07:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795161534;
	bh=cLS0+67Xm6j4O0DreFVUaojbZIk1TVHWDp6f/l3Xicw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LmvH2DDXO3uj3TmHuqi7xhOUZZWTnQPc4LIKmdNHXpmS+XkRWmib1DdcKwQO5BnO4
	 F08aDPK3zDS7rgYZK3mO22g/N75LnSfyPInLjhJgQav16w82fqvqhX5lqGDcjPwPpY
	 NYvzfyMo7DfiKo94csM1Fl4zeBo/iEIx7GDH7E69MgmBSDUI3u4MuMTq+iWtvYTW1O
	 RB9w/oPWyq+KPolF3LJokmcrJ2HJshR7QeU4LM9cxWYIBrd5iDwWIvMYpLIo/58cB7
	 nIis/y0QqRBIVH2IW1VabP/rX/U9DeG5QeAwtToRSjKXByrFz0tdnDuM95cTXDcDRN
	 pvIfh8LtNjiqQ==
Message-ID: <sashiko-outbox-224671@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/2] KVM: s390: make kvm_s390_vm_stop_migration()
 void
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gautam Gala" <ggala@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261120075345.116521-3-ggala@linux.ibm.com>
References: <20261120075345.116521-1-ggala@linux.ibm.com>
 <20261120075345.116521-3-ggala@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 07:58:53 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> kvm_s390_vm_stop_migration() returns 0 on all paths; it cannot fail.
> Its caller in s390_kvm_mmu_prepare_memory_region() wraps it in
> WARN(), producing a condition that is always false. The arm64 stub
> returns -EINVAL but is unreachable because
> kvm_s390_is_migration_mode() returns false there.
>=20
> Change the return type to void and drop the dead WARN(). The
> KVM_S390_VM_MIGRATION_STOP attribute handler sets its result to 0
> explicitly; userspace behavior is unchanged since stopping
> migration never failed.
>=20
> Signed-off-by: Gautam Gala <ggala@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120075345.1165=
21-1-ggala@linux.ibm.com?part=3D2

