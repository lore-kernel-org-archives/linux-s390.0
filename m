Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E073955E2;
	Mon, 10 Aug 2026 12:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786363880; cv=none; b=MfBZ0O9pCgFbfPv5Iyf239A/luIjYPDd6KeSEf+fBhSuV2Hw+gWOLqM38FTyC0PArd9a1f2uWT2f2XDS+NSG0cgKWc89B/88bi5UUBJqUvb/o0taNDDqEP3855uXYtQIJ41j1N2L9hwAH3qU52ZnFKN5b6yvZNcQw+gN3jPrJQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786363880; c=relaxed/simple;
	bh=GKCSg9gewmjo5BKbSguox68daGOzHcRSALBUYYHkchM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=S896+oRI0pq62/BhQQO+ubkcttSjEHbQpvMmJ+MzbBMVbAkeSe/Y2xShv7VrAWVs/zyPfbhN4CdUPS0V8gsjrPFXQQJrYfGSMX33d2K0oMaXucoWRC51J3lHMqHiUWr24pOgWb0CVSHpsgJhYMak7ht5NZ0pZEmTuU77/jE7zV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=Onmeiva9; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="Onmeiva9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786363876;
	bh=5jtAstx+MTmu0BBi0TAzaZP6DrdnW789C5m+qe2bSWE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Onmeiva9suyo51mhhhbM3V6gae/eLB19QXce3EzeWQ5TcOGJDaYVXgCJbK1Iqf+Rh
	 emTNCwidO+4i6ZngG+C5rthOrkMtYrRcGS+T6+BpDN1XhGIQ4iplffnRPKCba/ro5+
	 Kr2ddS7L/8emp8C1GNbo8VrWf4F3zQ+yBIo+Mc0E=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4hJYWS0fwwz6vFQ;
	Mon, 10 Aug 2026 12:11:16 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4hJYWR57z2z4y43;
	Mon, 10 Aug 2026 12:11:15 +0000 (UTC)
Date: Mon, 10 Aug 2026 13:11:16 +0100
From: Bradley Morgan <include@grrlz.net>
To: Mete Durlu <meted@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Petr Mladek <pmladek@suse.com>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>
CC: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org
Subject: Re: [PATCH v5 3/3] sparc: Implement arch_do_panic
In-Reply-To: <20260810-arch_do_panic-v5-3-e86ae992c253@linux.ibm.com>
References: <20260810-arch_do_panic-v5-0-e86ae992c253@linux.ibm.com> <20260810-arch_do_panic-v5-3-e86ae992c253@linux.ibm.com>
Message-ID: <963C6504-18B4-4731-95A5-6420EDD0FF8E@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 10 August 2026 12:35:58 BST, Mete Durlu <meted@linux.ibm.com> wrote:
>Implement sparc specific arch_do_panic() instead of using sparc specific
>ifdef sections in vpanic() code.
>Reorder arch specific panic handling, sparc's Stop-A messages are now
>printed after "end Kernel panic" marker.
>

Reviewed-by: Bradley Morgan <include@grrlz.net>

thank you for clearing the ifdeffery..

>Signed-off-by: Mete Durlu <meted@linux.ibm.com>
>---
> arch/sparc/kernel/setup.c | 9 +++++++++
> kernel/panic.c            | 9 ---------
> 2 files changed, 9 insertions(+), 9 deletions(-)
>
>diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
>index 4975867d9001..5f43cef80638 100644
>--- a/arch/sparc/kernel/setup.c
>+++ b/arch/sparc/kernel/setup.c
>@@ -2,6 +2,8 @@
> 
> #include <asm/setup.h>
> #include <linux/sysctl.h>
>+#include <linux/panic.h>
>+#include <linux/printk.h>
> 
> static const struct ctl_table sparc_sysctl_table[] = {
> 	{
>@@ -36,6 +38,13 @@ static const struct ctl_table sparc_sysctl_table[] = {
> #endif
> };
> 
>+void arch_do_panic(void)
>+{
>+	/* Make sure the user can actually press Stop-A (L1-A) */
>+	stop_a_enabled = 1;
>+	pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
>+		 "twice on console to return to the boot prom\n");
>+}
> 
> static int __init init_sparc_sysctls(void)
> {
>diff --git a/kernel/panic.c b/kernel/panic.c
>index ee6e3f9e3900..7dda841c16f9 100644
>--- a/kernel/panic.c
>+++ b/kernel/panic.c
>@@ -744,15 +744,6 @@ void vpanic(const char *fmt, va_list args)
> 			reboot_mode = panic_reboot_mode;
> 		emergency_restart();
> 	}
>-#ifdef __sparc__
>-	{
>-		extern int stop_a_enabled;
>-		/* Make sure the user can actually press Stop-A (L1-A) */
>-		stop_a_enabled = 1;
>-		pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
>-			 "twice on console to return to the boot prom\n");
>-	}
>-#endif
> 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
> 
> 	arch_do_panic();
>
>

Thanks!
