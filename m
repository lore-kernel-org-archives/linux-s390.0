Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B541F0984
	for <linux-s390@vger.kernel.org>; Tue, 10 Jun 2025 16:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749572164; cv=none; b=ed4WZ4ll3rE/OpqwzL9/emLzUe90h/qDHY5O7uQRkrd1FRXYuewrlOxe/w6mlqFowyMgAlgjMgK2k2X2hIiqC24FJ473PLtuH6kTLS7xckDjKGEKJgziaZZskXoIfgTFQ74TWQVgFzBm1VmUg2gA5ENKes4Tofpb23/SlpG+UNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749572164; c=relaxed/simple;
	bh=i1wysgW5zGZ4yIMcnwwg65sgoJiICB3in7hX8h58OOs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Jx5xUK/8mqjEFU0cOWXaaUcHP3RCjGhrlnWkG4PZlxAYVj/95DBuDeK/oiHYbc0qnbpOtW4dwuDQBHmaE8F7Y5DT5o1Rt3BOYM6bx7D4PXKJc59NSDqq/5cx7HcD2QpLXZmG2xw/O2awYDdp5hhdQe1Y/WZXzscaAncvTB05jCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WoSkqB/Y; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WoSkqB/Y"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so2031104a91.1
        for <linux-s390@vger.kernel.org>; Tue, 10 Jun 2025 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749572162; x=1750176962; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUiAnBaABBi8MmezG61ur8Gw02SUWXIVP1zr4GYN+eo=;
        b=WoSkqB/YtB3i5+UxGLQqkpT5EmTOmLMJfo2UD0yxuDvN9CY0ZOQE1nlGImbfxxFuCq
         cfitA5mFGzYltFmQfaY3S8+57TCuTj3zHkJKpL+05u+A1rTjBrpnfbJdxq1aFKFIDyG5
         rpYZTnBsjWEk1XoBd71F+C/HSjbVmWGtizcX9UOTdGenPlKB98ayB021aJYLVZP0agOp
         XLrtMlMKIOeEBeBbJc4hLy1dMzCFGeoVwiAszzB4zCwcubb/1enwaUTX68ryqbpUleCn
         pJb+Gdh1PyhW8ettAFdMSkXY558+kvbYk3/g+s5+5UcbnyPXKHR3zGT1B4P96VAGZsKv
         rbmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749572162; x=1750176962;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cUiAnBaABBi8MmezG61ur8Gw02SUWXIVP1zr4GYN+eo=;
        b=vAG1wMhcYPcQERJmj3A1wLHwBpmJRQBUP3qb+qoqzgCCJTYI81BAciwh3bhpQd4ntR
         yTTI0CaUAkQP6jskdRuOQdTg/E0deHLXvGxOKBxSE5B1YTeymj9jWgQq3zGEQkomZP0o
         bdb1pg3aSC0vnNG0Ou8wVrf1hPSYBSOOQ/BPiIHu8voXBQsVpgiu2MwbIM5Ea49iWT9p
         yDWozfeS16xU1z7eXSL3GT6StqQlMYx0QMq8Xmau+wZvVsKHPAo3L+zUgn1V1xGVEUmQ
         D+NpztXzaNKHCoCjFIbeNsMRmVFOlcu9/7kztS/mqDhmCble12KGliNns/fcU+mgERur
         sroQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvrXonQczeg2mWTdqVGaDO7jiWUGYQKXtb/H7Nltn2/UGRKai6YWayFTqfUa0hqjGUGwiBr8b5K9rk@vger.kernel.org
X-Gm-Message-State: AOJu0YwFWzSOyuyukr1uHfWWgsk4Nj/grZ8sBKuogL6casvmpoEc0bKC
	M0Q5YE8KKcxCqccAVCf61YxYac/P7MqfPYGqhgk3WeLl2HuZtH8Ydw06fUcNJE6QWScwc+fWM5K
	1rSUfeg==
X-Google-Smtp-Source: AGHT+IFXepQ7WyapQC/S8+sadNNKa7dRlJl1xoZOq4ObQKiG309XNQlCV5UWTBLTlgr03UbH2Wtya4oGIg8=
X-Received: from pjbst14.prod.google.com ([2002:a17:90b:1fce:b0:2ea:29de:af10])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3906:b0:311:ad7f:3281
 with SMTP id 98e67ed59e1d1-313af10ad5dmr288344a91.12.1749572161888; Tue, 10
 Jun 2025 09:16:01 -0700 (PDT)
Date: Tue, 10 Jun 2025 09:16:00 -0700
In-Reply-To: <ffb5e853-dedc-45bb-acd8-c58ff2fc0b71@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250529221929.3807680-1-seanjc@google.com> <20250529221929.3807680-8-seanjc@google.com>
 <ffb5e853-dedc-45bb-acd8-c58ff2fc0b71@linux.intel.com>
Message-ID: <aEhaQITromUV7lIO@google.com>
Subject: Re: [kvm-unit-tests PATCH 07/16] x86/pmu: Rename pmu_gp_counter_is_available()
 to pmu_arch_event_is_available()
From: Sean Christopherson <seanjc@google.com>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Andrew Jones <andrew.jones@linux.dev>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, "Nico =?utf-8?B?QsO2aHI=?=" <nrb@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, kvm-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Jun 10, 2025, Dapeng Mi wrote:
> On 5/30/2025 6:19 AM, Sean Christopherson wrote:
> > @@ -51,7 +51,7 @@ void pmu_init(void)
> >  		}
> >  		pmu.gp_counter_width = PMC_DEFAULT_WIDTH;
> >  		pmu.gp_counter_mask_length = pmu.nr_gp_counters;
> > -		pmu.gp_counter_available = (1u << pmu.nr_gp_counters) - 1;
> > +		pmu.arch_event_available = (1u << pmu.nr_gp_counters) - 1;
> 
> "available architectural events" and "available GP counters" are two
> different things. I know this would be changed in later patch 09/16, but
> it's really confusing. Could we merge the later patch 09/16 into this patch?

Ya.  I was trying to not mix too many things in one patch, but looking at this
again, I 100% agree that squashing 7-9 into one patch is better overall.

> > @@ -463,7 +463,7 @@ static void check_counters_many(void)
> >  	int i, n;
> >  
> >  	for (i = 0, n = 0; n < pmu.nr_gp_counters; i++) {
> > -		if (!pmu_gp_counter_is_available(i))
> > +		if (!pmu_arch_event_is_available(i))
> >  			continue;
> 
> The intent of check_counters_many() is to verify all available GP and fixed
> counters can count correctly at the same time. So we should select another
> available event to verify the counter instead of skipping the counter if an
> event is not available.

Agreed, but I'm going to defer that for now, this series already wanders in too
many directions.  Definitely feel free to post a patch.
