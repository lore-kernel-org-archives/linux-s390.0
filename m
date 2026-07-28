Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76793AFCED;
	Tue, 28 Jul 2026 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259640; cv=none; b=CfLbGkaikKACYHs92SEyDyT0kCRzrMaKvimS3YLhsRRYs7jwa5IZgFiuYC0bfSls9VOhFLsB8l2afzZQaZMtNXq8Zgmc0uq3PTSx1YvGgPCfamXIBnMXMpmWqL+Uj7vflHo15bE/1pApfCd/6J2hIAugrOaoJvkE1q8kOAJ3Pio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259640; c=relaxed/simple;
	bh=BxDoQS4Zxvxz0zkCpEYkhuu5+K9FdxslyhvYQwmM0q4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=STvgN/CDG3NXh9gwBnb+GI3vAFnZX+9JL8z3fK2AJ6bjqErLzKP5Ha1Th7EQeGI7xkXkcebNfTvvuuUwJisb5VklXLDWpwX8h9S+POaAaywfZl6xwhMcToh3hoE8pBs7nmILkXHxA88p/Cnys+96jxV3LqQNEyW2smq9YjIfT0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTnYrqyJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTnYrqyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136481F000E9;
	Tue, 28 Jul 2026 17:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785259639;
	bh=BxDoQS4Zxvxz0zkCpEYkhuu5+K9FdxslyhvYQwmM0q4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YTnYrqyJjNux0MU87FDCWDKuwPYp67KVZ+LMy1kbZ3FqmI7avgq6vmWAQVf5jC2HY
	 WgcJ6iNdS9Rpg/QDEWXxgdSrDyeOIYAiselbtXLvDBZVR+Y26d+Sg/mPzaW3t/aM0a
	 WrqVU5rSMhOsDwNrnUnDXLpp0SqIq+R83X1jNkxFWwrn0vVyHUx9LnKRu/gkRfdj+g
	 S8PS+HbMnAwQAosUNf/kO6Ekv/w1n5B1+n4lQBZ2ZUd1zqWmp/sCNYL5/tOZ66zX53
	 A0OegogotIm3tT7q5izMjklaJmZvmzuH95ibzUF6CivML9+wKRh7SHcgD+XFVUTkmt
	 AxpLYyKjUv01g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/13] KVM: s390: Fix unlikely NULL gmap dereference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260728170708.294400-2-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
 <20260728170708.294400-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:27:18 +0000
Message-Id: <20260728172719.136481F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728170708.2944=
00-1-imbrenda@linux.ibm.com?part=3D1

