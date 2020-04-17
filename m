Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31476 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728461AbgDQBhZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 16 Apr 2020 21:37:25 -0400
Date: Thu, 16 Apr 2020 20:37:15 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH 4/7] s390/module: Use s390_kernel_write() for relocations
Message-ID: <20200417013715.kj6g4byvdy5uzgev@treble>
References: <cover.1586881704.git.jpoimboe@redhat.com>
 <e7f2ad87cf83dcdaa7b69b4e37c11fa355bdfe78.1586881704.git.jpoimboe@redhat.com>
 <alpine.LSU.2.21.2004161047410.10475@pobox.suse.cz>
 <20200416120651.wqmoaa35jft4prox@treble>
 <20200416131635.scbpuued6l4xb6qq@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416131635.scbpuued6l4xb6qq@treble>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Miroslav Benes <mbenes@suse.cz>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jessica Yu <jeyu@kernel.org>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com

On Thu, Apr 16, 2020 at 08:16:35AM -0500, Josh Poimboeuf wrote:
> On Thu, Apr 16, 2020 at 07:06:51AM -0500, Josh Poimboeuf wrote:
> > On Thu, Apr 16, 2020 at 10:56:02AM +0200, Miroslav Benes wrote:
> > > > +	bool early = me->state == MODULE_STATE_UNFORMED;
> > > > +
> > > > +	return __apply_relocate_add(sechdrs, strtab, symindex, relsec, me,
> > > > +				    early ? memcpy : s390_kernel_write);
> > > 
> > > The compiler warns about
> > > 
> > > arch/s390/kernel/module.c: In function 'apply_relocate_add':
> > > arch/s390/kernel/module.c:453:24: warning: pointer type mismatch in conditional expression
> > >          early ? memcpy : s390_kernel_write);
> > 
> > Thanks, I'll get all that cleaned up.
> > 
> > I could have sworn I got a SUCCESS message from the kbuild bot.  Does it
> > ignore warnings nowadays?
> 
> Here's a fix on top of the original patch.
> 
> I changed s390_kernel_write() to return "void *" to match memcpy()
> (probably a separate patch).
> 
> I also grabbed the text_mutex for the !early case in
> apply_relocate_add() -- will do something similar for x86.
> 
> Will try to test this on a 390 box.

...and that borked the box pretty nicely.  Oops, big endian!  Need
something like this on top.

Sorry about not testing the patch in the first place, it looked trivial
and somehow I was thinking Peter writes exclusively bug-free code.

diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
index ee0904a23e24..513e640430ae 100644
--- a/arch/s390/kernel/module.c
+++ b/arch/s390/kernel/module.c
@@ -198,21 +198,25 @@ static int apply_rela_bits(Elf_Addr loc, Elf_Addr val,
 	}
 
 	if (bits == 8) {
-		write(dest, &val, 1);
+		unsigned char tmp = val;
+		write(dest, &tmp, 1);
 	} else if (bits == 12) {
 		unsigned short tmp = (val & 0xfff) |
 			(*(unsigned short *) loc & 0xf000);
 		write(dest, &tmp, 2);
 	} else if (bits == 16) {
-		write(dest, &val, 2);
+		unsigned short tmp = val;
+		write(dest, &tmp, 2);
 	} else if (bits == 20) {
 		unsigned int tmp = (val & 0xfff) << 16 |
 			(val & 0xff000) >> 4 | (*(unsigned int *) loc & 0xf00000ff);
 		write(dest, &tmp, 4);
 	} else if (bits == 32) {
-		write(dest, &val, 4);
+		unsigned int tmp = val;
+		write(dest, &tmp, 4);
 	} else if (bits == 64) {
-		write(dest, &val, 8);
+		unsigned long tmp = val;
+		write(dest, &tmp, 8);
 	}
 	return 0;
 }

-- 
Josh
