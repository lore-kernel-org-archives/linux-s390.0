Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A3B471421
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932406; cv=none; b=Qv5PwaK6aDLJNBAikp/EyZTq1M/y9JmI9ADVD6paJE8tOJeP6q/NPpQeYx1fh2N1p4UP1CnppbHaUYO0dCTx4xMmhZDvocavkAD8G1NIDtcIrEL3azfTtG91Rd6nHnwwjUcxAC1MiOek7Lm0B8RNkIESIo9riRMtbTAZBMmLXEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932406; c=relaxed/simple;
	bh=iCJ01eYsCQJl53V/SpfVbORMz0ZDLlw9SRgDCU4pm1U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WQF/0ppw1X4+VPQVGuaV9pUhRDPKrMUIgJVSnjoOReWSoNaILepiohr1c+CRSzuY9WnOxS/aAijvvzx5H9PB2AQdqKvgAjduTm1bfFlDwlldFZl+EWjcIpIbP2m3nLQyllcOoPix7dTfrbYj5QCA49MqlNorblwODOzb4dif9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ls+qoIOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ls+qoIOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869411F00893;
	Fri,  2 Oct 2026 09:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932404;
	bh=/4rOUZG9NC70b9H7qjUwbxTnwvbDb6M2gXNt/Y0+ooM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ls+qoIOnG8mOpRebb+roRerHu12D8NqzMIr2VLcKkZCmsf0ADJkJP1Q/78W+blvZs
	 oUhq8yR/UT9ZPPKXt6TD2+dn6ulGXU0KCNEgPDxFHw/74q3dun/2+2g1izAh5NNYQQ
	 KP1hdJdJDOYNfTEUYyStp6cnA3KP806JtQzP7i+iWNtDph6/U1/DIj/zcbA3P3du7W
	 vYVeCidv6ybrTPmufe+pA0rxy3NnLTH4baIg0EoS6vPCPIfBVCrYZtBibYblFOH/f6
	 qvXkhcwF44ExUgIrH8cHDO5n9VBEKFhpBrz1rRdPTMHzeeb36owEmaunCUnM8wIFLg
	 0N8pB03lID+8A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 08/13] sparc64: Initialize sbm topology on
 multi-LLC system
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261001192849.74788-9-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-9-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:24 +0000
Message-Id: <20261002091324.869411F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] sparc64: sbm topology initialization runs before CPU data is popul=
ated
- [High] sparc64: ghost SBM instances created by iterating uninitialized po=
ssible CPUs
--

commit e3accb8257522fa2bde71974a4d31cb5abc096f8
Author: K Prateek Nayak <kprateek.nayak@amd.com>

sparc64: Initialize sbm topology on multi-LLC system

This commit initializes the sparsebitmap (sbm) topology for SPARC64 after
the CPU topology is parsed. It introduces init_sbm_topology() which counts
LLC/NUMA instances and their maximum thread counts, calling it from
setup_arch().

> diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
> index 63615f5c99b47..7ab52d17e46f4 100644
> --- a/arch/sparc/kernel/setup_64.c
> +++ b/arch/sparc/kernel/setup_64.c

[ ... ]

> @@ -619,6 +621,48 @@ static void __init alloc_irqstack_bootmem(void)
>  	}
>  }
> =20
> +static struct cpumask cpu_sbm_setup_map __initdata;
> +static int __node_thread_count[NR_CPUS] __initdata;
> +
> +int arch_sbm_cpu_instance_id(int cpu)
> +{
> +	/* Combine the node and cache identifier. */
> +	return ((u32)cpu_to_node(cpu) << 16) |
> +	       cpu_data(cpu).max_cache_id;
> +}
> +
> +static void __init init_sbm_topology(void)
> +{
> +	int num_sbm_instances, max_threads_per_instance =3D 1;
> +	int i;
> +
> +	for_each_possible_cpu(i) {

[Severity: High]
Will this loop over uninitialized offline or absent CPUs?

If the possible mask exceeds the present mask, absent CPUs will evaluate
their uninitialized max_cache_id to 0.

They would then incorrectly match each other and be grouped into a single
phantom instance, which could heavily inflate the max_threads_per_instance
calculation below and misallocate the global sparsebitmap arrays.

Should this use for_each_present_cpu() instead?

> +		bool found =3D false;
> +		int j;
> +
> +		for_each_cpu(j, &cpu_sbm_setup_map) {
> +			if (cpu_to_node(i) =3D=3D cpu_to_node(j) &&
> +			    cpu_data(i).max_cache_id =3D=3D cpu_data(j).max_cache_id) {

[Severity: High]
Are the max_cache_id and node values actually initialized when this runs?

This function is called from setup_arch(), but max_cache_id is populated
later during SMP initialization:

arch/sparc/kernel/smp_64.c:setup_per_cpu_areas() {
    ...
    of_fill_in_cpu_data();
    if (tlb_type =3D=3D hypervisor)
        mdesc_fill_in_cpu_data(cpu_all_mask);
    ...
}

Because setup_per_cpu_areas() runs after setup_arch(),
cpu_data(i).max_cache_id and cpu_to_node(i) will evaluate to zero for all
CPUs here. This would group all CPUs into a single instance instead of
distributing them based on max_cache_id.

If alloc_sbm_index() later finds the true max_cache_id, could it fail to
allocate leaves and return -ENOENT? This might leave __sbm_cpu_to_idx[cpu]
as -1, potentially causing out-of-bounds array accesses in the scheduler
fast paths.

> +				found =3D true;
> +				break;
> +			}
> +		}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001192849.7478=
8-1-kprateek.nayak@amd.com?part=3D8
