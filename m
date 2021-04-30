Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD91C433B4
	for <linux-s390@archiver.kernel.org>; Fri, 30 Apr 2021 15:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2F76146D
	for <linux-s390@archiver.kernel.org>; Fri, 30 Apr 2021 15:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhD3PgD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 30 Apr 2021 11:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhD3PgB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 30 Apr 2021 11:36:01 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03B4C06174A
        for <linux-s390@vger.kernel.org>; Fri, 30 Apr 2021 08:35:11 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id p12so4369535ljg.1
        for <linux-s390@vger.kernel.org>; Fri, 30 Apr 2021 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zw/V8/6W4skoSH0mSs8cW3qf3BAXRpq8TIlzvcUbh9Y=;
        b=KB8gW36y7USDPOimeqhXInwA40Pnt1d90bk9cbUzrAJc2frJTwsE8DUmYpsixNTY5D
         0VEStw8wvZ8I0IlKf2CJfoljSzTfYWIayX3SvyxM1bomk9H/siwFiNjIEIKFbzohtdgO
         w6vFYnxfHEF3wCnVt6V3YoSITDNsGsa10Pis/sjL+FQpIE58o9XbL+C2P81CYaPhq8Qt
         qj8CGwVy7J+1cUwf/CXA01U/5rkNLcbVSAinzGvr1lHAjjXEfQK4i5hKVhhHHO2QhunW
         aiKrl9b+u8yIOotQlVcCRKukY18jn7e3TOfbROxw1rCaup7aO+V4Nvp132xeshzjhRwg
         DFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zw/V8/6W4skoSH0mSs8cW3qf3BAXRpq8TIlzvcUbh9Y=;
        b=T+rWBcxEZF1462rmyxAVZa34VptHNKcwWn6JFwjR+tsh6rde7HTQNj1SqMgj7d7/c8
         Hn8z6x/ZzWVdwq2TkKucOhanIZac+VwyVtvRCCuhcJUn3takErPdqq6GGv889fanDsGC
         ixrZw0kTHE6cqjjuJi2zthC2vEM7AFGwTCN2nJDKMS7KxM92Sk4trlzj9QG2CIW8EM5P
         doPhHTkhwgxOrPGlc+RV/t9f+PVSt6TCsRX7a+6+9oJ1wwOtcPibmiqTuUwOikd+NIQl
         IeCvdffvFBAUUMtGbaOmRaskYTwAMIhg/bCD8nq+vSI24fTidRdqrZ96OKqRzT8L5aV/
         ttCw==
X-Gm-Message-State: AOAM531CUS/WgMwf1E/WJ3jDgiI7lU0+1Fnw1qLzn5KzfrBR0b+XZ36m
        XaRYpLN4k9jk3aBZLAQINAO5+C9PGpgbKMgVgM2Rzg==
X-Google-Smtp-Source: ABdhPJx/QRgwRdWJdR4aTn2uakfmtAz6C7OxdhfGIo2oiu582wd/0wprc5qi+RX6OipU6nb2KN0bPjeYB4Dj/CDoOuM=
X-Received: by 2002:a2e:9a0a:: with SMTP id o10mr4294282lji.216.1619796910218;
 Fri, 30 Apr 2021 08:35:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210429203740.1935629-1-jingzhangos@google.com>
 <20210429203740.1935629-2-jingzhangos@google.com> <87bl9wnfgo.wl-maz@kernel.org>
In-Reply-To: <87bl9wnfgo.wl-maz@kernel.org>
From:   Jing Zhang <jingzhangos@google.com>
Date:   Fri, 30 Apr 2021 10:34:58 -0500
Message-ID: <CAAdAUtiMV_cVXPKBBEymNub8qYq-whLdihKG0si4_ALxK=yv6g@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] KVM: stats: Separate common stats from
 architecture specific ones
To:     Marc Zyngier <maz@kernel.org>
Cc:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Marc,

On Fri, Apr 30, 2021 at 7:07 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 29 Apr 2021 21:37:37 +0100,
> Jing Zhang <jingzhangos@google.com> wrote:
>
> > +struct kvm_vm_stat_common {
> > +     ulong remote_tlb_flush;
> > +};
> > +
> > +struct kvm_vcpu_stat_common {
> > +     u64 halt_successful_poll;
> > +     u64 halt_attempted_poll;
> > +     u64 halt_poll_invalid;
> > +     u64 halt_wakeup;
> > +     u64 halt_poll_success_ns;
> > +     u64 halt_poll_fail_ns;
> > +};
>
> Why can't we make everything a u64? Is there anything that really
> needs to be a ulong? On most architectures, they are the same anyway,
> so we might as well bite the bullet.
That's a question I have asked myself many times. It is a little bit annoying
to handle different types for VM and VCPU stats.
This divergence was from the  commit 8a7e75d47b681933, which says
"However vm statistics
 could potentially be updated by multiple vcpus from that vm at a time.
 To avoid the overhead of atomics make all vm statistics ulong such that
 they are 64-bit on 64-bit systems where they can be atomically incremented
 and are 32-bit on 32-bit systems which may not be able to atomically
 increment 64-bit numbers."

I would be very happy if there is a lock-free way to use u64 for VM stats.
Please let me know if anyone has any idea about this.
>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.

Thanks,
Jing
