Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B8E312819;
	Mon, 28 Sep 2026 13:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601755; cv=none; b=fLrTxi3b9qbB7hLCrAqzdGs1P5Q994RuxYHe+TV7IyAfAuKRNFdD6iDXpfafkER8P6h6MCZ0/B0J1tlbjtcKhVyKfLBwfBXPtiYbo5xw7szdOM5Ixk9U86HtvG73z4xReUIcPZ4rQm0gHUwWRTSB1EYZyha5zKPPUfphBiCLW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601755; c=relaxed/simple;
	bh=I1ipRuIqe4H7eFc+XrpVGhyBcaGx9cJa200gBPcN0nc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=E4FcKnyoMif9obAfwYzeozOlBGXa4EC7la+mKvMyRjhUZsI4fSzy+OyVtXTnlems5TFGpFgiRal7/iqnBSsaXkLgoswgp0PJymd1fb2KfHOoSARUKEHLIxIsBtr7t6oT7Z+04RgjxvVdBWra1WRzHhhEW27bagi19NWUKDbawSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThCZg/Dh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThCZg/Dh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63B91F000FF;
	Mon, 28 Sep 2026 13:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790601754;
	bh=I1ipRuIqe4H7eFc+XrpVGhyBcaGx9cJa200gBPcN0nc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ThCZg/Dhnr7qEO5eViHpXP6KhFPjfSDDeMkV/xaw7dTiVgrcZ6uQGZPz39AdW/Atm
	 QvUKja95sBQWR+bNbMqImzLnHxbmd+WGWFIZCuRRaTYbc+FvW+TRyKDwk7g5uS3Y20
	 N1IusuqTj92Jj3i+po6+w0VYeuvlOFtAeDATrIFNWq4X7jHHhLTGwIcEc4foSP5Mp5
	 7fEmH5Y1J3MhqDBhfGZqU4ol26x8JJDZIcBAMhMTiXuamo6hjbc49k5xG8QdAUIeUN
	 ZB4KBqLRmjeTHZj3G1688uaI3y4xG8Bhzo5lFZDuouKmTsL3mdXloEyb7B6Y+QRdNd
	 P05xyCHln0dHA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/6] KVM/vfio: Use file-based reference counting for
 KVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260928-vfio-v4-4-e32e226d5932@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
 <20260928-vfio-v4-4-e32e226d5932@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 13:22:33 +0000
Message-Id: <20260928132233.C63B91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Replace manual module reference counting with file-based reference
> counting for KVM integration. Previously, VFIO used symbol_get() to
> obtain function pointers for kvm_get_kvm_safe() and kvm_put_kvm(),
> then manually tracked module references through these symbols. This
> approach required storing the put_kvm function pointer in each device
> and carefully managing symbol references.
>=20
> Pass struct file pointers instead of struct kvm pointers throughout the
> VFIO-KVM interface, leveraging the kernel's existing file reference
> counting via get_file()/get_file_active() and fput(). Convert the x86
> page-track API and update s390 vfio to use file_to_kvm_<arch>(). This
> simplifies the code.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-vfio-v4-0-=
e32e226d5932@linux.ibm.com?part=3D4

