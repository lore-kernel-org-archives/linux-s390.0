Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BF3C7EE22
	for <linux-s390@archiver.kernel.org>; Mon,  8 May 2023 20:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjEHUat (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 8 May 2023 16:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjEHUar (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 May 2023 16:30:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656BC49C0
        for <linux-s390@vger.kernel.org>; Mon,  8 May 2023 13:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683577800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DVSAqbGo/SYymxziE0Ynvj5CJeQ8fOYfiV63Ae36Jlg=;
        b=bM5H0eGR46f0jKa43Nz2pTJkQF977G7kuTlbrXX2uuB+iWLfGJkhAFy53lg4ds2Qo8iZST
        eCLRuH6TupFa8UqC0VNrSR5rVnQH9/sTEAHsSdargY6K0z0qFm/0GJEhsRshJDsF8TFkzE
        rYX4WYxxKhzLuPKJLjxVEO721D88to8=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-wT-sJhz_OzqxiCFS4NQaUQ-1; Mon, 08 May 2023 16:29:59 -0400
X-MC-Unique: wT-sJhz_OzqxiCFS4NQaUQ-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-333d90b1a43so51949815ab.1
        for <linux-s390@vger.kernel.org>; Mon, 08 May 2023 13:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683577798; x=1686169798;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DVSAqbGo/SYymxziE0Ynvj5CJeQ8fOYfiV63Ae36Jlg=;
        b=fttxe9G+G0OHi2c71p4+9nHBGCWZ5mhzcB3JZWkqiE5CasZ0prx4y0ZL+0nC7LSTfg
         JSwAOv9NEV/jAXiIxdSTMf1XBWhetGDLeL2l1CnR4qxw8xDM2RsJvTEZJjqR68GbH4Eh
         L+2xQ8XhoCcYfm3jU41jn2OYwRgQeHy8HAzNVZDLu+6UIInqRPgINtC1XoYN0786dPO7
         Cm+v1oVeKJW44XNEQbwtxWcqScDZ+EPlCYrjGmJDbU81woBXkhMW5jWSL9bxLAq3iK1+
         YWR5aWT8s4T576Q2gdS6rjAM5pJqmb00qZIOw2F8ivfrqVDDN9RcOlAmD782YLC5loeh
         wrbA==
X-Gm-Message-State: AC+VfDwah1BzgkZJ02y7lYLFcNlTOkTU/+Ar+Hd2OwDnZGwi710P32Vk
        fmTvH6dMWdIgw4JTng6mt/vZHXkZrL4TpwK2QetMa8GesmkETmArByDNsMF4BzwtR8fsAR61MD0
        BJ5CBMEP4I7SNiRSiXAc6/Q==
X-Received: by 2002:a92:d403:0:b0:326:3a39:89d0 with SMTP id q3-20020a92d403000000b003263a3989d0mr8107218ilm.1.1683577798625;
        Mon, 08 May 2023 13:29:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7DrZnriZETaQ/90S6mqc6FkPi+6no4KK3rwJGM0g691+Xcp+XCrkWFWkbvezVgZkHdFJFtOw==
X-Received: by 2002:a92:d403:0:b0:326:3a39:89d0 with SMTP id q3-20020a92d403000000b003263a3989d0mr8107209ilm.1.1683577798310;
        Mon, 08 May 2023 13:29:58 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id l2-20020a056e0205c200b00334faa50484sm1915883ils.54.2023.05.08.13.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 13:29:57 -0700 (PDT)
Date:   Mon, 8 May 2023 14:29:55 -0600
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
        "Jiang, Yanting" <yanting.jiang@intel.com>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
Subject: Re: [PATCH v4 8/9] vfio/pci: Extend
 VFIO_DEVICE_GET_PCI_HOT_RESET_INFO for vfio device cdev
Message-ID: <20230508142955.44566026.alex.williamson@redhat.com>
In-Reply-To: <DS0PR11MB75295210DA7C4C2896D1FB6DC3719@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230426145419.450922-1-yi.l.liu@intel.com>
        <20230426145419.450922-9-yi.l.liu@intel.com>
        <20230427140405.2afe27d4.alex.williamson@redhat.com>
        <20230427141533.7d8861ed.alex.williamson@redhat.com>
        <DS0PR11MB75295210DA7C4C2896D1FB6DC3719@DS0PR11MB7529.namprd11.prod.outlook.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 8 May 2023 15:32:44 +0000
"Liu, Yi L" <yi.l.liu@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Friday, April 28, 2023 4:16 AM
> >  
> > > > + *
> > > >   * Return: 0 on success, -errno on failure:
> > > >   *	-enospc = insufficient buffer, -enodev = unsupported for device.
> > > >   */
> > > >  struct vfio_pci_dependent_device {
> > > > -	__u32	group_id;
> > > > +	union {
> > > > +		__u32   group_id;
> > > > +		__u32	dev_id;
> > > > +#define VFIO_PCI_DEVID_NONBLOCKING	0
> > > > +#define VFIO_PCI_DEVID_BLOCKING	-1  
> > >
> > > The above description seems like it's leaning towards OWNED rather than
> > > BLOCKING.  
> > 
> > Also these should be defined relative to something defined in IOMMUFD
> > rather than inventing values here.  We can't have the valid devid
> > number space owned by IOMMUFD conflict with these definitions.  Thanks,  
> 
> Jason has proposed to reserve all negative IDs and 0 in iommufd. In that case,
> can vfio define the numbers now?

Ok, as long as it's guaranteed that we're overlapping invalid dev-ids,
as specified by IOMMUFD, then the mapping of specific invalid dev-ids
to error values here is interface specific and can be defined here.
Thanks,

Alex

