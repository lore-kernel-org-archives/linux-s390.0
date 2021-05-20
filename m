Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29137C433ED
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 11:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF35D60E0B
	for <linux-s390@archiver.kernel.org>; Thu, 20 May 2021 11:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241079AbhETLiY (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 20 May 2021 07:38:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241268AbhETLgW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 20 May 2021 07:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621510500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vNMGpZqxRmHczjMFUilM+26He8KcqebZKfsvADu1AzE=;
        b=bBO30rr1Nbw59l62AYpC6DnL9eMtYj2ThP9ZF1BE1/NYAcOwzOoMH1HBtmaiKDmWTs4H1M
        02Fx2+82/eZKnArX42oH2X9+tIEKLTWHoQuOlOB1Wq9sH/kQNvKFWv0vmvtUNgm7cas2fr
        XvGyG0x841RfRH5FN06I3Ce1l0e1VwQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-VxA7lTOQOmiYNbCTGRk8Dw-1; Thu, 20 May 2021 07:34:56 -0400
X-MC-Unique: VxA7lTOQOmiYNbCTGRk8Dw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 56E36107ACC7;
        Thu, 20 May 2021 11:34:55 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-113-166.ams2.redhat.com [10.36.113.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F248E10016F2;
        Thu, 20 May 2021 11:34:53 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/3] vfio-ccw: some fixes
Date:   Thu, 20 May 2021 13:34:47 +0200
Message-Id: <20210520113450.267893-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20210520

for you to fetch changes up to 2af7a834a435460d546f0cf0a8b8e4d259f1d910:

  vfio-ccw: Serialize FSM IDLE state with I/O completion (2021-05-12 12:59:50 +0200)

----------------------------------------------------------------
Avoid some races in vfio-ccw request handling.

----------------------------------------------------------------

Eric Farman (3):
  vfio-ccw: Check initialized flag in cp_init()
  vfio-ccw: Reset FSM state to IDLE inside FSM
  vfio-ccw: Serialize FSM IDLE state with I/O completion

 drivers/s390/cio/vfio_ccw_cp.c  |  4 ++++
 drivers/s390/cio/vfio_ccw_drv.c | 12 ++++++++++--
 drivers/s390/cio/vfio_ccw_fsm.c |  1 +
 drivers/s390/cio/vfio_ccw_ops.c |  2 --
 4 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.31.1

