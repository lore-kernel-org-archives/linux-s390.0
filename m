Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305CFC761AF
	for <linux-s390@archiver.kernel.org>; Tue, 28 Mar 2023 14:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjC1O0a (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 28 Mar 2023 10:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232777AbjC1O03 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 28 Mar 2023 10:26:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF9C8A4C
        for <linux-s390@vger.kernel.org>; Tue, 28 Mar 2023 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680013541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2++2bLilwQ5MSfsDHwIkCG9/5Hx9PPAC52PhhrFnL/U=;
        b=Kfyqo9Ej4WwwYX1VodPY9I93BVJcqDhGvbyI8f8eQWQy7UtJefEPSzGzsOvLyFaMspLGSp
        +OhlZYbcdtHBDi6JrdF/om2UVpoxMPrXstq86tuuo9Sxbzd8e5NRXUakwAM5ztwLS6DNxt
        Xy9oh2OY8oGo3I1os8nX3zfxD7/t3a0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-Zo08rcU0OqyWDVXYkSreHw-1; Tue, 28 Mar 2023 10:25:39 -0400
X-MC-Unique: Zo08rcU0OqyWDVXYkSreHw-1
Received: by mail-io1-f72.google.com with SMTP id i189-20020a6b3bc6000000b00758a1ed99c2so7624422ioa.1
        for <linux-s390@vger.kernel.org>; Tue, 28 Mar 2023 07:25:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680013539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2++2bLilwQ5MSfsDHwIkCG9/5Hx9PPAC52PhhrFnL/U=;
        b=dzZHjFQhpZAtHzkVWYOcRC/eY34IdWGZXvk9SOK8LWcnWX2SWogjEIQAwHIm6Tdqcp
         f77zrQleJrKoA6yJ0Mhpsd1UIwfWbEmEKuVB/6fLLjP9nupV6SAVBOn0VbNrEVx3Qh2T
         GU1ePXEKqmdenkzsFp9j1qGh/ypF5PN3+nUVJirxghg2qCQxuoBCnh7fNRKzzwWj7VND
         sF1fEFg1xoIbYkCJuKvv4zQZqavVdyiRkLqsQLBCJT84D+b/4siDe5Hi2W5HRSemKjY5
         7K7ODLkWlA5KIdZ165t0sqblbVKZv4xaHozINNc/Gh7QZ1m5Bx1t36QDP09TzZKuKifJ
         CLBw==
X-Gm-Message-State: AAQBX9fNqlW60uVPNJCah7yMs0l4jkBHPqYdapmZVNETyzqhMYKVA3Oy
        Tg+omSR5rjIYdmCYAKN1EdeyNlaVRhLt4D9lIKRaPXQf70rQN8jYXGpaZSEMp13iV35jnkwwkv3
        nvIlc4SgUR76csOPx8yCzKw==
X-Received: by 2002:a5e:a912:0:b0:759:8f29:2e81 with SMTP id c18-20020a5ea912000000b007598f292e81mr11418383iod.18.1680013539084;
        Tue, 28 Mar 2023 07:25:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZNhCzGUUWjFJZ/tLMMjP/R+0PL+tTwRVzFU+D9wh0XaE/b4kJwrSeWZYFILcywbWp9ECxP3g==
X-Received: by 2002:a5e:a912:0:b0:759:8f29:2e81 with SMTP id c18-20020a5ea912000000b007598f292e81mr11418363iod.18.1680013538832;
        Tue, 28 Mar 2023 07:25:38 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id p19-20020a056638217300b003c4eb5cb22csm9381348jak.134.2023.03.28.07.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 07:25:38 -0700 (PDT)
Date:   Tue, 28 Mar 2023 08:25:36 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
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
Subject: Re: [PATCH v2 10/10] vfio/pci: Add
 VFIO_DEVICE_GET_PCI_HOT_RESET_GROUP_INFO
Message-ID: <20230328082536.5400da67.alex.williamson@redhat.com>
In-Reply-To: <BL1PR11MB52717FB9E6D5C10BF4B7DA0A8C889@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20230327093458.44939-1-yi.l.liu@intel.com>
        <20230327093458.44939-11-yi.l.liu@intel.com>
        <20230327132619.5ab15440.alex.williamson@redhat.com>
        <DS0PR11MB7529E969C27995D535A24EC0C3889@DS0PR11MB7529.namprd11.prod.outlook.com>
        <BL1PR11MB52717FB9E6D5C10BF4B7DA0A8C889@BL1PR11MB5271.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 28 Mar 2023 06:19:06 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Tuesday, March 28, 2023 11:32 AM
> >   
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Tuesday, March 28, 2023 3:26 AM
> > >
> > > Additionally, VFIO_DEVICE_GET_PCI_HOT_RESET_INFO has a flags arg that
> > > isn't used, why do we need a new ioctl vs defining
> > > VFIO_PCI_HOT_RESET_FLAG_IOMMUFD_DEV_ID.  
> > 
> > Sure. I can follow this suggestion. BTW. I have a doubt here. This new flag
> > is set by user. What if in the future kernel has new extensions and needs
> > to report something new to the user and add new flags to tell user? Such
> > flag is set by kernel. Then the flags field may have two kinds of flags (some
> > set by user while some set by kernel). Will it mess up the flags space?
> >   
> 
> flags in a GET_INFO ioctl is for output.
> 
> if user needs to use flags as input to select different type of info then it should
> be split into multiple GET_INFO cmds.

I don't know that that's actually a rule, however we don't currently
test flags is zero for input, so in this case I think we are stuck with
it only being for output.

Alternatively, should VFIO_DEVICE_GET_PCI_HOT_RESET_INFO automatically
return the dev_id variant of the output and set a flag to indicate this
is the case when called on a device fd opened as a cdev?  Thanks,

Alex

