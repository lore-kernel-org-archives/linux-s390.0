Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB87C1A79EC;
	Tue,  9 Jul 2024 16:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542392; cv=none; b=KJJuZtRYyY/3WnWOtRjivmETXsx5UwjxzQ2WUQ+FcIwQlx4lPlPCRrobzykGlqSuBzlpupAjFbaNQjtE2ZNXVR2szkmGPrN/z6yd1Lj5EYvXP80xu03SBKDeynpBW+i7QQekekmAvO3bgYfk+dZdQnkdXEkXAOaxkpnb92uAJLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542392; c=relaxed/simple;
	bh=boMMWFkcwwqtOkMNdobw81ZVF1ESrJHnVZYCzQPwPlA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d3CbbViZW+mlk1SlrIfBQOE5qwIwtwd17FkfjIdWsubpf4a458abP1n0F/qw0lD0jcfcqguGLudoeOIzE0tQW/9qvCJ0m2rMG1U40w5L5G6UB//+UUd6DYm8Vi79qPf+uy3ah3xtfRVbg7LTk/pptIdxF+2t8KtC539zuo6/LO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQm6T8lC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQm6T8lC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCC8C4AF07;
	Tue,  9 Jul 2024 16:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542392;
	bh=boMMWFkcwwqtOkMNdobw81ZVF1ESrJHnVZYCzQPwPlA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQm6T8lCPn5VQEvEjT7clvMSNLnYSlWuNUh4bxRZMXkFGMm0dqx7Yz+8cUCrCubih
	 dl/miF63eb/vljO3yEj5FyEnPFdluOFtSbZkiuX2MM8bcg2ggvWJkGSvP7wngBYIX7
	 PBamS7vgJDNKH9Ow7Rtlc5/rlSwaJrHFm7eFxLaDJd1+Pqr1ewlnls4bFyfjDfja7M
	 I7mLUSq70E5TRr/Q2LgIHhNFEBontNYk8ZwbfgmatCM7uDISnOjCYlWrBh5Ll2e4Hb
	 iiFxN2WBX+Hlb3tOQpG03cL9omuyMQEGIqOLOYvVfS1Q0KF6rf2RYuJOQ6YzPaMYBR
	 pweEBFDJPXsSQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	justinstitt@google.com,
	kees@kernel.org,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 08/14] s390/sclp: Fix sclp_init() cleanup on failure
Date: Tue,  9 Jul 2024 12:25:52 -0400
Message-ID: <20240709162612.32988-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162612.32988-1-sashal@kernel.org>
References: <20240709162612.32988-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.221
Content-Transfer-Encoding: 8bit

From: Heiko Carstens <hca@linux.ibm.com>

[ Upstream commit 6434b33faaa063df500af355ee6c3942e0f8d982 ]

If sclp_init() fails it only partially cleans up: if there are multiple
failing calls to sclp_init() sclp_state_change_event will be added several
times to sclp_reg_list, which results in the following warning:

------------[ cut here ]------------
list_add double add: new=000003ffe1598c10, prev=000003ffe1598bf0, next=000003ffe1598c10.
WARNING: CPU: 0 PID: 1 at lib/list_debug.c:35 __list_add_valid_or_report+0xde/0xf8
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc3
Krnl PSW : 0404c00180000000 000003ffe0d6076a (__list_add_valid_or_report+0xe2/0xf8)
           R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:0 RI:0 EA:3
...
Call Trace:
 [<000003ffe0d6076a>] __list_add_valid_or_report+0xe2/0xf8
([<000003ffe0d60766>] __list_add_valid_or_report+0xde/0xf8)
 [<000003ffe0a8d37e>] sclp_init+0x40e/0x450
 [<000003ffe00009f2>] do_one_initcall+0x42/0x1e0
 [<000003ffe15b77a6>] do_initcalls+0x126/0x150
 [<000003ffe15b7a0a>] kernel_init_freeable+0x1ba/0x1f8
 [<000003ffe0d6650e>] kernel_init+0x2e/0x180
 [<000003ffe000301c>] __ret_from_fork+0x3c/0x60
 [<000003ffe0d759ca>] ret_from_fork+0xa/0x30

Fix this by removing sclp_state_change_event from sclp_reg_list when
sclp_init() fails.

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/char/sclp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/char/sclp.c b/drivers/s390/char/sclp.c
index d2ab3f07c008c..8296e6bc229ee 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -1208,6 +1208,7 @@ sclp_init(void)
 fail_unregister_reboot_notifier:
 	unregister_reboot_notifier(&sclp_reboot_notifier);
 fail_init_state_uninitialized:
+	list_del(&sclp_state_change_event.list);
 	sclp_init_state = sclp_init_state_uninitialized;
 	free_page((unsigned long) sclp_read_sccb);
 	free_page((unsigned long) sclp_init_sccb);
-- 
2.43.0

