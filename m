Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6872C433F5
	for <linux-s390@archiver.kernel.org>; Fri,  6 May 2022 19:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352887AbiEFTls (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 6 May 2022 15:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234627AbiEFTlr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 May 2022 15:41:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100C96A02F;
        Fri,  6 May 2022 12:38:04 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651865882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8T2qZfZRWAyz/w0PKnt28heXPlVuPjH7rUUoRh3DSQE=;
        b=kWqK0E+R7ljU/7tYyyT7HtIpaWR+kJcBxZE4feZq4Is15XKSf/dupZk9JrTJHtDVribcAa
        o2sKvbKhKHFJL0cObyj3dxuEsyLAFZHAzG/JlCbTYSND8CNU121ezE4h+wHIrMAN6S/Nc/
        ERxQTrC5kK1izqhuGpCNLO9tv6HpLQo0gj7Rlk0OTXRZHXczx8bQYYK6Ngznf9qXbUxCp3
        9fPqCCDNi3QSw8oFqt7UqdP91GOSwy1HuKZsKqxJ/uV6b1ZhwAZn6ISEwg5Y0YCjrEy8n+
        XexPWL81QvZTST+tHedKy0S0HeAQtNCvuQKxdnWRgAOhf0HfdBCzQC2B+M+Qbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651865882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8T2qZfZRWAyz/w0PKnt28heXPlVuPjH7rUUoRh3DSQE=;
        b=QMYNKXBKI1hJag05M/ostqQK+KhIPg6iMTEvJHBuIWU2bRU/c52GuRQTNlee3OR2NXmM5f
        M+CCd4Y5mzuGtpCQ==
To:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH 1/2] entry: Rename arch_check_user_regs() to
 arch_enter_from_user_mode()
In-Reply-To: <20220504062351.2954280-2-tmricht@linux.ibm.com>
References: <20220504062351.2954280-1-tmricht@linux.ibm.com>
 <20220504062351.2954280-2-tmricht@linux.ibm.com>
Date:   Fri, 06 May 2022 21:38:02 +0200
Message-ID: <87bkwah2p1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, May 04 2022 at 08:23, Thomas Richter wrote:
> From: Sven Schnelle <svens@linux.ibm.com>
>
> arch_check_user_regs() is used at the moment to verify that struct pt_regs
> contains valid values when entering the kernel from userspace. s390 needs
> a place in the generic entry code to modify a cpu data structure when
> switching from userspace to kernel mode. As arch_check_user_regs() is
> exactly this, rename it to arch_enter_from_user_mode().
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
