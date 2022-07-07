Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE68C43334
	for <linux-s390@archiver.kernel.org>; Thu,  7 Jul 2022 23:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbiGGXBq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 7 Jul 2022 19:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236089AbiGGXBp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 Jul 2022 19:01:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E87161D58
        for <linux-s390@vger.kernel.org>; Thu,  7 Jul 2022 16:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657234903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q1R4YqBu0svZmycrzTEsm+CshT1fviRoeDSNFKgJtmI=;
        b=JGL6qyfZn0Fahh1RGug0wwaP8FpGKozQnM2T7k1je2a2148oIRg9lL9wdD6807+3RiOO8d
        qLlAJemH495K57wGI8QOr1ORoN5ZPNNJ82bfwjqSm/8kqHL80iOuzcGCbBdtNdHWTJvDy0
        yxaIuB0dKIOavvaKiT1UoexXSfBABy0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-dMTQ5xIqMwmP7Hxi-TEN0w-1; Thu, 07 Jul 2022 19:01:41 -0400
X-MC-Unique: dMTQ5xIqMwmP7Hxi-TEN0w-1
Received: by mail-io1-f72.google.com with SMTP id y22-20020a056602215600b00673b11a9cd5so10322878ioy.7
        for <linux-s390@vger.kernel.org>; Thu, 07 Jul 2022 16:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Q1R4YqBu0svZmycrzTEsm+CshT1fviRoeDSNFKgJtmI=;
        b=OuT4rgznFIQb1X1BO00ekEl9IV0yiAkYhIKAYvXOr2+jACjoISFMtVTzO/uCgiIvHd
         QSYo1Bk03hbbud/Mi+2jj+kqOaoYd5rx5mKDX46y0C0rxrMhi6wbWuEL6c/8XtD//+FI
         P6l5OewbndlqOXJkYfNYbx0yMXG7t/wyOWyVs/BGGDrz4z9otX5VFwz+KG70PyVfa4LK
         zjZqyyvUgJEBjAgWJE/bpq2ytUnYPaxx8BYJW6aa+gbAz6oBtZzqXxIG1IlSIY1mCYd3
         sZ5QJeX555gYvc3ROsdeRxUgAl6bZEQGUmkbq04mcihFufAK4bSv8m7H1wD3+NiTSNEj
         3/5w==
X-Gm-Message-State: AJIora8prXLmKDNdwrHe6E6fJWh8KwxKMj39NPXyvTeKUURjUc1oVYEk
        Z4AT088yNv0a3WifEgX9npVVD2m2mXIs8xgJaR4hS9DAb4o63l1wqrnaYaQot77AqmSuUm3CChz
        B7cjnhdQ2beVJ9VGStqMIrg==
X-Received: by 2002:a92:dc85:0:b0:2d9:1a4e:67b1 with SMTP id c5-20020a92dc85000000b002d91a4e67b1mr306000iln.282.1657234900873;
        Thu, 07 Jul 2022 16:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sipTe8IAMIsf4DdtE688PJxdjqLg8FaCbNUHuN/Z4VXumXyfd4opRxKbH9GUMWrG+goEhcVQ==
X-Received: by 2002:a92:dc85:0:b0:2d9:1a4e:67b1 with SMTP id c5-20020a92dc85000000b002d91a4e67b1mr305978iln.282.1657234900651;
        Thu, 07 Jul 2022 16:01:40 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i15-20020a92c94f000000b002dc21dec1d9sm3635833ilq.16.2022.07.07.16.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 16:01:40 -0700 (PDT)
Date:   Thu, 7 Jul 2022 17:01:39 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org
Subject: Re: [PATCH 15/15] vfio/mdev: remove an extra parent kobject
 reference
Message-ID: <20220707170139.1b2f977e.alex.williamson@redhat.com>
In-Reply-To: <20220707134052.GC19060@lst.de>
References: <20220706074219.3614-1-hch@lst.de>
        <20220706074219.3614-16-hch@lst.de>
        <20220706143833.GD693670@nvidia.com>
        <20220707134052.GC19060@lst.de>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 7 Jul 2022 15:40:52 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Jul 06, 2022 at 11:38:33AM -0300, Jason Gunthorpe wrote:
> > On Wed, Jul 06, 2022 at 09:42:19AM +0200, Christoph Hellwig wrote:  
> > > The mdev_type already holds a reference to the parent through
> > > mdev_types_kset, so drop the extra reference.  
> > 
> > I would drop this patch, but at least the explanation needs tweaking..  
> 
> I'm fine with that.  Alex, any preferences?

Modulo the bogus kobject_put()s, this essentially reverts:

commit 9a302449a58d45d0ef2aab686f64b35919bc604c
Author: Jason Gunthorpe <jgg@ziepe.ca>
Date:   Tue Apr 6 16:40:30 2021 -0300

    vfio/mdev: Add missing reference counting to mdev_type
    
    struct mdev_type holds a pointer to the kref'd object struct mdev_parent,
    but doesn't hold the kref. The lifetime of the parent becomes implicit
    because parent_remove_sysfs_files() is supposed to remove all the access
    before the parent can be freed, but this is very hard to reason about.
    
    Make it obviously correct by adding the missing get.
    
    Reviewed-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Kevin Tian <kevin.tian@intel.com>
    Reviewed-by: Cornelia Huck <cohuck@redhat.com>
    Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
    Message-Id: <7-v2-d36939638fc6+d54-vfio2_jgg@nvidia.com>
    Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

Which we all seemed to think was a good thing 15 months ago.  It is
still difficult to reason when the mdev_type_ktype.release function
occurs relative to the parent reference held by the kset, but without
an explanation how we're safe, I'm ok with a little paranoia and
explicit references.  Thanks,

Alex

