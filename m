Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B65FC433B4
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 08:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DE2061004
	for <linux-s390@archiver.kernel.org>; Wed, 28 Apr 2021 08:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbhD1IZi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Apr 2021 04:25:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27870 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231555AbhD1IZh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Apr 2021 04:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619598292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ae0nzINFLhJdV7eTcKhyVQl+oJwWog7lYQNdVgvDreg=;
        b=HEXY437jvaBg0R7FVc62bKKV/tpbouI7Ot7y8bRRyxcM5fW3xVqyQYjahKQWnj5j8Aelk9
        yfz1lc4XCKiVX64/UOm7Nahy+HgujwsNIRhBlMbgxBL8c0fFfPvlztgTYnBA9VY7mp6Asu
        5KPx6eKoGBJJSXhlHM3gr1LD6F1lmi0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-xVb-s7QMNTqHbArBM3o1YQ-1; Wed, 28 Apr 2021 04:24:49 -0400
X-MC-Unique: xVb-s7QMNTqHbArBM3o1YQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A32B1107ACE3;
        Wed, 28 Apr 2021 08:24:47 +0000 (UTC)
Received: from thuth.com (ovpn-112-95.ams2.redhat.com [10.36.112.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9ED0F772E1;
        Wed, 28 Apr 2021 08:24:45 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Marc Hartmayer <mhartmay@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, cohuck@redhat.com
Subject: [PATCH] arch/s390/configs: Change CONFIG_VIRTIO_CONSOLE to "m"
Date:   Wed, 28 Apr 2021 10:24:42 +0200
Message-Id: <20210428082442.321327-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In former times, the virtio-console code had to be compiled into
the kernel since the old guest virtio transport had some hard de-
pendencies. But since the old virtio transport has been removed in
commit 7fb2b2d51244 ("s390/virtio: remove the old KVM virtio transport"),
we do not have this limitation anymore.
Commit bb533ec8bacd ("s390/config: do not select VIRTIO_CONSOLE via
Kconfig") then also lifted the hard setting in the Kconfig system, so
we can finally switch the CONFIG_VIRTIO_CONSOLE knob to compile this
driver as a module now, making it more flexible for the user to only
load it if it is really required.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/configs/debug_defconfig | 2 +-
 arch/s390/configs/defconfig       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index dc0b69058ac4..04ce0edd0b31 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -548,7 +548,7 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_LEGACY_PTY_COUNT=0
-CONFIG_VIRTIO_CONSOLE=y
+CONFIG_VIRTIO_CONSOLE=m
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_RAW_DRIVER=m
 CONFIG_HANGCHECK_TIMER=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 320379da96d9..e448711eff8d 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -540,7 +540,7 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_SERIO is not set
 CONFIG_LEGACY_PTY_COUNT=0
-CONFIG_VIRTIO_CONSOLE=y
+CONFIG_VIRTIO_CONSOLE=m
 CONFIG_HW_RANDOM_VIRTIO=m
 CONFIG_RAW_DRIVER=m
 CONFIG_HANGCHECK_TIMER=m
-- 
2.27.0

