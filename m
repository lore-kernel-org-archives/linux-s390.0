Return-Path: <linux-kernel-owner+w=401wt.eu-S1756149AbYKELsb@vger.kernel.org>
Subject: Re: [patch 15/21] ptrace changes
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <490F317C.9040603@redhat.com>
References: <20081001083317.782967473@de.ibm.com>
	 <20081001084129.042880937@de.ibm.com>  <490F317C.9040603@redhat.com>
Content-Type: text/plain
Date: Wed, 05 Nov 2008 12:41:24 +0100
Message-Id: <1225885284.17430.7.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Smith <dsmith@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2008-11-03 at 11:14 -0600, David Smith wrote: 

> Is this correct, or should the 1st syscall argument be found in
> regs->orig_gpr2 by syscall_get_arguments()/syscall_set_arguments()?

The question is when do syscall_get_arguments and syscall_set_arguments
functions get called? If they are called on a call chain that started
from do_syscall_trace_enter then we'd have to use orig_gpr2 instead of
gprs[2] but if the functions are not called via do_syscall_trace_enter
the first argument is located in grprs[2]. As far as I can see the sole
user of syscall_get_arguments is collect_syscall which is used to get
the registers of a blocked process. In this case the kernel call chain
does not include do_syscall_trace_enter, therefore the first argument is
in gprs[2], no?

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
