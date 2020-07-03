Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33519 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbgGCN2x (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 09:28:53 -0400
Date: Fri, 3 Jul 2020 13:28:50 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: linux-next: umh: fix processed error when UMH_WAIT_PROC is used
 seems to break linux bridge on s390x (bisected)
Message-ID: <20200703132850.GW4332@42.do-not-panic.com>
References: <20200626025410.GJ4332@42.do-not-panic.com>
 <20200630175704.GO13911@42.do-not-panic.com>
 <b24d8dae-1872-ba2c-acd4-ed46c0781317@de.ibm.com>
 <a6792135-3285-0861-014e-3db85ea251dc@i-love.sakura.ne.jp>
 <20200701135324.GS4332@42.do-not-panic.com>
 <8d714a23-bac4-7631-e5fc-f97c20a46083@i-love.sakura.ne.jp>
 <20200701153859.GT4332@42.do-not-panic.com>
 <e3f3e501-2cb7-b683-4b85-2002b7603244@i-love.sakura.ne.jp>
 <20200702194656.GV4332@42.do-not-panic.com>
 <d8a74a06-de97-54ae-de03-0d955e82f62b@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8a74a06-de97-54ae-de03-0d955e82f62b@i-love.sakura.ne.jp>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: David Howells <dhowells@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Christoph Hellwig <hch@infradead.org>, "Eric W. Biederman" <ebiederm@xmission.com>, ast@kernel.org, axboe@kernel.dk, bfields@fieldses.org, bridge@lists.linux-foundation.org, chainsaw@gentoo.org, christian.brauner@ubuntu.com, chuck.lever@oracle.com, davem@davemloft.net, gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, josh@joshtriplett.org, keescook@chromium.org, keyrings@vger.kernel.org, kuba@kernel.org, lars.ellenberg@linbit.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, nikolay@cumulusnetworks.com, philipp.reisner@linbit.com, ravenexp@gmail.com, roopa@cumulusnetworks.com, serge@hallyn.com, slyfox@gentoo.org, viro@zeniv.linux.org.uk, yangtiezhu@loongson.cn, netdev@vger.kernel.org, markward@linux.ibm.com, linux-s390 <linux-s390@vger.kernel.org>

On Fri, Jul 03, 2020 at 09:52:01AM +0900, Tetsuo Handa wrote:
> On 2020/07/03 4:46, Luis Chamberlain wrote:
> > The alternative to making a compromise is using generic wrappers for
> > things which make sense and letting the callers use those.
> 
> I suggest just introducing KWIFEXITED()/KWEXITSTATUS()/KWIFSIGNALED()/KWTERMSIG()
> macros and fixing the callers, for some callers are not aware of possibility of
> KWIFSIGNALED() case.

OK so we open code all uses. Do that in a next iteration.

  Luis
