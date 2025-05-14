Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989C04438B
	for <linux-s390@vger.kernel.org>; Wed, 14 May 2025 03:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747193834; cv=none; b=brSEOen/jTMchTTZOmc3iQyHb7/GTaAnnL184+wnF1hpJEhBsb2nsbDwPZDrQdT8aCbqZoVeMXgFxmyl9dv9M4lAyvqm6SdZE4zoKGa9YBtmCBMB8zJ0jea10Oo1o2twpriYEXkpKyMrSyCQOtWkTHRAPh9aSudBljIARjZu0pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747193834; c=relaxed/simple;
	bh=1V7ejfjGKrSp2ZU/3GoXfAFp+S08WBXvioRWnbZi4ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLpVKxGE2lG+j4aBMPrkg/FTMuzxu8gJJkVcxFkXERN+SnqjDmnlW3g/f+/ZU8PON0rn0jTfjqF+tSP2mZkJS0xFlt/rFlM1B0uaHCLIz05kWDYH8qOouQovtslyPjCs/zmnKaB/ZjZ3sGsocVxNPaF1bAitND5gW8hmib8l3a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GosP4vXs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GosP4vXs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747193831;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sXnHSZ0Yk0pjB03hExnA/yD4CkvPU5te8D9VFkvGbRE=;
	b=GosP4vXsN218zv4s5OohvZUcl4xx8C/iM0l2XopyKMp++Gf0pMRKMkrjhEre2EHQdxg3j1
	s/4hfxbeNyCth419v5BulI9SF5V7H+T6n4q3qv4+JutDwM/ZV89AolvzJyrxKD7WsGqjTC
	gFiRnt2a9zN6WBvqwT6KUx/cTb42tQs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-lyRnQa5eNN2fyHKQp_h_qA-1; Tue, 13 May 2025 23:37:10 -0400
X-MC-Unique: lyRnQa5eNN2fyHKQp_h_qA-1
X-Mimecast-MFC-AGG-ID: lyRnQa5eNN2fyHKQp_h_qA_1747193829
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30ac9abbd4bso9795890a91.3
        for <linux-s390@vger.kernel.org>; Tue, 13 May 2025 20:37:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747193829; x=1747798629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sXnHSZ0Yk0pjB03hExnA/yD4CkvPU5te8D9VFkvGbRE=;
        b=NH7F5Pjji/P6twizgIPvVEYIPPFxi9OX4ePLzvnL0kkwzSzGbHqNNFAZ+eDiIiTM8m
         RS0mwo9JmTwid6gVgWqKuo1QHwodNPI9fFnBe/1KUxF83fk4TIk7xmUyUB76ik5ZXJXK
         R/A6vr0InBg4SYHjOAdQSnmAy8GsUoHxpVUl5ikt3Pz9ToSygbza3debLRofNmef5iSj
         gZZarI5hVoTKVnqiNmVHVL/mTGEtQV8wkvFdvzaowkBqlL/AmiFWnezGj80nMGQ9L8Rv
         ZE3N84TkOGpeCnZPSvfSD+w577cAC1vPxCmXq9GN3+wTBbaEwFHJFngwrj7WXDI48Dk9
         4fOg==
X-Forwarded-Encrypted: i=1; AJvYcCVwnDdq5HDRuPUvibzfGKR6d5QrYIlTiNylsjdA7ebZJo9QRgA6AIoRb0aIvP4BVg00uGy8czjQWc/T@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2EVP9Q34WRLo1Dm5l9qK3lz/4/we7eoAvXGsGqmwFZlzpIEex
	nSA9glludX6bmvJrysNp6+CPBbUy0BE8fcu1ihBwys/n574c0QAnmqQnWZa76+JeqIRwY22dFlb
	UP32mqVjW36IUlg59D/dI8UGxqX4CizWI9qje62L4SeeQyRNzEIHOmpRto6k=
X-Gm-Gg: ASbGncvsiNmaCu7ushzapKgIBuDtXPxLdPgFxoHO3mKykkC0lzXwx/9maHpdViliZqV
	1yqzKXYPVvaSgRt9X1kjVdOZ94HfGtG/4hyL0pEJ3OxqmtxmeSmbDG4Fe2Us9Z05g/qcJb6zDSE
	RciAXqo/9D01a1EAFy0YLqfjpVtu0DIcksc9dbay7tzUqyMH2KcFxlgdq5VsaGFfyNRx2tnHb43
	5rVup/EnE9zqKQRVvrngtF8A3Inku2uYIeJL/Yhsjl4acxF+ZPmSUJ8fG4/0YzNr6gS63xpISaM
	Zy6u/gcYCWdPRQxO
X-Received: by 2002:a17:90b:5590:b0:2ee:f687:6acb with SMTP id 98e67ed59e1d1-30e2e5c24b0mr3049820a91.13.1747193829182;
        Tue, 13 May 2025 20:37:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEMic3JZfqHUduiY6RIFo4rKxWJxbdw/r/LByh2iH/VAXRKkC+svCTuRA6EfZQjPLBCUxbkg==
X-Received: by 2002:a17:90b:5590:b0:2ee:f687:6acb with SMTP id 98e67ed59e1d1-30e2e5c24b0mr3049782a91.13.1747193828788;
        Tue, 13 May 2025 20:37:08 -0700 (PDT)
Received: from [10.72.116.125] ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30e334e2503sm434299a91.31.2025.05.13.20.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 20:37:08 -0700 (PDT)
Message-ID: <1ac10d00-c21c-44fd-9973-c32fd89b4ba1@redhat.com>
Date: Wed, 14 May 2025 11:36:58 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 05/16] scripts: Document environment
 variables
To: Alexandru Elisei <alexandru.elisei@arm.com>, andrew.jones@linux.dev,
 eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com,
 david@redhat.com, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, will@kernel.org, julien.thierry.kdev@gmail.com,
 maz@kernel.org, oliver.upton@linux.dev, suzuki.poulose@arm.com,
 yuzenghui@huawei.com, joey.gouly@arm.com, andre.przywara@arm.com,
 Andrew Jones <drjones@redhat.com>
References: <20250507151256.167769-1-alexandru.elisei@arm.com>
 <20250507151256.167769-6-alexandru.elisei@arm.com>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20250507151256.167769-6-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/7/25 11:12 PM, Alexandru Elisei wrote:
> Document the environment variables that influence how a test is executed
> by the run_tests.sh test runner.
> 
> Suggested-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
> Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>

Reviewed-by: Shaoqin Huang <shahuang@redhat.com>

> ---
>   docs/unittests.txt |  5 ++++-
>   run_tests.sh       | 12 +++++++++---
>   2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/unittests.txt b/docs/unittests.txt
> index 6eb315618dbd..ea0da959f008 100644
> --- a/docs/unittests.txt
> +++ b/docs/unittests.txt
> @@ -102,7 +102,8 @@ timeout
>   -------
>   timeout = <duration>
>   
> -Optional timeout in seconds, after which the test will be killed and fail.
> +Optional timeout in seconds, after which the test will be killed and fail. Can
> +be overwritten with the TIMEOUT=<duration> environment variable.
>   
>   check
>   -----
> @@ -113,3 +114,5 @@ can contain multiple files to check separated by a space, but each check
>   parameter needs to be of the form <path>=<value>
>   
>   The path and value cannot contain space, =, or shell wildcard characters.
> +
> +Can be overwritten with the CHECK environment variable with the same syntax.
> diff --git a/run_tests.sh b/run_tests.sh
> index f30b6dbd131c..dd9d27377905 100755
> --- a/run_tests.sh
> +++ b/run_tests.sh
> @@ -27,9 +27,15 @@ Usage: $0 [-h] [-v] [-a] [-g group] [-j NUM-TASKS] [-t] [-l]
>       -l, --list          Only output all tests list
>           --probe-maxsmp  Update the maximum number of VCPUs supported by host
>   
> -Set the environment variable QEMU=/path/to/qemu-system-ARCH to
> -specify the appropriate qemu binary for ARCH-run.
> -
> +The following environment variables are used:
> +
> +    QEMU            Path to QEMU binary for ARCH-run
> +    ACCEL           QEMU accelerator to use, e.g. 'kvm', 'hvf' or 'tcg'
> +    ACCEL_PROPS     Extra argument(s) to ACCEL
> +    MACHINE         QEMU machine type
> +    TIMEOUT         Timeout duration for the timeout(1) command
> +    CHECK           Overwrites the 'check' unit test parameter (see
> +                    docs/unittests.txt)
>   EOF
>   }
>   

-- 
Shaoqin

