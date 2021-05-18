Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56569C433ED
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 09:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A5F6613E3
	for <linux-s390@archiver.kernel.org>; Tue, 18 May 2021 09:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241602AbhERJvk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 18 May 2021 05:51:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348258AbhERJu6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 May 2021 05:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621331379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pWDDfzE00K7I9LPmkDG1S1lA7ltEV0Gm9b5uqDeW48=;
        b=IIsZn6Kh222y1XjPY1kHnuoUTotlwzdwN2yW2ptWSmT3yFKfYLzs5VDiPWYmfNZcej98T9
        dgBSURFFTyniIF6UW9g026dsNuoteI1PmVUIsSkLqxKmck42qKGHvF1eRugN2ORZRWXkZL
        VuPy1EIJqPtkrPp7EWaFbAncwvKTXGU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-304-ZAdlD6djMeuaUsuPGI5RZg-1; Tue, 18 May 2021 05:49:37 -0400
X-MC-Unique: ZAdlD6djMeuaUsuPGI5RZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB509195D563;
        Tue, 18 May 2021 09:49:36 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-74.ams2.redhat.com [10.36.113.74])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E9275B4B3;
        Tue, 18 May 2021 09:49:35 +0000 (UTC)
Date:   Tue, 18 May 2021 11:49:32 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH v6 0/3] vfio-ccw: Fix interrupt handling for HALT/CLEAR
Message-ID: <20210518114932.683dd8aa.cohuck@redhat.com>
In-Reply-To: <20210511195631.3995081-1-farman@linux.ibm.com>
References: <20210511195631.3995081-1-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 11 May 2021 21:56:28 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Hi Conny, Matt, Halil,
> 
> Here's one (last?) update to my proposal for handling the collision
> between interrupts for START SUBCHANNEL and HALT/CLEAR SUBCHANNEL.
> 
> Only change here is to include Conny's suggestions on patch 3.
> 
> Thanks,
> Eric
> 
> Changelog:
> v5->v6:
>  - Add a block comment and rename variable in patch 3 [CH]
>  - Drop RFC tag [EF]
> 
> v4->v5:
>  - Applied Conny's r-b to patches 1 and 3
>  - Dropped patch 2 and 4
>  - Use a "finished" flag in the interrupt completion path
> 
> Previous versions:
> v5: https://lore.kernel.org/kvm/20210510205646.1845844-1-farman@linux.ibm.com/
> v4: https://lore.kernel.org/kvm/20210413182410.1396170-1-farman@linux.ibm.com/
> v3: https://lore.kernel.org/kvm/20200616195053.99253-1-farman@linux.ibm.com/
> v2: https://lore.kernel.org/kvm/20200513142934.28788-1-farman@linux.ibm.com/
> v1: https://lore.kernel.org/kvm/20200124145455.51181-1-farman@linux.ibm.com/
> 
> Eric Farman (3):
>   vfio-ccw: Check initialized flag in cp_init()
>   vfio-ccw: Reset FSM state to IDLE inside FSM
>   vfio-ccw: Serialize FSM IDLE state with I/O completion
> 
>  drivers/s390/cio/vfio_ccw_cp.c  |  4 ++++
>  drivers/s390/cio/vfio_ccw_drv.c | 12 ++++++++++--
>  drivers/s390/cio/vfio_ccw_fsm.c |  1 +
>  drivers/s390/cio/vfio_ccw_ops.c |  2 --
>  4 files changed, 15 insertions(+), 4 deletions(-)
> 

Thanks, applied.

