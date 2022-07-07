Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59134C433EF
	for <linux-s390@archiver.kernel.org>; Thu,  7 Jul 2022 21:33:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbiGGVc7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Jul 2022 17:32:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbiGGVc7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Jul 2022 17:32:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 99CCD33E0F
        for <linux-s390@vger.kernel.org>; Thu,  7 Jul 2022 14:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657229577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cV1j2ZcOZ2ukDQseRE+2/CeOpXmD1CKdU7i9wQDZBys=;
        b=jQ15mvae6LckeUujOemyKW6+0nTqI67le8QVgplrjHcSQDJ8PouhWSxvdOBgAGA618d41V
        jGrLm+K2d1X2A09sO9Rdab79rcA/auBdyWrGscEpXoeJagHV5xGRXiDzkzpZPG0A5Zdd+7
        mPXEMsJkKc6h+J18/wzzpPH7WuEn+so=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-YznrED78PVOuc20o0MGc9A-1; Thu, 07 Jul 2022 17:32:56 -0400
X-MC-Unique: YznrED78PVOuc20o0MGc9A-1
Received: by mail-io1-f69.google.com with SMTP id s7-20020a5d9287000000b00678b8aa9e1aso3932614iom.11
        for <linux-s390@vger.kernel.org>; Thu, 07 Jul 2022 14:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=cV1j2ZcOZ2ukDQseRE+2/CeOpXmD1CKdU7i9wQDZBys=;
        b=dfifCvC3s+8w1aAiDcKGhzt038e7Ru8mAbTpTuS5lZAaACpxMPDiRflZiMgoz+gr7n
         oG3BbFfFsit5s4igGSzdvJeq1upVvUvWSzbyihocvOGsdwIcn45+T3JY5CaBguO6pjac
         Wm7+XLF9Y0GbTLTHJioEaXDp1gnOYV2XSxiVlIuiF7hx4P9OMKfJxUbzMFks+uG0b7Qp
         sWhPczSbNbg1mwgZPxIoDpc07j5hcEoxcb6cpV7vAWjwDVCiO/Ytmj4D9mwp6omxC35G
         4SJ+nivgWjZsGt+j/3KDZeNuMR9oPQnkxTE66vAjvGaIJTU45gNsr817zjJA1vJusF77
         cXNw==
X-Gm-Message-State: AJIora/4EKVwMUQ2RQBU0aOYnEt/YmCaCHkoOyiQwoqXT7zlg2FWzMXT
        uPrShZT6jQgfiwvu86lNHmPXx6jk5CW3eeI+VarIciNftnK3Uci6Xnukph6xjvnI0fz99K1j4au
        8hbytm8lG4/RoZPiL/J5WWw==
X-Received: by 2002:a05:6602:3799:b0:675:6a5f:7862 with SMTP id be25-20020a056602379900b006756a5f7862mr69623iob.145.1657229575472;
        Thu, 07 Jul 2022 14:32:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sAdM81uL8IRdNPDxNMth+ZRU9oKnRMb2HyV5qi+7gZzQ01BPw4Z2eS/KO7GFhisJ0965XFTg==
X-Received: by 2002:a05:6602:3799:b0:675:6a5f:7862 with SMTP id be25-20020a056602379900b006756a5f7862mr69617iob.145.1657229575253;
        Thu, 07 Jul 2022 14:32:55 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z18-20020a056638215200b0033f16e84688sm1426558jaj.8.2022.07.07.14.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 14:32:54 -0700 (PDT)
Date:   Thu, 7 Jul 2022 15:32:53 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH v4 00/11] s390/vfio-ccw rework
Message-ID: <20220707153253.13deffe3.alex.williamson@redhat.com>
In-Reply-To: <20220707135737.720765-1-farman@linux.ibm.com>
References: <20220707135737.720765-1-farman@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu,  7 Jul 2022 15:57:26 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Alex,
> 
> Here's a final pass through some of the vfio-ccw rework.
> I'm hoping that because of the intersection with the extern
> removal, you could grab this directly? [1]

Done.  Applied to vfio next branch for v5.20.  Thanks,

Alex

> There were no code changes since v3, I simply rebased this
> onto your linux-vfio/next tree, currently on commit 7654a8881a54
> ("Merge branches
>  'v5.20/vfio/migration-enhancements-v3',
>  'v5.20/vfio/simplify-bus_type-determination-v3',
>  'v5.20/vfio/check-vfio_register_iommu_driver-return-v2',
>  'v5.20/vfio/check-iommu_group_set_name_return-v1',
>  'v5.20/vfio/clear-caps-buf-v3',
>  'v5.20/vfio/remove-useless-judgement-v1' and
>  'v5.20/vfio/move-device_open-count-v2'
>  into
>  v5.20/vfio/next")
> 
> v3->v4:
>  - Rebased to vfio/next tree
>    - Tweak patch 6 to fit with extern removal
>    - The rest applied directly
>  - [MR] Added r-b's (Thank you!)
>  - [EF] Add a comment about cp_free() call in fsm_notoper()
> v3: https://lore.kernel.org/r/20220630203647.2529815-1-farman@linux.ibm.com/
> v2: https://lore.kernel.org/r/20220615203318.3830778-1-farman@linux.ibm.com/
> v1: https://lore.kernel.org/r/20220602171948.2790690-1-farman@linux.ibm.com/
> 
> Footnotes:
> [1] https://lore.kernel.org/r/e1ead3e4-9e7d-f026-485b-157d7dc004d3@linux.ibm.com/
> 
> Cc: Kirti Wankhede <kwankhede@nvidia.com>
> 
> Eric Farman (10):
>   vfio/ccw: Fix FSM state if mdev probe fails
>   vfio/ccw: Do not change FSM state in subchannel event
>   vfio/ccw: Remove private->mdev
>   vfio/ccw: Pass enum to FSM event jumptable
>   vfio/ccw: Flatten MDEV device (un)register
>   vfio/ccw: Update trace data for not operational event
>   vfio/ccw: Create an OPEN FSM Event
>   vfio/ccw: Create a CLOSE FSM event
>   vfio/ccw: Refactor vfio_ccw_mdev_reset
>   vfio/ccw: Move FSM open/close to MDEV open/close
> 
> Michael Kawano (1):
>   vfio/ccw: Remove UUID from s390 debug log
> 
>  drivers/s390/cio/vfio_ccw_async.c   |  1 -
>  drivers/s390/cio/vfio_ccw_drv.c     | 59 +++++------------
>  drivers/s390/cio/vfio_ccw_fsm.c     | 99 ++++++++++++++++++++++++-----
>  drivers/s390/cio/vfio_ccw_ops.c     | 77 +++++++---------------
>  drivers/s390/cio/vfio_ccw_private.h |  9 +--
>  include/linux/mdev.h                |  5 --
>  6 files changed, 125 insertions(+), 125 deletions(-)
> 

