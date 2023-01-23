Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E0BC54EAA
	for <linux-s390@archiver.kernel.org>; Mon, 23 Jan 2023 19:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjAWTiO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 Jan 2023 14:38:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjAWTiN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 23 Jan 2023 14:38:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5051A32518
        for <linux-s390@vger.kernel.org>; Mon, 23 Jan 2023 11:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674502646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0vWogAhmj1NvtjWCQKs+r5RRl21/4W7OFkx5SINebkk=;
        b=htwvFvDHjbcaURmolX68XCVE0P5ePiM1/1TuyX2C7Xazj1WOf/3dVeEmvAB0daiJBYeBwA
        qSUDWL9mBQu3ziCA/VRESlZoDqnN67Lm3lOpYIjK0H25FvhwHl5GHkinP04ob0a0U66/86
        rTMVO+ptXrMGSuqTHU6b6s6eLF5Mdik=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-570-X_NS3PV_Ot2iXN9PpJUu-w-1; Mon, 23 Jan 2023 14:37:25 -0500
X-MC-Unique: X_NS3PV_Ot2iXN9PpJUu-w-1
Received: by mail-il1-f200.google.com with SMTP id l14-20020a056e02066e00b0030bff7a1841so9096764ilt.23
        for <linux-s390@vger.kernel.org>; Mon, 23 Jan 2023 11:37:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0vWogAhmj1NvtjWCQKs+r5RRl21/4W7OFkx5SINebkk=;
        b=38fqaDBVUH3Aqr+TtCs6E58uFDossrOtfbtA3Tus9BvEkW578gsktBXyDZvM9Lsf7w
         GhV0xchf6sMF/85R/iYGsAZnp8RbFba72Jv+0BAhg0/Wj5sGeIUjI9rglG593eYkUxUa
         XpArHEBKmTjsQJOmyeHhE3KzQQEvWL4xrRKtXUp/h/JIiUkQA99r/xYKuVjIpb5+ihzG
         KrcLC+Y2UruW2gSBVYcwq2djmvcIt37/4SJJ0ZMGip02ed42WtDP162sZYiwqW+xUt0K
         XNWtrSRpPKYkGAo/cURA6hWJEWE5qev0Fex4YxHkPboIdatqxIyd6zIAUCGkvxZkxO3p
         B7RQ==
X-Gm-Message-State: AFqh2kryrNN30IPDZ9xz986JlVEkqU+O71MaC3MWHaer9NURpLtolsKG
        YXXp/4xPhbZI203w+Mgg914yOXlTgQsaJjnvD3/0Wpa06pmHMhL3ButGfiGInNftV6cqbs6SmU5
        Z2/hBkxWajmnWcFIScTCpwQ==
X-Received: by 2002:a6b:8ed5:0:b0:6dd:83b1:199b with SMTP id q204-20020a6b8ed5000000b006dd83b1199bmr18182837iod.16.1674502644419;
        Mon, 23 Jan 2023 11:37:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtu6Ly17bULQyFSGVLnyQUqC5oEfEglCgbjJ55TyAbA0Veuv1+y+vbu15OeDiLpyx1J/bGIWA==
X-Received: by 2002:a6b:8ed5:0:b0:6dd:83b1:199b with SMTP id q204-20020a6b8ed5000000b006dd83b1199bmr18182821iod.16.1674502644208;
        Mon, 23 Jan 2023 11:37:24 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id v26-20020a056602059a00b00704c3128817sm7121378iox.43.2023.01.23.11.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 11:37:23 -0800 (PST)
Date:   Mon, 23 Jan 2023 12:37:03 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, intel-gfx@lists.freedesktop.org
Subject: Re: misc mdev tidyups
Message-ID: <20230123123703.35074b2b.alex.williamson@redhat.com>
In-Reply-To: <20230110091009.474427-1-hch@lst.de>
References: <20230110091009.474427-1-hch@lst.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 10 Jan 2023 10:10:05 +0100
Christoph Hellwig <hch@lst.de> wrote:

> Hi all,
> 
> this series tidies up the mdev Kconfig interaction and documentation a bit.
> 
> Diffstat:
>  Documentation/driver-api/vfio-mediated-device.rst |  108 ----------------------
>  Documentation/s390/vfio-ap.rst                    |    1 
>  arch/s390/Kconfig                                 |    6 -
>  arch/s390/configs/debug_defconfig                 |    1 
>  arch/s390/configs/defconfig                       |    1 
>  drivers/gpu/drm/i915/Kconfig                      |    2 
>  drivers/vfio/mdev/Kconfig                         |    8 -
>  samples/Kconfig                                   |   16 +--
>  samples/vfio-mdev/README.rst                      |  100 ++++++++++++++++++++
>  9 files changed, 115 insertions(+), 128 deletions(-)
> 

Applied to vfio next branch for v6.3.  Thanks,

Alex

