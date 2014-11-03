Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 3 Nov 2014 12:50:59 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/1] s390/net: Deletion of unnecessary checks before two
 function calls
Message-ID: <20141103095059.GL6879@mwanda>
References: <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <5453C98C.90105@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5453C98C.90105@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Ursula Braun <ursula.braun@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Frank Blaschka <blaschka@linux.vnet.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, trivial@kernel.org, Coccinelle <cocci@systeme.lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

This one is buggy.

I'm sorry, but please stop sending these.

For kfree(), at least we all know that kfree() accepts NULL pointer.
But for this one:
1) I don't know what the functions do so I have to look at the code.
2) It's in a arch that I don't compile so cscope isn't set up meaning
   it's hard to find the functions.

You're sending a lot of patches and they are all hard to review and some
of them are buggy and none of them really add any value.  It's a waste
of your time and it's a waste of my time.

regards,
dan carpenter
