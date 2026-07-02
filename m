Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D159133AD8B;
	Thu,  2 Jul 2026 15:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006643; cv=none; b=SExp7j6HYKtl1BM+JTeESUqm835ODqfSErK4vb1NtpOa4KJnv5q/7fUVQwZyVoUMqMobe9yYC/b/G0iEp4laCNwu/1YrxpPTZhkm2Bs7dyuuIHdDRYa8NGhBXN0+b8zj2qO+sV1T8vnstb6LIKwsgS6PL6TrMuZMrynUbsX3GWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006643; c=relaxed/simple;
	bh=fJVyZh0pvJag5lWYALfj+g9cKsqC+eiPscvf5q6mzR8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eA92TrXmOXAHekfO+pq0XtoSvFowUKOaNpRP4jwiAF+BViruhftRi7KVAFd/h1pxhgeo+GOGFGPKNutykTjEY0VDb0mxG4OuNay0TdS2x67mKmqmSu/eyKNy+mvs5kYwsNf+EjTHVMhrlb9QdkU9Ad8z5IX/LYz7YuQJWtiJ4QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdxIb0dX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdxIb0dX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4320C1F00A3A;
	Thu,  2 Jul 2026 15:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006642;
	bh=GXmDdv4L21lQ3apq/yJWEsYwmxeG2HVUovxgQkU0bjY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QdxIb0dXdn3J1eKJQJTFks9q+DCwlPHr8xA7/ybLXwp5lHttgeeb6hvMaSkzbQc/h
	 jbEAPC1tnM5MAvhLHDcE/6/NOmRAZwUaj7cGCvLEBR41JcumqVurtRVpKBTgpwiPwd
	 dp2yL0v37bx6VXYAK6k93t+PYLw/uLdvVz6T8jELb1PilLoIEsWzgyG7gf+C0HOVrc
	 XnEzt918lrh94Pxs0LRR/wAi9Lqr8BZ0fkVVpt5efeHlpFBfMFVae1rjwK9zlYmWTh
	 FPQjBZAD9ZXz4luL9a7ER+DXGFdPC7qH07eKYmuajLYwJ73LrClJdXDhjA5Y321ACS
	 4T7UpOXKTzixg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/8] KVM: s390: Fix return value of
 kvm_s390_set_cmma_bits()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260702152406.204782-5-imbrenda@linux.ibm.com>
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
 <20260702152406.204782-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:37:21 +0000
Message-Id: <20260702153722.4320C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Leaked positive error codes (e.g., PGM_ADDRESSING) to userspace in=
 KVM storage key ioctls.
--

commit 9e2ad138adcf0c89db7df7095fa7b5199afab279
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix return value of kvm_s390_set_cmma_bits()

If kvm_s390_set_cmma_bits() is asked to set CMMA values outside of a
memslot, PGM_ADDRESSING (5) is returned, instead of a negative error
value. Fix by returning -EFAULT whenever the return value would be > 0.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2384,7 +2384,7 @@ static int kvm_s390_set_cmma_bits(struct kvm *kvm,
> =20
>  	set_bit(GMAP_FLAG_USES_CMM, &kvm->arch.gmap->flags);
> =20
> -	return r;
> +	return r <=3D 0 ? r : -EFAULT;

[Severity: High]
This isn't a bug introduced by this patch, but since you are fixing the
leaked PGM_ADDRESSING error code here, should we also fix the same issue
in the storage key ioctls?

If userspace calls KVM_S390_GET_SKEYS or KVM_S390_SET_SKEYS with an
out-of-bounds guest address, do they also return the positive error code
directly?

arch/s390/kvm/kvm-s390.c:kvm_s390_get_skeys() {
    ...
    r =3D dat_get_storage_key(kvm->arch.gmap->asce, args->start_gfn + i, ke=
ys + i);
    if (r)
        break;
    ...
    return r;
}

arch/s390/kvm/kvm-s390.c:kvm_s390_set_skeys() {
    ...
    r =3D dat_set_storage_key(mc, kvm->arch.gmap->asce, args->start_gfn + i=
, keys[i], 0);
    if (r)
        break;
    ...
    return r;
}

Furthermore, for KVM_S390_KEYOP, does it falsely report success and assign
the error code to the output key?

arch/s390/kvm/kvm-s390.c:kvm_arch_vm_ioctl() {
    case KVM_S390_KEYOP: {
        ...
        r =3D kvm_s390_keyop(mc, kvm, kop.operation, kop.guest_addr, skey);
        ...
        if (r < 0)
            break;

        kop.key =3D r;
        r =3D 0;
        ...
}

Should these functions also be updated to return -EFAULT for positive error=
s,
just like kvm_s390_set_cmma_bits() does here?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702152406.2047=
82-1-imbrenda@linux.ibm.com?part=3D4
