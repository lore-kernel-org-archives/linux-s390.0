Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5457B268.3020202@users.sourceforge.net>
Date: Mon, 03 Nov 2014 17:50:48 +0100
From: SF Markus Elfring <elfring@users.sourceforge.net>
MIME-Version: 1.0
Subject: Re: s390/net: Deletion of unnecessary checks before two function
 calls
References: <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.sourceforge.net> <5453C98C.90105@users.sourceforge.net> <20141103095059.GL6879@mwanda> <5457A560.2020304@users.sourceforge.net> <20141103162528.GT6890@mwanda>
In-Reply-To: <20141103162528.GT6890@mwanda>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Ursula Braun <ursula.braun@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Frank Blaschka <blaschka@linux.vnet.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, trivial@kernel.org, Coccinelle <cocci@systeme.lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

> After your patch then it will print warning messages.

To which messages do you refer to?


> The truth is I think that all these patches are bad and they make the
> code harder to read.
> 
> Before:  The code is clear and there is no NULL dereference.

Where do you stumble on a null pointer access?


>  After:  You have to remember that rtw_free_netdev() accepts NULL
> 	 pointers but free_netdev() does not accept NULL pointers.

Are any improvements needed for the corresponding documentation to make it
better accessible besides the source code?


> The if statements are there for *human* readers to understand and you are
> making it harder for humans to understand the code.

Is there a target conflict between source code understandability
and software efficiency?


> Even for kfree(), just removing the if statement is not really the right
> fix.  We do it because everyone knows kfree(), but what Julia Lawall
> said is the real correct way change the code and make it simpler for
> people to understand:
> 
> https://lkml.org/lkml/2014/10/31/452

You refer to another update suggestion for the software area
"staging: rtl8188eu".
Do you find adjustments for jump labels easier to accept than the simple
deletion of specific null pointer checks?


> I know it's fun to send automated patches but these make the code worse
> and they waste reviewer time.

I hope that small automated changes can also help to improve affected
source files.

Regards,
Markus
