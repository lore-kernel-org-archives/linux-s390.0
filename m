Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610B1319843
	for <linux-s390@vger.kernel.org>; Mon, 27 Oct 2025 08:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554868; cv=none; b=t82do7czMQfyKRROdnz3yat9Wt1hbHSI7KhYtTHPe1bKor7brCf7iAdfQPuipq9kf7mrJGFhLY9lBn2qof7ENmwl9CVWmEE0eUb6BR+FvImbiX+9K2IOrqtpnvUVMgm9RgyHbC9u5zDq1RFBgL3CFqZlTyVY6x1KyrHac4OCIFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554868; c=relaxed/simple;
	bh=H71eWvWbWm73Mp7PPsrGR98SqvdbMI0E6aocTIflNDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SwP3lmbzCFNJoon4XHz2YQfA8eD3pT+gk+i1WmNcANkpgwC3gcCP0/TLH8JK9cnkGHok8oANvgm9LdDkN1j7nQ8NejJX7kM86tVqX153C9gs+TZiDiLg59sbuozhIeDZUmLuzuX3d8J7H6EJq6LTvUVmrm92VnKsoQ7yF/aNyzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZBRXvbRw; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZBRXvbRw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761554863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u3H/Kw1PmsEzIN1WuPU7v//SQUe1FpBA2ChXgU+9gCk=;
	b=ZBRXvbRww9Ikl4/7pVjDo78+3jifpQvKQw1BjwT9DfyxVwBb+1TVWnmf0UarnP2OUvguKY
	oV6We5H/iuEVlDzlsV2tViRdLKUQmLO+1tl/FcVUpQfKrsL9cS5U9nzsBFlusl/wraPQXY
	P3gj8EoxlDPeuLF/xcbryVbbXUaGUmE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/nmi: Annotate s390_handle_damage with __noreturn
Date: Mon, 27 Oct 2025 09:47:25 +0100
Message-ID: <20251027084728.1362-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s390_handle_damage() ends by calling the non-returning function
disabled_wait() and therefore also never returns. Annotate it with the
__noreturn compiler attribute to improve compiler optimizations.

Remove the unreachable infinite while loop.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/s390/kernel/nmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 11f33243a23f..a55abbf65333 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -184,7 +184,7 @@ static notrace void nmi_print_info(void)
 	sclp_emergency_printk(message);
 }
 
-static notrace void s390_handle_damage(void)
+static notrace void __noreturn s390_handle_damage(void)
 {
 	struct lowcore *lc = get_lowcore();
 	union ctlreg0 cr0, cr0_new;
@@ -214,7 +214,6 @@ static notrace void s390_handle_damage(void)
 	lc->mcck_new_psw = psw_save;
 	local_ctl_load(0, &cr0.reg);
 	disabled_wait();
-	while (1);
 }
 NOKPROBE_SYMBOL(s390_handle_damage);
 
-- 
2.51.0

