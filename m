Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B3439F62;
	Mon, 28 Sep 2026 13:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601131; cv=none; b=VNz0iSHLAZUzqj53r60ZPO0Xsik14nKjtngfCmd9l/Wb2NRBAUNQkhpVvf7kyGxMmmKc+fIdHc3DdUr3aE4J76w0iH8ael/V2qvB0ySKZwJpK+bQsZFF9olc2fPI6aSuaB11hnde6xB2RtLWweoki5Gqxoy9sPzhUsiycEwI1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601131; c=relaxed/simple;
	bh=rL6ZYJv9DsFjRvU38C/nBOV/mCiBjmE6dVSThxlYNFo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C84uNfnRZSxL9Zfo07vor+hvn77EXBCuO9RVjD5q7pm6WeBCtblKNa5zHILikDBGsCspWe6O5+UHpQiLHEIIfotmr6DTojOExl1s1RkUpJN2ROr4BegEgQ+0YyTLnySfrwX2IlwcBIKza+iMNxUvXNiYWYmYY2RKmiWJg3q2B3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ak23Jwaq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ak23Jwaq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13781F00893;
	Mon, 28 Sep 2026 13:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790601129;
	bh=rL6ZYJv9DsFjRvU38C/nBOV/mCiBjmE6dVSThxlYNFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ak23Jwaqske4VSB0mlzncNL9cWc2zY7dCnas9HOZ6n8s2Tr5qUGBbq90mRlu24OI2
	 w0+EP7TFhLA3IQeRkHzTZ5CcnQ59Q/m3I2mxR8yZe4HbDxElwXFdL4gG/FUcuKH9O1
	 fhHrN783syx9Zp7XeCPZXRBw/4MOrW3f5k2O7xq4yOeA0ChR7dHoaJ3lmmULDkyKwW
	 V63PRvWExovYyfMIS0bpCRQjMHsYRnvCEZIUiONWpqQrsUY0q6F1edtkJ/xz7TsP9C
	 6L3nEL8n3gaozHzkWbUErreoKsldVDOReWYDcVSwIjsWopxnE1mgCqoA6jZfHC1I/g
	 XYkuUJE0s3vJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] KVM: Restrict kvm_get_kvm/kvm_put_kvm export to
 internal KVM modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260928-vfio-v4-5-e32e226d5932@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
 <20260928-vfio-v4-5-e32e226d5932@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 13:12:09 +0000
Message-Id: <20260928131209.A13781F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Switch kvm_get_kvm, kvm_get_kvm_safe, and kvm_put_kvm from
> EXPORT_SYMBOL_GPL to EXPORT_SYMBOL_FOR_KVM_INTERNAL. These symbols are
> now only used within KVM itself. No external module needs them now that
> VFIO uses file-based reference counting. Remove the corresponding
> exemptions from the x86 KVM Makefile exports check.
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-vfio-v4-0-=
e32e226d5932@linux.ibm.com?part=3D5

