From: "Alan D. Brunelle" <Alan.Brunelle@hp.com>
Date: Thu, 17 Jul 2008 12:27:53 +0000
Subject: Re: [Patch 0/3] driver data: blktrace pass-through support for	device
Message-Id: <487F3AC9.8080708@hp.com>
In-Reply-To: <1216297065.26621.147.camel@kitka.ibm.com>
References: <1216297065.26621.147.camel@kitka.ibm.com>
To: linux-s390@vger.kernel.org, linux-btrace@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Martin Peschke wrote:
> On Wed, 2008-07-16 at 11:15 -0400, Alan D. Brunelle wrote:
>> Martin Peschke wrote:
>>> On Wed, 2008-07-16 at 10:47 -0400, Alan D. Brunelle wrote:
>>>> Hm, again, if the blktrace | blkiomon (direct, no blkparse) is how
>>>> you do things,
> 
> blktrace | blkiomon   works out of the box :-)
> 
> 

Great - that should remove a lot of CPU processing...

Alan
