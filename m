Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8382D3750
	for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2026 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781098709; cv=none; b=HsCxEhCkQpq+/2PHkEEZQgWY2OTow5ZkHhc8nN7uCrvhqbpbEMLsBQAp+eUCgQXdM6ywZAd3Z9u3Ha7F3Ju4Ue3OHhvAgIRX95DRvGPwCrBoNV3StUvegfrTAdo5NC/i4ESC5EKoyaxPB8tGHXQ62u+0q7EovLY27Z2asGlsxv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781098709; c=relaxed/simple;
	bh=f5xF23PvbD03zrgF6UzgwUbWasiF/s+dmaVBDDMQYnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aiZIBNLtroKNidEZRullWqB0pY2jq120jxxI89pVe7GDyKutrRR2OzS1hhvS6Q/IfyaIrci7N14Ty0WnvpOVxOsdBX5FiPrXb8qonqWaJB073Mxj8lPEKZ7T1amFZ2ztF5AfTdfj7ZqYfD9rrZh0Z0fRxR25J2J/+uABcHqpwRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sM6IQSP3; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sM6IQSP3"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bec43ee8ff0so978319466b.1
        for <linux-s390@vger.kernel.org>; Wed, 10 Jun 2026 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781098706; x=1781703506; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hHFAGJXeiT/y4W+FHHHiOJeeM3a7WGwNiF8ZLx2zfY=;
        b=sM6IQSP3Ilo3vdosRXO5FKC5RotGlTj5bVscIgX/YaYKPpaYYg3j/GMuXNty/azgj5
         ZLcNS+x4jsVRMOQ/2AzXcajPExAkVr9tL/XBpzH+tni8lWQwl/3CqGczXqM886MMZVvU
         edN921MhTqOE85DtXepDtPC0Qe7ic0reD6kROyIxqm89G1in7FbfysunXW9/F7zPAHIf
         P4v+XNA1YALPCzycexDU0M+2GdrQjMZEXP7jbIJxZAsWH0D0Ihv5Wtifis4Xr6UlNRrQ
         k2A1d+AyZtrBScb3GBfujcRT7MCwyLI3yu6si1t60TzpsTEyOUY2woHeGQzPO0dFNKQh
         cirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781098706; x=1781703506;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5hHFAGJXeiT/y4W+FHHHiOJeeM3a7WGwNiF8ZLx2zfY=;
        b=fNhrMXAyc/vR8ifi+ppeegREffdL4t7xX+reqRLJe2riQYw0KT9vJw4jm23kMuU34z
         9YNfseNZ46k9ZpsKk1s19MSx+T8XTI0/kmekG7qSAQ55jMoxcqR04oCW1K4Sfr4cQiOF
         qAyUgn6x89Jy5POANoyERCEuc995otmP6N4miN6l/ZdQ/OnDE0msmIzfKE+uPnmYS9D+
         PJVTZCPwCmpevlYIG4XTUOOruimBYTMUzruzXLpVIY5lYSCDdQeLC6Z59Ioh5tt40gRO
         9Rz6u1dkpGUoh3ERa2yOpXzysOcsmLQdf+KI0yuBX5iYwMBiWB/J9stmHybAdCYvmYMF
         oCQw==
X-Forwarded-Encrypted: i=1; AFNElJ8juWEJm3jyR/DMmVLGrGOhWHHdOlk4F1QHpGptN6FOQcHJbFo9Aioz4PEDWcKXED4yOaCQh0v+7Ao6@vger.kernel.org
X-Gm-Message-State: AOJu0YxKjhNYGs4iQQy/qLwQJqAL/dSbrHAa2j/a1Zkduce7T/1EFPEA
	KS8CszO38baTuKvPfvSWfWiILG9C7DyvgMyLcoxAAKyRMMS0T3rEB9wHUBdzxZOPIIU=
X-Gm-Gg: Acq92OFD4oLmGNU5iDidevnVJyN9UzvV7wq4usU6FRflu/6WGvMrRhGm+B7DaDfHQaQ
	ti7yvcr578yo2wCxvilRpDmNkmXmH5qChHEW8Ir3ZVnd3Wuw8tYur8JUqiqaNyAx6FcYE4XEdeN
	vtUnBa6OHk0nj8ytAPU/2NWirVXS7ZDbv8j2sARhwnHGOlKsVDgAXxT5BMgRfUtPlDvnWkp9jSu
	pX8P9MqLKBoA43EWB32/+94OyOsJCcTaTPlZVC6mKET3dlos7LvrBCCWdh/QcmTV/P6SnlGiDT9
	4ThrxsLdWWD6oTeQfISy577ad57Jzcl3DKtqE75rFPeSwTeA7o5RRrcG2RnaFiJLS7/noEp9+Uy
	DHUsOolEIgz5n+WYnBTbcRXPFfDjfDxAm719Gm/s+nfTB3UynwPSGCrBwzRPgyXSoWN23dvQTjh
	+X+agMwp17m2RFjIoW/gN6i8wRSoc3dAgGyq4L5Eo=
X-Received: by 2002:a17:906:518a:20b0:bf8:970f:e4d8 with SMTP id a640c23a62f3a-bf8970fe4f0mr317498166b.12.1781098706106;
        Wed, 10 Jun 2026 06:38:26 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf05176fd07sm1203628966b.1.2026.06.10.06.38.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 06:38:25 -0700 (PDT)
Message-ID: <82e8f48d-50da-4010-9df2-82dfd436d85c@linaro.org>
Date: Wed, 10 Jun 2026 14:38:24 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf build: Do not duplicate CFLAGS in Python extension
 builds
To: Jens Remus <jremus@linux.ibm.com>
Cc: Jan Polensky <japo@linux.ibm.com>, Thomas Richter
 <tmricht@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260610112344.1550111-1-jremus@linux.ibm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260610112344.1550111-1-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/06/2026 12:23 pm, Jens Remus wrote:
> setuptools already uses CFLAGS.  Passing CFLAGS with additional flags as
> extra compile arguments causes CFLAGS to effectively get passed twice:
> 
> $ make -C tools/perf V=1 JOBS=1
> ...
> building 'perf' extension
> gcc [CFLAGS] -fPIC -Iutil/include -I/usr/include/python3.14 \
>    -c /root/linux/tools/perf/util/python.c \
>    -o python_ext_build/tmp/root/linux/tools/perf/util/python.o \
>    [CFLAGS] \
>    -fno-strict-aliasing -Wno-write-strings -Wno-unused-parameter \
>    -Wno-redundant-decls -Wno-cast-function-type \
>    -Wno-declaration-after-statement
> 
> Signed-off-by: Jens Remus <jremus@linux.ibm.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
> 
> Notes (jremus):
>      This patch applies on top of the perf-tools-next tree:
>      
>        git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git  master
>      
>      Note that my "[PATCH v2] perf build: Respect V=1 for Python extension
>      builds" [1] needs to be applied to actually observe the Python extension
>      build command and output with V=1.
>      
>      [1]: https://lore.kernel.org/all/20260608160613.3153795-1-jremus@linux.ibm.com/
> 
>   tools/perf/util/setup.py | 13 ++++++-------
>   1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index b65b1792ca05..a0ce76624a23 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -74,18 +74,17 @@ class install_lib(_install_lib):
>           self.build_dir = build_lib
>   
>   
> -cflags = getenv('CFLAGS', '').split()
>   # switch off several checks (need to be at the end of cflags list)
> -cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
> +extra_cflags = ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
>   if cc_is_clang:
> -    cflags += ["-Wno-unused-command-line-argument" ]
> +    extra_cflags += ["-Wno-unused-command-line-argument" ]
>       if clang_has_option("-Wno-cast-function-type-mismatch"):
> -        cflags += ["-Wno-cast-function-type-mismatch" ]
> +        extra_cflags += ["-Wno-cast-function-type-mismatch" ]
>   else:
> -    cflags += ['-Wno-cast-function-type' ]
> +    extra_cflags += ['-Wno-cast-function-type' ]
>   
>   # The python headers have mixed code with declarations (decls after asserts, for instance)
> -cflags += [ "-Wno-declaration-after-statement" ]
> +extra_cflags += [ "-Wno-declaration-after-statement" ]
>   
>   src_perf  = f'{srctree}/tools/perf'
>   build_lib = getenv('PYTHON_EXTBUILD_LIB')
> @@ -94,7 +93,7 @@ build_tmp = getenv('PYTHON_EXTBUILD_TMP')
>   perf = Extension('perf',
>                    sources = [ src_perf + '/util/python.c' ],
>   		         include_dirs = ['util/include'],
> -		         extra_compile_args = cflags,
> +		         extra_compile_args = extra_cflags,
>                    )
>   
>   setup(name='perf',

