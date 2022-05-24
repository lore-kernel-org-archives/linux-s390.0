Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0837C43219
	for <linux-s390@archiver.kernel.org>; Tue, 24 May 2022 16:08:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbiEXQIC (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 24 May 2022 12:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239712AbiEXQH5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 24 May 2022 12:07:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3337A762A9
        for <linux-s390@vger.kernel.org>; Tue, 24 May 2022 09:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653408469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjP5JPsp4sTeptQO7etKphezL1GL7XatlC7yllc+qq4=;
        b=gBszV04dxkBikKwPnzba24F8oMtXGniV4mRYLr8ldd6XAvXs0M8WDz/Q9aXY4SuoAWePFO
        dzIsnZ4xYfFiXkv4luf1h+thscCv+InT1bchstFtO/57oNXX3fENHq7SMiu9YuKnXbxNRb
        +KKqeRogxNYKsS2mmOa0prFJyuey7SY=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-qJWhb8trMIOqfQxMlpy_Vw-1; Tue, 24 May 2022 12:07:48 -0400
X-MC-Unique: qJWhb8trMIOqfQxMlpy_Vw-1
Received: by mail-io1-f71.google.com with SMTP id k17-20020a5d9d51000000b006653f2bc513so2946367iok.10
        for <linux-s390@vger.kernel.org>; Tue, 24 May 2022 09:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=AjP5JPsp4sTeptQO7etKphezL1GL7XatlC7yllc+qq4=;
        b=zbQPHIDoWNEgd//JGwx7+rSqp34f4f3whnWqVQ2zDms2dcX1J12IaJbWlFBRZp7mjw
         yA3Vmisyve0JK6vdxhhoqVAr1DTdMsUh04gzkThVJ7o2JkgcwjgrqgLqnjK9iY+wna+T
         m5Q07W8M776QsIBgjT2pEQ/F3Mb+TKU7goAumF7SyR66wVv+v2xQq9UwKf7r24UvLEfU
         BoCNPe1Npv8nKJO9Oh/u8kJYPbJfwtWPIf7N+/H76fo3Lw5qjX4ByGA2YrS6Ywge8Ifd
         poGbvimQYBx+6edEBDkIzN0YDe1tu6unTDKyPmVu5FBxNz9pNJKodXNobDMe2KcXgaLd
         umMA==
X-Gm-Message-State: AOAM531fDHmYRPmSrbvLNe/AdAFkc1YFRiVh4+LfbCdlzyIf+YBQLngW
        GeS55popKl+hbqeN2BeKrTpyWaOr9GHG4G26zScSoA8l+OkceygHAssJHlYCxOsnmCUSgbd5fe1
        VdudDAd60dBP0NEz20MCx6g==
X-Received: by 2002:a05:6e02:170a:b0:2d1:3f8b:ad75 with SMTP id u10-20020a056e02170a00b002d13f8bad75mr13606327ill.135.1653408467257;
        Tue, 24 May 2022 09:07:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDXCFqahhgZhF13j/01JuWAI9TkKwryMIBDz+Ojod8ivP2jLD7vfDSwtL6uq0vKB4eb0olaw==
X-Received: by 2002:a05:6e02:170a:b0:2d1:3f8b:ad75 with SMTP id u10-20020a056e02170a00b002d13f8bad75mr13606312ill.135.1653408467062;
        Tue, 24 May 2022 09:07:47 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m15-20020a056e021c2f00b002cde6e352d5sm4628333ilh.31.2022.05.24.09.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 09:07:46 -0700 (PDT)
Date:   Tue, 24 May 2022 10:07:45 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     jgg@nvidia.com, cohuck@redhat.com, borntraeger@linux.ibm.com,
        jjherne@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com, hch@infradead.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/1] vfio: remove VFIO_GROUP_NOTIFY_SET_KVM
Message-ID: <20220524100745.006a3635.alex.williamson@redhat.com>
In-Reply-To: <20220519183311.582380-1-mjrosato@linux.ibm.com>
References: <20220519183311.582380-1-mjrosato@linux.ibm.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 19 May 2022 14:33:10 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> As discussed in this thread:
> 
> https://lore.kernel.org/kvm/20220516172734.GE1343366@nvidia.com/
> 
> Let's remove VFIO_GROUP_NOTIFY_SET_KVM and instead assume the association
> has already been established prior to device_open.  For the types today
> that need a KVM (GVT, vfio-ap) these will fail if a KVM is not found.
> Looking ahead, vfio-pci-zdev will optionally want the KVM association
> (enable hardware assists) but it will not be a hard requirement (still
> want to allow other, non-KVM userspace usage). 
> 
> This is built on top of vfio-next and tested with s390x-pci
> (zdev-kvm series) and vfio-ap (GVT changes are compile-tested only)
> 
> Changes for v3:
> - merge branches under if (device->open_count == 1) (Kevin)
> - move device->open_count-- out from group_rwsem (Kevin)
> - drop null KVM check (Christoph)
> - remove extra kvm_{get,put}_kvm from vfio_ap_ops, it was already getting
>   a reference (Jason)
> - Add comment about kvm reference in vfio.h (Jason)
> - Return -EINVAL if !kvm for vfio-ap (Tony)
> 
> Changes for v2:
> - gvt no longer needs release_work, get rid of it (Christoph)
> - a few compile fixes for gvt
> - update commit to mention fixes gvt oops (Jason)
> - s/down_write/down_read/ in a few spots (Jason)
> - avoid kvm build dependency by holding group read lock over device
>   open/close and put the onus on the driver to obtain a reference if
>   it will actually use the kvm pointer.  Document the requirement,
>   use lockdep_assert to ensure lock is held during register_notifer;
>   today all callers are from driver open_device. 
> 
> Matthew Rosato (1):
>   vfio: remove VFIO_GROUP_NOTIFY_SET_KVM
> 
>  drivers/gpu/drm/i915/gvt/gtt.c        |  4 +-
>  drivers/gpu/drm/i915/gvt/gvt.h        |  3 -
>  drivers/gpu/drm/i915/gvt/kvmgt.c      | 82 ++++++--------------------
>  drivers/s390/crypto/vfio_ap_ops.c     | 35 ++---------
>  drivers/s390/crypto/vfio_ap_private.h |  3 -
>  drivers/vfio/vfio.c                   | 83 ++++++++++-----------------
>  include/linux/vfio.h                  |  6 +-
>  7 files changed, 57 insertions(+), 159 deletions(-)

Applied to vfio next branch for v5.19.  Thanks,

Alex

