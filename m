Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 3 Nov 2014 19:28:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: s390/net: Deletion of unnecessary checks before two function
 calls
Message-ID: <20141103162802.GM6879@mwanda>
References: <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <5453C98C.90105@users.sourceforge.net>
 <1415012678.18669.6.camel@BR9GV9YG.de.ibm.com>
 <5457A8FB.8070306@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5457A8FB.8070306@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Ursula Braun <ubraun@linux.vnet.ibm.com>, Ursula Braun <ursula.braun@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Frank Blaschka <blaschka@linux.vnet.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, trivial@kernel.org, Coccinelle <cocci@systeme.lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Nov 03, 2014 at 05:10:35PM +0100, SF Markus Elfring wrote:
> > I agree with your proposed debug_unregister() changes, but not with your
> > kfree_fsm() change.
> 
> Why do you want to keep an additional null pointer check before the call
> of the kfree_fsm() function within the implementation of the
> netiucv_free_netdevice() function?

Think about how long it takes you to figure this out what the bug is and
then remember that we have to spend that same amount of time multiplied
by the number of patches you have sent.

regards,
dan carpenter
