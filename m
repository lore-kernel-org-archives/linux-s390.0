Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA6BC636CC
	for <linux-s390@archiver.kernel.org>; Mon, 13 Feb 2023 19:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjBMTsL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 13 Feb 2023 14:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBMTsK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 13 Feb 2023 14:48:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143F32723
        for <linux-s390@vger.kernel.org>; Mon, 13 Feb 2023 11:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676317644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jukjE54rA/NniTDMWLMlEUTdm+2tzCyGjiSO2l2TjQQ=;
        b=PA45mwcFJE2PmFLCfpjIweuYKqzN1cIV8stL+NTmX2HolzPDjPip9MqZNr+90SZxBEguqB
        cwAk3QjeaiMQx5s4pFWwu4Hx6DdFnHfhjNQYrIo1v2Ui+vqIGm6pvwh+Q/+hmIHgAB4L8I
        xgbR7nlKVPSPXZAFOrOyKMDWGTHhz9Q=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-UBnGzbxQNASMMA9fAULruA-1; Mon, 13 Feb 2023 14:47:23 -0500
X-MC-Unique: UBnGzbxQNASMMA9fAULruA-1
Received: by mail-il1-f200.google.com with SMTP id c16-20020a92b750000000b003154f6c5064so1377764ilm.12
        for <linux-s390@vger.kernel.org>; Mon, 13 Feb 2023 11:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jukjE54rA/NniTDMWLMlEUTdm+2tzCyGjiSO2l2TjQQ=;
        b=wa3g14UW92k3U+kt4yU82WJ8fB+zpByldsjLgf3KoacmwMhyLIHQz7CeLH9kxRv8Wk
         srUgeAu7THWwcxLPYj9NGNaN6kxahfqq/d4gH/0KmAtjDO5F5SW900x6nR5LuSkjo+fI
         2er4ysJakjQBibAwLXPKWkiIy0e9h2nnCenoKoZDbCOwsWS0drvxoUB+B7myEiyWwOcy
         FowpSpZOT6WXHpb91mR2/RMI4Y0vB96I0lig234SgXo9cbBCrkh4F1zztzG2kjmlq84o
         S0J7bEopCIfi8CNJTW5YFZqcbiNwC+R9yN5CrSGlBRFUQ+f260T/ChaREwuq4COcB9zc
         zLLw==
X-Gm-Message-State: AO0yUKWKRDMZ0U6ogAEvWhJgXm0KVvc4lMsIAVMRfIl6SjLnYAiXBWAK
        dT3aKFxX+3Yrw1pwCGGMn2fl5Cg3zSfP/upQHEkAPfyh5LjRj0zQdMt1yzkTd4hUbgaYmF2Ki7h
        CkHD6T75Yqvj54QBT6C0TQg==
X-Received: by 2002:a05:6e02:184d:b0:315:475c:5cfb with SMTP id b13-20020a056e02184d00b00315475c5cfbmr4365702ilv.2.1676317642478;
        Mon, 13 Feb 2023 11:47:22 -0800 (PST)
X-Google-Smtp-Source: AK7set+a3j5BS/mB6OljGhyF1TwNBaNZHDWgm8ontm8ZGuY3WL3AC4gQHk2dSPBwbafrr/9Ovuk7+A==
X-Received: by 2002:a05:6e02:184d:b0:315:475c:5cfb with SMTP id b13-20020a056e02184d00b00315475c5cfbmr4365682ilv.2.1676317642188;
        Mon, 13 Feb 2023 11:47:22 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id g15-20020a92dd8f000000b00313f2279f06sm4010881iln.73.2023.02.13.11.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 11:47:21 -0800 (PST)
Date:   Mon, 13 Feb 2023 12:47:19 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     joro@8bytes.org, jgg@nvidia.com, kevin.tian@intel.com,
        robin.murphy@arm.com, cohuck@redhat.com, eric.auger@redhat.com,
        nicolinc@nvidia.com, kvm@vger.kernel.org, mjrosato@linux.ibm.com,
        chao.p.peng@linux.intel.com, yi.y.sun@linux.intel.com,
        peterx@redhat.com, jasowang@redhat.com,
        shameerali.kolothum.thodi@huawei.com, lulu@redhat.com,
        suravee.suthikulpanit@amd.com, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 00/15] Add vfio_device cdev for iommufd support
Message-ID: <20230213124719.126eb828.alex.williamson@redhat.com>
In-Reply-To: <20230213151348.56451-1-yi.l.liu@intel.com>
References: <20230213151348.56451-1-yi.l.liu@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 13 Feb 2023 07:13:33 -0800
Yi Liu <yi.l.liu@intel.com> wrote:

> Existing VFIO provides group-centric user APIs for userspace. Userspace
> opens the /dev/vfio/$group_id first before getting device fd and hence
> getting access to device. This is not the desired model for iommufd. Per
> the conclusion of community discussion[1], iommufd provides device-centric
> kAPIs and requires its consumer (like VFIO) to be device-centric user
> APIs. Such user APIs are used to associate device with iommufd and also
> the I/O address spaces managed by the iommufd.
>=20
> This series first introduces a per device file structure to be prepared
> for further enhancement and refactors the kvm-vfio code to be prepared
> for accepting device file from userspace. Then refactors the vfio to be
> able to handle iommufd binding. This refactor includes the mechanism of
> blocking device access before iommufd bind, making vfio_device_open() be
> exclusive between the group path and the cdev path. Eventually, adds the
> cdev support for vfio device, and makes group infrastructure optional as
> it is not needed when vfio device cdev is compiled.
>=20
> This is also a prerequisite for iommu nesting for vfio device[2].
>=20
> The complete code can be found in below branch, simple test done with the
> legacy group path and the cdev path. Draft QEMU branch can be found at[3]
>=20
> https://github.com/yiliu1765/iommufd/tree/vfio_device_cdev_v3
> (config CONFIG_IOMMUFD=3Dy CONFIG_VFIO_DEVICE_CDEV=3Dy)

Even using your branch[1], it seems like this has not been tested
except with cdev support enabled:

/home/alwillia/Work/linux.git/drivers/vfio/vfio_main.c: In function =E2=80=
=98vfio_device_add=E2=80=99:
/home/alwillia/Work/linux.git/drivers/vfio/vfio_main.c:253:48: error: =E2=
=80=98struct vfio_device=E2=80=99 has no member named =E2=80=98cdev=E2=80=
=99; did you mean =E2=80=98dev=E2=80=99?
  253 |                 ret =3D cdev_device_add(&device->cdev, &device->dev=
ice);
      |                                                ^~~~
      |                                                dev
/home/alwillia/Work/linux.git/drivers/vfio/vfio_main.c: In function =E2=80=
=98vfio_device_del=E2=80=99:
/home/alwillia/Work/linux.git/drivers/vfio/vfio_main.c:262:42: error: =E2=
=80=98struct vfio_device=E2=80=99 has no member named =E2=80=98cdev=E2=80=
=99; did you mean =E2=80=98dev=E2=80=99?
  262 |                 cdev_device_del(&device->cdev, &device->device);
      |                                          ^~~~
      |                                          dev

Additionally the VFIO_ENABLE_GROUP Kconfig option doesn't make much
sense to me, it seems entirely redundant to VFIO_GROUP.

I think it's too late for v6.3 already, but given this needs at least
one more spin, let's set expectations of this being v6.4 material.  Thanks,

Alex

[1] 98491da60ae1 cover-letter: Add vfio_device cdev for iommufd support

