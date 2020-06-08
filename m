Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730187AbgFHXQK (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 8 Jun 2020 19:16:10 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 197/606] s390/kexec_file: fix initrd location for kdump kernel
Date: Mon,  8 Jun 2020 19:05:22 -0400
Message-Id: <20200608231211.3363633-197-sashal@kernel.org>
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Philipp Rudo <prudo@linux.ibm.com>, Lianbo Jiang <lijiang@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-s390@vger.kernel.org

From: Philipp Rudo <prudo@linux.ibm.com>

commit 70b690547d5ea1a3d135a4cc39cd1e08246d0c3a upstream.

initrd_start must not point at the location the initrd is loaded into
the crashkernel memory but at the location it will be after the
crashkernel memory is swapped with the memory at 0.

Fixes: ee337f5469fd ("s390/kexec_file: Add crash support to image loader")
Reported-by: Lianbo Jiang <lijiang@redhat.com>
Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
Tested-by: Lianbo Jiang <lijiang@redhat.com>
Link: https://lore.kernel.org/r/20200512193956.15ae3f23@laptop2-ibm.local
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/kernel/machine_kexec_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 8415ae7d2a23..f9e4baa64b67 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -151,7 +151,7 @@ static int kexec_file_add_initrd(struct kimage *image,
 		buf.mem += crashk_res.start;
 	buf.memsz = buf.bufsz;
 
-	data->parm->initrd_start = buf.mem;
+	data->parm->initrd_start = data->memsz;
 	data->parm->initrd_size = buf.memsz;
 	data->memsz += buf.memsz;
 
-- 
2.25.1
