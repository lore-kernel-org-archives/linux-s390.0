Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC32EC05027
	for <linux-s390@archiver.kernel.org>; Fri, 20 Jan 2023 17:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjATR7j (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 20 Jan 2023 12:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjATR7i (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 20 Jan 2023 12:59:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0E1C459F
        for <linux-s390@vger.kernel.org>; Fri, 20 Jan 2023 09:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674237525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WmRfpj48RyjRyZDGGPZo2d8kT+rAwJ1anTjm2/PHafk=;
        b=N3pAtpq1qahNIplH1WsCyr53HKiHunwll0Yl/UOzMveZI0gtQZxrpdG/2Pashl2HrWI1qw
        PQ0cKvRm1zc5J7u/dleygCITexJeoVJPjtrbvod2GiB6cIf0Ub+wkBLRZ8FTcwBdplszQQ
        9/gj2nQOMdkrkwikRsQW6QbOXZxZynk=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-20-B3XgsZYmMYKbG9uzJeHi0A-1; Fri, 20 Jan 2023 12:58:41 -0500
X-MC-Unique: B3XgsZYmMYKbG9uzJeHi0A-1
Received: by mail-il1-f197.google.com with SMTP id x9-20020a056e021ca900b0030f177273c3so4163341ill.8
        for <linux-s390@vger.kernel.org>; Fri, 20 Jan 2023 09:58:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WmRfpj48RyjRyZDGGPZo2d8kT+rAwJ1anTjm2/PHafk=;
        b=4scTuzhSF2x6aWoeH7hf7pdnbxXSZanr5ntndCd6YPzejtz6lhRhPHt8cTzR32Xvxy
         k/g5cTmeh9uUs2F2847gk14mNS+Ycjs+77QncO/yiEMSRraZIfy2eI9FagzWESBxTpRN
         zu28Oz2uB2Sr85s8FcJ/24YtMi9xz2uKC7+xFWHubVyxWALlrV4NUCt06CcI49MWsrb/
         OuiOYtwDLMDUfSD9H0cpklBZ+5w5eKbtYPmP0yHxIoWW4pH7FSk4pjW4xdNEJd21qQ51
         Wzs8os8QTELS9UKuOM1rsTtJ5xBwt5ULKoaWhbez4mxYX1uwF/woBvPDQwGSHIyWPLre
         SYqw==
X-Gm-Message-State: AFqh2kqR6V8zHi+B8rgb54PKjnaGIR5zbwn+rY153mRNfr3CQuYmzFBZ
        zlEydGluUToccqWs6NUavhQfLz4zTvTf63Sfxc/yDCYUki8I71VB3DRjG6Hutdupdv3yZ+Gsqc2
        Ss1TM5fYDAn3447v43Aw1cQ==
X-Received: by 2002:a5d:91ce:0:b0:704:ce06:81fd with SMTP id k14-20020a5d91ce000000b00704ce0681fdmr10190708ior.12.1674237520797;
        Fri, 20 Jan 2023 09:58:40 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvWHZw0KBjfw/OOejn5eFckg+3ECBCwnEWHdhh2gOLwwb1mg/roN1/n+BWFUPswaGH+Cbf2rg==
X-Received: by 2002:a5d:91ce:0:b0:704:ce06:81fd with SMTP id k14-20020a5d91ce000000b00704ce0681fdmr10190681ior.12.1674237520535;
        Fri, 20 Jan 2023 09:58:40 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id j2-20020a026302000000b0038a48cfededsm12514918jac.15.2023.01.20.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 09:58:40 -0800 (PST)
Date:   Fri, 20 Jan 2023 10:58:37 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Yi Liu <yi.l.liu@intel.com>
Cc:     pbonzini@redhat.com, mjrosato@linux.ibm.com, jgg@nvidia.com,
        kevin.tian@intel.com, cohuck@redhat.com, farman@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@linux.ibm.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@redhat.com,
        akrowiak@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com, seanjc@google.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm/vfio: Fix potential deadlock on vfio group_lock
Message-ID: <20230120105837.254a0b0a.alex.williamson@redhat.com>
In-Reply-To: <20230120150528.471752-1-yi.l.liu@intel.com>
References: <20230120150528.471752-1-yi.l.liu@intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 20 Jan 2023 07:05:28 -0800
Yi Liu <yi.l.liu@intel.com> wrote:

> Currently it is possible that the final put of a KVM reference comes from
> vfio during its device close operation.  This occurs while the vfio group
> lock is held; however, if the vfio device is still in the kvm device list,
> then the following call chain could result in a deadlock:
> 
> VFIO holds group->group_lock/group_rwsem
>   -> kvm_put_kvm
>    -> kvm_destroy_vm
>     -> kvm_destroy_devices
>      -> kvm_vfio_destroy
>       -> kvm_vfio_file_set_kvm
>        -> vfio_file_set_kvm
>         -> try to hold group->group_lock/group_rwsem  
> 
> The key function is the kvm_destroy_devices() which triggers destroy cb
> of kvm_device_ops. It calls back to vfio and try to hold group_lock. So
> if this path doesn't call back to vfio, this dead lock would be fixed.
> Actually, there is a way for it. KVM provides another point to free the
> kvm-vfio device which is the point when the device file descriptor is
> closed. This can be achieved by providing the release cb instead of the
> destroy cb. Also rename kvm_vfio_destroy() to be kvm_vfio_release().
> 
> 	/*
> 	 * Destroy is responsible for freeing dev.
> 	 *
> 	 * Destroy may be called before or after destructors are called
> 	 * on emulated I/O regions, depending on whether a reference is
> 	 * held by a vcpu or other kvm component that gets destroyed
> 	 * after the emulated I/O.
> 	 */
> 	void (*destroy)(struct kvm_device *dev);
> 
> 	/*
> 	 * Release is an alternative method to free the device. It is
> 	 * called when the device file descriptor is closed. Once
> 	 * release is called, the destroy method will not be called
> 	 * anymore as the device is removed from the device list of
> 	 * the VM. kvm->lock is held.
> 	 */
> 	void (*release)(struct kvm_device *dev);
> 
> Fixes: 421cfe6596f6 ("vfio: remove VFIO_GROUP_NOTIFY_SET_KVM")
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> ---
>  virt/kvm/vfio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/virt/kvm/vfio.c b/virt/kvm/vfio.c
> index 495ceabffe88..e94f3ea718e5 100644
> --- a/virt/kvm/vfio.c
> +++ b/virt/kvm/vfio.c
> @@ -336,7 +336,7 @@ static int kvm_vfio_has_attr(struct kvm_device *dev,
>  	return -ENXIO;
>  }
>  
> -static void kvm_vfio_destroy(struct kvm_device *dev)
> +static void kvm_vfio_release(struct kvm_device *dev)
>  {
>  	struct kvm_vfio *kv = dev->private;
>  	struct kvm_vfio_group *kvg, *tmp;
> @@ -363,7 +363,7 @@ static int kvm_vfio_create(struct kvm_device *dev, u32 type);
>  static struct kvm_device_ops kvm_vfio_ops = {
>  	.name = "kvm-vfio",
>  	.create = kvm_vfio_create,
> -	.destroy = kvm_vfio_destroy,
> +	.release = kvm_vfio_release,
>  	.set_attr = kvm_vfio_set_attr,
>  	.has_attr = kvm_vfio_has_attr,
>  };

Applied to vfio for-linus branch for v6.2, along with Matthew's R-b,
the comment update, and the extra reference link.  Once we get a
linux-next build I'll send a pull request, along with Matthew's
reserved region fix.  Thanks,

Alex

