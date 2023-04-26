Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A6AC7618E
	for <linux-s390@archiver.kernel.org>; Wed, 26 Apr 2023 13:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240983AbjDZNVN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 26 Apr 2023 09:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240864AbjDZNVM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 26 Apr 2023 09:21:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D13AA2
        for <linux-s390@vger.kernel.org>; Wed, 26 Apr 2023 06:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682515224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3tF50+FCEBA470O0m1Pz3/uU72DgfPgXqci+5b6Z6Us=;
        b=hTUQm9txUiL8QnN3F5ADFPh7bsJqv5X4+cZqB/p5uLZRudJy0+wepI4V+bu7lI3am/TSdJ
        09Z6a3wH0WRWLYHXH6XxJZhqMqppKgk2pCTANRLCOtr0coPSzLKBY9ukHWuPdx+oiSGqIP
        cvnmjCko9//OJtZXst07TvrVXj1P1Tw=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-pjhxSxyfNQCIUKyLxM7PZg-1; Wed, 26 Apr 2023 09:20:23 -0400
X-MC-Unique: pjhxSxyfNQCIUKyLxM7PZg-1
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-760ed929d24so1030974439f.2
        for <linux-s390@vger.kernel.org>; Wed, 26 Apr 2023 06:20:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682515222; x=1685107222;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tF50+FCEBA470O0m1Pz3/uU72DgfPgXqci+5b6Z6Us=;
        b=Pxa+gvq4EU46AQRmGaMtz05FB4LRGkybn++Q+ds0VkmydfSwA0NHDBDUonGYeJtKOl
         egwKIn9R/iQMiEKGqRjmVio7KMOZcM2OrBAwEa/bOblYR/NYIVoUXaCn7IRNDRCs6ma8
         gPgS7RfbQM/b0JqkZifMp1UT2KzowBbW7aEAi1yLTcKrwH4Vrzi8HKMl2aJShzmFU5XE
         /S+PrLk34YBWV0whJ75KAG7hxQbK5/j4+pcQd8jFitRuOtEapelc3r5lMnDFDmTyHi3O
         eYRZ/0iUDtaqb/pqQjFx5SpKZvExRBqIspyitC1Etb97P2BTtwzOfr67Ws1XcL0YuC1y
         meFQ==
X-Gm-Message-State: AAQBX9d4QydPGgFNUWOHjdQ0LDI3zBTHd6V0GNF2u5wtFqt1cDEppntN
        azcMugBQKYfsZk+vVcHTvV1CJ4WF/n44I3FyrQG0xQgpGUAM+bum3NgbYFNbeWxbd/RDCFjg8uk
        sfKNthWxPhlfPbEOnqOSiAw==
X-Received: by 2002:a5d:96c2:0:b0:763:6b5a:cb1e with SMTP id r2-20020a5d96c2000000b007636b5acb1emr9806279iol.10.1682515222505;
        Wed, 26 Apr 2023 06:20:22 -0700 (PDT)
X-Google-Smtp-Source: AKy350bVAxUZl+SaNxB4KtQp9lG5YMqf1m8i1/etdz67vKvzBfIWPiTagkhyoXG3sdYL8vcNxrib3g==
X-Received: by 2002:a5d:96c2:0:b0:763:6b5a:cb1e with SMTP id r2-20020a5d96c2000000b007636b5acb1emr9806258iol.10.1682515222228;
        Wed, 26 Apr 2023 06:20:22 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id h20-20020a5d9e14000000b0075d23c433efsm4465857ioh.29.2023.04.26.06.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 06:20:21 -0700 (PDT)
Date:   Wed, 26 Apr 2023 07:20:20 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
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
        "Jiang, Yanting" <yanting.jiang@intel.com>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v3 12/12] vfio/pci: Report dev_id in
 VFIO_DEVICE_GET_PCI_HOT_RESET_INFO
Message-ID: <20230426072020.62834ac6.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB75298CDC8108BA213243DBB8C3659@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <BN9PR11MB5276782DA56670C8209470828C989@BN9PR11MB5276.namprd11.prod.outlook.com>
        <ZDfslVwqk6JtPpyD@nvidia.com>
        <20230413120712.3b9bf42d.alex.williamson@redhat.com>
        <BN9PR11MB5276A160CA699933B897C8C18C999@BN9PR11MB5276.namprd11.prod.outlook.com>
        <DS0PR11MB7529B7481AC97261E12AA116C3999@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230414111043.40c15dde.alex.williamson@redhat.com>
        <DS0PR11MB75290A78D6879EC2E31E21AEC39C9@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230417130140.1b68082e.alex.williamson@redhat.com>
        <ZD2erN3nKbnyqei9@nvidia.com>
        <20230417140642.650fc165.alex.williamson@redhat.com>
        <ZD6TvA+9oI0v4vC2@nvidia.com>
        <20230418123920.5d92f402.alex.williamson@redhat.com>
        <DS0PR11MB7529C11E11F187D7BD88C18AC3639@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230420080839.652732dc.alex.williamson@redhat.com>
        <DS0PR11MB75298CDC8108BA213243DBB8C3659@DS0PR11MB7529.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 26 Apr 2023 07:22:17 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Thursday, April 20, 2023 10:09 PM  
> [...]
> > > > Whereas dev-id < 0
> > > > (== -1) is an affected device which prevents hot-reset, ex. an un-owned
> > > > device, device configured within a different iommufd_ctx, or device
> > > > opened outside of the vfio cdev API."  Is that about right?  Thanks,  
> > >
> > > Do you mean to have separate err-code for the three possibilities? As
> > > the devid is generated by iommufd and it is u32. I'm not sure if we can
> > > have such err-code definition without reserving some ids in iommufd.  
> > 
> > Yes, if we're going to report the full dev-set, I think we need at
> > least two unique error codes or else the user has no way to determine
> > the subset of invalid dev-ids which block the reset.  I think Jason is
> > proposing the set of valid dev-ids are >0, a dev-id of zero indicates
> > some form of non-blocking, while <0 (or maybe specifically -1)
> > indicates a blocking device.  I was trying to get consensus on a formal
> > definition of each of those error codes in my previous reply.  Thanks,  
> 
> Seems like RESETTABLE flag is not needed if we report -1 for the devices
> that block hotreset. Userspace can deduce if the calling device is resettable
> or not by checking if there is any -1 in the affected device list.

There is some redundancy there, yes.  Given the desire for a null array
on the actual reset ioctl I assumed there would also be a desire to
streamline the info ioctl such that userspace isn't required to parse
the return array, for example maybe userspace isn't required to pass a
full buffer and can get the reset availability status from only the
header.  Of course it's still the responsibility of userspace to know
the extent of the reset.  Thanks,

Alex

