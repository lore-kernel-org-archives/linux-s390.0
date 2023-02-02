Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D98C636D3
	for <linux-s390@archiver.kernel.org>; Thu,  2 Feb 2023 23:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjBBXOG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Feb 2023 18:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbjBBXOC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Feb 2023 18:14:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE0C9646A9
        for <linux-s390@vger.kernel.org>; Thu,  2 Feb 2023 15:13:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675379594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4glrkB5ql6wUNYPNiI941jzqAV8teJiRbBLj9H6Yjs8=;
        b=LkIZrreL2Vues13ia9yzGaAVFVhVh+j2CZc/JCccQj6AP+4xRJU/3KmWdvSyZhcHMba7oc
        ujA2F56c2wLmz30RfnfF8urqfmZq2n8rV3Ku1FgLo69C0OXNISnmwl4D9t8DSj6k9LQSS4
        9APKKLGtYKuB4MYGBYxtbi7j/a3tl4U=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-636-v5YOIStdP7qKciLL4B7npg-1; Thu, 02 Feb 2023 18:13:10 -0500
X-MC-Unique: v5YOIStdP7qKciLL4B7npg-1
Received: by mail-il1-f200.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso2221644ilj.17
        for <linux-s390@vger.kernel.org>; Thu, 02 Feb 2023 15:13:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4glrkB5ql6wUNYPNiI941jzqAV8teJiRbBLj9H6Yjs8=;
        b=oeSCHP1h9/iUd9vaRpTqUPv+7uZoT0XRv7W+c248DJA3yeXAM78M9mqMqng7EuGDlz
         PCgzpiGlNlmIwnrGKxeKGIPRa/yg9cDyfo5hL6BxsGxB52t1jEnHYHI9TPQxO4Nn84CH
         e7XqfCV4w7AFbM34JatZqo+l0eDEZQOk0OToU/hxr6SCgngDgpPIcn+GYpZ7c6VdZ//h
         vsqWsO+OfxfzwI8I4bxYYVISzcg219JRNGGcHgAEL9eGRJ6HoiknhG1fdyZuj5sQ4lU4
         BNWaK/pbjkBrw2K3NaP1aGzTmBK3piSV1jWns25jlcI722WgszMnAzC19IKWQCI1Tv8+
         8gng==
X-Gm-Message-State: AO0yUKXmfS+j+Mh6ewsLkbY2p7RcgozaFcUaD7jqxeKyLP8RyPYutREQ
        oSrHwy54P/Ea7BSNlQD5xrm9SNoWZW3yrurV+zFLgC5kpHcb+dQKu2Ntz84RrI4Eg376waUbF9q
        36x8La8y0OtBkxhEHFfJFlw==
X-Received: by 2002:a5e:8e04:0:b0:71f:2e0b:5c64 with SMTP id a4-20020a5e8e04000000b0071f2e0b5c64mr5453134ion.3.1675379590188;
        Thu, 02 Feb 2023 15:13:10 -0800 (PST)
X-Google-Smtp-Source: AK7set+b8pGPR77dGbU4qatHthpYCAIMQpARtX1qQ/2j2i7HMF8A+n6jNFbLyHBhEg+B3kM57ThseA==
X-Received: by 2002:a5e:8e04:0:b0:71f:2e0b:5c64 with SMTP id a4-20020a5e8e04000000b0071f2e0b5c64mr5453113ion.3.1675379589952;
        Thu, 02 Feb 2023 15:13:09 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id i30-20020a056638381e00b003bc39fc7505sm197983jav.62.2023.02.02.15.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 15:13:09 -0800 (PST)
Date:   Thu, 2 Feb 2023 16:13:07 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     "Tian, Kevin" <kevin.tian@intel.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>,
        "pmorel@linux.ibm.com" <pmorel@linux.ibm.com>,
        "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
        "frankja@linux.ibm.com" <frankja@linux.ibm.com>,
        "imbrenda@linux.ibm.com" <imbrenda@linux.ibm.com>,
        "david@redhat.com" <david@redhat.com>,
        "akrowiak@linux.ibm.com" <akrowiak@linux.ibm.com>,
        "jjherne@linux.ibm.com" <jjherne@linux.ibm.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        "Wang, Zhi A" <zhi.a.wang@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] vfio: fix deadlock between group lock and kvm lock
Message-ID: <20230202161307.0c6aa23e.alex.williamson@redhat.com>
In-Reply-To: <BN9PR11MB527618E281BEB8E479ABB0418CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20230202162442.78216-1-mjrosato@linux.ibm.com>
        <20230202124210.476adaf8.alex.williamson@redhat.com>
        <BN9PR11MB527618E281BEB8E479ABB0418CD69@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 2 Feb 2023 23:04:10 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Friday, February 3, 2023 3:42 AM
> > 
> > On Thu,  2 Feb 2023 11:24:42 -0500
> > Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> >   
> > > After 51cdc8bc120e, we have another deadlock scenario between the
> > > kvm->lock and the vfio group_lock with two different codepaths acquiring
> > > the locks in different order.  Specifically in vfio_open_device, vfio
> > > holds the vfio group_lock when issuing device->ops->open_device but  
> > some  
> > > drivers (like vfio-ap) need to acquire kvm->lock during their open_device
> > > routine;  Meanwhile, kvm_vfio_release will acquire the kvm->lock first
> > > before calling vfio_file_set_kvm which will acquire the vfio group_lock.
> > >
> > > To resolve this, let's remove the need for the vfio group_lock from the
> > > kvm_vfio_release codepath.  This is done by introducing a new spinlock to
> > > protect modifications to the vfio group kvm pointer, and acquiring a kvm
> > > ref from within vfio while holding this spinlock, with the reference held
> > > until the last close for the device in question.
> > >
> > > Fixes: 51cdc8bc120e ("kvm/vfio: Fix potential deadlock on vfio group_lock")
> > > Reported-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> > > Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> > > Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > > ---
> > > Changes from v2:
> > > * Relocate the new functions back to vfio_main and externalize to call
> > >   from group (Kevin) since cdev will need this too
> > > * s/vfio_kvm_*_kvm/vfio_device_*_kvm/ and only pass device as input.
> > >   Handle new kvm_ref_lock directly inside vfio_device_get_kvm (Alex)
> > > * Add assert_lockdep_held for dev_set lock (Alex)
> > > * Internalize error paths for vfio_device_get_kvm_safe and now return
> > >   void - either device->kvm is set with a ref taken or is NULL (Alex)
> > > * Other flow suggestions to make the call path cleaner - Thanks! (Alex)
> > > * Can't pass group->kvm to vfio_device_open, as it references the value
> > >   outside of new lock.  Pass device->kvm to minimize changes in this
> > >   fix (Alex, Yi)
> > > Changes from v1:
> > > * use spin_lock instead of spin_lock_irqsave (Jason)
> > > * clear device->kvm_put as part of vfio_kvm_put_kvm (Yi)
> > > * Re-arrange code to avoid referencing the group contents from within
> > >   vfio_main (Kevin) which meant moving most of the code in this patch
> > >   to group.c along with getting/dropping of the dev_set lock
> > > ---
> > >  drivers/vfio/group.c     | 32 ++++++++++++++----
> > >  drivers/vfio/vfio.h      | 14 ++++++++
> > >  drivers/vfio/vfio_main.c | 70 ++++++++++++++++++++++++++++++++++++--  
> > --  
> > >  include/linux/vfio.h     |  2 +-
> > >  4 files changed, 103 insertions(+), 15 deletions(-)  
> > 
> > LGTM.  I'm not sure moving the functions to vfio_main really buys us
> > anything since we're making so much use of group fields.  The cdev
> > approach will necessarily be different, so the bulk of the get code will
> > likely need to move back to group.c anyway.
> >   
> 
> well my last comment was based on Matthew's v2 where the get code
> gets a kvm passed in instead of implicitly retrieving group ref_lock
> internally. In that case the get/put helpers only contain device logic
> thus fit in vfio_main.c.
> 
> with v3 then they have to be in group.c since we don't want to use
> group fields in vfio_main.c.
> 
> but I still think v2 of the helpers is slightly better. The only difference
> between cdev and group when handling this race is using different
> ref_lock. the symbol get/put part is exactly same. So even if we
> merge v3 like this, very likely Yi has to change it back to v2 style
> to share the get/put helpers while just leaving the ref_lock part
> handled differently between the two path.

I'm not really a fan of the asymmetry of the v2 version where the get
helper needs to be called under the new kvm_ref_lock, but the put
helper does not.  Having the get helper handle that makes the caller
much cleaner.  Thanks,

Alex

