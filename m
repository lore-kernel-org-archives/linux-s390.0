Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43ED3939BF
	for <linux-s390@vger.kernel.org>; Mon,  6 Apr 2026 17:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498370; cv=none; b=t1Wo/sYFTViD/os3Ha5ieHRc+AnJYCtNAKnFY1n3x2sjGAudafX+nMfjG0JvIq5juL5rAFdxDNt4GGN/tiNVV2PYrojwcuIJSLSKls0rPYsDEDgyr+dO6qZmRQHzh4H0D7ISkTym19+AfkfmJcW0KhDYA5mSm/c4LbjQrfQMYOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498370; c=relaxed/simple;
	bh=K7QUyorWgJ1bt/io0zMKMx3F/m5DdiP3gvFGZ8CTS3c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DYnGaCRY/Wqo1ZhKY95F/QEz3SIcbU2LIEbjvacywnv4002kXFObiCxkQ58rXGqp9f30laLBchDMrSAiIIQiochocxU9keduIOb7N7E0IOpGGI8HNAvSJ7Upp+SJStqGBobcBYV821e4OQGo/vXtxlKbkskBpK59Jw1ojg3hq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gcGoonIy; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gcGoonIy"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630753cc38so7832404a12.1
        for <linux-s390@vger.kernel.org>; Mon, 06 Apr 2026 10:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775498363; x=1776103163; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8un0IEjBMxtnZYDO+jKaIXeNdgwpHrOxZMgG/O9GlLg=;
        b=gcGoonIyCBdYlan35no7zEszwO4xp4OXTLwm0TtLsrO7cFw9yONv9nhqEXYwGDxUBH
         ZTiLXyMLiFMMu3T4oCvJnviVWlWeeIcq7d9AUrKI6Ium4iv4LRo/vJ1xeMAPp/0hAQU6
         a9v+MpCpRjs38krWjTb9dnq/QNDqu3IuGzt+voE48ucAFhtknPLU93U2dxeYnnnG2OQx
         Y/iex6vnEXO+BYLDgcKmvtfpw/4lin6iUb6UOM1qXwQ6HTEr5Uf8GLT7gWuzjiwtjj3u
         5A6vMQbo4Sd2nWG6Yo0UsqF/SgcOhP5gDMLuFlIeRMGwNnrr1g2YNTjXqaMjoihSIL0L
         rosw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775498363; x=1776103163;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8un0IEjBMxtnZYDO+jKaIXeNdgwpHrOxZMgG/O9GlLg=;
        b=K8GVZ2ptjR0zdE5aW/BK4q/zNcewjba8ffxQsYvUlQDNTnhKG0EyYQsZQVuB9L+1/M
         DXrs9nCSHShttbttRH813qKZ5Z3vTQXy6pHftz1SpFXTAe5513LDLgRyO+K6hRxnBYxz
         05wCBxatUPQA9taAJdkMAPyp8jG2wFn9354tijXsfqbb8nqoRRFstQhq6Cx9xnfQkvBG
         MLcChpK52kWtmOJ9MeRj9vrmBgHV6xIsvGqn0gycRC3UU6Xlkfgyi0EMgGa2dio1Db25
         aIgW4aKXVcL/fgGM0Dzmk+BGHbh1HTIfzU7+u9eb9GPqUjoEH87dayByXsUxd1Rjq6bk
         Voaw==
X-Forwarded-Encrypted: i=1; AJvYcCXRuvZmj2nRa/8afHii7+p3fQah4lnWBGOPIfWAIWQDk7byx//AVopU0GT9F4QpyqbRDTnk8Tnv5AND@vger.kernel.org
X-Gm-Message-State: AOJu0YyuUAKAsD8xdBhc94sn7P6lHRgY2G8G1+a7wrj4BhQoAV+UrJV2
	EVsg7AIkUsNLj0OnWIyapDkaVEKqjvqdIZNIVqIGKDO77pOvGLKpMaNoYQVL5YoN92m3ta2y23j
	vTAII7A==
X-Received: from pfch7.prod.google.com ([2002:a05:6a00:1707:b0:829:7245:b797])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:958e:b0:39c:2b9d:93ae
 with SMTP id adf61e73a8af0-39f2f1ae00dmr12997024637.60.1775498362325; Mon, 06
 Apr 2026 10:59:22 -0700 (PDT)
Date: Mon, 6 Apr 2026 10:59:20 -0700
In-Reply-To: <0b9c451f-0167-4f1b-a38e-6413cf089c18@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260406064419.14384-1-freimuth@linux.ibm.com>
 <20260406064419.14384-4-freimuth@linux.ibm.com> <0b9c451f-0167-4f1b-a38e-6413cf089c18@linux.ibm.com>
Message-ID: <adP0eA7dBlS4B6gl@google.com>
Subject: Re: [PATCH v3 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic
 fast inject
From: Sean Christopherson <seanjc@google.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com, 
	imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Apr 06, 2026, Matthew Rosato wrote:
> On 4/6/26 2:44 AM, Douglas Freimuth wrote:
> > S390 needs a fast path for irq injection, and along those lines we 
> > introduce kvm_arch_set_irq_inatomic. Instead of placing all interrupts on
> > the global work queue as it does today, this patch provides a fast path for
> > irq injection.
> > 
> > The inatomic fast path cannot lose control since it is running with
> > interrupts disabled. This meant making the following changes that exist on 
> > the slow path today. First, the adapter_indicators page needs to be mapped
> > since it is accessed with interrupts disabled, so we added map/unmap
> > functions. Second, access to shared resources between the fast and slow 
> > paths needed to be changed from mutex and semaphores to spin_lock's.
> > Finally, the memory allocation on the slow path utilizes GFP_KERNEL_ACCOUNT
> > but we had to implement the fast path with GFP_ATOMIC allocation. Each of
> > these enhancements were required to prevent blocking on the fast inject
> > path.
> > 
> > Fencing of Fast Inject in Secure Execution environments is enabled in the
> > patch series by not mapping adapter indicator pages. In Secure Execution
> > environments the path of execution available before this patch is followed.
> > 
> > Statistical counters have been added to enable analysis of irq injection on
> > the fast path and slow path including io_390_inatomic, io_flic_inject_airq,
> > io_set_adapter_int and io_390_inatomic_adapter_masked.
> > 
> > Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
> 
> 
> Sashiko complains about PREEMPT_RT kernels and spinlocks being sleepable
> in this case which would break the whole point of kvm_arch_set_irq_inatomic.

Just make it a raw spinlock so that it stays an actual spinlock.

> I suspect actually the kvm_arch_set_irq_inatomic() call itself shouldn't
> be used in this case, or in other words it wouldn't be an issue with
> just this s390 implementation but rather all of arch implementations?
> 
> I did not try enabling it and running a test, but I did do some
> searching of the codebase and I can found at least 1 spinlock acquired
> somewhere along the inatomic path for the existing implementations...
> 
> longarch (pch_pic_set_irq)

I doubt anyone runs PREEMPT_RT VMs on LoongArch at this point.

> arm64 (vgic_its_inject_cached_translation)

Uses raw.

> powerpc (icp_deliver_irq)

Presumably arch_spin_lock() is also a "raw" version?  PPC KVM is barely maintained
at this point, so I wouldn't worry much about it.

> riscv (kvm_riscv_aia_aplic_inject)

Uses "raw".

> For x86 I didn't find a spinlock -- maybe I didn't look hard enough! --
> but I did find a path that uses RCU (kvm_irq_delivery_to_apic_fast)
> which AFAIU would also become preemptible under PREEMPT_RT.

This isn't about becoming preemptible per se, it's about non-raw spinlocks
becoming sleepable locks.  RCU can be made preemptible, but rcu_read_lock()
doesn't become sleepable.

> So for this series it seems reasonable to me to proceed as-is, with an
> open question whether there should be a KVM-wide avoidance of
> kvm_arch_set_irq_inatomic() under PREEMPT_RT?

s390 should use a raw spinlock, same as arm64 and RISC-V.
