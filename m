Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43566 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2635000AbgDPMHc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 16 Apr 2020 08:07:32 -0400
Date: Thu, 16 Apr 2020 07:06:51 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 4/7] s390/module: Use s390_kernel_write() for relocations
Message-ID: <20200416120651.wqmoaa35jft4prox@treble>
References: <cover.1586881704.git.jpoimboe@redhat.com>
 <e7f2ad87cf83dcdaa7b69b4e37c11fa355bdfe78.1586881704.git.jpoimboe@redhat.com>
 <alpine.LSU.2.21.2004161047410.10475@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.21.2004161047410.10475@pobox.suse.cz>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jessica Yu <jeyu@kernel.org>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com

On Thu, Apr 16, 2020 at 10:56:02AM +0200, Miroslav Benes wrote:
> > +	bool early = me->state == MODULE_STATE_UNFORMED;
> > +
> > +	return __apply_relocate_add(sechdrs, strtab, symindex, relsec, me,
> > +				    early ? memcpy : s390_kernel_write);
> 
> The compiler warns about
> 
> arch/s390/kernel/module.c: In function 'apply_relocate_add':
> arch/s390/kernel/module.c:453:24: warning: pointer type mismatch in conditional expression
>          early ? memcpy : s390_kernel_write);

Thanks, I'll get all that cleaned up.

I could have sworn I got a SUCCESS message from the kbuild bot.  Does it
ignore warnings nowadays?

-- 
Josh
