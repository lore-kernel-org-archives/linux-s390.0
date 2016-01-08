Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1452241551.5327.16.camel@BR9GV9YG.de.ibm.com>
Subject: Re: 390/qeth: Delete an unnecessary variable initialisation in
 qeth_core_set_online()
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Fri, 08 Jan 2016 09:25:51 +0100
In-Reply-To: <568F62D0.9050806@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
	 <5688F13A.70601@users.sourceforge.net>
	 <5688F198.4040109@users.sourceforge.net>
	 <1452177226.1081.6.camel@BR9GV9YG.de.ibm.com>
	 <568F62D0.9050806@users.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2016-01-08 at 08:18 +0100, SF Markus Elfring wrote:
> > As Heiko already answered, you could propose a lot of this kind of changes
> > with just minor benefit. I do not want to push them in single patches.
> 
> Thanks for your clarification.
> 
> 
> > Either there is a cleanup patch for explicit initialisation of
> > local variables in the whole qeth driver,
> 
> Is there any more fine-tuning cooking in the background?
Not yet; qeth is an important driver for Linux on System z; there are
lots of investigation ideas for improvements, which we will take care
about according to their priorities. I regard your proposed fine-tuning
code change as valid, but prioritize it as one with lowest benefit,
since it does not really make a difference once compiled.
> 
> 
> > or we take care about such minor changes, once we touch the code anyway
> 
> How often will this really happen?
There is no general rule. Check our git history to answer this question.
> 
> 
> > due to other reasons.
> 
> I am curious which ones will trigger further related software improvements.
> 
> Regards,
> Markus
> 
