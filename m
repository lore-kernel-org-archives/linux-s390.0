Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CD3C76196
	for <linux-s390@archiver.kernel.org>; Mon,  3 Apr 2023 15:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232862AbjDCPdI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 Apr 2023 11:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjDCPdI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 Apr 2023 11:33:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A55410E7
        for <linux-s390@vger.kernel.org>; Mon,  3 Apr 2023 08:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680535942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mg/WY/5QTApvYEdExo6w0NW+ojlwZZElJz9ZdPVvAZI=;
        b=MKiTetGSveHEbZCKjQmPvuxzfqHCLD0j8CC9Mn8XhDncGAJ+1RyQn5QS86YCAWZNRrrWdf
        8t0MUgiwWolQRQTWGPMyImAyIQ22cPBmzCuFnTE7AN04Vdy3m5ZL/wtCGf2n5chedJZRwR
        fNlINGybg1u3SpysK/LJWLAwqs6dsys=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-14zIM4nbMbqUr-6eHt_XTg-1; Mon, 03 Apr 2023 11:32:21 -0400
X-MC-Unique: 14zIM4nbMbqUr-6eHt_XTg-1
Received: by mail-io1-f70.google.com with SMTP id c83-20020a6bb356000000b00758333e1ddfso18256666iof.14
        for <linux-s390@vger.kernel.org>; Mon, 03 Apr 2023 08:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680535940;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mg/WY/5QTApvYEdExo6w0NW+ojlwZZElJz9ZdPVvAZI=;
        b=wM/tWJRsOCtskvmMQfROr035/eYFdBmWpH9HhVy24WUp1Q1ylWe0EW1DS/71BdvcLV
         MozaqBmf5WrieTOtEw0pVgPCJGdO0UUCo89TCZ4U4QrHUfOoQiEfEvALTd2Ly801F7oo
         IQTIilQKhPl5iBak5VQVY6umwL6vGEN4wKR32l/N5fRV36CMSJu+U8eYxH/OriHVKHqF
         RNh9kFAGLzXgNCgsFB5D3S+DZgE/czdymZts3mEVdmCUNy/uJByjAKEodka+EvjvN+0z
         2s5RRDYYALd3z5NfyKDx/UiWebGjFB6uRudzkHbu1H0X8JaSyAJZZreV5YUvhy+0TX3y
         Dskg==
X-Gm-Message-State: AAQBX9cEXXJljdlMDVy8gWrl8O3FRPnKR2UgNCGiHoQBk7kdVNQ5MMPh
        ixI6ntxCo4DO+2hPDRK4zYbnLWodwST/VmiqtoaDUjDkbtYUkT06tlY4CsEKhZrfIDfu1jhwAvm
        D056irG+04L8w+r9253+fBQ==
X-Received: by 2002:a6b:7d03:0:b0:74c:e1a5:c5e3 with SMTP id c3-20020a6b7d03000000b0074ce1a5c5e3mr11053641ioq.0.1680535940485;
        Mon, 03 Apr 2023 08:32:20 -0700 (PDT)
X-Google-Smtp-Source: AKy350bXWtL5Bw8Ad/8Ov2pt5McA0ZU3giGQcsZasTbEv+jukxYVvdtKYYQhb5IUNd4UqwaLyXy2hA==
X-Received: by 2002:a6b:7d03:0:b0:74c:e1a5:c5e3 with SMTP id c3-20020a6b7d03000000b0074ce1a5c5e3mr11053599ioq.0.1680535940161;
        Mon, 03 Apr 2023 08:32:20 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id q20-20020a5ea614000000b0075c47fb539asm2681451ioi.0.2023.04.03.08.32.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 08:32:19 -0700 (PDT)
Date:   Mon, 3 Apr 2023 09:32:18 -0600
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
Subject: Re: [PATCH v3 12/12] vfio/pci: Report dev_id in
 VFIO_DEVICE_GET_PCI_HOT_RESET_INFO
Message-ID: <20230403093218.04e79d32.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB7529A380EF7E3F33C5DCEE3EC3929@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230401144429.88673-1-yi.l.liu@intel.com>
        <20230401144429.88673-13-yi.l.liu@intel.com>
        <DS0PR11MB752996A6E6B3263BAD01DAC2C3929@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230403090151.4cb2158c.alex.williamson@redhat.com>
        <DS0PR11MB7529A380EF7E3F33C5DCEE3EC3929@DS0PR11MB7529.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 3 Apr 2023 15:22:03 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Monday, April 3, 2023 11:02 PM
> >=20
> > On Mon, 3 Apr 2023 09:25:06 +0000
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> >  =20
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Saturday, April 1, 2023 10:44 PM =20
> > > =20
> > > > @@ -791,7 +813,21 @@ static int vfio_pci_fill_devs(struct pci_dev *=
pdev, void =20
> > *data) =20
> > > >  	if (!iommu_group)
> > > >  		return -EPERM; /* Cannot reset non-isolated devices */ =20
> > >
> > > Hi Alex,
> > >
> > > Is disabling iommu a sane way to test vfio noiommu mode? =20
> >=20
> > Yes
> >  =20
> > > I added intel_iommu=3Doff to disable intel iommu and bind a device to=
 vfio-pci.
> > > I can see the /dev/vfio/noiommu-0 and /dev/vfio/devices/noiommu-vfio0=
. Bind
> > > iommufd=3D=3D-1 can succeed, but failed to get hot reset info due to =
the above
> > > group check. Reason is that this happens to have some affected device=
s, and
> > > these devices have no valid iommu_group (because they are not bound t=
o vfio-pci
> > > hence nobody allocates noiommu group for them). So when hot reset inf=
o loops
> > > such devices, it failed with -EPERM. Is this expected? =20
> >=20
> > Hmm, I didn't recall that we put in such a limitation, but given the
> > minimally intrusive approach to no-iommu and the fact that we never
> > defined an invalid group ID to return to the user, it makes sense that
> > we just blocked the ioctl for no-iommu use.  I guess we can do the same
> > for no-iommu cdev. =20
>=20
> sure.
>=20
> >=20
> > BTW, what does this series apply on?  I'm assuming[1], but I don't see
> > a branch from Jason yet.  Thanks, =20
>=20
> yes, this series is applied on [1]. I put the [1], this series and cdev s=
eries
> in https://github.com/yiliu1765/iommufd/commits/vfio_device_cdev_v9.
>=20
> Jason has taken [1] in the below branch. It is based on rc1. So I hesitat=
ed
> to apply this series and cdev series on top of it. Maybe I should have do=
ne
> it to make life easier. =F0=9F=98=8A
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/jgg/iommufd.git/log/?h=3D=
for-next

Seems like it must be in the vfio_mdev_ops branch which has not been
pushed aside from the merge back to for-next.  Jason?  Thanks,

Alex

