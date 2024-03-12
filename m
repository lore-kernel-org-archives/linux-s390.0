Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A782143748
	for <linux-s390@vger.kernel.org>; Tue, 12 Mar 2024 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280862; cv=none; b=lOpVw6TFQnyM2uAx60uExv21elFMNDh8rpyHn+oulemXA8TXnBkWKRa+MthikuBSC51DVGWMxJ5oM3go/IbaAB8FBR4OSMfWbpgFZ67XTKwYQehwVkhzomtZUsFzRiC6iq/9lXOV2RkRqHV+2NRNEo7oNAtoktQZqe3Cjvna+h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280862; c=relaxed/simple;
	bh=wGnHuFYICWDAqpBS7st1+d1ZNPu8frSboYhyV8sLtoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mudyd/jfk48brR9XbYm7DWq72MlNTduALiH1axnrrCqPoRQfDknoE4P9OrQmM55ZS3jhE7F7aObhkNS+7GfByvZfnAilI8aqdYKEtUQbhoc9GyL08VNVn2RB9rYssRAa4X5+HCCj2KRd4mivxtEC3//QKFD6ZBkarBiB8Ol+irc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=IdtI2Ovp; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="IdtI2Ovp"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29c14800a7fso1754356a91.2
        for <linux-s390@vger.kernel.org>; Tue, 12 Mar 2024 15:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710280859; x=1710885659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lLq08iYnVcnWuDzFJHO0LDnyeIZ1/WCj/v6YSvUnsiY=;
        b=IdtI2OvpSorUoROtlC29BT/59AfyqYkwITljCmkf2/G6/yKSNivtz6BNk3sZ+rAX7b
         l6ajD7icfu/XgUu+s078GIcdEyRoVcRDW9XU5RI8qxd89Wq6BBoRgr6qtnnN+9LkHN6E
         xYOdDeOVyTgi57HS7d3uMuSeHPmFAHrcyPKVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280859; x=1710885659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLq08iYnVcnWuDzFJHO0LDnyeIZ1/WCj/v6YSvUnsiY=;
        b=mggvo1OJWEsgJKvcNKskNBezrE6KVYk3nn6naKz7eqy+tt+viKU2jbkH+Z4nToB1lC
         BKy+pFZCDDQI8ncWLNlD7AyouhBnYdbb1vMC68DPhZ5eXyrMlKmMVHrQG3KEptZsWBKL
         ns0PAJuhkr4J5VC3YU+uSEqa22c0Yzc/QwFyTBiNxeqm5u4lxdLo2ne5ejixda5V4thZ
         3HCOEDHgtKQ4cnP/0EQasbrmALnlcSPq3D0PufFnH/26iF8BOYt823dB3aRTzgaNj3Qw
         YM6e0G+VPnECSwBEtAjR4pBeaQGLap8y3rzH2j1m9COxrbgeuYpf/t/zsyYxOxvUhFpE
         JCBA==
X-Forwarded-Encrypted: i=1; AJvYcCVsyTbuq4keeX5/IwcAO0mOdbFiq3G3eHi0SLjFcMkF2V7DsJYffe60uAzJWdxdQgE0g0TlqgnHgxv1quYhPV1Ys7ylTFnGXiRYMw==
X-Gm-Message-State: AOJu0Yym1mboZvTBCBey9v+DgSX9897iCUPJQbNIKAfptBcuQJJkoxyL
	9b+qLitpgJ5yR6aUWkIxcK3+97pwE9NyJ9CV2ViaWBHdhJ4OTT1zAM7k5y7IZw==
X-Google-Smtp-Source: AGHT+IHdha0C7GHgTOtn+h7GC1nV2SuVFIKnwQ0XR5LyRaxyHLt5ciUVNw2VJKedo24c6BQYxDb+PA==
X-Received: by 2002:a17:90a:8b02:b0:299:4cc5:aa25 with SMTP id y2-20020a17090a8b0200b002994cc5aa25mr2853635pjn.25.1710280859551;
        Tue, 12 Mar 2024 15:00:59 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e5c800b001ddb57a4dffsm2232631plf.132.2024.03.12.15.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:00:59 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:00:58 -0700
From: Kees Cook <keescook@chromium.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Daniel Diaz <daniel.diaz@linaro.org>,
	David Gow <davidgow@google.com>,
	Arthur Grillo <arthurgrillo@riseup.net>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Maxime Ripard <mripard@kernel.org>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, loongarch@lists.linux.dev,
	netdev@lists.linux.dev
Subject: Re: [PATCH 01/14] bug/kunit: Core support for suppressing warning
 backtraces
Message-ID: <202403121500.64A2C02@keescook>
References: <20240312170309.2546362-1-linux@roeck-us.net>
 <20240312170309.2546362-2-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312170309.2546362-2-linux@roeck-us.net>

On Tue, Mar 12, 2024 at 10:02:56AM -0700, Guenter Roeck wrote:
> Some unit tests intentionally trigger warning backtraces by passing
> bad parameters to API functions. Such unit tests typically check the
> return value from those calls, not the existence of the warning backtrace.
> 
> Such intentionally generated warning backtraces are neither desirable
> nor useful for a number of reasons.
> - They can result in overlooked real problems.
> - A warning that suddenly starts to show up in unit tests needs to be
>   investigated and has to be marked to be ignored, for example by
>   adjusting filter scripts. Such filters are ad-hoc because there is
>   no real standard format for warnings. On top of that, such filter
>   scripts would require constant maintenance.
> 
> One option to address problem would be to add messages such as "expected
> warning backtraces start / end here" to the kernel log.  However, that
> would again require filter scripts, it might result in missing real
> problematic warning backtraces triggered while the test is running, and
> the irrelevant backtrace(s) would still clog the kernel log.
> 
> Solve the problem by providing a means to identify and suppress specific
> warning backtraces while executing test code.
> 
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Daniel Diaz <daniel.diaz@linaro.org>
> Cc: Naresh Kamboju <naresh.kamboju@linaro.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Yup, this looks fine to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
