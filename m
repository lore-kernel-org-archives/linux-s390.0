Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F307C433E0
	for <linux-s390@archiver.kernel.org>; Tue, 23 Feb 2021 11:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D523864E22
	for <linux-s390@archiver.kernel.org>; Tue, 23 Feb 2021 11:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhBWLQ1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 23 Feb 2021 06:16:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42472 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231701AbhBWLQW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 23 Feb 2021 06:16:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614078896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E2kyO9/kHv6mDObVqIFauPTFE/WMna2vft2bwlJJ//s=;
        b=iodLukiBf+g7Nn71VckEljEw5Jfd0EeT13LUqmn+kUyG2V320Ecktj3+NSYnyshlpznI2W
        pc8jiuVD9ZpG5xHQvBSo8QQgYZ1OrdPWsw9EJ0Hh+A1Q2RLQTXdI5GAk0tna1aczzFxY4s
        +MWG50r0l/MACg747+V6M9WqGGar5M4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-435-jpLPipz5N2afzUja5Pau0g-1; Tue, 23 Feb 2021 06:14:52 -0500
X-MC-Unique: jpLPipz5N2afzUja5Pau0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83C79107ACE3;
        Tue, 23 Feb 2021 11:14:51 +0000 (UTC)
Received: from gondolin (ovpn-113-126.ams2.redhat.com [10.36.113.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 044CC6F95D;
        Tue, 23 Feb 2021 11:14:46 +0000 (UTC)
Date:   Tue, 23 Feb 2021 12:14:44 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Pierre Morel <pmorel@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com,
        thuth@redhat.com
Subject: Re: [PATCH v4 1/1] KVM: s390: diag9c (directed yield) forwarding
Message-ID: <20210223121444.28543783.cohuck@redhat.com>
In-Reply-To: <1613997661-22525-2-git-send-email-pmorel@linux.ibm.com>
References: <1613997661-22525-1-git-send-email-pmorel@linux.ibm.com>
        <1613997661-22525-2-git-send-email-pmorel@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 22 Feb 2021 13:41:01 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> When we intercept a DIAG_9C from the guest we verify that the
> target real CPU associated with the virtual CPU designated by
> the guest is running and if not we forward the DIAG_9C to the
> target real CPU.
> 
> To avoid a diag9c storm we allow a maximal rate of diag9c forwarding.
> 
> The rate is calculated as a count per second defined as a new
> parameter of the s390 kvm module: diag9c_forwarding_hz .
> 
> The default value of 0 is to not forward diag9c.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  Documentation/virt/kvm/s390-diag.rst | 33 ++++++++++++++++++++++++++++
>  arch/s390/include/asm/kvm_host.h     |  1 +
>  arch/s390/include/asm/smp.h          |  1 +
>  arch/s390/kernel/smp.c               |  1 +
>  arch/s390/kvm/diag.c                 | 31 +++++++++++++++++++++++---
>  arch/s390/kvm/kvm-s390.c             |  6 +++++
>  arch/s390/kvm/kvm-s390.h             |  8 +++++++
>  7 files changed, 78 insertions(+), 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

