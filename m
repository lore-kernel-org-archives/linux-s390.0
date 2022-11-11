Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568E8C4332F
	for <linux-s390@archiver.kernel.org>; Fri, 11 Nov 2022 00:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbiKKAGP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 10 Nov 2022 19:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiKKAGO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Nov 2022 19:06:14 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C3E5E9FA
        for <linux-s390@vger.kernel.org>; Thu, 10 Nov 2022 16:06:13 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id m6so3528325pfb.0
        for <linux-s390@vger.kernel.org>; Thu, 10 Nov 2022 16:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sXQg6m0KDTXTm2nqz+lTg6WMBvdzJA0Ss4aaQqsqfi0=;
        b=hNVPv+ey8HIvOZmC+WAnWIG8OYAeSlZS0xPLzYhDCZmnArotz5Y/nhfn9r9c8PCEFe
         E8mVjVIva+def9PHp762BmRXmUoK5jg3heR3NAusrpN5STPSFfkervClje0NQa5CwXrE
         HdlsTtSUM+MPo4+vdGUA38aqr644tAa7P5bI3VxUrx5hCBiuVMLzUakeu0v8EjWAOK7v
         BgVrNZDyAWChq0qRi87Yhdn0EcEzkTu6Ae/6zTz8SPVNgwEGA83vKScQ/P1+h2fj3QJH
         Ic9NMyWV4IhkYFZTb5wG6PyKY3kSFDqOOs7F1TgAuJpwI7fBOge9ep4GrU+eZD7ML8Bk
         8lbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sXQg6m0KDTXTm2nqz+lTg6WMBvdzJA0Ss4aaQqsqfi0=;
        b=lA9ol/LzdXMokiX5WBsdmos9k7gHoN3OOFZLuIp1QeJLA0rfz+JRxx1grs+3FhBzJL
         T6Pkyz6oJ1yPSYTeWwP0iUUZmQL6vWPqWfqkPcGOHMJwbqf9wvKlhTks/i5UG2syQghD
         Z/dDfzyNcsQ1paeFCCKIOaN9JgoO+vNNNQLsgIXT1TcMRI5ZqeFltAe37g/+xzDtQLLK
         KIy6xeQbQTn7ZhxCmMybhZrA2tQaOS2EQAyn2wxXvEib4tRaL2rv910poAArzjG3TJ5C
         XF8hmTRGDeOZkIZFUrYttJYpMaudOlnv7jUxThS+r/1LyW74/th1MLbGkMPvF9JdJBKK
         I9yA==
X-Gm-Message-State: ACrzQf1j724Mnns4a6wa4M31VxLY1om52tlLz3Z6Bk96p+kIfRWUqMlZ
        FMiAzMrqdHlaEVrqUNx/5YVLSw==
X-Google-Smtp-Source: AMsMyM4gD1W2r9wxYtObzCBR9GM6UAk6Hoer15K7R44TK7byNmqvji7Uiit5OvUTQRObzAPBYqhIPw==
X-Received: by 2002:a05:6a00:bef:b0:56e:3a98:1089 with SMTP id x47-20020a056a000bef00b0056e3a981089mr3906306pfu.38.1668125172489;
        Thu, 10 Nov 2022 16:06:12 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s18-20020a170903215200b00186a6b6350esm234146ple.268.2022.11.10.16.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 16:06:12 -0800 (PST)
Date:   Fri, 11 Nov 2022 00:06:08 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Isaku Yamahata <isaku.yamahata@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yuan Yao <yuan.yao@intel.com>
Subject: Re: [PATCH 36/44] KVM: x86: Do compatibility checks when onlining CPU
Message-ID: <Y22R8GAvcuoWBELA@google.com>
References: <20221102231911.3107438-1-seanjc@google.com>
 <20221102231911.3107438-37-seanjc@google.com>
 <20221103210402.GB1063309@ls.amr.corp.intel.com>
 <Y2RB4qT02EkhMjPL@google.com>
 <20221104071819.GD1063309@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104071819.GD1063309@ls.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Nov 04, 2022, Isaku Yamahata wrote:
> On Thu, Nov 03, 2022 at 10:34:10PM +0000,
> Sean Christopherson <seanjc@google.com> wrote:
> 
> > On Thu, Nov 03, 2022, Isaku Yamahata wrote:
> > > On Wed, Nov 02, 2022 at 11:19:03PM +0000,
> > > Sean Christopherson <seanjc@google.com> wrote:
> > > > diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> > > > index f223c845ed6e..c99222b71fcc 100644
> > > > --- a/arch/x86/include/asm/kvm_host.h
> > > > +++ b/arch/x86/include/asm/kvm_host.h
> > > > @@ -1666,7 +1666,7 @@ struct kvm_x86_nested_ops {
> > > >  };
> > > >  
> > > >  struct kvm_x86_init_ops {
> > > > -	int (*check_processor_compatibility)(void);
> > > > +	int (*check_processor_compatibility)(int cpu);
> > > 
> > > Is this cpu argument used only for error message to include cpu number
> > > with avoiding repeating raw_smp_processor_id() in pr_err()?
> > 
> > Yep.
> > 
> > > The actual check is done on the current executing cpu.
> > > 
> > > If cpu != raw_smp_processor_id(), cpu is wrong. Although the function is called
> > > in non-preemptive context, it's a bit confusing. So voting to remove it and
> > > to use.
> > 
> > What if I rename the param is this_cpu?  I 100% agree the argument is confusing
> > as-is, but forcing all the helpers to manually grab the cpu is quite annoying.
> 
> Makes sense. Let's settle it with this_cpu.

Finally got to actually change the code, and am not a fan of passing "this_cpu"
everywhere.  It's not terrible, but it's not clearly better than just grabbing
the CPU on-demand.  And while manually grabbing the CPU in the helpers is annoying,
in at least two cases the pain is just shifted to the caller.

I'm going with your original suggestion of just grabbing raw_smp_processor_id()
in the helpers that print the error message.
