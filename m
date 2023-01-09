Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63258C5479D
	for <linux-s390@archiver.kernel.org>; Mon,  9 Jan 2023 08:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjAIIec (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 9 Jan 2023 03:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233624AbjAIIeb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 9 Jan 2023 03:34:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169D99593
        for <linux-s390@vger.kernel.org>; Mon,  9 Jan 2023 00:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673253218;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y9gIK8bZiGG4LEKBzDLg/5EuK1s/Vb4LwYgwWkRCjz4=;
        b=VskUMBflC701tKS42+Kmcv3vfdNBniEQX+/3jCr17YqqUIRzs+FdmShT/3u8Le/f/l5uhv
        U4uzkBqSj9WCrqwyHt8WMMKFFxhalkouOP0OXxYp75EafQAnzipn0qIaeUBtpZ6ljhjXOB
        2wHYjIAJ3Z9USF9eeygHaAAUxRcG6+I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-KyuEl0DrMD6p6VrBdwebow-1; Mon, 09 Jan 2023 03:33:36 -0500
X-MC-Unique: KyuEl0DrMD6p6VrBdwebow-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C12B85C06A;
        Mon,  9 Jan 2023 08:33:36 +0000 (UTC)
Received: from localhost (unknown [10.39.193.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D2BF342220;
        Mon,  9 Jan 2023 08:33:35 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vineeth Vijayan <vneethv@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, vneethv@linux.ibm.com
Subject: Re: [PATCH 1/1] docs/ABI: use linux-s390 list as the main contact
In-Reply-To: <20230102202812.3336171-2-vneethv@linux.ibm.com>
Organization: Red Hat GmbH
References: <20230102202812.3336171-1-vneethv@linux.ibm.com>
 <20230102202812.3336171-2-vneethv@linux.ibm.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date:   Mon, 09 Jan 2023 09:33:32 +0100
Message-ID: <87ilhgds4j.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jan 02 2023, Vineeth Vijayan <vneethv@linux.ibm.com> wrote:

> Remove Cornelia's email address from the file as suggested by her. List
> linux-s390 mailing-list address as the primary contact instead.
>
> Link: https://lore.kernel.org/linux-s390/8735d0oiq6.fsf@redhat.com/
> Signed-off-by: Vineeth Vijayan <vneethv@linux.ibm.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-css | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

