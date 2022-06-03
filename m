Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4346BC433EF
	for <linux-s390@archiver.kernel.org>; Fri,  3 Jun 2022 07:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242530AbiFCHqw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Jun 2022 03:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242483AbiFCHqv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jun 2022 03:46:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95E73BA
        for <linux-s390@vger.kernel.org>; Fri,  3 Jun 2022 00:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654242405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qAxyKscgi+dU7C+Fjo9DBbGFN6Cbs/bD1XqARJsuc3s=;
        b=WK5ak6fmWLf18ynRRqhmS1de+PN7LFG2Rcx5pBeLrf0Lo27KUn2HSEM7A8doJbrIW4K6sG
        oBpk/v6DcpIzTeZES0jyyDpBJo/oeJ8XkBww2+MY7TKSVNUcIzWRN92+o2ZP7UZMBZMmNR
        k1i0mWXQYaCEfQaR990asMBRgzXQ45I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-663-GDXPLIM2MbSZkIAklTIg6Q-1; Fri, 03 Jun 2022 03:46:42 -0400
X-MC-Unique: GDXPLIM2MbSZkIAklTIg6Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 07750811E76;
        Fri,  3 Jun 2022 07:46:42 +0000 (UTC)
Received: from localhost (dhcp-192-194.str.redhat.com [10.33.192.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BC1992166B26;
        Fri,  3 Jun 2022 07:46:41 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH v1 17/18] vfio: Export vfio_device_try_get()
In-Reply-To: <20220602171948.2790690-18-farman@linux.ibm.com>
Organization: Red Hat GmbH
References: <20220602171948.2790690-1-farman@linux.ibm.com>
 <20220602171948.2790690-18-farman@linux.ibm.com>
User-Agent: Notmuch/0.36 (https://notmuchmail.org)
Date:   Fri, 03 Jun 2022 09:46:40 +0200
Message-ID: <874k129okf.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jun 02 2022, Eric Farman <farman@linux.ibm.com> wrote:

> From: Jason Gunthorpe <jgg@nvidia.com>
>
> vfio_ccw will need it.
>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Link: https://lore.kernel.org/r/9-v3-57c1502c62fd+2190-ccw_mdev_jgg@nvidia.com/
> [farman: added Cc: tags]
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/vfio/vfio.c  | 3 ++-
>  include/linux/vfio.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>

