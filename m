Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D96C4338F
	for <linux-s390@archiver.kernel.org>; Tue, 24 Aug 2021 20:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C892D61178
	for <linux-s390@archiver.kernel.org>; Tue, 24 Aug 2021 20:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbhHXUau (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 24 Aug 2021 16:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235166AbhHXUau (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Aug 2021 16:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629837005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J6zJIonQ8sbLYLpWTPIgRo4g40sNi8HlntfUwF/X63A=;
        b=HsaHy3fkm6zr9PpEbiCAIi53X3A+jr95f0mDBH0T5KkwTFhqx6oXdNd9u7SgtozeBr0KDP
        BhSNAgHwinBP6ovB+2Asnc5T4+Mn3figHwNrC5kEmdkZXx2Z8Npf71MJP0AYU7GBRust1E
        kaoskQzX87fYUkgSsN78y/j7r3w1688=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-ywrzbifdPgG3UHDmAJ8Zrg-1; Tue, 24 Aug 2021 16:30:04 -0400
X-MC-Unique: ywrzbifdPgG3UHDmAJ8Zrg-1
Received: by mail-oo1-f72.google.com with SMTP id q11-20020a4aa88b000000b0028e498bb328so8408192oom.3
        for <linux-s390@vger.kernel.org>; Tue, 24 Aug 2021 13:30:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=J6zJIonQ8sbLYLpWTPIgRo4g40sNi8HlntfUwF/X63A=;
        b=R5PCuwowWTbxZRN+Sd5EUFrfiVBrqYW8dzME8L+kd+sJAa2UXQVbq6RRKTBbEwSNCM
         f8HgArrVUl4ufPvqq81NWFsJn7NhnCuXwv9RBEtPWsmg15wCiWL3UB3vcWYE+yKVnhoU
         rkV45PebJLImaOIfWMve6OCPnVxmYs1DSi2huyIq3WF7v3mgG7ByyEqkYegFkztQwUFo
         WN1KawzigTbuwOdpbmHhLsG8jMW6M/eSheM59bsm6BPF+QL2xZ9IGsa1trMrc64by3QT
         8hsEJPJ8oFED47qPhNrczK+2GSe/igWKw9RV0oPGppSW9wo2YlkJF5G9+SlFlutX53IW
         5/Ew==
X-Gm-Message-State: AOAM531Oi8uzD73y3oo9lWRE8X2zglidq0AXhCMOZAfS5hN7OkIme449
        1YskGMt9ItAZNdO50h0NECZ3uu493U6LHthr9q74dR0Xm4oAqMAQuTjxFhYWJVqrzhqlLG1+VCe
        EiooejeSZf2ZHd5pd5PfrPw==
X-Received: by 2002:aca:e0d7:: with SMTP id x206mr4202522oig.64.1629837003407;
        Tue, 24 Aug 2021 13:30:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw7vVhF4XwzKAtQjFHSJbTyCq4g1oiWfoZbe/haR7vHY/Y6rFS9ri4QbRqIzCsPv2xQKnXCJg==
X-Received: by 2002:aca:e0d7:: with SMTP id x206mr4202510oig.64.1629837003228;
        Tue, 24 Aug 2021 13:30:03 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id f3sm5161191otc.49.2021.08.24.13.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 13:30:02 -0700 (PDT)
Date:   Tue, 24 Aug 2021 14:30:01 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Christoph Hellwig <hch@lst.de>, kvm@vger.kernel.org
Subject: Re: [PATCH v4] vfio/ap_ops: Convert to use
 vfio_register_group_dev()
Message-ID: <20210824143001.37d01a77.alex.williamson@redhat.com>
In-Reply-To: <0-v4-0203a4ab0596+f7-vfio_ap_jgg@nvidia.com>
References: <0-v4-0203a4ab0596+f7-vfio_ap_jgg@nvidia.com>
Organization: Red Hat
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

Jason & Tony,

Would one of you please rebase on the other's series?  The merge
conflict between this and 20210823212047.1476436-1-akrowiak@linux.ibm.com
is more than I'd like to bury into a merge commit and I can't test beyond
a cross compile.  Thanks,

Alex

