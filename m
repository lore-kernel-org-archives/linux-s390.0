Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BDD397691;
	Thu, 23 Jul 2026 18:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784830972; cv=none; b=scMd69fkEMJGKMgcxPCPHtgeDAvy6Oh9cYm7TRofpgOPSvUTBVs8639xAOlzEJzTRIHhonaDHmmnGw2SFqSjC8SdLGLlOTtP7fthP46+mtP7lyYtUi9P2hilqD+qqaGM3ReG/hU0y30aKXHo/eGs6UbmNWhqCCG9/oO9gsOVxzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784830972; c=relaxed/simple;
	bh=exTejfTI6JRFI/wCcyFI+aPicdg3UHNbx5HCAsjDEYA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DdDBEaEqJJcg6JWAyYT2Q/h/YmsQ2+TB/dJoJG3r15QneY08bfLqiRksDM9DBKOVUQGC9+UmmvpePpZc8kvvGMqtyUsztSx+gZR4WTh0gUbh1JSr87AW+gkThUz+NzJ7nP8R0pQqJXUpD2+hKFQPoGHEtlztYqrCHGaLCMKJVKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D93B1F000E9;
	Thu, 23 Jul 2026 18:22:39 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: s390: Fall back to short-term pinning in MAP
 ioctl
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jaehoon Kim" <jhkim@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260723181017.1220552-1-jhkim@linux.ibm.com>
References: <20260723181017.1220552-1-jhkim@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:22:33 +0000
Message-Id: <20260723182239.0D93B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] A `WARN_ON_ONCE` can be triggered by an unprivileged host-userspac=
e process when dynamically pinning the summary page fails in `adapter_indic=
ators_set`, leading to a kernel panic if `panic_on_warn` is set (host-side =
Denial of Service).
--

--- Patch [1]: [PATCH v2] KVM: s390: Fall back to short-term pinning in MAP=
 ioctl ---
commit adf4c032c2e044456068d97afccf0c63cb5027de
Author: Jaehoon Kim <jhkim@linux.ibm.com>

KVM: s390: Fall back to short-term pinning in MAP ioctl

FOLL_LONGTERM pinning fails for some memory types, such as file-backed
guest memory. As a result, kvm_s390_adapter_map() returns -EINVAL and
irqfd adapter registration fails even though interrupt delivery could
still work via the existing non-atomic path. This patch adds a fallback
to short-term pinning to restore the previous behavior.

> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 9e3e6b0d72ad6..75eacd1578efa 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c

[ ... ]

> @@ -2929,8 +2954,12 @@ static struct s390_map_info *get_map_info(struct s=
390_io_adapter *adapter,
>  		return NULL;
> =20
>  	list_for_each_entry(map, &adapter->maps, list) {
> -		if (map->addr =3D=3D addr)
> -			return map;
> +		if (map->addr =3D=3D addr) {
> +			if (map->pinned)
> +				return map;
> +			else
> +				return NULL;
> +		}
>  	}
>  	return NULL;
>  }

[Severity: High]
This is a pre-existing issue, but since this change forces the fast path
to fall back to the slow path for unpinned entries, I have a question about
the fallback behavior in adapter_indicators_set().

When get_map_info() returns NULL, adapter_indicators_set() attempts to pin
the summary page directly:

arch/s390/kvm/interrupt.c:adapter_indicators_set() {
	...
	summary_info =3D get_map_info(adapter, adapter_int->summary_addr);
	if (!summary_info) {
		spin_unlock_irqrestore(&adapter->maps_lock, flags);
		summary_page =3D pin_map_page(kvm, adapter_int->summary_addr, 0);
		if (WARN_ON_ONCE(!summary_page))
			return -1;
	...
}

If an unprivileged host-userspace process configures an irq routing entry
with a guest physical address for the summary indicator that resolves to an
unmapped or dynamically unmapped host virtual address, pin_map_page() will
fail.

Could userspace intentionally trigger this WARN_ON_ONCE by unmapping the
address, potentially causing a host panic if panic_on_warn is enabled?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723181017.1220=
552-1-jhkim@linux.ibm.com?part=3D1
