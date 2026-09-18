Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502DB3DF008;
	Fri, 18 Sep 2026 14:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740141; cv=none; b=g87QVZ95krACbSizgJCDBhMJte3zzJlOdRhyRjdwHvUx+zI4Ssico/vswZKps13BlF1THd3BKAPQ+DZ77glLz9bL2qyH6RKMG8rRs+4pWLOSVYzS9IrE3tivv4HoLDn1LEqCYd/JhyNEJfhXYdcZDlLJEEli/1thXgp0Oy7/2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740141; c=relaxed/simple;
	bh=1sF0FA/62+eswZ/0yvpE5Ch+CaGmGLfzoMZ1Go19VAU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kvTT+EtsdaPYrH0n4ky/EbPMrKki2UR3bR8cmQl0m8HVkGardAczNegGVH3LROZjiJEK0bh9YWMtvZpQed7sD0KvwrPpt2ijPKlDn5YMAO3y0GlTjLzXWgSHazkUb6CMPWdUDUEKywkuaVMape1fArZhSHIvznDzcl7NgueWfYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8jLGNKC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8jLGNKC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C71E1F000FF;
	Fri, 18 Sep 2026 14:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789740139;
	bh=AMqIKNOPjZPPECvzFtEl5Y+Ek7z5ODGlFeVi1miXXfM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F8jLGNKCrnVnYB+3C6ZaDJKIcERRXdw/s3+h3oLMapIRQcAeJJrISaKOKbopcFaib
	 jBcMnT3eyoo+XwmnqYEHLYNeskLi8OaXwZNlxSWXb5FMoiXDeMk3G7q1PJ/KkLhwOE
	 3cXQMN6yyfQ1sZ9hAHsdXSXojJbHOUbB1lZhjY/zo/fRXo/Gt0inV8IYd56lPEBkhQ
	 na39X32TZIZfGBSH8kI2oTSxGvq2sdKKTlHeYiM5WhSk0P8STWsYqi+Tg8frkE9HiC
	 nY8LtGuNToj1T3d/S2u2DBNNoz960HN1rZ6a9TEzdsibrtZsbmF+8We15gkQxP2MnR
	 FmvumeunVLcDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 03/29] KVM: x86: Use file_to_kvm_x86() in SEV
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev
In-Reply-To: <20260918133107.1042730-4-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-4-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:02:18 +0000
Message-Id: <20260918140218.9C71E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Use the new arch-namespaced helper  instead of open-coding the file
> check and private_data cast separately.
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D3

