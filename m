Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388793AbgFWVfu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Jun 2020 17:35:50 -0400
Date: Tue, 23 Jun 2020 14:35:47 -0700 (PDT)
Message-Id: <20200623.143547.611766403397972374.davem@davemloft.net>
Subject: Re: [PATCH v4 3/8] sparc64: Fix asm/percpu.h build error
From: David Miller <davem@davemloft.net>
In-Reply-To: <20200623083721.277992771@infradead.org>
References: <20200623083645.277342609@infradead.org>
        <20200623083721.277992771@infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: peterz@infradead.org
Cc: mingo@kernel.org, will@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk

From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 23 Jun 2020 10:36:48 +0200

> In order to break a header dependency between lockdep and task_struct,
> I need per-cpu stuff from lockdep.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Acked-by: David S. Miller <davem@davemloft.net>
