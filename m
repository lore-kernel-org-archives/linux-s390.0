Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8A53F1AA7
	for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290847; cv=none; b=M+2QotUbp89XBmnzWg3u70Y4s2etfiK8D6R60G9hmr5y0VjMM8+8b86FowKxzRT8Et+FpLROoVuRcS9Z3lL2ODz6JThe2Ze4pemZgQHAcS7FPhaN2s2HvB6gUn54x1OABUhtyxZs7g6k+rIeMLSWh0hvWskpqX9/gJc6cfDBgF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290847; c=relaxed/simple;
	bh=tweE/B5iRx4WqCmZC5jUJFMzY9zDXaqivSkzvGtJbn0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qc0F5Kl/Q+awUmY/P5UeJZdOv8YvwRifY5FG/CU2qrx6VJqB/45Satt+IjP9yMMSEn0ocJLXkkBgYfxZLewVVn1lKUbDaUlKPopExpldrUz5/t+repMDIuMmMxG/F3VQYUYqm640tAxESLYingLchMMWSuWEyujmZpYgJImZeAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gmEBa3y8; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gmEBa3y8"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-365fd467cf6so4281349a91.0
        for <linux-s390@vger.kernel.org>; Wed, 20 May 2026 08:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779290846; x=1779895646; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KhkgzLIvh7n8FBkLDCvvyoRLLy05jqAaJJsIAGt7tN0=;
        b=gmEBa3y8/jRi0+EpWviHV8clYZE0Mh1fvrsRthzQwel0+xtjbG7kZbQ9VUWT3Hkizw
         5pRPQVL0+keeK0sRMdWT4feH8s+F9sLUygdFrDebBfbOeY5fdSJ2s6eUlEiCExF68W/M
         RSB0q8/jqgrtcAr49RTi17WmBTpH8yMCT93XMdpUI+F3Ul88J5o8Z4qzTsC0YMH8LpJz
         RhpceRCra6X3htPPJZQ3qafeDge6q1y6FxT074jdyY4MWapeVR+y9n2jpSUW/gDhlZP3
         ON7fTkWm4ts8LTwB6G10+gbhvjZ7+vul5gFgSBAlMX7nnWf4Icib6RL7KnH3P9wDu1Ex
         aAxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779290846; x=1779895646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KhkgzLIvh7n8FBkLDCvvyoRLLy05jqAaJJsIAGt7tN0=;
        b=ZPUepbSblWVE38T4w21JVRk7lFl/DV7bywI8G6V4wXrSL6lWIeAUIbKVD3nqrv6awe
         tQkFjngPsZfmFwd5ZVXQq0boP6ZOgf1ASEXZlmUCBABEyDfOOQZDhzodKbXsoiHXDN/T
         9yuy0d72DkiLLVl+2y7RCZCsauMXtG1R64oNB8HsCbhkXfQUUmNJRvLM1UV8L4oJKkeT
         WWD4bmgdnyTaVIixtfU3HDc5jKV3B3SbnlnaeHKrQ3HLvj/ybqD5na8KwdJjFKss5fWd
         2ghWh1VtW7KX2yfQw3SrnG6+VoVy/usIfnZvIhzB2TMm4B9fiJfjS8yUi0fXfeIjavpI
         +MNQ==
X-Forwarded-Encrypted: i=1; AFNElJ94KGNNc65t1YGUvC6F8TCZiI04C8JTZ0NnW3JSp95UsUMAym7pFkuo4SNkDdapN52NEzOkpNJwELzN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5UteEGXGxd6DAnzz6DbUp0SGYo/6cuNlLuQQ0VXlZyHHbuaUp
	zUNSBOO7QKDvbQUpDHfEF6KVbZOuVkOmTb6EDSSdHNmcqrwC3ggTeYTqcN6Z8YPtVpMy114if8P
	9ZMakxg==
X-Received: from pgct24.prod.google.com ([2002:a05:6a02:5298:b0:c82:73de:68e2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2e04:b0:368:ed26:15b2
 with SMTP id 98e67ed59e1d1-369519fe820mr25179766a91.8.1779290845382; Wed, 20
 May 2026 08:27:25 -0700 (PDT)
Date: Wed, 20 May 2026 08:27:24 -0700
In-Reply-To: <20260520151710.231788-4-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260520151710.231788-1-imbrenda@linux.ibm.com> <20260520151710.231788-4-imbrenda@linux.ibm.com>
Message-ID: <ag3S3MjXHW4AeW_6@google.com>
Subject: Re: [PATCH v1 3/4] KVM: selftests: Fix pre_fault_memory_test to run
 on s390
From: Sean Christopherson <seanjc@google.com>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com, 
	david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com, 
	schlameuss@linux.ibm.com, gra@linux.ibm.com, pbonzini@redhat.com, 
	yan.y.zhao@intel.com, isaku.yamahata@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, May 20, 2026, Claudio Imbrenda wrote:
> Add a missing #include <ucall_common.h> which is needed and otherwise
> not included on s390.
> 
> Fence the assertion  vcpu->run->exit_reason == KVM_EXIT_IO  so that it
> is only checked on x86. On s390 the UCALL will return with a different
> code.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/pre_fault_memory_test.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/pre_fault_memory_test.c b/tools/testing/selftests/kvm/pre_fault_memory_test.c
> index fcb57fd034e6..42794892e902 100644
> --- a/tools/testing/selftests/kvm/pre_fault_memory_test.c
> +++ b/tools/testing/selftests/kvm/pre_fault_memory_test.c
> @@ -11,6 +11,7 @@
>  #include <kvm_util.h>
>  #include <processor.h>
>  #include <pthread.h>
> +#include <ucall_common.h>
>  
>  /* Arbitrarily chosen values */
>  #define TEST_SIZE		(SZ_2M + PAGE_SIZE)
> @@ -167,7 +168,6 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
>  		.type = vm_type,
>  	};
>  	struct kvm_vcpu *vcpu;
> -	struct kvm_run *run;
>  	struct kvm_vm *vm;
>  	struct ucall uc;
>  
> @@ -193,10 +193,11 @@ static void __test_pre_fault_memory(unsigned long vm_type, bool private)
>  	vcpu_args_set(vcpu, 1, gva);
>  	vcpu_run(vcpu);
>  
> -	run = vcpu->run;
> -	TEST_ASSERT(run->exit_reason == KVM_EXIT_IO,
> +#ifdef __x86_64__

I'd say just delete this assertion entirely.  It's an extra layer of paranoia to
guard against stale ucall data, but x86's ucall_arch_get_ucall() already has
sufficient guards.

> +	TEST_ASSERT(vcpu->run->exit_reason == KVM_EXIT_IO,
>  		    "Wanted KVM_EXIT_IO, got exit reason: %u (%s)",
>  		    run->exit_reason, exit_reason_str(run->exit_reason));
> +#endif
>  
>  	switch (get_ucall(vcpu, &uc)) {
>  	case UCALL_ABORT:
> -- 
> 2.54.0
> 
