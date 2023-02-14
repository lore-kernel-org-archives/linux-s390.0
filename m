Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA07C05027
	for <linux-s390@archiver.kernel.org>; Tue, 14 Feb 2023 23:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjBNXn0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Feb 2023 18:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbjBNXnZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Feb 2023 18:43:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374AA2CC55
        for <linux-s390@vger.kernel.org>; Tue, 14 Feb 2023 15:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676418160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUUIJ0cR3hLFYeEAbqlgShBHqdmwbGBdBl0fRIuzsMc=;
        b=Z9SSNNWJKoUPjdd9hdfPIVUjcS0whPujKZRcq6bvwiX8GbmhGrfrvjndNY/rtYdwckTVQl
        qFmiJxEMGnWdm1D8R/qcuCGTS09dbUQ0raKbGE83gwi6N87pmZu0oby6HOPeDYGSA/ypz9
        f1BItQSug1Hi5RrkMZ824UZeQp1rsec=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-658-Br_40SDrN4ulSv168egkRA-1; Tue, 14 Feb 2023 18:42:38 -0500
X-MC-Unique: Br_40SDrN4ulSv168egkRA-1
Received: by mail-il1-f198.google.com with SMTP id h7-20020a056e021d8700b0031532629b80so6446244ila.14
        for <linux-s390@vger.kernel.org>; Tue, 14 Feb 2023 15:42:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZUUIJ0cR3hLFYeEAbqlgShBHqdmwbGBdBl0fRIuzsMc=;
        b=hSubrnoYJacltB7/oow+AmWOG7VlIc+Mb1lxHqBUJsKvPCeMHGVloCw3d4iB6FX1dx
         IvlWxppTGAw9dsZBSIvNIVCpIL1eJDXtBgqP9MWQdrAdU/E0kY4hPBINPYAk4hi5G9z3
         UURLN+8hOt6aYhu1xyt+gWEkO5Sl4+HP+YU6OV6/ffQF5rj+C9A5B1NsE5l3WEPrkZUL
         1jE0ju11mbv44ykf2mBLdEXxbsdQ7f/VC1F4iwyt66XuhWGeYxtXzfAJvU9mqeIxj7II
         KDL11Kff/RLnJbXxI83Hs2QecQbHAG6L/OjWCgv3S8PRnimZDAv8tggPBuHzvb0TrFnn
         jA/w==
X-Gm-Message-State: AO0yUKURGl4Xu69IZDJIv+HvW1EcN/CPoe9canX5zCAST994uaYqyr0O
        gNUKkszEylvvUoE3Tw9HJaR64pWzn1CKZKOTiI7dTB/gSOUUjg8Nuq9JnFR+ZRtV0+Cyws6kKgH
        m6tMiRR0lMxJZSAenHbPZRw==
X-Received: by 2002:a05:6e02:1989:b0:311:66d:47aa with SMTP id g9-20020a056e02198900b00311066d47aamr486644ilf.26.1676418158125;
        Tue, 14 Feb 2023 15:42:38 -0800 (PST)
X-Google-Smtp-Source: AK7set+cnwaRu+xYLJYwKfQ18mKejRaIiksmj5ioXJ6on5Mp2TS8hLl7ygq6BKPlyKgT13iA1wicDA==
X-Received: by 2002:a05:6e02:1989:b0:311:66d:47aa with SMTP id g9-20020a056e02198900b00311066d47aamr486634ilf.26.1676418157875;
        Tue, 14 Feb 2023 15:42:37 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id b4-20020a02a584000000b003c4e8efcd09sm310027jam.32.2023.02.14.15.42.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 15:42:37 -0800 (PST)
Date:   Tue, 14 Feb 2023 16:42:35 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yi Liu <yi.l.liu@intel.com>, joro@8bytes.org, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 05/15] kvm/vfio: Accept vfio device file from
 userspace
Message-ID: <20230214164235.64e2dccb.alex.williamson@redhat.com>
In-Reply-To: <Y+wYX34sPvPQmGSr@nvidia.com>
References: <20230213151348.56451-1-yi.l.liu@intel.com>
        <20230213151348.56451-6-yi.l.liu@intel.com>
        <20230214152627.3a399523.alex.williamson@redhat.com>
        <Y+wYX34sPvPQmGSr@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 14 Feb 2023 19:25:19 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Feb 14, 2023 at 03:26:27PM -0700, Alex Williamson wrote:
> > > index 857d6ba349e1..d869913baafd 100644
> > > --- a/virt/kvm/vfio.c
> > > +++ b/virt/kvm/vfio.c
> > > @@ -286,18 +286,18 @@ static int kvm_vfio_set_file(struct kvm_device *dev, long attr,
> > >  	int32_t fd;
> > >  
> > >  	switch (attr) {
> > > -	case KVM_DEV_VFIO_GROUP_ADD:
> > > +	case KVM_DEV_VFIO_FILE_ADD:
> > >  		if (get_user(fd, argp))
> > >  			return -EFAULT;
> > >  		return kvm_vfio_file_add(dev, fd);
> > >  
> > > -	case KVM_DEV_VFIO_GROUP_DEL:
> > > +	case KVM_DEV_VFIO_FILE_DEL:
> > >  		if (get_user(fd, argp))
> > >  			return -EFAULT;
> > >  		return kvm_vfio_file_del(dev, fd);
> > >  
> > >  #ifdef CONFIG_SPAPR_TCE_IOMMU
> > > -	case KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE:
> > > +	case KVM_DEV_VFIO_FILE_SET_SPAPR_TCE:
> > >  		return kvm_vfio_file_set_spapr_tce(dev, arg);  
> > 
> > I don't see that the SPAPR code is so easily fungible to a device
> > file descriptor.  The kvm_vfio_spapr_tce data structure includes a
> > groupfd, which is required to match a groupfd on the file_list.  So
> > a SPAPR user cannot pass a cdev via FILE_ADD if they intend to use
> > this TCE code.  
> 
> SPAPR cannot use cdev at all, cdev mode only works with iommufd.
> 
> So with my other remark about blocking unbound cdevs, in SPAPR mode
> you can never open a cdev and make it bound thus
> kvm_vfio_file_iommu_group() and others will return NULL always for
> cdev.
> 
> Thus AFAICT this is all fine.

A device file opened through a group could be passed through this
interface though, right?  Do we just chalk that up to user error?
Maybe the SPAPR extension at least needs to be documented as relying on
registering groups rather than devices.
 
> Yi, you should also add some kconfig stuff to ensure that SPAPR always
> has the group interface compiled in.
> 
> > That also makes me wonder what we're really gaining in forcing this
> > generalization from group to file.    
> 
> I think it is just less code overall. Otherwise we need to needlessly
> double quite a lot of stuff, rather pointlessly, IMHO.
> 
> I'm still thinking about proposing to just delete all this SPAPR
> stuff. Power still hasn't had the patches applied to make it work
> again so it seems to all be dead.

There's been some off-list discussion about at least fixing SPAPR
support, but yes, it either needs to get some love or we ought to think
about its future.  Thanks,

Alex

