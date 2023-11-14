Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AEEC4167D
	for <linux-s390@archiver.kernel.org>; Tue, 14 Nov 2023 09:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjKNJRk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Nov 2023 04:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjKNJRi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Nov 2023 04:17:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2631BC
        for <linux-s390@vger.kernel.org>; Tue, 14 Nov 2023 01:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699953438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FCQMK3tvMnlcAutGAmjADx8NXWTNg1Te+2YY/zMRKiU=;
        b=anZkM5ruqyZJHCY3dT7uv4HJXqnCXrS9hhb/ylQdWyFBF3i7yHowD9AEeVjD7Fa/OTtEeZ
        eL5HJuT6Be8EAHkB4M7UvffmdYTdZ04+ZBUpffH6cpm48Qul8qAOkNZQIIsHnjL3d2Fguw
        XDqE7Hcp7r/IMb77EtivahOKJ1JnAw4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-AtEvHmVsOLW5Ae-g10RPxA-1; Tue, 14 Nov 2023 04:17:15 -0500
X-MC-Unique: AtEvHmVsOLW5Ae-g10RPxA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EB275101A53B;
        Tue, 14 Nov 2023 09:17:14 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E3A2D2166B26;
        Tue, 14 Nov 2023 09:17:10 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, x86@kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        akpm@linux-foundation.org, ebiederm@xmission.com,
        takahiro.akashi@linaro.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH 2/2] kexec_file: Load kernel at top of system RAM if required
Date:   Tue, 14 Nov 2023 17:16:58 +0800
Message-ID: <20231114091658.228030-3-bhe@redhat.com>
In-Reply-To: <20231114091658.228030-1-bhe@redhat.com>
References: <20231114091658.228030-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Kexec_load interface has been doing top down searching and loading
kernel/initrd/purgtory etc to prepare for kexec reboot. In that way,
the benefits are that it avoids to consume and fragment limited low
memory which satisfy DMA buffer allocation and big chunk of continuous
memory during system init; and avoids to stir with BIOS/FW reserved
or occupied areas, or corner case handling/work around/quirk occupied
areas when doing system init. By the way, the top-down searching and
loading of kexec-ed kernel is done in user space utility code.

For kexec_file loading, even if kexec_buf.top_down is 'true', it's simply
ignored. It calls walk_system_ram_res() directly to go through all
resources of System RAM bottom up, to find an available memory region,
then call locate_mem_hole_callback() to allocate memory in that found
memory region from top to down. This is not expected and inconsistent
with kexec_load.

Here check if kexec_buf.top_down is 'true' in kexec_walk_resources(),
if yes, call the newly added walk_system_ram_res_rev() to find memory
region of system RAM from top to down to load kernel/initrd etc.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index f9a419cd22d4..ba3ef30921b8 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -592,6 +592,8 @@ static int kexec_walk_resources(struct kexec_buf *kbuf,
 					   IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
 					   crashk_res.start, crashk_res.end,
 					   kbuf, func);
+	else if (kbuf->top_down)
+		return walk_system_ram_res_rev(0, ULONG_MAX, kbuf, func);
 	else
 		return walk_system_ram_res(0, ULONG_MAX, kbuf, func);
 }
-- 
2.41.0

