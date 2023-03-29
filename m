Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A772EC6FD18
	for <linux-s390@archiver.kernel.org>; Wed, 29 Mar 2023 15:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjC2Puk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 29 Mar 2023 11:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjC2Pub (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 29 Mar 2023 11:50:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BAB4487
        for <linux-s390@vger.kernel.org>; Wed, 29 Mar 2023 08:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680104989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hP1XBMM0doEA+LEJ78VJjS+VLo2jAysv8Y016r4ZnnY=;
        b=SPUuPbQKIxt/SsHMeVQq6+AaExhiQes6d+CzAtEUBfD0irMSNvi1phHyHw7uGYso78beU6
        ZjIVQYQH06OojJYKJDfiMQRlbAdgJrEC2PnBOYJBcsQEmJYKiQd8jbzgNxbtZK6Qu3yPAe
        vITdYjx+T+jZK32c1SREOTU46ShBzHw=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-294-bDkX3ecqONqWpzES_HYNFA-1; Wed, 29 Mar 2023 11:49:48 -0400
X-MC-Unique: bDkX3ecqONqWpzES_HYNFA-1
Received: by mail-io1-f71.google.com with SMTP id r25-20020a056602235900b0074d472df653so9592492iot.2
        for <linux-s390@vger.kernel.org>; Wed, 29 Mar 2023 08:49:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680104987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hP1XBMM0doEA+LEJ78VJjS+VLo2jAysv8Y016r4ZnnY=;
        b=6njCzBy8S+U/5wXffWihjN7Okx7CRWZW+Kdcm2uiW1B3FNolLGZ56KqWADHVxs6tqP
         H0DPiIZtduV/VXlnCUu/YSlkxQKTAbNiKzum1/snPVe1M9VLCilOO8laOXGVPNkC0heI
         Y2OslFdZDe4K1VBi/TpswAHum8N+dcthuGBoLGK0xFu/LE/KiHUQpLB+TM8NPaWi59xf
         pPvfzXblkVDtwjkInYK//GfYgqgvxF+4gRK6anB3e6IpGAkyaKnFGN+Xb8B1JfISHp5B
         JlsLOSacsHnwbcrukbIQk+2vu94b5xd/xv5hIhJvHyJhZAX3Fv+ubCImGzYHuWkJebF4
         Dwsg==
X-Gm-Message-State: AAQBX9dRVuZp0J9mm+vBfOrHylpMGWwN6R694YnC65RMbTIvl7Gb/Rjh
        gvWOUgRdJFF4AHGW3/bsqwIvyrR+sDJa8aLeqBllBUCRqlRaIwHebfVsRrCN/AiUkP9ckY27//U
        zwtjKBhXgZc4Fcpez4xsAqA==
X-Received: by 2002:a92:c743:0:b0:326:2902:e7d9 with SMTP id y3-20020a92c743000000b003262902e7d9mr2178951ilp.7.1680104987692;
        Wed, 29 Mar 2023 08:49:47 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZSyu7j44X/rupYZlbiuoYiWibGVg929WRZpz3ftBxDYQY1mBTe8lVgtKaDoJrTKTZsWHhhjA==
X-Received: by 2002:a92:c743:0:b0:326:2902:e7d9 with SMTP id y3-20020a92c743000000b003262902e7d9mr2178916ilp.7.1680104987361;
        Wed, 29 Mar 2023 08:49:47 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id n4-20020a056638110400b00400d715c57dsm10708357jal.29.2023.03.29.08.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:49:46 -0700 (PDT)
Date:   Wed, 29 Mar 2023 09:49:44 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
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
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Hao, Xudong" <xudong.hao@intel.com>,
        "Zhao, Yan Y" <yan.y.zhao@intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        "Jiang, Yanting" <yanting.jiang@intel.com>
Subject: Re: [PATCH v2 10/10] vfio/pci: Add
 VFIO_DEVICE_GET_PCI_HOT_RESET_GROUP_INFO
Message-ID: <20230329094944.50abde4e.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB52762E789B9C1D8021F54ECC8C899@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230327093458.44939-1-yi.l.liu@intel.com>
        <20230327093458.44939-11-yi.l.liu@intel.com>
        <20230327132619.5ab15440.alex.williamson@redhat.com>
        <DS0PR11MB7529E969C27995D535A24EC0C3889@DS0PR11MB7529.namprd11.prod.outlook.com>
        <BL1PR11MB52717FB9E6D5C10BF4B7DA0A8C889@BL1PR11MB5271.namprd11.prod.outlook.com>
        <20230328082536.5400da67.alex.williamson@redhat.com>
        <DS0PR11MB7529B6782565BE8489D922F9C3889@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230328084616.3361a293.alex.williamson@redhat.com>
        <DS0PR11MB75290B84D334FC726A8BBA95C3889@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230328091801.13de042a.alex.williamson@redhat.com>
        <DS0PR11MB752903CE3D5906FE21146364C3889@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230328100027.3b843b91.alex.williamson@redhat.com>
        <DS0PR11MB7529C12E086DAB619FF9AFF0C3899@DS0PR11MB7529.namprd11.prod.outlook.com>
        <BN9PR11MB52762E789B9C1D8021F54ECC8C899@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 29 Mar 2023 09:41:26 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Wednesday, March 29, 2023 11:14 AM
> >   
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Wednesday, March 29, 2023 12:00 AM
> > >
> > >
> > > Personally I don't like the suggestion to fail with -EPERM if the user
> > > doesn't own all the affected devices.  This isn't a "probe if I can do
> > > a reset" ioctl, it's a "provide information about the devices affected
> > > by a reset to know how to call the hot-reset ioctl".  We're returning
> > > the bdf to the cdev version of this ioctl for exactly this debugging
> > > purpose when the devices are not owned, that becomes useless if we give
> > > up an return -EPERM if ownership doesn't align.  
> > 
> > Jason's suggestion makes sense for returning the case of returning dev_id
> > as dev_id is local to iommufd. If there are devices in the same dev_set are
> > opened by multiple users, multiple iommufd would be used. Then the
> > dev_id would have overlap. e.g. a dev_set has three devices. Device A and
> > B are opened by the current user as cdev, dev_id #1 and #2 are generated.
> > While device C opened by another user as cdev, dev_id #n is generated for
> > it. If dev_id #n happens to be #1, then user gets two info entries that have
> > the same dev_id.
> >   
> 
> In Alex's proposal you'll set a invalid dev_id for device C so the user can
> still get the info for diagnostic purpose instead of seeing an -EPERM error.

Yes, we shouldn't be reporting dev_ids outside of the user's iommufd
context.

> btw I found an open about fd pass scheme which may affect the choice here.
> 
> In concept even with cdev we still expect the userspace to maintain the
> group knowledge so it won't inadvertently attempt to assign devices in
> the same group to different IOAS's. It also needs such knowledge when
> constructing guest topology.
> 
> with fd passed in Qemu has no way to associate the fd to a group.

Hmm, QEMU tries to get the group for the device address space in the
guest, so finding an existing group with a different address space
indeed allows QEMU to know of this conflict since the group is the
fundamental unit IOMMU context in the legacy vfio model.

> We could extend bind_iommufd to return the group id or introduce a
> new ioctl to query it per dev_id.

That would be ironic to go to all this trouble to remove groups from
the API only to have them show up here.  But with a cdev interface,
don't we break that model of conflating isolation and address-ability?

For example, devices within a group cannot be bound to separate
iommufds due to lack of isolation, which is handled via DMA ownership,
but barring DMA aliasing issues, due to conventional PCI buses or
quirks, cdev could allow devices within the same group to be managed by
separate IOAS's.  So the group information really isn't enough for
userspace to infer address space restrictions with cdev anyway.

Therefore aren't we expecting this to be denied at attach_ioas() and
QEMU shouldn't be making these sorts of assumptions for cdev anyway?
Thanks,

Alex

