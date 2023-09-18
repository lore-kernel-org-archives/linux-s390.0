Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2424ACD13D2
	for <linux-s390@archiver.kernel.org>; Mon, 18 Sep 2023 15:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjIRPVm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbjIRPVk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Sep 2023 11:21:40 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313B51737
        for <linux-s390@vger.kernel.org>; Mon, 18 Sep 2023 08:18:07 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-76ef27a8e4dso301541985a.1
        for <linux-s390@vger.kernel.org>; Mon, 18 Sep 2023 08:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695050286; x=1695655086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=skILK3+RqLs29/E8NIb2upQKKLhMeBuYLpBX+o8j0o8=;
        b=epA4f9kEjYmtgyDTAraRytjVHXA60gPqpXFLNZUI5T6CmfNozGMDgtHTsswK3xeFwN
         1OaIl3PXjp3zhr9NqAE6nOG7HQ8FSaxPaWwdzzepp4y2otKnJRYR0ljNSEWGJUC57f69
         8+EzWR5gOljFD37THkSHlK62BilBydq+YTXLvCRJyRuRyVS6jLambIhSM9cnk6bUzXaU
         DD/8zo7gvasZZOWGlx7j8A/q91DMAH0eXiDRJeOxTgckOdb9dXBPpC/a/9XPINqgguT6
         8A3KbK4V1xG0nVPOIs5OeUSwfxXBg7P621lqHwQ+yM5jTU2N3hkAE+juEg3hcIBfJV7w
         ARbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050286; x=1695655086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skILK3+RqLs29/E8NIb2upQKKLhMeBuYLpBX+o8j0o8=;
        b=NkSvd8FftAB1vkOMMhG3IthueCGPfTsOGyupgE2VZjFnqHvhzWtXdrTKw+nFNXrCR/
         XvhL7C//jlep0WvUglSRqaOZW40QJhsJNcESmm29jCP0/KxAX3KsE3PcqSKFWDO3XLJu
         CWjSfQHV/Kn69XAtGlGkeex98O76B4V2FfIdZ/Q4d97nem4RJ9LzP9ST0lCiLFupM2li
         n/29BW3fHXT1UA+SgFU3YuGb3zHIeW87dvCbqSTofaZpKb1Ha/TFQ8XTcgpWv4enHnMI
         LYH/Hog2XqFDgc2IoU4uwXyrs+PyperVzZLfwb3keaTgN0JgwxzSBbVmPtB+cUeZC1ay
         buyg==
X-Gm-Message-State: AOJu0Yx4c6Kxd2l+LZQRz2cAbOUuuFKhCZ2HNyj8AH5/7BTuaGajd72e
        4jdY9fYgwpDB6mXgojNZuVJ5iw==
X-Google-Smtp-Source: AGHT+IEPjZK20Aqh4DOH80nyWTVB2XY8RoIapnvcyiksM3wp5qxi6JV9wSTNi2A0D4DmrBL930vlSw==
X-Received: by 2002:ad4:458d:0:b0:63f:9aa3:867b with SMTP id x13-20020ad4458d000000b0063f9aa3867bmr9395365qvu.40.1695050286275;
        Mon, 18 Sep 2023 08:18:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id r28-20020a0cb29c000000b0063d038df3f3sm3532215qve.52.2023.09.18.08.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:18:05 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qiG0i-0005OR-Iy;
        Mon, 18 Sep 2023 12:18:04 -0300
Date:   Mon, 18 Sep 2023 12:18:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        Huacai Chen <chenhuacai@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Anup Patel <anup@brainfault.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Anish Ghulati <aghulati@google.com>,
        Venkatesh Srinivas <venkateshs@chromium.org>,
        Andrew Thornton <andrewth@google.com>
Subject: Re: [PATCH 03/26] virt: Declare and define vfio_file_set_kvm() iff
 CONFIG_KVM is enabled
Message-ID: <20230918151804.GH13795@ziepe.ca>
References: <20230916003118.2540661-1-seanjc@google.com>
 <20230916003118.2540661-4-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916003118.2540661-4-seanjc@google.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Sep 15, 2023 at 05:30:55PM -0700, Sean Christopherson wrote:
> Hide vfio_file_set_kvm() and its unique helpers if KVM is not enabled,
> nothing else in the kernel (or out of the kernel) should be using a
> KVM specific helper.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  drivers/vfio/vfio_main.c | 2 +-
>  include/linux/vfio.h     | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Patch subject should be vfio not virt

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> @@ -1388,6 +1387,7 @@ void vfio_file_set_kvm(struct file *file, struct kvm *kvm)
>  		vfio_device_file_set_kvm(file, kvm);
>  }
>  EXPORT_SYMBOL_GPL(vfio_file_set_kvm);
> +#endif

We could even put this in a symbol namespace..

Jason
