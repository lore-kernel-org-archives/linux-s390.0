Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D16C77B78
	for <linux-s390@archiver.kernel.org>; Tue, 18 Apr 2023 16:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjDRQun (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 Apr 2023 12:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjDRQum (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 18 Apr 2023 12:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30FE7DC
        for <linux-s390@vger.kernel.org>; Tue, 18 Apr 2023 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681836597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QW4OejsqAutNiGQJiYZJkfIFG7vwNJbOHeoSgw01y+o=;
        b=fGTF8JJCwXReaYEtOX9mTBoMQKRroGh4FHXoL2s0r4S2DbZOr5lWQgB22uZZqbTkhcuPMi
        fPOa6MB2Sm/j+fwZqWrCCN+A4HY79KcU/I0jvg+ofM5DJ0ij22Rd5x+HER2MDg8U6RVkwM
        idNfMZo3pII0uPKGmdYUy437usU5Kw4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-ZjZYa9AfNQiTfw7SCuYf9A-1; Tue, 18 Apr 2023 12:49:56 -0400
X-MC-Unique: ZjZYa9AfNQiTfw7SCuYf9A-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-32addcf3a73so95183065ab.0
        for <linux-s390@vger.kernel.org>; Tue, 18 Apr 2023 09:49:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681836595; x=1684428595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QW4OejsqAutNiGQJiYZJkfIFG7vwNJbOHeoSgw01y+o=;
        b=Ju0u2UjNv8UuJ6tF16OWyu/+GdF3/usZ8/QwdLHf90+4/qHB3VrePzIDSDQ4QWn6La
         jfA8+z0iAlcAVveRoCR3ZJ0gkRa1iRhAqksp/Awj9PIfK8mXlYAIaDArLHmTQsJdZ37+
         SWUQToF64tG1gE9wlSzW15EzscyaYwHLj/RAJRtMun2oN+eiB0kojHwMX+fFLb0SdCg4
         TpkTZsvHxqOZdeUASbLv+0vFH6KeN88frFnrUS6EgHVY8tiJha+86fsp1X2uO4BrK+WE
         fZxvXnaaeQ9iH7Izkb3T4VAb2SadpwsTf7lSK92xcP9lIq13/HIfDScvljVO5irugUgB
         n3bA==
X-Gm-Message-State: AAQBX9fG/lI3oOqedoG+kiCGMpBplZERWoUsTRWQtiQlxoeiaXxdhodv
        nswcE70+arHmBofABQmQTNE1NQIYnof+P4yu4dkUjNk6jB5h6ogxIJB1eWI6qdirZFg0E9aWwmv
        srFeAdFgUaEsOKkTngvpQUg==
X-Received: by 2002:a6b:1452:0:b0:760:e776:18c0 with SMTP id 79-20020a6b1452000000b00760e77618c0mr2235544iou.9.1681836595276;
        Tue, 18 Apr 2023 09:49:55 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZVsgHFq5DkfTVjZLoX8ZDscMPn0l0IcDwaF7P4VYcMS0dy9AZqf3xGlcdGUdzNLu695Of27Q==
X-Received: by 2002:a6b:1452:0:b0:760:e776:18c0 with SMTP id 79-20020a6b1452000000b00760e77618c0mr2235519iou.9.1681836594980;
        Tue, 18 Apr 2023 09:49:54 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id ay29-20020a056638411d00b003c5170ddcedsm4254803jab.110.2023.04.18.09.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 09:49:54 -0700 (PDT)
Date:   Tue, 18 Apr 2023 10:49:53 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
Message-ID: <20230418104953.28cfe9cb.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB7529F0992BD2C5CAC1BEA088C39D9@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230412105045.79adc83d.alex.williamson@redhat.com>
        <ZDcPTTPlni/Mi6p3@nvidia.com>
        <BN9PR11MB5276782DA56670C8209470828C989@BN9PR11MB5276.namprd11.prod.outlook.com>
        <ZDfslVwqk6JtPpyD@nvidia.com>
        <20230413120712.3b9bf42d.alex.williamson@redhat.com>
        <BN9PR11MB5276A160CA699933B897C8C18C999@BN9PR11MB5276.namprd11.prod.outlook.com>
        <DS0PR11MB7529B7481AC97261E12AA116C3999@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230414111043.40c15dde.alex.williamson@redhat.com>
        <DS0PR11MB75290A78D6879EC2E31E21AEC39C9@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230417130140.1b68082e.alex.williamson@redhat.com>
        <ZD2erN3nKbnyqei9@nvidia.com>
        <20230417140642.650fc165.alex.williamson@redhat.com>
        <BN9PR11MB5276D93DDFE3ED97CD1B923B8C9D9@BN9PR11MB5276.namprd11.prod.outlook.com>
        <20230417221033.778c00c9.alex.williamson@redhat.com>
        <DS0PR11MB7529F0992BD2C5CAC1BEA088C39D9@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 18 Apr 2023 10:34:45 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Tuesday, April 18, 2023 12:11 PM
> >   
> [...]
> >
> > We haven't discussed how it fails when called on a group-opened device
> > in a mixed environment.  I'd propose that the INFO ioctl behaves
> > exactly as it does today, reporting group-id and BDF for each affected
> > device.  However, the hot-reset ioctl itself is not extended to accept
> > devicefd because there is no proof-of-ownership model for cdevs.
> > Therefore even if the user could map group-id to devicefd, they get
> > -EINVAL calling HOT_RESET with a devicefd when the ioctl is called from
> > a group-opened device.  Thanks,  
> 
> Will it be better to let userspace know it shall fail if invoking hot
> reset due to no proof-of-ownership as it also has cdev devices? Maybe
> the RESETTABLE flag should always be meaningful. Even if the calling
> device of _INFO is group-opened device. Old user applications does not
> need to check it as it will never have such mixed environment. But for
> new applications or the applications that have been updated per latest
> vfio uapi, it should strictly check this flag before going ahead to do
> hot-reset.

The group-opened model cannot consistently predict whether the user can
provide proof-of-ownership.  I don't think we should define a flag
simply because there's a case that we can predict, the definition of
that flag becomes problematic.  Let's not complicate the interface by
trying to optimize a case that will likely never exist in practice and
can be handled via the existing legacy API.  Thanks,

Alex

