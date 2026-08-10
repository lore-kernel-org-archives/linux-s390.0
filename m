Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD413C6606;
	Mon, 10 Aug 2026 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786363325; cv=none; b=tF9RPG7TIf2xPCO53xiWyqVaqW5n9tEhr8hb1arRoQAmawuorvMfzDWZshtacyQJVU2lQuoAgMggU9c8B9idvT/rukgt8GHKMf7oUVijEm4VgINX714mWshksr4b9mtbmMFWV53NuG0KmTwa8Uuhl/8bMm1f7YCfRCjPavE0aUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786363325; c=relaxed/simple;
	bh=LaxH5pd0afJmmqCtk+AoFhcgtfYL8tCLUuKKzjrP7O0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ULbSGSp3hs06Cia9PfhU9JKiq//pnvLskpfOMuC1x8/ITVyazCeEfg7EX0GlSJlimzcKXp6UvAbp9deM4v5ns8qQD84/Jc8hJTIjTY0DrHCnft6Eje8ykAbhERWaZryIC1boOK5pu6NCfQuJschzyZOn5P2qFgZFnVVJ4Z5eX8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=kxMuXODo; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="kxMuXODo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1786363312;
	bh=3cfmHDED700Hy4UknGGjQVZX58clxs7NkKnxYCghlj4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=kxMuXODoa6ucHGfqOJQbTEaqZdfDOpuDSMFwsUAUoAmX24Vs2x3dJ825/8qhDSguf
	 7fL1VfriDYDLfRVVVmLjpCfrkgkFz019L9v/BJh3yJM3j67y6edSohz58RZw3BQk9U
	 pA1gGtfP3xT78Oag93Sgnx+rHTEodlQX5PzEwUEM=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4hJYJc6vmFzGpMH;
	Mon, 10 Aug 2026 12:01:52 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4hJYJc4pJJzGpMF;
	Mon, 10 Aug 2026 12:01:52 +0000 (UTC)
Date: Mon, 10 Aug 2026 13:01:53 +0100
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
Subject: Re: [PATCH v5 2/3] s390: Implement arch_do_panic()
In-Reply-To: <20260810-arch_do_panic-v5-2-e86ae992c253@linux.ibm.com>
References: <20260810-arch_do_panic-v5-0-e86ae992c253@linux.ibm.com> <20260810-arch_do_panic-v5-2-e86ae992c253@linux.ibm.com>
Message-ID: <F6A6B990-849D-4F95-B503-8DB33C493ADA@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 10 August 2026 12:35:57 BST, Mete Durlu <meted@linux.ibm.com> wrote:
>Implement s390 specific arch_do_panic() instead of using s390 specific
>ifdef sections in vpanic() code. disabled_wait() is now called after
>"end Kernel panic" marker.
>No functional changes.
>

Can't see anything wrong, code wise

Reviewed-by: Bradley Morgan <include@grrlz.net>



>Signed-off-by: Mete Durlu <meted@linux.ibm.com>
>---
> arch/s390/kernel/traps.c | 7 +++++++
> kernel/panic.c           | 3 ---
> 2 files changed, 7 insertions(+), 3 deletions(-)
>
>diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
>index 564403496a7c..309d3d3e95fd 100644
>--- a/arch/s390/kernel/traps.c
>+++ b/arch/s390/kernel/traps.c
>@@ -24,6 +24,7 @@
> #include <linux/entry-common.h>
> #include <linux/kmsan.h>
> #include <linux/bug.h>
>+#include <linux/panic.h>
> #include <asm/entry-percpu.h>
> #include <asm/asm-extable.h>
> #include <asm/irqflags.h>
>@@ -31,6 +32,7 @@
> #include <asm/vtime.h>
> #include <asm/fpu.h>
> #include <asm/fault.h>
>+#include <asm/processor.h>
> #include "entry.h"
> 
> static inline void __user *get_trap_ip(struct pt_regs *regs)
>@@ -275,6 +277,11 @@ static void monitor_event_exception(struct pt_regs *regs)
> 	}
> }
> 

Comment? I mean, its a suggestion, but it's not strictly needed

>+void arch_do_panic(void)
>+{
>+	disabled_wait();
>+}
>+
> void kernel_stack_invalid(struct pt_regs *regs)
> {
> 	/*
>diff --git a/kernel/panic.c b/kernel/panic.c
>index 726a97842232..ee6e3f9e3900 100644
>--- a/kernel/panic.c
>+++ b/kernel/panic.c
>@@ -752,9 +752,6 @@ void vpanic(const char *fmt, va_list args)
> 		pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
> 			 "twice on console to return to the boot prom\n");
> 	}
>-#endif
>-#if defined(CONFIG_S390)
>-	disabled_wait();
> #endif
> 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
> 
>
>

Thanks!
