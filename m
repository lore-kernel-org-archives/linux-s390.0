Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B248940B0E6;
	Mon, 27 Jul 2026 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157362; cv=none; b=oz0PpAQclMu9eoZDCRVmUzz4mhzYx2d+0688jhKJj5RAENpEX1yPvLFgI34hnBgT75E4t9U6Lbftt8Bk5wK0pBGNFWZCF9ai7gT1B9MWs4kHOQGWEADG3qhnQQQHGOMofDMTGo0Yw05FnFRZ4hPnYcAqL6sqCR9Zx+QthF6Nj+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157362; c=relaxed/simple;
	bh=Y0cNoOG+Z7Zv0CT94F7P5igAc1A8mg6AulCNxYxzKdc=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=FOfzfw/kUQpHKNJQVb4OPQex5rZBOuAb2SjH0OuXVsQakokZMSajymNClI6XwYr1JNYrrGMX6D0oPwk2jkA/G0NXV1L7c0V2sOauFCwIWHEDK/HZAQLhK4z3QAofViDK4a9fWqCr4c5jHLBqxfO5kR2DOsiB+/iBPmw1k1QU1jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=fWU2VYdG; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="fWU2VYdG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1785157357;
	bh=qLRrYJt1j4ax6qeA8XXxa77UlyQ4E7SDckSBJJS4grk=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=fWU2VYdGoyCn1bl5YirKBkVB6Wqd70CTuPO6dRzDbtylsSwNpj7XeylhS/EDGjfbT
	 auApOcmDNsMoT4hFgBMn3S7TX4OUMn+1OrEVKwmaITg4DWa4UmSOcf7o52pDl4D1aj
	 8G0fjbtEAuU0HFNJ7X9oAqZFGkVfXcRGt9nJEMiE=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4h7zK93TPnzGpVM;
	Mon, 27 Jul 2026 13:02:37 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4h7zK91P76zGpVJ;
	Mon, 27 Jul 2026 13:02:37 +0000 (UTC)
Date: Mon, 27 Jul 2026 14:02:39 +0100
From: Bradley Morgan <include@grrlz.net>
To: meted@linux.ibm.com
CC: agordeev@linux.ibm.com, akpm@linux-foundation.org, andreas@gaisler.com,
 borntraeger@linux.ibm.com, davem@davemloft.net, gor@linux.ibm.com,
 hca@linux.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 pmladek@suse.com, sparclinux@vger.kernel.org, svens@linux.ibm.com
Subject: Re: [PATCH v2 3/3] sparc: Implement arch_do_panic
In-Reply-To: <20260727-arch_do_panic-v2-3-4e25ceb05075@linux.ibm.com>
Message-ID: <7B104DF1-518B-461A-982F-85738700D6CD@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Hi Mete,

the move itself is right. with the weak function from patch 1 the
asm/bug.h hunk goes away, and the asm/setup.h hunk deleting a blank
line is unrelated churn that shouldnt be here either. what remains:

diff --git a/arch/sparc/kernel/setup.c b/arch/sparc/kernel/setup.c
--- a/arch/sparc/kernel/setup.c
+++ b/arch/sparc/kernel/setup.c
@@ -36,6 +36,15 @@ static const struct ctl_table sparc_sysctl_table[] = {
 #endif
 };
 
+void arch_do_panic(void)
+{
+	extern int stop_a_enabled;
+
+	/* Make sure the user can actually press Stop-A (L1-A) */
+	stop_a_enabled = 1;
+	pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
+		 "twice on console to return to the boot prom\n");
+}
 
 static int __init init_sparc_sysctls(void)
 {
diff --git a/kernel/panic.c b/kernel/panic.c
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -747,15 +747,6 @@ void vpanic(const char *fmt, va_list args)
 			reboot_mode = panic_reboot_mode;
 		emergency_restart();
 	}
-#ifdef __sparc__
-	{
-		extern int stop_a_enabled;
-		/* Make sure the user can actually press Stop-A (L1-A) */
-		stop_a_enabled = 1;
-		pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
-			 "twice on console to return to the boot prom\n");
-	}
-#endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 
 	arch_do_panic();

suggestion only, no SoB from me, its yours to fold into v3.

note the Stop A message now prints after the "end Kernel panic"
marker instead of before it. thats the call site from patch 1 doing
that, im ok with it, but it wants a sentence in the changelog.

with the stray hunks gone this looks good to me.
Thanks!
