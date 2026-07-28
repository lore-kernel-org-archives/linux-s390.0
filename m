Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E623A75B6;
	Tue, 28 Jul 2026 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259539; cv=none; b=cKIcD1dEzN1W+P2QtuRpnhVwXoAnLiXiWhFw9+GVjjTVxnMnOFsV0kOzPWRQK0JaX4eFW/cYovUdQczwIoLg6jaBxnwbXwHI3r0P7T8ZYKFCHAwlnQk/bHQo+KZeiKB0r5cbufY2iwzAQSuEsaDZ34nhNnuWyGwWvBvcbNKA52w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259539; c=relaxed/simple;
	bh=J+fe8oMvpNufqTFyZibH3lMwf2OYmKxp+mHNHujU1vo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HGwyIas0+sFIqT997xcy23yzt/6F4FNXRXELmYSgx4IV+UqBxkX6UVjbObnfoAARpVhRu1SgIV/7kZW/MYdUz6kTCJXFOLS4YHJd+42dCo4qMS6ojzqY8l0oR9g91TPY7Co4WtSmILNIU89dvlAGsjLKvFj2TV0knnSxHT7QUFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/uydPeY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/uydPeY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9832C1F000E9;
	Tue, 28 Jul 2026 17:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785259537;
	bh=GVF+6/FpMmNQOLETJYYbnRoOe+zrVwOpiDKNL8+ixNQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m/uydPeYAXd4lJ7893jP7LH2kE9oYhn8kWAJuAY8SLMKyn5bRMoE3iSTc90UFlT69
	 1V8RITTaHbi5jSnx7d80NyrPf2jSXOs8v0nyyCK0yr6BjtztzD3R0N79kB0FLuWzmE
	 ubKIiNm22e8BlMh9S3vQbl2XvDzMG0JpGqLV5KRiY563jYXm6vRQpvEmIDZ2xk0JQO
	 QTP+JVAxSiVQjUFTHsywRuVg+RjYyXnGGQSXybOw8gwkd+LFOytBmnbdnSsFD2i40l
	 VlEVbZj73vnsitZGHxP8cX4DIlOa48eIp+KRpHaw1gUw3e9wwEAurIxQUluAbdHdPZ
	 DofORP3AHE2OQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/13] KVM: s390: Fix kvm_arch_commit_memory_region()
 when low on memory
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260728170708.294400-12-imbrenda@linux.ibm.com>
References: <20260728170708.294400-1-imbrenda@linux.ibm.com>
 <20260728170708.294400-12-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:25:37 +0000
Message-Id: <20260728172537.9832C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] User-triggerable KVM_BUG_ON (WARN_ON_ONCE) on memcg OOM.
--

--- Patch [11]: [PATCH v4 11/13] KVM: s390: Fix kvm_arch_commit_memory_regi=
on() when low on memory ---
commit 9bd2f3fe880640681d24faea9af3bd26f006d538
Author: Claudio Imbrenda <imbrenda@linux.ibm.com>

KVM: s390: Fix kvm_arch_commit_memory_region() when low on memory
   =20
When low on memory, kvm_arch_commit_memory_region() attempts to refill
the MMU cache and retry. If the refill fails, it kills the VM using
KVM_BUG_ON.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -5850,11 +5848,17 @@ void kvm_arch_commit_memory_region(struct kvm *kv=
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
Could this KVM_BUG_ON() be triggered by a host-userspace process facing
memory pressure?

If an unprivileged userspace process creates a VM within a restricted memory
cgroup (memcg), and then calls KVM_SET_USER_MEMORY_REGION to modify a
memslot, kvm_s390_mmu_cache_topup() could return -ENOMEM due to the memcg
limit.

Since KVM_BUG_ON expands to WARN_ON_ONCE, wouldn't this allow a malicious
guest or unprivileged host process to cause a host-side denial of service
if panic_on_warn is enabled?

>  		pr_warn("failed to commit memory region\n");
>  	return;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728170708.2944=
00-1-imbrenda@linux.ibm.com?part=3D11
