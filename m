Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86921C43214
	for <linux-s390@archiver.kernel.org>; Wed, 25 Aug 2021 21:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660C8610CA
	for <linux-s390@archiver.kernel.org>; Wed, 25 Aug 2021 21:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbhHYV0S (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 25 Aug 2021 17:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233073AbhHYV0P (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 25 Aug 2021 17:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629926728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a8WjHoFBXc0jwAZ/Pzv1m1K7J4OWtNmWsJJuNT1URQ8=;
        b=U3LUOgGwsbOFZQ1PNqBh0/0Nza3r9tFgbqKLgmzl7e6xnUoR+jmIZSOKyT6YXdxdTZqR6p
        IzsgROSabeyytiVUrL8XTH/Qj8NeU0zHiUJ+QCnhi953PdhViHrlghuUGeofeK6clZgbJx
        fDV+bDD3KE/11hgi0zi9KoTshxR1bcY=
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-lJW9zQ6JPR6AAiQBcjSN3w-1; Wed, 25 Aug 2021 17:25:27 -0400
X-MC-Unique: lJW9zQ6JPR6AAiQBcjSN3w-1
Received: by mail-oo1-f71.google.com with SMTP id w9-20020a4aca09000000b0028b7adc5bd2so312610ooq.11
        for <linux-s390@vger.kernel.org>; Wed, 25 Aug 2021 14:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=a8WjHoFBXc0jwAZ/Pzv1m1K7J4OWtNmWsJJuNT1URQ8=;
        b=amw0/UMD7TbPjI5K2bQDMgm7KxXeQmt3MatRcsJe6CliUDLHTbxKMr3nP97fhskfza
         g/qdtlc8QLHquSWUuZET5iTJn5i0JDCwz7AmiTvpl+JvifFDerTUjTVwo6JLePsKw4dE
         CIoblcy5srASCfvki/XTBce0mZ1ioS4Dmd6sTbtZ6x82DMqpxb/QDMKXdEizj0vwFJbJ
         XlGsj+zNAoHBZYETn3CULZ+tLc0NawZW5McQt+y31PUIuqnnnmZwEvBwTNBXpFK2bJlZ
         WD63zzGtT0P2aJHTIEfSJj2BEO8FBknfOaRhyDCsOiFWE3uyX7cWel5LoTbMwiJUIzxc
         beNQ==
X-Gm-Message-State: AOAM531IfIeG4Iuhu1D5D4xP2ow0JeJyo7g7NXR97DmaOSMmOFmHiMbB
        Xu8JF4xhuNy3oDbk9NGr68pr/UHKozNlKCzirL/8NkzEftQq6j6LvMnOQuFSFe+uj4c7wvpIPQT
        ROGbmpUbylTp/5M0ck3nxBA==
X-Received: by 2002:aca:59c6:: with SMTP id n189mr8927969oib.44.1629926726456;
        Wed, 25 Aug 2021 14:25:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2TQ0tVP/G/91e1rsMJxtfNj9JdiJU9bbsFApswvKRzxaqgLUrbQuFPpCCzIEKetVt2wAhqA==
X-Received: by 2002:aca:59c6:: with SMTP id n189mr8927948oib.44.1629926726248;
        Wed, 25 Aug 2021 14:25:26 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id y7sm178910oov.36.2021.08.25.14.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 14:25:25 -0700 (PDT)
Date:   Wed, 25 Aug 2021 15:25:24 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Yishai Hadas <yishaih@nvidia.com>, bhelgaas@google.com,
        corbet@lwn.net, diana.craciun@oss.nxp.com, kwankhede@nvidia.com,
        eric.auger@redhat.com, masahiroy@kernel.org,
        michal.lkml@markovi.net, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kbuild@vger.kernel.org,
        mgurtovoy@nvidia.com, jgg@nvidia.com, maorg@nvidia.com,
        leonro@nvidia.com
Subject: Re: [PATCH V4 09/13] PCI: Add 'override_only' field to struct
 pci_device_id
Message-ID: <20210825152524.45437035.alex.williamson@redhat.com>
In-Reply-To: <20210825155446.GA3575423@bjorn-Precision-5520>
References: <20210825135139.79034-10-yishaih@nvidia.com>
        <20210825155446.GA3575423@bjorn-Precision-5520>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 25 Aug 2021 10:54:46 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Aug 25, 2021 at 04:51:35PM +0300, Yishai Hadas wrote:
> > From: Max Gurtovoy <mgurtovoy@nvidia.com>
> > 
> > Add 'override_only' field to struct pci_device_id to be used as part of
> > pci_match_device().
> > 
> > When set, it means that matching is true only when dev->driver_override
> > is this driver.  
> 
> Maybe:
> 
>   When set, a driver only matches the entry when dev->driver_override
>   is set to that driver.

I've made this change locally, thanks Bjorn.

Alex

> 
> > In addition, add a helper macro named 'PCI_DEVICE_DRIVER_OVERRIDE' to
> > enable setting some data on it.
> > 
> > Next patch from this series will use the above functionality.
> > 
> > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Yishai Hadas <yishaih@nvidia.com>  
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

