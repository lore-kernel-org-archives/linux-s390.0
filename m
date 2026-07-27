Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDAA32B9BB
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171463; cv=none; b=MBQATN3M6FKitCi+MSTD8UAfGEtNli5wvxdphP9PALx1y6rYl/TCKxi9jCeKmWzlr4Ep8EDO15jIwXptioMYSt4XovOCNW3VSiY/4HzIPW16qO2VLKquuj6hadt4stJaeywH707sdFtNZHNhbuX/eh1it0Ydt0VAKtl+nGBwCN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171463; c=relaxed/simple;
	bh=uWoXI1pSqRz0/y9fjAs1R8kkHsu0ebBlqGYp08yB3GA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kRxcR4OrQXagod535EYh5ME5DnbCD4irgygttUWVS3nRA6ba9qfoNT/PMIySROmEwOxTiRIgN5xioyRvhghqhaE3h/F0dhVjJx0VvVYfMexVcYzkOIkjWs/UfONpo6XjdXbSe2gaxZe8Ca/+OFJx0L3x0UgBqi98CA5tNH7/Mws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dyHsebiz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyHsebiz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B726F1F000E9;
	Mon, 27 Jul 2026 16:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785171461;
	bh=wEz3Wt99nIIw8xztypRMT5vjEOhP9uLlV5AgR1udcZM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dyHsebiz39XsOO/kZn4Q676IPEvr7A59HZ6hFN5NhONXGFnr1unBYIGbPawuzOaCd
	 t2smaYrR9+Y5w3zTxfu3pUZAoSA0PYUkEc9YCelVKyBQdb0ft3Gk1c+lchGlvTm37u
	 TcbOOjnYYItlpvV+Md0S9wRssabb2HcuZIHLhCuadTLWJ1gOEAT3xUMga5+Y/h4eT6
	 V9/BQy/6ykWMx4DGzR4GyGuz7aXfubgqdycqjojbgMGDwUxMhIPQrWWFj//TkkONzw
	 l21ff7hvhLv7lzb0iPWF8DEGcroNEeJfnt6eWykCMuitRT+8R189pJQulTZsxMrzN7
	 Jv9zIVIcy/oAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] KVM: s390: Remove cond_resched() calls
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727162430.1599396-3-hca@linux.ibm.com>
References: <20260727162430.1599396-1-hca@linux.ibm.com>
 <20260727162430.1599396-3-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 16:57:40 +0000
Message-Id: <20260727165740.B726F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing cpu_relax() in busy-wait loops in ipte_lock_simple and i=
pte_lock_siif.
--

--- Patch [2]: [PATCH 2/4] KVM: s390: Remove cond_resched() calls ---
commit 85d6ff7bc8ba9ff52b5d710af6d19c877a1f970f
Author: Heiko Carstens <hca@linux.ibm.com>

KVM: s390: Remove cond_resched() calls
   =20
Since [1] cond_resched() is a no-op on s390. Remove all calls.

[ ... ]

> diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
> index 36102b2727fbf..0d389a302a70e 100644
> --- a/arch/s390/kvm/gaccess.c
> +++ b/arch/s390/kvm/gaccess.c
> @@ -151,10 +151,8 @@ static void ipte_lock_simple(struct kvm *kvm)
>  	ic =3D &kvm->arch.sca->ipte_control;
>  	old =3D READ_ONCE(*ic);
>  	do {
> -		if (old.k) {
> -			cond_resched();
> +		if (old.k)
>  			goto retry;
> -		}

[Severity: Medium]
This isn't a bug introduced by this patch, but removing cond_resched() makes
it clear that this becomes a tight read-spin loop when old.k evaluates to t=
rue.

Since cond_resched() is a no-op, this loop continuously re-reads memory wit=
hout
yielding or pausing.

Should this include a cpu_relax() to prevent saturating memory bandwidth
and starving other SMT threads on the same core?

>  		new =3D old;
>  		new.k =3D 1;
>  	} while (!try_cmpxchg(&ic->val, &old.val, new.val));
> @@ -189,10 +187,8 @@ static void ipte_lock_siif(struct kvm *kvm)
>  	ic =3D &kvm->arch.sca->ipte_control;
>  	old =3D READ_ONCE(*ic);
>  	do {
> -		if (old.kg) {
> -			cond_resched();
> +		if (old.kg)
>  			goto retry;
> -		}

[Severity: Medium]
This isn't a bug introduced by this patch, but similar to ipte_lock_simple(=
),
this creates a tight read-spin loop when old.kg evaluates to true.

Would adding cpu_relax() be appropriate here as well?

>  		new =3D old;
>  		new.k =3D 1;
>  		new.kh++;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727162430.1599=
396-1-hca@linux.ibm.com?part=3D2
