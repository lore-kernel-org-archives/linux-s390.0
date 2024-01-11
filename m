Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37B515EBF
	for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UTZd9lDa"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2c375d2430so105313566b.1
        for <linux-s390@vger.kernel.org>; Thu, 11 Jan 2024 05:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1704978863; x=1705583663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YCNCVeMrlWJxf5qX+E5fJGrbwnZ87NzyDtVjQyYpgQk=;
        b=UTZd9lDafTlUTQtNY6vQS/PQVO9sDK+3DpFc++J83gZ+R2H515eoPglREqAYxvqTna
         HkMoIQI3TzyOob/RqNDNsgusv9WFsEjKaR+4jNlGzPvwInOnn2aEMBcFC3uV/PIxlneY
         A6xzWOHB3oqdDD+pjZrpodZs7L1TJOH4M9NZAy/L89qSESAt24znxuAC31ApRNwF51Wo
         OYBsc+FVsHWfx973FShGgNR0gRTL4SJ9srabe4bD9MhjAfozu16nDGyo6NwHBVC+UW2F
         dQODLnXuUOSUhZjelytJNSK+dtVtIeXb9GRBgxRBECReTHLf1XB56mq/j/K7d9e3eTia
         1d+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704978863; x=1705583663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCNCVeMrlWJxf5qX+E5fJGrbwnZ87NzyDtVjQyYpgQk=;
        b=ghDLtNTYtO4cdlkewp9x0jlWm9XGRlWkxsmVZi/RnEKKj8yr6u7hpMQ0UdfsbXqYPW
         QOOSIwC6f7cbUQm6T93/OrRljLVMx0L+TzbiLJtW+H1im6e60ihaCjqdBsqiH+rQY3nG
         NVffyEfDnqHhGhidsw1a/OeSOucUY+I4Hhg+4cZHJfKGaUznpW0zYgi7S6MH4V3PfNot
         B5ouTO/boerPBUMIp/YhelHmdRsYEaDMvNPkly+sLVMGKTO3VFMWMVlDgIJOdDn8NDZX
         zcVxuiLj19pweiYILQMoCL88T+sqb5weGrP0rYEGsM/YtkzegI0GcgKK613ZA5E+DWRM
         earw==
X-Gm-Message-State: AOJu0YymcgUbic7xq5rU0m3GnrKvSscw8LSYD5uVc92XDkZTvgHHcY7w
	6m+CiQTDBUTGaCdXSk2kyPmb6IxNlcot5Q==
X-Google-Smtp-Source: AGHT+IGBVw22W2OzEoJmEk9Elwj9ma9Il/3v/LVT8XzL3+C0bm8CX5rIyMF55d9KmXgQCByhP0JI3g==
X-Received: by 2002:a17:906:6a05:b0:a28:ac84:5d52 with SMTP id qw5-20020a1709066a0500b00a28ac845d52mr782286ejc.2.1704978863223;
        Thu, 11 Jan 2024 05:14:23 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id u3-20020a1709064ac300b00a269b4692a9sm568895ejt.84.2024.01.11.05.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 05:14:23 -0800 (PST)
Date: Thu, 11 Jan 2024 14:14:20 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
	Joe Lawrence <joe.lawrence@redhat.com>,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH v5 1/3] kselftests: lib.mk: Add TEST_GEN_MODS_DIR variable
Message-ID: <ZZ_phoS29aNXplC2@alley>
References: <20240109-send-lp-kselftests-v5-0-364d59a69f12@suse.com>
 <20240109-send-lp-kselftests-v5-1-364d59a69f12@suse.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109-send-lp-kselftests-v5-1-364d59a69f12@suse.com>

On Tue 2024-01-09 21:24:54, Marcos Paulo de Souza wrote:
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
>   make -C tools/testing/selftests/livepatch/
> 
> or they will be automatically built before running the tests via
> 
>   make -C tools/testing/selftests/livepatch/ run_tests
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
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

I am not export on kbuild. But it looks reasonable and works for me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

