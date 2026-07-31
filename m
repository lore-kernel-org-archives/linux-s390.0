Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37C52D060D
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 14:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508150; cv=none; b=OC4CsKFczOQKaFHut792oOJHgoSsGTculoYXA2SKII3Ykt1kwwfUqg6/kaIRkHNqUoO/wbmTRtrUD5l8XBd/nFBpUyJJlJKlTv8pCpFYlXV9cqyKw0wx3n0rScDMubawGxvgGdIMdiTub4uc53uuy0TNrNoFOnCC4oLfb8NhN3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508150; c=relaxed/simple;
	bh=irMpV9a/2qawDXmp6ztz+nswVSbGCihY5H3HF6baxUk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uL7ST+GONjQgHtYnqI4tvVbX3DknYFQnOHKDFMR1aFUOQG1y6wdOARXGHBTlN/8dRwQRLtzjyoYA3dT8+UxbJdq1x+0MAnfo9KK79fCW62SkU2S7VyMoOi5WiWG+qLoq3jdQJG6PghLmehcyuZ1cIyseB3TeBGV7qWjGLhrQyBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=h0moRNIj; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="h0moRNIj"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7eb9b427da2so1460336a34.0
        for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 07:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785508148; x=1786112948; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RjhPOZ3bdgpAm7mKb0QctoHN9xX2G/6IKethU/a6XIM=;
        b=h0moRNIjCXcEMLCUfTSV65tAHFN5X1N+a7unU64JTlXbMFYofo4dDQtGy7SwmrzPFo
         /RjhyIiEVU5v/JQiP5O/BxGqwJR6TbiZsRnnf4vnV7gkJ3NDyCZxW72DNQVVyWVNlLuB
         6re+4PTeqpzV7R1qReCd8MMBOeaC2/3L49PDN9zNKipnnqwPSCbistNa8KTWPph0n6p9
         PuO8zG5qbXalWihDCKMaHqe9lmX85noCeko+2ktwiY2gtorhysYIhW0NkDRbpD+keX4U
         Q7x8FOjx9qycPESYi+f2nIRS0NKRNZ+Hi2wgMPpclXUZNgpOlYtVvXNowhaE0tCpQKTf
         yHaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785508148; x=1786112948;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RjhPOZ3bdgpAm7mKb0QctoHN9xX2G/6IKethU/a6XIM=;
        b=PwwH6SdJ2SQ+1X52AD81IEdNRJF5x/0M68CggdCYGiirgO4spOk13SD2bjCcReVG0V
         VrJGOyKoGcJD70GBmLg9139k2neHPXms1TfYhN1xuVHjm3L283mFw8+t2fL/pldrwAWW
         287RSBE3EEgoz+mBE4z/7jUf+jBpNsq0a6xeojg2hlTMoGXoQ4at3v90LmPB0ZTOivo7
         0wE+IvTkRA2LpsP4mRSx27NzwBed/lzpXB3tErdMQvIua68DqXJICUqznEefwwoTuC8y
         QDtS8x5wELG7pDrs1p0M9CLmzJS5ZW9tETOgDZY2DtTJA0Z+r593X3dgfq6//gb9HiG2
         iVPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrkoAvT3QV6iBtzsaGA4nQzObrAD6l/LgXQM6R9INiERwaAmUVzwScv5Y0baKQiHEBcFiUgLxtToGvo@vger.kernel.org
X-Gm-Message-State: AOJu0YyrHcbdhGTdQZ7iXNyh0cUZBr6YFdp6btmb6S07mE9cG/GhACjj
	6SW0q4QKAY6WQ6542bvC4W07GASHiH+kesKBBsudE9L12vMRaZzPxdy2sbQELFgpB0AdGBavo3p
	9oDP38S4REg==
X-Gm-Gg: AR+sD13CBE39wiRxJ2DIfc0pzqdzAC+Dj82rbB+MsqP5ohr2JHulyFcX6PDWGMEnZDl
	umVoeFStiGJdzgnajtrjEkaGDBUuh//otObtDu1JIeZtFu1hhIydAeQpwuIJebT6jpvfm/M+pCB
	CEJjcjd/B8kWRL+7CYERJ/DmnkPUUxwP8CSLKmgKEfCF4S8ACHLwT2/tIClJ+kgo72BZUf0RjMK
	iQ0is3NU1MvxOXapy+lzGNOkg1x/V34dkJo/DqRCHC0abWv8RJDmZLDQIB8JhY7Gu5n7cFwq6o7
	7Gb6R3rQWzOUQuK57zCriICGy5bBDrcES4eYbzSDod2ZZuh3QCj3LBVtoWihr4r1MZSI+5B9Lcy
	QU4xT7/GfpoDlHa2p/1eREX7gIz4IizZTPYqQW8FnLoqh4hqGxKzhvJJShlx6X6D6uZBN1aH/f6
	Vm2j/ypZnmITPp2iZUN3DHn/GBy5sm4+Ah2zvyYLo4eYD+juv60KsWpCMB6222qQMoxowtDgC7y
	Zj4dzeW4EOst85MxzCxorV1JibhS5fA0YVhfN6q5A==
X-Received: by 2002:a05:6820:1985:b0:6aa:e267:f11 with SMTP id 006d021491bc7-6ae38364f69mr2910597eaf.12.1785508147887;
        Fri, 31 Jul 2026 07:29:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458f664d884sm1179699fac.12.2026.07.31.07.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:29:07 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, 
 linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260727142840.567286-1-sth@linux.ibm.com>
References: <20260727142840.567286-1-sth@linux.ibm.com>
Subject: Re: [PATCH 0/3] s390/dasd: fixes
Message-Id: <178550814683.6950.1912092779211953730.b4-ty@b4>
Date: Fri, 31 Jul 2026 08:29:06 -0600
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15.2


On Mon, 27 Jul 2026 16:28:37 +0200, Stefan Haberland wrote:
> please apply the following 3 patches that partially address rather
> important issues in the DASD driver.
> Thanks.
> 
> Jan Höppner (1):
>   s390/dasd: Fix potential NULL pointer dereference
> 
> [...]

Applied, thanks!

[1/3] s390/dasd: Fix path verification interrupted by concurrent dasd_sleep_on_immediatly
      commit: dcba277d119af323c267d1f27f61b868dac62753
[2/3] s390/dasd: Fix potential NULL pointer dereference
      commit: 9973026f572db6b67570cadc30942f3014e41079
[3/3] s390/dasd: Fix undersized format-check buffer
      commit: 7f40b346462f563a0d6e841a77b5163d2a882a04

Best regards,
-- 
Jens Axboe



