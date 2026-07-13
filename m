Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C820C23C8A0
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 13:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783949709; cv=none; b=VtX9RDdSlEbaTsNveDosVLHf5ODdzCyBRSWLvw4j1F+ys59FmuYMHwCPFHCxOUxBdW2Ami+Wb9nFt3EGzbnkIQ59YS5kDk6KkU95BKii2PC4w5jXu3a2DhtFQnVqm4VMvpwxZPab9g53GQAkBrCg9YgYGEopsn0RcFmTKN9qwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783949709; c=relaxed/simple;
	bh=ODMdvDY3dHNEVGcU+TpThwnD1sq8fG98yVoHBy6zJd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5qbiP33i1PvlXvZKeiYb8UjTKIW7vF2QOf8pxvhhoowT98SBUuxGk8QmngzzQOpBzw+hwN22G8OQm+f8zjhk3BBpN2D8ATrNOn3s7joTRj0s5Dy3Rb9I1ghoSpiE4LBH/8A6y6Ox+c8psk+MkocJ5gc8AktOL17VBlLoUHnuZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=Kk7N3a4t; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="Kk7N3a4t"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b013084dc2so2521310e87.0
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1783949705; x=1784554505; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SliLKtP787sX870Cskw0AHEsWHrRbdp92vmeZ+8WbMk=;
        b=Kk7N3a4tDY0BQ4YA/29qmgyQDfcBxzPZuutlxTgxeoNzay9gFtLKwJXp23rPHRtsDa
         HensWkxIYsYt1uw5/0hOC2hqlzOXpDY4r4WESzVyHAm92bTbOF9Qlgd58A9ZBlWvc1RQ
         NgfRwiFchVls+ck7jqJXW+uhOL3w03/5aZuGEWams3CYqrBKftl5dt6uVEEcgI+q1480
         8Gvxym6A54N7Pk7Y8FYLunknkWDwhEde39FlGcHgvQxjq9uxlvQpd05gsnBVjmNzARc1
         hbK1y6Q3XOJJRCWJoVqBau09W2/XyjgGfwOw+cDw+eAFeRWhZ4aG+hpvWPkuZc7XKC37
         qHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783949705; x=1784554505;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SliLKtP787sX870Cskw0AHEsWHrRbdp92vmeZ+8WbMk=;
        b=KnIJewj9v8kmZqsdMWM6TXDpEuc0MlFLlYoGhzpxxKPTLhq/n8wOMxxmp+LJENnzaS
         gIvjl48iOoEnRu2WLuQ0kmlQmaVBqDV9yHcvlUOsA4y6x2atVjspYka+yJpJXO+isihR
         yB6YFweDjNkBtm12AHwTAANc/377qYsYwsLRtdPUvXmj9icATNO8E8m/LGNiTdPVE0+B
         SdxnPLa0f7NS6p0T/O9ZmsCdE9wJtR386OiKQsPUGQHsJHNsq+4evv+P0P7VDTSoEipr
         jC0OHKGDX66ZquAN4GQLdlCWN9Bs4m3/EoY7GqcwK1ikIdJnF/8GiQ9KJhNjt36Whexp
         H5Qw==
X-Forwarded-Encrypted: i=1; AHgh+RrviK57qs/xneV5WJ8DRmYL53PYpUrxw1wQgEcu+5UvA6r7RECv4QIBe+M8ZodO1aJJLfQMTYJAHya9@vger.kernel.org
X-Gm-Message-State: AOJu0YyUR9cTyU9rxxJnX9tV12rAqQWQix7Zg20c2DJZNQMXcfeHh/4n
	UqqRwvyAWr7vL8XAe6s4AQNAi+zEfDbZ0sPccfaW+aA/OA3LfM3obfwwUyFwvH47/GU=
X-Gm-Gg: AfdE7clcnxlR/xMpsbV9AKg0NdIcEtvmxiRPi8aD7flGKdvv4tFj3ImD32/yu3IdNVW
	aM8pp7LkFn82UNFrOOqPk6rHvp17jcvAN/YibV4vcBOWK0vpfUGswCHilXj6vsyDOxDcaz24Z50
	gryeU4CGLwMilSla+3CY79Zk447B+K7xruNDCkuFaLWaBfEI2HKjn7gzPW2Ba9uU+Ra/ELPEvrV
	ivN83Z8/S1GKVPBldAqxqLLIMqU71PoO2euMboOprrr5Bpi1+TsVFp+LIf4wSEMPrQPtU/64CTc
	iGQuzLmiy8ZSNaQpAw/4fEf8LQCMWNr7qdjuIECgrdP6eP7AkrGQVgtZlh67gjML8+W3Mq84+gi
	6+iFRM16tfuMU5BwN45Vs22R7qR9584ZdDRWizznIHnnv4Y+VX04Bc1+fUVVo4jdeqZjKFncg0K
	BZCH/J7N851qwX3m7DkT0sBw==
X-Received: by 2002:a05:6512:6699:10b0:5ae:c27b:f7a0 with SMTP id 2adb3069b0e04-5b023561439mr1182547e87.11.1783949704595;
        Mon, 13 Jul 2026 06:35:04 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b01ca4a287sm2920463e87.3.2026.07.13.06.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:35:04 -0700 (PDT)
Date: Mon, 13 Jul 2026 15:35:00 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, tj@kernel.org, mkoutny@suse.com, 
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, hannes@cmpxchg.org
Subject: Re: [PATCH rdma-next 13/13] RDMA/selftests: Add rxe_netns_names test
Message-ID: <alTpYrmPI_fWz3me@FV6GYCPJ69>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-14-jiri@resnulli.us>
 <20260710095632.8F8A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710095632.8F8A41F000E9@smtp.kernel.org>

Fri, Jul 10, 2026 at 11:56:31AM +0200, sashiko-bot@kernel.org wrote:
>Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
>- [Medium] The test script declares a test plan of 7 tests, but only contains logic to execute 6 tests, causing the script to unconditionally fail.
>- [Medium] The test `TEST_SAME_NETNS_DUP_RENAME` attempts to rename a non-existent device, causing the test to pass for the wrong reason and failing to verify duplicate name rejection.
>--
>
>--- Patch [13]: [PATCH rdma-next 13/13] RDMA/selftests: Add rxe_netns_names test ---
>commit abd8a5c3d2f106017be1f5b869afa69da9c27f3a
>Author: Jiri Pirko <jiri@resnulli.us>
>
>RDMA/selftests: Add rxe_netns_names test
>
>This commit adds a kselftest script that exercises per-netns RDMA device
>naming with RXE. It covers duplicate names across namespaces, move conflict
>handling, move-with-rename, and same-namespace rename requests.
>
>> diff --git a/tools/testing/selftests/rdma/rxe_netns_names.sh b/tools/testing/selftests/rdma/rxe_netns_names.sh
>> new file mode 100755
>> index 0000000000000..a7e57706fdff7
>> --- /dev/null
>> +++ b/tools/testing/selftests/rdma/rxe_netns_names.sh
>
>[ ... ]
>
>> +setup || fail "failed to create net namespaces"
>> +
>> +ktap_print_header
>> +ktap_set_plan 7
>
>[Severity: Medium]
>Does this plan count match the number of tests executed? It looks like the
>script only runs 6 tests, which would cause the test suite to unconditionally
>fail during ktap_finished due to a missing test.

Fixed.


>
>> +
>> +if setup_devs &&
>
>[ ... ]
>
>> +if ! setup_devs; then
>> +	ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
>> +elif rdma dev set "$RXE_A" name "$RXE_SAME" &&
>> +     rdma dev set "$RXE_B" name "$RXE_NEW"; then
>> +	if rdma dev set "$RXE_A" name "$RXE_NEW" >/dev/null 2>&1; then
>
>[Severity: Medium]
>Will this command fail because of a duplicate name, or because the device
>is missing? 
>
>The device originally named RXE_A was just renamed to RXE_SAME in the previous
>condition. If we attempt to rename RXE_A again here, the command fails due to
>the device not being found, which seems to cause the test to pass for the
>wrong reason instead of properly verifying duplicate name rejection.


Fixed.


>
>> +		ktap_test_fail "$TEST_SAME_NETNS_DUP_RENAME"
>> +	elif rdma_dev_exists "" "$RXE_SAME" &&
>> +	     rdma_dev_exists "" "$RXE_NEW"; then
>> +		ktap_test_pass "$TEST_SAME_NETNS_DUP_RENAME"
>
>-- 
>Sashiko AI review · https://sashiko.dev/#/patchset/20260709095532.855647-1-jiri@resnulli.us?part=13
