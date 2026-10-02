Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED5470456
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932408; cv=none; b=q1CaO+7da5Q1djNk1TKi4EIAli9uNfrU4i57pDBd4wrkT/7/sB478XQhRNR6JHc7psmRaq2JW17gdduKO5OmW6xaLG4jOZJT1JDiPXlHt87QPO6PvskWgLP+T/gATYtJmptywrUOZ8/n4SebdEa+LjXx/pslwuOEVvkDa41H0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932408; c=relaxed/simple;
	bh=+X6sAmQu1bl0Ep0ZABXLfSYC49PWf6Dzw01zBb4YlvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IUhClDFOuqlMx+Nf5z63XpL0SL9One6tI7IhrerD5a+0NuQGwnatWY3tjPEVc4E/y5qzt/acnmXUGTH1tIlxfSGnHnpvh4jbyOBhI8XrTuwm1NvvYnZVC/TjYeTi6SthUodBiVUFcY+eytH7iCFMQXfI1KKInH1OPjwHemkwwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jL5YeN84; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jL5YeN84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56FC01F00893;
	Fri,  2 Oct 2026 09:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932406;
	bh=qq0NcbWfKcZUYUUfB0Bpm850ajH6mgS/4izOX/fuZ20=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jL5YeN84r/58YF6K8C2gPgH+9lHpK36rRQLdClN7wp0Aowabt60ElB1hK2DJCbkts
	 zgci8ij74YQqxnhWveuTZvIFPSyUgfThrx1lzZDAn8MPYaFRDdc8+2LncOsw3sazHZ
	 78akEO83Y6vPSxRWYl15FgXwCitOZShyNC3mHEskeTeqv0uU/yCzu+DJJ/+xIiffy5
	 dm/sawpo6sdRYISRBgKuH0hHRO1Mdi5mYVdx6861DnjAL0n9LOruuFGWuJIRY0hB97
	 0aAh0CNLYssUoqUXUiXVrI4/0jN3394I7iEx5K0F/xbs3QWE6bOXWhSNTfHBEttZKN
	 iG9fiDVeFyZ/Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 07/13] s390/topology: Initialize sbm topology
 during topology_init_early()
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261001192849.74788-8-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-8-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:25 +0000
Message-Id: <20261002091326.56FC01F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] s390/topology: OOB write in SBM due to underestimating max_threads=
_per_instance
- [High] s390/topology: arch_sbm_cpu_instance_id() fails to map secondary C=
PUs
- [Low] s390/topology: __configure_sbm_topology() counts dummy head node
--

commit 7e4b5901a7b8d62cc7a0551c478b49d8ad5ae92b
Author: K Prateek Nayak <kprateek.nayak@amd.com>

s390/topology: Initialize sbm topology during topology_init_early()

This commit configures sparsebitmask (sbm) properties for the system using
socket_info when the topology mode is TOPOLOGY_MODE_HW. It also adds
arch_sbm_cpu_instance_id() to map CPUs to socket instance IDs during
CPU hotplug events.

> diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
> index 1377c6f3f6709..80dc51f5ce6f5 100644
> --- a/arch/s390/kernel/topology.c
> +++ b/arch/s390/kernel/topology.c

[ ... ]

> @@ -561,6 +562,55 @@ static int __init detect_polarization(union topology=
_entry *tle)
>  	return tl_core->pp !=3D POLARIZATION_HRZ;
>  }
> =20
> +int arch_sbm_cpu_instance_id(int cpu)
> +{
> +	struct mask_info *info =3D &socket_info;
> +
> +	/*
> +	 * sbm core should not call this if sbm_set_topology() was
> +	 * skipped below due to lack of topology information.
> +	 */
> +	if (WARN_ON_ONCE(topology_mode !=3D TOPOLOGY_MODE_HW))
> +		return -1;
> +
> +	while (info) {
> +		if (cpumask_test_cpu(cpu, &info->mask))
> +			return info->id;

[Severity: High]
Can this fail to map newly hotplugged CPUs?

Since hardware topology masks on s390 are updated asynchronously via a
workqueue, the mask might not be populated before the CPU online callback
executes during CPU hotplug.

> +		info =3D info->next;
> +	}
> +
> +	pr_warn_once("socket mapping for CPU%d not found! Mapping to ID 0", cpu=
);
> +	return 0;

[Severity: High]
If the mask check above fails due to the asynchronous update race, does
falling back to instance 0 break SBM topology isolation by grouping all
secondary CPUs into a single instance?

> +}
> +
> +static void __configure_sbm_topology(void)
> +{
> +	int num_sbm_instances =3D 0, max_threads_per_instance =3D -1;
> +	struct mask_info *info =3D &socket_info;

[Severity: Low]
Should this traversal start at info->next instead of the dummy head node?

socket_info serves as a static dummy head, and alloc_masks() attaches newly
allocated instances starting at socket_info.next.

> +
> +	/*
> +	 * Consider single package if topology
> +	 * information is unavailable.
> +	 *
> +	 * sbm core will handle the initialization.
> +	 */
> +	if (topology_mode !=3D TOPOLOGY_MODE_HW)
> +		return;
> +
> +	while (info) {
> +		num_sbm_instances +=3D 1;

[Severity: Low]
Counting the dummy head node as a valid instance appears to pass an inflated
count to sbm_set_topology(), which would overallocate the SBM instance
metadata arrays by exactly one element.

> +		max_threads_per_instance =3D max_t(int,
> +						 cpumask_weight(&info->mask),
> +						 max_threads_per_instance);

[Severity: High]
Does calculating the max threads per instance here underestimate the
capacity?

Because this is called during topology_init_early() when only the boot CPU
is marked as present, info->mask will only contain the boot CPU's threads.
This results in a drastically undersized max_threads_per_instance.

When secondary CPUs come online later, alloc_sbm_index() assigns them
local indices. Will returning an index that exceeds this undersized limit
trigger an out-of-bounds write in the SBM core when accessing its internal
arrays?

> +		info =3D info->next;
> +	}
> +
> +	if (WARN_ON_ONCE(!num_sbm_instances || max_threads_per_instance < 1))
> +		return;
> +
> +	sbm_set_topology(num_sbm_instances, max_threads_per_instance);
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001192849.7478=
8-1-kprateek.nayak@amd.com?part=3D7
