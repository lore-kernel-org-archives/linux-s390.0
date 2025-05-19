Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B926AA8A
	for <linux-s390@vger.kernel.org>; Mon, 19 May 2025 08:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645033; cv=none; b=WJPwQcOTcpV/gxJXzPAHM4xzdkCqg3oFmpoAqgSTnaJ02PRafzjLGm+KKS7l2md0Mrm/177YIbLsYqONJbIAKGQb9IsvDZ9p6Yj30WuEhekjDoIQAHbXXcqR8sKYWWHQbcJW2o9rnjoTDZaWBd5nWxzNCu7DogDajnfz33FYKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645033; c=relaxed/simple;
	bh=TgsUBw6/6A7FvTsvKBR6l8n6JZnqtTuIQiDETXqRu6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JuMoHrNhltTnBT4qQ5hVqPH8PxV5ctEua56cjGvoTEfEfd8TpN8BkK4winIWfBfGbPsw6/tJddcuy5tJd2ze84tGuPeM4EMBndGNWciu9rVi+aVIIrd4JJTZjLoH9rE9domkNlWfppn//mD9Zd+iR78z9kPjE1+NJMBN57txnt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PTqzLJeo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PTqzLJeo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747645029;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=57lbWIGpAZjDd2L3740mwnHRJL/CETq+opyWz0J1phk=;
	b=PTqzLJeo5vUrtkO71KkM4IBSXUjycyceNiFzu2/i02w8NxFgd7gGL8ykyiWsFw4aLp0dG1
	SCRDP248IoR6T3sI9WRwf6Aj9naKNtrXl+pkz0HAdKKtwJmJPlp56n5Qs9cn8sSg7dVSvj
	q4Zsed/Rd8OcIfkTC1/9W6PMV7CSvdk=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-Hu6F0AjzPveXjNZ0fDXfMw-1; Mon, 19 May 2025 04:57:08 -0400
X-MC-Unique: Hu6F0AjzPveXjNZ0fDXfMw-1
X-Mimecast-MFC-AGG-ID: Hu6F0AjzPveXjNZ0fDXfMw_1747645027
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b0e5f28841dso2859538a12.2
        for <linux-s390@vger.kernel.org>; Mon, 19 May 2025 01:57:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747645027; x=1748249827;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57lbWIGpAZjDd2L3740mwnHRJL/CETq+opyWz0J1phk=;
        b=iTS68UlHR/olV86KL2G07FG+lPguslRhnozI+yT2Ax4gjASTkhmeMxXHgl99llcM69
         fpV6vkQGteH6bzibAjFmNhZljvYEhD+LJ1Q9Wu1szPS3AtJeX0PwvsJ0yix5GeDTM92x
         hWEt4A85qmaxHc9Ewnsgpo3wcDM7aP28nKD+0ZDiI981FA72oy/93IEOQXF09zTBKuXS
         SxTnnH+G7HMICbTZDnh5d7WMe3LyLoWqg/HbE7tzBKBm+cm7Q3L+hEFVzfzPt20QZXx3
         yQV9dkg4Em/hec442FrW8sE5tPNG3Tma4llRJVDD+RNB3FUKj7QW3VSeKsFMMn6rpXhG
         jR5A==
X-Forwarded-Encrypted: i=1; AJvYcCVCzxbxaWO6HwRe5s0afRj7BBrgPpykuu6L2OVqXnofDqmvV/XNKK50jG4p++rAXXH5y7kpqG4fDEh7@vger.kernel.org
X-Gm-Message-State: AOJu0YzM1RxLT0AHcDDVkgJqPlpXQHFNJWWakp5qBygTc0A/z0We0pmW
	3OYMgzyc8amjK3MaMtTAjilVX29nI6jmrtHeT7JbMX7iVO6bBofvfrmrSosZbOpvqsIHh92jehe
	iZFVHG6kwFOwxwZNAezi0c1j8kYmRlskgmrjuZhGzML0wjPp79gVJiCBADBRvxvk=
X-Gm-Gg: ASbGnculVYyQ5wGcoZHhAUubxceuyGAm3cdNQnXb7I3ZeEEf+oeiUBTKEdMrs5tCDo0
	hlDZwVvcpmUbKiwjJIPr8/Vq07v/vmzDclx0HHDOFQJ9n6PPmwIuhO1CDQHenKChdBl3x5iyp8O
	z9W9bsSjoQo+PS8Tg5GupDrS5vRRwAK+sRg2UDs3K7BmawcEcp0BBtjIaaJrpGsv6r6vluRSCpN
	r/I4SpK/9FG+nc4X/H1DsZqtIbWgYaHvf+iYrKmg0Gw2kRDjgENWVRQqOlSEyRzH4G5KJeczX2/
	wTvTvMUSFlkwQkGb
X-Received: by 2002:a05:6a21:a341:b0:1f6:6539:e026 with SMTP id adf61e73a8af0-216218e668fmr19448401637.15.1747645026960;
        Mon, 19 May 2025 01:57:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+BBkV0dSDFn9S/kO/xVvSG5+nt7BjgxgmMpQUjhktNCq5vzK536Q0m1eaNG4mx2NI/khDRA==
X-Received: by 2002:a05:6a21:a341:b0:1f6:6539:e026 with SMTP id adf61e73a8af0-216218e668fmr19448372637.15.1747645026548;
        Mon, 19 May 2025 01:57:06 -0700 (PDT)
Received: from [10.72.116.146] ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b26eb0a89edsm5672369a12.67.2025.05.19.01.56.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 May 2025 01:57:05 -0700 (PDT)
Message-ID: <1ecedde8-8d18-43f1-a3b7-e8bcc82a61f0@redhat.com>
Date: Mon, 19 May 2025 16:56:56 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v3 00/16] arm/arm64: Add kvmtool to the
 runner script
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
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <20250507151256.167769-1-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alexandru,

For this series, I've tested it, everything works good.

On 5/7/25 11:12 PM, Alexandru Elisei wrote:
> v2 can be found here [1].
> 
> To goal is to allow the user to do:
> 
> $ ./configure --target=kvmtool
> $ make clean && make
> $ ./run_tests.sh
> 
> to run all the tests automatically with kvmtool.
> 
> Reasons to use kvmtool:
> 
> * kvmtool is smaller and a lot easier to hack than qemu, which means
> developers may prefer it when adding or prototyping new features to KVM.
> Being able to run all the tests reliably and automatically is very useful
> in the development process.
> 
> * kvmtool is faster to run the tests (a couple of times faster on
> my rockpro64), making for a quick turnaround. But do keep in mind that not
> all tests work on kvmtool because of missing features compared to qemu.
> 
> * kvmtool does things differently than qemu: different memory layout,
> different uart, PMU emulation is disabled by default, etc. This makes it a
> good testing vehicule for kvm-unit-tests itself.
> 
> Changes in v3
> -------------
> 
> Lots of changes following the excellent feedback I got. A bird's eye view:
> 
> * Split extra_params into qemu_params and test_args: qemu_params for qemu
> arguments and test_args for the test's main() function.
> 
> Now that I'm putting the cover letter together I'm considering that maybe
> having qemu_params, kvmtool_params and test_params (instead of test_args)
> might be a better naming scheme.
> 
> * TARGET is now exported unconditionally. Unfortunately a side effect of
> this is that checking out these series and running the tests will end up
> with an error because the scripts now expect TARGET to be defined in
> config.mak.
> 
> If it's unacceptable, I can drop this and handle everything in vmm.bash by
> converting direct accesses to vmm_opts with functions defined in vmm.bash
> (vmm_opts[$TARGET:parse_premature_failure] becomes
> vmm_parse_premature_failure(), for example).
> 
> * Introduced scripts/vmm.bash to keep the vmm stuff contained. As a
> consequence there's very little $TARGET stuff in scripts/runtime.bash (only
> for premature_failure(), and no more 'case' statements anywhere) and
> instead scripts/common.bash passes the correct arguments directly to
> runtime.bash::run().
> 
> Unfortunately, because of all the changes, I decided not to keep some of
> the Reviewed-by tags. That's not to say that the effort is not appreciated,
> on the contrary, these changes are a direct result of the review; I dropped
> the tags because I was worried they might not apply to the current content
> of the patches.
> 
> If no major changes are needed following this round of review, for the next
> iteration I'm planning to send the first two patches (extra_params renamed
> to qemu_params and the new test_args) separately, to make sure it gets the
> review it deserves from the rest of the architectures.
> 
> Still haven't managed to get EDK2 to work with kvmtool, so I've decided to
> explicitely disabled UEFI tests in the last patch ("scripts: Enable
> kvmtool") - this is new.
> 
> I would also like to point out that despite Drew's comment I kept the
> 'disabled_if' test definition because I think using 'targets', with the
> default value of 'qemu', will probably lead to most, if not all, of the new
> tests which will be added never being run or tested with kvmtool. More
> details in patch #15 ("scripts: Add 'disabled_if' test definition parameter
> for kvmtool to use").
> 
> [1] https://lore.kernel.org/kvm/20250120164316.31473-1-alexandru.elisei@arm.com/
> 
> Alexandru Elisei (16):
>    scripts: unittests.cfg: Rename 'extra_params' to 'qemu_params'
>    scripts: Add 'test_args' test definition parameter
>    configure: Export TARGET unconditionally
>    run_tests.sh: Document --probe-maxsmp argument
>    scripts: Document environment variables
>    scripts: Refuse to run the tests if not configured for qemu
>    scripts: Use an associative array for qemu argument names
>    scripts: Add 'kvmtool_params' to test definition
>    scripts: Add support for kvmtool
>    scripts: Add default arguments for kvmtool
>    scripts: Add KVMTOOL environment variable for kvmtool binary path
>    scripts: Detect kvmtool failure in premature_failure()
>    scripts: Do not probe for maximum number of VCPUs when using kvmtool
>    scripts/mkstandalone: Export $TARGET
>    scripts: Add 'disabled_if' test definition parameter for kvmtool to
>      use
>    scripts: Enable kvmtool
> 
>   README.md               |  18 ++++-
>   arm/efi/run             |   8 ++
>   arm/run                 | 161 +++++++++++++++++++++++--------------
>   arm/unittests.cfg       | 125 ++++++++++++++++++++---------
>   configure               |  37 ++++++---
>   docs/unittests.txt      |  54 +++++++++++--
>   powerpc/run             |   4 +-
>   powerpc/unittests.cfg   |  21 ++---
>   riscv/run               |   4 +-
>   riscv/unittests.cfg     |   2 +-
>   run_tests.sh            |  35 ++++++---
>   s390x/run               |   2 +-
>   s390x/unittests.cfg     |  53 +++++++------
>   scripts/arch-run.bash   | 113 ++++++++++----------------
>   scripts/common.bash     |  71 +++++++++++------
>   scripts/mkstandalone.sh |   4 +
>   scripts/runtime.bash    |  51 +++++-------
>   scripts/vmm.bash        | 170 ++++++++++++++++++++++++++++++++++++++++
>   x86/run                 |   4 +-
>   x86/unittests.cfg       | 164 +++++++++++++++++++++-----------------
>   20 files changed, 730 insertions(+), 371 deletions(-)
>   create mode 100644 scripts/vmm.bash
> 
> 
> base-commit: 08db0f5cfbca16b36f200b7bc54a78fa4941bcce

-- 
Shaoqin

