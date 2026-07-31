Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7169930C171;
	Fri, 31 Jul 2026 13:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506180; cv=none; b=jjcvISl1AkvKT2y+PR6SKqt7q3U28YSWXtYzaGqGF06oWHlgaR2NnRoJ2IR1Ous95l6hL33KqmbEiaZ0tjdisSdm2eMADbU/lD4GpT8EdGk8Zg38EnUYX4TrVMbKYmg4j3H9CKpZR1oOiHKdtDlJUNCjwobQeIojaOb8iP2d3AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506180; c=relaxed/simple;
	bh=1lc3bLl8t7+sL6SsnYkRrJmR7S/J493+qvp68IRS+70=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dX8w3sOoFaecKPmz6UjKn5BvtwAPITTRALMMIlazXtEhaASFJM8LLd4tlpw6NXaFXFjcpI/F23bssIH3q9x+aneQ6gjc148WIAA8pRCdFBWu6OQghrCU7t4cXxzucjDWPQUXhNHLvVUmIkd8T39H7yIcBlEjck7wyYzFP+QBfv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJvbqYAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJvbqYAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE701F00A3A;
	Fri, 31 Jul 2026 13:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785506179;
	bh=PHSMQTOcSjHEJKFBsPIEs5jxQJt3zgXCwzvEb9G+4CA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hJvbqYAQBVDRHWX1JczY+r9jDrn8OJ8462oGenxGl5ZFaEhoR5XSSzQGaEqY4CF/n
	 WshIPfwof02Q0knZ4XC2TEzJHI8Zb7MEFPszwIsBcuBZdqWpvjznnAX1U0gOywwl2W
	 7VjNzTPKrpN9aVKsB7r4107ye9BPmcPI0pKlXy1JJlGIiuYF8Va0VMimBM+9iis5MK
	 iipFg/hJIIfmk5sz2zXaxeStOpb7epwR5QHMpuG0YZEvUKPlvdKVdKkXdSuFMhdTBD
	 EdpVzu8UNeyKJzrkwyVPGVBWD9P8JDnhq9TJK7NyB+/5r0t1DogvMIeg5oOONRtIpu
	 6KSkMqhsvBZUQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/31] KVM: s390: gmap: Move storage key and CMMA
 code to kvm/s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Marc
 Zyngier" <maz@kernel.org>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260731130902.654679-19-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-19-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:56:18 +0000
Message-Id: <20260731135618.9DE701F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] CMMA and storage key function declarations were not fully extracted=
 from generic gmap headers.
--

--- Patch [18]: [PATCH v5 18/31] KVM: s390: gmap: Move storage key and CMMA=
 code to kvm/s390 ---
commit bde63a0d30be0c82cba34cb31a22562bc02b69e0
Author: Steffen Eiden <seiden@linux.ibm.com>
Subject: KVM: s390: gmap: Move storage key and CMMA code to kvm/s390

This commit extracts storage key and CMMA functionality from kvm/gmap to
kvm/s390. This enables other KVM implementations to use gmap without
implementing s390-specific storage key or CMMA handling.

> diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
> --- a/arch/s390/kvm/gmap/dat.h
> +++ b/arch/s390/kvm/gmap/dat.h
> @@ -532,13 +532,6 @@ int dat_entry_walk(struct kvm_s390_mmu_cache *mc, gf=
n_t gfn, union asce asce, in
>  void dat_free_level(struct crst_table *table, bool owns_ptes);
>  struct crst_table *dat_alloc_crst_sleepable(unsigned long init);
>  int dat_set_asce_limit(struct kvm_s390_mmu_cache *mc, union asce *asce, =
int newtype);
> -int dat_get_storage_key(union asce asce, gfn_t gfn, union skey *skey);
> -int dat_set_storage_key(struct kvm_s390_mmu_cache *mc, union asce asce, =
gfn_t gfn,
> -			union skey skey, bool nq);
> -int dat_cond_set_storage_key(struct kvm_s390_mmu_cache *mmc, union asce =
asce, gfn_t gfn,
> -			     union skey skey, union skey *oldkey, bool nq, bool mr, bool mc);
> -int dat_reset_reference_bit(union asce asce, gfn_t gfn);
> -long dat_reset_skeys(union asce asce, gfn_t start);
> =20
>  unsigned long dat_get_ptval(struct page_table *table, struct ptval_param=
 param);
>  void dat_set_ptval(struct page_table *table, struct ptval_param param, u=
nsigned long val);

[ ... ]

>  int dat_set_prefix_notif_bit(union asce asce, gfn_t gfn);
>  bool dat_test_age_gfn(union asce asce, gfn_t start, gfn_t end);
> =20
>  int dat_perform_essa(union asce asce, gfn_t gfn, int orc, union essa_sta=
te *state, bool *dirty);

[Severity: Low]
Does this commit fully extract CMMA functionality from the generic headers?

It appears that while the implementations were moved to kvm/s390, several C=
MMA
function declarations like dat_perform_essa() and dat_reset_cmma() were left
behind in arch/s390/kvm/gmap/dat.h.

Since the stated goal is to decouple these subsystems so other KVM
implementations can use gmap without s390-specific handling, shouldn't these
prototypes also be moved out of the generic headers alongside their newly
relocated implementations?

> diff --git a/arch/s390/kvm/gmap/gmap.h b/arch/s390/kvm/gmap/gmap.h
> --- a/arch/s390/kvm/gmap/gmap.h
> +++ b/arch/s390/kvm/gmap/gmap.h
> @@ -100,10 +100,9 @@ int gmap_ucas_map(struct gmap *gmap, gfn_t p_gfn, gf=
n_t c_gfn, unsigned long cou
>  void gmap_ucas_unmap(struct gmap *gmap, gfn_t c_gfn, unsigned long count=
);
>  int gmap_enable_skeys(struct gmap *gmap);
>  int gmap_pv_destroy_range(struct gmap *gmap, gfn_t start, gfn_t end, boo=
l interruptible);
>  int gmap_insert_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn=
_t p_gfn,
>  		     gfn_t r_gfn, int level);
>  int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gf=
n_t p_gfn, gfn_t r_gfn,
>  		      kvm_pfn_t pfn, int level, bool wr);
> -void _gmap_set_cmma_all(struct gmap *gmap, bool dirty);
>  void _gmap_handle_vsie_unshadow_event(struct gmap *parent, gfn_t gfn);

[Severity: Low]
Are there duplicate or leftover declarations here?

While gmap_enable_skeys() was correctly duplicated into
arch/s390/kvm/s390/s390.h where it is now implemented, it seems the original
prototype was not removed from arch/s390/kvm/gmap/gmap.h.

Leaving it here continues to unnecessarily expose s390-specific storage key
operations through the generic gmap headers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D18
