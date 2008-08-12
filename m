From: Jan Glauber <glauber@gmx.de>
Date: Tue, 12 Aug 2008 11:33:09 +0000
Subject: Re: __kernel_ino_t == 32bit
Message-Id: <1218540789.8269.3.camel@localhost.localdomain>
In-Reply-To: <20080809141428.GA7813@wavehammer.waldi.eu.org>
References: <20080809141428.GA7813@wavehammer.waldi.eu.org>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Bastian,

On Sat, 2008-08-09 at 16:14 +0200, Bastian Blank wrote:
> Hi folks
> 
> Is there a reason why both 32 and 64Bit kernel have __kernel_ino_t 32bit
> wide? Any other arches have it matching the word size.

I don't think there is a reason and my machine does not complain if I
change it the 64Bit __kernel_ino_t to "unsigned long". But what about
the comment in the header file that the types are used by userspace?
Can we easily change that without breaking things?

Jan

> Bastian
> 
