Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65745202C48
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 07:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747208960; cv=none; b=kFJ6C5H4hh7PrVBiYBtx9C08LIt83G+MP0r4qrm3sVNkYkPp8owdE9tytpS+5bXbChIEBmZDT4i6wVEoQZg/7sWGCJMyQQ76qyG3t90NB7kmXUBdD6r1iZMurtbReEFeFQtFMuY31CSIw06ClA9A1/X6DmyuyC5LPiVg5uOPo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747208960; c=relaxed/simple;
	bh=lzfyW5te2xA5XTLbpjnHt9WakjMUlZCEwN2zoYKHIxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m8/DLJVqE20olA1UV5ypkjKKF4hn4ENEm38ioY/nktdcA6kW7EzL0G6EWCyntssladU6Zek2Itm4/q3KvZZcNeYEGtoyzum24bmu0JxSIazyUZ38SAF4cByKohczmr0dgEe/eNiivLJqFoMyrzZT6XTRFg+BnFiOPzYT0hBfS+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=elL9VmWt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elL9VmWt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747208956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GY5pVLDJBE/QxHoyRscYKOYBVWh0U1cYp7B4seYFbNI=;
	b=elL9VmWthI5UzbQx8W488snkOcAvVEf4aGR/rMNtwggOqdHwsaMNZp0HabrgX2z6EB/mqg
	M77bgqP96/S+njXB4cJzvFoESQIUFaLXOAvXpNFCuYSlRCJ4kIoU7hfgLG7elm82K4E6Nr
	VNZ+73hcIW3f2ObXHahMFSkmUXNd3Qg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-J3oAKIDNMdSxO-rxHrGSAw-1; Wed, 14 May 2025 03:49:15 -0400
X-MC-Unique: J3oAKIDNMdSxO-rxHrGSAw-1
X-Mimecast-MFC-AGG-ID: J3oAKIDNMdSxO-rxHrGSAw_1747208954
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-739525d4d7bso5311310b3a.2
        for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 00:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747208954; x=1747813754;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GY5pVLDJBE/QxHoyRscYKOYBVWh0U1cYp7B4seYFbNI=;
        b=fUpEflyLmI6p1kJa6KU6R+R883RZFvHuYCq2c71avHnA8ICpWwNrz0H87igWYXT1wW
         gk3EmzRK3epaeDVHDaAeZIXyE1G3pesTOhn8TC4rbxzUGFpAMfhq7ymptViDcz6YfMCE
         xab3CEbK4wVJVxiG2qkrwM+QtrCQ/wrLd3ZMQmsjGB9q5pThz2gV2ef0vqX4WWsbhnCD
         kHf5A2qLhVGLe3wfhgTtHX6QNS+jO8QJ+2VhtF4MDEKrHSleUzhQxVjOnL+/wAFxGJsd
         qT+mzENKKuychHtwxeUsw/rJFfoHhm8vAcegiiL/yxktYVjuaN/NyWTXxqdSN8LFgEk8
         q80Q==
X-Forwarded-Encrypted: i=1; AJvYcCVozX0b7HeXAMeqZ+ieCXh2/UdXQrqE+Qb8Pd+qxlR0+Nv47nTZspeWT6VnriPXxm0RS/6tKHWHR/aU@vger.kernel.org
X-Gm-Message-State: AOJu0YwVzRUG+J9p7yq1z2MF9jPyEi6oeQD+CpBNldvROe7JsI/Ag59Y
	q2oQIKdFrs/D7J2xH7Uv2faJkLvlRxQjHEqeiB20E03ixVmFnuJCOdTqNSfL+zYRvFv6PpGwI+9
	m8z/63fVYwJWdT1wLzBg8OMzaoiVI5so6kJk6ku7zpIrEaeU02zT19YOg0zg=
X-Gm-Gg: ASbGncuWwiuckltMiglhblFLVdp+dVGVRcIYZICYkTvG9/Ff+9rvdaMBJdCSz+5n1UL
	DFWLh0hvO2u72/SDXiKhX7n//C7Bn0yynx7VSd3kJ6SnAQn2bEK31lwJ0hXD/36/QkILA6Wypja
	3xUo8UxQUCD3ypH+bphZQrwm0pFvdaqLScbdnASsypf2vUhLPOJAVURzv/dfrDYUFHG8kS7PuBf
	h47mZOTgW/fQ9RWFWGzvWvU1oSD9ibTNIryjoocGmA49FzrlgfQrTVmnLI0jHJ2tUnNk/QI/S/Z
	wijKxoXJV4sk+pmi
X-Received: by 2002:a05:6a00:a83:b0:740:596e:1489 with SMTP id d2e1a72fcca58-74289373d91mr3716627b3a.23.1747208953935;
        Wed, 14 May 2025 00:49:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxNAnjJT+LSzbpKrbMZgFeI/1Abe8EQQBbch700DZ2BLpon2TmE4Xe4l7GJrieZh9Qyjgk0Q==
X-Received: by 2002:a05:6a00:a83:b0:740:596e:1489 with SMTP id d2e1a72fcca58-74289373d91mr3716602b3a.23.1747208953574;
        Wed, 14 May 2025 00:49:13 -0700 (PDT)
Received: from [10.72.116.125] ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a10881sm9212477b3a.106.2025.05.14.00.49.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 00:49:12 -0700 (PDT)
Message-ID: <67fb8130-94fd-46d0-8f59-1c047ff0a881@redhat.com>
Date: Wed, 14 May 2025 15:49:03 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 06/16] scripts: Refuse to run the tests
 if not configured for qemu
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
 <20250507151256.167769-7-alexandru.elisei@arm.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20250507151256.167769-7-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/25 11:12 PM, Alexandru Elisei wrote:
> Arm and arm64 support running the tests under kvmtool. kvmtool has a
> different command line syntax for configuring and running a virtual
> machine, and the automated scripts know only how to use qemu.
> 
> One issue with that is even though the tests have been configured for
> kvmtool (with ./configure --target=kvmtool), the scripts will use qemu to
> run the tests, and without looking at the logs there is no indication that
> the tests haven't been run with kvmtool, as configured.
> 
> Another issue is that kvmtool uses a different address for the UART and
> when running the tests with qemu via the scripts, this warning is
> displayed:
> 
> WARNING: early print support may not work. Found uart at 0x9000000, but early base is 0x1000000.
> 
> which might trip up an unsuspected user.
> 
> There are four different ways to run a test using the test infrastructure:
> with run_tests.sh, by invoking arm/run or arm/efi/run with the correct
> parameters (only the arm directory is mentioned here because the tests can
> be configured for kvmtool only on arm and arm64), and by creating
> standalone tests.
> 
> run_tests.sh ends up execuing either arm/run or arm/efi/run, so add a check
> to these two scripts for the test target, and refuse to run the test if
> kvm-unit-tests has been configured for kvmtool.
> 
> mkstandalone.sh also executes arm/run or arm/efi run, but the usual use
> case for standalone tests is to compile them on one machine, and then to
> run them on a different machine. This two step process can be time
> consuming, so save the user time (and frustration!) and add a check
> directly to mkstandalone.sh.
> 
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>

Reviewed-by: Shaoqin Huang <shahuang@redhat.com>

> ---
>   arm/efi/run             |  3 +++
>   arm/run                 |  4 ++++
>   scripts/mkstandalone.sh |  3 +++
>   scripts/vmm.bash        | 14 ++++++++++++++
>   4 files changed, 24 insertions(+)
>   create mode 100644 scripts/vmm.bash
> 
> diff --git a/arm/efi/run b/arm/efi/run
> index 8f41fc02df31..53d71297cc52 100755
> --- a/arm/efi/run
> +++ b/arm/efi/run
> @@ -11,6 +11,9 @@ if [ ! -f config.mak ]; then
>   fi
>   source config.mak
>   source scripts/arch-run.bash
> +source scripts/vmm.bash
> +
> +check_vmm_supported
>   
>   if [ -f /usr/share/qemu-efi-aarch64/QEMU_EFI.fd ]; then
>   	DEFAULT_UEFI=/usr/share/qemu-efi-aarch64/QEMU_EFI.fd
> diff --git a/arm/run b/arm/run
> index ef58558231b7..56562ed1628f 100755
> --- a/arm/run
> +++ b/arm/run
> @@ -7,7 +7,11 @@ if [ -z "$KUT_STANDALONE" ]; then
>   	fi
>   	source config.mak
>   	source scripts/arch-run.bash
> +	source scripts/vmm.bash
>   fi
> +
> +check_vmm_supported
> +
>   qemu_cpu="$TARGET_CPU"
>   
>   if [ "$QEMU" ] && [ -z "$ACCEL" ] &&
> diff --git a/scripts/mkstandalone.sh b/scripts/mkstandalone.sh
> index c4ba81f18935..4f666cefe076 100755
> --- a/scripts/mkstandalone.sh
> +++ b/scripts/mkstandalone.sh
> @@ -6,6 +6,9 @@ if [ ! -f config.mak ]; then
>   fi
>   source config.mak
>   source scripts/common.bash
> +source scripts/vmm.bash
> +
> +check_vmm_supported
>   
>   temp_file ()
>   {
> diff --git a/scripts/vmm.bash b/scripts/vmm.bash
> new file mode 100644
> index 000000000000..39325858c6b3
> --- /dev/null
> +++ b/scripts/vmm.bash
> @@ -0,0 +1,14 @@
> +source config.mak
> +
> +function check_vmm_supported()
> +{
> +	case "$TARGET" in
> +	qemu)
> +		return 0
> +		;;
> +	*)
> +		echo "$0 does not support target '$TARGET'"
> +		exit 2
> +		;;
> +	esac
> +}

-- 
Shaoqin

