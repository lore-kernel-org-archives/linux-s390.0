Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EF4C00144
	for <linux-s390@archiver.kernel.org>; Mon,  1 Aug 2022 20:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbiHAUzj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 1 Aug 2022 16:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234629AbiHAUzf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Aug 2022 16:55:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE598DFE8
        for <linux-s390@vger.kernel.org>; Mon,  1 Aug 2022 13:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659387333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKq8HVGZQpe4cr2LqvofdEB83s1X3DS/h6MN4idsnvs=;
        b=ENbdOiB4JmuOAEm7WFCOrfYzUpKsDiE6u+FUZD+DLIw6jHVnP56CU64gI1QGPgfl2R5exg
        sMQR8F1MzC+/frVVj4mxh8lA7kGaEKd+TSJYkUnc/bPzgQ3qvJpzeTks81oV6IRUbcUShz
        EwX7zi58LhyG6qW853UIbvnYsxkI4GE=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-bxnqjwRLOZChLY8zWNdQ4A-1; Mon, 01 Aug 2022 16:55:32 -0400
X-MC-Unique: bxnqjwRLOZChLY8zWNdQ4A-1
Received: by mail-il1-f200.google.com with SMTP id x7-20020a056e021ca700b002ded2e6331aso938247ill.20
        for <linux-s390@vger.kernel.org>; Mon, 01 Aug 2022 13:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=QKq8HVGZQpe4cr2LqvofdEB83s1X3DS/h6MN4idsnvs=;
        b=W6qJKz+yv711PVmlYN0IFWf1e1ObM0n3FCrzlystvd/C9KUSFKW0J9/U96mmojLi7V
         5qvMyGGU9OeOOT0If+56R+9sv6cEsFylEjyLD+/QKLusFCuSSMJlNC/+HC/MJ0yzEqhO
         WVl+rPKCKzRWSFcwO/chrh5dVoN5dUbMsnN3V7kqTH13pTOUBhN2RCNEz0/h15fJXZ74
         fXumLEypri92HJYFTL/CLPJTDCDgWXEQuAPxRgdVqSK5duILgrTA8EH9UE23R2Xz1Y+h
         6xJSZxh1+WbXPF0RbAg5VL8TvZjqgyP9bkbT/GY7dIV3JmK222DQlohRO53tkbMtrFKm
         gt7Q==
X-Gm-Message-State: ACgBeo3AIAGadXJAQ3jmDmzVFXENMsotlDWomUH8fDCmRQDOaAEsPCXE
        vdBESPBSLxGVdiVnN2qSvaoXvMGiCfmFZP0TDH5w5lF6dq7Vt/To02RQWqR05RnRRprlns4hwiR
        EUTeNAcFsTVxyxmNlmV1Z+w==
X-Received: by 2002:a05:6e02:1d81:b0:2de:e4d2:787d with SMTP id h1-20020a056e021d8100b002dee4d2787dmr155046ila.126.1659387331634;
        Mon, 01 Aug 2022 13:55:31 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4QImEUtJqO/CgVMXMKqIjE3TY0B7QN+vBWj7uS022EYUdT4narfpq+W80jOwZoLjvTO3ZYKA==
X-Received: by 2002:a05:6e02:1d81:b0:2de:e4d2:787d with SMTP id h1-20020a056e021d8100b002dee4d2787dmr155036ila.126.1659387331455;
        Mon, 01 Aug 2022 13:55:31 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id v7-20020a05663812c700b0032e49fcc241sm5685731jas.176.2022.08.01.13.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 13:55:31 -0700 (PDT)
Date:   Mon, 1 Aug 2022 14:55:28 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Nicolin Chen <nicolinc@nvidia.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v3 0/3] vfio-ccw fixes for 5.20
Message-ID: <20220801145528.4b7ec8c7.alex.williamson@redhat.com>
In-Reply-To: <20220728204914.2420989-1-farman@linux.ibm.com>
References: <20220728204914.2420989-1-farman@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 28 Jul 2022 22:49:11 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Matt, Alex,
> 
> Here are the (hopefully last) patches for the DMA UNMAP thing.
> 
> Changelog:
> v2->v3:
>  - [MR] Add r-b to Patch 1, 3 (Thank you!)
>  - [MR] s/unsigned long/u64/
>  - [EF] Add brackets to for(i) loop
> v2: https://lore.kernel.org/r/20220728160550.2119289-1-farman@linux.ibm.com/
> v1: https://lore.kernel.org/r/20220726150123.2567761-1-farman@linux.ibm.com/
> 
> Eric Farman (3):
>   vfio/ccw: Add length to DMA_UNMAP checks
>   vfio/ccw: Remove FSM Close from remove handlers
>   vfio/ccw: Check return code from subchannel quiesce
> 
>  drivers/s390/cio/vfio_ccw_cp.c  | 16 +++++++++++-----
>  drivers/s390/cio/vfio_ccw_cp.h  |  2 +-
>  drivers/s390/cio/vfio_ccw_drv.c |  1 -
>  drivers/s390/cio/vfio_ccw_fsm.c |  2 +-
>  drivers/s390/cio/vfio_ccw_ops.c |  4 +---
>  5 files changed, 14 insertions(+), 11 deletions(-)
> 

Applied to vfio next branch for v5.20/v6.0.  Thanks,

Alex

