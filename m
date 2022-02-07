Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B12C433F5
	for <linux-s390@archiver.kernel.org>; Mon,  7 Feb 2022 08:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbiBGIiD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 7 Feb 2022 03:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238652AbiBGI24 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Feb 2022 03:28:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DD9EC043181
        for <linux-s390@vger.kernel.org>; Mon,  7 Feb 2022 00:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644222535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FJ5taJzIn7M+azZADWBSS56Hl06do4D4nfM2v7m4sMo=;
        b=ZKgivc7u9A3Xlx4GX/qhqVKY4f/s+v0InROQfgowJaonpfbPaWcaHnpBRO3/T/mlHrqcu4
        pgKFutWBJVXtxm885CF6ePQ65QjB3HNJa0zKuy1N8133AXbxciLN38eekFUzbw4HPtNwh6
        l652p3RDFm4oQL+ry61HnXIkvT2qjJg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-28-ThYU6bVkMjCJpBn0dqlQMQ-1; Mon, 07 Feb 2022 03:28:51 -0500
X-MC-Unique: ThYU6bVkMjCJpBn0dqlQMQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D93261091DA0;
        Mon,  7 Feb 2022 08:28:48 +0000 (UTC)
Received: from localhost (unknown [10.39.193.241])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 851F810589D0;
        Mon,  7 Feb 2022 08:28:29 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     alex.williamson@redhat.com, schnelle@linux.ibm.com,
        farman@linux.ibm.com, pmorel@linux.ibm.com,
        borntraeger@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, agordeev@linux.ibm.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        vneethv@linux.ibm.com, oberpar@linux.ibm.com, freude@linux.ibm.com,
        thuth@redhat.com, pasic@linux.ibm.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/30] s390/airq: pass more TPI info to airq handlers
In-Reply-To: <20220204211536.321475-6-mjrosato@linux.ibm.com>
Organization: Red Hat GmbH
References: <20220204211536.321475-1-mjrosato@linux.ibm.com>
 <20220204211536.321475-6-mjrosato@linux.ibm.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 07 Feb 2022 09:28:27 +0100
Message-ID: <87iltrw05w.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Feb 04 2022, Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> A subsequent patch will introduce an airq handler that requires additional
> TPI information beyond directed vs floating, so pass the entire tpi_info
> structure via the handler.  Only pci actually uses this information today,
> for the other airq handlers this is effectively a no-op.
>
> Reviewed-by: Eric Farman <farman@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  arch/s390/include/asm/airq.h     | 3 ++-
>  arch/s390/kvm/interrupt.c        | 4 +++-
>  arch/s390/pci/pci_irq.c          | 9 +++++++--
>  drivers/s390/cio/airq.c          | 2 +-
>  drivers/s390/cio/qdio_thinint.c  | 6 ++++--
>  drivers/s390/crypto/ap_bus.c     | 9 ++++++---
>  drivers/s390/virtio/virtio_ccw.c | 4 +++-
>  7 files changed, 26 insertions(+), 11 deletions(-)

For virtio-ccw:

Acked-by: Cornelia Huck <cohuck@redhat.com>

