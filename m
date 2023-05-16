Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE85AC77B75
	for <linux-s390@archiver.kernel.org>; Tue, 16 May 2023 16:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjEPQmq (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 16 May 2023 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjEPQmp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 16 May 2023 12:42:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCCBA5ED;
        Tue, 16 May 2023 09:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aFKM5bz7ROvvSHxsgBF1CZOKnRtiOyBU/TIBLGujOCc=; b=SUSCHB3+QJjTisyN5s4Ep+S1UO
        7oMFXSdIdtPzNXveelW3ZBy1RlrgQyFNj2uPSbeYtyfv6/KInKs+fgWQ5RLhBbQbq+TpSci6Y51wa
        W2xf21ZkIEHdizXCcsJ05AWiAQN/BcgTT7MqP4leScGSF6CE/L4bjNOS8MaJwfKnvTRgyLewiw7yL
        nEa3GMQCLiA8sDTtelOxkq2bCuClbVDrQQBCJUn8/izrrj4agfIdpdgu7qroXdq6j0FkQUCjTkY2e
        SVgCpLmTU/PqWzF/rMg6WgAwAnjyuHvFkQmh/yYT89zylVGupxUOtovihVriOW3h10bGLW1Q7F9d6
        QcDqCgLg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pyxkl-004Mu0-KC; Tue, 16 May 2023 16:42:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5FDC3000DC;
        Tue, 16 May 2023 18:42:21 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 832442CB5D5E9; Tue, 16 May 2023 18:42:21 +0200 (CEST)
Date:   Tue, 16 May 2023 18:42:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Lutomirski <luto@kernel.org>, linux-s390@vger.kernel.org,
        hca@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] entry: move the exit path to header files
Message-ID: <20230516164221.GA2602133@hirez.programming.kicks-ass.net>
References: <20230516133810.171487-1-svens@linux.ibm.com>
 <20230516133810.171487-2-svens@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516133810.171487-2-svens@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, May 16, 2023 at 03:38:09PM +0200, Sven Schnelle wrote:
> @@ -465,4 +470,175 @@ irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
>   */
>  void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
>  
> +static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
> +					    unsigned long ti_work)

Should these things not grow __always_inline/inline when moved into a header?

> +{

> +}
> +
> +
> +static void exit_to_user_mode_prepare(struct pt_regs *regs)

idem

> +{

> +}

> +static void syscall_exit_work(struct pt_regs *regs, unsigned long work)

and more..

> +{

> +}
> +
