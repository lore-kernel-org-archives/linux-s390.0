Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098ACC6FA86
	for <linux-s390@archiver.kernel.org>; Tue, 27 Sep 2022 20:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbiI0UI7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 27 Sep 2022 16:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232947AbiI0UIj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 27 Sep 2022 16:08:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9CC1EAD74
        for <linux-s390@vger.kernel.org>; Tue, 27 Sep 2022 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664309261;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i9KCspW5QBpvFaoYn48TLwQ3ngMOEiqEbJfDsVhYYhY=;
        b=g47thuQcFgDzKbdnvZrIEjlam4UIAIkHheaVCZq5NMX5vxsahv8jGOMcfKz3zVFw3EEkcf
        x5pEKkqn415Prg5Fy7pWtrfdP6e0/xE7YTUV99PWeQPjCBDfwYKr5AvTGNLwdZMLgR3k3I
        ehOBzTkukdSPpZIyIdZdtgBgrLHwsko=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-588-p7ZLzrTcNlaO4YMsKvmG1Q-1; Tue, 27 Sep 2022 16:07:39 -0400
X-MC-Unique: p7ZLzrTcNlaO4YMsKvmG1Q-1
Received: by mail-io1-f69.google.com with SMTP id l84-20020a6b3e57000000b006a3fe90910cso6483987ioa.16
        for <linux-s390@vger.kernel.org>; Tue, 27 Sep 2022 13:07:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=i9KCspW5QBpvFaoYn48TLwQ3ngMOEiqEbJfDsVhYYhY=;
        b=i68exL7FWrAIRJkySYDNWaUvpL0gsH921WdhQq9Uvqr5KC5kIx5YIqx8Zda9JTfUIf
         ALY8OLT9B+smdzaZDMijWKazfqLSS/NOtCBjg31SSE/9MoeWCH9sdxNyhImJap/wUZi+
         bOR+9SmXpf3+8xD7RKEn7OLV9RYtrgLj6lP8y4x5Q5E/TPFbI7m0sgtH2ovinKU73WEe
         GjE01deyXWmxawYKeaFhhYXMauYTqKkKahrgiZDx97hlcEcUkL28/CRC19DF3RRqX6Rf
         ZMUP6XskiwAtZplSgcNdWiO01oh3sTrPxWfGVDXFo1pcCXDngoWfChFgQdcrtxV6UbM+
         D7Kg==
X-Gm-Message-State: ACrzQf1VdZHkSrZiKREyP2+h4/SjU4wq707xWq7otKVR03GVKqiKZgb8
        T6MvGvRj1acEePBeyNT/Zg1VqFHN9dR0QTea2gGCqSseyNCi/OLKxUfjCUTgNMt+KBMnnmPIqCW
        obkgJ1CWBASiY16lBdM6g2g==
X-Received: by 2002:a05:6e02:164d:b0:2f1:869c:c45b with SMTP id v13-20020a056e02164d00b002f1869cc45bmr12241784ilu.212.1664309259222;
        Tue, 27 Sep 2022 13:07:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5lK3WbPrzD44Iq58D1vNhjr5XwGPbVXBbULBMbNnjK3x4PVL86wB1/1VUMJJsx+kK4SSdmYA==
X-Received: by 2002:a05:6e02:164d:b0:2f1:869c:c45b with SMTP id v13-20020a056e02164d00b002f1869cc45bmr12241776ilu.212.1664309259048;
        Tue, 27 Sep 2022 13:07:39 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id m20-20020a02a154000000b00346b96a352bsm963856jah.164.2022.09.27.13.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:07:38 -0700 (PDT)
Date:   Tue, 27 Sep 2022 14:07:37 -0600
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
Message-ID: <20220927140737.0b4c9a54.alex.williamson@redhat.com>
In-Reply-To: <20220923092652.100656-1-hch@lst.de>
References: <20220923092652.100656-1-hch@lst.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 23 Sep 2022 11:26:38 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> this series significantly simplifies the mdev driver interface by
> following the patterns for device model interaction used elsewhere in
> the kernel.
> 
> Changes since v7:
>  - rebased to the latests vfio/next branch
>  - move the mdev.h include from cio.h to vfio_ccw_private.h
>  - don't free the parent in mdev_type_release
>  - set the pretty_name for vfio_ap
>  - fix the available_instances check in mdev_device_create

Thanks for your persistence, I think all threads are resolved at this
point.  Applied to vfio next branch for v6.1.  Thanks,

Alex

