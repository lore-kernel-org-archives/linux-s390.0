Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32942 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726029AbgEGQCX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 May 2020 12:02:23 -0400
Date: Thu, 7 May 2020 18:01:44 +0200
From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH v4 05/11] s390: Change s390_kernel_write() return type
 to match memcpy()
Message-ID: <20200507180144.165a6edf@thinkpad>
In-Reply-To: <nycvar.YFH.7.76.2005071534170.25812@cbobk.fhfr.pm>
References: <cover.1588173720.git.jpoimboe@redhat.com>
        <be5119b30920d2da6fca3f6d2b1aca5712a2fd30.1588173720.git.jpoimboe@redhat.com>
        <nycvar.YFH.7.76.2005071534170.25812@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Jessica Yu <jeyu@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>, Miroslav Benes <mbenes@suse.cz>, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, Gerald Schaefer <gerald.schaefer@de.ibm.com>

On Thu, 7 May 2020 15:36:48 +0200 (CEST)
Jiri Kosina <jikos@kernel.org> wrote:

> On Wed, 29 Apr 2020, Josh Poimboeuf wrote:
> 
> > s390_kernel_write()'s function type is almost identical to memcpy().
> > Change its return type to "void *" so they can be used interchangeably.
> > 
> > Cc: linux-s390@vger.kernel.org
> > Cc: heiko.carstens@de.ibm.com
> > Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> > Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
> > Acked-by: Miroslav Benes <mbenes@suse.cz>
> 
> Also for this one -- s390 folks, could you please provide your Ack for 
> taking things through livepatching.git as part of this series?
> 
> Thanks.
> 

Ah, forgot about that one, sorry. Also looks good.

Acked-by: Gerald Schaefer <gerald.schaefer@de.ibm.com> # s390
