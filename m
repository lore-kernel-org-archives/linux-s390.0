Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C03C47089
	for <linux-s390@archiver.kernel.org>; Thu, 27 May 2021 06:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C36613C5
	for <linux-s390@archiver.kernel.org>; Thu, 27 May 2021 06:33:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhE0Gez (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 27 May 2021 02:34:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229868AbhE0Gey (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 May 2021 02:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622097200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nHImtBYkw4lCcg0C5T7A+w8BKD0CNflxB4DhqBvnb7E=;
        b=VEJLzzejcHMnAUFa8cmM2HJlY7OvciWIFv5M/8p7ISs+tfDsRoFhGcy9ZiYf/99BhjH52k
        PQ/9m/ffTo64LhGuXQPHXW1lN4h/UZKKGRb07wNxG66Nh0LpQaRa3Jh1GdOxg0/D6BTF2R
        SIDPu23dbVrkPxW8AXBAG/DUKUTBmHk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-hFVtQeprPU69iecJpCDfrw-1; Thu, 27 May 2021 02:33:18 -0400
X-MC-Unique: hFVtQeprPU69iecJpCDfrw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4BBB18766D4;
        Thu, 27 May 2021 06:33:16 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-46.ams2.redhat.com [10.36.113.46])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BF4BF5C3E9;
        Thu, 27 May 2021 06:33:15 +0000 (UTC)
Date:   Thu, 27 May 2021 08:33:13 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Subject: b4 usage (was: [PULL 0/3] vfio-ccw: some fixes)
Message-ID: <20210527083313.0f5b9553.cohuck@redhat.com>
In-Reply-To: <your-ad-here.call-01622068380-ext-9894@work.hours>
References: <20210520113450.267893-1-cohuck@redhat.com>
        <your-ad-here.call-01622068380-ext-9894@work.hours>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, 27 May 2021 00:33:00 +0200
Vasily Gorbik <gor@linux.ibm.com> wrote:

> On Thu, May 20, 2021 at 01:34:47PM +0200, Cornelia Huck wrote:
> > The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad6=
27b5:
> >=20
> >   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> >=20
> > are available in the Git repository at:
> >=20
> >   https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git =
tags/vfio-ccw-20210520
> >=20
> > for you to fetch changes up to 2af7a834a435460d546f0cf0a8b8e4d259f1d910:
> >=20
> >   vfio-ccw: Serialize FSM IDLE state with I/O completion (2021-05-12 12=
:59:50 +0200)
> >=20
> > ----------------------------------------------------------------
> > Avoid some races in vfio-ccw request handling.
> >=20
> > ----------------------------------------------------------------
> >=20
> > Eric Farman (3):
> >   vfio-ccw: Check initialized flag in cp_init()
> >   vfio-ccw: Reset FSM state to IDLE inside FSM
> >   vfio-ccw: Serialize FSM IDLE state with I/O completion =20
>=20
> Pulled into fixes, thanks.
>=20
> BTW, linux-s390@vger.kernel.org is now archived on lore and we started

Oh, nice.

> using b4 (https://git.kernel.org/pub/scm/utils/b4/b4.git) to pick up
> changes. Besides all other features, it can convert Message-Id: to Link:

I've been using b4 to pick patches (Linux and especially QEMU) for
quite some time now, but never felt the need to convert Message-Id: to
Link:. If you prefer the Link: format, I can certainly start using that
for kernel patches.

>=20
> Hm, and b4 also now complains:
> =E2=9C=97 BADSIG: DKIM/ibm.com
> have to look into that...
>=20

