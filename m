Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963643B47D0
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 09:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932403; cv=none; b=HtDY62LiDzp7OxAH/kfGGp/gyovTeRqJVeLzufH6LNK6hrTMejwXXyF2bqnaaOT9uzP1+t/v1GLEyTVtscSxyL7yzlWO1OjOtfOU80znBRYVVFdw9/WzIQ7DmjWqnm6dOup3bTSQ+OFoiWKakp6peSOi/2/UVY/7PS3gTVRy4og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932403; c=relaxed/simple;
	bh=zk7vTapUp1PTrWkhFzbxhpzzTW40eYo+lfTnVPLZ5aA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ELkyLp4PHvy19NB8HRFoCfWbhofAv7q/2MNz2oY9AZkjuywYPuB9fRcplEJioWmLxz+ciUfiLmqL8jz2d07xkKRem6dOvYa0bXg6OWpRBDXRfM9QOlYkR85VSv/WC+jypQRVhjl9qK1z03F9Zk623y02g/FsOVEMT6UzrqjE5A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=niROj0MJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="niROj0MJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AA701F00893;
	Fri,  2 Oct 2026 09:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932402;
	bh=O2IDWNcxWRyPba7YEjjDqsYcSCEHt9DsQaSIpxqco1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=niROj0MJzKhlE0dIWDthmzcgH2S955aLGbXO4Ed2w0d4iaflMtI7zo1a2Uq56gCq8
	 pHXXYi/jJNx3AaVEI5Sb8hSxNIioCuPEURDU7ugGAuw0206oqlWtX5v1uUG6LOC2XR
	 lV5HNZdFD0JE4oqyhxBwJ1NRD32fxUdYRU0E2gvVUaoQu9RzNJSENqLYC18MPBbjj1
	 509iS3+TymYJr2IvxbuEHRjIPdFWGGRAYyutxgCMJsfT12a9JDAbYzjCrDYsz0McwL
	 1MBADLWT105xXp+RHNi/yAHFe0fKvBLhbHgwjZYU+GnntqEym62+8W7BHGC6eeHBL9
	 M0vbqzoxVcANg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 05/13] MIPS: Initialize sbm topology on
 multi-node systems
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20261001192849.74788-6-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-6-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:21 +0000
Message-Id: <20261002091322.2AA701F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] mips: modpost section mismatch from cpu_node_probe() calling __init=
 function
--

commit a182a04b59c7d5076dc4fa89322bc392b7a56f93
Author: K Prateek Nayak <kprateek.nayak@amd.com>

MIPS: Initialize sbm topology on multi-node systems

For MIPS systems that support NUMA, configure the sparsebitmap (sbm)
topology.

> diff --git a/arch/mips/kernel/topology.c b/arch/mips/kernel/topology.c
> index 9429d85a4703c..bb6d14bfe5ebb 100644
> --- a/arch/mips/kernel/topology.c
> +++ b/arch/mips/kernel/topology.c
> [ ... ]
> @@ -5,9 +5,52 @@
>  #include <linux/node.h>
>  #include <linux/nodemask.h>
>  #include <linux/percpu.h>
> +#include <linux/sbm.h>
> =20
>  static DEFINE_PER_CPU(struct cpu, cpu_devices);
> =20
> +#ifdef CONFIG_NUMA
> +/* sbm setup data - only needed during init */
> +static struct cpumask cpu_sbm_setup_map __initdata;
> +static int __node_thread_count[NR_CPUS] __initdata;
> +
> +int arch_sbm_cpu_instance_id(int cpu)
> +{
> +	return cpu_to_node(cpu);
> +}
> +
> +void __init configure_sbm_topology(void)
> +{
> [ ... ]
> diff --git a/arch/mips/sgi-ip27/ip27-smp.c b/arch/mips/sgi-ip27/ip27-smp.c
> index 62733e049570a..244f8d987f13b 100644
> --- a/arch/mips/sgi-ip27/ip27-smp.c
> +++ b/arch/mips/sgi-ip27/ip27-smp.c
> [ ... ]
> @@ -80,6 +81,8 @@ void cpu_node_probe(void)
>  		highest =3D node_scan_cpus(nasid, highest);
>  	}
> =20
> +	configure_sbm_topology();

[Severity: Low]
Does this cause a modpost section mismatch warning?

Since configure_sbm_topology() is marked __init in
arch/mips/kernel/topology.c, calling it from cpu_node_probe() creates a
cross-section reference because cpu_node_probe() is not marked __init.

While cpu_node_probe() might only be called during initialization,
shouldn't it also be marked __init to prevent the .text section from
referencing the freed .init.text section?

> +
>  	printk("Discovered %d cpus on %d nodes\n", highest + 1, num_online_node=
s());
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001192849.7478=
8-1-kprateek.nayak@amd.com?part=3D5
