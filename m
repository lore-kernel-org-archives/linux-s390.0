Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D153DEB64D7
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jun 2023 17:33:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbjFMRdI (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jun 2023 13:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239136AbjFMRdA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 13 Jun 2023 13:33:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEF91BD2
        for <linux-s390@vger.kernel.org>; Tue, 13 Jun 2023 10:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686677511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UFob1aFAu0uRDZrX0tACTzFE1GhOsHEDLUDxSxQ/iS8=;
        b=SjYTSnlzP9suRTNLk9q0CDuooM6m6Sw/qkOcLuoTwzM3aaG5S9pDZ0gPJ3oQ0ZrVen21bR
        XughQfeA7rmARuqIhc4CXeKB+2aPGk8kFVlXt/iK5TBFJcP31t0gXC/OBXX/8gD4zLw8Gx
        zT6b7vXS0Eb5JJLTJt3pi4Flmi7Fx4k=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-1NJwS6shNEy1HXkTSbz58g-1; Tue, 13 Jun 2023 13:31:50 -0400
X-MC-Unique: 1NJwS6shNEy1HXkTSbz58g-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-766655c2cc7so622455639f.3
        for <linux-s390@vger.kernel.org>; Tue, 13 Jun 2023 10:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686677507; x=1689269507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFob1aFAu0uRDZrX0tACTzFE1GhOsHEDLUDxSxQ/iS8=;
        b=BkNrBPdM9DGvYvCHq6VTwtvFfklbdhGtU7D/w3+fjeYZy8Vb+0PkJl6gx+eqrgI59p
         RCorSP0LT8jlL3Lz3thHy8NSlOjaWVgRlsZPkOsYDdGwkiSG5UyLxa6z1aez7QOyed+a
         Iq37IxAobo3jURW15KO79xmzq34eRfhlfGnLAAmWvWdF+6ikzFoYVS+uFEkRARak5qqW
         pjX++25jJtK6DUlttB2nOAUNBHVmR7WU/SoryItMfasKY0fhn99BDRLhK+Ms2DHE1iSg
         U72nQlZC5YbYmyZJqboydj6z2CuDPZUXumM47GVFSYOO6OMw/V33kcEKuQY0SNzJajEG
         SqRQ==
X-Gm-Message-State: AC+VfDyhg6If28DCo/IU0tqT2NIYLnKP3Cq0TfKPr1whkKoZCDQO/gGm
        TrMAzOTvigLvQ1cc2P0VQGtNnMZT5K7EnyrvUsD4WGVxPdQhce8a+/yOgPBF5v5d4peloHNpGcJ
        xcdI9+2mMTzSSRs+n3fJwBg==
X-Received: by 2002:a6b:6611:0:b0:774:ae01:fe1a with SMTP id a17-20020a6b6611000000b00774ae01fe1amr11606440ioc.7.1686677507015;
        Tue, 13 Jun 2023 10:31:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6bJFfYsjTQdozyUeq9/qeGnMAlrvVCxaIfEt3FiroYG03nbc7MFTmdssUxFLgFVi603YCgtg==
X-Received: by 2002:a6b:6611:0:b0:774:ae01:fe1a with SMTP id a17-20020a6b6611000000b00774ae01fe1amr11606418ioc.7.1686677506733;
        Tue, 13 Jun 2023 10:31:46 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id z3-20020a5ec903000000b0077ac811b20dsm3980818iol.38.2023.06.13.10.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 10:31:46 -0700 (PDT)
Date:   Tue, 13 Jun 2023 11:31:45 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
        "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
        "yi.y.sun@linux.intel.com" <yi.y.sun@linux.intel.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
        "intel-gvt-dev@lists.freedesktop.org" 
        <intel-gvt-dev@lists.freedesktop.org>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Hao, Xudong" <xudong.hao@intel.com>,
        "Zhao, Yan Y" <yan.y.zhao@intel.com>,
        "Xu, Terrence" <terrence.xu@intel.com>,
        "Jiang, Yanting" <yanting.jiang@intel.com>,
        "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
        "clegoate@redhat.com" <clegoate@redhat.com>
Subject: Re: [PATCH v12 07/24] vfio: Block device access via device fd until
 device is opened
Message-ID: <20230613113145.66b02d0f.alex.williamson@redhat.com>
In-Reply-To: <ZIilFVb3sKnBgH2F@nvidia.com>
References: <20230602121653.80017-1-yi.l.liu@intel.com>
        <20230602121653.80017-8-yi.l.liu@intel.com>
        <20230612155210.5fd3579f.alex.williamson@redhat.com>
        <DS0PR11MB75293327BDE6D268996FFFCCC355A@DS0PR11MB7529.namprd11.prod.outlook.com>
        <20230613081647.740f5217.alex.williamson@redhat.com>
        <ZIilFVb3sKnBgH2F@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 13 Jun 2023 14:19:17 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Jun 13, 2023 at 08:16:47AM -0600, Alex Williamson wrote:
> 
> > > Not quite get why bit field is going to be incompatible with smp
> > > lockless operations. Could you elaborate a bit? And should I define
> > > the access_granted as u8 or "u8:1"?  
> > 
> > Perhaps FUD on my part, but load-acquire type operations have specific
> > semantics and it's not clear to me that they interest with compiler
> > generated bit operations.  Thanks,  
> 
> They won't compile if you target bit ops, you can't take the address
> of a bitfield.

Yup, that's what I was assuming but was too lazy to prove it.  Thanks,

Alex

