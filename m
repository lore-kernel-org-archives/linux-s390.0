Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059D168D9
	for <linux-s390@vger.kernel.org>; Wed, 13 Mar 2024 07:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710315576; cv=none; b=EoaAJFtfe0X5C3My5e2BtEeUifg4zLi0H/XBPgOtwvszRAFY61pu7p8J0QBWHLUj7TM1lbui7YpbML3vtxAfd8SXOxJ23NHfFkXasShXvwWO2+rbzztGditODv42MOUcrRsQdCJVi86k35JVOpV9F6ttZptar6e4JxsAF5/133o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710315576; c=relaxed/simple;
	bh=AvANucvrZ/fsPo2yOI31iWo1FDKNiABMfD22ldNz5dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kg1CT5xFYamhuNrGf+vdUpecgHEcgTiZ7K9NfxsoJKOgGaGWS5yK++mj9iZ98jERugx11QUc2A1h6UC3rhAR/8SzFxz7apvkHXd7utRYCgwYLXUNwSCcV4Z/4Qf6sNX+9LFfeLcVrApNLHcyFArIV65J+MeK/+wT8rZe1w9ym+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GdnaITHH; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GdnaITHH"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a44665605f3so876193966b.2
        for <linux-s390@vger.kernel.org>; Wed, 13 Mar 2024 00:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710315572; x=1710920372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AvANucvrZ/fsPo2yOI31iWo1FDKNiABMfD22ldNz5dc=;
        b=GdnaITHHnDyTc59DrnY/aK1qBmW4s8v+1Wlo7OaXKXq57D0uGr0gsQX/ItX/BACBPM
         mCpMOjziUb+3Mn5COgkXtUpoeoLEcXZCGTpgGjzVyLc+VMKae2PiFkxwSu99rRhGu5PL
         h0DwhApPO9cJtQFK8IR03dSWBM+quu8+QvheMmkAeD9cyenRXDT5FzO/WA+ETkmUxyZa
         SN1VD6WkfLXCEc+IYf4zf/JHE0Wo1vDZsy4xcu7u+lDW5Wu0D+wy0+1TtlvzrncNvHlr
         tpridwRMpXbbySaNM/TBwn2tAXOaruwSht9ctgRneZZUslHQzUPXkKVV6MMDE1ceGHf3
         4nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710315572; x=1710920372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AvANucvrZ/fsPo2yOI31iWo1FDKNiABMfD22ldNz5dc=;
        b=qi3XO4u++OkWdEUMOcoNk9P0H6rDOX2iWla49GcLCDv1ZP/ii3fI2fy2iP0fdbeT2J
         Jh7C+/q90kfSOERFTkCUqGDIxYdiWrCzQPmrWWo8nP495D2iGVvu6K5uFgpEpADJsJLt
         XHSa99AqwFIEKqicZuz1JSNlOs94pGN8Sj8n9cmOShTib7UHsiFQQKOd7u7LBesSVL3k
         X6N8dTN9mbQ+jb/gsMz0NgxE4sJ77eIFMEIfWIneXgVO+Z7bj6SstJa7CIa14LRxkTJk
         gU1cSy/m7R1+fmHcgtTWKP8i+SRK1kNzeRg77FVBJ0qeKZ7r8eMNK55pvyjCux4e/beV
         HZbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn+N4R3qBJlGE6xJpVED3o2L4NVlO8OyUYjmmgx3uLz+M0CQzBgq19/feUGHZV/YdToECY+Z3eHAub75Hz1yewWv+++naR0WsGfg==
X-Gm-Message-State: AOJu0YzYM08erPD5TMSbNfRg7K9wvogabDaLWa5prkqezfBbk4XWHn/B
	Ij6iv0rSqBcyiNMhmjPjQqdtEn20eQhT17nIk+DL0P69CLNFeGgMdw1QvXwUAG8=
X-Google-Smtp-Source: AGHT+IH38GneADkyKtRbEkb8+HLK5ZsZNpyhD22lE4uk6eUmiwmdHa00scLatPQEFNYx/T2Y2VkSUg==
X-Received: by 2002:a17:906:2ccb:b0:a41:3e39:b918 with SMTP id r11-20020a1709062ccb00b00a413e39b918mr7484516ejr.24.1710315572226;
        Wed, 13 Mar 2024 00:39:32 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id qx26-20020a170906fcda00b00a45a687b52asm4578781ejb.213.2024.03.13.00.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 00:39:31 -0700 (PDT)
Date: Wed, 13 Mar 2024 10:39:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kselftest@vger.kernel.org, David Airlie <airlied@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>,
	Kees Cook <keescook@chromium.org>,
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
Subject: Re: [PATCH 00/14] Add support for suppressing warning backtraces
Message-ID: <43ef4ef4-303b-45c6-aa50-3e0982c93bd7@moroto.mountain>
References: <20240312170309.2546362-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312170309.2546362-1-linux@roeck-us.net>

Thanks!

Acked-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter

