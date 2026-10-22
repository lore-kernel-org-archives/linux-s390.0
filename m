Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792693101;
	b=o+hLEQ6hxhJ/T+QNQilqClZ7PoEWshr/u+BP3HTbmR7C6fc5byXivPWZRoem+zx95EaU
	 mElH7rNKT5BBPjcy33BSMBwotLUZIBaPzHKLr1bAr7Aj34Jr5SVZszhstzxnTAM2kAg/P
	 KGxCU1i/picKg5cdSlH4dThIJHBQ4lCEmytCaJrcryhFHh9Eyaa8b+Nnmq3IuAsh9gxn9
	 iiXYN1YSuv5u5p4LcYBUejHXKLS2G7VJB2cetIP/A1X6hlWOHjikWdwHQoh3RDqKWO+S1
	 Qmj6M7PAG7PUTaAq4faQaSBftU9xbpUFyw8WraIjK0CVNk+NIRLhfp9f/l2DtZdosPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792693101;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=gA1AUubl9m6fHOyzeOfDMgK8SFqgm8VvX00DyQ47ihk=;
	b=S5tic2kyQVGXc8fR0QnJedGCeIyetMSD+RgLIKc8l3B8gNsNixOje/O4nZGvgDuCU5R4
	 90QQggmawWesbcjnjKehllqFTLO4mxNNEHQVcTesgB+0UcX34AYpbkcipoD5cjD7loxjg
	 WaA+oSopZ23KOrIB8NNKdxJRcZGkv8wHJsOftgCLxTnZDyhFLIHITBt/qExme+aiufPb/
	 7rp0OIwhOzdAh56mEwq1rFQTXL1nH0bk7fkuXzpA8MKw8yRPbDz+Rg5lrRb7MieOa+Pfv
	 SGN93xPk3C2kXUN/ue9SLrRxyJKB+MvzXzbMvXx53cbfq6mON+m9VK3QEX8PyUVqiCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TA60Awwl;
	arc=none smtp.remote-ip=209.85.215.197
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF96606A31A
	for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 18:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAF96606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=TA60Awwl
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cd67e98f68fso106525a12.3
        for <linux-s390@vger.kernel.org>; Thu, 22 Oct 2026 11:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792693100; x=1793297900; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gA1AUubl9m6fHOyzeOfDMgK8SFqgm8VvX00DyQ47ihk=;
        b=TA60Awwlh9FiPRH3OLzggHhy88D6w+X/wbdhaTppSyY69zDzorfhPPBS35LxloPTQV
         /12zlS/wCHoSGl37M2mR5wEIqBcxtfw9wcwpCWKabB4Fq4J5v8n8BqeVX9Ok0dIAlS9R
         /SAzW9g6fLeTRlykHA3hJ+LwgX3ZGCD9cW9or8hRP9HZn8pYKqHx9sUyG6Dbq3arZkMp
         IjoEH0ja4TORFk7PkRb2GFKF7MlKp37jNXcu/WwC/oCu7rOPrdFxFDK9t58ESAx6Yqgj
         2RIrx8jEma6AygFKsD3gfusGWvAZ3085W74F+Y3kz3+5yJ1n32gQFA6BLxMG8UUqfBYv
         tiiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792693100; x=1793297900;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gA1AUubl9m6fHOyzeOfDMgK8SFqgm8VvX00DyQ47ihk=;
        b=O2pQZt8mT348o3/pvCurwCAFWTTjzaUq744e0eSeMm+kdS6fGc4FZlC3HaKLz7oJ5I
         tsf38I37ZmhMA0QKux8zc8r5/uCQb/hPHeqqvzH2Hkz132ygElfkTne8J3WPNQl3Frhd
         odhd54y/HjgmZvQGT9CJymXtcvitpOqI5bFc+c9nU/EfLAL8qHeuMLTipuXSU9QKbNGE
         r7vLqNZjWAVyDsJ5PQKXSTKke8nkMh5c+dRyt/xUcyPHJV0p9QyKieukhBb2DNYEPbOQ
         F2RUOuM0RB64Afi4m5JP9H+Oj7loob2krSsnEt4VntJReFQ+CnmnQBcNXBbmx6EeVbSP
         9JZw==
X-Forwarded-Encrypted: i=1; AKwUvBx/lAlmOAWQqHDA1CyHInghYZk+50ZdeB26ki5yWTlVWypGBi6BQRrtfObKN80SksbQRpXBUybEY68q@vger.kernel.org
X-Gm-Message-State: AFq9FYJPu+fXWQ3Zva80kr/r0C7+P4MI7CcJqq22WV84my3mC8yB90X2
	M+m1EEmePAVUWoZ+xgJJ77NKi4rMcz5rrK2M9bH9ePzRQ6VmavDvIeBUS1KWLv85IZyt7gdCLpz
	jGEKb4A==
X-Received: from pgjs24.prod.google.com ([2002:a63:f058:0:b0:cc9:f7f0:57ef])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:cf85:b0:3e1:1db7:7608
 with SMTP id adf61e73a8af0-3e287eae778mr4848932637.54.1792693099812; Thu, 22
 Oct 2026 11:18:19 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:18:19 -0700
In-Reply-To: <20261020175818.375700-3-borntraeger@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261020175818.375700-1-borntraeger@linux.ibm.com> <20261020175818.375700-3-borntraeger@linux.ibm.com>
Message-ID: <atpTa2FMU19UGitv@google.com>
Subject: Re: [PATCH v2 2/2] KVM: selftests: Test that KVM_RUN fails for
 unresolvable host faults
From: Sean Christopherson <seanjc@google.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, 
	linux-s390 <linux-s390@vger.kernel.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 20, 2026, Christian Borntraeger wrote:
> Add a test in which the guest writes to a shmem-backed memslot beyond
> the end of the file.  KVM_RUN must fail with -EFAULT.
> 
> On x86 the guest enables interrupts, and on s390 the test sets up
> pfault, so that KVM could handle the fault with an asynchronous page
> fault.  If KVM mistakes the error for a fault that needs I/O, the vCPU
> retries the access forever, and the test fails after a timeout.
> 
> The test is not built for LoongArch, which handles a failed mapping as
> an MMIO access.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>  tools/testing/selftests/kvm/Makefile.kvm      |   1 +
>  .../selftests/kvm/faultin_sigbus_test.c       | 169 ++++++++++++++++++

The "sigbus" part of this is confusing, because there is never actually a sigbus.
Kinda silly, but maybe faultin_efault_test?

> +static void arch_enable_async_pf(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
> +{

...

> +}
> +#else
> +/* x86 needs guest interrupts on, see guest_code(); nothing to do elsewhere. */
> +static void arch_enable_async_pf(struct kvm_vm *vm, struct kvm_vcpu *vcpu)

Nit, maybe arch_enable_host_async_pf()?  Because x86 has PV async #PFs, where
instead of scheduling a worker task in the host, KVM (conditionally) reflects
the #PF into the guest so that the guest can schedule in a different task.  A
lot of people, myself included, see "async #PF" and think of the PV version first,
e.g. I initially was looking for the PV side of things here.


> +#endif
> +
> +static void guest_code(u64 gva, u64 size)
> +{
> +#ifdef __x86_64__
> +	/* KVM does async #PF, or its halt fallback, only with IRQs enabled. */
> +	sti_nop();
> +#endif
> +	/* Within EOF: must work, proves that the mapping is set up right. */
> +	WRITE_ONCE(*(u64 *)gva, 1);
> +	GUEST_SYNC(0);
> +
> +	/* Beyond EOF: KVM_RUN must fail with -EFAULT. */
> +	WRITE_ONCE(*(u64 *)(gva + size - sizeof(u64)), 1);
> +	GUEST_FAIL("Store beyond EOF succeeded");
> +}
> +
> +static void sig_alarm(int sig)
> +{
> +}

...

> +	TEST_ASSERT(!sigaction(SIGALRM, &sa, NULL), "sigaction() failed");
> +	alarm(TIMEOUT_SECS);
> +	r = __vcpu_run(vcpu);
> +	alarm(0);
> +
> +	TEST_ASSERT(!(r == -1 && errno == EINTR),
> +		    "KVM_RUN did not return within %d seconds: the fault on the SIGBUS page is retried forever",
> +		    TIMEOUT_SECS);

Rather than assert on EINTR, what if we have sig_alarm() explicitly TEST_FAIL()?
That way readers don't have to piece together that the EINTR is coming from the
alarm, and there's less chance of the test somehow getting a false pass because
KVM manages to morph the signal into EFAULT.  That would also allow using the
single-underscore _vcpu_run(), though I don't know if that's actually a good idea.

E.g.

diff --git a/tools/testing/selftests/kvm/faultin_sigbus_test.c b/tools/testing/selftests/kvm/faultin_sigbus_test.c
index 9394b04efcd6..9d90c32f3c6a 100644
--- a/tools/testing/selftests/kvm/faultin_sigbus_test.c
+++ b/tools/testing/selftests/kvm/faultin_sigbus_test.c
@@ -106,6 +106,7 @@ static void guest_code(u64 gva, u64 size)
 
 static void sig_alarm(int sig)
 {
+	TEST_FAIL("%d second timeout expired before KVM_RUN hit -EFAULT", TIMEOUT_SECS);
 }
 
 int main(void)
@@ -154,12 +155,9 @@ int main(void)
 
 	TEST_ASSERT(!sigaction(SIGALRM, &sa, NULL), "sigaction() failed");
 	alarm(TIMEOUT_SECS);
-	r = __vcpu_run(vcpu);
+	r = _vcpu_run(vcpu);
 	alarm(0);
 
-	TEST_ASSERT(!(r == -1 && errno == EINTR),
-		    "KVM_RUN did not return within %d seconds: the fault on the SIGBUS page is retried forever",
-		    TIMEOUT_SECS);
 	TEST_ASSERT(r == -1 && errno == EFAULT,
 		    "Expected KVM_RUN to fail with EFAULT, got r = %d, errno = %d (%s), exit reason %s",
 		    r, errno, strerror(errno), exit_reason_str(vcpu->run->exit_reason));
