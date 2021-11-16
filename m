Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F969C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 16 Nov 2021 03:32:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FB2861B96
	for <linux-s390@archiver.kernel.org>; Tue, 16 Nov 2021 03:32:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244627AbhKPDfL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 15 Nov 2021 22:35:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55145 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242204AbhKPDeH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 15 Nov 2021 22:34:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637033469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vsr7tOPK7Y5VuSVrTKiVhFvojkVdBSuchZU9h7bR2Gw=;
        b=IXk4hCFiBHEkIyZy4i0tD0ATJoIptgzp6eYpxBR1dlnNDeQypU3gsu8Nkhx/jlRJ0X3IA4
        25liE3E8VJVGy9aOcrW7jeRWHg6G5dm985+XvEWrB3HiAT4T5L9ypQ/oKqGyiXiNRgnU8k
        Ka/NQtPH/QY2RNGvJdG6x5s6l8T4/pA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-tlJoC0S5PrauTgW0IdJC_w-1; Mon, 15 Nov 2021 22:31:05 -0500
X-MC-Unique: tlJoC0S5PrauTgW0IdJC_w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D39D315721;
        Tue, 16 Nov 2021 03:31:04 +0000 (UTC)
Received: from localhost (ovpn-12-162.pek2.redhat.com [10.72.12.162])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A9DF60BE5;
        Tue, 16 Nov 2021 03:31:03 +0000 (UTC)
Date:   Tue, 16 Nov 2021 11:31:01 +0800
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, kexec@lists.infradead.org,
        hca@linux.ibm.com, prudo@redhat.com
Subject: [PATCH v2 RESEND 2/2] s390/kexec: fix memory leak of ipl report
 buffer
Message-ID: <20211116033101.GD21646@MiWiFi-R3L-srv>
References: <20211116032557.14075-1-bhe@redhat.com>
 <20211116032557.14075-2-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116032557.14075-2-bhe@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

unreferenced object 0x38000195000 (size 4096):
  comm "kexec", pid 8548, jiffies 4294953647 (age 32443.270s)
  hex dump (first 32 bytes):
    00 00 00 c8 20 00 00 00 00 00 00 c0 02 80 00 00  .... ...........
    40 40 40 40 40 40 40 40 00 00 00 00 00 00 00 00  @@@@@@@@........
  backtrace:
    [<0000000011a2f199>] __vmalloc_node_range+0xc0/0x140
    [<0000000081fa2752>] vzalloc+0x5a/0x70
    [<0000000063a4c92d>] ipl_report_finish+0x2c/0x180
    [<00000000553304da>] kexec_file_add_ipl_report+0xf4/0x150
    [<00000000862d033f>] kexec_file_add_components+0x124/0x160
    [<000000000d2717bb>] arch_kexec_kernel_image_load+0x62/0x90
    [<000000002e0373b6>] kimage_file_alloc_init+0x1aa/0x2e0
    [<0000000060f2d14f>] __do_sys_kexec_file_load+0x17c/0x2c0
    [<000000008c86fe5a>] __s390x_sys_kexec_file_load+0x40/0x50
    [<000000001fdb9dac>] __do_syscall+0x1bc/0x1f0
    [<000000003ee4258d>] system_call+0x78/0xa0

Signed-off-by: Baoquan He <bhe@redhat.com>
Fixes: 99feaa717e55 ("s390/kexec_file: Create ipl report and pass to next kernel")
---
RESEND:
  Fix the incorrect subject.

 arch/s390/include/asm/kexec.h         | 7 +++++++
 arch/s390/kernel/machine_kexec_file.c | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index ea398a05f643..bbe125dd0329 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -74,6 +74,13 @@ void *kexec_file_add_components(struct kimage *image,
 int arch_kexec_do_relocs(int r_type, void *loc, unsigned long val,
 			 unsigned long addr);
 
+#define ARCH_HAS_KIMAGE_ARCH
+
+struct kimage_arch {
+        void *ipl_buf;
+};
+
+
 extern const struct kexec_file_ops s390_kexec_image_ops;
 extern const struct kexec_file_ops s390_kexec_elf_ops;
 
diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 17e961975624..7f51837e9bc2 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -205,6 +205,7 @@ static int kexec_file_add_ipl_report(struct kimage *image,
 		return ret;
 	buf.bufsz = data->report->size;
 	buf.memsz = buf.bufsz;
+	image->arch.ipl_buf = buf.buffer;
 
 	data->memsz += buf.memsz;
 
@@ -325,3 +326,11 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 	}
 	return 0;
 }
+
+int arch_kimage_file_post_load_cleanup(struct kimage *image)
+{
+	kvfree(image->arch.ipl_buf);
+	image->arch.ipl_buf = NULL;
+
+	return kexec_image_post_load_cleanup_default(image);
+}
-- 
2.17.2

