Return-Path: <linux-kernel-owner+w=401wt.eu-S1755147Ab0AUUcd@vger.kernel.org>
Date: Thu, 21 Jan 2010 21:32:07 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
	results on s390x)
Message-ID: <20100121203207.GA20050@redhat.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com> <1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com> <20100104155225.GA16650@redhat.com> <20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com> <20100104181412.GA21146@redhat.com> <20100104211147.4CC94D532@magilla.sf.frob.com> <20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com> <20100106205633.700CC134D@magilla.sf.frob.com> <20100107100050.31724463@mschwide.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100107100050.31724463@mschwide.boeblingen.de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Roland McGrath <roland@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 01/07, Martin Schwidefsky wrote:
>
> On Wed,  6 Jan 2010 12:56:33 -0800 (PST)
> Roland McGrath <roland@redhat.com> wrote:
>
> > In other circumstances with utrace, it is very possible to wind up with
> > user_disable_single_step being called superfluously when there was no
> > stop (and so not necessarily any context switch or other high overhead).
> > On other machines, user_disable_single_step is pretty cheap even where
> > user_enable_single_step is quite costly.  Given how simple and cheap it
> > is to short-circuit the excess work on s390, I think it is worthwhile.
>
> We could use the same compare of the control registers as the code in
> __switch_to. See below.

FYI, I tested your c3311c13adc1021e986fef12609ceb395ffc5014 commit which
does this optimization (compared to the patch you sent previously), it
works fine.

But please see another email I am going to send...

Oleg.
