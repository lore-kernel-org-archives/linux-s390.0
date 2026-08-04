Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505D23403E8;
	Tue,  4 Aug 2026 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785869228; cv=none; b=kbFhSw/cWEaI0MCEiiN+FvMaEPs1fqVTyfcrlWwUb04NIgU0OHSn1JoUSl3xQGRWKT9uvVMieOtd4kUsXTm0rr4U5tVzfsdjQPxnlqIzPPAPNDM4zxlpzj/xFRf8DtsUNy9n4n1KNR6ExyokqVj/wAe3W4QVVwmR/wctEp+LtTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785869228; c=relaxed/simple;
	bh=47LWcNfbqIG3/+x5FpISaKfE/u7wtl/N2p3RhkGjHT4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PIgjI1aPlXQOtWp8iuG8Y9FC8I/nIWAppjK5eMWJ1HOG+lXg5H5bx18L+7Jjzy0Y3/4sLMgvxGiqbh2dd1VThDCvPes29VD6LjOV/sbavVfWYwzVeujSG4TJWPphxF2QCn4hPhRN1H66ohBNSrWvNot37fj60v7Rux5gozZKafA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q6yAQgm0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6yAQgm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B2B1F00A3D;
	Tue,  4 Aug 2026 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785869227;
	bh=47LWcNfbqIG3/+x5FpISaKfE/u7wtl/N2p3RhkGjHT4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q6yAQgm0zGX7LlpfRgOy/havIC4nRTEM1sEqr5a51glp/rvsl4e+mLz7hCDsZa+/a
	 uJPycYJ+sPg9V787PnDtaxTdRVen1DQtG+B9wR7wtkpFFI3IKdn9+q5HkNxgAaFv4V
	 7t67DHqf68rA1hHEzARqIJAQDN+QW6wGoWlCRecXOanpjfTTZZVlUO6k3ip1v9F6jE
	 RiLHQaja2IcRbMtw2vPEFFAN+KIrlhdZGrMQaWQ0FLjpKpOtpRL+goAEQj3XUCW1aX
	 yxSldcmiHtVGmIK0/LcE4nC91oE8bm4Hm/kPUxOGb37ymN8VoMLjctSlPzPcm2QqG/
	 72JDAlT143sxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 7/7] KVM: s390: Free guest debug data on vcpu destroy
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260804162435.28617-8-borntraeger@linux.ibm.com>
References: <20260804162435.28617-1-borntraeger@linux.ibm.com>
 <20260804162435.28617-8-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 18:47:06 +0000
Message-Id: <20260804184706.E2B2B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> kvm_s390_clear_bp_data() is only called from
> kvm_arch_vcpu_ioctl_set_guest_debug(), i.e. when user space changes or
> disables debugging. A vCPU that is destroyed while hardware breakpoints
> are still armed - the normal case when the VMM just exits or crashes -
> leaks hw_bp_info, hw_wp_info and all old_data buffers, since generic KVM
> frees the vCPU right after kvm_arch_vcpu_destroy().
>=20
> That is bounded by MAX_BP_COUNT entries, so roughly 8 KiB per vCPU, but
> it is unbounded over VM lifetimes. The allocations are
> GFP_KERNEL_ACCOUNT, so the charge also outlives the exiting process and
> pins dying memcgs.
>=20
> Fix by clearing the debug data on vCPU destruction. Calling it
> unconditionally is fine: struct kvm_vcpu is zero allocated, so for a vCPU
> that never enabled debugging the counters are 0 and the pointers NULL.
>=20
> Fixes: 27291e2165b6 ("KVM: s390: hardware support for guest debugging")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804162435.2861=
7-1-borntraeger@linux.ibm.com?part=3D7

