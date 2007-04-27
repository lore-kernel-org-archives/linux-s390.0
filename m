Return-Path: <linux-kernel-owner+w=401wt.eu-S1756061AbXD0QVo@vger.kernel.org>
Message-ID: <46322310.1090000@redhat.com>
Date: Fri, 27 Apr 2007 12:21:36 -0400
From: Chuck Ebbert <cebbert@redhat.com>
MIME-Version: 1.0
Subject: Re: [patch 18/38] Improved oops output.
References: <20070427140503.087958775@de.ibm.com>	 <20070427140516.013904506@de.ibm.com>	 <20070427142506.GA12738@infradead.org> <1177687465.23773.2.camel@localhost>	  <46321E5E.9010909@redhat.com> <1177690548.23773.13.camel@localhost>
In-Reply-To: <1177690548.23773.13.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Martin Schwidefsky wrote:
>> No ksymoops for your architecture?
> 
> There is ksymoops for s390 and it should be able to disassemble the code
> as well. But you need all sorts of files to feed into ksymoops to get
> something out of it. At least I often get bug reports with the console
> output attached and it simply saves time if I can see the disassembly
> without an extra step.
> 

The only file you need on i386 is the oops itself. ksymoops will scream
about missing files but will still work for disassembly.
