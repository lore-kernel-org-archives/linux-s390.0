Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602AAC54EF1
	for <linux-s390@archiver.kernel.org>; Thu,  5 Jan 2023 22:10:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235248AbjAEWKj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 5 Jan 2023 17:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbjAEWK3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 5 Jan 2023 17:10:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60EEC69509
        for <linux-s390@vger.kernel.org>; Thu,  5 Jan 2023 14:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672956575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FHRon4iazglsqJx0za5dkKZ1ECmTBS5D3uCSiao/wBQ=;
        b=Z8nnAsIVsplhS9AxYvOfdZwdwcEPyHOeJ6oIGWrrxmjcU8Bgw0bSKGLVBTbUvDDm+E2FXd
        vlknkPchEfmjJOz1EdXV2LagO5Lt2LMyLnO7IHXD693zGSwAyEYcZuerrWn2eJGO2l607D
        HmgAHUP5Vwhnmw+Svy2b52XkqIjiNLw=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-624-ittl3OyyNvyqKvuNLJVHDw-1; Thu, 05 Jan 2023 17:09:33 -0500
X-MC-Unique: ittl3OyyNvyqKvuNLJVHDw-1
Received: by mail-il1-f197.google.com with SMTP id l3-20020a056e021aa300b00304be32e9e5so23679608ilv.12
        for <linux-s390@vger.kernel.org>; Thu, 05 Jan 2023 14:09:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHRon4iazglsqJx0za5dkKZ1ECmTBS5D3uCSiao/wBQ=;
        b=QnR/tHyyGAkmdP9aeYcRbHuMqdc5xgNJgJrjIycP/JawO1FgNP1T1wcSoskubM5XVq
         m6nSWfdxY3C1lfGIACw/5sQfJti2I+6Lc/5pcJVY2wsR6B3/TJDSoMTNOC5hrM551vEZ
         Yp0ph+haJlCeAmaYhc9m+aF1NX1EV2z1vMq1DOtIPHCfZ2nBB7ATFxCEzw6lGKYkHXFB
         FZXK6hGih4n4DVw50ekpvO+//J91oEilP+ZL/FDxyXiUaMJc/4T1cpUZj9wxZRDtd/cN
         s/2kgDyz7y039WqqVznRL5XRTm0gd49Pm+A/4qlCjJwOTnhNxGXQ5xnx1sMkIzpG7yVd
         yGLQ==
X-Gm-Message-State: AFqh2kozGEZ+iF2/R+LSyQM9OUjO7++vVAcubuSt4LfXz8goOFvOIRA8
        oESluAkgzaNR3X310koHuYKVLo8aTYsKvtAblzJvP+fNr3ArMgQ1b1ryw1kO3jLIBOqnoUt1FF9
        w+Tjaz0ac/s0XzVFj6aS3+Q==
X-Received: by 2002:a5e:a609:0:b0:6e4:2893:2b33 with SMTP id q9-20020a5ea609000000b006e428932b33mr32962718ioi.14.1672956573186;
        Thu, 05 Jan 2023 14:09:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXs5yKX/wdLm9HEyg87onxVqgfS0N/eR1/PgmgN9uAH7OlTthfhrG0MhtGAnQyZQ6XYAeeVAMA==
X-Received: by 2002:a5e:a609:0:b0:6e4:2893:2b33 with SMTP id q9-20020a5ea609000000b006e428932b33mr32962706ioi.14.1672956572929;
        Thu, 05 Jan 2023 14:09:32 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id w12-20020a5e970c000000b006e3170eeee4sm13692498ioj.6.2023.01.05.14.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:09:32 -0800 (PST)
Date:   Thu, 5 Jan 2023 15:09:30 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     jgg@nvidia.com, cohuck@redhat.com, borntraeger@linux.ibm.com,
        jjherne@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com,
        zhenyuw@linux.intel.com, zhi.a.wang@intel.com, hch@infradead.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/1] vfio: remove VFIO_GROUP_NOTIFY_SET_KVM
Message-ID: <20230105150930.6ee65182.alex.williamson@redhat.com>
In-Reply-To: <20220519183311.582380-2-mjrosato@linux.ibm.com>
References: <20220519183311.582380-1-mjrosato@linux.ibm.com>
        <20220519183311.582380-2-mjrosato@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 19 May 2022 14:33:11 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> Rather than relying on a notifier for associating the KVM with
> the group, let's assume that the association has already been
> made prior to device_open.  The first time a device is opened
> associate the group KVM with the device.
> 
> This fixes a user-triggerable oops in GVT.

It seems this has traded an oops for a deadlock, which still exists
today in both GVT-g and vfio-ap.  These are the only vfio drivers that
care about kvm, so they make use of kvm_{get,put}_kvm(), where the
latter is called by their .close_device() callbacks.

.close_device() is called holding the group->group_lock, or at the time
of this commit group->group_rwsem.  The remaining call chain looks like
this:

kvm_put_kvm
 -> kvm_destroy_vm
  -> kvm_destroy_devices
   -> kvm_vfio_destroy
    -> kvm_vfio_file_set_kvm
     -> vfio_file_set_kvm
      -> group->group_lock/group_rwsem

Any suggestions for a fix?  Thanks,

Alex

