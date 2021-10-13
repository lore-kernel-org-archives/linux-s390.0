Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF96C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 13 Oct 2021 12:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD91460EE9
	for <linux-s390@archiver.kernel.org>; Wed, 13 Oct 2021 12:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhJMM5O (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 13 Oct 2021 08:57:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231294AbhJMM5N (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Oct 2021 08:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634129710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bua+UvhRZx/vtJpW/R79wAmjzbaBOR2FatQ2gYmLKAk=;
        b=imCDhWuWI5hr9wxKRNm+RZyDWnJUNKV39xwKQtw3TkcLGfdCvLzMrnapy3qlT/MV0lN9Yo
        GgkZNr7ehYSNFnKhhWxJ6MthVECACrBxnnuYBMn1i7mTJAuQS8x8m5ZhQYvDXohyqkh67p
        juX97odvt37mrfN0/KE6gNs1Fgz+Z8g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-U2IIN9iEPhmwZgiwg4d_zA-1; Wed, 13 Oct 2021 08:55:09 -0400
X-MC-Unique: U2IIN9iEPhmwZgiwg4d_zA-1
Received: by mail-wr1-f72.google.com with SMTP id r16-20020adfb1d0000000b00160bf8972ceso1889257wra.13
        for <linux-s390@vger.kernel.org>; Wed, 13 Oct 2021 05:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bua+UvhRZx/vtJpW/R79wAmjzbaBOR2FatQ2gYmLKAk=;
        b=7u+waBrL2k5aI8VxLQwqDwOcOrQkSFbOfpaJvP0KgqBUoKQ4cffbfbJMPTqksWXvZf
         6uX+tzZPWovJfneRCaUPjdfU1rfN5XzPyH2dRRFdq+Yj/TkJNrk6pQS5jJkr5ElvEgLc
         mwO4J4YbeKdMm+BnJdovzhHsIIP33b61UC3Gxs8ak3C22ke2FUo54YNKY+cwBz1xy6Z/
         gahQNltwKYLWc8Ib0yx91q+eXj1UuLA9Q7ZaYuFcvbR9HCeWbWogeVJXq//nok6ZR50D
         b6XQNVu4fne2N16uMBhxcsF80gpfQ3UQKtNV0g3IstHIgaClndi9T7Y0Mr4urruTBtJy
         j6eA==
X-Gm-Message-State: AOAM533Led13AKzv54CQKDLUhy3gB5stayV05kN+0xL2eXNcMkgMosSQ
        8Q8A2NEeFzc9oKrK8xZQlgVnIfDdF1xU8b33oJBQGZfsgL/K1aowOLGb8lgdph+q/dtxSFfdT30
        ZBDNVVFafPzLfXTknw93ggw==
X-Received: by 2002:a1c:22d7:: with SMTP id i206mr13001187wmi.122.1634129708024;
        Wed, 13 Oct 2021 05:55:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUlSBIGEPmkknnlsQTkGPbs0LAOHhsvCUmorYQR19foafC7W/ikoT3XdyrV6wuhDzoeZLiZw==
X-Received: by 2002:a1c:22d7:: with SMTP id i206mr13001158wmi.122.1634129707894;
        Wed, 13 Oct 2021 05:55:07 -0700 (PDT)
Received: from redhat.com ([2.55.30.112])
        by smtp.gmail.com with ESMTPSA id g12sm5445986wme.3.2021.10.13.05.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 05:55:07 -0700 (PDT)
Date:   Wed, 13 Oct 2021 08:55:03 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        markver@us.ibm.com, linux-s390@vger.kernel.org,
        stefanha@redhat.com, Raphael Norwitz <raphael.norwitz@nutanix.com>,
        qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/1] virtio: write back F_VERSION_1 before validate
Message-ID: <20211013085423-mutt-send-email-mst@kernel.org>
References: <20211011053921.1198936-1-pasic@linux.ibm.com>
 <20211013060923-mutt-send-email-mst@kernel.org>
 <96561e29-e0d6-9a4d-3657-999bad59914e@de.ibm.com>
 <20211013081836-mutt-send-email-mst@kernel.org>
 <87zgrdulwp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgrdulwp.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 13, 2021 at 02:52:38PM +0200, Cornelia Huck wrote:
> On Wed, Oct 13 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Oct 13, 2021 at 01:23:50PM +0200, Christian Borntraeger wrote:
> >> Can we get this kernel patch queued for 5.15 and stable without waiting for the QEMU patch
> >> as we have a regression with 4.14?
> >
> > Probably. Still trying to decide between this and plain revert for 5.15
> > and back. Maybe both?
> 
> Probably better queue this one, in case we have some undiscovered
> problems with the config space access in virtio-net?

So both then. I think you are right. Pushed out to -next. Will do a pull
towards end of the week.

-- 
MST

