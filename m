Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12114C76188
	for <linux-s390@archiver.kernel.org>; Wed,  5 Apr 2023 16:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbjDEQxL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 Apr 2023 12:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjDEQxJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 Apr 2023 12:53:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC353AAB
        for <linux-s390@vger.kernel.org>; Wed,  5 Apr 2023 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680713540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EB7/SSqRugBMOg+yS5JddA7JHRMlc+6bLSnv6uWfB7Q=;
        b=EDd/KFPi5iOgt/4FKy+c6N8fEIFa0ZWZpHGB+dzzTG/l4QI3oYfFRaNXrZOarb4Eqt2ku6
        5Sj81A/p9WdOZIllQjWfEESLdNgwpl6HPNzfAlXWAP/xNkvsQWU3OxSrScd7Og8aScuKSb
        MGK3t1bgfLxNysLszRHMu3DOQWE/4FM=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-9xh7KocvMDG4H5HkLjrrzw-1; Wed, 05 Apr 2023 12:52:18 -0400
X-MC-Unique: 9xh7KocvMDG4H5HkLjrrzw-1
Received: by mail-io1-f69.google.com with SMTP id v126-20020a6bac84000000b007587234a54cso22341901ioe.6
        for <linux-s390@vger.kernel.org>; Wed, 05 Apr 2023 09:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680713538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EB7/SSqRugBMOg+yS5JddA7JHRMlc+6bLSnv6uWfB7Q=;
        b=5T5sByT7bfo3jeatT4ES8+TWQ/peri4tT8iua1zOCQhdIHdSTTC8dXigg7qKRvkuvi
         PThmw+QIO1VmmayFsuGz5Wh3rtmy4TzWZ4Xte7K8ChYqeMOJkiwZsU1XOcI9bL4jfu2O
         028AxrHRNSt69e06XAjZBMARj0BWiZ0JPZD14RqJGmABV65LbxKFRBkc3j+CVQrWfA0B
         RcIEh5iCSJCzEykut+kJBgDpiSlXxvX6eqBeMH7PVse1HflEeAF6EPRl3Ide86xRfweE
         LyLd5185KKdW9/V16EaKIsFEWW5mscU82XYyMtwY9+fVsjIJuABPEKhHqq2eGsf4G7Mk
         Reqg==
X-Gm-Message-State: AAQBX9fKCCNjAvMJLkkoXgSx8v/SA0y7lk8c7cr/r92/h3HxEms4xnt8
        L866CPpJMeLMWAX5VOD1VCiu29AqCRqfxppA7YO98+73/nH+2YMA4oBTBCp9EgXzBPUXdPPMNXj
        WFs5wAmTsUrV3tw8pysra+A==
X-Received: by 2002:a5e:8f0d:0:b0:758:d81e:31b3 with SMTP id c13-20020a5e8f0d000000b00758d81e31b3mr5365226iok.19.1680713537881;
        Wed, 05 Apr 2023 09:52:17 -0700 (PDT)
X-Google-Smtp-Source: AKy350bE76z65MsjEi90EUqHhSdz/Ba8x+YHs3xVBowAybeX8RM8K+11AMUit3DvIcx7b80rO9J9wA==
X-Received: by 2002:a5e:8f0d:0:b0:758:d81e:31b3 with SMTP id c13-20020a5e8f0d000000b00758d81e31b3mr5365199iok.19.1680713537661;
        Wed, 05 Apr 2023 09:52:17 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id d187-20020a0262c4000000b003c2b76fcdf2sm1141357jac.52.2023.04.05.09.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 09:52:16 -0700 (PDT)
Date:   Wed, 5 Apr 2023 10:52:15 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
        "Jiang, Yanting" <yanting.jiang@intel.com>
Subject: Re: [PATCH v3 12/12] vfio/pci: Report dev_id in
 VFIO_DEVICE_GET_PCI_HOT_RESET_INFO
Message-ID: <20230405105215.428fa9f5.alex.williamson@redhat.com>
In-Reply-To: <ZC2jsQuWiMYM6JZb@nvidia.com>
References: <20230401144429.88673-1-yi.l.liu@intel.com>
        <20230401144429.88673-13-yi.l.liu@intel.com>
        <a937e622-ce32-6dda-d77c-7d8d76474ee0@redhat.com>
        <DS0PR11MB7529D4E354C3B85D7698017DC3909@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230405102545.41a61424.alex.williamson@redhat.com>
        <ZC2jsQuWiMYM6JZb@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 5 Apr 2023 13:37:05 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Apr 05, 2023 at 10:25:45AM -0600, Alex Williamson wrote:
> 
> > But that kind of brings to light the question of what does the user do
> > when they encounter this situation.  
> 
> What does it do now when it encounters a group_id it doesn't
> understand? Userspace already doesn't know if the foreign group is
> open or not, right?

It's simple, there is currently no screwiness around opened devices.
If the caller doesn't own all the groups mapping to the affected
devices, hot-reset is not available.

> > reset can complete.  If the device is opened by a different user, the
> > reset is blocked.  The only logical conclusion is that the user should
> > try the reset regardless of the result of the info ioctl, which the  
> 
> IMHO my suggested version is still the overall saner uAPI.
> 
> An info that basically returns success/fail if reset is security
> authorized and information about the reset groupings.
> 
> Actual reset follows the returned groupings automatically.
> 
> Easy for qemu. Call the info at startup to confirm reset can be
> emulated, use the returned information to propogate the reset groups
> to the guest. Trigger the reset with no fuss when the guest asks for
> it.
> 
> Less weird corner cases.

This leads to scenarios where the info ioctl indicates a hot-reset is
initially available, perhaps only because one of the affected devices
was not opened at the time, and now it fails when QEMU actually tries
to use it.  In the group model, QEMU can know the set of affected
devices and the required groups, confirm it owns those, and for all
practical purposes guarantee that a hot-reset is available (yes, there
might be some exceptionally rare topology changes).

This goofiness around unopened devices and null-arrays is killing this
API.  Thanks,

Alex

