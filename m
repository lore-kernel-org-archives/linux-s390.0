Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B389C38141
	for <linux-s390@archiver.kernel.org>; Fri, 20 Jan 2023 15:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjATPu3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjATPu2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 Jan 2023 10:50:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD56EBB88
        for <linux-s390@vger.kernel.org>; Fri, 20 Jan 2023 07:49:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674229779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aavit6jM1lC6qQPOxTCnu44ZFH15mB1QS8MkjGvi8Yk=;
        b=OIyf9x007f+182VJm9PhxmgxjP+2JjOXDPTkzRsj09DO9udjSH9pB8YxkGp2UqSpaPZKG2
        BIUXgABYxVmB488Eie9wrC6IsndGzxScm0O/GebNZjM88eMPaE26Nf/ZOIMolE7SrJLBWK
        X2T6k73815S3QE7YV7DUyimtTgbpyu4=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-98-EPq3VCKMOdiWmji8tnIH5g-1; Fri, 20 Jan 2023 10:49:37 -0500
X-MC-Unique: EPq3VCKMOdiWmji8tnIH5g-1
Received: by mail-io1-f71.google.com with SMTP id b21-20020a5d8d95000000b006fa39fbb94eso3094745ioj.17
        for <linux-s390@vger.kernel.org>; Fri, 20 Jan 2023 07:49:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aavit6jM1lC6qQPOxTCnu44ZFH15mB1QS8MkjGvi8Yk=;
        b=1JnSShhDlRXAXCbqDD+4xUTIJMRcR61/kFQkSpA0GPsDSgedhS7SW1yH0NfiRQOMS0
         HWt+UyYcIX+Ttt8Tr+w1GJ7sfQ4wzZf7BKYtXePw5p5WHYNAMFlMn6yn9L4vChnC6FnV
         YtUezzQCwAq8cjdACF/EeXZNSsSMeFGunthT+KNnoiPFBzeq0+BPeGEw6se16UuLzZar
         2dxvDlDqWnnE8o/A5B39BO4rmf71WyZsckHQP9uuYfvrConXUWBTn8Jks4qXiSPC5YSu
         y3DWdzK9pb9INlz6brmLsRR96tOAvn8hQDRQ784Xlaa3Ja4OGRIizxRjn60bZJAbyxLj
         FAUg==
X-Gm-Message-State: AFqh2krw6od/t9bqsNZB/uMONiqZy/n6lgvAQz+B/9Y00BHrqheWKTRH
        BJSD5AmhxcTlIrnzv4O8tD+ImVemIU6h/RViz8aDThTK/9XgQ++XEkc6iyutnPx5yYdr0eqWirU
        /kqK0h9QFlbIqEkWOazVhsA==
X-Received: by 2002:a05:6e02:cc6:b0:30f:3dfe:c670 with SMTP id c6-20020a056e020cc600b0030f3dfec670mr4626048ilj.25.1674229776950;
        Fri, 20 Jan 2023 07:49:36 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsF7uAHGgInj7PstAuuh+H1lLdGiBCat5fhmmcQKX6OvgOleEUrY91pvtEjqx5EjFLwygLnnw==
X-Received: by 2002:a05:6e02:cc6:b0:30f:3dfe:c670 with SMTP id c6-20020a056e020cc600b0030f3dfec670mr4626033ilj.25.1674229776663;
        Fri, 20 Jan 2023 07:49:36 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z18-20020a92d192000000b0030c0217dde6sm851618ilz.0.2023.01.20.07.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:49:36 -0800 (PST)
Date:   Fri, 20 Jan 2023 08:49:33 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "jgg@nvidia.com" <jgg@nvidia.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
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
        "Christopherson, , Sean" <seanjc@google.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kvm/vfio: Fix potential deadlock on vfio group_lock
Message-ID: <20230120084933.40f59c89.alex.williamson@redhat.com>
In-Reply-To: <6eff63d8-d825-aecd-12b5-e8dbf55f4372@linux.ibm.com>
References: <20230120150528.471752-1-yi.l.liu@intel.com>
        <DS0PR11MB7529B08476DF1764F1B6C007C3C59@DS0PR11MB7529.namprd11.prod.outlook.com>
        <6eff63d8-d825-aecd-12b5-e8dbf55f4372@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 20 Jan 2023 10:45:40 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 1/20/23 10:08 AM, Liu, Yi L wrote:
> >> From: Liu, Yi L <yi.l.liu@intel.com>
> >> Sent: Friday, January 20, 2023 11:05 PM
> >>
> >> Currently it is possible that the final put of a KVM reference comes from
> >> vfio during its device close operation.  This occurs while the vfio group
> >> lock is held; however, if the vfio device is still in the kvm device list,
> >> then the following call chain could result in a deadlock:
> >>
> >> VFIO holds group->group_lock/group_rwsem  
> >>   -> kvm_put_kvm
> >>    -> kvm_destroy_vm
> >>     -> kvm_destroy_devices
> >>      -> kvm_vfio_destroy
> >>       -> kvm_vfio_file_set_kvm
> >>        -> vfio_file_set_kvm
> >>         -> try to hold group->group_lock/group_rwsem  
> >>
> >> The key function is the kvm_destroy_devices() which triggers destroy cb
> >> of kvm_device_ops. It calls back to vfio and try to hold group_lock. So
> >> if this path doesn't call back to vfio, this dead lock would be fixed.
> >> Actually, there is a way for it. KVM provides another point to free the
> >> kvm-vfio device which is the point when the device file descriptor is
> >> closed. This can be achieved by providing the release cb instead of the
> >> destroy cb. Also rename kvm_vfio_destroy() to be kvm_vfio_release().
> >>
> >> 	/*
> >> 	 * Destroy is responsible for freeing dev.
> >> 	 *
> >> 	 * Destroy may be called before or after destructors are called
> >> 	 * on emulated I/O regions, depending on whether a reference is
> >> 	 * held by a vcpu or other kvm component that gets destroyed
> >> 	 * after the emulated I/O.
> >> 	 */
> >> 	void (*destroy)(struct kvm_device *dev);
> >>
> >> 	/*
> >> 	 * Release is an alternative method to free the device. It is
> >> 	 * called when the device file descriptor is closed. Once
> >> 	 * release is called, the destroy method will not be called
> >> 	 * anymore as the device is removed from the device list of
> >> 	 * the VM. kvm->lock is held.
> >> 	 */
> >> 	void (*release)(struct kvm_device *dev);
> >>
> >> Fixes: 421cfe6596f6 ("vfio: remove VFIO_GROUP_NOTIFY_SET_KVM")
> >> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> >> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> >> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> >> Signed-off-by: Yi Liu <yi.l.liu@intel.com>  
> > 
> > More background can be found in Mathew's work.
> > https://lore.kernel.org/kvm/20230114000351.115444-1-mjrosato@linux.ibm.com/T/#u
> >   
> 
> Thanks Yi.
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> One small nit:  There is a comment at the very end of
> kvm_vfio_release on the kfree(dev) that still references .destroy,
> this should be updated to .release

I've fixed this locally, s/destroy/release/ in that comment.  Thanks,

Alex

