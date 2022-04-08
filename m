Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2149C433FE
	for <linux-s390@archiver.kernel.org>; Fri,  8 Apr 2022 12:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbiDHMrs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 8 Apr 2022 08:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235939AbiDHMrp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 Apr 2022 08:47:45 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7FDED93C
        for <linux-s390@vger.kernel.org>; Fri,  8 Apr 2022 05:45:41 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id p25so4650869qkj.10
        for <linux-s390@vger.kernel.org>; Fri, 08 Apr 2022 05:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n0Q03Y/eZmvD4gdqyNKPm3EQwhmNG2mz8mwozYTQaEw=;
        b=DXGaRsNTjOlC6moq6bFtHJK+OFb8JayyOqjhIFqjLBKYh4H+KjBdyxlXTRttGVUdpj
         IV6yeFaThuOFW0HyqpTWHnWlDDQsOoKz1LHeMESPiD+Zu0MHKqBtZ55OkzkEvbSLDkHr
         M6CBRhi5F38L6gyljRT4uBWN11BYsYNs2lGwMx5tnt8HkVZw7NUq9ExN2NHYUVofshZF
         Fzm9kYhfCYhQuFW1ZhvpCUNu2SqEPEuvuD1jsnbzcnDqJyVa3kqyFqsuXrkbKL+ZoK7k
         iOuQD/wbU8th/0iKaxOSKq92AQgkYZX9Re3WStH2yCGmAjeKj3tabBD0j/IntMcguZgX
         FxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n0Q03Y/eZmvD4gdqyNKPm3EQwhmNG2mz8mwozYTQaEw=;
        b=Gmf6OvHvv/MtKGtJSmSALW3s2bRtI8wIOJyRDF1RIY98UTZA7LMr39ucRP47HUjp0N
         7WewnYpHMd/JKcmFdXpTzMaPB013ibQ6YJf3wb9Ociu55RvFrgx6TGtstyyIBduAxlmd
         9m7eSYEsh43ZcC51zPs9eBzMQWrKRoD2Y0oQZ8Bg2Mtoooy8Li044KAC0raZW8wvZYbF
         CB4lVVQThlRzz6CQOYu2cY6XaWmOMS1UoOU54oHyrmtnqwIRGmVs6T0u7+sjWPGzRDPW
         +EDav0OUGhJC1vmwtQE0hD/a3DgAUNXjrVS47hLbj0wfdHtfCrlJA+/RllvtJyI2xkDG
         rUHQ==
X-Gm-Message-State: AOAM532VfsXZXZyjndFZqkUzLZmoxTEVNl0e486pYc4+gf27980lZbvz
        2j4Z6DTAK2Y4kI2XWmVD5fxbdQ==
X-Google-Smtp-Source: ABdhPJxoiUP1tZ7KeNBPWAx2H5m7E3mW/0pyOPTv0wkEGMWe6jMBimeBnZDbkH6Rv5j9d7LBGVtYTw==
X-Received: by 2002:a05:620a:2681:b0:67e:933e:54b6 with SMTP id c1-20020a05620a268100b0067e933e54b6mr12895867qkp.428.1649421940184;
        Fri, 08 Apr 2022 05:45:40 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id c70-20020a379a49000000b0069bdce177e2sm979729qke.55.2022.04.08.05.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 05:45:37 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1ncnzc-00Eyq7-W4; Fri, 08 Apr 2022 09:45:37 -0300
Date:   Fri, 8 Apr 2022 09:45:36 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, alex.williamson@redhat.com,
        cohuck@redhat.com, schnelle@linux.ibm.com, farman@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com, frankja@linux.ibm.com,
        david@redhat.com, imbrenda@linux.ibm.com, vneethv@linux.ibm.com,
        oberpar@linux.ibm.com, freude@linux.ibm.com, thuth@redhat.com,
        pasic@linux.ibm.com, pbonzini@redhat.com, corbet@lwn.net,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 16/21] KVM: vfio: add s390x hook to register KVM guest
 designation
Message-ID: <20220408124536.GX64706@ziepe.ca>
References: <20220404174349.58530-1-mjrosato@linux.ibm.com>
 <20220404174349.58530-17-mjrosato@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404174349.58530-17-mjrosato@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Apr 04, 2022 at 01:43:44PM -0400, Matthew Rosato wrote:
> At the time a KVM is associated with a vfio group, s390x zPCI devices
> must register a special guest indication (GISA designation) to allow
> for the use of interpretive execution facilities.  This indication is
> used to ensure that only the specified KVM can interact with the device.
> Similarly, the indication must be removed once the KVM is no longer
> associated with the device.
> 
> This patch adds an s390-specific hook to invoke a KVM registration routine
> for each device associated with the iommu group; in reality, it will be a
> NOP for all but zPCI devices on s390x.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  virt/kvm/vfio.c | 35 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 34 insertions(+), 1 deletion(-)

I wonder if this should be done in the vfio_pci side from the existing
kvm notifier

Jason
