Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5AEC05027
	for <linux-s390@archiver.kernel.org>; Tue, 14 Feb 2023 15:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbjBNPsk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Feb 2023 10:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjBNPsj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Feb 2023 10:48:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371792BF37
        for <linux-s390@vger.kernel.org>; Tue, 14 Feb 2023 07:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676389648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dF8oAqlz95bIOcOVCAeaX6K0tlmtU+5fJeYgHw8uZHs=;
        b=ZBvEmKEPqPfdifMlSAAOBdxKCOp2T+yd2l4Qdzlb+QONbbzgzGmM9tx2SZPQwIuSbeO8An
        gzdNEOWbXmr7GaX6VzMaXa7WUj40XF2YmpxqfZHmygJJiU3Nq16TYT5BFwo8ZlgOIcp+iL
        6oQHEKwI+0tnF3t0AO0D7jhnhzKQcv4=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-642-TdboILboNQavQDjNLd_Gjw-1; Tue, 14 Feb 2023 10:47:24 -0500
X-MC-Unique: TdboILboNQavQDjNLd_Gjw-1
Received: by mail-il1-f197.google.com with SMTP id r8-20020a92cd88000000b00313f4759a73so11606017ilb.9
        for <linux-s390@vger.kernel.org>; Tue, 14 Feb 2023 07:47:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dF8oAqlz95bIOcOVCAeaX6K0tlmtU+5fJeYgHw8uZHs=;
        b=XH77qrWhmj5+D46QzHkQROk3BfG6P/IHTKHoBibkSUdK32CHJ5KaoiwtfvntxckrUH
         diC384u9dHLmlBnjHl1ufSXKa54vb6pnbCQJAuu//8o71MEahGcrJSE88ip+0AdMotcg
         gOW9Gp6bHPjN99ArYrhdDmwTEqqBxsjSqqdyftPOQ0PmGpMsY2Rfz5vvzLI8SsVSnwSi
         apuPey2mXcWb/SYfbzlwCTcos5I3psRUAeBagPFQtXBa7o6kT6mVqNaLANHZuXQKrmd8
         4pRsS+0sXYQz3fXZvQrlpsNF4OhCKTowF5lIfigXYQ0xpJLzbA2CL6gbCfWPw8b/KMsa
         iw3g==
X-Gm-Message-State: AO0yUKULJPsAx67ynijDa3QV7PG0negyGRfHMukrPvHEuzrtkL/Uf8pI
        LDNo/wv9uGsRdtA7DNrE0kMh/Dvf/KHwM1qdoNLnxLPDk4yrwAA96IEiQRjL2IBl/2PjeRm34f5
        LYo10S0Z8lcyh09iZFUqAEA==
X-Received: by 2002:a05:6e02:b46:b0:315:3fab:195b with SMTP id f6-20020a056e020b4600b003153fab195bmr3126997ilu.20.1676389643481;
        Tue, 14 Feb 2023 07:47:23 -0800 (PST)
X-Google-Smtp-Source: AK7set+QyPBpjyOP4beHC997KFQ4c9DMd5Kti6+9unU5tJWqfEML/h+K7BuEX21SBcHNYcHniWZAyw==
X-Received: by 2002:a05:6e02:b46:b0:315:3fab:195b with SMTP id f6-20020a056e020b4600b003153fab195bmr3126971ilu.20.1676389643222;
        Tue, 14 Feb 2023 07:47:23 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id t5-20020a02cca5000000b003b1f0afe484sm4930903jap.141.2023.02.14.07.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 07:47:22 -0800 (PST)
Date:   Tue, 14 Feb 2023 08:47:20 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     "joro@8bytes.org" <joro@8bytes.org>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
Message-ID: <20230214084720.74b3574e.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB75298788BCA03FD9513F991AC3A29@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230213151348.56451-1-yi.l.liu@intel.com>
        <20230213124719.126eb828.alex.williamson@redhat.com>
        <DS0PR11MB75298788BCA03FD9513F991AC3A29@DS0PR11MB7529.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 14 Feb 2023 01:55:17 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Tuesday, February 14, 2023 3:47 AM
> >=20
> > On Mon, 13 Feb 2023 07:13:33 -0800
> > Yi Liu <yi.l.liu@intel.com> wrote:
> >  =20
> > > Existing VFIO provides group-centric user APIs for userspace. Userspa=
ce
> > > opens the /dev/vfio/$group_id first before getting device fd and hence
> > > getting access to device. This is not the desired model for iommufd. =
Per
> > > the conclusion of community discussion[1], iommufd provides device- =
=20
> > centric =20
> > > kAPIs and requires its consumer (like VFIO) to be device-centric user
> > > APIs. Such user APIs are used to associate device with iommufd and al=
so
> > > the I/O address spaces managed by the iommufd.
> > >
> > > This series first introduces a per device file structure to be prepar=
ed
> > > for further enhancement and refactors the kvm-vfio code to be prepared
> > > for accepting device file from userspace. Then refactors the vfio to =
be
> > > able to handle iommufd binding. This refactor includes the mechanism =
of
> > > blocking device access before iommufd bind, making vfio_device_open()=
 =20
> > be =20
> > > exclusive between the group path and the cdev path. Eventually, adds =
the
> > > cdev support for vfio device, and makes group infrastructure optional=
 as
> > > it is not needed when vfio device cdev is compiled.
> > >
> > > This is also a prerequisite for iommu nesting for vfio device[2].
> > >
> > > The complete code can be found in below branch, simple test done with=
 =20
> > the =20
> > > legacy group path and the cdev path. Draft QEMU branch can be found =
=20
> > at[3] =20
> > >
> > > https://github.com/yiliu1765/iommufd/tree/vfio_device_cdev_v3
> > > (config CONFIG_IOMMUFD=3Dy CONFIG_VFIO_DEVICE_CDEV=3Dy) =20
> >=20
> > Even using your branch[1], it seems like this has not been tested
> > except with cdev support enabled:
> >=20
> > /home/alwillia/Work/linux.git/drivers/vfio/vfio_main.c: In function
> > =E2=80=98vfio_device_add=E2=80=99:
> > /home/alwillia/Work/linux.git/drivers/vfio/vfio_main.c:253:48: error: =
=E2=80=98struct
> > vfio_device=E2=80=99 has no member named =E2=80=98cdev=E2=80=99; did yo=
u mean =E2=80=98dev=E2=80=99?
> >   253 |                 ret =3D cdev_device_add(&device->cdev, &device-=
>device);
> >       |                                                ^~~~
> >       |                                                dev
> > /home/alwillia/Work/linux.git/drivers/vfio/vfio_main.c: In function
> > =E2=80=98vfio_device_del=E2=80=99:
> > /home/alwillia/Work/linux.git/drivers/vfio/vfio_main.c:262:42: error: =
=E2=80=98struct
> > vfio_device=E2=80=99 has no member named =E2=80=98cdev=E2=80=99; did yo=
u mean =E2=80=98dev=E2=80=99?
> >   262 |                 cdev_device_del(&device->cdev, &device->device);
> >       |                                          ^~~~
> >       |                                          dev =20
>=20
> Sorry for it. It is due to the cdev definition is under
> "#if IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV)". While, in the code it
> uses "if (IS_ENABLED(CONFIG_VFIO_DEVICE_CDEV))".  I think for
> readability, it would be better to always define cdev in vfio_device,
> and keep the using of cdev in code. How about your taste?

It seems necessary unless we want to litter the code with #ifdefs.

> > Additionally the VFIO_ENABLE_GROUP Kconfig option doesn't make much
> > sense to me, it seems entirely redundant to VFIO_GROUP. =20
>=20
> The intention is to make the group code compiling match existing case.
> Currently, if VFIO is configured, group code is by default compiled.
> So VFIO_ENABLE_GROUP a hidden option, and VFIO_GROUP an option
> for user.  User needs to explicitly config VFIO_GROUP if VFIO_DEVICE_CDEV=
=3D=3Dy.
> If VFIO_DEVICE_CDEV=3D=3Dn, then no matter user configed VFIO_GROUP or no=
t,
> the group code shall be compiled.

I understand the mechanics, I still find VFIO_ENABLE_GROUP redundant
and unnecessary.  Also, Kconfig should not allow a configuration
without either VFIO_GROUP or VFIO_DEVICE_CDEV as this is not
functional.  Deselecting VFIO_GROUP should select VFIO_DEVICE_CDEV, but
VFIO_DEVICE_CDEV should be an optional addition to VFIO_GROUP.  Thanks,

Alex

