Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E422C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 18 Nov 2021 18:51:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B27061AFD
	for <linux-s390@archiver.kernel.org>; Thu, 18 Nov 2021 18:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhKRSyB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 18 Nov 2021 13:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbhKRSyA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 18 Nov 2021 13:54:00 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FDDC06173E
        for <linux-s390@vger.kernel.org>; Thu, 18 Nov 2021 10:51:00 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id r23so6187621pgu.13
        for <linux-s390@vger.kernel.org>; Thu, 18 Nov 2021 10:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=zAr8G8m6HwrPqqoGdIArvc5MN7TTOd03aeCBtzrDy6c=;
        b=rbZpSNPBshLLEgA/oYmPUPBbBkHwOg37klgFkMWXqRk+AzrmyZ/M8ccKC2y8hmj5XX
         PLpPwnUPPnPUTd02kdHoVA+HzFD/83CjjC3Xbl8iUzGpDaC5IgVnhNZp/tysG3KqErGy
         5NHK+nazoYp2JBbWoBCcZ90G56QCBVHGDC2bRvtFDuQptjhoIwkzkNewqtOfKXf5uclO
         DhLKIN93hjB32b8vl6mql00pPTkF1CnjBXdgyjfBHRSJU7IHYoN8ZQlZWFAH1r/9oUd0
         jnvQBNIOdWFfAc3UrHP8NU5X0ygb/qQXibVUtpmNCElsCb3HlLNAGjLYo0jNbS4Fc47o
         oIdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=zAr8G8m6HwrPqqoGdIArvc5MN7TTOd03aeCBtzrDy6c=;
        b=mWFVy30eP8ZX+A1AJYnCSdb/RGcPO763Tc7bKMHk0FCetf9xzEGoxVlgoj25BhzDS5
         Jt6EnJS1VAH/obmWDCqwElxe6ZKAKQ51gjNo0SHYqX+8sUIxSs/MmsNWWlk9Z0NyNlnX
         3lPozT0WK5sF80fQCxSZ0m5PE+bCtq0KCiyiahRnIechlnXU71FLXOM+rRn1247tZTu5
         W5gd9t8MqG+7noatwnaSAw8kJPgpkiaCu42rmKFCv1OrCZ9GCShjMSK6F0AkNuzzvYBt
         bhFuK6rfaqgx4RGd5XFNHzAyJ/4nH4craCJSdYpt8zR/Fx0jNN97mvdCZVToLIE3Srgz
         FU5A==
X-Gm-Message-State: AOAM531xUIYZ3K8wFxoAjAKoMLAIv3Ch5OxEc6+13CMM7TJ/Dt1fwqsA
        /JWC0SZqcF7iokXAu9I1KNUWew==
X-Google-Smtp-Source: ABdhPJwrEgdsIYmbNbF+vA4sWC6GNXtBMPWh0SewfV4Te7mVM91SE0D0KPe2RQ2SZU3Fb1o23V6Nkg==
X-Received: by 2002:a05:6a00:b49:b0:49f:bad2:bd7c with SMTP id p9-20020a056a000b4900b0049fbad2bd7cmr58136547pfo.64.1637261459650;
        Thu, 18 Nov 2021 10:50:59 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id y18sm306696pgh.18.2021.11.18.10.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 10:50:59 -0800 (PST)
Date:   Thu, 18 Nov 2021 18:50:55 +0000
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
Message-ID: <YZagjzYUsixbFre9@google.com>
References: <20211117174003.297096-1-dwmw2@infradead.org>
 <20211117174003.297096-9-dwmw2@infradead.org>
 <85d9fec17f32c3eb9e100e56b91af050.squirrel@twosheds.infradead.org>
 <4c48546b-eb4a-dff7-cc38-5df54f73f5d4@redhat.com>
 <20b5952e76c54a3a5dfe5a898e3b835404ac6fb1.camel@infradead.org>
 <YZaeL5YztL3p1nLM@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZaeL5YztL3p1nLM@google.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Nov 18, 2021, Sean Christopherson wrote:
> On Thu, Nov 18, 2021, David Woodhouse wrote:
> > That leaves the one in TDP MMU handle_changed_spte_dirty_log() which
> > AFAICT can trigger the same crash seen by butt3rflyh4ck — can't that
> > happen from a thread where kvm_get_running_vcpu() is NULL too? For that
> > one I'm not sure.
> 
> I think could be trigger in the TDP MMU via kvm_mmu_notifier_release()
> -> kvm_mmu_zap_all(), e.g. if the userspace VMM exits while dirty logging is
> enabled.  That should be easy to (dis)prove via a selftest.

Scratch that, the dirty log update is guarded by the new_spte being present, so
zapping of any kind won't trigger it.

Currently, I believe the only path that would create a present SPTE without an
active vCPU is mmu_notifer.change_pte, but that squeaks by because its required
to be wrapped with invalidate_range_{start,end}(MMU_NOTIFY_CLEAR), and KVM zaps
in that situation.

Ben's series to promote pages on disabling of dirty logging will also sqeuak by
because dirty logging is obviously disabled.
