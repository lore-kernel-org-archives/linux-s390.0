Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC49C433FE
	for <linux-s390@archiver.kernel.org>; Wed,  4 May 2022 15:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiEDQAt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 4 May 2022 12:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352619AbiEDQAo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 May 2022 12:00:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277276542;
        Wed,  4 May 2022 08:57:08 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A53991F74B;
        Wed,  4 May 2022 15:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1651679826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=hG7emcEGn0sS81RKfZEcY3mzY1AE7PXlwENEP7suGv0=;
        b=g4wY94mvZyO+V+p1H2CBHhX6rOIEgjn6VJaUzqhOuZaZX7Z5w3dZMNr2IaH2+kGxfqve9X
        r9KOXvqVpM9FnKRs3k6i4MC+Iqp/CQTkqEI1FyzTVZqXo58XoBlTfaY4/FeC40jLvdkqw2
        cmdfELH/dDTQoTEyFXNI3PahwVKzzWM=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 04953132C4;
        Wed,  4 May 2022 15:57:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XfVKO1GicmLWPAAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 04 May 2022 15:57:05 +0000
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Oleksandr Tyshchenko <olekstysh@gmail.com>
Subject: [PATCH v3 0/2] kernel: add new infrastructure for platform_has() support
Date:   Wed,  4 May 2022 17:57:01 +0200
Message-Id: <20220504155703.13336-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

In another patch series [1] the need has come up to have support for
a generic feature flag infrastructure.

This patch series is introducing that infrastructure and adds the first
use case.

I have decided to use a similar interface as the already known x86
cpu_has() function. As the new infrastructure is meant to be usable for
general and arch-specific feature flags, the flags are being spread
between a general bitmap and an arch specific one.

The bitmaps start all being zero, single features can be set or reset
at any time by using the related platform_[re]set_feature() functions.

The platform_has() function is using a simple test_bit() call for now,
further optimization might be added when needed.

[1]: https://lore.kernel.org/lkml/1650646263-22047-1-git-send-email-olekstysh@gmail.com/T/#t

Juergen Gross (2):
  kernel: add platform_has() infrastructure
  virtio: replace arch_has_restricted_virtio_memory_access()

 MAINTAINERS                            |  8 ++++++++
 arch/s390/Kconfig                      |  1 -
 arch/s390/mm/init.c                    | 13 +++----------
 arch/x86/Kconfig                       |  1 -
 arch/x86/mm/mem_encrypt.c              |  7 -------
 arch/x86/mm/mem_encrypt_amd.c          |  4 ++++
 drivers/virtio/Kconfig                 |  6 ------
 drivers/virtio/virtio.c                |  5 ++---
 include/asm-generic/Kbuild             |  1 +
 include/asm-generic/platform-feature.h |  8 ++++++++
 include/linux/platform-feature.h       | 19 ++++++++++++++++++
 include/linux/virtio_config.h          |  9 ---------
 kernel/Makefile                        |  2 +-
 kernel/platform-feature.c              | 27 ++++++++++++++++++++++++++
 14 files changed, 73 insertions(+), 38 deletions(-)
 create mode 100644 include/asm-generic/platform-feature.h
 create mode 100644 include/linux/platform-feature.h
 create mode 100644 kernel/platform-feature.c

-- 
2.35.3

