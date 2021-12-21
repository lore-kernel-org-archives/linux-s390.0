Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E49C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 21 Dec 2021 19:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbhLUTLe (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Dec 2021 14:11:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20027 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232879AbhLUTLd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Dec 2021 14:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640113892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D3nopav1HV958Lz8ym3EJquqZZpJ17bAGW+vR5I0OKk=;
        b=L9iMOi44gvf4WMU6h9hQZ8fJDpz3EUld0V2o4plprqGNfameSntruVjFxcfZdYKsBMl7QL
        BSJr7rIoksAf/6Y12HNO3P240Tu6/8LuzkLzTlx+9pMN69kY98qaFtQxBZ1YUhmkWDfg8T
        jcBzByp9sDvbbmlau7KHDcL12JuT0Ms=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-UsSV4NZvPKue9UF_YJ3mTg-1; Tue, 21 Dec 2021 14:11:31 -0500
X-MC-Unique: UsSV4NZvPKue9UF_YJ3mTg-1
Received: by mail-ot1-f69.google.com with SMTP id m23-20020a05683023b700b0055c8a2dcca0so4611099ots.6
        for <linux-s390@vger.kernel.org>; Tue, 21 Dec 2021 11:11:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3nopav1HV958Lz8ym3EJquqZZpJ17bAGW+vR5I0OKk=;
        b=4FoTpGpQCkRa29UgIim7p704sf3bc2HUSx58YoXCcv/zrsJSvhruAxm4avQlvqs/iu
         9Y18pBM1I+IkyFXXy6lovJaa6viLcBjAYuBMqKlorK9f2HUip2hpKkynV6UGRwbiNP1C
         lbSm0IlfcWaxamWrFA04+vDGvAwD+oO/mWiWBuLwlZxQtnZvwGgifz2NLqmhHWYQRFs2
         fOu0rhA8LXmrfWyEtxsWcTGwAoejWC08VelQmautxM1Hlaw1CE8R6lEzck+EXRp/CzNf
         DC5bB9MfVxHPKxTAgCBZ0zACpwspa0gVIahs8B34gTi33YoGvbfb/fbQKHD5oPUPRUEx
         FLyg==
X-Gm-Message-State: AOAM531mMLCVGF+TOHoagO2R4dhpCxBp/ChqlPoSEdFh9NT0YmJyLp4W
        yceE7bQd1dWEchYHY81w6uF8Nru6Nks/Ihv2i7PGd7p2o+dgtPsFvoMdjOiJlnCT/OyMuxWgiFl
        H/dlw+YAHPtWvbvv0WA+NEg==
X-Received: by 2002:a05:6830:1209:: with SMTP id r9mr2359950otp.23.1640113890475;
        Tue, 21 Dec 2021 11:11:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQtFZKZ6VThEzbIaG8jpXFiklalKg9k83yzWNk3jWIaqACsso1srrjrT1BD2Jw2cQLyfJtCg==
X-Received: by 2002:a05:6830:1209:: with SMTP id r9mr2359934otp.23.1640113890289;
        Tue, 21 Dec 2021 11:11:30 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id u40sm4417173oiw.56.2021.12.21.11.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 11:11:30 -0800 (PST)
Date:   Tue, 21 Dec 2021 12:11:28 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Christian Borntraeger <borntraeger@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        linux-s390@vger.kernel.org, cohuck@redhat.com,
        schnelle@linux.ibm.com, farman@linux.ibm.com, pmorel@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 32/32] MAINTAINERS: additional files related kvm s390
 pci passthrough
Message-ID: <20211221121128.06c8c2bd.alex.williamson@redhat.com>
In-Reply-To: <5073966a-0e99-977b-dc97-e72f55ff7091@linux.ibm.com>
References: <20211207205743.150299-1-mjrosato@linux.ibm.com>
        <20211207205743.150299-33-mjrosato@linux.ibm.com>
        <5073966a-0e99-977b-dc97-e72f55ff7091@linux.ibm.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 17 Dec 2021 15:55:08 +0100
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

> Am 07.12.21 um 21:57 schrieb Matthew Rosato:
> > Add entries from the s390 kvm subdirectory related to pci passthrough.
> > 
> > Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>  
> 
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Question for Alex. Shall I take these and future patches regarding
> KVM hw support for PCI passthru via my tree or via your vfio tree?

Looks like there will be another rev of this series but the diffstat of
this one would suggest your tree.  For future patches, I don't need to
slow down the process for anything entirely internal to zpci,
especially since I don't know the intricacies anyway, but I'd like to
at least get a chance to look at anything exposing new vfio interfaces.
Thanks,

Alex

