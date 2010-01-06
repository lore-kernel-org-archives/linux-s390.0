Return-Path: <linux-kernel-owner+w=401wt.eu-S932796Ab0AFVPq@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
 results on s390x)
In-Reply-To: Martin Schwidefsky's message of  Tuesday, 5 January 2010 10:26:06 +0100 <20100105102606.4f223990@mschwide.boeblingen.de.ibm.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<20100104155225.GA16650@redhat.com>
	<20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com>
	<20100104181412.GA21146@redhat.com>
	<20100105102606.4f223990@mschwide.boeblingen.de.ibm.com>
Message-Id: <20100106211536.0F6AC134D@magilla.sf.frob.com>
Date: Wed,  6 Jan 2010 13:15:36 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Oleg Nesterov <oleg@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

> > then the test-case from 6580807da14c423f0d0a708108e6df6ebc8bc83d
> > fails. This probably means that copy_process()->user_disable_single_step()
> > is not enough to clear the "this task wants single-stepping" copied
> > from parent.
> 
> user_disable_single_step() does not remove the TIF_SINGLE_STEP bit from the
> forked task. Perhaps we should just clear the bit in the function.

If that were to fix this test case, I think it would be incidental rather
than meaning the right thing.  The "this task wants single-stepping" state
should not have anything to do with TIF_SINGLE_STEP.  It means "this task
recently had single-stepping", which is a separate moving part.

Thanks,
Roland
