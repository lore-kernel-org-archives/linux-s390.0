Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D00C636D4
	for <linux-s390@archiver.kernel.org>; Wed, 15 Feb 2023 15:33:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjBOPdq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 15 Feb 2023 10:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjBOPdo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Feb 2023 10:33:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19735B74C
        for <linux-s390@vger.kernel.org>; Wed, 15 Feb 2023 07:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676475175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dh5NdUXXqt2OwKe+bgzJIjOdCZFOJ5LseD3HaKSZilk=;
        b=G53A1fVcvM26uCR+fG1z4mMjzKdlBB6YLraf1bLVI6+roQiUkKC5W2F5PKIg7a+XlCttY7
        bg2kTiXcVgBIWdXHpLU62I8wInK13OhjhOLDQ8yABZ/G3W6qJ77Ncn5w9Ffr2zFvYuz6fz
        qf/QrIW3xBF7ASKoHfLevh+HBSDDJXo=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-377-vFTGa8clN1qrfVY1Od8hzg-1; Wed, 15 Feb 2023 10:32:44 -0500
X-MC-Unique: vFTGa8clN1qrfVY1Od8hzg-1
Received: by mail-il1-f200.google.com with SMTP id q3-20020a056e02096300b003157134a9fbso1009931ilt.2
        for <linux-s390@vger.kernel.org>; Wed, 15 Feb 2023 07:32:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dh5NdUXXqt2OwKe+bgzJIjOdCZFOJ5LseD3HaKSZilk=;
        b=p6u+XIsKE/FEdqtPJvdKGes4zSy+5GHnuFu6DQscZ6iJTJ0V+rEhF+GBsS4cHaD96x
         EgH/7XauXgKawKB2SonmoFptHFbqHE56cuC6d3ZIU3t0Fz6fHmPeBmAYjjA9WE9/iC+m
         vpNZ+HNUu3xRbUzSkR6lVxVt569XGgU18X8KFXrqPsDUg6WEHTY/jEBUPbLDijlSp9uC
         Ns5ULYwls3+XQJWNBs3hgnLMfs/xmc0BIyOT+MMqdBjcxqxifzk8HQaV/xBsqspo85RQ
         ttEWqmTjGLj1jF/2uSq/S7kcOBj4yyQJYtTMFYtu+jQcP2X8t83hbyl6NFDUG1J8a/3l
         NhJg==
X-Gm-Message-State: AO0yUKWqnDgW4Y0aNe5Fv0O4tGLyMExDvoNVPt/xCGuM3+1Eg5cBcXhx
        RfDbtnUohIEp08UGTadk6SEo06uDJ/oNIEKyEr2eK+t7hIal7SE0jqwy99OxjRO55oErisElQSO
        xI/hgeBGIMGoeX49EKxjDfg==
X-Received: by 2002:a05:6e02:180a:b0:315:3036:4da with SMTP id a10-20020a056e02180a00b00315303604damr2903337ilv.30.1676475157561;
        Wed, 15 Feb 2023 07:32:37 -0800 (PST)
X-Google-Smtp-Source: AK7set9dYhmZ8agTRUin0PWV3DETcyMYPO5GFEHe0t1hXDUe9MWRtba6M7F5v8HJtVUnNqr1Vxo/uA==
X-Received: by 2002:a05:6e02:180a:b0:315:3036:4da with SMTP id a10-20020a056e02180a00b00315303604damr2903310ilv.30.1676475157275;
        Wed, 15 Feb 2023 07:32:37 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id u6-20020a02aa86000000b0038a822f87c3sm5723739jai.159.2023.02.15.07.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 07:32:36 -0800 (PST)
Date:   Wed, 15 Feb 2023 08:32:34 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
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
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 03/15] vfio: Accept vfio device file in the driver
 facing kAPI
Message-ID: <20230215083234.194d07a9.alex.williamson@redhat.com>
In-Reply-To: <Y+zwSn63eA7HrefO@nvidia.com>
References: <20230213151348.56451-1-yi.l.liu@intel.com>
        <20230213151348.56451-4-yi.l.liu@intel.com>
        <Y+rLKvCMivND0izd@nvidia.com>
        <DS0PR11MB7529B43C7D357D8A0C2438C7C3A29@DS0PR11MB7529.namprd11.prod.outlook.com>
        <Y+zSRklKkL3rc2FB@nvidia.com>
        <DS0PR11MB75299F5D92AAC33FD8690694C3A39@DS0PR11MB7529.namprd11.prod.outlook.com>
        <Y+zwSn63eA7HrefO@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

[Cc +Paolo]

On Wed, 15 Feb 2023 10:46:34 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Feb 15, 2023 at 02:43:20PM +0000, Liu, Yi L wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, February 15, 2023 8:39 PM
> > > 
> > > On Tue, Feb 14, 2023 at 02:02:37AM +0000, Liu, Yi L wrote:  
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Tuesday, February 14, 2023 7:44 AM
> > > > >
> > > > > On Mon, Feb 13, 2023 at 07:13:36AM -0800, Yi Liu wrote:  
> > > > > > +static struct vfio_device *vfio_device_from_file(struct file *file)
> > > > > > +{
> > > > > > +	struct vfio_device_file *df = file->private_data;
> > > > > > +
> > > > > > +	if (file->f_op != &vfio_device_fops)
> > > > > > +		return NULL;
> > > > > > +	return df->device;
> > > > > > +}
> > > > > > +
> > > > > >  /**
> > > > > >   * vfio_file_is_valid - True if the file is usable with VFIO APIS
> > > > > >   * @file: VFIO group file or VFIO device file
> > > > > >   */
> > > > > >  bool vfio_file_is_valid(struct file *file)
> > > > > >  {
> > > > > > -	return vfio_group_from_file(file);
> > > > > > +	return vfio_group_from_file(file) ||
> > > > > > +	       vfio_device_from_file(file);
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(vfio_file_is_valid);  
> > > > >
> > > > > This can only succeed on a device cdev that has been fully opened.  
> > > >
> > > > Actually, we cannot. This is used in the kvm-vfio code to see if the
> > > > user-provided fd is vfio fds in the SET_KVM path. And we don't
> > > > have the device cdev fully opened until BIND_IOMMUFD. But we do
> > > > need to invoke SET_KVM before issuing BIND_IOMMUFD as the device
> > > > open needs kvm pointer. So if we cannot apply fully opened limit to this
> > > > interface. Maybe an updated function comment is needed.  
> > > 
> > > This also seems sketchy, KVM is using the VFIO fd as a "proof" to
> > > enable the wbinvd stuff. A half opened cdev should not be used as that
> > > proof.  
> > 
> > From this angle, the group path seems has the same concern. Device is not
> > opened until VFIO_GROUP_GET_DEVICE_FD.   
> 
> Well, classically the device was DMA ownership claimed at least.
> 
> > But group path has one advantage, which make it ok. Group can only be
> > opened by one application. So once it is opened, the devices within the
> > group are somehow obtained by the application until group fd close.  
> 
> It depends on what do we want the KVM proof to actually mean.
> 
> Is simply having permissions on the cdev node sufficient proof for
> wbinvd?
> 
> I admit I poorly understand the threat model for this in kvm beyond
> that kvm doesn't want everyone to use wbinvd.

We've discussed this with Paolo before and I believe the bar of proof
is not very high.  I suspect it's not a problem that the device itself
is not yet accessible, so long as the user can prove they have the
ability to access the device, such as access to a restricted file.  In
most cases this isn't going to turn on wbinvd anyway since DMA will be
coherent.  Thanks,

Alex

