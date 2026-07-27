Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326D340EBAD;
	Mon, 27 Jul 2026 13:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157318; cv=none; b=KAfJ79tGghZoV44X9T9OHdJbCX+Nd+O/zRcAANBwbgs08Y5ujoGNrH2FHn+bfrCZndtdBafehbax+A5s6D/u+sg82YEl7w9Vil93umsuafyT0tLERVKMutskISddQ8tRWJTLzhX6x+qFGsAQGNw8weGZoS80bvkrjVuoI0Gc5P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157318; c=relaxed/simple;
	bh=vRmwV93Fa18w+kcitfqwkvEVqIYApp5K9/Ak61EQLSQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=rhiUbUUzmF6LWkxXxRFvvUhdFoqD6yN7T52rmPWeZvkUWXzEC8TzY3KrMveNdPj5AFDqz/weCnN7hII1r8Z/jFM3Qk0Dn7ZJ0iYXQU3hxIJcQon2UAPw6QIdLRijCDRCzku0H0eVbb+80V10s2GlJJ6s7JNdtC57oHLZwZJWI9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=msTbvKaj; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="msTbvKaj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1785157312;
	bh=wEmLxfActWCi8y9KKOsCUmr4+jkf6zkWnHyr22idtFg=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=msTbvKaj8rPmEoxaYi9vGO7N5dPT6pu11Qyq4YSQ+2+CVi4tyNVaaOTdG/2y9dtsJ
	 BliTaII6vCaGCoioBY3q4dYaD1w4ly7z5pYW6rrOOaWOWG1KktJ0fn+pq9xDcA7r5C
	 BdGBuSfRnvLBE7sjQ4Ufpf1v3eFqb4CXaSnI5aFo=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4h7zJJ4NG3zGpKq;
	Mon, 27 Jul 2026 13:01:52 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4h7zJJ1zx9zGpDy;
	Mon, 27 Jul 2026 13:01:52 +0000 (UTC)
Date: Mon, 27 Jul 2026 14:01:54 +0100
From: Bradley Morgan <include@grrlz.net>
To: meted@linux.ibm.com
CC: agordeev@linux.ibm.com, akpm@linux-foundation.org, andreas@gaisler.com,
 borntraeger@linux.ibm.com, davem@davemloft.net, gor@linux.ibm.com,
 hca@linux.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 pmladek@suse.com, sparclinux@vger.kernel.org, svens@linux.ibm.com
Subject: Re: [PATCH v2 2/3] s390: Implement arch_do_panic
In-Reply-To: <20260727-arch_do_panic-v2-2-4e25ceb05075@linux.ibm.com>
Message-ID: <8E5EEFE6-C655-4319-B659-E3817DD24954@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

Mete,

> -#endif
> -#if defined(CONFIG_S390)
> -	disabled_wait();
> -#endif

removal is fine, this was unreachable anyway. the notifier ran
do_panic() which ends in stop_run(), so nothing ever came back to hit
this disabled_wait().

> +void arch_do_panic(void);
> +#define arch_do_panic arch_do_panic

with the weak function i suggested on patch 1, this whole asm/setup.h
hunk disappears and the patch shrinks to exactly the parts that mean
something:

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -2115,7 +2115,7 @@ static ssize_t on_panic_store(struct kobject *kobj,
 }
 static struct kobj_attribute on_panic_attr = __ATTR_RW(on_panic);
 
-static void do_panic(void)
+void arch_do_panic(void)
 {
 	lgr_info_log();
 	on_panic_trigger.action->fn(&on_panic_trigger);
@@ -2331,18 +2331,6 @@ static int __init vmcmd_on_poff_setup(char *str)
 }
 __setup("vmpoff=", vmcmd_on_poff_setup);
 
-static int on_panic_notify(struct notifier_block *self,
-			   unsigned long event, void *data)
-{
-	do_panic();
-	return NOTIFY_OK;
-}
-
-static struct notifier_block on_panic_nb = {
-	.notifier_call = on_panic_notify,
-	.priority = INT_MIN,
-};
-
 void __init setup_ipl(void)
 {
 	BUILD_BUG_ON(sizeof(struct ipl_parameter_block) != PAGE_SIZE);
@@ -2375,7 +2363,6 @@ void __init setup_ipl(void)
 		/* We have no info to copy */
 		break;
 	}
-	atomic_notifier_chain_register(&panic_notifier_list, &on_panic_nb);
 }
 
 void __no_stack_protector s390_reset_system(void)
diff --git a/kernel/panic.c b/kernel/panic.c
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -755,9 +755,6 @@ void vpanic(const char *fmt, va_list args)
 		pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
 			 "twice on console to return to the boot prom\n");
 	}
-#endif
-#if defined(CONFIG_S390)
-	disabled_wait();
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 
same deal, suggestion only, no SoB from me, fold it in under yours.
check whether linux/panic_notifier.h is still needed in ipl.c after
the notifier goes away.

> This now means that the panic_timeout value takes precedence over user
> defined on_panic behavior.

this is the part i want to poke at. distros routinely ship panic=N on
the cmdline. with this change, anyone who configured on_panic=dump on
such a system silently stops getting dumps, because
emergency_restart() runs first and never returns. a reboot instead of
the dump you explicitly asked for is strictly worse. if you and Sven
want that semantic, fine, but spell it out properly and give the s390
docs for on_panic a line about the new precedence.

also worth saying in the changelog what this actually wins: today the
INT_MIN notifier never returns, so sys_info, kmsg_dump, the post
notifier crash_kexec path, the console flushes and the end banner
never execute on s390 once on_panic fires. after this patch they all
do. thats the headline and the changelog undersells it.

> Fixes: ff6b8ea68f4b ("[S390] ipl/dump on panic.")

What's broken? What's buggy? I'm sure this is just a behaviour 
change, could you either

1: Drop the fixes tag
2: Put in the changelog What's broken and why?


s/now allow/now allows/ in the changelog..
Thanks!
