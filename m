Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4DFC433F5
	for <linux-s390@archiver.kernel.org>; Mon, 23 May 2022 15:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237559AbiEWPPp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 23 May 2022 11:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237515AbiEWPPp (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 23 May 2022 11:15:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4442D49FB4;
        Mon, 23 May 2022 08:15:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id E345821B40;
        Mon, 23 May 2022 15:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1653318942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Li9Eq39Zca7A7Yd+2+8FiQZmQCwkSJCjj6oLOBXVCTQ=;
        b=UQslza7yiL1x8r4CTlcvmyaEzDceraNNRn4y2gdNRFA021qH++lF1uuahK9zlB0ChD1z2W
        opw6Z1MGw6aJi0cxM3BmTltSvfrdGBSoVU5Z/bvw/OtqPHl40yNd4DDS8TmMABzOjvjpWm
        jBE7cmrpVE3jk5YKQjCOBilTHWohuHc=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DC5A02C141;
        Mon, 23 May 2022 15:15:40 +0000 (UTC)
Date:   Mon, 23 May 2022 17:15:37 +0200
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
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "live-patching@vger.kernel.org" <live-patching@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] livepatch: Remove klp_arch_set_pc() and asm/livepatch.h
Message-ID: <YoulGX1p82IoEzST@alley>
References: <e029c7cfde436f6bbf99148ab14dc2da99add503.1648447981.git.christophe.leroy@csgroup.eu>
 <YkLsEUgxJkYbLZ7Z@alley>
 <e1840187-6032-9f75-d7a8-b2b2fc5cbb58@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1840187-6032-9f75-d7a8-b2b2fc5cbb58@csgroup.eu>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon 2022-05-23 06:51:47, Christophe Leroy wrote:
> 
> 
> Le 29/03/2022 à 13:22, Petr Mladek a écrit :
> > On Mon 2022-03-28 08:26:48, Christophe Leroy wrote:
> >> All three versions of klp_arch_set_pc() do exactly the same: they
> >> call ftrace_instruction_pointer_set().
> >>
> >> Call ftrace_instruction_pointer_set() directly and remove
> >> klp_arch_set_pc().
> >>
> >> As klp_arch_set_pc() was the only thing remaining in asm/livepatch.h
> >> on x86 and s390, remove asm/livepatch.h
> >>
> >> livepatch.h remains on powerpc but its content is exclusively used
> >> by powerpc specific code.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > 
> > Acked-by: Petr Mladek <pmladek@suse.com>
> > 
> > I am going to take it via livepatch/livepatch.git for 5.19. We are
> > already in the middle of the merge window and this is not critical.
> > 
> 
> I haven't seen it in linux-next.
> 
> Do you still plan to take it for 5.19 ?

Thanks a lot for pointing this out. I have completely forgot about
this patch /o\

I have just pushed it into livepatching/livepatching.git,
branch for-5.19/cleanup.

I am going to create pull request for 5.19 by the end of this week
after it gets a spin in linux-next.

Best Regards,
Petr
