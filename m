Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4678286D5E;
	Wed, 30 Sep 2026 01:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790731335; cv=none; b=VAfyWnZehZYM+SemselPaXnFLX7pd6l/9VQxo8i3ytsTMOW0xxUWm8qF4mUhfZ5iGbrh3cCMGBvqdrIm4+ZiulJ1BsDtnhYZIy2t96wXuKg88TJT313OeXxrxdkRUj4PZNt5MyMg9QhCUb0el1zmVVpT8Et1GGsCipNSW7WnfnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790731335; c=relaxed/simple;
	bh=OcBuAljt4jWnnEd8IpRsYKKqB35Z04s1t+2BMGtcE9w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=utYFkhtSk0VONbSBxqmk0H6VTbw991LnvGZLBMjNpKxVo28tIJl5vLJylFjGul6+7tO6yupIns6edcwrbKPJQuRhQxq+6ZSE9NN3IacFAeFXVYjrJ5TkVo/aP4OGPkWZJvSG6a2QR44Pj+Ks+T/YjyBQjzS+EqxWgVrnd5F9Pw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qq7wvWY7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qq7wvWY7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E23B1F000FF;
	Wed, 30 Sep 2026 01:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790731333;
	bh=khHq7dqBr+PC1XhM608Ftg5HTTg2612sy94qP4078Sk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qq7wvWY7KNiG8oqRSImCj6Y4jVnEXFvyxXmj9EOlwqJoxLb86czeQYNRgEkvRWIZ1
	 k4lwdx3XC87WmpLaVB6teyeYenUmj3Pp4ZNDl354VWFiPw9aFEDYcwS5j8urtaTFDv
	 WWHaDiwgoblQuNX8NeOn5yRaCtw6UFq4QBxdNmxPZs6+XWPY5K/1GDiiMUtXlm4dvp
	 g+I3RCLzkCZH7p3OfRQHwC1mNjqU1pqshxhN5G1/ayN7BhRvVFPPJMPCYLLQTHoV/B
	 IlEba+CKdH4OydSMjygrQ7z3c6x5PBPKZewrJcgl4wR8VKiIsa3ebj28BqHPDkW1/e
	 uMrs8orlqpnOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] kvm: s390: Reject memory region operations for
 ucontrol VMs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Dinaburg" <artem@trailofbits.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260930011211.94657-1-artem@trailofbits.com>
References: <20260930011211.94657-1-artem@trailofbits.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 01:22:12 +0000
Message-Id: <20260930012213.2E23B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Christoph Schlameuss <schlameuss@linux.ibm.com>
>=20
> [ Upstream commit 7816e58967d0e6cadce05c8540b47ed027dc2499 ]
>=20
> This change rejects the KVM_SET_USER_MEMORY_REGION and
> KVM_SET_USER_MEMORY_REGION2 ioctls when called on a ucontrol VM.
> This is necessary since ucontrol VMs have kvm->arch.gmap set to 0 and
> would thus result in a null pointer dereference further in.
> Memory management needs to be performed in userspace and using the
> ioctls KVM_S390_UCAS_MAP and KVM_S390_UCAS_UNMAP.
>=20
> Also improve s390 specific documentation for KVM_SET_USER_MEMORY_REGION
> and KVM_SET_USER_MEMORY_REGION2.
>=20
> [ Backport to 6.6.y: omitted KVM_SET_USER_MEMORY_REGION2 documentation
>   because that ioctl is absent from 6.6.y. ]
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> Fixes: 27e0393f15fc ("KVM: s390: ucontrol: per vcpu address spaces")
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Link: https://lore.kernel.org/r/20240624095902.29375-1-schlameuss@linux.i=
bm.com
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> [frankja@linux.ibm.com: commit message spelling fix, subject prefix fix]
> Message-ID: <20240624095902.29375-1-schlameuss@linux.ibm.com>
> Assisted-by: LLM
> Signed-off-by: Artem Dinaburg <artem@trailofbits.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930011211.9465=
7-1-artem@trailofbits.com?part=3D1

