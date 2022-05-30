Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88366C4321E
	for <linux-s390@archiver.kernel.org>; Mon, 30 May 2022 08:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiE3Ivd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 May 2022 04:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbiE3IvO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 May 2022 04:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AAC1D78ED6
        for <linux-s390@vger.kernel.org>; Mon, 30 May 2022 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653900659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yKtdU5vxewPnOdOWNNLgSNOUnSAAIYi1vfN6EO9YdFk=;
        b=R5SVOYsDxFyQ11QDLzl1iPRHg4fPSPus/6MPuzwgDFZyqtQLRJQKDQByAvYLa7lXeywW5o
        eylUWRBXyrp5ubvEVxCzms0efFQ8UXejLNOZ8R96rcFdO1hdxqk74SWKIIM6QjIZ+rc2ye
        syiyybXzYR+I8sFl43JS7v33o0I3Wl8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-68-eDQB5Cx-OC2kcv7cACYsXg-1; Mon, 30 May 2022 04:50:52 -0400
X-MC-Unique: eDQB5Cx-OC2kcv7cACYsXg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5BD66181E07C;
        Mon, 30 May 2022 08:50:39 +0000 (UTC)
Received: from localhost (unknown [10.39.194.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DC65C23DC1;
        Mon, 30 May 2022 08:50:38 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Eric Farman <farman@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Eric Farman <farman@linux.ibm.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: Update s390 virtio-ccw
In-Reply-To: <20220525144028.2714489-2-farman@linux.ibm.com>
Organization: Red Hat GmbH
References: <20220525144028.2714489-1-farman@linux.ibm.com>
 <20220525144028.2714489-2-farman@linux.ibm.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 30 May 2022 10:50:37 +0200
Message-ID: <874k17v1ya.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, May 25 2022, Eric Farman <farman@linux.ibm.com> wrote:

> Add myself to the kernel side of virtio-ccw

Thanks a lot!

>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6618e9b91b6c..1d2c6537b834 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20933,6 +20933,7 @@ F:	include/uapi/linux/virtio_crypto.h
>  VIRTIO DRIVERS FOR S390
>  M:	Cornelia Huck <cohuck@redhat.com>
>  M:	Halil Pasic <pasic@linux.ibm.com>
> +M:	Eric Farman <farman@linux.ibm.com>
>  L:	linux-s390@vger.kernel.org
>  L:	virtualization@lists.linux-foundation.org
>  L:	kvm@vger.kernel.org

...anyone feel like picking this up directly? It feels a bit silly to do
a pull request for a one-liner.

In any case,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

