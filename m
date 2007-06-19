Return-Path: <linux-kernel-owner+w=401wt.eu-S1756682AbXFSJTQ@vger.kernel.org>
Date: Tue, 19 Jun 2007 18:17:27 +0900
From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [patch 5/6] Move psw_set_key.
Message-ID: <20070619091727.GB23697@linux-sh.org>
References: <20070619084516.457715754@de.ibm.com> <20070619084643.095486838@de.ibm.com> <20070619084516.457715754@de.ibm.com> <20070619084642.673859525@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070619084643.095486838@de.ibm.com> <20070619084642.673859525@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jun 19, 2007 at 10:45:21AM +0200, Martin Schwidefsky wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Move psw_set_key() from ptrace.h to processor.h which is a more
> suitable place for it. In addition the moves makes the function
> invisible to user space.
> 
>  arch/s390/kernel/traps.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 

On Tue, Jun 19, 2007 at 10:45:22AM +0200, Martin Schwidefsky wrote:
> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> This is mainly to switch off all potentially debugging stuff that
> won't report anything useful after an oops happened.
> Besided that setting pause_on_oops will work too, but doesn't make
> too much sense on s390.
> 
>  include/asm-s390/processor.h |    5 +++++
>  include/asm-s390/ptrace.h    |    9 +--------
>  2 files changed, 6 insertions(+), 8 deletions(-)
> 
These changelog does not match the patch, they're reversed.. :-)
