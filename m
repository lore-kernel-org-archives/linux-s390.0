Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EED382371;
	Wed, 29 Jul 2026 18:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785351198; cv=none; b=eUwZ4VgiC1Fl33UgrfQlFcL6iRKIwybYXd9UD+jDLVMCFr+dDy3gfjMhkZNB0tAj/v7tVUNyYhRy6ydYFbdRTUYtoOw64cRwSGnE64SD/dUlOGMvZ+wDNTmrQHo/F2mHWsQvbI53kpWxAk9jUg9vWlT7Yw7Mf4GYTFgWT5UeaIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785351198; c=relaxed/simple;
	bh=/6MUFfYL1sZQ3ZRRDeG4jK3QVt5PoNs4RmkEBf1cAME=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hiEScKh9ttCuMJGY9UUBeGYzJte/JpLo+qXOu5LiFrBDrqdeRo9BEWOLgn2GSxS2mMmpdVz9ntNiz99CbHh9mdWaGOMFky79NSxGQAX/WmxHne6cZ8FgLLyta9iMDFs+ztuvsSKEN5OCwGf3De6wTNpJv+gRhEd1WAFL43pyPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7CJF7AS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7CJF7AS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173BE1F000E9;
	Wed, 29 Jul 2026 18:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785351197;
	bh=070WhWz00rM9Pi+Apzi6vg4A4aLpPWJ42+a3DVjm6mc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m7CJF7ASP8uAS6jczdwuFuGuT8NFwlK8aVpg+98RMLHcpMXWHtrcFP8mSnVfOJRHs
	 zlqJiMbQP2AaVaACmkKTI6ZjalltKeWoXVYIjg8iOPbugKYy8GQbsXxCtN+x8sBlDL
	 +zyY9A7TBOofcgC2/9kMGtXgYM8Js8u7i7wK5WCtR9OF82RtjeHQpTJrLPbe/jdiDy
	 UgAElgiuV4lXRSlG/5PhABtbV7RnXS2kxGklefWH1/Oxa1ty9OqYv8WQSUm12KxzRg
	 NHB+f5z2mWmA8Pqh/oBRALgobYLYogDSn0a5+cctmwReyeYsy0XBhi5NVcm6YGJybn
	 O7bPL1AwLPh2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 13/13] KVM: s390: Fix kvm_arch_commit_memory_region()
 when low on memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260729152938.782383-14-imbrenda@linux.ibm.com>
References: <20260729152938.782383-1-imbrenda@linux.ibm.com>
 <20260729152938.782383-14-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 18:53:16 +0000
Message-Id: <20260729185317.173BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Dropping `kvm->mmu_lock` and retrying allows guest page faults=
 to populate page tables that are subsequently freed by `dat_create_slot`, =
destroying guest ESSA state and leaking `cmma_dirty_pages`.
- [High] The patch introduces a host-userspace-reachable KVM_BUG_ON() which=
 triggers a WARN_ON_ONCE, allowing unprivileged users to spam the kernel lo=
g or crash the host if panic_on_warn is set.
--

--- Patch [13]: [PATCH v5 13/13] KVM: s390: Fix kvm_arch_commit_memory_regi=
on() when low on memory ---
commit 4801c2be100c4b8f582c02a4637cf4703c366817
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix kvm_arch_commit_memory_region() when low on memory
   =20
This commit updates the out-of-memory handling in
kvm_arch_commit_memory_region(). It refills the kvm_s390_mmu_cache and
retries the operation, and warns and kills the VM if the refill fails.

> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -5822,7 +5822,7 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
[ ... ]
>  	mc =3D kvm_s390_new_mmu_cache();
> -	if (!mc) {
> -		rc =3D -ENOMEM;
> +	if (!mc)
>  		goto out;
> -	}
> -
> +retry:
>  	scoped_guard(write_lock, &kvm->mmu_lock) {
[ ... ]
>  		default:
> +			rc =3D 0;
>  			WARN(1, "Unknown KVM MR CHANGE: %d\n", change);
>  		}
>  	}
> +	if (rc =3D=3D -ENOMEM) {
> +		rc =3D kvm_s390_mmu_cache_topup(mc);
> +		if (!rc)
> +			goto retry;

[Severity: Critical]
Does dropping kvm->mmu_lock between the scoped_guard exit and the goto
retry allow concurrent guest page faults?

If a guest vCPU faults on an address in the new memslot during this
window, it could populate a page table and execute ESSA instructions.
When kvm_arch_commit_memory_region() restarts dat_create_slot() after
re-acquiring the lock, could it blindly replace the now-populated CRSTE
and free the new page table without cleaning up the atomic counters?

Looking at dat_create_slot(), it appears that it replaces the CRSTE and
frees the lower-level page table:

arch/s390/kvm/dat.c:_dat_slot_crste() {
    ...
		/* A lower level table was present, needs to be freed. */
		if (!crste.h.fc && !crste.h.i) {
			if (is_pmd(crste))
				dat_free_pt(dereference_pmd(crste.pmd));
    ...
}

Could this regression result in the loss of guest state and leak
cmma_dirty_pages?

> +	}
>  out:
> -	if (rc)
> +	if (KVM_BUG_ON(rc, kvm))

[Severity: High]
Can this KVM_BUG_ON be triggered by an unprivileged host userspace
process?

If a process in a restrictive memory cgroup invokes the memslot ioctl,
kvm_s390_mmu_cache_topup() could fail with -ENOMEM, passing the error to
this path. Since KVM_BUG_ON internally executes WARN_ON_ONCE, could this
allow a malicious host-userspace process to spam the kernel log or
trigger a crash if panic_on_warn is set?

>  		pr_warn("failed to commit memory region\n");
>  	return;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729152938.7823=
83-1-imbrenda@linux.ibm.com?part=3D13
