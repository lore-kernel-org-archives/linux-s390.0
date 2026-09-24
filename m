Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930803D1AB9;
	Thu, 24 Sep 2026 09:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790240571; cv=none; b=JU26qOmZ6IAXxZWkcCcmuntwSlJSV/OrgsN5yfqVM3Pj5S83QBvHSg8QTyyJHcNQTNmsyZjdoqCd2wfiOHeDvWbJsrZg+QiJz3IyldBNiSYQaGZDW2lPGiJQ5M774zY/muwHX/dGRleLIwujBbYWmbV9PFRvlsYm/c3ialoorJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790240571; c=relaxed/simple;
	bh=rKyhNPgAe6mLH74pOG5es61QnMriK4h8vLyT2BCiHUA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iSCOrD7Z0T9gdDVGyn3eMjwVYpsGT2RaWBn/BdL5j4bolBwi/U6Qeih4EnkdrxC48M90aydIVx+6dox+/Samt1vksS0RqcpntrInn0UbMd29JRhRS45FRD4wzgUnRxbFLLpQHTZRZ4X0Reax2lrMaGzwanRmK8u7+XlXWaSDLSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkXTTiTN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkXTTiTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C34F01F000FF;
	Thu, 24 Sep 2026 09:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790240561;
	bh=rKyhNPgAe6mLH74pOG5es61QnMriK4h8vLyT2BCiHUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZkXTTiTNAR1n9XUS/Gp0EiF459FpsgoJElKX0FxW4FXR7jTNMU+PHwFl4lFGJOxfR
	 J+nXsPMd2B1PAjMcuVQVS0bhmv4zRmX8XcBetG/sVa1dh6vvD/3kRjJ5jM2fsVDQCN
	 wDEcstK8Bb10/h5spjm0FLLvjLRWJAR12J9HyWvhI01AgdzhtKutY26pdD9EcIpEqs
	 8UkGmzbS1AWcr9McyvAUbnSYRneOdn7AdO/XO/xapn26DA9dgH/o97QGtoawAXYdT8
	 K9QDChM77Sx3I7rIJ6UY5jxObQswpWnK/P7s3ZIrKAhoLmZkxkd/4jabyyVBeJee7T
	 dShnkzy6kPIcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 5/5] KVM: Restrict kvm_get_kvm/kvm_put_kvm export to
 internal KVM modules
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260924-vfio-v3-5-4a294307797b@linux.ibm.com>
References: <20260924-vfio-v3-0-4a294307797b@linux.ibm.com>
 <20260924-vfio-v3-5-4a294307797b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 09:02:40 +0000
Message-Id: <20260924090240.C34F01F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-vfio-v3-0-=
4a294307797b@linux.ibm.com?part=3D5

