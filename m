Return-Path: <linux-kernel-owner+w=401wt.eu-S1754158Ab0AGVom@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
	results on s390x)
In-Reply-To: Oleg Nesterov's message of  Thursday, 7 January 2010 19:16:32 +0100 <20100107181632.GC13300@redhat.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<20100104155225.GA16650@redhat.com>
	<20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com>
	<20100104181412.GA21146@redhat.com>
	<20100104211147.4CC94D532@magilla.sf.frob.com>
	<20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com>
	<20100105153633.GA9376@redhat.com>
	<20100106210812.E03A1134D@magilla.sf.frob.com>
	<20100107101619.0877cf67@mschwide.boeblingen.de.ibm.com>
	<20100107181632.GC13300@redhat.com>
Message-Id: <20100107214429.6388A7300@magilla.sf.frob.com>
Date: Thu,  7 Jan 2010 13:44:29 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

> Can't understand why do we need TIF_SINGLE_STEP at all.

I think you mean "why we need to set it in do_signal" here,
not "why do we need it to exist at all".

> Just pass current->thread.per_info.single_step to
> tracehook_signal_handler() ?

Yes.  I believe this is what Martin meant, and it's what I meant to endorse.

do_signal should not do anything with TIF_SINGLE_STEP at all.
Its only purpose should be to communicate from the low-level
trap assembly code up to the return-to-user assembly code so
it calls do_single_step.


Thanks,
Roland
