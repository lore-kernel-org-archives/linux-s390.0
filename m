Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C4B3D8122;
	Mon, 12 Oct 2026 23:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848511; cv=none; b=Blb+o5WyhyXzQZHTb2ikWWFsuvlXSHPR0DBd7N8fcPtLIUGM+APtI3uRguQYFPgBoB/armIT3PV0J9VD87wiKWk2Yihn2DAo6rUhmqYH6bmjkJW2sEU1nSkW1SPO3hSZzko0lI4tUMnBIwss1LFYwh0Z8z1bK6M164wlqckzqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848511; c=relaxed/simple;
	bh=iD+/aLbLxyN4OPgQVnmXQ+36xaYhRSs8OGa/lzPqXVQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JxuVd6FqHAM85kyrF4YywN2BpfviVtTwtIRQAzZXitLsXFNN8XNLpRbFG/bwlQNJYY4ZEi28iVPvSsD0FPsRFNoroBe2aePkk7mkYLXNn7vhyPeuHkXTOgCoejDUkBPe93MCu0R3akSmlAI0im7of+VNAJMY2YvfMOXqQXRCuFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F3rhYTqN; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3rhYTqN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791848509; x=1823384509;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=iD+/aLbLxyN4OPgQVnmXQ+36xaYhRSs8OGa/lzPqXVQ=;
  b=F3rhYTqNn1jOf/080UxZTRngn6PqWLJXR1SDmRtQPOt8lsQ78hnABWeS
   aVVzEJLXzzK2SIQQ88CSq0m3WtjwkS3C0L3ApDyJCeW5CD2hzp3wgEqiY
   31LlCWUY1Dp3JFBmrWo6RUKYxlXHTPuK25+hV7oPYzUlpO/eCR5i2i+2q
   Jwj9hTqGsnkaJquDtEU/p9mEqMFWYourj6NWBeHnArrZu9F4/J85fBZhi
   CvZO+HOpQJSj3ozaR2fTqlXLry9XicApAAgj2AVW4nlB42H+iVoppcfbM
   K6YvUncO/GyHwZMzefy66eqILEkrNupMady6onl995J5mwO99auMczQH2
   w==;
X-CSE-ConnectionGUID: u/NXtRM1SnO1/4gc/Q/dgw==
X-CSE-MsgGUID: ul9liZSPRf2d9fcdG1zs6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="450036"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="450036"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 16:41:48 -0700
X-CSE-ConnectionGUID: Ul+a5TfqQzeWtVVntqfNIw==
X-CSE-MsgGUID: d0HMC7X4QHe9fpBC8h1eFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="1209371"
Received: from unknown (HELO [10.241.242.105]) ([10.241.242.105])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 16:41:48 -0700
Message-ID: <cf703658d922b4d698d35e35bb942f359971d850.camel@linux.intel.com>
Subject: Re: [RFC PATCH v3 02/13] drivers/base/arch_topology: Add support
 for initializing sbm topology
From: Tim Chen <tim.c.chen@linux.intel.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra	
 <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, Ingo Molnar	
 <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot	
 <vincent.guittot@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Arnd Bergmann	 <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-mips@vger.kernel.org,
 loongarch@lists.linux.dev, 	driver-core@lists.linux.dev, Sudeep Holla
 <sudeep.holla@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich	 <dakr@kernel.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt	
 <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman	
 <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth
 Hegde	 <sshegde@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:41:47 -0700
In-Reply-To: <20261001192849.74788-3-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
	 <20261001192849.74788-3-kprateek.nayak@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-10-01 at 19:28 +0000, K Prateek Nayak wrote:
> Add (fragile) support for initializing sparsebitmap topology for
> architectures that support GENERIC_ARCH_TOPOLOGY.
>=20
> Similar to setting cpu_smt_set_num_threads(), count the number of unique
> LLCs (if last_level_cache_is_valid() true, otherwise) / packages, and
> the maximum threads that exist in those instance and set
> sbm_set_proc_config().
>=20
> Any failure on the path will default to considering the entire processor
> as a single sbm domain and the default logic will divide the system into
> BITS_PER_LONG chunks. In case of a failure, sbm core will skip using
> arch_sbm_cpu_instance_id() and assume all CPUs belong to the same
> instance with the same instance id.
>=20
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  drivers/base/arch_topology.c | 122 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 121 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
> index 8c5e47c28d9a..f55745a93298 100644
> --- a/drivers/base/arch_topology.c
> +++ b/drivers/base/arch_topology.c
> @@ -20,6 +20,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/init.h>
>  #include <linux/rcupdate.h>
> +#include <linux/sbm.h>
>  #include <linux/sched.h>
>  #include <linux/units.h>
> =20
> @@ -930,6 +931,114 @@ __weak int __init parse_acpi_topology(void)
>  	return 0;
>  }
> =20
> +/*
> + * Note: arch_sbm_cpu_instance_id() is only used if init_sbm_topology()
> + * below succeeds at setting the sbm topology. Either the LLC
> + * information is valid or package_id is dependable.
> + */
> +int arch_sbm_cpu_instance_id(int cpu)
> +{
> +	if (last_level_cache_is_valid(cpu)) {
> +		struct cacheinfo *llc_info =3D get_cpu_cacheinfo_llc(cpu);
> +
> +		if (!llc_info)
> +			goto out;
> +
> +		if (llc_info->attributes & CACHE_ID)
> +			return llc_info->id;
> +
> +		/*
> +		 * XXX: fw_token be truncated from cast
> +		 * when the value is returned as an int.
> +		 */
> +		return (int)((long)llc_info->fw_token);
> +	}
> +out:
> +	return cpu_topology[cpu].package_id;
> +}
> +
> +static void __init init_sbm_topology(void)
> +{
> +	int num_sbm_instances =3D 0, max_threads_per_instance =3D -1;
> +	bool has_cache =3D false, has_package =3D false;
> +	cpumask_var_t unique_cpus;
> +	struct xarray instances;
> +	unsigned long cpu, *count;
> +
> +	/*
> +	 * If the allocation fails, the sbm core will use
> +	 * the default logic of splitting CPUs evenly in
> +	 * BITS_PER_LONG chunk.
> +	 */
> +	if (!zalloc_cpumask_var(&unique_cpus, GFP_KERNEL))
> +		return;
> +
> +	xa_init(&instances);
> +
> +	for_each_possible_cpu(cpu) {
> +		bool found =3D false;
> +		int unique_cpu;
> +
> +		for_each_cpu(unique_cpu, unique_cpus) {
> +			/*
> +			 * XXX: Assumes last_level_cache_is_valid() is uniformly true
> +			 * across the entire system if it is true for one CPU.
> +			 */
> +			if (last_level_cache_is_valid(cpu)) {

I don't think last_level_cache_is_valid() can be true for any CPU at
this point. Here is the call order on arm64. riscv is the same in
arch/riscv/kernel/smpboot.c.

  smp_prepare_cpus()                          arch/arm64/kernel/smp.c
    init_cpu_topology()
      fetch_cache_info(cpu)                   for every possible CPU
        allocate_cache_info(cpu)              kzalloc: all leaves are zero
      init_sbm_topology()                     <-- counts instances HERE
        last_level_cache_is_valid(cpu)        false for every CPU
        =3D> groups by package_id
    store_cpu_topology(boot cpu)
      update_siblings_masks()
        detect_cache_attributes()             boot CPU leaves filled HERE
   =20
  kernel_init_freeable()                      init/main.c=20
    sbm_init()
    alloc_sbm_index(boot cpu)
      arch_sbm_cpu_instance_id()              boot CPU: LLC id

  secondary_start_kernel()                    on each secondary CPU
    store_cpu_topology(cpu)
      update_siblings_masks()
        detect_cache_attributes(cpu)          this CPU's leaves filled HERE
  sched_cpu_activate(cpu)
    alloc_sbm_index(cpu)
      arch_sbm_cpu_instance_id()              this CPU: LLC id

last_level_cache_is_valid() only returns true when the LLC leaf has
CACHE_ID set or a fw_token:

        return (llc->attributes & CACHE_ID) || !!llc->fw_token;

Both are written only from detect_cache_attributes(), through
cache_shared_cpu_map_setup() -> cache_setup_properties():

  - DT:   cache_setup_of_node() sets fw_token and CACHE_ID
          (drivers/base/cacheinfo.c)
  - ACPI: cache_setup_acpi() sets fw_token and CACHE_ID
          (drivers/acpi/pptt.c)

fetch_cache_info() only counts the cache levels and allocates the
leaves with kzalloc, so at init_sbm_topology() time every leaf still
has attributes =3D=3D 0 and fw_token =3D=3D NULL. Not even the boot CPU has=
 its
leaves filled yet, because its store_cpu_topology() runs after
init_cpu_topology().

I think complications arise if we don't have the complete cache info.

How about updating the design to wait for cache detection instead? The
earliest point where all booted CPUs have their cacheinfo is
sched_init_smp(). That is also where the scheduler builds its own LLC
domains, from the llc_sibling masks that store_cpu_topology() fills.
Nothing needs an sbm index before then: nohz_balance_enter_idle()
returns early on on_null_domain() until the domains exist, and 12/13
already moves the nohz allocation into sched_init_smp(). Roughly:

 1. Move sbm_init() and the boot CPU's alloc_sbm_index() from
    kernel_init_freeable() to the start of sched_init_smp(), before
    init_sched_fair_class_smp().
   =20
 2. Count the instances there, over the online CPUs, with
    arch_sbm_cpu_instance_id(). At that point it can safely return
    the LLC ID. Counting and runtime then use the same function on
    the same data.
   =20
 3. Hand out indices to all active CPUs in one pass at that point. In
    sched_cpu_activate(), call alloc_sbm_index() only once
    sched_smp_initialized is set, i.e. for CPUs hotplugged later.

 4. Leave room for possible CPUs that did not boot (maxcpus=3D, or arm64
    ACPI vCPU hotplug). Their cacheinfo is still unknown at
    sched_init_smp(). Possible choice is what powerpc and s390
    do in this series: assume each of them may add a new instance, or
    land in the largest one. Their package could give a tighter bound.

Perhaps this could simplify the design.

Thanks.

Tim

> +				has_cache =3D true;
> +				if (last_level_cache_is_shared(cpu, unique_cpu)) {
> +					found =3D true;
> +					break;
> +				}
> +			} else {
> +				/* Go by package_id if no LLC information is found. */
> +				has_package =3D true;
> +				if (cpu_topology[unique_cpu].package_id =3D=3D
> +				    cpu_topology[cpu].package_id) {
> +					found =3D true;
> +					break;
> +				}
> +			}
> +		}
> +
> +		/* XXX: CPUs should not suddenly switch IDs mid way. */
> +		if (has_cache && has_package)
> +			goto out;
> +
> +		if (!found) {
> +			count =3D kzalloc_obj(*count);
> +			if (!count)
> +				goto out;
> +
> +			cpumask_set_cpu(cpu, unique_cpus);
> +			*count +=3D 1;
> +
> +			xa_store(&instances, cpu, count, GFP_KERNEL);
> +			continue;
> +		}
> +
> +		count =3D xa_load(&instances, unique_cpu);
> +		if (!count)
> +			goto out;
> +
> +		*count +=3D 1;
> +	}
> +
> +	xa_for_each(&instances, cpu, count) {
> +		max_threads_per_instance =3D max_t(int, max_threads_per_instance, *cou=
nt);
> +		num_sbm_instances++;
> +	}
> +
> +	sbm_set_topology(num_sbm_instances, max_threads_per_instance);
> +out:
> +	xa_for_each(&instances, cpu, count) {
> +		xa_erase(&instances, cpu);
> +		kfree(count);
> +	}
> +	xa_destroy(&instances);
> +	free_cpumask_var(unique_cpus);
> +}
> +
>  void __init init_cpu_topology(void)
>  {
>  	int cpu, ret;
> @@ -954,8 +1063,19 @@ void __init init_cpu_topology(void)
>  			continue;
>  		else if (ret !=3D -ENOENT)
>  			pr_err("Early cacheinfo failed, ret =3D %d\n", ret);
> -		return;
> +		break;
>  	}
> +
> +	/*
> +	 * If fetch_cache_info() fails for first CPU,
> +	 * init_cpu_sbm_topology() will use pacakge_id instead.
> +	 *
> +	 * Uniform cache topology is a necessary since implementation
> +	 * assumes last_level_cache_is_valid() gives same result for
> +	 * all possible CPUs
> +	 */
> +	if (!ret || (cpu =3D=3D 0 && ret =3D=3D -ENOENT))
> +		init_sbm_topology();
>  }
> =20
>  void store_cpu_topology(unsigned int cpuid)
