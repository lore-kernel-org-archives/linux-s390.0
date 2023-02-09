Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930A2C61DA4
	for <linux-s390@archiver.kernel.org>; Thu,  9 Feb 2023 21:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjBIVEr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 9 Feb 2023 16:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjBIVEm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Feb 2023 16:04:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A86768AF3
        for <linux-s390@vger.kernel.org>; Thu,  9 Feb 2023 13:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675976634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0hzi6znNyM3FxWtE65ukWP+Wt97TeNT+3DRNv4OIzVA=;
        b=bcKjwms9gIA1xSiyXvdU5/jv5K2JMEPV5/v15WOzPVY5cF+GztB+oy3Lk4LpddpKJ5oz9n
        J6iWMlKHumT1XpET9pDFRzaLHwLlmeYud0Eb5OQiFWWHeOf4jwLdySnB5Mc43mFIECXi47
        /nRqXE2SYRyW8cSUPtDDMYUGAIHMY3o=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-584-RKHvldL2P-mU-y-gTI4pAg-1; Thu, 09 Feb 2023 16:03:53 -0500
X-MC-Unique: RKHvldL2P-mU-y-gTI4pAg-1
Received: by mail-io1-f71.google.com with SMTP id n85-20020a6b8b58000000b0073a2fb71d15so2041517iod.6
        for <linux-s390@vger.kernel.org>; Thu, 09 Feb 2023 13:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0hzi6znNyM3FxWtE65ukWP+Wt97TeNT+3DRNv4OIzVA=;
        b=IcUsAarE5y0W7ZofPQ0x2t4mSWFZYWXsVuk30UWfoibHz19G/qdE0s6W92yBbODQ6o
         hkL5l4ZDtdwHNOJ63Rc13Dq8Jrh/okMp4DKxxjtqOjw/y1v9gwu3ifygYAsTv8gvf8Xj
         RpEoH7Fkzt4d3B8iHS9X1x0iX8TI6DrOI2X/ME+A4QLTJCGwjg2iNXHNpNeX6BVXEt4A
         xwfm7IAo38WLLY3dMovBCMhvn49nv3naYSradMf5K4K16QXPGn7nacGwIuZvn2Q0sH6B
         uzcbF71DoZtYjOQCTwWrszhjNpvRBPCnavTt7s9buR5WZirxUUsXAiv0+Ik5d0uevSYQ
         QuBg==
X-Gm-Message-State: AO0yUKWTt2W6FV1QH+8FMOGfVTb0/CWxjF3+7KX86o78/8NbzE3VleJT
        ctz6H1J20nSu4IfvpNinHiNJEV9qhsCqV4ouvddb1eWFNFVf+W6ufeWO5WjcyEf+aNdcuBdbwOf
        X7QB1nSnR7TS2rrTZQE1KQA==
X-Received: by 2002:a05:6602:2d13:b0:704:7be5:9537 with SMTP id c19-20020a0566022d1300b007047be59537mr14244242iow.20.1675976632529;
        Thu, 09 Feb 2023 13:03:52 -0800 (PST)
X-Google-Smtp-Source: AK7set9rs8OA65lw6671PZ1PpYK2stGa0HAY3gcdYk+JO8kpoT0yBNh478fTTwihnUoCWW3Y7vCO2A==
X-Received: by 2002:a05:6602:2d13:b0:704:7be5:9537 with SMTP id c19-20020a0566022d1300b007047be59537mr14244210iow.20.1675976632268;
        Thu, 09 Feb 2023 13:03:52 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id c5-20020a5ea905000000b0071cbf191687sm698346iod.55.2023.02.09.13.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 13:03:51 -0800 (PST)
Date:   Thu, 9 Feb 2023 14:03:26 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     pbonzini@redhat.com, yi.l.liu@intel.com, jgg@nvidia.com,
        cohuck@redhat.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, david@redhat.com, akrowiak@linux.ibm.com,
        jjherne@linux.ibm.com, pasic@linux.ibm.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com, seanjc@google.com,
        kevin.tian@intel.com, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] vfio: fix deadlock between group lock and kvm
 lock
Message-ID: <20230209140326.6957dca0.alex.williamson@redhat.com>
In-Reply-To: <20230203215027.151988-1-mjrosato@linux.ibm.com>
References: <20230203215027.151988-1-mjrosato@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri,  3 Feb 2023 16:50:25 -0500
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Hi Alex,
> 
> Here is the latest group_lock vs kvm lock deadlock fix + a non-fix
> follow-on to remove the kvm argument from vfio_device_open and
> vfio_device_first_open.
> 
> Changes from v3:
> * Remove device->group->kvm reference in vfio_main by passing the
>   kvm in (Kevin)
> * Slight re-organization to make it easier for cdev to build upon
>   this later and keep symmetry between get/put (Alex)
> * Add follow-on patch that removes unused kvm argument (Yi)
> 
> Changes from v2:
> * Relocate the new functions back to vfio_main and externalize to call
>   from group (Kevin) since cdev will need this too
> * s/vfio_kvm_*_kvm/vfio_device_*_kvm/ and only pass device as input.
>   Handle new kvm_ref_lock directly inside vfio_device_get_kvm (Alex)
> * Add assert_lockdep_held for dev_set lock (Alex)
> * Internalize error paths for vfio_device_get_kvm_safe and now return
>   void - either device->kvm is set with a ref taken or is NULL (Alex)
> * Other flow suggestions to make the call path cleaner - Thanks! (Alex)
> * Can't pass group->kvm to vfio_device_open, as it references the value
>   outside of new lock.  Pass device->kvm to minimize changes in this
>   fix (Alex, Yi)
> 
> Changes from v1:
> * use spin_lock instead of spin_lock_irqsave (Jason)
> * clear device->kvm_put as part of vfio_kvm_put_kvm (Yi)
> * Re-arrange code to avoid referencing the group contents from within
>   vfio_main (Kevin) which meant moving most of the code in this patch 
>   to group.c along with getting/dropping of the dev_set lock
> 
> Matthew Rosato (2):
>   vfio: fix deadlock between group lock and kvm lock
>   vfio: no need to pass kvm pointer during device open
> 
>  drivers/vfio/group.c     | 44 +++++++++++++++++++++----
>  drivers/vfio/vfio.h      | 18 +++++++++--
>  drivers/vfio/vfio_main.c | 70 +++++++++++++++++++++++++++++++++-------
>  include/linux/vfio.h     |  2 +-
>  4 files changed, 113 insertions(+), 21 deletions(-)
> 

Applied to vfio next branch for v6.3.  Thanks,

Alex

