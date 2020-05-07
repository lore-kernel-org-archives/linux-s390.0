Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 7 May 2020 12:00:13 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4 06/11] s390/module: Use s390_kernel_write() for late
 relocations
In-Reply-To: <4710f82c960ff5f8b0dd7dba6aafde5bea275cfa.1588173720.git.jpoimboe@redhat.com>
Message-ID: <nycvar.YFH.7.76.2005071159490.25812@cbobk.fhfr.pm>
References: <cover.1588173720.git.jpoimboe@redhat.com> <4710f82c960ff5f8b0dd7dba6aafde5bea275cfa.1588173720.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jessica Yu <jeyu@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Wed, 29 Apr 2020, Josh Poimboeuf wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 
> Because of late module patching, a livepatch module needs to be able to
> apply some of its relocations well after it has been loaded.  Instead of
> playing games with module_{dis,en}able_ro(), use existing text poking
> mechanisms to apply relocations after module loading.
> 
> So far only x86, s390 and Power have HAVE_LIVEPATCH but only the first
> two also have STRICT_MODULE_RWX.
> 
> This will allow removal of the last module_disable_ro() usage in
> livepatch.  The ultimate goal is to completely disallow making
> executable mappings writable.
> 
> [ jpoimboe: Split up patches.  Use mod state to determine whether
> 	    memcpy() can be used.  Test and add fixes. ]
> 
> Cc: linux-s390@vger.kernel.org
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
> Acked-by: Miroslav Benes <mbenes@suse.cz>

Could we please get an Ack / Reviewed-by: for this patch from s390 folks?

Thanks,

-- 
Jiri Kosina
SUSE Labs
