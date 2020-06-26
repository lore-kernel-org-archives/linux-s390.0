Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pj1-f65.google.com ([209.85.216.65]:36155 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgFZLkM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 26 Jun 2020 07:40:12 -0400
Date: Fri, 26 Jun 2020 11:40:08 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: linux-next: umh: fix processed error when UMH_WAIT_PROC is used
 seems to break linux bridge on s390x (bisected)
Message-ID: <20200626114008.GK4332@42.do-not-panic.com>
References: <20200624144311.GA5839@infradead.org>
 <9e767819-9bbe-2181-521e-4d8ca28ca4f7@de.ibm.com>
 <20200624160953.GH4332@42.do-not-panic.com>
 <ea41e2a9-61f7-aec1-79e5-7b08b6dd5119@de.ibm.com>
 <4e27098e-ac8d-98f0-3a9a-ea25242e24ec@de.ibm.com>
 <4d8fbcea-a892-3453-091f-d57c03f9aa90@de.ibm.com>
 <1263e370-7cee-24d8-b98c-117bf7c90a83@de.ibm.com>
 <20200626025410.GJ4332@42.do-not-panic.com>
 <feb6a8c4-2b94-3f95-6637-679e089a71ca@de.ibm.com>
 <20200626090001.GA30103@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626090001.GA30103@infradead.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, ast@kernel.org, axboe@kernel.dk, bfields@fieldses.org, bridge@lists.linux-foundation.org, chainsaw@gentoo.org, christian.brauner@ubuntu.com, chuck.lever@oracle.com, davem@davemloft.net, dhowells@redhat.com, gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, josh@joshtriplett.org, keescook@chromium.org, keyrings@vger.kernel.org, kuba@kernel.org, lars.ellenberg@linbit.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, nikolay@cumulusnetworks.com, philipp.reisner@linbit.com, ravenexp@gmail.com, roopa@cumulusnetworks.com, serge@hallyn.com, slyfox@gentoo.org, viro@zeniv.linux.org.uk, yangtiezhu@loongson.cn, netdev@vger.kernel.org, markward@linux.ibm.com, linux-s390 <linux-s390@vger.kernel.org>

On Fri, Jun 26, 2020 at 10:00:01AM +0100, Christoph Hellwig wrote:
> On Fri, Jun 26, 2020 at 07:22:34AM +0200, Christian Borntraeger wrote:
> > 
> > 
> > On 26.06.20 04:54, Luis Chamberlain wrote:
> > > On Wed, Jun 24, 2020 at 08:37:55PM +0200, Christian Borntraeger wrote:
> > >>
> > >>
> > >> On 24.06.20 20:32, Christian Borntraeger wrote:
> > >> [...]> 
> > >>> So the translations look correct. But your change is actually a sematic change
> > >>> if(ret) will only trigger if there is an error
> > >>> if (KWIFEXITED(ret)) will always trigger when the process ends. So we will always overwrite -ECHILD
> > >>> and we did not do it before. 
> > >>>
> > >>
> > >> So the right fix is
> > >>
> > >> diff --git a/kernel/umh.c b/kernel/umh.c
> > >> index f81e8698e36e..a3a3196e84d1 100644
> > >> --- a/kernel/umh.c
> > >> +++ b/kernel/umh.c
> > >> @@ -154,7 +154,7 @@ static void call_usermodehelper_exec_sync(struct subprocess_info *sub_info)
> > >>                  * the real error code is already in sub_info->retval or
> > >>                  * sub_info->retval is 0 anyway, so don't mess with it then.
> > >>                  */
> > >> -               if (KWIFEXITED(ret))
> > >> +               if (KWEXITSTATUS(ret))
> > >>                         sub_info->retval = KWEXITSTATUS(ret);
> > >>         }
> > >>  
> > >> I think.
> > > 
> > > Nope, the right form is to check for WIFEXITED() before using WEXITSTATUS().
> > 
> > But this IS a change over the previous code, no?
> > I will test next week as I am travelling right now. 
> 
> I'm all for reverting back to the previous behavior.  If someone wants
> a behavior change it should be a separate patch.  And out of pure self
> interest I'd like to see that change after my addition of the
> kernel_wait helper to replace the kernel_wait4 abuse :)

Yeah sure, this will be *slightly* cleaner after that. Today we
implicitly return -ECHLD as well under the assumption the kernel_wait4()
call failed.

Andrew, can you please revert these two for now:

selftests: simplify kmod failure value
umh: fix processed error when UMH_WAIT_PROC is used

Later, we'll add Christoph's simplier kernel wait, and make the change
directly there to catpure the right error. That still won't fix this reported
issue, but it will be cleaner and will go tested by Christian Borntraeger
before.

  Luis
