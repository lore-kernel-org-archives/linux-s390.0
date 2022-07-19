Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68FA0C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 19 Jul 2022 15:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbiGSP0z (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238232AbiGSP0w (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Jul 2022 11:26:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DEA8E50062
        for <linux-s390@vger.kernel.org>; Tue, 19 Jul 2022 08:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658244410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G7zzeWeOFiX/qPfQUEc/yUHAFf2sghiN9c5AjnoHblQ=;
        b=K4dtbwbJ2wEYD1Ymh5PmsuTfu1/timPDBEy1+WxnCWiodAPY5Fkv+r9iNGS9ea8fFsr++A
        IvijS/nJJO4aKnszUJESxigLwjUnvWAdc30uCVlgGadTvgAy0hz7eftotescY4ZqCC1o5n
        umHKv4lCg7jtrxKPgIEoMx6Z5Ld9ttY=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-x_Owfo_sNze_e4kVN8Kwdw-1; Tue, 19 Jul 2022 11:26:48 -0400
X-MC-Unique: x_Owfo_sNze_e4kVN8Kwdw-1
Received: by mail-il1-f200.google.com with SMTP id f2-20020a056e020b4200b002dca33f6243so9633572ilu.15
        for <linux-s390@vger.kernel.org>; Tue, 19 Jul 2022 08:26:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=G7zzeWeOFiX/qPfQUEc/yUHAFf2sghiN9c5AjnoHblQ=;
        b=5nOGB7althqyVycahKWeJyGl5FaqQvdx8o6NvgTiBN8ZEfX9/RnwxJhdR8PBztpbhB
         vBagdO8AjbuXVED+G6Nhgsxl84ZJN8vidNbrxaki4JJH4PB8kTc3jO0OEiiQtby4Lode
         RXJR2oExdBEYX77y5sDQ9lKsRhvIR0hXGTCCIiKhRWbACFrEDmK+DxaDi1x3dCKMNNLH
         YdTktbzMw85AuGvT0mVSxwWDpEPGz7T/JGYjAHEqoXUV5/9lGDEUxfyqWJtRAh3Jdtwn
         MubN33vVgAV8lrDsbirOZd3pB5EekyQr50/czkCUzDWQpG9kEk1/3bLJULbEoL+Taf6G
         UQFw==
X-Gm-Message-State: AJIora/zVosuJTuDGB7zHG6UvNd1+rJlBqvO3Cn0niCfReXKAWvXfTol
        93eibLXeTc/ag/PA1Xf0EQq4MYr4KIw+0qE589aQjWUstOyM+U/fOw1H2sdiiSevhe0QpARIEI6
        EvoNjANjeuiRwI6nGgzddbw==
X-Received: by 2002:a05:6638:348c:b0:33f:82b2:7441 with SMTP id t12-20020a056638348c00b0033f82b27441mr17856992jal.296.1658244406585;
        Tue, 19 Jul 2022 08:26:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sCP7legSjso0LeShf9Ua6sFhO1nc12IEp69v7ovtogZn2d+6QLUaad2RzcOZuMrXJv8UG/8A==
X-Received: by 2002:a05:6638:348c:b0:33f:82b2:7441 with SMTP id t12-20020a056638348c00b0033f82b27441mr17856977jal.296.1658244406330;
        Tue, 19 Jul 2022 08:26:46 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id t2-20020a92cc42000000b002dcf927087asm1345647ilq.65.2022.07.19.08.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 08:26:45 -0700 (PDT)
Date:   Tue, 19 Jul 2022 09:26:44 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Eric Farman <farman@linux.ibm.com>,
        Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gvt-dev@lists.freedesktop.org,
        Vineeth Vijayan <vneethv@linux.ibm.com>
Subject: Re: simplify the mdev interface v6
Message-ID: <20220719092644.3db1ceee.alex.williamson@redhat.com>
In-Reply-To: <20220719144928.GB21431@lst.de>
References: <20220709045450.609884-1-hch@lst.de>
        <20220718054348.GA22345@lst.de>
        <20220718153331.18a52e31.alex.williamson@redhat.com>
        <1f945ef0eb6c02079700a6785ca3dd9864096b82.camel@linux.ibm.com>
        <20220719144928.GB21431@lst.de>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 19 Jul 2022 16:49:28 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Jul 18, 2022 at 10:01:40PM -0400, Eric Farman wrote:
> > I'll get the problem with struct subchannel [1] sorted out in the next
> > couple of days. This series breaks vfio-ccw in its current form (see
> > reply to patch 14), but even with that addressed the placement of all
> > these other mdev structs needs to be handled differently.  
> 
> Alex, any preference if I should just fix the number instances checking
> with either an incremental patch or a resend, or wait for this ccw
> rework?

Since it's the last patch, let's at least just respin that patch rather
than break and fix.  I'd like to make sure Eric is ok to shift around
structures as a follow-up or make a proposal how this series should
change though.  Thanks,

Alex

