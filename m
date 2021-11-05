Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F59DC433EF
	for <linux-s390@archiver.kernel.org>; Fri,  5 Nov 2021 15:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F4960720
	for <linux-s390@archiver.kernel.org>; Fri,  5 Nov 2021 15:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233691AbhKEP7A (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 5 Nov 2021 11:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:29626 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232537AbhKEP7A (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Nov 2021 11:59:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636127780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OF5GtL3ADF57dbTh917K/zUSNmWiN4qCeq1RBYbSkyI=;
        b=C6Z78T8PGl/WmSEpHhrpzm3UDBkGPhtWl9jvG/AEzqumVclVBdFzBm7mtwYKwYo+P7hK9N
        JdlyxvCfVw912HVhUedTrU/FuMDVWCvENA2O4mj56Y1BvKfs2zI6tuH4A+TYsiCrrezF+1
        2hVmAX34V6RnSbb4+/ouxcuOF63xed8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-VNIL8gUFNbWwzwvfkVC2eA-1; Fri, 05 Nov 2021 11:56:18 -0400
X-MC-Unique: VNIL8gUFNbWwzwvfkVC2eA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CEEFA80668A;
        Fri,  5 Nov 2021 15:56:17 +0000 (UTC)
Received: from localhost (unknown [10.39.193.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 587A0104A9FF;
        Fri,  5 Nov 2021 15:56:15 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>, linux-s390@vger.kernel.org
Cc:     oberpar@linux.ibm.com, vneethv@linux.ibm.com
Subject: Re: [PATCH] s390/cio: check the subchannel validity for dev_busid
In-Reply-To: <20211105154451.847288-1-vneethv@linux.ibm.com>
Organization: Red Hat GmbH
References: <20211105154451.847288-1-vneethv@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Fri, 05 Nov 2021 16:56:14 +0100
Message-ID: <87ee7ua95t.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Nov 05 2021, Vineeth Vijayan <vneethv@linux.ibm.com> wrote:

> Check the validity of subchanel before reading other fields in
> the schib.
>
> Fixes: d3683c055212 ("s390/cio: add dev_busid sysfs entry for each subchannel")
> Reported-by: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
> ---
>  drivers/s390/cio/css.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

