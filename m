Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04120C465
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 08:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747209752; cv=none; b=JtG747XfnJNs2ZZN/ySQ+W6AmrpHjWsEZrjAYxxR2TTxpJ52hKdujt9KYnv8393aM1m+SQrKQ+iEEgnvTw0XhQNhSB/A5eU0AQRqe35SDqxmFdeQZct+DDoF1eejB/S7myyt4S0io65OcRXkKnU+SMtbtYYTnJ9OUAlDXOKjC/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747209752; c=relaxed/simple;
	bh=xqHgvAYCC9t6MZ7wyX6GrXISDsKjOo/Grz/it3buzvI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rse8PH4R40Mm7+vkMUBO7S3aj8cf5P6ldIZgyOkJfDweyshQBIyrPQ1BkwqGElSW6VvVi9DJ+egShXKIcXnl0tNbW/RBsN7+dWLy7h0lfvGpZf87fgAEjU9ORUnHCi/fiUp7tZdWI/3o7y+GhQ8mAk2M6X4xN8aC7W9uVK4oxew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DaNi4Qjm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaNi4Qjm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747209749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ET5iCd8MyKLHEGzFDUiYbW8pYPvNTTRlK86QIMS0syE=;
	b=DaNi4QjmDZag9fvwmgNXFnMFMOj2FZGRo3mVc+hVeS3NC20k24uOjtn9GiWmMVi/qrpxYy
	9DC0xLhfkW3RP0IgZNmlzujqy6bYDP/d0C3kcfHvLFMkDE2PYOXjovrPecHc8s8eqFa/LF
	wp0yCzoUSArX9ppxYgvHML6dWohD6Ik=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-fbfVFhVgPyKSVbpnfaV_Ng-1; Wed, 14 May 2025 04:02:28 -0400
X-MC-Unique: fbfVFhVgPyKSVbpnfaV_Ng-1
X-Mimecast-MFC-AGG-ID: fbfVFhVgPyKSVbpnfaV_Ng_1747209748
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7424d8944b6so484475b3a.1
        for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 01:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747209747; x=1747814547;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ET5iCd8MyKLHEGzFDUiYbW8pYPvNTTRlK86QIMS0syE=;
        b=oP5e8Wng8kQIPvz1bCMMhjXCx2CBnQE4f0XKqnpVuw55vVEfH0osvppUVxPcj/jxI4
         pV6sfzgwReqfJxIPIlxfMLpolrJlED1G3mPzNmMiPwh2YT6bpU1z5KniNX0ECVHeKqlN
         sYL1KV6cUGkMiEM0S1A67FaJrd8fclJu2n1o5O7v9ZAieqdnWXDL/m/ChOato0Szo7QI
         XnGXQsWZVRhitgHnwZNg5DvNdcywqy4zJYfnuymM+fyYbm4wSOy3RoA/ZtOnRx24cg7Z
         8/kMQx6LJPMJb0n7tKZbdlHILZmfx41fmAE1V+Wn5elQ1p9BaT76ezrmmwEmmAXfcZHM
         pbMg==
X-Forwarded-Encrypted: i=1; AJvYcCW8cReWRqsyhBZqpLsvv3B2aCKY2kocHsu2e1TS9XHufevSDiiuK1XJ+UrlpetnbxKhpilM8mYZKIuP@vger.kernel.org
X-Gm-Message-State: AOJu0YxdTGhnlbBYhEjtj/pFtzZ3+C7CD1te+AfYV3HaLCoq/JhAeYJf
	5JRqr1IBHgo484UbqDIKV65+bfYZBR1ezkMMy0E7OBtv96JQ7LGcXV/9ADidC3Ho/keWRSjWsHy
	+4jwFOGpbro1pCgyX7NSDJxGwyeILr/VlUc3yEuJH595cNGwfOn2wArKJ3cE=
X-Gm-Gg: ASbGnct3//hiZgEHeBcZcnpC8jLzb4Q1YlFHWLKqzSj45IlkUrKor1CWCvqrd5Cj3Z2
	fskj3HWZazEGQp8Q6GI63wRaGyKtQg8V/L5QImTXz4jnj+kEVCB+5Q+fHgUcMUMWaYZHS7xwRnH
	YZP7aiDxMS6NV9MZA1C4wa5QBX+jfo4HLD8jWVK6bGWYoPfANtfHy4uR7RWDUVZ6FdiK54ElgKh
	l5rUz1trepdcgqLf3//VydCLQOVoVDLYTlHRWqKqRCN3o3i3Vd01NamPfzMsB07ig7KFZrieJLv
	UP1NZNNAEoGX42tw
X-Received: by 2002:a05:6a00:811a:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-7427917883cmr7436403b3a.9.1747209747409;
        Wed, 14 May 2025 01:02:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwhqdQhP9GhHKMFywwgH/LIw6XImxil66dwro2onM7heCubGabPHGV/eyERLOa/TP3h81BbA==
X-Received: by 2002:a05:6a00:811a:b0:736:4c3d:2cba with SMTP id d2e1a72fcca58-7427917883cmr7436362b3a.9.1747209747028;
        Wed, 14 May 2025 01:02:27 -0700 (PDT)
Received: from [10.72.116.125] ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7423772752csm8775799b3a.45.2025.05.14.01.02.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 01:02:26 -0700 (PDT)
Message-ID: <74a90a55-80ae-45ff-9b37-7cb2771ed0e0@redhat.com>
Date: Wed, 14 May 2025 16:02:17 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 07/16] scripts: Use an associative array
 for qemu argument names
To: Alexandru Elisei <alexandru.elisei@arm.com>, andrew.jones@linux.dev,
 eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com,
 david@redhat.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, will@kernel.org, julien.thierry.kdev@gmail.com,
 maz@kernel.org, oliver.upton@linux.dev, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, joey.gouly@arm.com, andre.przywara@arm.com
References: <20250507151256.167769-1-alexandru.elisei@arm.com>
 <20250507151256.167769-8-alexandru.elisei@arm.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20250507151256.167769-8-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/25 11:12 PM, Alexandru Elisei wrote:
> Move away from hardcoded qemu arguments and use instead an associative
> array to get the needed arguments. This paves the way for adding kvmtool
> support to the scripts, which has a different syntax for the same VM
> configuration parameters.
> 
> Suggested-by: Andrew Jones <andrew.jones@linux.dev>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>

Reviewed-by: Shaoqin Huang <shahuang@redhat.com>

> ---
>   scripts/common.bash  | 10 +++++++---
>   scripts/runtime.bash |  7 +------
>   scripts/vmm.bash     |  7 +++++++
>   3 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/common.bash b/scripts/common.bash
> index 9deb87d4050d..649f1c737617 100644
> --- a/scripts/common.bash
> +++ b/scripts/common.bash
> @@ -1,4 +1,5 @@
>   source config.mak
> +source scripts/vmm.bash
>   
>   function for_each_unittest()
>   {
> @@ -26,8 +27,11 @@ function for_each_unittest()
>   				$(arch_cmd) "$cmd" "$testname" "$groups" "$smp" "$kernel" "$test_args" "$opts" "$arch" "$machine" "$check" "$accel" "$timeout"
>   			fi
>   			testname=$rematch
> -			smp=1
> +			smp="${vmm_opts[$TARGET:nr_cpus]} 1"
>   			kernel=""
> +			# Intentionally don't use -append if test_args is empty
> +			# because qemu interprets the first argument after
> +			# -append as a kernel parameter.
>   			test_args=""
>   			opts=""
>   			groups=""
> @@ -39,9 +43,9 @@ function for_each_unittest()
>   		elif [[ $line =~ ^file\ *=\ *(.*)$ ]]; then
>   			kernel=$TEST_DIR/${BASH_REMATCH[1]}
>   		elif [[ $line =~ ^smp\ *=\ *(.*)$ ]]; then
> -			smp=${BASH_REMATCH[1]}
> +			smp="${vmm_opts[$TARGET:nr_cpus]} ${BASH_REMATCH[1]}"
>   		elif [[ $line =~ ^test_args\ *=\ *(.*)$ ]]; then
> -			test_args=${BASH_REMATCH[1]}
> +			test_args="${vmm_opts[$TARGET:args]} ${BASH_REMATCH[1]}"
>   		elif [[ $line =~ ^(extra_params|qemu_params)\ *=\ *'"""'(.*)$ ]]; then
>   			opts=${BASH_REMATCH[2]}$'\n'
>   			while read -r -u $fd; do
> diff --git a/scripts/runtime.bash b/scripts/runtime.bash
> index 06cc58e79b69..86d8a2cd8528 100644
> --- a/scripts/runtime.bash
> +++ b/scripts/runtime.bash
> @@ -34,7 +34,7 @@ premature_failure()
>   get_cmdline()
>   {
>       local kernel=$1
> -    echo "TESTNAME=$testname TIMEOUT=$timeout MACHINE=$machine ACCEL=$accel $RUNTIME_arch_run $kernel -smp $smp $opts"
> +    echo "TESTNAME=$testname TIMEOUT=$timeout MACHINE=$machine ACCEL=$accel $RUNTIME_arch_run $kernel $smp $test_args $opts"
>   }
>   
>   skip_nodefault()
> @@ -88,11 +88,6 @@ function run()
>       local accel="${10}"
>       local timeout="${11:-$TIMEOUT}" # unittests.cfg overrides the default
>   
> -    # If $test_args is empty, qemu will interpret the first option after -append
> -    # as a kernel parameter instead of a qemu option, so make sure the -append
> -    # option is used only if $test_args is not empy.
> -    [ -n "$test_args" ] && opts="-append $test_args $opts"
> -
>       if [ "${CONFIG_EFI}" == "y" ]; then
>           kernel=${kernel/%.flat/.efi}
>       fi
> diff --git a/scripts/vmm.bash b/scripts/vmm.bash
> index 39325858c6b3..b02055a5c0b6 100644
> --- a/scripts/vmm.bash
> +++ b/scripts/vmm.bash
> @@ -1,5 +1,12 @@
>   source config.mak
>   
> +declare -A vmm_opts=(
> +	[qemu:nr_cpus]='-smp'
> +	[qemu:kernel]='-kernel'
> +	[qemu:args]='-append'
> +	[qemu:initrd]='-initrd'
> +)
> +
>   function check_vmm_supported()
>   {
>   	case "$TARGET" in

-- 
Shaoqin

