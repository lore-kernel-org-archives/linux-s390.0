Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43095C433B4
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 10:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E31661222
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 10:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbhDOKzB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Apr 2021 06:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44857 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232399AbhDOKzB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Apr 2021 06:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618484078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DjPUmx4ZuT82ngfXJ12wBBUr3RMNilWkR0ojCFc0jqk=;
        b=Slq9BfPb1bO2ADg0VBjJP7czGTNGrAdRUK7zdU4Gno3d7gzQj7eq0Dvl5qW3yojcm2xCxL
        cKQJ0C2ZZhXLRtTlpmXlq7pCX4hZ1Qk4I2cNtc6N5k4Ve2aGHiQMt3l7iKWIXaBIYDWIQI
        H6cf7MUz1XmK3e15dnU5PU44HDnZENM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-BrY5UVa4OqOLcklPML1K6Q-1; Thu, 15 Apr 2021 06:54:36 -0400
X-MC-Unique: BrY5UVa4OqOLcklPML1K6Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3554A10054F6;
        Thu, 15 Apr 2021 10:54:35 +0000 (UTC)
Received: from gondolin (ovpn-113-158.ams2.redhat.com [10.36.113.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D510D19D9F;
        Thu, 15 Apr 2021 10:54:33 +0000 (UTC)
Date:   Thu, 15 Apr 2021 12:54:31 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Eric Farman <farman@linux.ibm.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [RFC PATCH v4 3/4] vfio-ccw: Reset FSM state to IDLE inside FSM
Message-ID: <20210415125431.0260b4e8.cohuck@redhat.com>
In-Reply-To: <20210413182410.1396170-4-farman@linux.ibm.com>
References: <20210413182410.1396170-1-farman@linux.ibm.com>
        <20210413182410.1396170-4-farman@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 13 Apr 2021 20:24:09 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> When an I/O request is made, the fsm_io_request() routine
> moves the FSM state from IDLE to CP_PROCESSING, and then
> fsm_io_helper() moves it to CP_PENDING if the START SUBCHANNEL
> received a cc0. Yet, the error case to go from CP_PROCESSING
> back to IDLE is done after the FSM call returns.
> 
> Let's move this up into the FSM proper, to provide some
> better symmetry when unwinding in this case.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_fsm.c | 1 +
>  drivers/s390/cio/vfio_ccw_ops.c | 2 --
>  2 files changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

