Return-Path: <linux-kernel-owner+w=401wt.eu-S932073Ab0AERDU@vger.kernel.org>
Date: Tue, 5 Jan 2010 18:03:01 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
	results on s390x)
Message-ID: <20100105170301.GA13641@redhat.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com> <1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com> <20100104155225.GA16650@redhat.com> <20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com> <20100104181412.GA21146@redhat.com> <20100104211147.4CC94D532@magilla.sf.frob.com> <20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com> <20100105153633.GA9376@redhat.com> <20100105164610.388effd3@mschwide.boeblingen.de.ibm.com> <20100105155913.GA10652@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100105155913.GA10652@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Roland McGrath <roland@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 01/05, Oleg Nesterov wrote:
>
> I'll add clear_bit(TIF_SINGLE_STEP) into do_fork() path and re-test.

Hmm. This patch

	--- kernel/fork.c~	2009-12-22 10:41:53.188084961 -0500
	+++ kernel/fork.c	2010-01-05 11:42:58.370636323 -0500
	@@ -1206,6 +1206,8 @@ static struct task_struct *copy_process(
		 * of CLONE_PTRACE.
		 */
		clear_tsk_thread_flag(p, TIF_SYSCALL_TRACE);
	+	clear_tsk_thread_flag(p, TIF_SINGLE_STEP);
	+	user_disable_single_step(p);
	 #ifdef TIF_SYSCALL_EMU
		clear_tsk_thread_flag(p, TIF_SYSCALL_EMU);
	 #endif

doesn't help, I still see the same XXX's in dmesg...

Oleg.
