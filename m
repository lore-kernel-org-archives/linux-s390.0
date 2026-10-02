Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9F8470456
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932409; cv=none; b=hBQfSI4QE2Uj0t7mDVehpmfdosSdAyhnJhCRQHQnoj+ZrsKqqNV8LYwhjffABVoJDGkPTVQgJAPUvDsTsz6PzeVDYVp+cN9kpsBNJSrOOdCJlvhN+QjVeDpfYKawsxnUyoRguQU8ya8t27IxEDtKFyHnGF9y9hbhIaq2k6lj9fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932409; c=relaxed/simple;
	bh=lUKg20weJ5YH0/T+RDTNlB8YlYEQWuGNyMNEPoRt6Ek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YPqznUaJBCLNeZq5nRy5HPsiDJ5MNt2QXKzLvJRzdoCYKXcBjAqsXudK4osi/4Z8kx4JuB/BnUeTk9QhgJnJqn/jYcJE08cK9wCErwz0Qhn8vH6Hr5PIBB1V1E6AIgkcA7YEPEJQdn4+ymJdEU+QaNy4lSuX0LucNyKJQlQKp1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Og5wjgNF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Og5wjgNF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F173F1F00899;
	Fri,  2 Oct 2026 09:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932408;
	bh=o7md0252Q93rVkqy4a4q1vzln/OIOOPyUpKs9GHTeFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Og5wjgNFgTWLhGmenUHtLFmxyvAKmk6GVwTyMVDa5naqkxMCrkTa53R0fd93m3CyM
	 smtd8VCXZjbri4qlW/lo1r7Do7ZFeraHFyj1FjMZ3b0M4qxs+L6ETxJWucoGB7wkwf
	 AZMK9KqdwAMpDMY9lp4zinqk3+F5y+dFhL/g6jB06IF2tddnJDn7ZO50Ired+EO81h
	 f3gMU/iA9M9LAYebThP34oSIlXUfceDkSxx+ugKldf+Y0I/rPyFUmc/jljnJvC7HT6
	 uivQE+vRuKPgY8TM99IPQsu1DePn+PTwNG3Oo6wxR3AbuYU4cJQ+nXOWQS2FJwp1Rg
	 mn/gRDC4q1kRg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 11/13] lib/sbm: Add helpers to allocate, set,
 clear, and traverse the bits on sbm
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261001192849.74788-12-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-12-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:27 +0000
Message-Id: <20261002091327.F173F1F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] sched/fair: out-of-bounds memory corruption in __sbm_op() during C=
PU hotplug
- [High] lib/sbm: premature decrement of max index in free_sbm_index() hide=
s active CPUs
- [Low] lib/sbm: sbm_alloc() massively over-allocates cacheline-aligned mem=
ory
--

commit 8d84c933216fc8041e9a487dfb8a2121359eb99f
Author: Peter Zijlstra <peterz@infradead.org>

lib/sbm: Add helpers to allocate, set, clear, and traverse the bits on sbm

This commit introduces a set of helpers to allocate a sparsebitmap (sbm)=20
structure based on architecture-configured lengths. It provides macros and=
=20
inline functions to set, clear, test, and iterate over bits in the sbm arra=
y.

> diff --git a/include/linux/sbm.h b/include/linux/sbm.h
> --- a/include/linux/sbm.h
> +++ b/include/linux/sbm.h
[ ... ]
> @@ -9,12 +11,95 @@
> +#define __sbm_op(sbm, func)				\
> +({							\
> +	int idx =3D sbm_cpu_to_idx(cpu);			\
> +	int nr =3D idx >> __sbm_shift;			\
> +	int bit =3D idx & __sbm_mask;			\
> +							\
> +	func(bit, &sbm[nr].bitmap);			\
> +})

[Severity: High]
Can this sequence lead to out-of-bounds memory corruption during CPU
hotplug?

When a CPU is brought offline, free_sbm_index() sets its index to -1.
If the dying CPU continues to run the idle task to tear down, it can
trigger tick_nohz_idle_stop_tick() and consequently call sbm_cpu_set().

Because __sbm_op lacks bounds checking on the mapped idx, computing
idx =3D -1 results in nr =3D -1, which then unconditionally executes func()
on &sbm[-1].bitmap.

> diff --git a/lib/sbm.c b/lib/sbm.c
> --- a/lib/sbm.c
> +++ b/lib/sbm.c
[ ... ]
> @@ -45,6 +51,44 @@ int sbm_idx_to_cpu(int idx)
[ ... ]
> +struct sbm *sbm_alloc(void)
> +{
> +	return kzalloc_objs(struct sbm, sbm_max_threads_per_instance * sbm_num_=
instance);
> +}

[Severity: Low]
Does this code allocate significantly more memory than needed?

Each struct sbm encapsulates a full bitmask that accommodates
sbm_max_threads_per_instance CPUs. Since the index calculation
nr =3D idx >> __sbm_shift directly corresponds to the leaf index, the
array only seems to require exactly sbm_num_instance elements.

Allocating sbm_max_threads_per_instance * sbm_num_instance elements
appears to request considerably more cacheline-aligned memory than is
actually necessary to map all bits.

[ ... ]
> @@ -127,6 +173,15 @@ void free_sbm_index(int cpu)
[ ... ]
>  	if (find_first_bit(&__sbm_idx_metadata[leaf].allocated_mask, BITS_PER_L=
ONG) =3D=3D
>  	    BITS_PER_LONG)
>  		__sbm_idx_metadata[leaf].instance_id =3D -1;
> +
> +	if (leaf =3D=3D sbm_max_populated_index) {
> +		for (idx =3D leaf - 1; idx > -1; idx--) {
> +			if (__sbm_idx_metadata[idx].instance_id !=3D -1)
> +				break;
> +		}
> +
> +		WRITE_ONCE(sbm_max_populated_index, max(idx, 0));
> +	}
>  }

[Severity: High]
Could this prematurely shrink the maximum index and strand active CPUs?

When clearing a bit in a leaf's allocated_mask, if the leaf matches
sbm_max_populated_index, this loop unconditionally scans backward to find
the next non-empty leaf and overwrites sbm_max_populated_index.

However, it does this without verifying if the current maximum leaf
actually became completely empty (instance_id =3D=3D -1). If other CPUs
remain actively allocated in that same leaf, they appear to be
immediately hidden since the global max index is truncated below them.

This would cause functions like sbm_empty() and sbm_find_next_bit() to
permanently ignore these active CPUs during NOHZ idle load balancing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001192849.7478=
8-1-kprateek.nayak@amd.com?part=3D11
