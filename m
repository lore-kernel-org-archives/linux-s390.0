Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA77F1D89E3
	for <linux-s390@vger.kernel.org>; Wed, 21 May 2025 03:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747797706; cv=none; b=JAvfOS9It5BvI+GJp/8bKBxHGlnxNuTNVdfQc2aarYGNd90eE1icMMH81zRr2set6MqMkjk4irRFG+jhs2b2QSauV0F0l4BiqTWHPSOOVglGJPwgu47VOgJXdwHQ3jm9Gn8DDL4IOpI3LayYvu9fiXRrQKEtsjTddHI14TjOlJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747797706; c=relaxed/simple;
	bh=2GJVJSHxG7TNTDIWEF3lOgcb68A6g+jAddK5dW3eqKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D2PuQc286PaqFUcPNvYayGZeoNGySb3+7711n58uoh1gwxJnGE94RLHB8XLyteLjRIXKLQSgXfDsHw67nJ3xaiExZY8yGqba/5SYG1AkbybNuvH7VtOSm/7ow33l+0BmNZlDpUhjL7OaAgKp7Vk45O0v8EBMSuFstKGet/vqZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E0NkF/rt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0NkF/rt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747797701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUSOmA0/3Qa3aXRPXfKpDedwfKwE88WYumy/XPPRjQc=;
	b=E0NkF/rtg1DSSk/SjyINkCtqcvfdyA/jsGRDJD9E06lp95tE4ee1922NzFwdZTl7AUaLYX
	Mjg7RMbeLBvrkt2GdMW+U/EBpCU6BEMyvBU4lWe7Lmx1tDH5L0TYyQD+vHIQkdj4EmSKEu
	HVpogAlXC+lJKvoAd1extmksbblBWTg=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-cpxtO_viPXiNLp2b-lqL7g-1; Tue, 20 May 2025 23:21:40 -0400
X-MC-Unique: cpxtO_viPXiNLp2b-lqL7g-1
X-Mimecast-MFC-AGG-ID: cpxtO_viPXiNLp2b-lqL7g_1747797699
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22c31b55ac6so99742945ad.0
        for <linux-s390@vger.kernel.org>; Tue, 20 May 2025 20:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747797699; x=1748402499;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jUSOmA0/3Qa3aXRPXfKpDedwfKwE88WYumy/XPPRjQc=;
        b=DA5qD1PdfvRn0u0P7d+nWN5y31adHSG0M8B7MavH/0T5K4NbNAyCON8OuCmIqyrnSk
         aWUuo8d5BlHPN1EVMc1f2S/fE6/dxjn6fMA3CENfTNj2H5Ok4TMe9mL94qhDm3eWlQ25
         lKAX6TCHKxL756+63D62qq5MAef/51pQugxdUdVbBX+nolaqw/MyekzGsH0tPuIHpQYT
         KbzBL8SxhCjVUz4IsjahvG47E+0KA4ijEDqoJfKrWvdeax9t5b6/H4pozeXY0f/fyCJB
         qSqImi4QrbASuhiBHUeIYv6ED/YAk0ZlnSeS9RScChbP4asuGOSbud4y3hdXMc50HG9t
         CHwA==
X-Forwarded-Encrypted: i=1; AJvYcCUs3Ru4CR+lfRI+BACsL75c0g9DvPXIV7Ws2qThASf3aKM8mcVXP3hALvnQlkfRlyy3HGitlcaMAy6C@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2yBuNSMsN7FkcpFJrLJ/WBaIju3SRZcoWbf21oTbEWGa+YeZ
	rrub31TpYvTBwvwZ9Wv2hgwcc1vN+/rGAei+8TFJAJkR7JsAaX/MboRkXIoNnL5FjWPJ1RX4aua
	hFAFzOxvqSLVHSxtSqVL/9joIAfNb0uv/r1H8pV5s6BJivyICfVqry9ZCqYhpW6g=
X-Gm-Gg: ASbGncuoPGuL1pkLqOG1NfE6ado7TRf4ZniCjVOrtvL8lyVPS8zacboWj/I3nuA0sv0
	ZvUSiOQlu7w4MrNWLj+hqKHRcY8V6ELaQcaIbpq2hSVyPt0gtgkg1NWbcPViTRRev5js+MV19Vy
	H8HCAc8s2lyHm6H3X/IUR3Oiif1YUaaOo+AAbhF7cF7kyQHWQQW7IVTYFm36V3dNO+S53QxJh3f
	1vQZqljFF8kgh4IXXhoAAeXQetUNhNARda9g7K5G7HynFS6xBsYMMJe8wi0vAr7FhEjvmYigJYh
	yKlLpa+YWTbpO4w=
X-Received: by 2002:a17:902:d481:b0:232:4f8c:1b01 with SMTP id d9443c01a7336-2324f8c1cb2mr137961435ad.43.1747797699245;
        Tue, 20 May 2025 20:21:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlhvOC0UNtRC7lIlfulUbJxFqkdOC7pIWuh5IMs24BhyaPmpuqy0MrBWfWyaOHGCOUkRmRPA==
X-Received: by 2002:a17:902:d481:b0:232:4f8c:1b01 with SMTP id d9443c01a7336-2324f8c1cb2mr137961065ad.43.1747797698773;
        Tue, 20 May 2025 20:21:38 -0700 (PDT)
Received: from [10.72.116.61] ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e9784bsm83924955ad.113.2025.05.20.20.21.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 May 2025 20:21:38 -0700 (PDT)
Message-ID: <79d7ee71-a68a-4cde-8796-fb42df59cfce@redhat.com>
Date: Wed, 21 May 2025 11:21:28 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 10/16] scripts: Add default arguments
 for kvmtool
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
 <20250507151256.167769-11-alexandru.elisei@arm.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20250507151256.167769-11-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/25 11:12 PM, Alexandru Elisei wrote:
> kvmtool, unless told otherwise, will do its best to make sure that a kernel
> successfully boots in a virtual machine. It does things like automatically
> creating a rootfs and adding extra parameters to the kernel command line.
> This is actively harmful to kvm-unit-tests, because some tests parse the
> kernel command line and they will fail if they encounter the options added
> by kvmtool.
> 
> Fortunately for us, kvmtool commit 5613ae26b998 ("Add --nodefaults command
> line argument") addded the --nodefaults kvmtool parameter which disables
> all the implicit virtual machine configuration that cannot be disabled by
> using other parameters, like modifying the kernel command line. So always
> use --nodefaults to allow a test to run.
> 
> kvmtool can also be too verbose when running a virtual machine, and this is
> controlled by several parameters. Add those to the default kvmtool command
> line to reduce this verbosity to a minimum.
> 
> Before:
> 
> $ vm run arm/selftest.flat --cpus 2 --mem 256 --params "setup smp=2 mem=256"
> Info: # lkvm run -k arm/selftest.flat -m 256 -c 2 --name guest-5035
> Unknown subtest
> 
> EXIT: STATUS=127
> Warning: KVM compatibility warning.
>      virtio-9p device was not detected.
>      While you have requested a virtio-9p device, the guest kernel did not initialize it.
>      Please make sure that the guest kernel was compiled with CONFIG_NET_9P_VIRTIO=y enabled in .config.
> Warning: KVM compatibility warning.
>      virtio-net device was not detected.
>      While you have requested a virtio-net device, the guest kernel did not initialize it.
>      Please make sure that the guest kernel was compiled with CONFIG_VIRTIO_NET=y enabled in .config.
> Info: KVM session ended normally.
> 
> After:
> 
> $ vm run arm/selftest.flat --nodefaults --network mode=none --loglevel=warning --cpus 2 --mem 256 --params "setup smp=2 mem=256"
> PASS: selftest: setup: smp: number of CPUs matches expectation
> INFO: selftest: setup: smp: found 2 CPUs
> PASS: selftest: setup: mem: memory size matches expectation
> INFO: selftest: setup: mem: found 256 MB
> SUMMARY: 2 tests
> 
> EXIT: STATUS=1
> 
> Note that KVMTOOL_DEFAULT_OPTS can be overwritten by an environment
> variable with the same name, but it's not documented in the help string for
> run_tests.sh. This has been done on purpose, since overwritting
> KVMTOOL_DEFAULT_OPTS should only be necessary for debugging or development
> purposes.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
> ---
>   scripts/common.bash | 10 +++++-----
>   scripts/vmm.bash    | 13 +++++++++++++
>   2 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/scripts/common.bash b/scripts/common.bash
> index 0645235d8baa..ee0ae71948c2 100644
> --- a/scripts/common.bash
> +++ b/scripts/common.bash
> @@ -56,7 +56,7 @@ function for_each_unittest()
>   			# because qemu interprets the first argument after
>   			# -append as a kernel parameter.
>   			test_args=""
> -			opts=""
> +			opts="${vmm_opts[$TARGET:default_opts]}"
>   			groups=""
>   			arch=""
>   			machine=""
> @@ -70,13 +70,13 @@ function for_each_unittest()
>   		elif [[ $line =~ ^test_args\ *=\ *(.*)$ ]]; then
>   			test_args="${vmm_opts[$TARGET:args]} ${BASH_REMATCH[1]}"
>   		elif [[ $TARGET = "qemu" ]] && [[ $line =~ ^(extra_params|qemu_params)\ *=\ *'"""'(.*)$ ]]; then
> -			opts=$(parse_opts ${BASH_REMATCH[2]}$'\n' $fd)
> +			opts="${vmm_opts[$TARGET:default_opts]} $(parse_opts ${BASH_REMATCH[2]}$'\n' $fd)"
>   		elif [[ $TARGET  = "qemu" ]] && [[ $line =~ ^(extra_params|qemu_params)\ *=\ *(.*)$ ]]; then
> -			opts=${BASH_REMATCH[2]}
> +			opts="${vmm_opts[$TARGET:default_opts]} ${BASH_REMATCH[2]}"
>   		elif [[ $TARGET = "kvmtool" ]] && [[ $line =~ ^kvmtool_params\ *=\ *'"""'(.*)$ ]]; then
> -			opts=$(parse_opts ${BASH_REMATCH[1]}$'\n' $fd)
> +			opts="${vmm_opts[$TARGET:default_opts]} $(parse_opts ${BASH_REMATCH[1]}$'\n' $fd)"
>   		elif [[ $TARGET = "kvmtool" ]] && [[ $line =~ ^kvmtool_params\ *=\ *(.*)$ ]]; then
> -			opts=${BASH_REMATCH[1]}
> +			opts="${vmm_opts[$TARGET:default_opts]} ${BASH_REMATCH[1]}"
>   		elif [[ $line =~ ^groups\ *=\ *(.*)$ ]]; then
>   			groups=${BASH_REMATCH[1]}
>   		elif [[ $line =~ ^arch\ *=\ *(.*)$ ]]; then
> diff --git a/scripts/vmm.bash b/scripts/vmm.bash
> index 20968f2e6b10..d24a4c4b8713 100644
> --- a/scripts/vmm.bash
> +++ b/scripts/vmm.bash
> @@ -1,5 +1,16 @@
>   source config.mak
>   
> +# The following parameters are enabled by default when running a test with
> +# kvmtool:
> +# --nodefaults: suppress VM configuration that cannot be disabled otherwise
> +#               (like modifying the supplied kernel command line). Tests that
> +#               use the command line will fail without this parameter.

Maybe change it to below is better? (Put the 'Otherwise' to the next 
paragraph)

# --nodefaults: suppress VM configuration that cannot be disabled
#               (like modifying the supplied kernel command line). 	# 
            Otherwise tests that use the command line will fail
#               without this parameter.

Others looks good to me.

Reviewed-by: Shaoqin Huang <shahuang@redhat.com>

> +# --network mode=none: do not create a network device. kvmtool tries to help the
> +#               user by automatically create one, and then prints a warning
> +#               when the VM terminates if the device hasn't been initialized.
> +# --loglevel=warning: reduce verbosity
> +: "${KVMTOOL_DEFAULT_OPTS:="--nodefaults --network mode=none --loglevel=warning"}"
> +
>   ##############################################################################
>   # qemu_fixup_return_code translates the ambiguous exit status in Table1 to that
>   # in Table2.  Table3 simply documents the complete status table.
> @@ -87,12 +98,14 @@ declare -A vmm_opts=(
>   	[qemu:kernel]='-kernel'
>   	[qemu:args]='-append'
>   	[qemu:initrd]='-initrd'
> +	[qemu:default_opts]=''
>   	[qemu:fixup_return_code]=qemu_fixup_return_code
>   
>   	[kvmtool:nr_cpus]='--cpus'
>   	[kvmtool:kernel]='--kernel'
>   	[kvmtool:args]='--params'
>   	[kvmtool:initrd]='--initrd'
> +	[kvmtool:default_opts]="$KVMTOOL_DEFAULT_OPTS"
>   	[kvmtool:fixup_return_code]=kvmtool_fixup_return_code
>   )
>   

-- 
Shaoqin

