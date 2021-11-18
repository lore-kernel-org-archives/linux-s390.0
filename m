Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536DDC433FE
	for <linux-s390@archiver.kernel.org>; Thu, 18 Nov 2021 19:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38899619BB
	for <linux-s390@archiver.kernel.org>; Thu, 18 Nov 2021 19:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhKRTuC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 18 Nov 2021 14:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhKRTuC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 18 Nov 2021 14:50:02 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5ABC061748
        for <linux-s390@vger.kernel.org>; Thu, 18 Nov 2021 11:47:01 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id y8so6197472plg.1
        for <linux-s390@vger.kernel.org>; Thu, 18 Nov 2021 11:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=etzXRtUGTr8lCEC3N+zBz9sC9KLaK/1vTaoNub+XSrA=;
        b=TJltHTqmUDTIgL1P24a20gD79MoRsYyT+oWNI7Zk1KCB0kxMW9nay123E+ZoFctpYI
         aiNnMLJVER0OaOWjGQFAAodEb7XssAPkbTv3HZ/7Xvc56U/KwoqRQGvrj5PKP0bcKR4k
         2vvhP28esD9If7TAFeNjBviDlcYadmbYqHQK4EKbmvqKoyyDe2mAxq3N83OoFp8cHZvs
         tW/44+HbAaU7BnQeov5HYKclsNsjLoArhh5d8PMaS08emGsC4hW0iBqIihQVo007XCgE
         f+/05PLBrEHbV7h1EwSp8E42irdKiOdyzv/mpEc9ne+Zn3+nJLJHbZQwUjsMNM99uGwK
         D+nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=etzXRtUGTr8lCEC3N+zBz9sC9KLaK/1vTaoNub+XSrA=;
        b=u0uORVp62xqq+NaeTtG0LpBK7TdGLHyvVHp7C6qQeson1KiUlxei/uKoVfF6JVaB3y
         DqC/HXrlrMCAvmW1rOIyc3dl6u5j4QzjZMjBWDReZb531g7xmGin9vSuDI3ynyO1DaEv
         w/1dT+GsXrvXu0vWskJsIeHn43agx1lfpz/Bu8DJzTdcXF8XSzbet+kMvEtfXn/W776U
         2b/ehdWTuY41OkT0NSbFJSZvzAI/FGcEyKLEZ6EoRAT36YEoacRH8v2/HHaQcWHBwcJJ
         9Bv9OkrhuIUhxz3dG9iWDflbZO22B/AeLOaR7Yep0U6GgCmYTHdgkmnXkmup8I4OqhGZ
         vFOg==
X-Gm-Message-State: AOAM533O+32v7lxrzMbPLuQVB9RhWZ6xNVFPVKxZTBkaaSiY63omyJU3
        EYW4LUPDgbOQgZufwiuHFcCKAQ==
X-Google-Smtp-Source: ABdhPJw2jmwgTmZEgqtXJQ8BT+0frIfcOwv6QQsFYGUkgZtQBdhdiIC61pVtTpnGW9Ux3cY+6emP4Q==
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr13604040pjb.238.1637264821320;
        Thu, 18 Nov 2021 11:47:01 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id t40sm435895pfg.107.2021.11.18.11.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 11:46:59 -0800 (PST)
Date:   Thu, 18 Nov 2021 19:46:56 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm <kvm@vger.kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        "jmattson @ google . com" <jmattson@google.com>,
        "wanpengli @ tencent . com" <wanpengli@tencent.com>,
        "vkuznets @ redhat . com" <vkuznets@redhat.com>,
        "mtosatti @ redhat . com" <mtosatti@redhat.com>,
        "joro @ 8bytes . org" <joro@8bytes.org>, karahmed@amazon.com,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Anup Patel <anup.patel@wdc.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 08/12] KVM: Propagate vcpu explicitly to
 mark_page_dirty_in_slot()
Message-ID: <YZatsB3oadj6dgb8@google.com>
References: <20211117174003.297096-1-dwmw2@infradead.org>
 <20211117174003.297096-9-dwmw2@infradead.org>
 <85d9fec17f32c3eb9e100e56b91af050.squirrel@twosheds.infradead.org>
 <4c48546b-eb4a-dff7-cc38-5df54f73f5d4@redhat.com>
 <20b5952e76c54a3a5dfe5a898e3b835404ac6fb1.camel@infradead.org>
 <YZaeL5YztL3p1nLM@google.com>
 <YZagjzYUsixbFre9@google.com>
 <35AEC3FD-B46A-451D-B7D5-4B1BDD5407BD@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35AEC3FD-B46A-451D-B7D5-4B1BDD5407BD@infradead.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Nov 18, 2021, David Woodhouse wrote:
> 
> 
> On 18 November 2021 18:50:55 GMT, Sean Christopherson <seanjc@google.com> wrote:
> >On Thu, Nov 18, 2021, Sean Christopherson wrote:
> >> On Thu, Nov 18, 2021, David Woodhouse wrote:
> >> > That leaves the one in TDP MMU handle_changed_spte_dirty_log() which
> >> > AFAICT can trigger the same crash seen by butt3rflyh4ck — can't that
> >> > happen from a thread where kvm_get_running_vcpu() is NULL too? For that
> >> > one I'm not sure.
> >> 
> >> I think could be trigger in the TDP MMU via kvm_mmu_notifier_release()
> >> -> kvm_mmu_zap_all(), e.g. if the userspace VMM exits while dirty logging is
> >> enabled.  That should be easy to (dis)prove via a selftest.
> >
> >Scratch that, the dirty log update is guarded by the new_spte being present, so
> >zapping of any kind won't trigger it.
> >
> >Currently, I believe the only path that would create a present SPTE without an
> >active vCPU is mmu_notifer.change_pte, but that squeaks by because its required
> >to be wrapped with invalidate_range_{start,end}(MMU_NOTIFY_CLEAR), and KVM zaps
> >in that situation.
> 
> Is it sufficient to have *an* active vCPU?  What if a VMM has threads for
> active vCPUs but is doing mmap/munmap on a *different* thread? Does that not
> suffer the same crash?

It is sufficient for the current physical CPU to have an active vCPU, which is
generally guaranteed in the MMU code because, with a few exceptions, populating
SPTEs is done in vCPU context.

mmap() will never directly trigger SPTE creation, KVM first requires a vCPU to
fault on the new address.  munmap() is a pure zap flow, i.e. won't create a
present SPTE and trigger the writeback of the dirty bit.

That's also why I dislike using kvm_get_running_vcpu(); when it's needed, there's
a valid vCPU from the caller, but it deliberately gets dropped and indirectly
picked back up.
