Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:11190 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725779AbgDVPVf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Apr 2020 11:21:35 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03MFBkId155722
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 11:21:34 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ghmdk916-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 11:21:33 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <gerald.schaefer@de.ibm.com>;
        Wed, 22 Apr 2020 16:20:56 +0100
Date: Wed, 22 Apr 2020 17:21:26 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH v2 6/9] s390/module: Use s390_kernel_write() for late
 relocations
In-Reply-To: <20200422164037.7edd21ea@thinkpad>
References: <cover.1587131959.git.jpoimboe@redhat.com>
        <18266eb2c2c9a2ce0033426837d89dcb363a85d3.1587131959.git.jpoimboe@redhat.com>
        <20200422164037.7edd21ea@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200422172126.743908f5@thinkpad>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jessica Yu <jeyu@kernel.org>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, Vasily Gorbik <gor@linux.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>

On Wed, 22 Apr 2020 16:40:37 +0200
Gerald Schaefer <gerald.schaefer@de.ibm.com> wrote:

> On Fri, 17 Apr 2020 09:04:31 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
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
> > Also, for the late patching case, use text_mutex, which is supposed to
> > be held for all runtime text patching operations.
> > 
> > [ jpoimboe: Split up patches.  Use mod state to determine whether
> > 	    memcpy() can be used.  Add text_mutex.  Make it build. ]
> > 
> > Cc: linux-s390@vger.kernel.org
> > Cc: heiko.carstens@de.ibm.com
> > Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > ---
> >  arch/s390/kernel/module.c | 125 ++++++++++++++++++++++++--------------
> >  1 file changed, 79 insertions(+), 46 deletions(-)
> 
> Sorry, just noticed this. Heiko will return next month, and I'm not
> really familiar with s390 livepatching. Adding Vasily, he might
> have some more insight.
> 
> So, I might be completely wrong here, but using s390_kernel_write()
> for writing to anything other than 1:1 mapped kernel, should go
> horribly wrong, as that runs w/o DAT. It would allow to bypass
> DAT write protection, which I assume is why you want to use it,
> but it should not work on module text section, as that would be
> in vmalloc space and not 1:1 mapped kernel memory.
> 
> Not quite sure how to test / trigger this, did this really work for
> you on s390?

OK, using s390_kernel_write() as default write function for module
relocation seems to work fine for me, so apparently I am missing /
mixing up something. Sorry for the noise, please ignore my concern.
