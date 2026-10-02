Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F416D46C840
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 09:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932401; cv=none; b=YbzRBl9D9Q14qjhH/5nxLve2JwNMSAXdlcEX9CLBayGHcnRap1aQO/HiolhzhPWULn+Ip5spq20bOO7bwOyKxv9xrcUPbrQzK6CQQOyXw9bvgUA5CeDRR0SwwoIZ/cK0FMzyNBkMOjVs0VLDdbtSHvq12kOzHCzM0KDiK8jyOrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932401; c=relaxed/simple;
	bh=cMgxYIoKfF38xPy6VjvB3m9/KGKOwndgJKjZbvrWsSQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nB8RJj5Zs3s+4hfDmLv630b1PlI7XqLdT0Jedr4WwFfEEwGxLEG6dovCBCGUyzVvU3kZuvcwCGLWw3Z5q4kGI+Tlpfo4cEGZ7fEYpAfEuzK+uhXY26M8RQ+ObSBf/5sO3th4yaXshum+KtvixpfrJqlAcNzAuGTTpT9hGCSawYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlYGNj+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlYGNj+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73CDB1F00893;
	Fri,  2 Oct 2026 09:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932399;
	bh=0PETTKJipNclPxwdEvMNePXN+lZPpSl/WprcDZj6fAc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jlYGNj+Wo9FfiQIZ31qnHyVXbLFMltacngo4Mjs5lUMeK8IHbX+ZWOB9fr90xS8Fw
	 rz9EsckUQRppSNVR+ePGVBZ+JCD5eaJJrHkE4RKIfbZuSNuXPXcHAXf7R1rv5A39ky
	 rd+9Pd5h7YZNpMB9rTi57STOOpjEBz2SCC6Mw4Msge7C4Hgk7GgqKar2Xa2SXaVAHh
	 Kgj0tgtHUt9GPjY/5XQ+0qf7R63pqK30oMeW6ilwuSAyBaid7Av0m5mTnD9OeJVt5U
	 AFFqhh1O/jn+IZEBisc5xFBhBSU6Q5oWp2mhtMCDaR54PeGk7xLZV3vPG8Yn9WPJD0
	 6iPQSYOFI00Tg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 06/13] powerpc/setup: Initialize sbm topology
 based on coregroup / NUMA topology
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261001192849.74788-7-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-7-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:19 +0000
Message-Id: <20261002091319.73CDB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] powerpc/setup: uninitialized num_sbm_instances in setup_sbm_topolo=
gy()
- [High] powerpc/setup: unconditional dereference of smp_ops causes boot pa=
nic
- [Medium] powerpc/pseries: sizing SBM by num_online_nodes() breaks memory =
hotplug
--

commit a4d9dadc8cce1e3232c36f0087110489e579c9b4
Author: K Prateek Nayak <kprateek.nayak@amd.com>

powerpc/setup: Initialize sbm topology based on coregroup / NUMA topology

This commit initializes the sparsebitmap (sbm) topology based on coregroup
information, with each coregroup getting its own sparsemask leaf. For pSeri=
es,
NUMA topology is used instead to account for CPU hotplug behavior.

> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/set=
up-common.c
> index 4afaba19b5867..4b57ad553172d 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
[ ... ]
> @@ -602,6 +603,87 @@ static __init int add_pcspkr(void)
>  device_initcall(add_pcspkr);
>  #endif	/* CONFIG_PCSPKR_PLATFORM */
> =20
> +int arch_sbm_cpu_instance_id(int cpu)
> +{
> +	/*
> +	 * In case of pSeries processors, sbm masks are
> +	 * grouped by nodes where the cpuhotplug
> +	 * operations can remove and re-add same logical
> +	 * CPUs on different nodes.
> +	 *
> +	 * See comment in pseries_cpu_hotplug_init().
> +	 */
> +	if (smp_ops->cpu_disable)
> +		return cpu_to_node(cpu);

[Severity: High]
Is it possible for smp_ops to be NULL here?

If the platform does not initialize SMP (such as on UP platforms), evaluati=
ng
smp_ops->cpu_disable unconditionally can cause an immediate boot panic.

Additionally, on !CONFIG_SMP builds, struct smp_ops_t might be an incomplete
type, which can result in compilation errors.

> +
> +	return cpu_to_coregroup_id(cpu);
> +}
> +
> +static void __init setup_sbm_topology(void)
> +{
> +	int num_sbm_instances, max_threads_per_instance =3D 1;

[ ... ]

> +	/*
> +	 * If CPUs are disabled, they may pop up on any online node.
> +	 *
> +	 * XXX: Any implementation nuances that can help this?
> +	 * pSeries says only online nodes can be extended.
> +	 */
> +	if (disabled_cpus) {
> +		num_sbm_instances =3D num_sbm_instances + disabled_cpus;

[Severity: High]
Is num_sbm_instances uninitialized when it is used in this addition?

If disabled_cpus > 0, the calculation incorporates stack garbage. This
determines the SBM topology size during boot and can lead to uncontrolled
memory allocation sizing in sbm_init(), potentially causing out-of-bounds
array access or out-of-memory panics.

> +	} else {
> +		num_sbm_instances =3D cpumask_weight(cpu_sbm_setup_map);
> +	}
> +
> +	/*
> +	 * If disabled threads exists, assume the maximum threads per
> +	 * instance can extend by the number of disabled threads if they
> +	 * are all added to the same node.
> +	 */
> +	sbm_set_topology(num_sbm_instances,
> +			 max_threads_per_instance + disabled_cpus);
> +
> +	memblock_free(__node_thread_count, nr_cpu_ids * sizeof(int));
> +	memblock_free(cpu_sbm_setup_map, cpumask_size());
> +}
[ ... ]
> diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/=
platforms/pseries/hotplug-cpu.c
> index bc6926dbf1489..7c1c1ac3efde4 100644
> --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
> +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
[ ... ]
> @@ -870,6 +871,15 @@ void __init pseries_cpu_hotplug_init(void)
>  		return;
>  	}
> =20
> +	/*
> +	 * find_cpu_id_range() only looks at online nodes.
> +	 *
> +	 * XXX: Is it possible for a CPU attached memory node to come
> +	 * online after this point? May need num_possbile_nodes() then
> +	 * unless there are platform nuances that can help optimize.
> +	 */
> +	sbm_set_topology(num_online_nodes(), num_possible_cpus());

[Severity: Medium]
Does sizing SBM by num_online_nodes() break dynamic node hotplug?

pSeries platforms support Dynamic LPAR, where entirely new NUMA nodes can be
onlined after boot. When a CPU is added to a new node, its requested topolo=
gy
instance will exceed the boot-time pool bounded by num_online_nodes(). This
exhausts the SBM metadata index pool, causing alloc_sbm_index() to return
-ENOENT and potentially corrupting the scheduler's idle tracking mechanisms.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001192849.7478=
8-1-kprateek.nayak@amd.com?part=3D6
