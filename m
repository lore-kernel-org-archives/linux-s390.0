Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7490EB64D9
	for <linux-s390@archiver.kernel.org>; Thu,  6 Jul 2023 10:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjGFKsr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 6 Jul 2023 06:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGFKsq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 6 Jul 2023 06:48:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236481BD0
        for <linux-s390@vger.kernel.org>; Thu,  6 Jul 2023 03:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688640477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WTpNpWdJ7zMPCCrK35zZUzSPKl2PR5YluSM7GJncBns=;
        b=DWu3ZLhURHNCekq8EMnPIbz2KUciW6txcu/O6MLM9V3jgFYgpq4XM1HMSgatVKbdDkAyOo
        BUMv5GX4jRCBWYADj1gekUXRO3hmWp+fV8/mSf+cqHWmyjr1oDVDG3nWA87/pM6OPWO7la
        4xgiKI4AsVzUOo8RNOTmTQy0S3QD+FM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-V-Mwwe9RNw20zdnGkYDCsg-1; Thu, 06 Jul 2023 06:47:56 -0400
X-MC-Unique: V-Mwwe9RNw20zdnGkYDCsg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76721ad9ed7so10867185a.1
        for <linux-s390@vger.kernel.org>; Thu, 06 Jul 2023 03:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688640475; x=1691232475;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WTpNpWdJ7zMPCCrK35zZUzSPKl2PR5YluSM7GJncBns=;
        b=Nv8Thw8N8iTjfzqhx1btdlI2xhI+BNfATkPgVhnF+loDizWAghD50eB0dTsxVOIxEk
         ARdoVjAVNag90HBBcvJ8VBe0Inl+zZjqyJR8qQhNQxmjriM/pI/zQfIGF9e7XXUMAR3W
         bnd3soZZ32DTc8Z2/C8ttGmJRteSg54H3f04/mKsJ1oP+auPN4wMtZHQ1j/WOq8uWTfe
         jpPIDF7HuICewR2UUpVOxj1/QVKY7vY3i+MoNvotickv06gdR776TnCxH7seDh3mCSoD
         So4ra/YmjFRxVWA26A8n1+7ERpXeIJfwQfCKLrIF1C6Y1WS8EZthfMUxUeh43JzQE55x
         9FOw==
X-Gm-Message-State: ABy/qLb0Ha3b40jg5GpLOO3cq3FPJyOb4H7zPaje6LhhlQaahaaw/njX
        8cDDAiB2/+JUAwP7CdqZPhcEaUdo5LxkVdHrP9BtR/8l78fXqp70sxSAnc4w4yO/QTtuuGrUU2q
        OLyQqWJcWYZD8kiC3Ot872WqfenBftw==
X-Received: by 2002:a05:620a:191f:b0:765:7783:a0ec with SMTP id bj31-20020a05620a191f00b007657783a0ecmr1572438qkb.4.1688640475652;
        Thu, 06 Jul 2023 03:47:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFgIzBb7apMOlAbXh6tc6Xzr+BXVSdJOjsBN5I1RAB77prEw6PGmuRRI29CmrfrKgP1rLxB8Q==
X-Received: by 2002:a05:620a:191f:b0:765:7783:a0ec with SMTP id bj31-20020a05620a191f00b007657783a0ecmr1572417qkb.4.1688640475354;
        Thu, 06 Jul 2023 03:47:55 -0700 (PDT)
Received: from gerbillo.redhat.com (host-95-248-55-118.retail.telecomitalia.it. [95.248.55.118])
        by smtp.gmail.com with ESMTPSA id p5-20020a05620a15e500b00767868864e5sm588612qkm.126.2023.07.06.03.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 03:47:54 -0700 (PDT)
Message-ID: <c6835aae95dd18da35795d2231e9326e0d21b60b.camel@redhat.com>
Subject: Re: [PATCH net] s390/ism: Fix locking for forwarding of IRQs and
 events to clients
From:   Paolo Abeni <pabeni@redhat.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        Stefan Raspl <raspl@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Julian Ruess <julianr@linux.ibm.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Jul 2023 12:47:50 +0200
In-Reply-To: <20230705121722.2700998-1-schnelle@linux.ibm.com>
References: <20230705121722.2700998-1-schnelle@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 2023-07-05 at 14:17 +0200, Niklas Schnelle wrote:
> The clients array references all registered clients and is protected by
> the clients_lock. Besides its use as general list of clients the clients
> array is accessed in ism_handle_irq() to forward IRQs and events to
> clients. This use in an interrupt handler thus requires all code that
> takes the clients_lock to be IRQ save.
>=20
> This is problematic since the add() and remove() callbacks which are
> called for all clients when an ISM device is added or removed cannot be
> called directly while iterating over the clients array and holding the
> clients_lock since clients need to allocate and/or take mutexes in these
> callbacks. To deal with this the calls get pushed to workqueues with
> additional housekeeping to be able to wait for the completion outside
> the clients_lock.
>=20
> Moreover while the clients_lock is taken in the IRQ handler when calling
> handle_event() it is incorrectly not held during the
> client->handle_irq() call and for the preceding clients[] access. This
> leaves the clients array unprotected. Similarly the accesses to
> ism->sba_client_arr[] in ism_register_dmb() and ism_unregister_dmb() are
> also not protected by any lock. This is especially problematic as the
> the client ID from the ism->sba_client_arr[] is not checked against
> NO_CLIENT.
>=20
> Instead of expanding the use of the clients_lock further add a separate
> array in struct ism_dev which references clients subscribed to the
> device's events and IRQs. This array is protected by ism->lock which is
> already taken in ism_handle_irq() and can be taken outside the IRQ
> handler when adding/removing subscribers or the accessing
> ism->sba_client_arr[].
>=20
> With the clients_lock no longer accessed from IRQ context it is turned
> into a mutex and the add and remove workqueues plus their housekeeping
> can be removed in favor of simple direct calls.
>=20
> Fixes: 89e7d2ba61b7 ("net/ism: Add new API for client registration")
> Tested-by: Julian Ruess <julianr@linux.ibm.com>
> Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
> Note: I realize this is a rather large patch. So I'd understand if it's n=
ot
> acceptable as is and needs to be broken up. That said it removes more lin=
es
> than it adds and the complexity of the resulting code is in my opinion re=
duced.

This is indeed unusually large for a -net patch. IMHO it would be
better split it in 2 separated patches: 1 introducing the ism->lock and
one turning the clients_lock in a mutex. The series should still target
-net, but should be more easily reviewable.

Thanks,

Paolo

