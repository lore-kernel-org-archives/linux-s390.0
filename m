Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46EE280025
	for <linux-s390@vger.kernel.org>; Tue, 23 Sep 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648996; cv=none; b=Zsg7GUlNdZp4t1eK5D8zKqWJzAb386lOPtwgnOIpjfdGOqdStYmPEdrWujs4YdKNnx8azm/4CZ3k/V0g7b6ZOnCj69erlAfQq7+egq9WtYWdUBcNGW8Y0dPqmiPnf6UNAqKEgQHlLeLk7W7X6N4rsoqp4v/LP+sxhgVNtQz3x3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648996; c=relaxed/simple;
	bh=XHPLJJt/KbJ1D5F44GPRNGElgwDacszgHxKIzWlExhk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=W/tJ/wFatN9rnu9u1vFss1b1terchkCPoooPG/YekFR9X+Smp2lpf/Y+1vRO7h8y2YakqwSdGRFhyAiNnBbaQFKoppSFlhUCdxIjM2C+WGY3iVNMW+dEWCYU65w+rLJybDWrQs4Vb7S6Fn08bmk5yOxgMP6dl/eudYUQ1Dzsfh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4FZmDUr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e4FZmDUr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758648993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbwQJRq9OtjRzQDsrzY0ULWi7+7TtERNjKCPji+rNuQ=;
	b=e4FZmDUrBTKtKGUA2oejG0cK6jaQ17EA2H6OKKZ2pFaglEaEYACoOgVXT70OR/UEQ8ii2z
	EVw6qZjXURcvrmmV3bS9rZ8/Kxn2isX9uvhQUsMvJZkMwYKt+WVXR8/EzKa5q76mNGLdtb
	wJcckGh/mHIg20WcxD6sV+jevuT1OQk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-FmayRRJ9OYifmP-bLoZ9Zw-1; Tue,
 23 Sep 2025 13:36:28 -0400
X-MC-Unique: FmayRRJ9OYifmP-bLoZ9Zw-1
X-Mimecast-MFC-AGG-ID: FmayRRJ9OYifmP-bLoZ9Zw_1758648987
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7EFDC1955F56;
	Tue, 23 Sep 2025 17:36:26 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.155])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1BD4B1800446;
	Tue, 23 Sep 2025 17:36:22 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20250919203208.GA8350@quark>
References: <20250919203208.GA8350@quark> <20250919190413.GA2249@quark> <3936580.1758299519@warthog.procyon.org.uk> <3975735.1758311280@warthog.procyon.org.uk>
To: Eric Biggers <ebiggers@kernel.org>
Cc: dhowells@redhat.com, "Jason A. Donenfeld" <Jason@zx2c4.com>,
    Ard Biesheuvel <ardb@kernel.org>,
    Harald Freudenberger <freude@linux.ibm.com>,
    Holger Dengler <dengler@linux.ibm.com>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    Stephan Mueller <smueller@chronox.de>, Simo Sorce <simo@redhat.com>,
    linux-crypto@vger.kernel.org, linux-s390@vger.kernel.org,
    keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib/crypto: Add SHA3-224, SHA3-256, SHA3-384, SHA-512, SHAKE128, SHAKE256
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <538562.1758648981.1@warthog.procyon.org.uk>
Date: Tue, 23 Sep 2025 18:36:21 +0100
Message-ID: <538563.1758648981@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Eric Biggers <ebiggers@kernel.org> wrote:

> > > and that the functions can be called in any context.
> > 
> > "Context" as in?
> 
> See the "Function context" section of
> Documentation/doc-guide/kernel-doc.rst

Btw, in include/crypto/sha1.h:

/**
 * hmac_sha1_update() - Update an HMAC-SHA1 context with message data
 * @ctx: the HMAC context to update; must have been initialized
 * @data: the message data
 * @data_len: the data length in bytes
 *
 * This can be called any number of times.
 *
 * Context: Any context.
 */
static inline void hmac_sha1_update(struct hmac_sha1_ctx *ctx,
				    const u8 *data, size_t data_len)
{
	sha1_update(&ctx->sha_ctx, data, data_len);
}

for example, your specification of "Context: Any context." is probably not
correct if FPU/Vector registers are used by optimised assembly as part of the
function.  See:

void kernel_fpu_begin_mask(unsigned int kfpu_mask)
{
	if (!irqs_disabled())
		fpregs_lock();

	WARN_ON_FPU(!irq_fpu_usable());

	/* Toggle kernel_fpu_allowed to false: */
	WARN_ON_FPU(!this_cpu_read(kernel_fpu_allowed));
	this_cpu_write(kernel_fpu_allowed, false);

	if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER)) &&
	    !test_thread_flag(TIF_NEED_FPU_LOAD)) {
		set_thread_flag(TIF_NEED_FPU_LOAD);
		save_fpregs_to_fpstate(x86_task_fpu(current));
	}
	__cpu_invalidate_fpregs_state();

	/* Put sane initial values into the control registers. */
	if (likely(kfpu_mask & KFPU_MXCSR) && boot_cpu_has(X86_FEATURE_XMM))
		ldmxcsr(MXCSR_DEFAULT);

	if (unlikely(kfpu_mask & KFPU_387) && boot_cpu_has(X86_FEATURE_FPU))
		asm volatile ("fninit");
}

If you try and access the function in IRQ mode, for example, you'll get a
warning, and if IRQs are not disabled, it will disable BH/preemption.

You also can't use it from inside something else that uses FPU registers.

I suggest something like:

 * Context: Arch-dependent: May use the FPU/Vector unit registers.

David.

