Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BC2C433ED
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 09:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE0D061418
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 09:08:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhD1JJQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Apr 2021 05:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50772 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237745AbhD1JJQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Apr 2021 05:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619600911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fhr6VD9MpmIRwGw/LQkBVjKYFz4C2wLpeHZjuBPrxEw=;
        b=MtGAC/UZHSH+zQ+ocWbdou/qDr8D/POugou/22lhItXtN+LdCVDI9nFaaT6qZeJ1Sgg48o
        YjUx7cuhvC73uhjAl5WCJI3ZUlkaEbACqSE4TiyB/9IrPolJL4xY4aDNDd6h8RB2fH5Dur
        jewR6xdHp0ONHJpgcRpSwdTgtJTOMkA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-0_PvrvcsMLaWe9oxDTpISQ-1; Wed, 28 Apr 2021 05:08:27 -0400
X-MC-Unique: 0_PvrvcsMLaWe9oxDTpISQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00D4D19251A4;
        Wed, 28 Apr 2021 09:08:26 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-113.ams2.redhat.com [10.36.113.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48FE919C45;
        Wed, 28 Apr 2021 09:08:24 +0000 (UTC)
Date:   Wed, 28 Apr 2021 11:08:21 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Thomas Huth <thuth@redhat.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] arch/s390/configs: Change CONFIG_VIRTIO_CONSOLE to "m"
Message-ID: <20210428110821.70aa5774.cohuck@redhat.com>
In-Reply-To: <c015ef3f-ff88-113b-a089-e2af9202399a@de.ibm.com>
References: <20210428082442.321327-1-thuth@redhat.com>
        <c015ef3f-ff88-113b-a089-e2af9202399a@de.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, 28 Apr 2021 10:31:54 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 28.04.21 10:24, Thomas Huth wrote:
> > In former times, the virtio-console code had to be compiled into
> > the kernel since the old guest virtio transport had some hard de-
> > pendencies. But since the old virtio transport has been removed in
> > commit 7fb2b2d51244 ("s390/virtio: remove the old KVM virtio transport"),
> > we do not have this limitation anymore.
> > Commit bb533ec8bacd ("s390/config: do not select VIRTIO_CONSOLE via
> > Kconfig") then also lifted the hard setting in the Kconfig system, so
> > we can finally switch the CONFIG_VIRTIO_CONSOLE knob to compile this
> > driver as a module now, making it more flexible for the user to only
> > load it if it is really required.  
> 
> Isnt that a distro specific decision? I would be perfectly fine to have
> this change in Fedora, Redhat and co. Not so sure about defconfig.
> We often use the defconfig in our CI and development things to have a
> kernel config that boots up fine, even without a ramdisk. I agree that
> virtio console is no longer really the most important console but does
> it really hurt? Is any distro using the defconfig unmodified?

Having a value in the defconfig that will be sensible for most users
sounds good to me, independent of what different distros choose to do.
(Or am I misunderstanding the purpose of the defconfig?)

For booting without a ramdisk, I see that virtio-blk and virtio-input
are y, while other virtio drivers are m. That should be sufficient,
shouldn't it?

