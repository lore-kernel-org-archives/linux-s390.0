Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7504 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725923AbgEGM17 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 May 2020 08:27:59 -0400
Date: Thu, 7 May 2020 14:27:44 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH v4 06/11] s390/module: Use s390_kernel_write() for late
 relocations
Message-ID: <20200507142744.05271ac0@thinkpad>
In-Reply-To: <nycvar.YFH.7.76.2005071159490.25812@cbobk.fhfr.pm>
References: <cover.1588173720.git.jpoimboe@redhat.com>
        <4710f82c960ff5f8b0dd7dba6aafde5bea275cfa.1588173720.git.jpoimboe@redhat.com>
        <nycvar.YFH.7.76.2005071159490.25812@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jessica Yu <jeyu@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

On Thu, 7 May 2020 12:00:13 +0200 (CEST)
Jiri Kosina <jikos@kernel.org> wrote:

> On Wed, 29 Apr 2020, Josh Poimboeuf wrote:
> 
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > Because of late module patching, a livepatch module needs to be able to
> > apply some of its relocations well after it has been loaded.  Instead of
> > playing games with module_{dis,en}able_ro(), use existing text poking
> > mechanisms to apply relocations after module loading.
> > 
> > So far only x86, s390 and Power have HAVE_LIVEPATCH but only the first
> > two also have STRICT_MODULE_RWX.
> > 
> > This will allow removal of the last module_disable_ro() usage in
> > livepatch.  The ultimate goal is to completely disallow making
> > executable mappings writable.
> > 
> > [ jpoimboe: Split up patches.  Use mod state to determine whether
> > 	    memcpy() can be used.  Test and add fixes. ]
> > 
> > Cc: linux-s390@vger.kernel.org
> > Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> > Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> > Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
> > Acked-by: Miroslav Benes <mbenes@suse.cz>
> 
> Could we please get an Ack / Reviewed-by: for this patch from s390 folks?
> 
> Thanks,
> 

Looks pretty straightforward, and using s390_kernel_write() is OK, so

Acked-by: Gerald Schaefer <gerald.schaefer@de.ibm.com> # s390
