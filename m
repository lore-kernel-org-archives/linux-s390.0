Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A76ADD
	for <linux-s390@vger.kernel.org>; Fri, 11 Jul 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752244946; cv=none; b=tYRBdbM7mVrLOucDRwDCb53F2hYf5ag2wVk+6sozh6lkxispjpNQG7DamxEEMEnAGlIOQuaAdEc7+UtUKa+ov9N+C/7RTJ2pE9wQHWW/21U5D89xoYr/m0JlOLLKZapnqpOFlQafi0j4CcWHs9mKSVCbmIVDDp0ad1HaGBwKIME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752244946; c=relaxed/simple;
	bh=JoMednrKudpwTyk7fCMiSyL4oUGwSjsw9+UIGNz8hSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pArZAB+YKHbWMju7Ch7W9RXfeBmAp5CKhNdOXhZVlSjXHZwmNDGRHW6Zt6+77NGrPGwFOTXGyFCuzWF+bx7FcubiJMzbagX+bhr3uCmasayX9VgJ/WnsrxMh0e+K5kcFVIAVWDN+IQ6o7EsO9AE8IiyyivvAdK2VZgq4t6f/8Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I1ZhSoEW; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I1ZhSoEW"
Date: Fri, 11 Jul 2025 16:42:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752244942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9G1BdM4qfT0oQ7ApJDmEyueaQpLwC7hH32eQ/UuLFvE=;
	b=I1ZhSoEWbWl0wSWh66zRHvktrp/gFMkrXBG3YCjraKnHsDujGqIODtK75Nl6fXOVnit9Cf
	aXvzr+Y3Kez00ltKIuM+8XztiQlkb1Pa4vzs3wyfrSRmaoN4aGn5B2pRJJrPPajd0143Ef
	8dN7Ws4wO3QvZv9Gu1ZSUnkWvGIeVOo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Andrew Jones <andrew.jones@linux.dev>
To: linux-s390@vger.kernel.org
Cc: frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com, 
	david@redhat.com, thuth@redhat.com, alexandru.elisei@arm.com
Subject: Re: [kvm-unit-tests PATCH] s390x: Fix arch_cmd
Message-ID: <20250711-b9072e156b846ac853439d0c@orel>
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
X-Migadu-Flow: FLOW_OUT

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
> -- 
> 2.49.0
>

Merged.
