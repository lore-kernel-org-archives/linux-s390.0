Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA724C433B4
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 12:53:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FAB3611EE
	for <linux-s390@archiver.kernel.org>; Mon,  3 May 2021 12:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhECMxs (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 3 May 2021 08:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37075 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230246AbhECMxi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 3 May 2021 08:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620046364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uY7ncgkzOtZOUzdwMrfI87BDPnF0Y+CDGaGS1rFPivo=;
        b=RNchfaWrFo3I/eY3mnMR6gG+vlSjx/JysiknfgRgmfibDfePhYHRBhPvNhDRIqklzbVHI3
        Uu+VPqum0E11COZkJShAeA3/sE0csfsoe2HST0AYw4m37AbmjgN4ewJMT4FaIUSjo7l+jD
        akkhYJpXocMfHSCOdjs5P20PGvL9x9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-uY4ZkiPENg6NVjwLfEsTSA-1; Mon, 03 May 2021 08:52:41 -0400
X-MC-Unique: uY4ZkiPENg6NVjwLfEsTSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3796380DDEF;
        Mon,  3 May 2021 12:52:39 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-109.ams2.redhat.com [10.36.113.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 283FE19C97;
        Mon,  3 May 2021 12:52:34 +0000 (UTC)
Date:   Mon, 3 May 2021 14:52:32 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390: fix detection of vector enhancements facility 1
 vs. vector packed decimal facility
Message-ID: <20210503145232.68b5541c.cohuck@redhat.com>
In-Reply-To: <20210503121244.25232-1-david@redhat.com>
References: <20210503121244.25232-1-david@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon,  3 May 2021 14:12:44 +0200
David Hildenbrand <david@redhat.com> wrote:

> The PoP documents:
> 	134: The vector packed decimal facility is installed in the
> 	     z/Architecture architectural mode. When bit 134 is
> 	     one, bit 129 is also one.
> 	135: The vector enhancements facility 1 is installed in
> 	     the z/Architecture architectural mode. When bit 135
> 	     is one, bit 129 is also one.
> 
> Looks like we confuse the vector enhancements facility 1 ("EXT") with the
> Vector packed decimal facility ("BCD"). Let's fix the facility checks.
> 
> Detected while working on QEMU/tcg z14 support and only unlocking
> the vector enhancements facility 1, but not the vector packed decimal
> facility.
> 
> Fixes: 2583b848cad0 ("s390: report new vector facilities")
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: Alexander Egorenkov <egorenar@linux.ibm.com>
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/kernel/setup.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

