Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EB5C432BE
	for <linux-s390@archiver.kernel.org>; Thu, 26 Aug 2021 22:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2A06023B
	for <linux-s390@archiver.kernel.org>; Thu, 26 Aug 2021 22:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243739AbhHZWVp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 26 Aug 2021 18:21:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243721AbhHZWVo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 26 Aug 2021 18:21:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630016456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E45zJc4oH06emd8/Yu3NtU7GehJdnqxTJyDZ7X6eE2A=;
        b=SeyH9ktsRFi/mTRxrBQI6+RHuHD0wuP9ieSr6oDAAey2I2qY5XkPg6gMn3ShbPXAlC9bj8
        oGqiT89yx8E9fwItKnOW+nYjy2Qj74p91Yw3MvT0uYmM3LnpIJHOvdkPTJpj3PMeRfppZd
        ogAWE9jyPZybRIMYFOg/+tMc/6qJCGs=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-luq6MyLVOzWoZGofHm6iLA-1; Thu, 26 Aug 2021 18:20:54 -0400
X-MC-Unique: luq6MyLVOzWoZGofHm6iLA-1
Received: by mail-oi1-f197.google.com with SMTP id 20-20020aca2814000000b002690d9b60aaso2327581oix.0
        for <linux-s390@vger.kernel.org>; Thu, 26 Aug 2021 15:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E45zJc4oH06emd8/Yu3NtU7GehJdnqxTJyDZ7X6eE2A=;
        b=DVMiA0s6yRnZS5QVI8t2+wshcFhOageF8NpOA74Gb1UirecUXVoTVykR79zKFnRmuN
         0YcSZnP2NweBz9W+6YD5N5Mjh1xCPq1wJa6Xc6M1ga/vheOUPk38c6BCe7jY69/m/YDN
         013kKEfx3pBNhRztLH7qsyFmlnJfmWB+W/xrBtlAD+kBK8dxD6uIe7e79tISzguSXB4b
         fJc4VL398Cj2iCXGzDPk3gEFxCIdq3SAgpGI0Fi8n+JPvd/zh3ADxFDmgWFiDvmXNd8e
         ehiQ0dDinXzP3ddK1bUnm4H184WIhEx/YfaUkYZFQz2uUipoeaqjYoyzUQFLPJQikIYk
         Hp8g==
X-Gm-Message-State: AOAM533/e5nk65XKzR2ZSWwafvtPl67CPmxor2O4kIMR6XkahC6QlXOb
        cVFwLASyDte5E1FXxz4c8PGycq74Nsf1VzNkpBGUa1LlEYmR42+Z0jOLndq01LfQ5pg4cIAko4+
        DHgfZtEEmSm2FvBkCve73Ng==
X-Received: by 2002:a05:6808:2114:: with SMTP id r20mr8550374oiw.110.1630016454216;
        Thu, 26 Aug 2021 15:20:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwV5g6FNgRXBdSqttIdFMv3Sr3DrKeu9HRoTkffbcSn69IA92vPaVYUw5wDBA60+nwRvHURiQ==
X-Received: by 2002:a05:6808:2114:: with SMTP id r20mr8550358oiw.110.1630016454035;
        Thu, 26 Aug 2021 15:20:54 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id a15sm842242otq.13.2021.08.26.15.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 15:20:53 -0700 (PDT)
Date:   Thu, 26 Aug 2021 16:20:52 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christoph Hellwig <hch@lst.de>, kvm@vger.kernel.org
Subject: Re: [PATCH v4] vfio/ap_ops: Convert to use
 vfio_register_group_dev()
Message-ID: <20210826162052.4e510767.alex.williamson@redhat.com>
In-Reply-To: <0-v4-0203a4ab0596+f7-vfio_ap_jgg@nvidia.com>
References: <0-v4-0203a4ab0596+f7-vfio_ap_jgg@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 23 Aug 2021 11:42:04 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> This is straightforward conversion, the ap_matrix_mdev is actually serving
> as the vfio_device and we can replace all the mdev_get_drvdata()'s with a
> simple container_of() or a dev_get_drvdata() for sysfs paths.
> 
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: kvm@vger.kernel.org
> Cc: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Tony Krowiak <akrowiak@linux.ibm.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c     | 155 +++++++++++++++-----------
>  drivers/s390/crypto/vfio_ap_private.h |   2 +
>  2 files changed, 91 insertions(+), 66 deletions(-)

Applied proposed port to Tony's series to vfio next branch for v5.15.
Thanks,

Alex

