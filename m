Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422FAC433FE
	for <linux-s390@archiver.kernel.org>; Mon, 30 May 2022 15:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiE3Puz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 30 May 2022 11:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240713AbiE3Ptx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 30 May 2022 11:49:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4C6466CBE
        for <linux-s390@vger.kernel.org>; Mon, 30 May 2022 08:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653923542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DRdewCPW2PjLfahETyqZJaykG2Z7dGzih3m2LJk0xYA=;
        b=EGDAlOBCn+0TAmGUILzuGqWSTRPDc0I1HTKv92R3vFhrWwog/JZ3ltK0Am+47epSTFAxsW
        hpKPKk/BelMwdN89ueCIuAdjgalWC6Eo+q9IQsC3F8KxbzTFOAG0waBHGnxlPsyK+93Ioz
        3GMsZNDWbvjI9e2u0PLACmPhWSmophY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-1sfrdPbbN7-JuiOV3jgnBw-1; Mon, 30 May 2022 11:12:19 -0400
X-MC-Unique: 1sfrdPbbN7-JuiOV3jgnBw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 05CD785A5B9;
        Mon, 30 May 2022 15:12:19 +0000 (UTC)
Received: from localhost (unknown [10.39.194.233])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A6BD51410F36;
        Mon, 30 May 2022 15:12:18 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, peterz@infradead.org, paulmck@kernel.org,
        maz@kernel.org, pasic@linux.ibm.com, eperezma@redhat.com,
        lulu@redhat.com, sgarzare@redhat.com, xuanzhuo@linux.alibaba.com,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH V6 6/9] virtio-ccw: implement synchronize_cbs()
In-Reply-To: <20220527060120.20964-7-jasowang@redhat.com>
Organization: Red Hat GmbH
References: <20220527060120.20964-1-jasowang@redhat.com>
 <20220527060120.20964-7-jasowang@redhat.com>
User-Agent: Notmuch/0.34 (https://notmuchmail.org)
Date:   Mon, 30 May 2022 17:12:17 +0200
Message-ID: <87y1yjt5pq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, May 27 2022, Jason Wang <jasowang@redhat.com> wrote:

> This patch tries to implement the synchronize_cbs() for ccw. For the
> vring_interrupt() that is called via virtio_airq_handler(), the
> synchronization is simply done via the airq_info's lock. For the
> vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> device rwlock is introduced and used in the synchronization method.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

