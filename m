Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: S390: Fine-tuning for six function implementations
References: <fac68081-f0bb-2574-ba52-11ad78d792c3@users.sourceforge.net>
 <51ba03f7-d1d8-8064-7dee-b5a910ad47de@oracle.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <4fd54bfb-d681-ae6f-d92c-795a6bc67a80@users.sourceforge.net>
Date: Tue, 9 May 2017 10:43:56 +0200
MIME-Version: 1.0
In-Reply-To: <51ba03f7-d1d8-8064-7dee-b5a910ad47de@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>, linux-s390@vger.kernel.org
Cc: =?UTF-8?Q?Christian_Borntr=c3=a4ger?= <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Peter Zijlstra <peterz@infradead.org>, Sascha Silbe <silbe@linux.vnet.ibm.com>, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

> It would be different if your patches fixed actual bugs.

I dare to point change possibilities out which correspond to a special error category.
There can be different opinions about their relevance for further software improvements.


> This is just mindless code transformations that MAY in the best case save a few bytes
> of code here and there (I don't know; you didn't say).

Do you know the run time characteristics for the discussed functions good enough?
http://elixir.free-electrons.com/linux/v4.11/source/fs/seq_file.c#L405


> But the potential gains from these incredibly numerous and tiny patches
> that don't fix anything are so small, it's a waste of time, bandwidth,
> and mental capacity for you and for everybody involved.

I suggest a bit of code reduction at various places once more.


> I just searched my inbox for patches from you and you sent literally
> _hundreds_ over the past few days,

I sent update suggestions in this scale since the year 2014.


> all doing this crazy printf/puts/putc transformation.

I agree that the corresponding number could be remarkable.
But there are also other source code search patterns involved besides information
around these logging functions.


> Another bit of searching and I see that I'm not the first one giving you
> this response:

You are right that some agreements and disagreements were expressed already
(depending on the software area).

Regards,
Markus
