Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6D8C46CA1
	for <linux-s390@archiver.kernel.org>; Mon, 18 Sep 2023 15:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjIRPSI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 18 Sep 2023 11:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjIRPSI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 18 Sep 2023 11:18:08 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4081CEB
        for <linux-s390@vger.kernel.org>; Mon, 18 Sep 2023 08:17:12 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3ab2a0391c0so3407063b6e.1
        for <linux-s390@vger.kernel.org>; Mon, 18 Sep 2023 08:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695050232; x=1695655032; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/NB9QogE7/hqQA3eAPgSewNzbsnZd2QFPin+QhCO7do=;
        b=aOVfyVy0bb8uf9bdLpWIwweOAeWnv7bNmjWYdpaJn04tHb/1KwaEXEkzPuIHlEItRF
         DjpU2/zFT/rQi9Gaxilx4o2EGtnNkICABQArs6iDjaPh1X5M/65XLGshUkktvdemY4lr
         nAA1xqGhx7mz5U7mQAppRSD/y1h3wyCdga5wsIgd1gwj45yIkD+Ng2Qj6ewIDGGSWVsi
         f3dKmmsGjm9uKZ0HtcXUujZ/UHsD4fq56P97pgQY9ASv1BwBxJYEx19UnHgvnhGNOlx7
         kjpvrqKsC1S3UEru5uOnfeqBa5puOTRHqs0d9xit2pznRrJt2BMnNbJo6DIcHsOyxGTd
         QcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050232; x=1695655032;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NB9QogE7/hqQA3eAPgSewNzbsnZd2QFPin+QhCO7do=;
        b=fz4NCSWNG622V5dETLjzAC06lxEo2t4UjFffB7sHINGHcED+3tWgWLF5HWVYLIwHfq
         eX68Jxkzkn/usvnQWsHJaZ5xm7jVi8wLYxzkeCDcI6mSt1ziaBUJIxWxUbMWOzqlUzs4
         KG2qNiCik1EU04GcJ1X4x6pytW7zCCFZnwyEUvTFeUKY3R3KS8gqpTR2MkmbRcZjAZJR
         ykQ5Vo6eDNUzT1gpC/IPHy2Ur1J2JhhiyesIlhAe5FvgSgHLW96KuL4VqP7BBnP7VuS8
         KN+DkQ+OU/TV7SITXw9RQUKuijELB28/7EQpgEOvhvsu7iXW9vUy56yo+bqBAnIKPPe6
         /A2A==
X-Gm-Message-State: AOJu0YxZCWHl5ie938+tNysSPbH6dqoAGXH7GtliJxA3N+F/jnwdGzFK
        RjUhcFfy3shhscDD7mNZ54daoA==
X-Google-Smtp-Source: AGHT+IGk3T+gnY/Ry6RzP8KMpZ6etd0YaUlt1+KGAcu6zz40/S34i/NvbRLiXeftEMRhME9haaF4Dg==
X-Received: by 2002:a05:6870:b691:b0:1d5:b442:5de7 with SMTP id cy17-20020a056870b69100b001d5b4425de7mr10054844oab.35.1695050231963;
        Mon, 18 Sep 2023 08:17:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id r13-20020a0ce28d000000b0064f50e2c551sm1477356qvl.1.2023.09.18.08.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:17:11 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qiFzq-0005O4-IS;
        Mon, 18 Sep 2023 12:17:10 -0300
Date:   Mon, 18 Sep 2023 12:17:10 -0300
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
Subject: Re: [PATCH 02/26] vfio: Move KVM get/put helpers to colocate it with
 other KVM related code
Message-ID: <20230918151710.GG13795@ziepe.ca>
References: <20230916003118.2540661-1-seanjc@google.com>
 <20230916003118.2540661-3-seanjc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916003118.2540661-3-seanjc@google.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Sep 15, 2023 at 05:30:54PM -0700, Sean Christopherson wrote:
> Move the definitions of vfio_device_get_kvm_safe() and vfio_device_put_kvm()
> down in vfio_main.c to colocate them with other KVM-specific functions,
> e.g. to allow wrapping them all with a single CONFIG_KVM check.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  drivers/vfio/vfio_main.c | 104 +++++++++++++++++++--------------------
>  1 file changed, 52 insertions(+), 52 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
