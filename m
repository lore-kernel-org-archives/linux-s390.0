Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D68C05027
	for <linux-s390@archiver.kernel.org>; Tue, 14 Feb 2023 15:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjBNPzK (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Feb 2023 10:55:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjBNPzJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Feb 2023 10:55:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58FEA252B0
        for <linux-s390@vger.kernel.org>; Tue, 14 Feb 2023 07:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676390062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xb46HmzYSch6mL85Mc29IUcDhw17TwDxuJ7aIajpOQI=;
        b=Vr0iZY5qOMEEu5X8aVk5zyNvJiFSALxGQcrWXjWbtD3rHZ1EDsBOZ7l1bMpxCII+FO6W6z
        iHDDdHIU0vjCq1S4pLHXMvZz3G6+QbypFnoOqVkPWKFigVAfSSueCE6tFPfworkML4qYCF
        sRdz8oQN672a259ekoxSKhxW/oDDmfo=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-376-cGZBUojANH-x8WJwVw0avg-1; Tue, 14 Feb 2023 10:54:21 -0500
X-MC-Unique: cGZBUojANH-x8WJwVw0avg-1
Received: by mail-io1-f70.google.com with SMTP id t185-20020a6bc3c2000000b00733ef3dabe3so10502031iof.14
        for <linux-s390@vger.kernel.org>; Tue, 14 Feb 2023 07:54:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xb46HmzYSch6mL85Mc29IUcDhw17TwDxuJ7aIajpOQI=;
        b=yGyL2BF0DWhHdBosnyLbRUcJ8qfou17DaGm01MeWgn9MvC7RJDJP+JoWPTMyZK95DT
         hfnuc2olVeN7Il7eStiJenRH+8/Qgjzlo5N/yygbkd6mh69Kpyl0Rlkf+qhJMW/i+NhD
         GOh9GFlhVvgKDaL1FmSuZ1NCtCTFJ5WwTNiyefRfmL2tjMZcN6OG7+VRBhNtdYywg/Ap
         /0wIMV+eVmUEAqvuNIWURdhyJM6RZxP5X5fkQ+zPNGqaGzfFQpXxhylEwVgQUwQcZaEI
         HkBTZ2TT8VeWx2Qvy2lMercs0FffjfNIjxcE5oACqrhpuEFOwqTM8+8Y1uwjvNoidCar
         m9sw==
X-Gm-Message-State: AO0yUKWiN+iWYBvQO/AYKMyG0hwIlL0Slj6iojTEiiB5z3yfQkN+uPgi
        bOht/YEapOGlUarRpe0ANO/VLpCn46uvDkhB5YwtIP5nj7ohpoMKFmPcBXW4P0BrzC4IgSBmk3z
        eRtnJW1B2/ZlE04VgvDeaqg==
X-Received: by 2002:a05:6e02:20e4:b0:314:f7f:a369 with SMTP id q4-20020a056e0220e400b003140f7fa369mr4046643ilv.11.1676390060694;
        Tue, 14 Feb 2023 07:54:20 -0800 (PST)
X-Google-Smtp-Source: AK7set+yb7BFh0lx0KigAZF0OwR9/57RngCfPYMxWA+ojxz0Hlv7JuDsuFBdGIHTFwUQVEMWcfb2KQ==
X-Received: by 2002:a05:6e02:20e4:b0:314:f7f:a369 with SMTP id q4-20020a056e0220e400b003140f7fa369mr4046617ilv.11.1676390060461;
        Tue, 14 Feb 2023 07:54:20 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id e10-20020a02a50a000000b003c4d64a4d10sm705354jam.4.2023.02.14.07.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:54:20 -0800 (PST)
Date:   Tue, 14 Feb 2023 08:54:19 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v3 00/15] Add vfio_device cdev for iommufd support
Message-ID: <20230214085419.4ac6d2c2.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB7529F0B20A73690C5650778BC3A29@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230213151348.56451-1-yi.l.liu@intel.com>
        <20230213124719.126eb828.alex.williamson@redhat.com>
        <Y+rGDeEMTB8FxjAH@nvidia.com>
        <DS0PR11MB7529F0B20A73690C5650778BC3A29@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 14 Feb 2023 15:15:28 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Jason Gunthorpe <jgg@nvidia.com>
> > Sent: Tuesday, February 14, 2023 7:22 AM
> > 
> > On Mon, Feb 13, 2023 at 12:47:19PM -0700, Alex Williamson wrote:
> >   
> > > I think it's too late for v6.3 already, but given this needs at least
> > > one more spin, let's set expectations of this being v6.4 material.  Thanks,  
> > 
> > Please let's continue to try to get this finished during the merge
> > window, all the other series depend on it. We can manage it with a
> > shared branch again..
> >   
> 
> Sure. I've updated the below branch to address Kevin's latest remarks.
> Fixed the compiling failure reported by Alex as well.
> 
> https://github.com/yiliu1765/iommufd/commits/vfio_device_cdev_v3


Sorry, I think this is an abuse of the merge window.  We have a new uAPI
proposal that's barely a week old and has no reviews or acks other than
Yi's, we have build configuration issues which suggests a lack of
testing, we're finding subtle implications to other existing uAPIs, and
nobody seems to have finished an upstream review, including me.

Code for the merge window should already be in maintainer trees by now,
the merge window should be for integration.  There are a lot of things
in flight and many more review comments coming in than we should see
for this to be a v6.3 candidate.  Thanks,

Alex

