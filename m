Return-Path: <linux-kernel-owner+w=401wt.eu-S1760426AbXEUMAh@vger.kernel.org>
Date: Mon, 21 May 2007 14:00:25 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [patch 1/5] cio: Update documentation.
Message-ID: <20070521140025.7b9344a5@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20070521115322.GB15143@infradead.org>
References: <20070521105118.955425052@de.ibm.com>
	<20070521110108.214724333@de.ibm.com>
	<20070521115322.GB15143@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 21 May 2007 12:53:22 +0100,
Christoph Hellwig <hch@infradead.org> wrote:

> On Mon, May 21, 2007 at 12:51:19PM +0200, Martin Schwidefsky wrote:
> > From: Cornelia Huck <cornelia.huck@de.ibm.com>
> > 
> > - read_dev_chars()/read_conf_data() are deprecated. Don't document them, but
> >   advise to issue the channel program from the driver itself.
> 
> What's the reason these function aren't just removed?  They're just unused
> bloat right now.

They had been a documented and exported interface for ages, and I
didn't feel like breaking external modules without some warning
beforehand.
