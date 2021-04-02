Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B79C43460
	for <linux-s390@archiver.kernel.org>; Fri,  2 Apr 2021 17:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E9461166
	for <linux-s390@archiver.kernel.org>; Fri,  2 Apr 2021 17:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbhDBRHn (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 2 Apr 2021 13:07:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235623AbhDBRHm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 2 Apr 2021 13:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617383261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pay6FFP22GZUza5aFGS6CFJxV2F4MgiZsF6UU6/dhI8=;
        b=DDZVbimLiZ0qzr69hFCFHjo7GhHvGBG4n0Zu4WanOtDOYz2bV/iM+Yy6Qu/HXTN33J4iAu
        wPR5jfQNg7bm/rhCI/TblxM7OG4Ak3OMzbJ7gw8xmfdScIUT1Yzw2namXf/4JuZomm+GbZ
        4ulwyneJr4uNIz6VHKLp9AV3V8Cj5Jo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-CxOtzfnANGOi2pa9lR7TWA-1; Fri, 02 Apr 2021 13:07:37 -0400
X-MC-Unique: CxOtzfnANGOi2pa9lR7TWA-1
Received: by mail-ej1-f69.google.com with SMTP id di5so3335666ejc.1
        for <linux-s390@vger.kernel.org>; Fri, 02 Apr 2021 10:07:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pay6FFP22GZUza5aFGS6CFJxV2F4MgiZsF6UU6/dhI8=;
        b=a66fNpUiiQG+zXm4scRuX492cjhoHhnOmwyQsZuoB8uI9eI38vEYpp18y88rNi9loY
         XfGo8mx7MJOjkzwoxebDYKYHV5Sn0vaO/IeLsJ8Tw2c1I4joscetaDjzmuNf3PGzspA9
         bIpxMUXeI0GLuk+Xnaea+qWs732qh8yekKy0UjhzNpx4DYoSeCSKcu12h42SYG649gKv
         2LQQwwRGCc9NIl4UXaUPK0jzBsuw1GMn0WTxYaiUx+6L34FL17oZmUvFNdEy54gPF1RJ
         c+yuNBKAG4UT87J1J6K5UxbDIFaGF0HnaOrR205w3kE6B10b37ipIITzfCZ3K7wq8DiS
         Tq/A==
X-Gm-Message-State: AOAM531B1nOAZLE6Rl6itrGkNbkYvgaNEJTGNB6Dy7lodnyueS8XGeMX
        5XQgKYtVudYoQ02MMbHjoybPdSrld4GdQD0pD0E8b/h8qj1SRaIYm3qEd8anyRPKWVK72GAo8EK
        kmp16BRVVvs5999hvrhnH7g==
X-Received: by 2002:a17:906:b7d1:: with SMTP id fy17mr1377122ejb.110.1617383255837;
        Fri, 02 Apr 2021 10:07:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXsPPad+p73EMnvJYFjYKnSnzORC6vJi4cBRKTJqD3MK+cq9HDx86dIhXgIO61njm5wpECng==
X-Received: by 2002:a17:906:b7d1:: with SMTP id fy17mr1377082ejb.110.1617383255634;
        Fri, 02 Apr 2021 10:07:35 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k12sm5638463edo.50.2021.04.02.10.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 10:07:34 -0700 (PDT)
Subject: Re: [PATCH v2 6/9] KVM: x86: implement KVM_GUESTDBG_BLOCKEVENTS
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <seanjc@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Will Deacon <will@kernel.org>,
        "open list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <kvmarm@lists.cs.columbia.edu>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Jim Mattson <jmattson@google.com>,
        Cornelia Huck <cohuck@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "open list:S390" <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Kieran Bingham <kbingham@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "moderated list:KERNEL VIRTUAL MACHINE FOR ARM64 (KVM/arm64)" 
        <linux-arm-kernel@lists.infradead.org>,
        James Morse <james.morse@arm.com>
References: <20210401135451.1004564-1-mlevitsk@redhat.com>
 <20210401135451.1004564-7-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f9e1ca0c-d6cb-7477-55f2-c4861d8f8704@redhat.com>
Date:   Fri, 2 Apr 2021 19:07:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210401135451.1004564-7-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 01/04/21 15:54, Maxim Levitsky wrote:
> KVM_GUESTDBG_BLOCKEVENTS is a guest debug feature that
> will allow KVM to block all interrupts while running.
> It is mostly intended to be used together with single stepping,
> to make it more robust, and has the following benefits:
> 
> * Resuming from a breakpoint is much more reliable:
>    When resuming execution from a breakpoint, with interrupts enabled,
>    more often than not, KVM would inject an interrupt and make the CPU
>    jump immediately to the interrupt handler and eventually return to
>    the breakpoint, only to trigger it again.
> 
>    From the gdb's user point of view it looks like the CPU has never
>    executed a single instruction and in some cases that can even
>    prevent forward progress, for example, when the breakpoint
>    is placed by an automated script (e.g lx-symbols), which does
>    something in response to the breakpoint and then continues
>    the guest automatically.
>    If the script execution takes enough time for another interrupt to
>    arrive, the guest will be stuck on the same breakpoint forever.
> 
> * Normal single stepping is much more predictable, since it won't
>    land the debugger into an interrupt handler.
> 
> * Chances of RFLAGS.TF being leaked to the guest are reduced:
> 
>    KVM sets that flag behind the guest's back to single step it,
>    but if the single step lands the vCPU into an
>    interrupt/exception handler the RFLAGS.TF will be leaked to the
>    guest in the form of being pushed to the stack.
>    This doesn't completely eliminate this problem as exceptions
>    can still happen, but at least this eliminates the common
>    case.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>

The patch uses BLOCKIRQ instead of BLOCKEVENTS.

Paolo

> ---
>   Documentation/virt/kvm/api.rst  | 1 +
>   arch/x86/include/asm/kvm_host.h | 3 ++-
>   arch/x86/include/uapi/asm/kvm.h | 1 +
>   arch/x86/kvm/x86.c              | 4 ++++
>   4 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 9778b2434c03..a4f2dc84741f 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -3338,6 +3338,7 @@ flags which can include the following:
>     - KVM_GUESTDBG_INJECT_DB:     inject DB type exception [x86]
>     - KVM_GUESTDBG_INJECT_BP:     inject BP type exception [x86]
>     - KVM_GUESTDBG_EXIT_PENDING:  trigger an immediate guest exit [s390]
> +  - KVM_GUESTDBG_BLOCKIRQ:      avoid injecting interrupts/NMI/SMI [x86]
>   
>   For example KVM_GUESTDBG_USE_SW_BP indicates that software breakpoints
>   are enabled in memory so we need to ensure breakpoint exceptions are
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index cc7c82a449d5..8c529ae9dbbe 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -227,7 +227,8 @@ enum x86_intercept_stage;
>   	KVM_GUESTDBG_USE_HW_BP | \
>   	KVM_GUESTDBG_USE_SW_BP | \
>   	KVM_GUESTDBG_INJECT_BP | \
> -	KVM_GUESTDBG_INJECT_DB)
> +	KVM_GUESTDBG_INJECT_DB | \
> +	KVM_GUESTDBG_BLOCKIRQ)
>   
>   
>   #define PFERR_PRESENT_BIT 0
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 5a3022c8af82..b0f9945067f7 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -282,6 +282,7 @@ struct kvm_debug_exit_arch {
>   #define KVM_GUESTDBG_USE_HW_BP		0x00020000
>   #define KVM_GUESTDBG_INJECT_DB		0x00040000
>   #define KVM_GUESTDBG_INJECT_BP		0x00080000
> +#define KVM_GUESTDBG_BLOCKIRQ		0x00100000
>   
>   /* for KVM_SET_GUEST_DEBUG */
>   struct kvm_guest_debug_arch {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 956e8e0bd6af..3627ce8fe5bb 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8460,6 +8460,10 @@ static void inject_pending_event(struct kvm_vcpu *vcpu, bool *req_immediate_exit
>   		can_inject = false;
>   	}
>   
> +	/* Don't inject interrupts if the user asked to avoid doing so */
> +	if (vcpu->guest_debug & KVM_GUESTDBG_BLOCKIRQ)
> +		return;
> +
>   	/*
>   	 * Finally, inject interrupt events.  If an event cannot be injected
>   	 * due to architectural conditions (e.g. IF=0) a window-open exit
> 

