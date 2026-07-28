Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0F83A5E89;
	Tue, 28 Jul 2026 17:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259477; cv=none; b=iS7f6JQBaRsmbKzJ7iNFmUfWDlFawd7QWh/V72998tpMWO03/5/Zhx55gz5Sa2LbofgadxrsgsUpSlTuefSDW6Vhh5gpJPI3kZotMX2WbFh+IZqvWJRRPXJv19FY6LpmAAoRM/cG9OuXn6tDCzieOjgFYz1lS5i8jdugdqGn/VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259477; c=relaxed/simple;
	bh=Sasxd39/etoxEro8BoAs88yh2ogc2AMtXA+8uCM21sk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JPf6FFkkbJWuuNLCOtRo8VKCPMhuBnuqyM7FjCtZhW/G7RNSQnJGqq5qjNjQy0nLED4y92I54qEIbiPZZfYdevzU8tMS7F8IWmLFHOkuFrqhMgDcdiDa9lKdmxt7TNoGeZ3c+uV2W07JDJIlHD8kGTQ6K2wCMO/d69YJ6TKgxw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UrbYVv1S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UrbYVv1S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B1A1F000E9;
	Tue, 28 Jul 2026 17:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785259476;
	bh=Sasxd39/etoxEro8BoAs88yh2ogc2AMtXA+8uCM21sk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UrbYVv1Sj35yo7OYbDNWu3cj1XORCRBLstEJ3tQ4iLkJmjzOjiMud8Flyyuph1vOH
	 YCwtt3hn/Y6PNXLUXlC78BBBFWFNlVvpg8TP1KJYk6rjAgS58Zidry7DBcsh6mlO3r
	 ZZWQWNk58lxaifXNySjc+sCU7lOZO8md067k8tUCpOza5URLs59MNR9gRdeH55RWac
	 UM1ojVBMzL2rpv1xH9dm/bjmTpKHKdn65k3ZyTdojCsJzYDUsU71hT1+NNrLnipy6M
	 aVjPGFbPqzrDIioZEq0JL1rWo7QXenmLEV0jMrUZQqRmcrit8x2d0BGuXCXtyhBexT
	 ktMBYb32koIvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 12/13] KVM: s390: Fix kvm_s390_vcpu_unsetup_cmma()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260728170708.294400-13-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
 <20260728170708.294400-13-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:24:35 +0000
Message-Id: <20260728172435.99B1A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> In some cases kvm_s390_vcpu_unsetup_cmma() can be called with a 0
> cbrlo; in such cases, if running with V !=3D R, free_page() will attempt
> to free physical page 0.
>=20
> Fix by freeing cbrlo only if it's non-zero.
>=20
> Fixes: b31605c12f4e ("KVM: s390: make cmma usage conditionally")
> Fixes: 29b40f105ec8 ("KVM: s390: protvirt: Add initial vm and cpu lifecyc=
le handling")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728170708.2944=
00-1-imbrenda@linux.ibm.com?part=3D12

