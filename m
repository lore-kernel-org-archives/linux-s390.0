Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728095AbfHMOCY (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 13 Aug 2019 10:02:24 -0400
Date: Tue, 13 Aug 2019 16:02:17 +0200 (CEST)
From: Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] s390/livepatch: Implement reliable stack tracing for
 the consistency model
In-Reply-To: <20190728203053.q3pafkwnzm5j3ccs@treble>
Message-ID: <alpine.LSU.2.21.1908131602040.10477@pobox.suse.cz>
References: <20190710105918.22487-1-mbenes@suse.cz> <20190716184549.GA26084@redhat.com> <alpine.LSU.2.21.1907171223540.4492@pobox.suse.cz> <20190728203053.q3pafkwnzm5j3ccs@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Joe Lawrence <joe.lawrence@redhat.com>, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, jikos@kernel.org, pmladek@suse.com, nstange@suse.de, live-patching@vger.kernel.org

On Sun, 28 Jul 2019, Josh Poimboeuf wrote:

> On Wed, Jul 17, 2019 at 01:01:27PM +0200, Miroslav Benes wrote:
> > > On a related note, do you think it would be feasible to extend (in
> > > another patchset) the reliable stack unwinding code a bit so that we
> > > could feed it pre-baked stacks ... then we could verify that the code
> > > was finding interesting scenarios.  That was a passing thought I had
> > > back when Nicolai and I were debugging the ppc64le exception frame
> > > marker bug, but didn't think it worth the time/effort at the time.
> > 
> > That is an interesting thought. It would help the testing a lot. I will 
> > make a note in my todo list.
> 
> Another idea I had for reliable unwinder testing: add a
> CONFIG_RELIABLE_STACKTRACE_DEBUG option which does a periodic stack
> trace and warns if it doesn't reach the end.  It could triggered from a
> periodic NMI, or from schedule().

Noted as well. 

Miroslav
