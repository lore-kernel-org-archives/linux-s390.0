Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4478E4499A4;
	Mon, 28 Sep 2026 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601278; cv=none; b=PcuPloyJAhlg6XB4TBVnS7kusmpTpyUCWOZkCcodS3Km7XNXA4kW/8nZp2WFFTCc3b3+4Xn6ZEw54q2YcoAKFZ0vorQpVvjg+/7D+ph0w/+pqfSMYhUSjBE/muZwVD1Cp8F6vwH1j+rWJG5dM87IvhzmamCZGpggcH19bSzapks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601278; c=relaxed/simple;
	bh=HDG02bp08Xcf1Y+Mdk88UjERMeBfUYk2oolk/C6ORWA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AcSwjrZl4fRuNT3qqeHMTgt+X3lzfEkE69XRfeA0ftK8ZO3j2e5A8Ba7kH56l4XhLTfRcjLiyVoAfnnr/+/t+Eb8TrJQeFRdsQtMbMH7u0xdduwhzdWu/0RKcdbitrKqdawHTVFYRztgk9NjfMF1BGbs00A9Vt60z8A43OTiRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n52rXZhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n52rXZhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899C21F000FF;
	Mon, 28 Sep 2026 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790601277;
	bh=HDG02bp08Xcf1Y+Mdk88UjERMeBfUYk2oolk/C6ORWA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n52rXZhVpmS9Q9UAFLUDnN2hEm2mYmlVKFmcJX99iJvspKMnn9jiq3DT4F8/el3SU
	 6SNhAQVTV0vywjow/orBPmX7WPlG1PIQ+4XVvG9KMYsNFPy59TpQ+Qu1NrynCllIJw
	 eL2hTvhf5UBlpjXkGjqRJM4gpnLW3awYYWiPujqOc1dsrzIupj2IM/tMP9w5aEEMKW
	 C+KcXaJst0i5PyNxTI71XiaxRVQku9c/tA/K0iyI+vV5YXlHwQcREinAIiBRCt3xgE
	 +EDDGRZZiYq7aGuqLaX//wUyHoZ8nG1ttVdhkMl+Zwoa1GRKE4unLucRL3ZPVxy3zf
	 n3AUMmgCJuABA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] KVM: Introduce file_to_kvm_<arch>()
 infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260928-vfio-v4-1-e32e226d5932@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
 <20260928-vfio-v4-1-e32e226d5932@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 13:14:36 +0000
Message-Id: <20260928131436.899C21F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Add a macro mechanism that generates an opt-in and arch-namespaced
> file_to_kvm_<arch>() to convert a file reference to a kvm object if the
> file handle represents a kvm handle.
>=20
> Activate for x86 and for s390 (native KVM only).
>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-vfio-v4-0-=
e32e226d5932@linux.ibm.com?part=3D1

