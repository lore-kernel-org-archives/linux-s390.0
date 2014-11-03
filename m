Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <5457A560.2020304@users.sourceforge.net>
Date: Mon, 03 Nov 2014 16:55:12 +0100
From: SF Markus Elfring <elfring@users.sourceforge.net>
MIME-Version: 1.0
Subject: Re: s390/net: Deletion of unnecessary checks before two function
 calls
References: <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net> <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6> <5317A59D.4@users.sourceforge.net> <5453C98C.90105@users.sourceforge.net> <20141103095059.GL6879@mwanda>
In-Reply-To: <20141103095059.GL6879@mwanda>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Ursula Braun <ursula.braun@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Frank Blaschka <blaschka@linux.vnet.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, trivial@kernel.org, Coccinelle <cocci@systeme.lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

> This one is buggy.

I am still interested to clarify this opinion a bit more.


> I'm sorry, but please stop sending these.

I am going to improve more implementation details in affected source files.


> But for this one:
> 1) I don't know what the functions do so I have to look at the code.

I hope that static source code analysis can help here.


> 2) It's in a arch that I don't compile so cscope isn't set up meaning
>    it's hard to find the functions.

Do you find the Coccinelle software also useful for your area?


> You're sending a lot of patches and they are all hard to review and some
> of them are buggy and none of them really add any value.

Thanks for your feedback.


The suggested source code clean-up might result in a measurable effect
depending on the call frequency for the changed functions.
Can I help you in any ways to make corresponding review easier?


> It's a waste of your time and it's a waste of my time.

It can be your choice to reject my update suggestion.

Regards,
Markus
