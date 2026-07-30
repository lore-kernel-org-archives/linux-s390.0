Received: from latitanza.investici.org (latitanza.investici.org [185.218.207.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E7E42FCDA;
	Thu, 30 Jul 2026 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.218.207.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785416604; cv=none; b=Wr92rmbINBIdxwbSpzf7Xp1spFdrgJT/Trc99H0Doglrc/VMTEPe3kqaWtL7l9DTFou8dW5x3+udxogzw7wEmNuvNkxpAc8X20rejT+vptMV4TuLgXM5NsKScqUHDUTCoXq05GDONGYZ4gpjU/IrLLxa8ubN2FW5IExBVPSSAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785416604; c=relaxed/simple;
	bh=YI+cG3uvTcybkUbmx3OFff8B646QrjcqhvRWGQvRV5Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=HTdkHizGuPjF+sGYORcYX2hOucf9JB5nfZHauEOrutPlwWiP07jY7scCSS7TPIZCSMmVxJuSO+ebPLghNhfa9QT2Eq7GHjXvXRGk2/+fnUqXzMPSWcrGSTXeTwY3Xf9ir9viyNJB+ndOlLMgL+umXktDJjxDZvsZfznFslQ4FMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=a/GBMYIV; arc=none smtp.client-ip=185.218.207.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="a/GBMYIV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1785416593;
	bh=KLjCSraoKagLL0IOC7QJdTv4uULNlr18eFlQW2agqRs=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=a/GBMYIV81clxhBxfyDuDhBcR22yEL5AUJC2GeAqyijzslBTb6pNp45bAhdKVKDPs
	 NTqijC7hF/OMusdFxn3WSeMCnXzQqDSdaG4sbUZPBy3mM6kf+3xO2CasBMmWKiZXLB
	 G1qDj6OsGFzOJ5R6O971fyDd9gnzRkdtb+DhOVUw=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4h9qBT1FQTzGpRc;
	Thu, 30 Jul 2026 13:03:13 +0000 (UTC)
Received: by mx3.investici.org (Postfix) id 4h9qBS5YK9zGpQv;
	Thu, 30 Jul 2026 13:03:12 +0000 (UTC)
Date: Thu, 30 Jul 2026 14:03:14 +0100
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
Subject: Re: [PATCH v3 1/3] panic: Introduce arch_do_panic
In-Reply-To: <20260730-arch_do_panic-v3-1-d5401e683cdb@linux.ibm.com>
References: <20260730-arch_do_panic-v3-0-d5401e683cdb@linux.ibm.com> <20260730-arch_do_panic-v3-1-d5401e683cdb@linux.ibm.com>
Message-ID: <65A2F80D-9F0A-426C-AA31-AE3472FCE29A@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 30 July 2026 10:23:27 BST, Mete Durlu <meted@linux.ibm.com> wrote:
>Introduce a hook for architectures to put their specific panic handlers.
>s390 and sparc already has ifdef preprocessor checks to execute
>architecture specific code. Pave the way for vpanic() cleanup.
>
>Suggested-by: Sven Schnelle <svens@linux.ibm.com>

Nice.

Reviewed-by: Bradley Morgan <include@grrlz.net>

>Signed-off-by: Mete Durlu <meted@linux.ibm.com>
>---
> include/linux/panic.h | 2 ++
> kernel/panic.c        | 3 +++
> 2 files changed, 5 insertions(+)
>
>diff --git a/include/linux/panic.h b/include/linux/panic.h
>index f1dd417e54b2..98dd7dfd27de 100644
>--- a/include/linux/panic.h
>+++ b/include/linux/panic.h
>@@ -110,4 +110,6 @@ extern void add_taint(unsigned flag, enum lockdep_ok);
> extern int test_taint(unsigned flag);
> extern unsigned long get_taint(void);
> 
>+void arch_do_panic(void);
>+
> #endif	/* _LINUX_PANIC_H */
>diff --git a/kernel/panic.c b/kernel/panic.c
>index 213725b612aa..726a97842232 100644
>--- a/kernel/panic.c
>+++ b/kernel/panic.c
>@@ -567,6 +567,8 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
> 		crash_smp_send_stop();
> }
> 
>+void __weak arch_do_panic(void) {}
>+
> /**
>  * vpanic - halt the system
>  * @fmt: The text string to print
>@@ -756,6 +758,7 @@ void vpanic(const char *fmt, va_list args)
> #endif
> 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
> 
>+	arch_do_panic();
> 	/* Do not scroll important messages printed above */
> 	suppress_printk = 1;
> 
>
>


Thanks!
