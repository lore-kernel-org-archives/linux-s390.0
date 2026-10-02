Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C900B3B47D0
	for <linux-s390@vger.kernel.org>; Fri,  2 Oct 2026 09:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932402; cv=none; b=mzsyyCFsS0ISUOY5LOusqQXbGcokw7JrC72kz8eB5tHGB3ftXVbDe4rMQ/2LsTKE2UdwdaV/9bADV5qN0ZfVFVpLOm6ubcUcxkcV0Zu1BUx488kv5SfeXRsHhPCGUd/muFfrH6EwypW+FFXDNB8ohWla6FjyohZ3+drDUj5XyxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932402; c=relaxed/simple;
	bh=+vblMWLV0Ea3ECK1+KnsTe8kRYv5RWaUdCf2TXpfAzA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=s2omZhNOWXucpwNh12e7gfkJeiywU2cy7sE5rUHG2oGbqefJQdkFxM31dHfXN3JVl64s8A8fAtDT32LxiBKtp3bbV6UE15KDz31UXFNrpuCLVIBRK065z1GZt9k9mcgdb4PdFIUEN/UhTNxmW1n6XGB3UrZnh7g9vue1SoCzXBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XqwbL/ou; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XqwbL/ou"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3B91F000FF;
	Fri,  2 Oct 2026 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932400;
	bh=WaHDBfY/K2oC+BvUPn35Kdfr+2AgL0k7Anb3yPSL6/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XqwbL/oupVNTvSEp/v+5VR+dhlAw252FEq1ab1y5zy8SzaKbxnK2tw1z8TWqcivDG
	 YXXWEnq0WXf6uAXbUozDKzlvJYP9RfOoY/Z5u3aIXOizoPXJrvJp4C/SEAWH5/2VPJ
	 97BTlRSUL4mqNObxGqvyqa6QSWAGB96SZ6ME1OZPRkvplpffWWD6KyuuBsF4Erwd2j
	 2YX+hbscTnrwl73uMv3/rEAsYZbrr6siRbTGEcCNpOnVKlMlprw7pYTYeNPMdjJyEj
	 B1NXPkPL/hvC8X3c658ft1JbPw9zRaDWZWEJW5Px7R5rLKnPG4oT2orZQKtoC1uGnM
	 p9AeKtZnp9zcA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 02/13] drivers/base/arch_topology: Add support
 for initializing sbm topology
Reply-To: sashiko-reviews@lists.linux.dev
To: "K Prateek Nayak" <kprateek.nayak@amd.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261001192849.74788-3-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-3-kprateek.nayak@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:19 +0000
Message-Id: <20261002091320.5C3B91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] topology: 64-bit fw_token truncated to 32-bit int causing ID colli=
sions
- [High] topology: hardcoded 'cpu =3D=3D 0' fails initialization when CPU 0=
 is not possible
- [Medium] topology: memory leak of 'count' on xa_store() failure
- [Medium] topology: topology uniformity check silently ignores the first C=
PU
- [Medium] topology: mismatched cache type filtering causes inconsistent SB=
M domains
--

commit 3748179aae956b072baf4016333e144175bba72f
Author: K Prateek Nayak <kprateek.nayak@amd.com>
Subject: drivers/base/arch_topology: Add support for initializing sbm topol=
ogy

This commit introduces support for initializing sparsebitmap (sbm) topology
for architectures supporting GENERIC_ARCH_TOPOLOGY. It counts the number of
unique LLCs or packages and the maximum threads per instance to set the sbm
processor configuration.

> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 8c5e47c28d9a3..f55745a932986 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c

[ ... ]

> @@ -930,6 +931,114 @@ __weak int __init parse_acpi_topology(void)
>  int arch_sbm_cpu_instance_id(int cpu)
>  {
>  	if (last_level_cache_is_valid(cpu)) {
>  		struct cacheinfo *llc_info =3D get_cpu_cacheinfo_llc(cpu);
> =20
>  		if (!llc_info)
>  			goto out;
> =20
>  		if (llc_info->attributes & CACHE_ID)
>  			return llc_info->id;
> =20
>  		/*
>  		 * XXX: fw_token be truncated from cast
>  		 * when the value is returned as an int.
>  		 */
>  		return (int)((long)llc_info->fw_token);

[Severity: High]
Does this explicit truncation risk SBM topology corruption?

On 64-bit architectures using ACPI PPTT for cache topology, fw_token contai=
ns
a 64-bit pointer. By casting it down to a 32-bit int, the upper 32 bits are
dropped. If two different cache structures collide in their lower 32 bits,
CPUs that do not share an LLC might be incorrectly grouped into the same
instance ID.

>  	}
>  out:
>  	return cpu_topology[cpu].package_id;
>  }

[ ... ]

>  static void __init init_sbm_topology(void)
>  {
>  	int num_sbm_instances =3D 0, max_threads_per_instance =3D -1;
>  	bool has_cache =3D false, has_package =3D false;
>  	cpumask_var_t unique_cpus;
>  	struct xarray instances;
>  	unsigned long cpu, *count;

[ ... ]

>  	for_each_possible_cpu(cpu) {
>  		bool found =3D false;
>  		int unique_cpu;
> =20
>  		for_each_cpu(unique_cpu, unique_cpus) {

[Severity: Medium]
Will this silently ignore the first CPU for the topology uniformity check?

When the first CPU is processed, unique_cpus is empty, so this inner
for_each_cpu loop is completely skipped. Since has_cache and has_package
are only updated inside this loop, the cache state for the first CPU is
never recorded.

If a subsequent CPU has a conflicting topology, won't the has_cache &&
has_package check fail to detect the mismatch?

>  			/*
>  			 * XXX: Assumes last_level_cache_is_valid() is uniformly true
>  			 * across the entire system if it is true for one CPU.
>  			 */
>  			if (last_level_cache_is_valid(cpu)) {

[Severity: Medium]
Are we using mismatched cache type filtering rules?

Here in init_sbm_topology(), last_level_cache_is_valid() is used, which does
not filter out instruction caches. However, arch_sbm_cpu_instance_id() uses
get_cpu_cacheinfo_llc(), which strictly filters out instruction caches and
falls back to package_id.

If the LLC is an instruction cache, won't the domain counting diverge from =
ID
assignment, leading to inconsistent SBM domains?

>  				has_cache =3D true;
>  				if (last_level_cache_is_shared(cpu, unique_cpu)) {
>  					found =3D true;
>  					break;
>  				}

[ ... ]

>  		if (!found) {
>  			count =3D kzalloc_obj(*count);
>  			if (!count)
>  				goto out;
> =20
>  			cpumask_set_cpu(cpu, unique_cpus);
>  			*count +=3D 1;
> =20
>  			xa_store(&instances, cpu, count, GFP_KERNEL);
>  			continue;

[Severity: Medium]
Does this code leak the newly allocated count object if xa_store() fails?

The return value of xa_store() can be an error pointer if internal memory
allocation fails. If xa_store() fails here, count is not added to the xarra=
y,
but we continue the loop without freeing it, resulting in a memory leak.

>  		}

[ ... ]

>  void __init init_cpu_topology(void)
>  {
>  	int cpu, ret;

[ ... ]

>  	/*
>  	 * If fetch_cache_info() fails for first CPU,
>  	 * init_cpu_sbm_topology() will use pacakge_id instead.
>  	 *
>  	 * Uniform cache topology is a necessary since implementation
>  	 * assumes last_level_cache_is_valid() gives same result for
>  	 * all possible CPUs
>  	 */
>  	if (!ret || (cpu =3D=3D 0 && ret =3D=3D -ENOENT))
>  		init_sbm_topology();

[Severity: High]
Can this hardcoded check for cpu =3D=3D 0 silently bypass SBM initializatio=
n if
CPU 0 is offline or not possible?

If fetch_cache_info() fails with -ENOENT for the first possible CPU, the
loop preceding this block breaks and leaves that CPU in the cpu variable.
If the first possible CPU is greater than 0, cpu =3D=3D 0 evaluates to fals=
e,
and init_sbm_topology() will never be called.

Should this dynamically resolve the first valid CPU via
cpumask_first(cpu_possible_mask) instead?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001192849.7478=
8-1-kprateek.nayak@amd.com?part=3D2
