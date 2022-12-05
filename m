Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749AEC47089
	for <linux-s390@archiver.kernel.org>; Mon,  5 Dec 2022 21:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbiLEVMq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 5 Dec 2022 16:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbiLEVMp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 5 Dec 2022 16:12:45 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270B8DEA5
        for <linux-s390@vger.kernel.org>; Mon,  5 Dec 2022 13:12:44 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id h28so12619047pfq.9
        for <linux-s390@vger.kernel.org>; Mon, 05 Dec 2022 13:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9BS9+Fk77r2sqEaU7XwhOF5T7uvKSgLeTZbiEXUGcMo=;
        b=Ujio/I//LxFB/K3sVL9gmNsGJ2wTNbSjKjPUCByX11FEgdEzOgOqiXg/gRqfeGF7s+
         BRBVYIHZsjiCW+mopZZqJtOFx8R72OQ+lxd1rMhvvBVaCHky62qMT42W7ann/KH4QVEi
         7RDo5VhBRC8pzm08UnWL1v8bR/cRgCAMAHzAeJOZ77ZAJGj5jTiVT2fPdcmD7+sDDe5A
         MCK85CoektbMIOfXCT03EXGqxDh77jznAXbuGFlYRgsEHGnbyTN0uldNNg+81eLCMpdy
         485zxEh+YV7agkZEO9zh/Zlc6/uD1mmvMxm2NZPEwpELq6RwwxuABQO2pRIN5lh3pL9X
         0pWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9BS9+Fk77r2sqEaU7XwhOF5T7uvKSgLeTZbiEXUGcMo=;
        b=QPtCBgOq7F9JEMDbrbBAr/8V0cJZttwyon9K02SyyvPU5iS2kBEzG41G+RnvVpnNNG
         hMkEPLa0ePujxg/nkp5sRPIfMc00u0vEALlhy/WzDbFIFGAcNZ1c4QW7rFLrtB+fbXMr
         bLi4O9JUe9GJilAsobOKZ02V0sjYd0+wR9tDA2Jf3kdXMDJTImFVO2VCq8Ot+77esLgJ
         mEqn9GAhx3T9P6k0pHmT5gninf2BzJg2n5xIXpgOby0u+LWu2CZslPMmrhzZYy4biJ47
         em+whiUVX8At8hFevS8EqUwOKL9nZOc2Y6JuBiRbGNQm5b1Bb9k+KEq4U3onvMzjmbMx
         oBrA==
X-Gm-Message-State: ANoB5pniY3ZJtGYOYSKuWnCyW3MtnuDPLesYXqg+Nkfk46XsgqYI3+FO
        oV6XhWdwTr9ZWfOiXS/PQoF5zQ==
X-Google-Smtp-Source: AA0mqf7NtaiQFi9maqoCvGoM6sFH0HgJLUnKLXrzCG7pSHOZoyGtCDF0ZU4oxE1QMNHHmHHaqhNDEw==
X-Received: by 2002:aa7:91d6:0:b0:574:c543:f804 with SMTP id z22-20020aa791d6000000b00574c543f804mr49454104pfa.51.1670274763510;
        Mon, 05 Dec 2022 13:12:43 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id nn6-20020a17090b38c600b00219f8eb271fsm131413pjb.5.2022.12.05.13.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 13:12:43 -0800 (PST)
Date:   Mon, 5 Dec 2022 21:12:39 +0000
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
        David Woodhouse <dwmw2@infradead.org>,
        Paul Durrant <paul@xen.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Atish Patra <atishp@atishpatra.org>,
        David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuan Yao <yuan.yao@intel.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Fabiano Rosas <farosas@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kai Huang <kai.huang@intel.com>, Chao Gao <chao.gao@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 31/50] KVM: x86: Do CPU compatibility checks in x86
 code
Message-ID: <Y45ex/CyTY7jYa5D@google.com>
References: <20221130230934.1014142-1-seanjc@google.com>
 <20221130230934.1014142-32-seanjc@google.com>
 <20221205205246.GA3630770@ls.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205205246.GA3630770@ls.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Dec 05, 2022, Isaku Yamahata wrote:
> On Wed, Nov 30, 2022 at 11:09:15PM +0000,
> > index 66f16458aa97..3571bc968cf8 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -9277,10 +9277,36 @@ static inline void kvm_ops_update(struct kvm_x86_init_ops *ops)
> >  	kvm_pmu_ops_update(ops->pmu_ops);
> >  }
> >  
> > +struct kvm_cpu_compat_check {
> > +	struct kvm_x86_init_ops *ops;
> > +	int *ret;
> 
> minor nitpick: just int ret. I don't see the necessity of the pointer.
> Anyway overall it looks good to me.

...

> > @@ -9360,6 +9386,14 @@ static int __kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
> >  	if (r != 0)
> >  		goto out_mmu_exit;
> >  
> > +	c.ret = &r;
> > +	c.ops = ops;
> > +	for_each_online_cpu(cpu) {
> > +		smp_call_function_single(cpu, kvm_x86_check_cpu_compat, &c, 1);
> > +		if (r < 0)
> 
> Here it can be "c.ret < 0".

No, because the below goto leads to "return r", i.e. "c.ret" needs to be propagated
to "r".  That's why the code does the admittedly funky "int *ret" thing.

FWIW, this gets cleanup in the end.  "struct kvm_cpu_compat_check" goes away and
"&r" is passed directly to kvm_x86_check_cpu_compat.

> > +			goto out_hardware_unsetup;
