Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C8407CF6;
	Mon,  3 Aug 2026 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761752; cv=none; b=MM2YW/RKdZuvdgxH+Yu1JJ0iocy2Xyan4m/TlLSLAM+pVeqabhJwohazYGxBUmQxF4B1lMjZRBKXyVXK+t85gTxgP5pSjkGftyiEQjrtwNIyN7kdfcrUrpObZc2L6zM3suR94pb3JvU9x0vmojdFf/lY13/yic24my/zivzgtPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761752; c=relaxed/simple;
	bh=VeM/JSb+cZjUu85C37ZRPZIXpj3tHnty6cxGIIbJEKs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DVrwRLYPjngrc0Rz6RHNOkvwctzQwrlktV5dBSVSzGzi/9rwWtMXHkIupYVhpJF9qE+qEHyrDSS7b5WhzHyiVBS5wxCzpC7P758FaGYFu/j6S+Q/YJeHhv6sW8WyYA2Hqfdjjb6LcfdpBaJFo25pYkDws75X5pDdHRd5W9h/FU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lK0XdPBw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lK0XdPBw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05061F000E9;
	Mon,  3 Aug 2026 12:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785761751;
	bh=VeM/JSb+cZjUu85C37ZRPZIXpj3tHnty6cxGIIbJEKs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lK0XdPBwkyIH+5oPehXgsA3Bc1CZjyPrAc8zzN/5rXHEh6v9VKKxghxuTjIDLHxcq
	 2XkORTeYPF3lcB+ct9u/FH94IF5qf6HLD5jjfNFa0z7VUBiN3UkXaweminiRAJ79kM
	 O10+5IxGuh3ZhiCkSfiCc+lOUhzmxLb4SeaY5jvf3OFtdTJ5M1LAxHiM95L9up4ik3
	 JKufC8iVuqulMj+Z4ffCWB1NnH0Y2HkXMWza9d4+1lQsK4MYtLlwxSH3/1M4Xfunzl
	 ZOgLCdhJ62COEpXOf9Q42V7m5Z0PvfUkdl3AYsZXURvLjhD2RHaVEewlDANf/60P7v
	 ZA9iXPv4VR8BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 01/13] KVM: s390: Fix unlikely NULL gmap dereference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260803124040.126471-2-imbrenda@linux.ibm.com>
References: <20260803124040.126471-1-imbrenda@linux.ibm.com>
 <20260803124040.126471-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 12:55:49 +0000
Message-Id: <20260803125550.B05061F000E9@smtp.kernel.org>
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
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803124040.1264=
71-1-imbrenda@linux.ibm.com?part=3D1

