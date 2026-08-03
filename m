Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65C138AC79;
	Mon,  3 Aug 2026 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775428; cv=none; b=JOf6SPmMBOruszVOtJEsQOPxhTenqI4Hbtu1MCMlJ8PcPv8WIYKjD4XgJSkujIYVmu0DTI4A4CSxclwYwEwNBiMC1nTsFn39yLgNZ7pyd6dQOnCvRrWwlNIKcAQFN2rah1tzoZOquILc1p3eG4aUtMRLK77ZQGz3OA+tBey2IXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775428; c=relaxed/simple;
	bh=dk+24eeOgO9dGQscdms1fZVmeJrLe5hy4ZsuWmO/7lk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QtWp56i7uFI0z0BN/YYc5sH/Dn7nbSbIXp/ena3zfT3xCrsbMcnx0mGM34henx03w6CH+NRXWXxts80p6qh+KarCOMF3pRjeKVRtAbo7NBVqnSBqOLL4cYc0U1CTw6VKAdmBXgdC4atmgD1SKdL7rZYwz37Ze5Gxykj79jwsmkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ndzr39ew; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ndzr39ew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D70F11F000E9;
	Mon,  3 Aug 2026 16:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785775427;
	bh=dk+24eeOgO9dGQscdms1fZVmeJrLe5hy4ZsuWmO/7lk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ndzr39ew/PO7X+o+Lb174b4u7sVnTOm9mOPCkeIkOzx+q9NXSAA9r3y4nLKHBYe+E
	 hHLcdOq+CDhf9UWUkhFd5kYIK4M42jPoMmUk9CU+1Z/HgoGVKNXpFLRen1iykZEcw5
	 yWE1q+BXXIxDy1zeMDJjy87UoKnz988eLgRCqq1fqqHPF5IzZInC+SiaKy7Bqfh5vx
	 QTpBI5c5lOgEFqG47ATKWPmyIKtm0FjNyfdn5OoW0WSOafysfDrDKNY8HJZyWHoxmy
	 7H/iUpI2x8VZBsFMI8YDAf+YyL9Ow08TwjAsaibzyKI87+y5pmhpnbNx/1LUDCG4Z1
	 SoMuyuo/MDfbg==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL v1 11/23] KVM: s390: Fix unlikely NULL gmap
 dereference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260803160924.236807-12-imbrenda@linux.ibm.com>
References: <20260803160924.236807-1-imbrenda@linux.ibm.com>
 <20260803160924.236807-12-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 16:43:46 +0000
Message-Id: <20260803164346.D70F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When creating a new vCPU, kvm_vm_ioctl_create_vcpu() will call
> kvm_arch_vcpu_postcreate() after the file descriptor for the new vCPU
> has been created. The new file descriptor has not been returned yet,
> but a malicious userspace program could try to guess it.
>=20
> If a malicious userspace program manages to start the newly created vCPU
> before kvm_arch_vcpu_postcreate() is called, __vcpu_run() will try to
> dereference vcpu->arch.gmap and trigger a NULL pointer dereference.
>=20
> Fix this by adding a new field to struct kvm_vcpu_arch to keep track of
> the initialization status of the vCPU. Refuse to run a vCPU that is not
> fully initialized.
>=20
> Fixes: dafd032a15f8 ("KVM: s390: move vcpu specific initalization to a la=
ter point")
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803160924.2368=
07-1-imbrenda@linux.ibm.com?part=3D11

