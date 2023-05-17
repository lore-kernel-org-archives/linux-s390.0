Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC63C77B7A
	for <linux-s390@archiver.kernel.org>; Wed, 17 May 2023 14:34:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjEQOeD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 17 May 2023 10:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231980AbjEQOeC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 17 May 2023 10:34:02 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54ADD728A
        for <linux-s390@vger.kernel.org>; Wed, 17 May 2023 07:33:54 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-75773956860so51424685a.0
        for <linux-s390@vger.kernel.org>; Wed, 17 May 2023 07:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684334033; x=1686926033;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e3oHRvM4+O+XVaUuEdehDkOXM012vn7RckSkGvna424=;
        b=fu1tzDMU/Og/xO2VDVrDn7AMjoYSOOqIHHpkafFQsXAXa7bAquEW8FLCbTstV+4LMK
         WozWorjMKA6Ye6vd/CWIiTxdEYThpduYehQ0CQ0WfYzDYjo3Vb2D2M2rgHnkpqG2DoOG
         hFYTNMutL1PBlKS5Sm6U/taMV6kJ+5c+nFWzW2BnEmFKQvrQZqgN1lt1MaOoYlFovyr9
         7rwdJcPszNNgJz0aUNWpj3BWju7B7DitjFIRX5EHLLPdarguqNTfEhlBsUlRfiyyggcm
         rmyPk1XWlhvVmYgOtYCrVpLjW2EGN4HHxXkb5Vh4zDOUpaw4fdaI2HH4gyNooTHomACq
         60Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684334033; x=1686926033;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3oHRvM4+O+XVaUuEdehDkOXM012vn7RckSkGvna424=;
        b=V5d53okWoTUI61sDcI4vH751rXBcA3bWBG6BkcDNvUcoROl80jZD6ji3Ekr1eUlLta
         HLxPFUAbROm0wnoPU/F68E8eD8EmtLi6CjrIHzK/zK8t0FFaOgTuR+5Zjgrvh2boqLFR
         U16u17uF6bQy+7zXUQ551WuDw5z/IsS6lGei2BsiccXta3gyyqy+h2y5Z1YeYXIi/FRv
         L4awnteOg9uRlmadl1OqV8QUOjonWjvVma7rxgZi5DbRHB4CviTGw9on9uPA8H1vHmlb
         PsiQtWHqwKEi/ZyshlFAWy1Cl17LWXAr/nFqYA66HSReIAQrYfnWyKEcWwzRZ2e+I3T1
         4Z4w==
X-Gm-Message-State: AC+VfDwtXQBIwGdcAQubruUxo2tjxcuqudombZGjRkj97k0SiSd1sV3s
        APUGlzWHDF70t5OfZ1thAM//
X-Google-Smtp-Source: ACHHUZ62YidM3zKdwt9WsXpqyD57MEzZUZPKzKjSHJhQM0a+oKDUHR+Gn6BJRSHZwAJwHcpYfUyurw==
X-Received: by 2002:ac8:5c91:0:b0:3ef:5ba0:7038 with SMTP id r17-20020ac85c91000000b003ef5ba07038mr73060971qta.21.1684334033429;
        Wed, 17 May 2023 07:33:53 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id d19-20020a05620a159300b0075914b01c29sm645867qkk.70.2023.05.17.07.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 07:33:52 -0700 (PDT)
Date:   Wed, 17 May 2023 10:33:52 -0400
Message-ID: <e1a07eed22cb33af2733bdffe42b09f0.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Eric Paris <eparis@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        audit@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Subject: Re: [PATCH 4/14] audit: avoid missing-prototype warnings
References: <20230517131102.934196-5-arnd@kernel.org>
In-Reply-To: <20230517131102.934196-5-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On May 17, 2023 Arnd Bergmann <arnd@kernel.org> wrote:
> 
> Building with 'make W=1' reveals two function definitions without
> a previous prototype in the audit code:
> 
> lib/compat_audit.c:32:5: error: no previous prototype for 'audit_classify_compat_syscall' [-Werror=missing-prototypes]
> kernel/audit.c:1813:14: error: no previous prototype for 'audit_serial' [-Werror=missing-prototypes]
> 
> The first one needs a declaration from linux/audit.h but cannot
> include that header without causing conflicting (compat) syscall number
> definitions, so move the it into linux/audit_arch.h.
> 
> The second one is declared conditionally based on CONFIG_AUDITSYSCALL
> but needed as a local function even when that option is disabled, so
> move the declaration out of the #ifdef block.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  include/linux/audit.h      | 2 --
>  include/linux/audit_arch.h | 2 ++
>  kernel/audit.h             | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 31086a72e32a..6a3a9e122bb5 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -130,8 +130,6 @@ extern unsigned compat_dir_class[];
>  extern unsigned compat_chattr_class[];
>  extern unsigned compat_signal_class[];
>  
> -extern int audit_classify_compat_syscall(int abi, unsigned syscall);
> -
>  /* audit_names->type values */
>  #define	AUDIT_TYPE_UNKNOWN	0	/* we don't know yet */
>  #define	AUDIT_TYPE_NORMAL	1	/* a "normal" audit record */
> diff --git a/include/linux/audit_arch.h b/include/linux/audit_arch.h
> index 8fdb1afe251a..0e34d673ef17 100644
> --- a/include/linux/audit_arch.h
> +++ b/include/linux/audit_arch.h
> @@ -21,4 +21,6 @@ enum auditsc_class_t {
>  	AUDITSC_NVALS /* count */
>  };
>  
> +extern int audit_classify_compat_syscall(int abi, unsigned syscall);
> +
>  #endif
> diff --git a/kernel/audit.h b/kernel/audit.h
> index c57b008b9914..94738bce40b2 100644
> --- a/kernel/audit.h
> +++ b/kernel/audit.h
> @@ -259,8 +259,8 @@ extern struct tty_struct *audit_get_tty(void);
>  extern void audit_put_tty(struct tty_struct *tty);
>  
>  /* audit watch/mark/tree functions */
> -#ifdef CONFIG_AUDITSYSCALL
>  extern unsigned int audit_serial(void);
> +#ifdef CONFIG_AUDITSYSCALL
>  extern int auditsc_get_stamp(struct audit_context *ctx,
>  			      struct timespec64 *t, unsigned int *serial);

We probably should move the audit_serial() and auditsc_get_stamp()
away from the watch/mark/tree functions, but that isn't your problem.

Anyway, this looks okay to me; do you have a problem if I merge this
via the audit/next branch or were you hoping to have this go in
through a different tree?

--
paul-moore.com
