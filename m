Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE43471D10
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932414; cv=none; b=MDMtSd9XsbxGRfpUcf1ZkrZ47nnQoXFFkwwtIQYlv5M2ev3Ihz9SNino5NrbyEzWH8jQ/ZpI+aTrJaJmYQ0kePtyiOjXdweJ/rOJCAiC3Nr/T8F2IM3frC7GkisRMKnYQxmvjGoOURtVK3RVBCTVuMML6L+AyxX+nEkMH6isCTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932414; c=relaxed/simple;
	bh=0CnV2rcxyz3obL6X1l0BFJwSmlfVvEGcE95R1iKwMOk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hmakfLsP8MiGFbuA4p6Yv9tZfLf7be/P/CE4rOpaISrcOb1sDPDrR1eWPFlaxcRBWKZ3W5KX3+7zjy7hKYxJL6rmNGWtaPOWtRb3Ln/YKzbGB0BlUOKCLoUq6xkYO0kjpYK3mNtku3wEyhxwptsaDx7qzWnjRVtNKhPMiDza9Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU+ybQy/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU+ybQy/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AD11F00899;
	Fri,  2 Oct 2026 09:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932412;
	bh=wFy6X/3KQ5EZ9eDEO5fAH2xpPYE4fi/ghvuxF4RfC8s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YU+ybQy/oj9UCPeC5Dy/q1I+M/EXtxsaWp9/U9lwsAiONaJ8CiWZtt4AqRJWBXLpb
	 nE17ZaqTh74Yhu7JHvsxzM9JfAswtIqlKpbV40htyZL6ciCWWc0IQfnOC4Lanm3rIl
	 gPL83yBMwq0rpeFrfLPL1bsuh1nzsEepxlbQY594c+cW4oxp4WFRHr1/Ef1F6bCH5B
	 rozMKSm618Yp2tdEoOliyWB7qWc97ldHY3FsF8eb8vuAEO5WxxYsAV9z2BSPY67EMO
	 u68jLk/OymvobcdIGDPRJ+6fS3VhdIIbMq843KdODOS6+R8tTJw65ch2Y4YWcFEya1
	 3FfALphEMuTqQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 03/13] LoongArch: Initialize CPU _PXM relation
 for disabled CPUs from SRAT
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261001192849.74788-4-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-4-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:32 +0000
Message-Id: <20261002091332.63AD11F00899@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] loongarch/numa: skip adding disabled CPU node to numa_nodes_parsed
--

commit 9393724eb4ba65d5f1a0cdd15d60f325d36ffc28
Author: K Prateek Nayak <kprateek.nayak@amd.com>
Subject: LoongArch: Initialize CPU _PXM relation for disabled CPUs from SRAT

This commit updates SRAT parsing on LoongArch to initialize the CPU _PXM
(Node) relation even for disabled CPUs. This is intended to help early
topology parsing count LLC domains and set sparsebitmask properties, while
mapping per-CPU areas correctly.

> diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
> index cb454ee92b204..1f15f78713b7e 100644
> --- a/arch/loongarch/kernel/acpi.c
> +++ b/arch/loongarch/kernel/acpi.c
[ ... ]
> @@ -332,9 +331,12 @@ acpi_numa_processor_affinity_init(struct acpi_srat_c=
pu_affinity *pa)
>  		return;
>  	}
> =20
> -	early_numa_add_cpu(pa->apic_id, node);
> -
>  	set_cpuid_to_node(pa->apic_id, node);
> +
> +	if ((pa->flags & ACPI_SRAT_CPU_ENABLED) =3D=3D 0)
> +		return;
> +
> +	early_numa_add_cpu(pa->apic_id, node);
>  	node_set(node, numa_nodes_parsed);

[Severity: High]
Does skipping node_set() leave the NUMA node uninitialized?

If the node lacks memory and other enabled CPUs, it won't be added to
numa_nodes_parsed. As a result, alloc_node_data() will not be called,
leaving NODE_DATA(node) as NULL.

Since set_cpuid_to_node() was already called for this disabled CPU,
early_cpu_to_node() will return this uninitialized node instead of
NUMA_NO_NODE.

This can cause smp_prepare_boot_cpu() to bypass the safe rr_node fallback
and assign the uninitialized node to the CPU:

arch/loongarch/kernel/smp.c:smp_prepare_boot_cpu() {
    ...
		if (node !=3D NUMA_NO_NODE)
			set_cpu_numa_node(cpu, node);
		else {
			set_cpu_numa_node(cpu, rr_node);
			rr_node =3D next_node_in(rr_node, node_online_map);
		}
    ...
}

Could this lead to generic per-CPU allocations or CPU hotplug actions blind=
ly
dereferencing the NULL NODE_DATA(node) pointer? For example, when hotpluggi=
ng
the disabled CPU:

mm/memory_hotplug.c:hotadd_init_pgdat() {
    ...
	pgdat =3D NODE_DATA(nid);

	/* init node's zones as empty zones, we don't have any present pages.*/
	if (free_area_init_core_hotplug(pgdat))
    ...
}

[ ... ]
> @@ -366,9 +367,12 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2ap=
ic_cpu_affinity *pa)
>  		return;
>  	}
> =20
> -	early_numa_add_cpu(pa->apic_id, node);
> -
>  	set_cpuid_to_node(pa->apic_id, node);
> +
> +	if ((pa->flags & ACPI_SRAT_CPU_ENABLED) =3D=3D 0)
> +		return;
> +
> +	early_numa_add_cpu(pa->apic_id, node);
>  	node_set(node, numa_nodes_parsed);

[Severity: High]
Does this expose hotplugged CPUs in x2apic topologies to the same NULL
pointer dereference?

The exact same early return logic is present here for x2apic, skipping
the node_set() initialization for disabled CPUs.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001192849.7478=
8-1-kprateek.nayak@amd.com?part=3D3
