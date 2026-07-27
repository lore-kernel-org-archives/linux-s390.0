Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15453E8695;
	Mon, 27 Jul 2026 12:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157181; cv=none; b=XEeplNDvRnEj6P67XhvMs7JWGY5gCfqx637xOzq1MM6euRsAfUtGJkQJIPs2S1pugjS+ITZt/QnSj1jmENxiJRXtbJXqbw6SL6k2sXGtWoJ5z0YnRLu69JghZ9sUHViet3vZ81p0M81oKy53FWGywhkIej/qmkLNkjRQJcgACik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157181; c=relaxed/simple;
	bh=k5wNkK9/L6GBf7F4/P6BxDaGMkuzxeQieDTwu4je06w=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=jUTW2zc8wUKcdQiwKiQ9LV0P7Hl/C5dWQWXBSDLITNtHIk1GmHiMKZf0xJiwhDfm5M5WTDoiwWJAFvbg7krlidks01lWvVoMI1HFtsDuM0us0yCMcNd7l+JtPy1Fy1d4TZeAqkS3QKFtqSZGja2lv9kniXwjQnXFiw7QbKBqock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=LkBf/SwP; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="LkBf/SwP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1785157174;
	bh=2esCigb2YoF6dC0tf3LW+D4h8lV2SoIyBusphk8Rzhc=;
	h=Date:From:To:CC:Subject:In-Reply-To:From;
	b=LkBf/SwP5PDWX9MTPkWRV3XZEtWRCm6/DxukW3AYUxGAQLKHLcD/kCE/wJQSt8yia
	 mI4cuwzOymvWr3j33uLFQi5y2AqsHfsIgf5sKIxO+jZ4jjFDQBjx/FEZsGTbyWvNrw
	 8k7wlYDC3NiB5qYzYMUGSxTVQqF1NORczVYd9rXY=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4h7zFf45blz6vhq;
	Mon, 27 Jul 2026 12:59:34 +0000 (UTC)
Received: by mx2.investici.org (Postfix) id 4h7zFf1Gd2z4y40;
	Mon, 27 Jul 2026 12:59:34 +0000 (UTC)
Date: Mon, 27 Jul 2026 13:59:35 +0100
From: Bradley Morgan <include@grrlz.net>
To: meted@linux.ibm.com
CC: agordeev@linux.ibm.com, akpm@linux-foundation.org, andreas@gaisler.com,
 borntraeger@linux.ibm.com, davem@davemloft.net, gor@linux.ibm.com,
 hca@linux.ibm.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 pmladek@suse.com, sparclinux@vger.kernel.org, svens@linux.ibm.com
Subject: Re: [PATCH v2 1/3] panic: Introduce arch_do_panic
In-Reply-To: <20260727-arch_do_panic-v2-1-4e25ceb05075@linux.ibm.com>
Message-ID: <FF4C0015-29DD-480C-8905-E9594659521E@grrlz.net>
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

> +#ifndef arch_do_panic
> +#define arch_do_panic arch_do_panic
> +static inline void arch_do_panic(void) {}
> +#endif

this is fragile. the arch override only kicks in if whatever header
defines the macro happens to be in panic.c's include chain. if it ever
falls out, the empty stub wins silently, the arch version still
compiles as a global nobody calls, and the hook is just dead. no build
break, no warning, nothing.

use a weak function instead. arch defines the strong symbol and thats
it, no macro dance, no header placement contract, and the silent stub
failure cant happen. nobody cares about an indirect call in the panic
path. something like:

diff --git a/include/linux/panic.h b/include/linux/panic.h
--- a/include/linux/panic.h
+++ b/include/linux/panic.h
@@ -13,6 +13,7 @@ __printf(1, 2)
 void panic(const char *fmt, ...) __noreturn __cold;
 __printf(1, 0)
 void vpanic(const char *fmt, va_list args) __noreturn __cold;
+void arch_do_panic(void);
 void nmi_panic(struct pt_regs *regs, const char *msg);
 void check_panic_on_warn(const char *origin);
 extern void oops_enter(void);
diff --git a/kernel/panic.c b/kernel/panic.c
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -567,6 +567,11 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
 		crash_smp_send_stop();
 }
 
+/* Overridden by architectures with a panic handler of last resort. */
+void __weak arch_do_panic(void)
+{
+}
+
 /**
  * vpanic - halt the system
  * @fmt: The text string to print
@@ -756,6 +761,7 @@ void vpanic(const char *fmt, va_list args)
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
 
+	arch_do_panic();
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
 
untested, and no SoB from me, its a suggestion. if you fold it into v3
its your patch under your own SoB as usual.


(Heh, hope my client don't mutilate this)

the prototype in panic.h also means the arch definitions dont
trip -Wmissing-prototypes, which your version dodges with the macro but
only as long as the header keeps getting pulled in.

> 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
> 
> +	arch_do_panic();

one more thing on the call site: arch code now runs (and prints, on
sparc) after the "end Kernel panic" marker, which until now was the
last line anyone would ever see. tools grep for that as a terminal
marker. probably fine, but say so in the changelog instead of leaving
it implicit.

s/already has/already have/ in the changelog while your at it.

Thanks!
