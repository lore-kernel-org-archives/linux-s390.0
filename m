Return-Path: <linux-kernel-owner+w=401wt.eu-S1756039AbXD0QBr@vger.kernel.org>
Message-ID: <46321E5E.9010909@redhat.com>
Date: Fri, 27 Apr 2007 12:01:34 -0400
From: Chuck Ebbert <cebbert@redhat.com>
MIME-Version: 1.0
Subject: Re: [patch 18/38] Improved oops output.
References: <20070427140503.087958775@de.ibm.com>	 <20070427140516.013904506@de.ibm.com>	 <20070427142506.GA12738@infradead.org> <1177687465.23773.2.camel@localhost>
In-Reply-To: <1177687465.23773.2.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Martin Schwidefsky wrote:
>> So we're growing in-kernel disassemblers now? :)
>>
>> I wonder whether this is really worth it, but at least your handwritten
>> one is much nicer than the copy & paste from gdb in the kdb patches.
> 
> The disassembler uses about 8K of memory and it really helps in
> debugging. For me it is worth the cost.
> 

No ksymoops for your architecture?
