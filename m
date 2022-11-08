Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AC7C4332F
	for <linux-s390@archiver.kernel.org>; Tue,  8 Nov 2022 17:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiKHRqj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 8 Nov 2022 12:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbiKHRqh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 8 Nov 2022 12:46:37 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E06256553
        for <linux-s390@vger.kernel.org>; Tue,  8 Nov 2022 09:46:37 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id c2so14805142plz.11
        for <linux-s390@vger.kernel.org>; Tue, 08 Nov 2022 09:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cjSjC5m99kmUUHYC704oOlI8KJi6LTudhKVnFW3q+Mo=;
        b=ftWxPl3+8IfelsK/irLrvblaLrX6dvTk43ZU1RGb7E7QhEuhpuFGQnZUs1B/6eqA8Y
         9uQybJjBJrLcnswih9ZuqdP/IGzw5N1LHsBYZwMjKm4pxbrW1ieLuxCyIbeQvnPHGIX9
         KlKI+02Y2PtkvzGrkUCj7EVO4k0DJZDFtOtuUtFMvCioPX+FiFS160StdFwaRhG4AwZY
         /X/0r60JYMQEe4UtsauftLe+islfrGWTT7n2RWyEhP6x94J5Vb4QTPr7DjEYHP04yepW
         KF97tjKStfZxjB8uLonmnyGRloE774fNFuZ/STi6vuLRLYYB1EDXjhtfDOqD4TBoTzbU
         ZVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjSjC5m99kmUUHYC704oOlI8KJi6LTudhKVnFW3q+Mo=;
        b=AzW2D1Dik9DYQlxBPQfNojk2C/N+m7hPZ93nA1jxl+8aJpwur8lE3mtbL8iYxGU634
         469OIJP8GXeDy7+npRRYj1XByjSIRD70jpNAzAhccv1IqINWZ4FoWpCaX0eyecam0++2
         SYfB9evLWM6Ldwlok+0nmWtILUe3S5vmxJZmKpclOVHbIAYdsi9ALJk20LWKNqg/oGQf
         Qwzi/unOJDY2oQxMpVi+mqtCNhLuz4JsNc30Mvk49FXE+PB3qGadZPgrrSmkbRX3EkGx
         2ze6w+Bx03ZQy63TKiMjVLw+zf6162ZCElkvy96dLPEf67n4/pnFedH2NO45eSZ/01ds
         IC+A==
X-Gm-Message-State: ACrzQf31jkwuFNgRtHQJ9OLaXJ54euwkdbOwcHyPGWGGOePUOOKPi3Sj
        4h7QlV1yTXJSpNV4KLX8KAHccg==
X-Google-Smtp-Source: AMsMyM6IejjlUU0y+myBNmX6xdBJY00CqsdAF2QTJKOsZh5WixYj1ODA6TQRcmab3f8JPfGm8K7ciQ==
X-Received: by 2002:a17:902:ea04:b0:187:4923:56f4 with SMTP id s4-20020a170902ea0400b00187492356f4mr35142106plg.97.1667929596484;
        Tue, 08 Nov 2022 09:46:36 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902d50900b00185402cfedesm7283578plg.246.2022.11.08.09.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 09:46:35 -0800 (PST)
Date:   Tue, 8 Nov 2022 17:46:32 +0000
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
Subject: Re: [PATCH 00/44] KVM: Rework kvm_init() and hardware enabling
Message-ID: <Y2qV+IGKyKQItMj2@google.com>
References: <20221102231911.3107438-1-seanjc@google.com>
 <20221104071749.GC1063309@ls.amr.corp.intel.com>
 <Y2V1oslbw24/2Opd@google.com>
 <20221107214634.GE1063309@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107214634.GE1063309@ls.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Nov 07, 2022, Isaku Yamahata wrote:
> On Fri, Nov 04, 2022 at 08:27:14PM +0000,
> Sean Christopherson <seanjc@google.com> wrote:
> 
> > On Fri, Nov 04, 2022, Isaku Yamahata wrote:
> > > Thanks for the patch series. I the rebased TDX KVM patch series and it worked.
> > > Since cpu offline needs to be rejected in some cases(To keep at least one cpu
> > > on a package), arch hook for cpu offline is needed.
> > 
> > I hate to bring this up because I doubt there's a real use case for SUSPEND with
> > TDX, but the CPU offline path isn't just for true offlining of CPUs.  When the
> > system enters SUSPEND, only the initiating CPU goes through kvm_suspend()+kvm_resume(),
> > all responding CPUs go through CPU offline+online.  I.e. disallowing all CPUs from
> > going "offline" will prevent suspending the system.
> 
> The current TDX KVM implementation disallows CPU package from offline only when
> TDs are running.  If no TD is running, CPU offline is allowed.  So before
> SUSPEND, TDs need to be killed via systemd or something.  After killing TDs, the
> system can enter into SUSPEND state.

Ah, I assumed offlining was disallowed if TDX was enabled.

> > I don't see anything in the TDX series or the specs that suggests suspend+resume
> > is disallowed when TDX is enabled, so blocking that seems just as wrong as
> > preventing software from soft-offlining CPUs.
> 
> When it comes to SUSPEND, it means suspend-to-idle, ACPI S1, S3, or S4.
> suspend-to-idle doesn't require CPU offline.
> 
> Although CPU related spec doesn't mention about S3, the ACPI spec says
> 
>   7.4.2.2 System _S1 State (Sleeping with Processor Context Maintained)
>   The processor-complex context is maintained.
> 
>   7.4.2.4 System _S3 State or 7.4.2.5 System _S4 State
>   The processor-complex context is not maintained.
> 
> It's safe to say the processor context related to TDX is complex, I think.
> Let me summarize the situation. What do you think?
> 
> - While no TD running:
>   No additional limitation on CPU offline.
> 
> - On TD creation:
>   If any of whole cpu package is software offlined, TD creation fails.
>   Alternative: forcibly online necessary CPUs, create TD, and offline CPUs

The alternative isn't really viable because there's no way the kernel can guarantee
a CPU can be onlined, i.e. the kernel would need to fallback of disallowing TD
creation anyways.

> - TD running:
>   Although it's not required to keep all CPU packages online, keep CPU package
>   from offlining for TD destruction.
> 
> - TD destruction:
>   If any of whole cpu package is software offlined, TD destruction fails.
>   The current implementation prevents any cpu package from offlinining during
>   TD running.
>   Alternative:
>   - forcibly online necessary CPUs, destruct TD, and offline CPUs again and
>     allow CPU package to offline
>   - Stash TDX resources somewhere. When cpu packages are onlined, free those
>     release.
> 
> - On SUSPEND:
>   TODO: Allow CPU offline if S1 is requested.

Is this actually a TODO?  I assume the kernel doesn't actually try to offline
CPUs in this case, i.e. it Just Works.

>   - suspend-to-idle: nothing to do because cpu offline isn't required
>   - ACPI S1: Need to allow offline CPUs.  This can be implemented by referencing
>     suspend_state_t pm_suspend_target_state is PM_SUSPEND_TO_STANBY.
>   - ACPI S3/S4: refuse cpu offline.  The system needs to kill all TDs before
>     starting SUSPEND process. This is what is implemented.

Looks good, disallowing SUSPEND with active TDs is a reasonable tradeoff.  As
above, I highly doubt anyone actually cares.
