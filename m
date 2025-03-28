Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B2F1DF986
	for <linux-s390@vger.kernel.org>; Fri, 28 Mar 2025 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743186480; cv=none; b=bv90/lorKzPbMZp4KouXptdCl1ajictoU0BpAhjLJXtFFMYXK5knAOlN2XZSPqvX23Hf+UmcgFbn+dFl4kScC/luriGidZTGh5i/iIrFZ6m23h43rgggPhrZ2vs1pnQjIwH9UDGr9khjhKrb4x1NtrCpNO5j9+9fEegPw0FJCzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743186480; c=relaxed/simple;
	bh=XRJ2FZolH/J8Y0TJOfbHKH9CMImV97LQTgnKGL2Hwsw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hYq77vEgWSJ7+WygjXTBXjcxRHRbRRvHLLC4h89GrC/m3/Dthfdvr4oo4HiU0zhAeiz6JbyUsY2okXR3xXSDVJgnJAiADclz9wo3V1Na2eK2ZRysQLEurC4sqZ4Ff+HU6RibtJ7O59ikV3dSzbLInWxmq6jUMCkbq7GDOpcwcFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AXfkpJpI; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AXfkpJpI"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-229170fbe74so30699495ad.2
        for <linux-s390@vger.kernel.org>; Fri, 28 Mar 2025 11:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743186478; x=1743791278; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XRJ2FZolH/J8Y0TJOfbHKH9CMImV97LQTgnKGL2Hwsw=;
        b=AXfkpJpIao4h60Uk1V+v/keV4ey5Qh+GNg12MdJ5OCelMOZiJNoIOvC+xpsqo/gb1U
         ERLgSnXdEYxT/ClygQa58LRhbEKW2YMgs+ibpL53AeHcPUwevPlgyKs5KumyksYL34kY
         ewd161x30vDQehAEt8x0lVdJTNrJ+Pw4SZZi7+AZROI5zfb6CPIk7uR1ziMmtA45cMDA
         V6locCK2SBsGREayCy6UK/TpoIZt7yAZ0+af3tPjwEJwt1z5jtXK9mJg2dcRNcPQ1hfd
         KGYH+8lgi0xZrikrtoR0rP38mHK9bIaqyH68ATcP/yssps1rgv15wPB4rN32P0Zg5dEs
         6bYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743186478; x=1743791278;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XRJ2FZolH/J8Y0TJOfbHKH9CMImV97LQTgnKGL2Hwsw=;
        b=TQtX85ZRjLd+yohfwHR+v/GlxZysJ2+FgNFOz4X3ywoxBVoHtv/3idQVt81iq0bl5P
         l+RCot/ZC8beLHFLD3BpSfhTz1kcNSkauyIuqrWg1hmFKThujA9b5F/990yL+Rx4BW8e
         qVKvmINiSkk7PDisARLixJvC/3ViHecwusHcRie2ip+LxrObACnRXcr30K88gcrUSRMb
         aO1hvldfSoFuIQsSI8NPW+wJaSrzzcViVBPYF1N7eiE9j5anXcYpwyTLFT+JcClLRca5
         5A5ThLiaNUcfXXP6mIAm4qrX7ZcVtvJJ9lIkwgYiWx39dOrdk/ra5qg2vuRcZhRfhCJt
         d6Zw==
X-Forwarded-Encrypted: i=1; AJvYcCXq8LFMd77fJU3ajKc4xlBEuBDP5CMzH2j2wSV4EKY5mnc3bIqMX1IGoexilbXuKgva0CziAxvXzjZ7@vger.kernel.org
X-Gm-Message-State: AOJu0YwBWZD1cfTM1nmu8qCVqrTZqzbA3LatxBMIw4k4QdxY5+jBe2Ww
	uuTqxv2UUJD8FFxklcdfgQKurrGdnOf4m4rn03sVWhcdFISyTusiRLMiRElwWdLu1fPkQqzhFl4
	Olg==
X-Google-Smtp-Source: AGHT+IFBBQtgOfvWzPAF5i2yJMdV/dsAvgseHW7W6uZZ4TV1TuGHUdK+sVb0HFuE+coaNQr6/L++8gG9I3c=
X-Received: from plgi13.prod.google.com ([2002:a17:902:cf0d:b0:220:ecac:27e5])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:189:b0:223:f9a4:3f99
 with SMTP id d9443c01a7336-2292f975798mr2954795ad.29.1743186477887; Fri, 28
 Mar 2025 11:27:57 -0700 (PDT)
Date: Fri, 28 Mar 2025 11:27:52 -0700
In-Reply-To: <815e95e9-5a2d-4ef7-96bf-321fb57f42e7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <815e95e9-5a2d-4ef7-96bf-321fb57f42e7@linux.ibm.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328182752.769662-1-ctshao@google.com>
Subject: Re: [PATCH] perf/test: Skip leader sampling for s390
From: Chun-Tse Shao <ctshao@google.com>
To: tmricht@linux.ibm.com
Cc: acme@kernel.org, agordeev@linux.ibm.com, gor@linux.ibm.com, 
	hca@linux.ibm.com, irogers@google.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	namhyung@kernel.org, sumanthk@linux.ibm.com, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

We believe we know the problem, appreciate Stephan Eranian's investigation.
It comes from throttling. While the sampling is too high, the generic code
does not modify event scheduling. `perf_event_overflow()` simply returns 1,
and subsequently, `pmu_stop()` only stops the leader event, not the slave
events because the arch layer does not consider groups. Also, the
`event_stop()` callback only operates on a single event, not the siblings.

This would impact all architectures. Perhaps we can extend the
`evnet_stop()` callback to include a new argument to also stop the siblings.
We also welcome all suggestions and open to discuss any potential solutions.

Thanks,
CT

Cc: Stephane Eranian <eranian@google.com>
