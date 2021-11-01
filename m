Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54263C433FE
	for <linux-s390@archiver.kernel.org>; Mon,  1 Nov 2021 16:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D441610D2
	for <linux-s390@archiver.kernel.org>; Mon,  1 Nov 2021 16:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbhKAQPb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 1 Nov 2021 12:15:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:31596 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232627AbhKAQPa (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 1 Nov 2021 12:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635783177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+G6SzjVTR+LCyYNlG0zbcp2+gduPxDNU+2Zc+nwBRpo=;
        b=DqejiyoA2UBzwKKsBehIcWvsvwkmIuprNxgqZPFTzFoRgfPlh3ep3QfRWgAfMBfU26Ooqg
        mOSxk9Je/pFA+hqSrmIL5eScCfJApuqJE0nsqq7uTg5V1Vy1ppuXsbGJUxqAaR5sbBOySy
        dr+5qC+XScd5mFfxeCwtea1fPMidRkE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-Pw6mtmFwPGehWjexjpdPEA-1; Mon, 01 Nov 2021 12:12:56 -0400
X-MC-Unique: Pw6mtmFwPGehWjexjpdPEA-1
Received: by mail-qv1-f69.google.com with SMTP id gw8-20020a0562140f0800b0038366347de1so16700247qvb.16
        for <linux-s390@vger.kernel.org>; Mon, 01 Nov 2021 09:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+G6SzjVTR+LCyYNlG0zbcp2+gduPxDNU+2Zc+nwBRpo=;
        b=TMEhod/aX3zCMnaOMyecNAH/TRWtK0h0+PvuJC5Yk7ril38vOVc0gwRG+N3woInCCv
         9F9kCQB6MNzvUQi5123AMiOkOzZjjl68GXRxKj7Lze66AjJp3Hqfs8rOwOUcRkXApaJy
         yiP9CEzzTvELFJmGYqEDIssFpZRdCgPGaOajhlGfk+9q/F7wrt6SjbAVfMApC+cVsBS0
         ZfT43zdU6COadvNxYcAfpfeyBmMBHHiFhJG/OxwLPWuCvEh30MQ2nIs/CMQsn93RGuXr
         VTvugnxX6g4nNVOMifderGX38UBonejERHYKZoNbAy7jaCc93j/qNhqN1C0gvVI4G0wF
         XH+g==
X-Gm-Message-State: AOAM531WPLF4b2vzfTMA4kHwQXg1S80hB4oyDm2ObAM6NsyKW4vm3JX8
        KadAQIbT/6v6mTh1kiKzI74vEYHQzCzioPHSCAEJ4SR1ncLJQDEnduEkx/gIBmh+3zSnQKqejEI
        pfNC0EFa8Jnu/ilLlyXfE
X-Received: by 2002:a0c:e708:: with SMTP id d8mr23264794qvn.62.1635783175419;
        Mon, 01 Nov 2021 09:12:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/H7B1fdn7PP13//AwKmpta1av9FRTtOajPRoBskVHgoJcCnXd+0D44u/s4udzcALoTqA+Rw==
X-Received: by 2002:a0c:e708:: with SMTP id d8mr23264758qvn.62.1635783175189;
        Mon, 01 Nov 2021 09:12:55 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id v16sm167031qtw.90.2021.11.01.09.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 09:12:54 -0700 (PDT)
Date:   Mon, 1 Nov 2021 12:12:53 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ira Weiny <ira.weiny@intel.com>,
        device-mapper development <dm-devel@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-erofs@lists.ozlabs.org,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 01/11] dm: make the DAX support dependend on CONFIG_FS_DAX
Message-ID: <YYASBVuorCedsnRL@redhat.com>
References: <20211018044054.1779424-1-hch@lst.de>
 <20211018044054.1779424-2-hch@lst.de>
 <CAPcyv4hrEPizMOH-XhCqh=23EJDG=W6VwvQ1pVstfe-Jm-AsiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hrEPizMOH-XhCqh=23EJDG=W6VwvQ1pVstfe-Jm-AsiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 27 2021 at  4:53P -0400,
Dan Williams <dan.j.williams@intel.com> wrote:

> On Sun, Oct 17, 2021 at 9:41 PM Christoph Hellwig <hch@lst.de> wrote:
> >
> > The device mapper DAX support is all hanging off a block device and thus
> > can't be used with device dax.  Make it depend on CONFIG_FS_DAX instead
> > of CONFIG_DAX_DRIVER.  This also means that bdev_dax_pgoff only needs to
> > be built under CONFIG_FS_DAX now.
> 
> Looks good.
> 
> Mike, can I get an ack to take this through nvdimm.git? (you'll likely
> see me repeat this question on subsequent patches in this series).

Sorry for late reply, but I see you punted on pushing for 5.16 merge
anyway (I'm sure my lack of response didn't help, sorry about that).

Acked-by: Mike Snitzer <snitzer@redhat.com>

Thanks!

