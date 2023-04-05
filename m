Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFFBC7619A
	for <linux-s390@archiver.kernel.org>; Wed,  5 Apr 2023 15:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238893AbjDEPQg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Apr 2023 11:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238551AbjDEPQQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Apr 2023 11:16:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7E3729C
        for <linux-s390@vger.kernel.org>; Wed,  5 Apr 2023 08:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680707598;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HHZ/jIzCBVCjw8Sv1KUUo+r8mPEiPRUgi3mJO20sEiE=;
        b=JiSUBkw7ZO+xJC48EM+PVyoLj/zhXJSR/uq8nUbZXvPAuwdFBMUjsqdqpi+DJs8eMqBelu
        J1/mr5sA2kKXXQ+GnrinjuP82m8MpK74tEetYFz6TCCs6Y0cfb+7GM4N6NesREQArrhU2Q
        yEe7AYYLyWkcRrTRlPdtcbr7rbq6h6w=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-JZL2-UDQNI2gbjf06h-_cQ-1; Wed, 05 Apr 2023 11:13:16 -0400
X-MC-Unique: JZL2-UDQNI2gbjf06h-_cQ-1
Received: by mail-io1-f72.google.com with SMTP id b2-20020a6bcb02000000b0075e09ef5a2eso8308784iog.13
        for <linux-s390@vger.kernel.org>; Wed, 05 Apr 2023 08:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680707595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HHZ/jIzCBVCjw8Sv1KUUo+r8mPEiPRUgi3mJO20sEiE=;
        b=wHNNixB1w/AZW6lqAkx50hXtwHsybnsdF2O8E6vr/QePrkbDvfpS67H721bKSVByOg
         +dz21KjgkwynsB0mA1qnAsVyCGkzeBsVasJJHGkuSABi080JPTPdLXQjW6aW1njdkAxF
         9oH22KqXFTOMADuHdjfPp8BNmcyKM/OhRSKvzCOXCYcYmM3YyxyPNLwcHxeYiRNYM+hY
         cqRM39f4u8A3g/kMG6gRLhL4AKZyywWS+2qTV0GWEw+In5oNMFW5N7LhxFqCYdH+a0mH
         yP0Jv1BD1FHS4CuEhDjLeHOYm7a/5ZYGLzb5wS+sKfzEswGyx2DEGn5husmI65sYo7jc
         5fkg==
X-Gm-Message-State: AAQBX9eV1qvElpqe8H1d+2yd0cWn3xGbaCVjUEX/EXQESmkqlUsC7z4Q
        XMk7jWaWEjJPDVy4DZ9n1krSiMFKM8F6V2L5U4nMumvCearS/hGtFJsE7kSxwfzrhCLHemZbzmC
        K9OB9DTydvlKJkE/n28xtQg==
X-Received: by 2002:a92:dd04:0:b0:326:1fb2:40c4 with SMTP id n4-20020a92dd04000000b003261fb240c4mr5004304ilm.23.1680707595591;
        Wed, 05 Apr 2023 08:13:15 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZP1bpPm4WhRQrqOqZKR50zNpeviNu90Bjdp+q5pCVln3oaoFR9YOzr1ahR+dQPp+xRvGH4tQ==
X-Received: by 2002:a92:dd04:0:b0:326:1fb2:40c4 with SMTP id n4-20020a92dd04000000b003261fb240c4mr5004271ilm.23.1680707595338;
        Wed, 05 Apr 2023 08:13:15 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q10-20020a027b0a000000b00406496ef3dcsm4195746jac.49.2023.04.05.08.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 08:13:14 -0700 (PDT)
Date:   Wed, 5 Apr 2023 09:13:12 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
Subject: Re: [PATCH v3 11/12] iommufd: Define IOMMUFD_INVALID_ID in uapi
Message-ID: <20230405091312.6e9dbae0.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB752985764A642C7B12436C53C3909@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230401144429.88673-1-yi.l.liu@intel.com>
        <20230401144429.88673-12-yi.l.liu@intel.com>
        <20230404150034.312fbcac.alex.williamson@redhat.com>
        <DS0PR11MB752985764A642C7B12436C53C3909@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 5 Apr 2023 09:31:39 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Wednesday, April 5, 2023 5:01 AM
> > 
> > On Sat,  1 Apr 2023 07:44:28 -0700
> > Yi Liu <yi.l.liu@intel.com> wrote:
> >   
> > > as there are IOMMUFD users that want to know check if an ID generated
> > > by IOMMUFD is valid or not. e.g. vfio-pci optionaly returns invalid
> > > dev_id to user in the VFIO_DEVICE_GET_PCI_HOT_RESET_INFO ioctl. User
> > > needs to check if the ID is valid or not.
> > >
> > > IOMMUFD_INVALID_ID is defined as 0 since the IDs generated by IOMMUFD
> > > starts from 0.
> > >
> > > Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> > > ---
> > >  include/uapi/linux/iommufd.h | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> > > index 98ebba80cfa1..aeae73a93833 100644
> > > --- a/include/uapi/linux/iommufd.h
> > > +++ b/include/uapi/linux/iommufd.h
> > > @@ -9,6 +9,9 @@
> > >
> > >  #define IOMMUFD_TYPE (';')
> > >
> > > +/* IDs allocated by IOMMUFD starts from 0 */
> > > +#define IOMMUFD_INVALID_ID 0
> > > +
> > >  /**
> > >   * DOC: General ioctl format
> > >   *  
> > 
> > If allocation "starts from 0" then 0 is a valid id, no?  Does allocation
> > start from 1, ie. skip 0?  Thanks,  
> 
> yes, it starts from 1, that's why we can use 0 as invalid id.

So the comment is wrong, correct?

