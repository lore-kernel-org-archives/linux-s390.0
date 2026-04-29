Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B2E37472D
	for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2026 21:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498760; cv=none; b=GcfsskCCQefQ8T3YuEFcPM4VGPrtDU4aONq4PxqhIOLlxKODre3jGF8JIVQkrqMW+o2KrMvBsA86eWfb0c+yW3dSxP8Ier2Y2egu5bYbJ0oUH2rTxHd16P5BcoodUysIvsyrplBgWkJr+TtCZ15mbZTpwiDpgzqebP5Z8xDPeQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498760; c=relaxed/simple;
	bh=h2lh+8R29qTzWsXnZAvURjNXsuGB5WenhZEuqHf4SBc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hX/FeXrEPdlSVvCy94yY9VGsm1/aRWO5afD7Hg2Aid2gmaSgdBCH9cYSnIaaPMu63fRXqt698WE+WIjOxDfOzjfZ1a0P3mAI0Y0ne0/9L0cNGBwuPAptfZqGN7bxXjU1d/m085YPxb6ExQ4feYC8yOAEer2N/l/hXxsLc/B48Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5bQ50hn; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5bQ50hn"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso2103785e9.2
        for <linux-s390@vger.kernel.org>; Wed, 29 Apr 2026 14:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777498757; x=1778103557; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=h2lh+8R29qTzWsXnZAvURjNXsuGB5WenhZEuqHf4SBc=;
        b=N5bQ50hnQLU5SuM8FDcuiqJ8n4PpUZ7auDRDlzzpV1m9PGW0kQxKA/f/8Q7m2sPKPO
         /TgLPPfJQZhHJ1E3tF48Hg8XaP3bcLZLIbZvmy7j87/b+kjlCDVTsK0kmeEx6Ip4I2Qf
         AevY5G+6HLnYAZpZlShKx52vXS4Mkjf4pVAMLw+SwobmWYj8vYtz1kcKD6Eg3PO/2b+u
         7Lot/hpQ4GYQoyQAvp1UKwjPzVbhVOyuo3vPLS0xYZ6zNcaPmj3KOnEGGkY90twDNh3/
         UNtz9uySkNR1xE8SCv3gfHU4eo3OTwm8UJYKIZ6scmKV4Z+Y0aSqEZktvKSfMZH3064U
         N8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777498757; x=1778103557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2lh+8R29qTzWsXnZAvURjNXsuGB5WenhZEuqHf4SBc=;
        b=PgGyxoLFuypGmexajRPWMnTtbdmIhm/93etzgi/GoHc87TmOHqcthD5W5tWaF3v+8c
         8D/LW83HAgxpMhrA0upVExFmooUC+OwTyS0GadOiKT8Kim11sjkA5AnkOOiVT5w58KOD
         U+z3xSziCUjYXxqHBknH1C2WGJjtHm04oKgM2Nl7TNrRVIjiDGgRSECXCFpzPN4FXzaB
         XS4OwGdFP4q7U9NiIE3D33lUPF2ID/D6AiexsQJuP9O7uFhDIw+Y9NrDYeC2x4TmTPyf
         ufTrS0oOB1HI+1s2Q/dQJNQYKPLxHhNGPbVTs+Fb3H3o+HMmHJparIcdfTBaEONaZfMa
         fFpg==
X-Forwarded-Encrypted: i=1; AFNElJ/Kezr4OZauK4NhRdekFGwPy8Bc3dpGNSpNfZoG+NSTDBp9S/Rqy9KXhL72vS2WvWbL4zYC5LUtJ3Gt@vger.kernel.org
X-Gm-Message-State: AOJu0YyiffZI2a/gWOrm5KqVLH2JUGQkvENSNyHA6zr6hB6mYPs+sQDn
	Qz+bkckR/CHdhW8ooxZ7cReuFexst/uyArf5C+mElIgfSBoEhCz/3rrV
X-Gm-Gg: AeBDieuxO0PlWY0BmgTKQJJ1ZjU0jQrdOTuAC2EsVsMwqj6xQL1hejQaZ//huEQ0no7
	9KJ/EsHRtgwhX+N5ft43j6dxDnnyMp2t40SH+qqY6/9r9vV8W7Rg0Ro3x0JYI7182W5uJFYSSEM
	m6GaZhY61sWmiQQh5APo8Pqc+xgfM/r/SGyVxL7PDR9liR5p8C1bIyhGGbgpwYx/AjLauT3RSkh
	AF69H82L4zwvEcJjMQ8daLR78p6Kg+cZpbRbB1GxWryTUpcxrYrMUNP6QVN/roL538nnR7yBa/c
	LGObo59ncFbFPVfnyxj64BitvYwQppPJv2s5UvgzTJNQ++Mw30OrV7IG1RIm/O/PX5ow0JIJgXY
	gsg6zwoGJ9OygHzcU3CUMITvyiVWHXMAFbCKClxTloeCx460bWGGcN/eDG3GAmlME0CMeYvVrKJ
	e7xcNbZ94AdaAtaDvqTosiYxJTgQn2Oo0rtVHXXdONFO+2jwKem0Z4L4T2QdeNqbNWxHaFKA==
X-Received: by 2002:a05:600c:8b76:b0:48a:599a:36fe with SMTP id 5b1f17b1804b1-48a8447bc67mr5025475e9.24.1777498756672;
        Wed, 29 Apr 2026 14:39:16 -0700 (PDT)
Received: from [10.128.10.158] (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81b9493bsm16333925e9.0.2026.04.29.14.39.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 14:39:16 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <b3dba59d-22cc-4404-8876-8fd4e22021b5@gmail.com>
Date: Wed, 29 Apr 2026 22:39:14 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] s390: fix dead defaults for
 S390_MODULES_SANITY_TEST and S390_UNWIND_SELFTEST
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: gor@linux.ibm.com, hca@linux.ibm.com, iii@linux.ibm.com,
 meted@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
 akpm@linux-foundation.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260414215651.151228-1-julianbraha@gmail.com>
 <a3adc8e8-ce4c-458c-a0c8-c0e66078589d-agordeev@linux.ibm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <a3adc8e8-ce4c-458c-a0c8-c0e66078589d-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026, Alexander Gordeev <agordeev@linux.ibm.com> wrote:
> This tool is still in development, right?

You can find the latest release (v0.7) outside the tree here:
https://github.com/julianbraha/kconfirm

And there's also a recent RFC to move it into the tree here:
https://lore.kernel.org/all/20260427174429.779474-1-julianbraha@gmail.com/

> Anyway, I do not quite get what do you mean with the dead code.
> Could you please elaborate?

Sure! In kconfig, default statements are evaluated in the order
they appear (top --> bottom). This means that if you have an
unconditional default statement at the top, e.g. 'default n', then all
of the default statements that follow it will never be evaluated - in
other words, they are dead code.

In the case of this code in particular, the 'def_tristate n' at the top
does two things:
1. declares the type of the config option as a tristate,
2. sets the default value to 'n' unconditionally.

So, the 'default KUNIT_ALL_TESTS' statement that follows is dead code.

See also this sentence from the "Menu attributes" section of the kconfig
docs:
"If multiple default values are visible, only the first defined one is
active."
Source:
https://docs.kernel.org/kbuild/kconfig-language.html

- Julian Braha
