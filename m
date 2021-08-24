Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B89C432BE
	for <linux-s390@archiver.kernel.org>; Tue, 24 Aug 2021 16:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3801361212
	for <linux-s390@archiver.kernel.org>; Tue, 24 Aug 2021 16:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhHXQS5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 24 Aug 2021 12:18:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231404AbhHXQS4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 24 Aug 2021 12:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629821890;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJabbqkNupKTThGjFKf2rBjQIQEbUXnIAkBWwJDSMks=;
        b=dBOV1LY+1AOzqRWzfzMPr0pTRn1M9ZEI25XJF/3l4yUoNwqDbHDYoCpnvczilboRbd5krp
        gZZAKdP17XQINRaMSmzwiQex1KcU25WQ0NN08lA35esr5tIxy1CH0XjREiegnEi2AZi/yO
        Hc981gorllOxSJ0g60llNOtFI4q8WL0=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-7T3ubtjhMdmffzdbY3-ahg-1; Tue, 24 Aug 2021 12:18:09 -0400
X-MC-Unique: 7T3ubtjhMdmffzdbY3-ahg-1
Received: by mail-il1-f198.google.com with SMTP id x3-20020a92de03000000b0022458d4e768so12145366ilm.2
        for <linux-s390@vger.kernel.org>; Tue, 24 Aug 2021 09:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=bJabbqkNupKTThGjFKf2rBjQIQEbUXnIAkBWwJDSMks=;
        b=MGE+ikMtr0Kh5Y64tpDBa40ubIIJ0NLfzLFqYcI5+NtHykl1XbDao+1Sv5da4CdPBX
         /dzQ5HDtr+Zos6hRVpcQ+gbYCXB2LyzWNZa2oILfuKUPl2ct13R2bc6qqsJDSbtrCszE
         KLW877nLYNVwEVDV7nhETR5yxVcVa0snwON2JtXkePoEtfdaf0uPI3UlW7gpZw3FT8Ms
         kLjNLY23jmA24950bz7JgjfaGlP2B7WxDfEdJ1WDedXO+hpO0+FgBZLQWobxzEMY6S7j
         oI1gASTL0d/PAl/fKN1GP8LFkLOL+VS9jet+xTK/b3lQY+QPm667tpY2Um8/+IWEHCbM
         rSRQ==
X-Gm-Message-State: AOAM533wc3gFhs1/q/+WoinblM9ARIHVkBkXjQPUOZ1swI1bnDXrkFoM
        z4kOx8FE3/iqjHyLzuBiELcylD4koxUj1e/lzNocJfKPjf9E1W4SeaDPKXLHRzsOs6c2fIK/EEi
        xJbNnNBe1105Bj5xGb1wyoA==
X-Received: by 2002:a5d:8710:: with SMTP id u16mr13582505iom.62.1629821889009;
        Tue, 24 Aug 2021 09:18:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwice9wMKOTJEhk94fUGvO1ox0iAV2gbWgv+fyeX4ypPIlF3s4RP/BFcStnTfghdPYRVxKqrg==
X-Received: by 2002:a5d:8710:: with SMTP id u16mr13582489iom.62.1629821888821;
        Tue, 24 Aug 2021 09:18:08 -0700 (PDT)
Received: from redhat.com ([198.99.80.109])
        by smtp.gmail.com with ESMTPSA id s16sm10156290iln.5.2021.08.24.09.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 09:18:08 -0700 (PDT)
Date:   Tue, 24 Aug 2021 10:18:05 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     Cai Huoqing <caihuoqing@baidu.com>, farman@linux.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2] vfio-pci/zdev: Remove repeated verbose license text
Message-ID: <20210824101805.028a0011.alex.williamson@redhat.com>
In-Reply-To: <d2e299fb-c636-ea1d-a523-c0e842e0d9e6@linux.ibm.com>
References: <20210824003749.1039-1-caihuoqing@baidu.com>
        <d2e299fb-c636-ea1d-a523-c0e842e0d9e6@linux.ibm.com>
Organization: Red Hat
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 24 Aug 2021 11:52:11 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 8/23/21 8:37 PM, Cai Huoqing wrote:
> > remove it because SPDX-License-Identifier is already used
> > and change "GPL-2.0+" to "GPL-2.0-only"  
> 
> Could maybe extend the commit message a little to add something along 
> the lines of ' to match the more restrictive license that was specified 
> by the verbose text being removed.', so as to explain why the identifier 
> is being changed here.
> 
> With that,
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Agreed, I'd propose changing it to:

  The SPDX and verbose license text are redundant, however in this case
  the verbose license indicates a GPL v2 only while SPDX specifies v2+.
  Remove the verbose license and correct SPDX to the more restricted
  version.

I can update on commit unless Cai wishes to respin with different
wording.  Thanks,

Alex

> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> > ---
> > v1->v2: change "GPL-2.0+" to "GPL-2.0-only"
> > 
> >   drivers/vfio/pci/vfio_pci_zdev.c | 7 +------
> >   1 file changed, 1 insertion(+), 6 deletions(-)
> > 
> > diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
> > index 7b011b62c766..104fcf6658db 100644
> > --- a/drivers/vfio/pci/vfio_pci_zdev.c
> > +++ b/drivers/vfio/pci/vfio_pci_zdev.c
> > @@ -1,15 +1,10 @@
> > -// SPDX-License-Identifier: GPL-2.0+
> > +// SPDX-License-Identifier: GPL-2.0-only
> >   /*
> >    * VFIO ZPCI devices support
> >    *
> >    * Copyright (C) IBM Corp. 2020.  All rights reserved.
> >    *	Author(s): Pierre Morel <pmorel@linux.ibm.com>
> >    *                 Matthew Rosato <mjrosato@linux.ibm.com>
> > - *
> > - * This program is free software; you can redistribute it and/or modify
> > - * it under the terms of the GNU General Public License version 2 as
> > - * published by the Free Software Foundation.
> > - *
> >    */
> >   #include <linux/io.h>
> >   #include <linux/pci.h>
> >   
> 

