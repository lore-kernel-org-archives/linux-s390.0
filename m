Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149B2C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 29 Mar 2022 11:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235697AbiC2LYp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 29 Mar 2022 07:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiC2LYo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 29 Mar 2022 07:24:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6398818B258;
        Tue, 29 Mar 2022 04:23:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0422A1F87C;
        Tue, 29 Mar 2022 11:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648552981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SIv5uXYMR0opeIvGmNdx5Nx23cUrlYA4mD5vDaH6REM=;
        b=a4pa12+asB0UvvOL2t6C7VRrhoYKwHDo9Jo1k1K7cQSVeCHRBqAxNEzdFkHj6Jx/cJvJMv
        xzTboGQJtPnMz32eX6bxd6a+dUtVbcvzrMkj7YY00wEBN+JYWlhoLgnAXmqUso50y5Sdu2
        ycRjhpo8VdscO15NjnBedEdqe8bBlGE=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C099FA3B82;
        Tue, 29 Mar 2022 11:23:00 +0000 (UTC)
Date:   Tue, 29 Mar 2022 13:22:57 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        live-patching@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] livepatch: Remove klp_arch_set_pc() and asm/livepatch.h
Message-ID: <YkLsEUgxJkYbLZ7Z@alley>
References: <e029c7cfde436f6bbf99148ab14dc2da99add503.1648447981.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e029c7cfde436f6bbf99148ab14dc2da99add503.1648447981.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon 2022-03-28 08:26:48, Christophe Leroy wrote:
> All three versions of klp_arch_set_pc() do exactly the same: they
> call ftrace_instruction_pointer_set().
> 
> Call ftrace_instruction_pointer_set() directly and remove
> klp_arch_set_pc().
> 
> As klp_arch_set_pc() was the only thing remaining in asm/livepatch.h
> on x86 and s390, remove asm/livepatch.h
> 
> livepatch.h remains on powerpc but its content is exclusively used
> by powerpc specific code.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Petr Mladek <pmladek@suse.com>

I am going to take it via livepatch/livepatch.git for 5.19. We are
already in the middle of the merge window and this is not critical.

Best Regards,
Petr
