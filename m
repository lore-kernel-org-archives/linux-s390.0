Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100D13A4F3D;
	Fri, 18 Sep 2026 14:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741600; cv=none; b=BtTit8Ifyda+VRa9EUU2yUFRysaQORT13SQmqgQmgifGtZ3K2xIHGY3wMP0/oyy7/OI/BqqyP6zNyi8yN5dv6dji9SXOhcm9R3gy27FlX5xAFu6QNl0HNreMwfIDGVik2ACkHb1VV8zsb8jeuzzMiOgEJJTMRddsVwa/h3ASFeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741600; c=relaxed/simple;
	bh=CVyeT5MMiKNb80nzmfjTnV7DYf/LfIGB6nWTVAhLb+s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NB5KYGd+B3xXsT+4VFg64+C+DFk4PFrCV6ruqu5NRLKQySfsvSzwxeNFZAoeCcKaJPDjf/lzXRi8Fn7ZknXqiEFJVpT0NXbs7pHAuWf99VlwVdbq0JdZWmwEyv++YQ4uDaQJGnZGa9w95njfPgTkBQqu7Df6S4+C0t3Zr0Hb+M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbntdF6c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbntdF6c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523D31F000FF;
	Fri, 18 Sep 2026 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789741598;
	bh=CVyeT5MMiKNb80nzmfjTnV7DYf/LfIGB6nWTVAhLb+s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CbntdF6ckJfY/h8YXmQus8sOUge+O2pWgQrZ2DXBUvTRNjqRNte8lNkdejdgwuya6
	 gnJQaoMLDxRBN5NEfJEvj108Dz9Vl9eZaM/hapgdiLQtRdH7DbDqZzxC0KAdx/9bnh
	 c59zQDquIw+3SosLSu62ejVW9ASXmWS+Sd0ADqxjRFZqe0gFSrGtz0HMUY1xwOjkJl
	 MwjauwGtZmwO04ONoSuLh6OZYVVf5v/U5DTpl1hz6Udww0fR3wXAuvyQ0OAP654Y7M
	 mFeKO28x8PTFjKvJX1aC8gVqR230GZmc6EXIklSiu3V6EQb2MVD0OCtWqJFqw+S34E
	 D5+2z9GIQGCnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 04/29] KVM/vfio: Use file-based reference counting
 for KVM
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, "Oliver Upton" <oupton@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260918133107.1042730-5-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-5-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 14:26:37 +0000
Message-Id: <20260918142638.523D31F000FF@smtp.kernel.org>
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
> page-track API likewise, and update vfio_ap and vfio_pci_zdev to use
> file_to_kvm_s390(). This simplifies the code and removes all remaining
> externally exported symbols for KVM which would appear twice for when a
> second concurrent KVM module is introduced.
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D4

