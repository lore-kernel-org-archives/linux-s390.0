Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B033914E1;
	Thu, 30 Jul 2026 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430206; cv=none; b=A6jIf7cnB1BDfbhmyijvpfXNM/Azt1Pj2xmyMPrkuTeBnikTEQlzhxsNcc+03CkpHq2w2cM8gcVISFX2Dqfi/KjpT9m+7fuQHFSMdx54AKW9aGBmtPENAqNL9LURfUd+fH150Qsvz3xVaFg2aZEbjQc7J0xYE9KukR5PbRL7PDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430206; c=relaxed/simple;
	bh=m93g6I7ntTUxcw6TmZwpTUOBHHF4AKF8m/dzViprECg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gI7fI+i6tv5ZGFhXkpbMCtJVM2vQKTbpkNR1cJzp9XEUywuFiS3CMYa6dYsVHLNVdEHiPueSmW6MT0Kx7BdWzAZBlkFNvL6zewuZ+hyEEFxG8WluYg9PivNP0Xg0SFkcNYIazFRLl14CEmpzXz6/a3OAVZCnATeEZsLYAGIU7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQ4MuLra; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQ4MuLra"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FC471F000E9;
	Thu, 30 Jul 2026 16:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785430205;
	bh=4jQJ9rHRA1BVNQaDcmCuU7PQ4/iGLsDdf6Uyusrj8og=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hQ4MuLra6eZH3QoRUGZsyNmZlsuuOCagDGUWmbJ8lnnREccBpsPaLgxAoZ1Fe2nPA
	 qe4NSWgb2+E9Nw78yJ8NdcZ9vd27bLnBKo1F/EjQ1zfaDWnDD1yvjFwV7r0SO1rLYm
	 pgqLJmx8ib/ain/Af7J2VXTk0Yyx11h47AGN2F6BSZ72KK51YYN0nb10rMNd2//5F8
	 bpnUWFKhf0ivnm0lIqFupMQ7LigtZw/kUqWbR68kurZJeMWzj4ZXvcJcAOfvKhMn8/
	 XvHSFsqGwkdxmO+0CLlgCHofIo07yUmWeRG0DWU2Yb89hZuYyNthWjI8sAptGRS1xD
	 +LyOtEE0J+1GQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/14] KVM: s390: Fix unlikely NULL gmap dereference
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260730162714.133327-2-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
 <20260730162714.133327-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 16:50:04 +0000
Message-Id: <20260730165005.0FC471F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The patch implements an architecture-specific workaround to fix =
a generic KVM race condition instead of addressing the root cause by deferr=
ing fd_install().
--

--- Patch [1]: [PATCH v6 01/14] KVM: s390: Fix unlikely NULL gmap dereferen=
ce ---
commit 403acc4eca694d221f980de53cd9d5235694b0bf
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix unlikely NULL gmap dereference

This commit fixes a race condition where a malicious userspace program
can start a newly created vCPU before kvm_arch_vcpu_postcreate() finishes.
It resolves this by tracking the initialization status with a new flag.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 150b5dd2170e2..f86b4b0b356f4 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -3613,6 +3613,9 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>  	if (test_kvm_facility(vcpu->kvm, 74) || vcpu->kvm->arch.user_instr0 ||
>  	    vcpu->kvm->arch.user_operexec)
>  		vcpu->arch.sie_block->ictl |=3D ICTL_OPEREXC;
> +
> +	/* Pairs with smp_load_acquire() in kvm_arch_vcpu_ioctl_run() and kvm_a=
rch_vcpu_ioctl() */
> +	smp_store_release(&vcpu->arch.initialized, true);

[Severity: Medium]
Could this regression be addressed in the generic KVM code rather than
adding an architecture-specific workaround here?

The race occurs because virt/kvm/kvm_main.c:kvm_vm_ioctl_create_vcpu()
exposes the file descriptor to userspace before postcreate completes:

virt/kvm/kvm_main.c:kvm_vm_ioctl_create_vcpu() {
    ...
    r =3D create_vcpu_fd(vcpu);
    ...
    kvm_arch_vcpu_postcreate(vcpu);
    ...
}

Since create_vcpu_fd() installs the file descriptor, userspace can
immediately guess or observe the fd and race to call KVM_RUN or other
ioctls while kvm_arch_vcpu_postcreate() is still running.

Could we fix this generically by splitting anon_inode_getfd() into
get_unused_fd_flags() and anon_inode_getfile() during fd creation,
and then deferring fd_install() until after kvm_arch_vcpu_postcreate()
completes?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730162714.1333=
27-1-imbrenda@linux.ibm.com?part=3D1
