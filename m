Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3553C07E94
	for <linux-s390@archiver.kernel.org>; Fri,  4 Jun 2021 09:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF14A610A2
	for <linux-s390@archiver.kernel.org>; Fri,  4 Jun 2021 09:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFDJXg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 4 Jun 2021 05:23:36 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:39435 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbhFDJXf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Jun 2021 05:23:35 -0400
Received: by mail-pl1-f173.google.com with SMTP id q16so4330928pls.6
        for <linux-s390@vger.kernel.org>; Fri, 04 Jun 2021 02:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mBAEhjZZRv7Jcy7Zua0pi2TsECX3PFBDfNxkyFGsLO0=;
        b=GFzrB6mDdP8QDUkM5E2D3SpI1YuNW543kJ1Zx1kk0NuEJ9dY60dkreacgqq7B7HMEs
         uqcy1p2HaKtSeecuRPdMc+ZpGU/OEc3CdNONynbGrv/3vMYyT7bl4zUw0YUQ9/GOQcn/
         p9MzmRmMsJwpomp+rOKp0w+JG2E9nloY+xf18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mBAEhjZZRv7Jcy7Zua0pi2TsECX3PFBDfNxkyFGsLO0=;
        b=FgqAmB/GMQfIlITYLHFJ2wEK6wIfVV1xK0B3FA12CABPmFOkOs3M3ksq93L0cL4c5g
         24h/wsHRytIN2z4dzLLqHcgHWvGU5BchCA34O7bjrqHB+AN+cP3Bi+61yeTbrdcTYhR8
         L9lvZ8+/lqxcHUITePSvMFzvVcNkCx+5wGjSMHNODPRUdc0wuUcmIeZmy4bI9AXKkoXG
         1f/6u4nCDG3SgL4apkFmDrmd4iqivbXhWglP3hf+F4P69+tmS3gN8hvOOlZV+2D5wGFo
         S7fADBFgdWTAeqdFQezz2pNTFy67mB5iSRAGF/LCGDcjIGGVLzmQIt7sgjOAvNm9VkaH
         el9w==
X-Gm-Message-State: AOAM531wiV8drv8RFyO48APl1k+WRHBLiQsrLD9+M6H4pEVZZd7vvgne
        c2igiGMDEHbG/2RgxUtnuYkZdA==
X-Google-Smtp-Source: ABdhPJxqC/sFmH8NWFwbR+x7mytZyDKEx7TFmgf8/+UGv7fZox1XEZk3IYhTIOf3hSBOmUz/xertuQ==
X-Received: by 2002:a17:90b:607:: with SMTP id gb7mr3845129pjb.5.1622798435671;
        Fri, 04 Jun 2021 02:20:35 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:36b:f5b6:c380:9ccf])
        by smtp.gmail.com with ESMTPSA id p19sm4236799pjv.21.2021.06.04.02.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 02:20:34 -0700 (PDT)
Date:   Fri, 4 Jun 2021 18:20:28 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Suleiman Souhlal <suleiman@google.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [RFC][PATCH] kvm: add suspend pm-notifier
Message-ID: <YLnwXD5pPplTrmoZ@google.com>
References: <20210603164315.682994-1-senozhatsky@chromium.org>
 <87v96uyq2v.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v96uyq2v.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On (21/06/04 09:46), Marc Zyngier wrote:
[..]
> > +void kvm_arch_pm_notifier(struct kvm *kvm)
> > +{
> > +#ifdef CONFIG_PM
> > +	int c;
> > +
> > +	mutex_lock(&kvm->lock);
> > +	for (c = 0; c < kvm->created_vcpus; c++) {
> > +		struct kvm_vcpu *vcpu = kvm->vcpus[c];
> > +		int r;
> > +
> > +		if (!vcpu)
> > +			continue;
> 
> Wouldn't kvm_for_each_vcpu() avoid this kind of checks?

Right, that's what I do in v2, which I haven't posted yet.

[..]
> > +#include <linux/notifier.h>
> > +
> >  #ifndef KVM_MAX_VCPU_ID
> >  #define KVM_MAX_VCPU_ID KVM_MAX_VCPUS
> >  #endif
> > @@ -579,6 +581,10 @@ struct kvm {
> >  	pid_t userspace_pid;
> >  	unsigned int max_halt_poll_ns;
> >  	u32 dirty_ring_size;
> > +
> > +#ifdef CONFIG_PM
> > +	struct notifier_block pm_notifier;
> > +#endif
> 
> I'd certainly like to be able to opt out from this on architectures
> that do not implement anything useful in the PM callbacks.

Well on the other hand PM-callbacks are harmless on those archs, they
won't overload the __weak function.

> Please consider making this an independent config option that individual
> archs can buy into.

Sure, I can take a look into this, but how is this better than __weak
function? (that's a real question)

[..]
> > +#ifdef CONFIG_PM
> > +static int kvm_pm_notifier_call(struct notifier_block *bl,
> > +				unsigned long state,
> > +				void *unused)
> > +{
> > +	struct kvm *kvm = container_of(bl, struct kvm, pm_notifier);
> > +
> > +	switch (state) {
> > +	case PM_HIBERNATION_PREPARE:
> > +	case PM_SUSPEND_PREPARE:
> > +		kvm_arch_pm_notifier(kvm);
> 
> How about passing the state to the notifier callback? I'd expect it to
> be useful to do something on resume too.

For different states we can have different kvm_arch functions instead.
kvm_arch_pm_notifier() can be renamed to kvm_arch_suspend_notifier(),
so that we don't need to have `switch (state)` in every arch-code. Then
for resume/post resume states we can have kvm_arch_resume_notifier()
arch functions.

> > +		break;
> > +	}
> > +	return NOTIFY_DONE;
> > +}
> > +
> > +static void kvm_init_pm_notifier(struct kvm *kvm)
> > +{
> > +	kvm->pm_notifier.notifier_call = kvm_pm_notifier_call;
> > +	kvm->pm_notifier.priority = INT_MAX;
> 
> How is this priority determined?

Nothing magical here. I want this to be executed first, before we suspend
ftrace, RCU and the like. Besides KVM is usually the last one to register
its PM callbacks, so there can be something on the notifier list that
returns NOTIFY_STOP_MASK in front of KVM PM-notifier list entry.
