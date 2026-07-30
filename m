Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1102E3932D0;
	Thu, 30 Jul 2026 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785430955; cv=none; b=H6Ls4Wr+Nkf0c/x+0RNaDjQwTIV6ywGBYVQfGL4QJe8lKrlfFQx2tbFO4tPQScqlXsu3UXLVJFmxSfY8CWqvQh9MHQupRYHzYCQaneFWhIrqYTgV6X9LzK+q8T/isen7J7BU0VAkWoK0qj00sM6+eeqXh/LmmD2g356xF80Ak3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785430955; c=relaxed/simple;
	bh=QIICy8pjPT4+T+xmZH2iwZ9/GT4WnOPPv62RryrCxfI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pK2YqKLBKEpz0/treIFWUWEIUFK/IpAHGNcx5A/Ggx7IoNrZiWMlcnBMhALtdGuDH/BBOow12e6uuHYY5u/LjfEcnvX/+pnGy6cXrmOfiA+mIzZf01DhsPoDnSw4xuKcy4b8VFXPN76Cj2rHKNN9IlTFsdacHJCry3vlDuCI5KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRgb+n01; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRgb+n01"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E10F1F000E9;
	Thu, 30 Jul 2026 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785430953;
	bh=MIdZ7oObGB4jJEgS/Vj7nhr1Cdbr2U1exZZdkLXPKmI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fRgb+n01FofKfbtZTGJSfpRZ8j35exNA8Ofrs1AG6rSJRCs9s7JpW7Kr915T8pSNb
	 gDjuNQHg/Ew5xaQ0bST6NMAwqYTwKdlEyAX1tD17cLSZ/T6T+TB/Zv8971jgzFvyfN
	 +8erFmHoMIoe+K0rWftuCFznH9tmBnia1/PVJeYp6azY2vxCS3xgtOEuvW7mOlCVhd
	 CNRRp7iOPFtzBgkutpgEXo55BaGLVkMXvg7WpzEmceFwL2xhIlPqMXivEh0jPPRWL8
	 ZG6L4kfK2JKiiq5NGxf3F+formRTfWSezkhCTbFbYqlXbtvn+0/c4o5+Q1mQbfBBEV
	 t9H4OxxCkAnyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/14] KVM: s390: Fix kvm_arch_commit_memory_region()
 when low on memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260730162714.133327-14-imbrenda@linux.ibm.com>
References: <20260730162714.133327-1-imbrenda@linux.ibm.com>
 <20260730162714.133327-14-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 17:02:32 +0000
Message-Id: <20260730170233.5E10F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unprivileged userspace can trigger a host-side WARN_ON_ONCE via KV=
M_BUG_ON by exhausting memory cgroup limits.
--

--- Patch [13]: [PATCH v6 13/14] KVM: s390: Fix kvm_arch_commit_memory_regi=
on() when low on memory ---
commit c04a67c8bae206347441b13dff0d06941031c158
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix kvm_arch_commit_memory_region() when low on memory

When low on memory, kvm_arch_commit_memory_region() might not perform
the required action completely. The patch attempts to fix this by refilling
the MMU cache and retrying, using KVM_BUG_ON if it still fails.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index ba600c9488871..035476ec7fbc3 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -5862,11 +5860,17 @@ void kvm_arch_commit_memory_region(struct kvm *kv=
m,
>  		case KVM_MR_FLAGS_ONLY:
>  			break;
>  		default:
> +			rc =3D 0;
>  			WARN(1, "Unknown KVM MR CHANGE: %d\n", change);
>  		}
>  	}
> +	if (rc =3D=3D -ENOMEM) {
> +		rc =3D kvm_s390_mmu_cache_topup(mc);
> +		if (!rc)
> +			goto retry;
> +	}
>  out:
> -	if (rc)
> +	if (KVM_BUG_ON(rc, kvm))

[Severity: High]
Could this KVM_BUG_ON() be triggered by an unprivileged host-userspace
process exhausting its memory cgroup limit?

If kvm_s390_new_mmu_cache() fails to allocate memory (for example, due to a
memcg limit restricting its GFP_KERNEL_ACCOUNT allocation), the function ju=
mps
to the out label with rc set to -ENOMEM.

Passing this error to KVM_BUG_ON() executes a WARN_ON_ONCE. If the host has
panic_on_warn enabled, this would crash the system, potentially allowing a
host-side denial of service directly reachable from unprivileged userspace.

Is it possible to use pr_warn_once() or a similar logging mechanism here to
avoid assertions on userspace-driven inputs?

>  		pr_warn("failed to commit memory region\n");
>  	return;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730162714.1333=
27-1-imbrenda@linux.ibm.com?part=3D13
