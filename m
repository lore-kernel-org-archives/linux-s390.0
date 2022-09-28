Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55CDFC04A95
	for <linux-s390@archiver.kernel.org>; Wed, 28 Sep 2022 18:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiI1S46 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Sep 2022 14:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiI1S45 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 28 Sep 2022 14:56:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E48F1D5A
        for <linux-s390@vger.kernel.org>; Wed, 28 Sep 2022 11:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664391415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/G4Vq697fdL4v+7M0FMtvwUHBXoZlZMDykWA34n1ZXM=;
        b=QjOiwsY7FAGk480aT0I7rnS+eZ7MhYDFLwlrkFkcuFRQQ/nn5qHEGhrbXNYQPDWukGwB7e
        V8tql7YCJJ9iaTYYYe6pra3kg5K1a7K7rei67DJnaG0K8/j1HawEm+8FJ7mujMZ+iZ3my4
        sxjk28F5QCi2MO6KfZGRCjg3GLg9Stg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-201-VHyBgmt3OQ-YoziH6aQ2Qg-1; Wed, 28 Sep 2022 14:56:54 -0400
X-MC-Unique: VHyBgmt3OQ-YoziH6aQ2Qg-1
Received: by mail-io1-f70.google.com with SMTP id b5-20020a05660214c500b006a43c89e0bdso8392871iow.22
        for <linux-s390@vger.kernel.org>; Wed, 28 Sep 2022 11:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=/G4Vq697fdL4v+7M0FMtvwUHBXoZlZMDykWA34n1ZXM=;
        b=1i964DqMf5d0mb8H9F3v7IS0kbmanHEB+MaDecmySCDc4C3pa8QloSxt8+bmhbriO8
         4vR3vJ0h2w+y0NbRfltYR7ZXAtbUhq6elrSEUoeFnjYZY72Gt/t3u51nJ2hEH79yBSyt
         PrkVgQjNOusZ70t/wICP6lc5wKuBevk4As2M6vpM0VLUpnwdgssWmGd/tynNDCT2eHmw
         g15RF3qt6yYf1ioetbn7VArXFS47V5xc9BdFPPariMtaViUp0GwKKtI+uZLueO3uKe8W
         yDnXyUGY/eeOaYSEfkpLY8jSnUNb+Ufta5Pi3FhPankYgFCGozYFUL1ONsOR/58pQpeE
         Ckzw==
X-Gm-Message-State: ACrzQf2YmbG5Zcsq02QWp1klI2PhMcpWPeuZYB9gkVoHt0w4Ccp5SqOt
        7jSkOqf6SrCzHXlMD2c60bhed/Ib1df2ATdH5jly/fhUiU2ttEw+n1h4MI9k0juLf0uYf0VN4Bk
        WTHIbSs1DmqYRWZFdELq0HQ==
X-Received: by 2002:a05:6e02:1a6f:b0:2f9:1b98:9412 with SMTP id w15-20020a056e021a6f00b002f91b989412mr225940ilv.204.1664391413851;
        Wed, 28 Sep 2022 11:56:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4+rrxfEBEydSabU2v5S3BOdqrNy/3aSdw+xUzsmxEdtmSd7NFDLxd30KRxn4ox+Ehtolvebw==
X-Received: by 2002:a05:6e02:1a6f:b0:2f9:1b98:9412 with SMTP id w15-20020a056e021a6f00b002f91b989412mr225931ilv.204.1664391413632;
        Wed, 28 Sep 2022 11:56:53 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id g6-20020a05663810e600b00349fb9b1abesm2084847jae.106.2022.09.28.11.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 11:56:52 -0700 (PDT)
Date:   Wed, 28 Sep 2022 12:56:50 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org
Subject: Re: simplify the mdev interface v8
Message-ID: <20220928125650.0a2ea297.alex.williamson@redhat.com>
In-Reply-To: <20220928121110.GA30738@lst.de>
References: <20220923092652.100656-1-hch@lst.de>
        <20220927140737.0b4c9a54.alex.williamson@redhat.com>
        <20220927155426.23f4b8e9.alex.williamson@redhat.com>
        <20220928121110.GA30738@lst.de>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 28 Sep 2022 14:11:10 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Sep 27, 2022 at 03:54:26PM -0600, Alex Williamson wrote:
> > Oops, I had to drop this, I get a null pointer from gvt-g code:  
> 
> Ok, this is a stupid bug in the second patch in the series.  I did not
> hit it in my mdev testing as my script just uses the first type and
> thus never hits these, but as your trace showed mdevctl and once I
> used that I could reproduce it.  The fix for patch 2 is below, and
> the git tree at:
> 
>    git://git.infradead.org/users/hch/misc.git mvdev-lifetime
> 
> has been updated with that folded in and the recent reviews.

That fixes the crash, but available_instances isn't working:

[root@nuc ~]# cd /sys/class/mdev_bus/0000\:00\:02.0/mdev_supported_types/
[root@nuc mdev_supported_types]# ls */devices/
i915-GVTg_V4_1/devices/:

i915-GVTg_V4_2/devices/:

i915-GVTg_V4_4/devices/:

i915-GVTg_V4_8/devices/:
[root@nuc mdev_supported_types]# grep . */available_instances
i915-GVTg_V4_1/available_instances:1
i915-GVTg_V4_2/available_instances:2
i915-GVTg_V4_4/available_instances:5
i915-GVTg_V4_8/available_instances:7
[root@nuc mdev_supported_types]# uuidgen > i915-GVTg_V4_1/create
[root@nuc mdev_supported_types]# ls */devices/
i915-GVTg_V4_1/devices/:
669d83b1-81d8-4fd4-8d8b-7f972721c83f

i915-GVTg_V4_2/devices/:

i915-GVTg_V4_4/devices/:

i915-GVTg_V4_8/devices/:
[root@nuc mdev_supported_types]# grep . */available_instances
i915-GVTg_V4_1/available_instances:0
i915-GVTg_V4_2/available_instances:0
i915-GVTg_V4_4/available_instances:1
i915-GVTg_V4_8/available_instances:1
[root@nuc mdev_supported_types]# echo 1 > i915-GVTg_V4_1/devices/669d83b1-81d8-4fd4-8d8b-7f972721c83f/remove 
[root@nuc mdev_supported_types]# ls */devices/
i915-GVTg_V4_1/devices/:

i915-GVTg_V4_2/devices/:

i915-GVTg_V4_4/devices/:

i915-GVTg_V4_8/devices/:
[root@nuc mdev_supported_types]# grep . */available_instances
i915-GVTg_V4_1/available_instances:0
i915-GVTg_V4_2/available_instances:0
i915-GVTg_V4_4/available_instances:1
i915-GVTg_V4_8/available_instances:1

