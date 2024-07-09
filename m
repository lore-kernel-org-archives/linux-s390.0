Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB45918EA66;
	Tue,  9 Jul 2024 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542339; cv=none; b=afn0ey9DJ+LWLL0IoHDKJcHbi7c2FyA/RyxYE+sSSKiEpBR1K1+FPHbm2hGsgQz14CxpUXm5ScCG/Nidg4LsmDTwtU/2JnISlyncQ76Qq3pBsxHoeobRSdy7g9hFzoUJyOZDymdm/pflBWhH1sY1tsFits2KdMY+VuiyjCh5n+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542339; c=relaxed/simple;
	bh=Uo8THIP+qahbvQHYwUyy1Reg3pWn4lucxMDpZD44Kvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeDJ75dqnpQIP7YkcnGrA0kq/QZ0mxJTWasXShj76g+UUbhP+aUeJW0Iq8Rxj+KKuT0KCod4JbvptYvq3HAIPomC6Ea7j6M7I1B2JkBIQD6JTemLfEtTBWTr+LK2+NcUcHYBPA6YeP/FEVh1di8/hPG9HRBp5YZE0M41E/RZ4tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADPLz1bb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADPLz1bb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E491C4AF07;
	Tue,  9 Jul 2024 16:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542338;
	bh=Uo8THIP+qahbvQHYwUyy1Reg3pWn4lucxMDpZD44Kvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ADPLz1bbx3KHI58GZzH5k07ukegekNdOzYLGrVf61NoEVcTH55LgfrTu+SS1zj4Ll
	 Jr4gIFYQ1IXepm/0uRuuKN4TzdeeD8MRvv3HJ2OITuR3F/OVMy9ZA94oxxPwbTAf/p
	 Kjao7aNDctf3LoKN1TWekM8A/nC25+m4hCYqJU2agQuibB7Ch35YCnBtJJZAbCWLaZ
	 xdoMdiyEvv9D14pMs5rAsvBVGQTcV5iEsILkYvDSKt4Qbl5vfdKSCgBaPSi3vHe2Lz
	 uaAnL1rA68SCnCZayy1XRdv3kDxJAkG1TL3ao6NQQolWGZI5ihX2tSLH0RMzike/bw
	 dmwGYM0be+yyw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Carstens <hca@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	gor@linux.ibm.com,
	justinstitt@google.com,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 08/17] s390/sclp: Fix sclp_init() cleanup on failure
Date: Tue,  9 Jul 2024 12:24:52 -0400
Message-ID: <20240709162517.32584-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162517.32584-1-sashal@kernel.org>
References: <20240709162517.32584-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.162
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
index 2cf7fe131ecec..0830ea42e7c80 100644
--- a/drivers/s390/char/sclp.c
+++ b/drivers/s390/char/sclp.c
@@ -1292,6 +1292,7 @@ sclp_init(void)
 fail_unregister_reboot_notifier:
 	unregister_reboot_notifier(&sclp_reboot_notifier);
 fail_init_state_uninitialized:
+	list_del(&sclp_state_change_event.list);
 	sclp_init_state = sclp_init_state_uninitialized;
 	free_page((unsigned long) sclp_read_sccb);
 	free_page((unsigned long) sclp_init_sccb);
-- 
2.43.0

