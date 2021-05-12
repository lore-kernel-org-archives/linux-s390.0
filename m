Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CA42C433B4
	for <linux-s390@archiver.kernel.org>; Wed, 12 May 2021 10:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E862A6127A
	for <linux-s390@archiver.kernel.org>; Wed, 12 May 2021 10:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhELKgZ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 12 May 2021 06:36:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54166 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230292AbhELKgY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 May 2021 06:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620815716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JjvMxQTKtgVV/vw0mCHKj+DX9Iwi8frvy9yTNz/M6yk=;
        b=akfQcl4EcoP5hydcyUWUvjEoTnNi8CTY7M7qpS3zSePBnM0ZC0g2E0RNTzUfQw09JSBxXi
        7F+6Pb6y4oBpj6YfRjmEzMxcsp1tyz4m839/7ehuF2NZm9bWA1zUgqk9AbX86/f+yFObjO
        z4lKsOAzfEzjpI77q/npNevyF1kOntI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-ighyW7aVO6GJpjTyhaPeSg-1; Wed, 12 May 2021 06:35:12 -0400
X-MC-Unique: ighyW7aVO6GJpjTyhaPeSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B296B801B13;
        Wed, 12 May 2021 10:35:08 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-78.ams2.redhat.com [10.36.113.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D4F95D9D7;
        Wed, 12 May 2021 10:35:06 +0000 (UTC)
Date:   Wed, 12 May 2021 12:35:03 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com,
        jjherne@linux.ibm.com, jgg@nvidia.com, alex.williamson@redhat.com,
        kwankhede@nvidia.com, stable@vger.kernel.org,
        Tony Krowiak <akrowiak@stny.rr.com>
Subject: Re: [PATCH v2] s390/vfio-ap: fix memory leak in mdev remove
 callback
Message-ID: <20210512123503.3177fc3d.cohuck@redhat.com>
In-Reply-To: <20210510214837.359717-1-akrowiak@linux.ibm.com>
References: <20210510214837.359717-1-akrowiak@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, 10 May 2021 17:48:37 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> The mdev remove callback for the vfio_ap device driver bails out with
> -EBUSY if the mdev is in use by a KVM guest. The intended purpose was
> to prevent the mdev from being removed while in use; however, returning a
> non-zero rc does not prevent removal. This could result in a memory leak
> of the resources allocated when the mdev was created. In addition, the
> KVM guest will still have access to the AP devices assigned to the mdev
> even though the mdev no longer exists.
> 
> To prevent this scenario, cleanup will be done - including unplugging the
> AP adapters, domains and control domains - regardless of whether the mdev
> is in use by a KVM guest or not.
> 
> Fixes: 258287c994de ("s390: vfio-ap: implement mediated device open callback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tony Krowiak <akrowiak@stny.rr.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)

With the S-o-b fixed,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

