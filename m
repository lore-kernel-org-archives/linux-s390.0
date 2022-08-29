Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71FCECAAD4
	for <linux-s390@archiver.kernel.org>; Mon, 29 Aug 2022 12:19:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiH2MTm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 29 Aug 2022 08:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbiH2MTQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 29 Aug 2022 08:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ADFE17E1E
        for <linux-s390@vger.kernel.org>; Mon, 29 Aug 2022 05:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661774520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JxYStZcImyV6pg+KupRauvweBTIy9m8if0nxzKPXP30=;
        b=CyP1M6mFEkhP0K/vPcpFcasJ+et2zRG6nJ78Q/tXlD49SIWsD/E0eRz98rqI2g9B3lWo6V
        HNX3RXQhvA/uQFa4J0gIBqwPvlDMyjjO7cWrN0jTGix/6TinWN8FbSqfvLHEXmcWKXawjR
        5737/zwhNlabkJKbORbii0bvi5Q6ZVg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-53-VdLVpJssO5irTeJghS9HbA-1; Mon, 29 Aug 2022 07:51:04 -0400
X-MC-Unique: VdLVpJssO5irTeJghS9HbA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DEB629AA387;
        Mon, 29 Aug 2022 11:51:03 +0000 (UTC)
Received: from localhost (unknown [10.39.193.155])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 089DFC15BC3;
        Mon, 29 Aug 2022 11:51:02 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     Kevin Tian <kevin.tian@intel.com>
Subject: Re: [PATCH v2 3/3] vfio/pci: Simplify the is_intx/msi/msix/etc defines
In-Reply-To: <3-v2-1bd95d72f298+e0e-vfio_pci_priv_jgg@nvidia.com>
Organization: Red Hat GmbH
References: <3-v2-1bd95d72f298+e0e-vfio_pci_priv_jgg@nvidia.com>
User-Agent: Notmuch/0.36 (https://notmuchmail.org)
Date:   Mon, 29 Aug 2022 13:51:01 +0200
Message-ID: <871qszfeu2.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Aug 26 2022, Jason Gunthorpe <jgg@nvidia.com> wrote:

> Only three of these are actually used, simplify to three inline functions,
> and open code the if statement in vfio_pci_config.c.
>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/pci/vfio_pci_config.c |  2 +-
>  drivers/vfio/pci/vfio_pci_intrs.c  | 22 +++++++++++++++++-----
>  drivers/vfio/pci/vfio_pci_priv.h   |  2 --
>  3 files changed, 18 insertions(+), 8 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

