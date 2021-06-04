Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA89C07E94
	for <linux-s390@archiver.kernel.org>; Fri,  4 Jun 2021 09:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A326610A2
	for <linux-s390@archiver.kernel.org>; Fri,  4 Jun 2021 09:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbhFDJYz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 4 Jun 2021 05:24:55 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:40702 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhFDJYz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Jun 2021 05:24:55 -0400
Received: by mail-pg1-f171.google.com with SMTP id j12so7372286pgh.7
        for <linux-s390@vger.kernel.org>; Fri, 04 Jun 2021 02:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pcVIrrrWEUuSA+N6NdZCH+jzIyXyj1HQeo01ZwpdXxY=;
        b=T6vUk/4jMaY1sFB+ktO56Tu+hSYK1wiZBd79Qpkt7cR3wdk6RgqpEA+MqmoApExn4u
         Ki+XTdzY1lKdvlx+de9gaG+wdCW5+FLPTTH3w22d8er65zizi+PUDGgUHvaCEEPTouoT
         LUIBuV5Az0wlga/c+czm/LVkend9CKDw/kZwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pcVIrrrWEUuSA+N6NdZCH+jzIyXyj1HQeo01ZwpdXxY=;
        b=j6OQETGOPb8KtONlJVJKgEjGXSNf1fyi5h/6pGXz1vriAisFUvuZ5PTbLtxo476cuO
         1kvD3CXjAQgBNKeb7cgsjyFTGH6BUseyJ60FZ0B1TcOKEbM9LED0AkFEpO6oz6djoIdD
         PpX1H1yOb3fH7+xZdkMTm4yxmIa3qOnVGnB0Zk+4nG00TRF7CkRaD2kXfSCGxsqQHmu6
         s6Hk3dQ7LlNA1CPijzFFulYx+gv1hWbd355FEQDi360/ibF9qBUpyzjX6eLrRCb7a55K
         L0sTv/j3BNdsGhZMD8jZSbnNUB/NlHUEYW6RMAl0xs5ExVj3EHRXFWdRnuMIyORul1IM
         AWPA==
X-Gm-Message-State: AOAM531XWOwXJgUQtlWCETxn8ghEgePwTjDxRM6KCWglFcCxOD2zI3ik
        u4SNjakHl3ATTRyDR3AQ7cL30g==
X-Google-Smtp-Source: ABdhPJyN+y7mCRzpjZlapAyCgZr6LbpUALEaLKem6t6vFwqQAQV8qZmVYl6DOYQnER784of3HxKE+Q==
X-Received: by 2002:aa7:82cb:0:b029:2e6:f397:d248 with SMTP id f11-20020aa782cb0000b02902e6f397d248mr3647517pfn.52.1622798529641;
        Fri, 04 Jun 2021 02:22:09 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:36b:f5b6:c380:9ccf])
        by smtp.gmail.com with ESMTPSA id d15sm4208168pjr.47.2021.06.04.02.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 02:22:09 -0700 (PDT)
Date:   Fri, 4 Jun 2021 18:22:02 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Suleiman Souhlal <suleiman@google.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [RFC][PATCH] kvm: add suspend pm-notifier
Message-ID: <YLnwum6AtcURNlRL@google.com>
References: <20210603164315.682994-1-senozhatsky@chromium.org>
 <87a6o614dn.fsf@vitty.brq.redhat.com>
 <e4b4e872-4b22-82b7-57fc-65a7d10482c0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4b4e872-4b22-82b7-57fc-65a7d10482c0@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On (21/06/04 09:24), Paolo Bonzini wrote:
> On 04/06/21 09:21, Vitaly Kuznetsov wrote:
> > >   	preempt_notifier_inc();
> > > +	kvm_init_pm_notifier(kvm);
> > You've probably thought it through and I didn't but wouldn't it be
> > easier to have one global pm_notifier call for KVM which would go
> > through the list of VMs instead of registering/deregistering a
> > pm_notifier call for every created/destroyed VM?
> 
> That raises questions on the locking, i.e. if we can we take the kvm_lock
> safely from the notifier.

Right, I wanted to take the VM lock, rather than subsystem lock
(kvm_lock).
