Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BFC14375D
	for <linux-s390@vger.kernel.org>; Tue, 12 Mar 2024 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710280989; cv=none; b=DvNhj2nGO4monGP5k2mb4d1kjdb1DY3tZrgZ8dgu4E+nM4R0fEeHPJuGI2n+ope24K4dWxy3F3lo4OWZQ6yoC7mXusNIKCHlfXJCjHINPgupsPld/BbR3mqBJX4Mi3L8CbzuitIzpiCa+i2SfB709GjMXQMt8gyiBgf6dFn1erI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710280989; c=relaxed/simple;
	bh=D4lY7fxdRPJh4W1hrWZC0Kv5/fDQzdNIZGvAvIvgwj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qY/OfP4sfYTkJ2cHkPOXKLK/U8PHAjvq9r9sl6c/M/u+VrSRMDXL/tNjGPeagx+l2B1KqF9UAtrC7nT5fjuWJNny/F7OUFXfxDYga/CzCuPk0LFtjr/M3dBnsEKNkbtVg9oi0uS3zNNkosKptI6/GQMWispQzAeYQA5U9Mle7XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A/TNZHOd; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/TNZHOd"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c8c0ca77easo12553939f.3
        for <linux-s390@vger.kernel.org>; Tue, 12 Mar 2024 15:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710280986; x=1710885786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bFZkOPzjUiG9hBeGxmULl/XMqNk9IbEaqEvdeXcgD8s=;
        b=A/TNZHOduTDw50espaicZGUQX6jYzVKJBdIDeVnj4Ef+T1kYvYyYeHd8S7/kNrpvGD
         3RH+VH5SOhmcdBNAHJ8Ce3Yzv+nkQ1baRzAymYdkEDF7B0Re6olgpjR2rwsAoVR/EBe7
         bazE+AsiGg4KmyHLPgOg49cRkO+/ghkrdd1OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710280986; x=1710885786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFZkOPzjUiG9hBeGxmULl/XMqNk9IbEaqEvdeXcgD8s=;
        b=OPFHCaS2ofCdfGBMHgaHGV8cltGMOfWI/C28+gXG//9fm0MxJf1LnqaLsgN2F0BVAV
         5rouEvK/pPveXObNzjnk3fz2itCbAYOcCS72U8bYmorbLnnOIQ8tbygfbb6tqCrfXAcq
         GRG4zOcgtz8UQi8JYleXvPxSKHsxdIMqL/OclfJPawpI12LpSbix7cKKx7hNuU6aqKfc
         IwQxuRtcH7Z7uhp4m62F2sBoBCddo/+uJG7Z5707CNjoIR6LEB/lz/XeCwXVVbAHuchK
         k5Wjvnavs9YRLYjK5oUsxY0hO0ZjTHJtkpIZ8RzdjuVWdz4IYFcQlG+G86UxWTyU7Qnk
         lmrA==
X-Forwarded-Encrypted: i=1; AJvYcCVAJwdwOegY45tlI/aeGrnT3kWPxc8abuXrP2XK4qigR+PL0ud32JdrOfUupcSfVDYLGFvFyIaIYoHH5d4WZndxMSODFj/XaAwGRA==
X-Gm-Message-State: AOJu0YyX6kNaZHsWM+qfm9qbJPG5DZk7nZ/1zEp9/yDYWLIgW/FPdYR2
	uTFWMzaHBFxsap9rtcYzlm0frr1XsYHkQ5WYfBCEWogrnVOkEpCDEGGj6/FI/Q==
X-Google-Smtp-Source: AGHT+IEdwN1SY2GeciEHPDmRWgTgdPa04evl6KEFQYoPJeYQSV2BmWI4216WoCmzy6l7zJDsrZVhNw==
X-Received: by 2002:a6b:e719:0:b0:7c8:bf15:5653 with SMTP id b25-20020a6be719000000b007c8bf155653mr4918871ioh.20.1710280986087;
        Tue, 12 Mar 2024 15:03:06 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id m14-20020a63ed4e000000b005dc816b2369sm6650251pgk.28.2024.03.12.15.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 15:03:05 -0700 (PDT)
Date: Tue, 12 Mar 2024 15:03:05 -0700
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
Subject: Re: [PATCH 04/14] kunit: Add documentation for warning backtrace
 suppression API
Message-ID: <202403121503.B97DE8A60E@keescook>
References: <20240312170309.2546362-1-linux@roeck-us.net>
 <20240312170309.2546362-5-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312170309.2546362-5-linux@roeck-us.net>

On Tue, Mar 12, 2024 at 10:02:59AM -0700, Guenter Roeck wrote:
> Document API functions for suppressing warning backtraces.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
