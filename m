Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0066EC4332F
	for <linux-s390@archiver.kernel.org>; Wed,  9 Feb 2022 19:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiBITwr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Feb 2022 14:52:47 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiBITwq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Feb 2022 14:52:46 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4FFE0536EF
        for <linux-s390@vger.kernel.org>; Wed,  9 Feb 2022 11:52:48 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id r19so6120922pfh.6
        for <linux-s390@vger.kernel.org>; Wed, 09 Feb 2022 11:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nFEbKA8UOj2F0aYmafhYdx9MoDnLhZL6FzGdA3foG6Y=;
        b=kMS+/VC4xCdhdLklBPMZrl1DDgsPdemkNlQ+9xJdsF7MXhYOau3XWTVe4FOrwEqNCE
         AtJl33LpEFo6tfuoyyjy0zXo24YUgl2rkRpZDMF8C8XU1aeb1hng1SUX4zjzRKukMAQ9
         27hgmz8ku+LmTHBmD6JLUcxGm2ViDLqKuaJNEonZsgpd0HlXbksTP9GkQqwkK3nofxzk
         9N3WOhuOj7Zmr/5Cp7EeaMz/pprsSKTROefT+5wZO27PB8CVnklUVAkPBIVMBiLCrHCw
         jl9lkCtgzT6We8ITi8RRxUdBU2p3bPtKzg04MIXkdCVNZOh+d/Fln2r4rSPfvBbdqxfm
         cNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nFEbKA8UOj2F0aYmafhYdx9MoDnLhZL6FzGdA3foG6Y=;
        b=pK7KNilXdjYdI2gpZSMez3lXZJGlx8gsQlnlqyiWo57akTt1E7L4ulBnwpb7TqpQEp
         htxXj1l19wQ8E1JCTrwBcdSqz/H2Z98yVgXDIn7IBj5MEWp/5SD1DtBG51hqfrun2VJ9
         HblCPXEeZm+H0pXnlMzzwsqEX7zWrM91wjfs5mDkaTESLB/qRycDIU+8lDjkk/0UWHco
         LkftcDmv3eIfhGQkfm0aGnuuQSZ0NXfSvohUpCzvoo36psuunU5izma9HReXM/VxF0gO
         TBZOJ5zcDgjEdjQJrRFyuY7STiEj3Kdshf4vGU6XkylwIYyV3xZZTNq2ffe0i+yF11Ur
         Fifw==
X-Gm-Message-State: AOAM533vUxPDa+jb5lepFXCwh/h0D9I+ia6mLwWu6w/bDsG3S130blbe
        QtCOw2WqKx7NdZhHK/7n+tzC6Q==
X-Google-Smtp-Source: ABdhPJxEijFR2ADtO2dJpv7+eOnsj3GAeQVvJQZsu/Pn1kY2yGlTgcOn0LgYSwuqCOLhd8P+Pi4JPg==
X-Received: by 2002:a05:6a00:23d0:: with SMTP id g16mr3889078pfc.19.1644436367723;
        Wed, 09 Feb 2022 11:52:47 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id pi9sm7744343pjb.46.2022.02.09.11.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 11:52:47 -0800 (PST)
Date:   Wed, 9 Feb 2022 19:52:43 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, kevin.tian@intel.com,
        tglx@linutronix.de, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 2/5] Partially revert "KVM: Pass kvm_init()'s opaque
 param to additional arch funcs"
Message-ID: <YgQbi1VcxA5OTo77@google.com>
References: <20220209074109.453116-1-chao.gao@intel.com>
 <20220209074109.453116-3-chao.gao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209074109.453116-3-chao.gao@intel.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Feb 09, 2022, Chao Gao wrote:
> This partially reverts commit b99040853738 ("KVM: Pass kvm_init()'s opaque
> param to additional arch funcs") remove opaque from
> kvm_arch_check_processor_compat because no one uses this opaque now.
> Address conflicts for ARM (due to file movement) and manually handle RISC-V
> which comes after the commit.
> 
> And changes about kvm_arch_hardware_setup() in original commit are still
> needed so they are not reverted.
> 
> Signed-off-by: Chao Gao <chao.gao@intel.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
