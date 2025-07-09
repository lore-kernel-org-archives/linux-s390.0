Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60E527FD72
	for <linux-s390@vger.kernel.org>; Wed,  9 Jul 2025 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752056210; cv=none; b=eJodLWynEhcRU7NE0nkT47ASETiMSzg494zl8lapSKtzwS6rfa6LBH57ZSmPVHLUl453PgQitE8cXpIQCTKKFiadrpTxQHJ1uyU/1TlzVD/YtTknw69emQpi3gv5KRYRU1wi3pdgtKwhVWO4l8zJ4PfIiuWRsTII3ru5LiUhMuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752056210; c=relaxed/simple;
	bh=X5ErKMiWcEcreH4yoyc2jIxyoon19lq8xZAhTxORE4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kj8zamr/ACacEhIsDjvZv/Xwr4qY9A++nGhKwfVzmVk9Y/LBT6WHw20VumE45+/BJlx0LQXzSheW67cWM/EpNGCC6Qx0IR8UUIYiQPfCimk9HjK9KKwC/8fmdZh2+x5MiNs+UZ9hvXRP0SsVMMNT7biHaBLApTAVB3f/2HYcnQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91D3F153B;
	Wed,  9 Jul 2025 03:16:36 -0700 (PDT)
Received: from raptor (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF5613F694;
	Wed,  9 Jul 2025 03:16:46 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:16:40 +0100
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: Andrew Jones <andrew.jones@linux.dev>
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com,
	imbrenda@linux.ibm.com, nrb@linux.ibm.com, david@redhat.com,
	thuth@redhat.com, alexandru.elisei@arm.com
Subject: Re: [kvm-unit-tests PATCH] s390x: Fix arch_cmd
Message-ID: <aG5BbHg3nK5w3mmH@raptor>
References: <20250709085938.33254-2-andrew.jones@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709085938.33254-2-andrew.jones@linux.dev>

Hi Drew,

On Wed, Jul 09, 2025 at 10:59:39AM +0200, Andrew Jones wrote:
> As commit ("scripts: Add 'test_args' test definition parameter") states
> in its summary, it adds another parameter. Make sure we account for it
> in the s390x-specific arch_cmd as well.
> 
> Fixes: a7794f16c84a ("scripts: Add 'test_args' test definition parameter")
> Signed-off-by: Andrew Jones <andrew.jones@linux.dev>
> ---
>  scripts/s390x/func.bash | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/scripts/s390x/func.bash b/scripts/s390x/func.bash
> index f04e8e2ac0a7..28c3a70c7da9 100644
> --- a/scripts/s390x/func.bash
> +++ b/scripts/s390x/func.bash
> @@ -11,15 +11,16 @@ function arch_cmd_s390x()
>  	local groups=$3
>  	local smp=$4
>  	local kernel=$5
> -	local opts=$6
> -	local arch=$7
> -	local machine=$8
> -	local check=$9
> -	local accel=${10}
> -	local timeout=${11}
> +	local test_args=$6
> +	local opts=$7
> +	local arch=$8
> +	local machine=$9
> +	local check=${10}
> +	local accel=${11}
> +	local timeout=${12}
>  
>  	# run the normal test case
> -	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
> +	"$cmd" "$testname" "$groups" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
>  
>  	# run PV test case
>  	if [ "$accel" = 'tcg' ] || grep -q "migration" <<< "$groups"; then
> @@ -35,5 +36,5 @@ function arch_cmd_s390x()
>  		print_result 'SKIP' $testname '' 'PVM image was not created'
>  		return 2
>  	fi
> -	"$cmd" "$testname" "$groups pv" "$smp" "$kernel" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
> +	"$cmd" "$testname" "$groups pv" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
>  }

My bad, I vaguely remember having this change in an earlier version of kvmtool
support, but I must have dropped it at some point.

Looks correct to me, it matches the arguments from for_each_unittest():

Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,
Alex
