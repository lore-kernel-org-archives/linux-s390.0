Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6825DF30
	for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705943762; cv=none; b=kHpfayRzFsmnapUVLne0NT7Af6wqiidURGA0T4fp9eC7scaIa+HFHG4M3EOETThO+qyr0wZr63gnSQdKaSQtfUKZu2VlKke59D4IX1VtM4z7g++SWY74qI3xyyCuThYxRCMKv1WjHAF5k8bv2XOma6SyRstBqp1xatvrx+mbq30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705943762; c=relaxed/simple;
	bh=qi4d0pu7u814/CypIFC9w8MjeTjXsELC8s/V0OQyCwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=so6acGvVVxsSJpx5gm5WqWlFkxcmSLxmcaK9qQmXxNyMjGnhuvQoJZBNqoYdHg8IB7HIO+6cpW2NhBiFRiisn8pYL4kn/odWl/06ibdHcrbP2fDWWGci0wrWN+JXDq6042H4gd9ktR95vKzHMKR4VM0tRZjD7RQgShSwpXjvSYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=a++aXjck; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="a++aXjck"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6d9ac0521c6so829171b3a.0
        for <linux-s390@vger.kernel.org>; Mon, 22 Jan 2024 09:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1705943760; x=1706548560; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZykbXfSEvyPN8az3PbYAztD8rQi+GVKbnMIYIbl6l/g=;
        b=a++aXjck1L2wXtrtA/TvdmT7FflZE2yfaTCL2sLW2+I1jNvqyu/vPsR1ZP3tBGRGLj
         yS4n75zdvUAxBQXpk90UxlFxU9/tkMNu7/kUI++ahkmJr1O6nVdFz3B1X4AVeBhnt3QE
         7OQWTMV7B0A3sRb0mYSGL1xPKDeP5GuwUfbqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705943760; x=1706548560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZykbXfSEvyPN8az3PbYAztD8rQi+GVKbnMIYIbl6l/g=;
        b=RP4x9VfuaBd8GUnnnia+bazrk5yZyMgNKhL/RrfQjOdgKOiv1I/+zcGd991pZeUajl
         bv1xAXnxYnXz4GT7f2xjndYQqF/fzrdwWpqaD7h0or4FUlfTNhLYMTYqYt3WiTsFiQL6
         KpR3yP05nsZEZNHHOF2qBEy+MVrj0m3LKL9Q908b1j90il/54ec/rnw3V0Dvz39i5Je9
         vgxcIfkZpll+ftB6DxUg7CCQjhS1ljzXa1Icy1EgMqrYO6y9XMWGEZE2ay8wj7SYYNnG
         4bcsP3Od69oJS2l4e1/f2c8jUZwLxMVuG5uMSQ1/vkq78GiZWh/5oldxzkHHVlsVyqr3
         D5og==
X-Gm-Message-State: AOJu0Yyj/mTvJNsAMbLds/DxVJzFsmMIIlmdpeeKc8jIdwUy4ZynFCtg
	3uYI1g5jwWFHIEJ7HZj2xCY4d60WF1ZYznF9kuDQobXdkRK6ay93eJm8ZPpJ1/5Htc+DozUbjuS
	t
X-Google-Smtp-Source: AGHT+IF9qblypine1FnCuwH9nIKKzYWA4/9vvuB6JdzWcXCZe3+11yStM3b9Pm3XvyMdKtnaxdg5Yg==
X-Received: by 2002:a62:6204:0:b0:6d9:383b:d91a with SMTP id w4-20020a626204000000b006d9383bd91amr8877907pfb.1.1705943759942;
        Mon, 22 Jan 2024 09:15:59 -0800 (PST)
Received: from [128.240.1.152] ([206.170.126.10])
        by smtp.gmail.com with ESMTPSA id it22-20020a056a00459600b006dbcabc31c5sm4766765pfb.209.2024.01.22.09.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 09:15:59 -0800 (PST)
Message-ID: <5aceb855-2862-4d53-b27b-50e2956e099b@linuxfoundation.org>
Date: Mon, 22 Jan 2024 10:15:57 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/3] kselftests: lib.mk: Add TEST_GEN_MODS_DIR variable
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Shuah Khan
 <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 live-patching@vger.kernel.org
References: <20240112-send-lp-kselftests-v6-0-79f3e9a46717@suse.com>
 <20240112-send-lp-kselftests-v6-1-79f3e9a46717@suse.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240112-send-lp-kselftests-v6-1-79f3e9a46717@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/12/24 10:43, Marcos Paulo de Souza wrote:
> Add TEST_GEN_MODS_DIR variable for kselftests. It can point to
> a directory containing kernel modules that will be used by
> selftest scripts.
> 
> The modules are built as external modules for the running kernel.
> As a result they are always binary compatible and the same tests
> can be used for older or newer kernels.
> 
> The build requires "kernel-devel" package to be installed.
> For example, in the upstream sources, the rpm devel package
> is produced by "make rpm-pkg"
> 
> The modules can be built independently by
> 
>    make -C tools/testing/selftests/livepatch/
> 
> or they will be automatically built before running the tests via
> 
>    make -C tools/testing/selftests/livepatch/ run_tests
> 
> Note that they are _not_ built when running the standalone
> tests by calling, for example, ./test-state.sh.
> 
> Along with TEST_GEN_MODS_DIR, it was necessary to create a new install
> rule. INSTALL_MODS_RULE is needed because INSTALL_SINGLE_RULE would
> copy the entire TEST_GEN_MODS_DIR directory to the destination, even
> the files created by Kbuild to compile the modules. The new install
> rule copies only the .ko files, as we would expect the gen_tar to work.
> 
> Reviewed-by: Joe Lawrence <joe.lawrence@redhat.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>   Documentation/dev-tools/kselftest.rst |  4 ++++
>   tools/testing/selftests/lib.mk        | 26 +++++++++++++++++++++-----


Hi Marcos,

I would like the doc patch and lib.mk patch separate. If lib.mk needs changes
we don't have to touch the doc patch.

thanks,
-- Shuah
