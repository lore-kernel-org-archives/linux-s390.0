Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DF3C4320A
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 16:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E09860EE7
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 16:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237566AbhHCQwt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 3 Aug 2021 12:52:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29187 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237576AbhHCQwl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Aug 2021 12:52:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628009550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKtEVRvHNGT42iZNHToUtsFsYwSj6OAOl6LkhSWUXzQ=;
        b=HLV1Uxh/gQiv/X+OpQ5B69XeaYIxGDambTtmAWr5ZJH2dj7N4Z4L/z7Yj1gnzZXn3i9R2B
        lG9R4VggXRkMLPa9N8Q+o0v1TrFDrBkrrRBzYDyC9aUjDb8L1xpFEdVO8QbrLGotDuWGEm
        O4cGC8S+awZQszOe82cNu04N+KI6Jbw=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-A9W5KVbBMp68xGPacAerEw-1; Tue, 03 Aug 2021 12:52:28 -0400
X-MC-Unique: A9W5KVbBMp68xGPacAerEw-1
Received: by mail-oi1-f200.google.com with SMTP id r12-20020a056808210cb029025af6d05d99so8879905oiw.10
        for <linux-s390@vger.kernel.org>; Tue, 03 Aug 2021 09:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sKtEVRvHNGT42iZNHToUtsFsYwSj6OAOl6LkhSWUXzQ=;
        b=Na/bsi9y2ap9ZmZAdoHKT3imEi1GqeTJ4YERKRH/5+99Mw/kBbOoLK8YwBaKdsURCD
         RRoiFrU9WCA7mgwkU1q/63oL3fOEDbazaR4A73tNdBI8DhfrUNXRCJ/o8O8LDTf9vQHb
         J56wUpsHoCLLtjiQ60FQ3P9J9f3MDB+MgDNOR5aLDFNe6fjbZ+Q8lEtrD5nzFrj2HQQo
         YlWvi5HZN8GZxWXq1VOyhE0mmDzZO0JacWN8YlWx2eMzvvbASi3ljWSrNsuJUKJ6gwnF
         1FIcIEeGuesBSoox2pFnqzUKwNC0x1Igmb2CRTSXR7AKa9+GybgDvzbuR+wZn6LIKlSQ
         3Cvg==
X-Gm-Message-State: AOAM533WC2Ps9+xwKhvy28EdTDNYDMciiju6+9ExN8buqxoNKG5EhwyD
        KjV8fL/oowOgY0Ft+7r6MY87UvtA/j/p8kze7+Xp9H1jnpofcgJm/7m/TgZ3BueX/n/SHkkLve5
        5TNrokLdKH+/YyBoxa2orIw==
X-Received: by 2002:a9d:62d4:: with SMTP id z20mr16205621otk.305.1628009548262;
        Tue, 03 Aug 2021 09:52:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwvKOEKD8L0w37wO357XcF+/U3bT3CXb+wzZAe9sXlApc1eVkv2cU2JtkoR7Kvj984JI4QXhg==
X-Received: by 2002:a9d:62d4:: with SMTP id z20mr16205581otk.305.1628009548040;
        Tue, 03 Aug 2021 09:52:28 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id bd20sm2365330oib.1.2021.08.03.09.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 09:52:27 -0700 (PDT)
Date:   Tue, 3 Aug 2021 10:52:25 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     David Airlie <airlied@linux.ie>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Vetter <daniel@ffwll.ch>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        dri-devel@lists.freedesktop.org,
        Eric Auger <eric.auger@redhat.com>,
        Eric Farman <farman@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        kvm@vger.kernel.org, Kirti Wankhede <kwankhede@nvidia.com>,
        linux-doc@vger.kernel.org, linux-s390@vger.kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Christoph Hellwig <hch@lst.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v3 09/14] vfio/pci: Change vfio_pci_try_bus_reset() to
 use the dev_set
Message-ID: <20210803105225.2ee7dac2.alex.williamson@redhat.com>
In-Reply-To: <20210803164152.GC1721383@nvidia.com>
References: <0-v3-6c9e19cc7d44+15613-vfio_reflck_jgg@nvidia.com>
        <9-v3-6c9e19cc7d44+15613-vfio_reflck_jgg@nvidia.com>
        <20210803103406.5e1be269.alex.williamson@redhat.com>
        <20210803164152.GC1721383@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 3 Aug 2021 13:41:52 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:
> On Tue, Aug 03, 2021 at 10:34:06AM -0600, Alex Williamson wrote:
> > I think the vfio_pci_find_reset_target() function needs to be re-worked
> > to just tell us true/false that it's ok to reset the provided device,
> > not to anoint an arbitrary target device.  Thanks,  
> 
> Yes, though this logic is confusing, why do we need to check if any
> device needs a reset at this point? If we are being asked to reset
> vdev shouldn't vdev needs_reset?
> 
> Or is the function more of a 'synchronize pending reset' kind of
> thing?

Yes, the latter.  For instance think about a multi-function PCI device
such as a GPU.  The functions have dramatically different capabilities,
some might have function level reset abilities and others not.  We want
to be able to trigger a bus reset as the last device of the set is
released, no matter the order they're released and no matter the
capabilities of the device we're currently processing.  Thanks,

Alex

