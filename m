Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876DE53363
	for <linux-s390@vger.kernel.org>; Thu, 23 Jan 2025 16:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737648793; cv=none; b=huoek2R3L90TaZevWHXzf8Wp8pcfZrlCrs1TfN+Gsxq/mCL1w9lu6dRyfJQfE2vK3vVXBm3+b7yeMQP9+q0MEqAmzpRzFx1/mGmuf1KWjrg3SxEkv+brsp1TIyzINh8O1W5RdwAIJqkW3/zWaF+B+Y9F95dDi372u9U6KI8f1n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737648793; c=relaxed/simple;
	bh=MNLui14fZN+6VJ/pKz9DfN7dkjAM5YauH7/78gtwiu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJaKp20M+T1nLQpVQElW8SxU9qaJY0wl6lWwSs9QIRGWY5Qr5baagLTI8452lfv+3mZ8r9y8YIeylhZY/oG/eaFp+0FCv1aO8XkRoIigDzJwRWlLkHTsk11eF7NHS+KTG8aFNavcFmd9kIF3SVanKP9/TBB9Q5HNkYPNAAvLVvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CdEfjCZ0; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CdEfjCZ0"
Date: Thu, 23 Jan 2025 17:12:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1737648778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KVjcAL8dszFablg6zSOCb3X5h1b08qnMEWy+SAhCX+M=;
	b=CdEfjCZ0Emw7h2C19EyXfNIlFLFlSQXcDoTQIFOgT5XRbA1/Xz3R9t/N9SzXK6Vrvnin4X
	thEzxRsofkjpUjgLII97kjT6y2k88hlNfM5KzQjaW1LQEg9alaJFQ1D/+bQMC7zS3QqQvt
	Sazw3uVx63g7NHOdP/RnHLQV2SRqarU=
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
Subject: Re: [kvm-unit-tests PATCH v2 18/18] run_tests: Enable kvmtool
Message-ID: <20250123-30dd5e1694818e0d0228131b@orel>
References: <20250120164316.31473-1-alexandru.elisei@arm.com>
 <20250120164316.31473-19-alexandru.elisei@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120164316.31473-19-alexandru.elisei@arm.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jan 20, 2025 at 04:43:16PM +0000, Alexandru Elisei wrote:
> Everything is in place to run the tests using kvmtool:
> 
> $ ./configure --target=kvmtool
> $ make clean && make
> $ KVMTOOL=<path/to/kvmtool> ./run_tests.sh
> 
> so enable it, and remove ERRATA_FORCE=y when configuring for kvmtool,
> because the runner will generate and pass the correct environment to
> kvmtool.
> 
> Missing is support for EFI tests. That's because distros don't ship a
> EDK2 binary compiled for kvmtool, and on top of that kvm-unit-tests as
> an EFI app hasn't been tested to work with kvmtool.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
> 
> Should I also revert commit 35145f140442 ("arm/arm64: kvmtool: force all tests
> to run") which introduced ERRATA_FORCE? I didn't do this now in case other
> architectures use it/planning to use it.

We can leave ERRATA_FORCE, I use from time to time for quick testing.

> 
>  README.md               | 15 +++++++++++++++
>  arm/run                 |  2 +-
>  configure               |  1 -
>  run_tests.sh            |  2 +-
>  scripts/mkstandalone.sh |  2 +-
>  5 files changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/README.md b/README.md
> index be07dc28a094..5e7706f02553 100644
> --- a/README.md
> +++ b/README.md
> @@ -65,6 +65,9 @@ or:
>  
>  to run them all.
>  
> +All tests can be run using QEMU. On arm and arm64, tests can also be run using
> +kvmtool.
> +
>  By default the runner script searches for a suitable QEMU binary in the system.
>  To select a specific QEMU binary though, specify the QEMU=path/to/binary
>  environment variable:
> @@ -80,10 +83,22 @@ For running tests that involve migration from one QEMU instance to another
>  you also need to have the "ncat" binary (from the nmap.org project) installed,
>  otherwise the related tests will be skipped.
>  
> +To run a test with kvmtool, please configure kvm-unit-tests accordingly first:
> +
> +   ./configure --arch=arm64 --target=kvmtool
> +
> +then run the test(s) like with QEMU above.
> +
> +To select a kvmtool binary, specify the KVMTOOL=path/to/binary environment
> +variable. kvmtool supports only kvm as the accelerator.
> +
>  ## Running the tests with UEFI
>  
>  Check [x86/efi/README.md](./x86/efi/README.md).
>  
> +On arm and arm64, this is only supported with QEMU; kvmtool cannot run the
> +tests under UEFI.
> +
>  # Tests configuration file
>  
>  The test case may need specific runtime configurations, for
> diff --git a/arm/run b/arm/run
> index 880d5afae86d..438a2617e564 100755
> --- a/arm/run
> +++ b/arm/run
> @@ -10,7 +10,7 @@ if [ -z "$KUT_STANDALONE" ]; then
>  fi
>  
>  case "$TARGET" in
> -qemu)
> +qemu | kvmtool)
>      ;;
>  *)
>     echo "'$TARGET' not supported"
> diff --git a/configure b/configure
> index 86cf1da36467..17d3d931f2c0 100755
> --- a/configure
> +++ b/configure
> @@ -299,7 +299,6 @@ elif [ "$arch" = "arm" ] || [ "$arch" = "arm64" ]; then
>          arm_uart_early_addr=0x09000000
>      elif [ "$target" = "kvmtool" ]; then
>          arm_uart_early_addr=0x1000000
> -        errata_force=1
>      else
>          echo "--target must be one of 'qemu' or 'kvmtool'!"
>          usage
> diff --git a/run_tests.sh b/run_tests.sh
> index d38954be9093..3921dcdcb344 100755
> --- a/run_tests.sh
> +++ b/run_tests.sh
> @@ -110,7 +110,7 @@ while [ $# -gt 0 ]; do
>  done
>  
>  case "$TARGET" in
> -qemu)
> +qemu | kvmtool)
>      ;;
>  *)
>      echo "$0 does not support '$TARGET'"
> diff --git a/scripts/mkstandalone.sh b/scripts/mkstandalone.sh
> index 10abb5e191b7..16383b05adfa 100755
> --- a/scripts/mkstandalone.sh
> +++ b/scripts/mkstandalone.sh
> @@ -8,7 +8,7 @@ source config.mak
>  source scripts/common.bash
>  
>  case "$TARGET" in
> -qemu)
> +qemu | kvmtool)
>      ;;
>  *)
>      echo "'$TARGET' not supported for standlone tests"
> -- 
> 2.47.1
>

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
