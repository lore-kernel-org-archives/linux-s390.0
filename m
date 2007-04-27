Return-Path: <linux-kernel-owner+w=401wt.eu-S1757308AbXD0VKz@vger.kernel.org>
Message-ID: <463266D3.8080607@redhat.com>
Date: Fri, 27 Apr 2007 17:10:43 -0400
From: Chuck Ebbert <cebbert@redhat.com>
MIME-Version: 1.0
Subject: Re: [patch 18/38] Improved oops output.
References: <20070427140503.087958775@de.ibm.com>	 <20070427140516.013904506@de.ibm.com>  <p733b2l3ct2.fsf@bingen.suse.de> <1177707409.7451.4.camel@localhost>
In-Reply-To: <1177707409.7451.4.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: Andi Kleen <andi@firstfloor.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Martin Schwidefsky wrote:
> On Fri, 2007-04-27 at 20:14 +0200, Andi Kleen wrote:
>> Martin Schwidefsky <schwidefsky@de.ibm.com> writes:
>>
>>> Second a disassembler is added that decodes the instructions surrounding
>>> the faulting PSW. 
>> Is that really needed? I use a simple wrapper around as/objdump for this
>> and it works great.
>>
>> (ftp://ftp.firstfloor.org/pub/ak/shell/decodecode) 
> 
> It is not absolutly needed but it is damn convenient. Usually I can
> immediatly see the reason for the oops. And the size is only 8KB which
> is next to nothing.
> 

Yeah, well your instruction set is really simple anyway. :)

I wonder how big the x86 disassembler is...
