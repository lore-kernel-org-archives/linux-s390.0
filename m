Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B985C43334
	for <linux-s390@archiver.kernel.org>; Thu,  9 Jun 2022 02:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbiFICte (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Jun 2022 22:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237120AbiFICtd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jun 2022 22:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 312301A0AF9
        for <linux-s390@vger.kernel.org>; Wed,  8 Jun 2022 19:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654742971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/0YpjuW68HNELekQLFsdSYJRUrxNvsJVXmGH2rDIGvE=;
        b=gK8petfGMORgvqp8pZ0H2bN1Y/EPv4L7+SLqjHo4p1MFrFu5jHq7p5Jkg4JMaV+97hZ5zM
        yg2jovnzTI+3knjPjHMa+qoPingFEpebESM4cufL4oQJWPfKQyYBwubp/nFILq7v+1a2Sz
        BKaZekXPkgQiY6HHECO3ehavLmEXzag=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-467-3Y8Gx35ZM46reltw4Sse4w-1; Wed, 08 Jun 2022 22:49:22 -0400
X-MC-Unique: 3Y8Gx35ZM46reltw4Sse4w-1
Received: by mail-qk1-f197.google.com with SMTP id c8-20020a05620a268800b0069c0f1b3206so18091451qkp.18
        for <linux-s390@vger.kernel.org>; Wed, 08 Jun 2022 19:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/0YpjuW68HNELekQLFsdSYJRUrxNvsJVXmGH2rDIGvE=;
        b=deEIB+1NaPd6ufEYSXZfotNVj56IOnkalAxS0KrgFV6d34fnKrq0nyWa3WVskx5cDO
         m/Mj5HOaSELDf1Zs6ZpxdyUipRhMHrS22EidTL7bkkN+D+LMIli5pGhdtEq7XpBBUOGw
         HD9/tLRjgdbyYX2WZXygKlDet7SLoXyb47+NhjRao6TBjPJ0j9hfbyxOjApIWfMmrofl
         OFKMA6Vibkj//9gGl+zk/xmN1Hm1e+RwhU94fcutF7uWRa0qhgNoF0k9Z5G9J6nMGAxK
         i7XRkW/KnwOZkZqTrxbwvh7Mf6iYLnwzwduStadDLIFXNXCe0J+jxP/gEcVTde4Iu2j4
         L8QA==
X-Gm-Message-State: AOAM532xScLpE0gnG6NpEDo/5NP5uKdUQF/0hP8SofTKUGoyFOHH2fkU
        G6gg6Tbxq/iMSZtAg1ymMTwgQE4c0fpxAp/kHZuZggfwZFYctvLj2zrDN4n/UhQFnX+yOBARMjK
        U5Pw+PRM3eJBYzBBGoqN9Nw==
X-Received: by 2002:a05:620a:884:b0:6a7:347:386 with SMTP id b4-20020a05620a088400b006a703470386mr4112875qka.7.1654742962228;
        Wed, 08 Jun 2022 19:49:22 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBK1tIWNCe57tZEsE8mUnnp/UpdYnyXz4Zm8gvU2pKB7qcEdewVRclbUm+yfr4AUtK27ViWw==
X-Received: by 2002:a05:620a:884:b0:6a7:347:386 with SMTP id b4-20020a05620a088400b006a703470386mr4112866qka.7.1654742961980;
        Wed, 08 Jun 2022 19:49:21 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y28-20020a05620a0e1c00b006a0ffae114fsm16842033qkm.120.2022.06.08.19.49.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 19:49:21 -0700 (PDT)
Date:   Thu, 9 Jun 2022 10:49:15 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Alexander Gordeev <agordeev@linux.ibm.com>
Cc:     bugzilla-daemon@kernel.org, linux-s390@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bug 216073] New: [s390x] kernel BUG at mm/usercopy.c:101!
 usercopy: Kernel memory exposure attempt detected from vmalloc 'n  o area'
 (offset 0, size 1)!
Message-ID: <20220609024915.geephkxchu2fgpwk@zlang-mailbox>
References: <bug-216073-27@https.bugzilla.kernel.org/>
 <20220606151312.6a9d098c85ed060d36519600@linux-foundation.org>
 <Yp9pHV14OqvH0n02@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <20220608021922.n2izu7n4yoadknkx@zlang-mailbox>
 <YqD0yAELzHxdRBU6@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqD0yAELzHxdRBU6@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 08, 2022 at 09:13:12PM +0200, Alexander Gordeev wrote:
> On Wed, Jun 08, 2022 at 10:19:22AM +0800, Zorro Lang wrote:
> > One of the test environment details as [1]. The xfstests config as [2].
> > It's easier to reproduce on 64k directory size xfs by running xfstests
> > auto group.
> 
> 
> Thanks for the details, Zorro!
> 
> Do you create test and scratch device with xfs_io, as README suggests?
> If yes, what are sizes of the files?

# fallocate -l 5G /home/test_dev.img
# fallocate -l 10G /home/scratch_dev.img
Then create loop devices.


> Also, do you run always xfs/auto or xfs/294 hits for you reliably?

100% for on my testing, I tried 10 times, then hit it 10 times last
weekend. Will test again this week.

> 
> Thanks!
> 

