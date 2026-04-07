Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311ED337110
	for <linux-s390@vger.kernel.org>; Tue,  7 Apr 2026 17:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584374; cv=none; b=USq16Fys0+H6H3tnbynuy9A9DlgLc2FwMTP0BoeIENHYZlaYSKVoosYUae9R6zb764z59KsQZwBAnOLJwFOczshl9Z92MmXKiqW6hyaTbfQXwh7Zt6abveB5fAp8+b2Jo2DMhaifkZ7H1RlhZal1DfP+m7t+MMXWtOQqiB5VlUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584374; c=relaxed/simple;
	bh=SFi+MQ6VGcPjgdgikIOtIRVkkflB5tN7WyaTIpXX2RU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S39YTZJ6eMzqVJnEPr5ZPR4adkWGOohx57cRmU6yNX7wNb18Paxb8cLC29RP066fiZOzCqOhlWIsUFIyziPbvgfgwpf8nYvxDXTcyV02++HANGeoqWvvbFHaWacwlsqAuS2xD1PweKngLcOOyzrEKF3WAZUk+ERJuFzaTI/UD6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YZa4BrMa; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZa4BrMa"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3594620fe97so12613548a91.1
        for <linux-s390@vger.kernel.org>; Tue, 07 Apr 2026 10:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775584373; x=1776189173; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=X/MSOJp/AJlf7hUTMD/NXnVkTNNfR/Z7vvW8KkUYbLI=;
        b=YZa4BrMaWQ7Sv4KfQ30+pGBZjqlCkMfEFBrZ/PC7w2+d7G0DNM2i6ZrYWiTEd79Wnh
         8wDC9o/JYW5YAFwenwZBH0/MU+lOJiP0GNL1BGZfuQdpYOXGjqMK3NflGuZWDWmdTAJj
         J0hdkUNMBI8iIVBJ8/q5igUlj8aaK6hCp4i1VW8n7tNUNMB8nXqZmx+2UsTrM1fnlP6c
         AvZSR8H13Eb9W64hHgZlR3p5iRqpt2EqxjwC7kXHSJzHcdxVcEUQbC82wkrcQTkq6fYJ
         cjlqceLNQnXCO/hlNO0mqDbRhAmaa3NddkM8lRkwhVxcqqhxVpJfSGfPUHJkHeUbQe9/
         ELSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775584373; x=1776189173;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X/MSOJp/AJlf7hUTMD/NXnVkTNNfR/Z7vvW8KkUYbLI=;
        b=OcFso6s/N6KcGwxWeaRrm3ePS5x0vnz6J7Jklps006KOl4MR8fg+VwgPPsU0LVKHJt
         Z3Nf7DkYgzb4zyLCCl9Bt4lCr6ajDdrotoyvg5AT5SKn1/r3RZR+8NawwFQkxvmK9rPT
         QJN0CLcXC2iHFd8zKvznnLYZUCo1Y9jMwm57OevhMqpcaMCj3AjkdXPFb0RJCPXz6LbG
         Rh/tSjTM7trzSCi8HNRfEvnLFPNgUkxbh/gD/OXIOp8rMLK0BTp+uYIVH57zgKs2zE4V
         272pbmHS/BGJu8qLB/Ft/O/lkd6zqrPs9CFWgP55mUUYym2Df3t5zOMdUB/Ow7xJ+8no
         sYcg==
X-Forwarded-Encrypted: i=1; AJvYcCXFWQSQF47oaV3vHgGo6C1eIg7+wtmp4/M/6fXw0m7CpLrzE58z4OI+F7sxk1ptWKQ3pRuLQK33l7na@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6eZNxGJWVhk80HPxyfm7FzYHknqkv7E2Ni2wDbK/i1Lbi3dR1
	cIcPw0H/9O9UlGcx6dHpb5iNKEh2Ds+KF66G3oFfrHcbKFUhbSnw3VoPcaEBgdFsAqg7lqo8EWV
	1b9o0Pg==
X-Received: from pjps16.prod.google.com ([2002:a17:90a:a110:b0:35d:94b3:bd6b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2885:b0:35d:974d:8f7
 with SMTP id 98e67ed59e1d1-35de679c8ecmr16179304a91.1.1775584372473; Tue, 07
 Apr 2026 10:52:52 -0700 (PDT)
Date: Tue, 7 Apr 2026 10:52:51 -0700
In-Reply-To: <2a216ee2-aebb-42ba-b2aa-826488448bbe@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1773890510.git.baolin.wang@linux.alibaba.com>
 <545847c132da5d957cfc74ab19e849b16127aa8f.1773890510.git.baolin.wang@linux.alibaba.com>
 <67c670e2-c98f-490b-bbb9-2960f8175b5a@lucifer.local> <66e78b59-f96c-4277-b7d7-473b68ed413f@linux.alibaba.com>
 <adBJTXeE6G2vQNKX@google.com> <2a216ee2-aebb-42ba-b2aa-826488448bbe@linux.alibaba.com>
Message-ID: <adVEc4zUVVxRiEJG@google.com>
Subject: Re: [PATCH 6/6] mm: change to return bool for the MMU notifier's
 young flag check
From: Sean Christopherson <seanjc@google.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, akpm@linux-foundation.org, david@kernel.org, 
	Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, linux-arm-kernel@lists.infradead.org, 
	x86@kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, open <linux-mm@kvack.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 07, 2026, Baolin Wang wrote:
> On 4/4/26 7:12 AM, Sean Christopherson wrote:
> > On Fri, Mar 20, 2026, Baolin Wang wrote:
> > > > > -static __always_inline int kvm_age_hva_range(struct mmu_notifier *mn,
> > > > > -						unsigned long start,
> > > > > -						unsigned long end,
> > > > > -						gfn_handler_t handler,
> > > > > -						bool flush_on_ret)
> > > > > +static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
> > > > > +					      unsigned long start,
> > > > > +					      unsigned long end,
> > > > > +					      gfn_handler_t handler,
> > > > > +					      bool flush_on_ret)
> > > > 
> > > > Can we please fix this terrrible indentation while we're here :)?
> > > > 
> > > > static __always_inline bool kvm_age_hva_range(struct mmu_notifier *mn,
> > > > 		unsigned long start, unsigned long end, gfn_handler_t handler,
> > > > 		bool flush_on_ret)
> > > > 
> > > > Would be nicer, thanks!
> > 
> > No, please keep this as-is.  KVM's preferred style is exactly this (and I personally
> > find mm's style much harder to parse).
> 
> Um, Andrew has already queued v2[1] into the mm-stable branch. Do you want
> me to send a follow-up patch to restore the original KVM coding style?

Nah, not worth the churn.  Thanks though!
