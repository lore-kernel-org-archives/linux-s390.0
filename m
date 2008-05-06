From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 06 May 2008 11:34:25 +0000
Subject: Re: [PATCH] s390 ptrace cleanup
Message-Id: <1210073665.31803.13.camel@localhost>
In-Reply-To: <1210063997.31803.3.camel@localhost>
References: <1210063997.31803.3.camel@localhost>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Roland,

On Tue, 2008-05-06 at 01:49 -0700, Roland McGrath wrote:
> I have not tested this at all nor even compiled it.
> But it's, you know, probably fine.  Season to taste.
> Modulo anything broken so it won't compile, it probably
> won't have any subtle problems.  (But someone who actually
> hacks on s390 should verify that ptrace still works.)

I fixed a few "cast to pointer from integer of different size" warnings
but apart from that the patch works fine. I'll add it to the s390 patch
queue. Many thanks, that removes a to-do from my list.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
