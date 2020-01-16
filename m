Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388493AbgAPRGZ (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Jan 2020 12:06:25 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 314/671] s390/kexec_file: Fix potential segment overlap in ELF loader
Date: Thu, 16 Jan 2020 11:59:12 -0500
Message-Id: <20200116170509.12787-51-sashal@kernel.org>
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Philipp Rudo <prudo@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Philipp Rudo <prudo@linux.ibm.com>

[ Upstream commit 6339a3889ad4d0dd930ed7a1e873fb81d3e690f7 ]

When loading an ELF image via kexec_file the segment alignment is ignored
in the calculation for the load address of the next segment. When there are
multiple segments this can lead to segment overlap and thus load failure.

Signed-off-by: Philipp Rudo <prudo@linux.ibm.com>
Fixes: 8be018827154 ("s390/kexec_file: Add ELF loader")
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/kernel/kexec_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/kexec_elf.c b/arch/s390/kernel/kexec_elf.c
index 602e7cc26d11..5cf340b778f1 100644
--- a/arch/s390/kernel/kexec_elf.c
+++ b/arch/s390/kernel/kexec_elf.c
@@ -58,7 +58,7 @@ static int kexec_file_add_elf_kernel(struct kimage *image,
 		if (ret)
 			return ret;
 
-		data->memsz += buf.memsz;
+		data->memsz = ALIGN(data->memsz, phdr->p_align) + buf.memsz;
 	}
 
 	return 0;
-- 
2.20.1
