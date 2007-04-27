Return-Path: <linux-kernel-owner+w=401wt.eu-S1755846AbXD0OZ4@vger.kernel.org>
Date: Fri, 27 Apr 2007 15:25:06 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch 18/38] Improved oops output.
Message-ID: <20070427142506.GA12738@infradead.org>
References: <20070427140503.087958775@de.ibm.com> <20070427140516.013904506@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070427140516.013904506@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 27, 2007 at 04:05:21PM +0200, Martin Schwidefsky wrote:
> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> This patch adds two improvements to the oops output. First it adds an
> additional line after the PSW which decodes the different fields of it.
> Second a disassembler is added that decodes the instructions surrounding
> the faulting PSW. The output of a test oops now looks like this:

So we're growing in-kernel disassemblers now? :)

I wonder whether this is really worth it, but at least your handwritten
one is much nicer than the copy & paste from gdb in the kdb patches.
