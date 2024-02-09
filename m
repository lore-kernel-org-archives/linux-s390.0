Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A0931A79
	for <linux-s390@vger.kernel.org>; Fri,  9 Feb 2024 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707467550; cv=none; b=Z2nD5AXJiYW6glYK5oUT5xU6QTO3l5mhxZLgAG5VgGDKrenNI+a1h6MuVSDGnuxGsFk19KRThSTmUZgi7zM97sLlCzSqTSWDtSVlfrNwv/HpX+ZfJGr8yQWMk32+umNRFZ1CHun4JGvfSz4913jSHK4JXQykzz8hCuDpSVTyp2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707467550; c=relaxed/simple;
	bh=SNAFyvRV8ArvpSELs8/L7OL/I+4zB3EQAnWaBFE1nKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P/mzw1DYkoCm28IVJwoIQ+kFEe4fi+KI+Dx0XOyc0amhLNvcyflgeNSe9qmGNXEa7xii1Avn4qGbIL/aOyuX9ChuXyLo8DtnjO7RG3w72gv3n353tAqfgBpeNvJacLDda35Ar+/4NIpep5xZxr1BEe3Fmu1CwtR91Hhu1JW0SIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Byh3usa8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Byh3usa8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707467548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n1+bf0Nx8c8mDk6BEeuFlVUau/1lVtJgwfFu+gol4dA=;
	b=Byh3usa8ukRou+Dt76a7f4JtEy3vHEJYpC0fbt1bgx1U5yf5SQprOniHzAxLSM4k+2hN1j
	MP35wsxvpDOnjLZGm7eoJPAwpdzpJLbNUW5nH8QJsobTn8CQToSB4C3ih0xBnY5eVbQP0H
	3vCaitQPQzPwN6QPaTyTJUdxKH9rrx4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-iGpit7utOGaSWW6ePwg7IQ-1; Fri, 09 Feb 2024 03:32:26 -0500
X-MC-Unique: iGpit7utOGaSWW6ePwg7IQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a2f71c9f5d2so44535366b.2
        for <linux-s390@vger.kernel.org>; Fri, 09 Feb 2024 00:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707467545; x=1708072345;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n1+bf0Nx8c8mDk6BEeuFlVUau/1lVtJgwfFu+gol4dA=;
        b=JwXb4dtPhoOc9thsqvz3mvXZrjJjHdmRjZQ1eDl6qZG7plwC17wfFIMLKavpwE3lwM
         0FWRXAvsqUXs51zmY2WGYtJKrB+HVGDtUgRLS/y94KBlnfI8MtTzWUWFwn2Y+rlCtRmV
         9iG0/y5HZYlkteJtNgXT1R0RircSbmcDe4z19ZEK0b111U1p6EFWKzULFpWMO8rCaeko
         7ph4A0qEqwHiblfzblh1cWiej+tpB7JgXQSI95/a9WszeHSq06r2YVjwsTdM/hJvAdTa
         wX6YCOhaGYO+7yumArsuJHuDVlzJeNU6voBu/y9Mk5R17EvcI9T9+4qpoC03aAhbQaws
         pFpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkdTqiX6ZxZGf4FiMImH+g4Jovdp+oZBYR2iX77EYXO9gxiO84C+dumUgTaL7PtX3ObzOcvBVPY+nM5C+Dcl0O/56iRjxDtPYRSw==
X-Gm-Message-State: AOJu0YwCwB/bx4IQ93fvDtB3VaAfUSxq2/RAP1rsaupMHCbYbyVtsYtM
	AJs3AWv4w/iE3qmuzuZh2nnEWCs8Vja90Umu9i3Lkx68vP3fIKyw6+AOwqK49IZLDfpqSDpNkt+
	voTr/wllCOgjnRbzQESzx44dkCu4+6WvTgJjiX2SRe1pAWBKiu5mEXbx/1Ew=
X-Received: by 2002:a17:906:f25a:b0:a38:7541:36f6 with SMTP id gy26-20020a170906f25a00b00a38754136f6mr534590ejb.21.1707467545418;
        Fri, 09 Feb 2024 00:32:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/T6YYLfzbp3yhYxtgIsbBvBi9OmPusrYwMtKL4j3WI45fIZaoPgiu1tQyIJoywazyiWjlKA==
X-Received: by 2002:a17:906:f25a:b0:a38:7541:36f6 with SMTP id gy26-20020a170906f25a00b00a38754136f6mr534582ejb.21.1707467545120;
        Fri, 09 Feb 2024 00:32:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWXiUg04J0xyZA2xGb9Fu4y0ntNnaZfu5u3wCECya3Mj6SWlZwp5ICs3/Ov2/qiL9su432EHDvLiVJ0KuNjkJ9dA+qBka4y8ssadh6OiEJ5wpy1En3Fx6anCAdFa7L7MQ/5WVXwqd08bOmyybu5k7Qp1UMvIypUKIMPgtveVcd/GscsLTNJxkC7CaS/yJcLRXIRobE2cKHHIHL5sNoJ059E+mN1EgspRqxG1jLZpHKIRYudg+rhDdl4OtfFPow7/DAAcE/0UIo+I6M8OqxAw4LzeRm++4M4N032W3p0NvaLAdALIWIF/bz89lF45wQXVnsgVCFvipJxUOfJqVQ+tLKDf7Dm8rNEogN2oEb+qJl5xCTmAsxN0sSXNr0ar2u0ZxLikYF3QyLVUj9CsgOiEbIs2k7zhC71oFP6Eq0BDU/dVGAP0Ip74uqtYXDZDXYkmdNY01V18wx696yEfj1s7ZfgIstsNWb5OHSzpU25dubiYvEDA39m6AxMqZD8gr65Yuhuq60pdfoXeVeQ9K7ds7G3+Qqc
Received: from [192.168.0.9] (ip-109-43-177-145.web.vodafone.de. [109.43.177.145])
        by smtp.gmail.com with ESMTPSA id tb5-20020a1709078b8500b00a35e3202d81sm519996ejc.122.2024.02.09.00.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 00:32:24 -0800 (PST)
Message-ID: <32a940e0-2b6d-489d-b987-41d640d04dd0@redhat.com>
Date: Fri, 9 Feb 2024 09:32:23 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 8/8] migration: add a migration selftest
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kvm@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>, Andrew Jones <andrew.jones@linux.dev>,
 Nico Boehr <nrb@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Eric Auger <eric.auger@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Marc Hartmayer
 <mhartmay@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, kvmarm@lists.linux.dev,
 kvm-riscv@lists.infradead.org
References: <20240209070141.421569-1-npiggin@gmail.com>
 <20240209070141.421569-9-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240209070141.421569-9-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2024 08.01, Nicholas Piggin wrote:
> Add a selftest for migration support in  guest library and test harness
> code. It performs migrations a tight loop to irritate races and bugs in

"*in* a tight loop" ?

> the test harness code.
> 
> Include the test in arm, s390, powerpc.
> 
> Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com> (s390x)
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> This has flushed out several bugs in developing the multi migration test
> harness code already.
> 
> Thanks,
> Nick
> 
>   arm/Makefile.common          |  1 +
>   arm/selftest-migration.c     |  1 +
>   arm/unittests.cfg            |  6 ++++++
>   common/selftest-migration.c  | 34 ++++++++++++++++++++++++++++++++++
>   powerpc/Makefile.common      |  1 +
>   powerpc/selftest-migration.c |  1 +
>   powerpc/unittests.cfg        |  4 ++++
>   s390x/Makefile               |  1 +
>   s390x/selftest-migration.c   |  1 +
>   s390x/unittests.cfg          |  4 ++++
>   10 files changed, 54 insertions(+)
>   create mode 120000 arm/selftest-migration.c
>   create mode 100644 common/selftest-migration.c
>   create mode 120000 powerpc/selftest-migration.c
>   create mode 120000 s390x/selftest-migration.c
> 
> diff --git a/arm/Makefile.common b/arm/Makefile.common
> index f828dbe0..f107c478 100644
> --- a/arm/Makefile.common
> +++ b/arm/Makefile.common
> @@ -5,6 +5,7 @@
>   #
>   
>   tests-common  = $(TEST_DIR)/selftest.$(exe)
> +tests-common += $(TEST_DIR)/selftest-migration.$(exe)
>   tests-common += $(TEST_DIR)/spinlock-test.$(exe)
>   tests-common += $(TEST_DIR)/pci-test.$(exe)
>   tests-common += $(TEST_DIR)/pmu.$(exe)
> diff --git a/arm/selftest-migration.c b/arm/selftest-migration.c
> new file mode 120000
> index 00000000..bd1eb266
> --- /dev/null
> +++ b/arm/selftest-migration.c
> @@ -0,0 +1 @@
> +../common/selftest-migration.c
> \ No newline at end of file
> diff --git a/arm/unittests.cfg b/arm/unittests.cfg
> index fe601cbb..1ffd9a82 100644
> --- a/arm/unittests.cfg
> +++ b/arm/unittests.cfg
> @@ -55,6 +55,12 @@ smp = $MAX_SMP
>   extra_params = -append 'smp'
>   groups = selftest
>   
> +# Test migration
> +[selftest-migration]
> +file = selftest-migration.flat
> +groups = selftest migration
> +
> +arch = arm64

Please swap the last two lines!

>   # Test PCI emulation
>   [pci-test]
>   file = pci-test.flat

With the nits fixed:
Reviewed-by: Thomas Huth <thuth@redhat.com>

