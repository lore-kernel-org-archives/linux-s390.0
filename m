Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC312C81F
	for <linux-s390@vger.kernel.org>; Fri, 16 Feb 2024 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092323; cv=none; b=d6kKthQAn1XmjgXMAy7tr8qWXAzuv2ZLxf2klfkkAlEFzBSadJVRKi2FQcmGA3TLp7mFs/aO2ea2zDQvJrZS4LkaHTxzLuC2qFkp5rXnlsCTD2pWzBasgmZwwa63u9Qw0f7cyEvLm3tlKd+9UlZeXN9Kgt6sybngRDbKKFsvw5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092323; c=relaxed/simple;
	bh=3/UywGEmfDq8guBuOVIFPW7ddYbA+MZVny/rOXkoC/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AzPQBxz5vPZoKSBp3Lu3b1laQCHp+uUCT8q/RhGp0yGjOHXNYyWi90dKQ+VnQGH6yxWJjjcQUXnKceZU5ojyhg1QQuGpKiNa54tnFg0/LQJ8vQXaAHt0Tc5WtNcxrvyTRfbmuBHKQQs0eKkeSxnJOmXb5exDs6IXcNfZJncD1oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSmS83nm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSmS83nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708092320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=lwzLOSSNOTOlXVVos2KmnfPtZGho1mkmqO1WiYK8IAA=;
	b=BSmS83nmmJmvv21vuPHj0GbVo8VIOxJyugzfZ61+IY05hVvDIRLZH+ve6vc72e00M8E3sj
	MCQjrcSN4djyvvXZ0jw5kEIoX/I5ND5+SL0wC+RY9WJ7rGBeSN51LVbMojnWZnuuxIxbBi
	WoEB4XaSSpb1Uv2HoUNsJidVZlWyU70=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-NPD8q0GqMDS4gSf4FfLy4A-1; Fri, 16 Feb 2024 09:05:18 -0500
X-MC-Unique: NPD8q0GqMDS4gSf4FfLy4A-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7833761135dso264107285a.0
        for <linux-s390@vger.kernel.org>; Fri, 16 Feb 2024 06:05:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092318; x=1708697118;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwzLOSSNOTOlXVVos2KmnfPtZGho1mkmqO1WiYK8IAA=;
        b=NqI1UEFvnxFO6dnq94C+aeI9jIFOLpp7QZb2kd2MNs6T9wCq48UpuMK+97p9OmhB+j
         E1aPMTspOrrI6jOhta3AkN159SNUHElg09H7h77wixz72EVmhmf7PSdrI5ESwKwrqH2B
         4cUl1SfbG2bquuBRpWHAe/go6NSqKnrl7qbPI5GDei2a6L6kDXADe/5cVQ4NUf8LlJlF
         koYPSnW1nOFEqsRIKwZ6f6hbuRppoC9xdBXEfPk882yGcg0U1iNRbDwoKZZzKA53z1rP
         L0uBQuOtPpNQb8rmLmczVxftbHaGFpP6H5c6qHrrftfI55EXq6Ys/xEh49ixLUON5SpN
         F5kw==
X-Forwarded-Encrypted: i=1; AJvYcCV6272Zvjig5gLukFkuaO5pibDEZqBTEjlLqLWlCKmK8AeMHI9YY+Ca3z/t0xAgSb/lu2Igfw+grQxqb90t/syPKlblSk/c3xFn8Q==
X-Gm-Message-State: AOJu0YzQ+PmVc1VdlBhO+Yr3uux30/93T6XxTY4HVpGlSmfModnk/KiL
	ojRiajVcSSWpUOw9kPYztyLIamOiz9kNVuun6cB0mdx/noGdkgBXsHR1+8Nu/ijxuto+m5zDrhC
	/AbS41HR+uLiDr1uUWqI788T4nnOrXK+FNj93ha50kROmYQA+0Xfegz0/b/Y=
X-Received: by 2002:a05:622a:170b:b0:42d:e765:38c0 with SMTP id h11-20020a05622a170b00b0042de76538c0mr722299qtk.61.1708092318112;
        Fri, 16 Feb 2024 06:05:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmAgWinSKipDH0Yvn4QXXyIIpV54zWweCnN0Xl+mWnKvc+2T7YM5cZKuTrYuaeWjkXmCKLJw==
X-Received: by 2002:a05:622a:170b:b0:42d:e765:38c0 with SMTP id h11-20020a05622a170b00b0042de76538c0mr722276qtk.61.1708092317827;
        Fri, 16 Feb 2024 06:05:17 -0800 (PST)
Received: from [192.168.0.9] (ip-109-43-177-178.web.vodafone.de. [109.43.177.178])
        by smtp.gmail.com with ESMTPSA id qm18-20020a056214569200b0068d137664e3sm1774065qvb.134.2024.02.16.06.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:05:17 -0800 (PST)
Message-ID: <77d8fd0d-e2a9-42f7-9a76-08868ab95cb9@redhat.com>
Date: Fri, 16 Feb 2024 15:05:12 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v4 8/8] migration: add a migration selftest
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
References: <20240209091134.600228-1-npiggin@gmail.com>
 <20240209091134.600228-9-npiggin@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240209091134.600228-9-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2024 10.11, Nicholas Piggin wrote:
> Add a selftest for migration support in  guest library and test harness
> code. It performs migrations in a tight loop to irritate races and bugs
> in the test harness code.
> 
> Include the test in arm, s390, powerpc.
> 
> Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com> (s390x)
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
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
> index fe601cbb..db0e4c9b 100644
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
> +arch = arm64
> +
>   # Test PCI emulation
>   [pci-test]
>   file = pci-test.flat
> diff --git a/common/selftest-migration.c b/common/selftest-migration.c
> new file mode 100644
> index 00000000..f70c505f
> --- /dev/null
> +++ b/common/selftest-migration.c
> @@ -0,0 +1,34 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Machine independent migration tests
> + *
> + * This is just a very simple test that is intended to stress the migration
> + * support in the test harness. This could be expanded to test more guest
> + * library code, but architecture-specific tests should be used to test
> + * migration of tricky machine state.
> + */
> +#include <libcflat.h>
> +#include <migrate.h>
> +
> +#if defined(__arm__) || defined(__aarch64__)
> +/* arm can only call getchar 15 times */
> +#define NR_MIGRATIONS 15
> +#else
> +#define NR_MIGRATIONS 100
> +#endif

FYI, I just wrote a patch that will hopefully fix the limitation to 15 times 
on arm:

  https://lore.kernel.org/kvm/20240216140210.70280-1-thuth@redhat.com/T/#u

  Thomas

