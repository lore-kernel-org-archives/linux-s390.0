Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8463988EB;
	Thu, 23 Jul 2026 22:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845846; cv=none; b=oX7ZFslYfovdHSGoRhjHHhDzp7RcRdJkTjojbO4zohpcOBdKdSoF8hyffY/ysN1tSBFhe3cMpAeGi4LBaZX8yUCA2WBEnq53X0DA2h+AG4/hZJohYu96q1VUCu+QmqukIISG3L+jYj8rVop3GlYeOggahuz3LM2sYqXc9dU2iJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845846; c=relaxed/simple;
	bh=9hqWo0LuxB60JHKmFntZ+6bdYArhfHmAiSyJ1V5DaKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J9PltE1i92xCo57EtY4ScC0wrIaFoWNxP08LBUNn06zCQjYYlfFbIEAp7wwiUlUrqub19lyrItgJ5nwcrxOg1J0an79JzJVYOwDKWLJCS683L3v7WPQ3QrZtX8IelcCBu73qpN8iYEUdQgxIJA/LF0coSNRFEGhCK9B+i+KyAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ewhoi20y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ewhoi20y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147021F000E9;
	Thu, 23 Jul 2026 22:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784845845;
	bh=6Y6Az2ofB9SdnKK8Yr9pRo1I7G0xl8fMOKFNDKrydes=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ewhoi20ynM0yy+44GbipGGWHy3hFb1ZMfsLcDOkHBcecKU4joNjz+mOg1nq4cjChQ
	 iXghsYobJ+TEA7AyqpDteVaON6kR/J9K6RGeottiFtuwTWXY5tXBVUmc9l0G+TVgJi
	 yipAusahqnMjYO/DfkKMzr4HdYK13TUx080S9bdHThEZJZRZ2HnZylYd332d9cIuH0
	 3wAwLaSbH7Ka/jUJKHOlA20s0YatZ16a7snTng/4UNV+0z0TVzwlqXGzxWXikMsLmn
	 2rXSem7+z0m+PujccTyN/KuA2vuYy2s5cq/y5YicV5nz5SC/brDv7+ThfTaBJ6Q3aL
	 zez3dDAvyPpQQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/6] KVM: s390: pci: Fix missing error codes and
 memory unaccounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260723221409.5874-4-alifm@linux.ibm.com>
References: <20260723221409.5874-1-alifm@linux.ibm.com>
 <20260723221409.5874-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:30:44 +0000
Message-Id: <20260723223045.147021F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Concurrent execution of KVM_S390_ZPCI_OP ioctl and PCI device hot-=
unplug leads to Use-After-Free of zdev.
--

--- Patch [3]: [PATCH v6 3/6] KVM: s390: pci: Fix missing error codes and m=
emory unaccounting ---
commit 1ca75882cbc64513fea8b4f11f208e8914e5eb06
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Fix missing error codes and memory unaccounting

In kvm_s390_pci_aif_enable() two error paths failed to set an error code,
causing the function to return 0 on failure. It also failed to rollback
memory accounting on failure. Fix both by propagating an error code on
failure and calling unaccount_mem() in the cleanup path.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 44c00e5e32c57..f58d7ec0bc7ec 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c

[ ... ]

> @@ -351,6 +354,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *z=
dev, struct zpci_fib *fib,
>  	return rc;
> =20
>  unlock:
> +	if (pcount > 0)
> +		unaccount_mem(zdev->kzdev, pcount);
>  	mutex_unlock(&aift->aift_lock);
>  unpin2:
>  	if (fib->fmt0.sum =3D=3D 1)

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
involving the zdev pointer in this file.

When userspace calls the KVM_S390_ZPCI_OP ioctl, kvm_s390_pci_zpci_op()
fetches zdev from get_zdev_from_kvm_by_fh():

arch/s390/kvm/pci.c:get_zdev_from_kvm_by_fh() {
	list_for_each_entry(kzdev, &kvm->arch.kzdev_list, entry) {
		if (kzdev->zdev->fh =3D=3D fh) {
			zdev =3D kzdev->zdev;
			break;
		}
	}
	spin_unlock(&kvm->arch.kzdev_list_lock);

	return zdev;
}

The zdev pointer is returned without taking a reference count. If the ioctl
thread is preempted, and the physical PCI device is removed concurrently
(hot-unplug), the PCI subsystem could drop the last reference to zdev and
free it via kfree_rcu().

After the RCU grace period, the ioctl thread would resume and attempt to
lock the freed memory:

arch/s390/kvm/pci.c:kvm_s390_pci_zpci_op() {
	zdev =3D get_zdev_from_kvm_by_fh(kvm, args->fh);
	if (!zdev)
		return -ENODEV;

	mutex_lock(&zdev->kzdev_lock);
	...
}

Does this sequence allow a use-after-free if the device is removed while
the ioctl is executing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723221409.5874=
-1-alifm@linux.ibm.com?part=3D3
