Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842D028C001
	for <linux-s390@vger.kernel.org>; Wed,  7 May 2025 16:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635315; cv=none; b=sbTWUR+b+hckvQpdUC3ElKAQBypqqr/GMyCXbr9QuUmWo9NV76zaEzi+eoheWknhV5ST9pNvIvcARFbYl13nrWnLsyhiPYAAG1NJbvM9e5mIF+zorWIvdCw8kG1xKdMAqH2oFhDrDxNUga4wQFF9rIdAx6ySiKH/C6gt7PpRlLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635315; c=relaxed/simple;
	bh=TT+UoXuYBmMJxxhppevuQ0J1d23IRGpWKdN5CaPsUmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIPyTOVFaXKPk2Rlg3VekfmLk2vywrKRDPQXrS2OLGXxNRkw471rM72ue/bvXewBMDL7e1zZzO8xY9+udjN0J53i/SDdcjbDCYgrEwTojsHmMM9CUuD19iXtucgaod4CjQgEE3OLuGO5cgpSvDCb0KN3ZwTiNKR/SmGWV8lu2tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TVM5u1Ga; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TVM5u1Ga"
Date: Wed, 7 May 2025 18:28:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746635301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uZ+/PxtWl6nzVoV+9eYTtusxdZ2MaYcOmQ2l7+j67sY=;
	b=TVM5u1Ganj79z24Twq6gaJYAt9iMdS0VxRM0OG3WFSrBd1rv+EbJutGo8RW0mUp/LUn2rG
	X1i07Tn0fPYmdATTaWRI73gPVE6aw6YbuFCr7JlRJGmI6R/VOi+mUv+tpsucptjZWM3kS5
	DIOnui57Wgn7Ezh3Z2mEGIV03RI+9AA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com, 
	frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com, david@redhat.com, 
	pbonzini@redhat.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	will@kernel.org, julien.thierry.kdev@gmail.com, maz@kernel.org, 
	oliver.upton@linux.dev, suzuki.poulose@arm.com, yuzenghui@huawei.com, joey.gouly@arm.com, 
	andre.przywara@arm.com
Subject: Re: [kvm-unit-tests PATCH v3 08/16] scripts: Add 'kvmtool_params' to
 test definition
Message-ID: <20250507-5b376c9bc878cbdffabdb3c2@orel>
References: <20250507151256.167769-1-alexandru.elisei@arm.com>
 <20250507151256.167769-9-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507151256.167769-9-alexandru.elisei@arm.com>
X-Migadu-Flow: FLOW_OUT

On Wed, May 07, 2025 at 04:12:48PM +0100, Alexandru Elisei wrote:
> arm/arm64 supports running tests under kvmtool, but kvmtool's syntax for
> running and configuring a virtual machine is different to qemu. To run
> tests using the automated test infrastructure, add a new test parameter,
> 'kvmtool_params'. The parameter serves the exact purpose as 'qemu_params',
> but using kvmtool's syntax.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>  arm/unittests.cfg   | 24 +++++++++++++++++++++++
>  docs/unittests.txt  |  8 ++++++++
>  scripts/common.bash | 47 +++++++++++++++++++++++++++++----------------
>  3 files changed, 62 insertions(+), 17 deletions(-)
> 
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index a4192ed7e20b..f3c773e56933 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -17,6 +17,7 @@ file = selftest.flat
>  smp = 2
>  test_args = 'setup smp=2 mem=256'
>  qemu_params = -m 256
> +kvmtool_params = --mem 256
>  groups = selftest
>  
>  # Test vector setup and exception handling (kernel mode).
> @@ -48,66 +49,77 @@ groups = pci
>  file = pmu.flat
>  groups = pmu
>  test_args = "cycle-counter 0"
> +kvmtool_params = --pmu
>  
>  [pmu-event-introspection]
>  file = pmu.flat
>  groups = pmu
>  arch = arm64
>  test_args = pmu-event-introspection
> +kvmtool_params = --pmu
>  
>  [pmu-event-counter-config]
>  file = pmu.flat
>  groups = pmu
>  arch = arm64
>  test_args = pmu-event-counter-config
> +kvmtool_params = --pmu
>  
>  [pmu-basic-event-count]
>  file = pmu.flat
>  groups = pmu
>  arch = arm64
>  test_args = pmu-basic-event-count
> +kvmtool_params = --pmu
>  
>  [pmu-mem-access]
>  file = pmu.flat
>  groups = pmu
>  arch = arm64
>  test_args = pmu-mem-access
> +kvmtool_params = --pmu
>  
>  [pmu-mem-access-reliability]
>  file = pmu.flat
>  groups = pmu
>  arch = arm64
>  test_args = pmu-mem-access-reliability
> +kvmtool_params = --pmu
>  
>  [pmu-sw-incr]
>  file = pmu.flat
>  groups = pmu
>  arch = arm64
>  test_args = pmu-sw-incr
> +kvmtool_params = --pmu
>  
>  [pmu-chained-counters]
>  file = pmu.flat
>  groups = pmu
>  arch = arm64
>  test_args = pmu-chained-counters
> +kvmtool_params = --pmu
>  
>  [pmu-chained-sw-incr]
>  file = pmu.flat
>  groups = pmu
>  arch = arm64
>  test_args = pmu-chained-sw-incr
> +kvmtool_params = --pmu
>  
>  [pmu-chain-promotion]
>  file = pmu.flat
>  groups = pmu
>  arch = arm64
>  test_args = pmu-chain-promotion
> +kvmtool_params = --pmu
>  
>  [pmu-overflow-interrupt]
>  file = pmu.flat
>  groups = pmu
>  arch = arm64
>  test_args = pmu-overflow-interrupt
> +kvmtool_params = --pmu
>  
>  # Test PMU support (TCG) with -icount IPC=1
>  #[pmu-tcg-icount-1]
> @@ -131,6 +143,7 @@ file = gic.flat
>  smp = $((($MAX_SMP < 8)?$MAX_SMP:8))
>  test_args = ipi
>  qemu_params = -machine gic-version=2
> +kvmtool_params = --irqchip=gicv2
>  groups = gic
>  
>  [gicv2-mmio]
> @@ -138,6 +151,7 @@ file = gic.flat
>  smp = $((($MAX_SMP < 8)?$MAX_SMP:8))
>  test_args = mmio
>  qemu_params = -machine gic-version=2
> +kvmtool_params = --irqchip=gicv2
>  groups = gic
>  
>  [gicv2-mmio-up]
> @@ -145,6 +159,7 @@ file = gic.flat
>  smp = 1
>  test_args = mmio
>  qemu_params = -machine gic-version=2
> +kvmtool_params = --irqchip=gicv2
>  groups = gic
>  
>  [gicv2-mmio-3p]
> @@ -152,6 +167,7 @@ file = gic.flat
>  smp = $((($MAX_SMP < 3)?$MAX_SMP:3))
>  test_args = mmio
>  qemu_params = -machine gic-version=2
> +kvmtool_params = --irqchip=gicv2
>  groups = gic
>  
>  [gicv3-ipi]
> @@ -159,6 +175,7 @@ file = gic.flat
>  smp = $MAX_SMP
>  test_args = ipi
>  qemu_params = -machine gic-version=3
> +kvmtool_params = --irqchip=gicv3
>  groups = gic
>  
>  [gicv2-active]
> @@ -166,6 +183,7 @@ file = gic.flat
>  smp = $((($MAX_SMP < 8)?$MAX_SMP:8))
>  test_args = active
>  qemu_params = -machine gic-version=2
> +kvmtool_params = --irqchip=gicv2
>  groups = gic
>  
>  [gicv3-active]
> @@ -173,6 +191,7 @@ file = gic.flat
>  smp = $MAX_SMP
>  test_args = active
>  qemu_params = -machine gic-version=3
> +kvmtool_params = --irqchip=gicv3
>  groups = gic
>  
>  [its-introspection]
> @@ -180,6 +199,7 @@ file = gic.flat
>  smp = $MAX_SMP
>  test_args = its-introspection
>  qemu_params = -machine gic-version=3
> +kvmtool_params = --irqchip=gicv3-its
>  groups = its
>  arch = arm64
>  
> @@ -188,6 +208,7 @@ file = gic.flat
>  smp = $MAX_SMP
>  test_args = its-trigger
>  qemu_params = -machine gic-version=3
> +kvmtool_params = --irqchip=gicv3-its
>  groups = its
>  arch = arm64
>  
> @@ -196,6 +217,7 @@ file = gic.flat
>  smp = $MAX_SMP
>  test_args = its-migration
>  qemu_params = -machine gic-version=3
> +kvmtool_params = --irqchip=gicv3
>  groups = its migration
>  arch = arm64
>  
> @@ -204,6 +226,7 @@ file = gic.flat
>  smp = $MAX_SMP
>  test_args = its-pending-migration
>  qemu_params = -machine gic-version=3
> +kvmtool_params = --irqchip=gicv3
>  groups = its migration
>  arch = arm64
>  
> @@ -212,6 +235,7 @@ file = gic.flat
>  smp = $MAX_SMP
>  test_args = its-migrate-unmapped-collection
>  qemu_params = -machine gic-version=3
> +kvmtool_params = --irqchip=gicv3
>  groups = its migration
>  arch = arm64
>  
> diff --git a/docs/unittests.txt b/docs/unittests.txt
> index ea0da959f008..a9164bccc24c 100644
> --- a/docs/unittests.txt
> +++ b/docs/unittests.txt
> @@ -78,6 +78,14 @@ extra_params
>  Alias for 'qemu_params', supported for compatibility purposes. Use
>  'qemu_params' for new tests.
>  
> +kvmtool_params
> +--------------
> +Extra parameters supplied to the kvmtool process. Works similarly to
> +'qemu_params', but uses kvmtool's syntax for command line arguments. The
> +example for 'qemu_params', applied to kvmtool, would be:
> +
> +kvmtool_params = --mem 256
> +
>  groups
>  ------
>  groups = <group_name1> <group_name2> ...
> diff --git a/scripts/common.bash b/scripts/common.bash
> index 649f1c737617..0645235d8baa 100644
> --- a/scripts/common.bash
> +++ b/scripts/common.bash
> @@ -1,6 +1,29 @@
>  source config.mak
>  source scripts/vmm.bash
>  
> +function parse_opts()
> +{
> +	local opts="$1"
> +	local fd="$2"
> +
> +	while read -r -u $fd; do
> +		#escape backslash newline, but not double backslash
> +		if [[ $opts =~ [^\\]*(\\*)$'\n'$ ]]; then
> +			if (( ${#BASH_REMATCH[1]} % 2 == 1 )); then
> +				opts=${opts%\\$'\n'}
> +			fi
> +		fi
> +		if [[ "$REPLY" =~ ^(.*)'"""'[:blank:]*$ ]]; then
> +			opts+=${BASH_REMATCH[1]}
> +			break
> +		else
> +			opts+=$REPLY$'\n'
> +		fi
> +	done
> +
> +	echo "$opts"
> +}
> +
>  function for_each_unittest()
>  {
>  	local unittests="$1"
> @@ -46,24 +69,14 @@ function for_each_unittest()
>  			smp="${vmm_opts[$TARGET:nr_cpus]} ${BASH_REMATCH[1]}"
>  		elif [[ $line =~ ^test_args\ *=\ *(.*)$ ]]; then
>  			test_args="${vmm_opts[$TARGET:args]} ${BASH_REMATCH[1]}"
> -		elif [[ $line =~ ^(extra_params|qemu_params)\ *=\ *'"""'(.*)$ ]]; then
> -			opts=${BASH_REMATCH[2]}$'\n'
> -			while read -r -u $fd; do
> -				#escape backslash newline, but not double backslash
> -				if [[ $opts =~ [^\\]*(\\*)$'\n'$ ]]; then
> -					if (( ${#BASH_REMATCH[1]} % 2 == 1 )); then
> -						opts=${opts%\\$'\n'}
> -					fi
> -				fi
> -				if [[ "$REPLY" =~ ^(.*)'"""'[:blank:]*$ ]]; then
> -					opts+=${BASH_REMATCH[1]}
> -					break
> -				else
> -					opts+=$REPLY$'\n'
> -				fi
> -			done
> -		elif [[ $line =~ ^(extra_params|qemu_params)\ *=\ *(.*)$ ]]; then
> +		elif [[ $TARGET = "qemu" ]] && [[ $line =~ ^(extra_params|qemu_params)\ *=\ *'"""'(.*)$ ]]; then

Should use == with [[ ]]

> +			opts=$(parse_opts ${BASH_REMATCH[2]}$'\n' $fd)
> +		elif [[ $TARGET  = "qemu" ]] && [[ $line =~ ^(extra_params|qemu_params)\ *=\ *(.*)$ ]]; then
                               ^ extra space

>  			opts=${BASH_REMATCH[2]}
> +		elif [[ $TARGET = "kvmtool" ]] && [[ $line =~ ^kvmtool_params\ *=\ *'"""'(.*)$ ]]; then
> +			opts=$(parse_opts ${BASH_REMATCH[1]}$'\n' $fd)
> +		elif [[ $TARGET = "kvmtool" ]] && [[ $line =~ ^kvmtool_params\ *=\ *(.*)$ ]]; then
> +			opts=${BASH_REMATCH[1]}

I think we can do something like

if [[ $TARGET == "qemu" ]]; then
   params='(extra_params|qemu_params)'
elif [[ $TARGET == "kvmtool" ]]; then
   params='(kvmtool_params)'
else
   ...fail...
fi

And then use $params in the regular expressions and always use
BASH_REMATCH[2]. That would allow us to avoid duplicating the if
statements and then we wouldn't need to factor out parse_opts either.

Thanks,
drew

>  		elif [[ $line =~ ^groups\ *=\ *(.*)$ ]]; then
>  			groups=${BASH_REMATCH[1]}
>  		elif [[ $line =~ ^arch\ *=\ *(.*)$ ]]; then
> -- 
> 2.49.0
> 
> 
> -- 
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
