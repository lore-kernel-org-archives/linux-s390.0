Return-Path: <linux-kernel-owner+w=401wt.eu-S1761433AbXEULxb@vger.kernel.org>
Date: Mon, 21 May 2007 12:53:22 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [patch 1/5] cio: Update documentation.
Message-ID: <20070521115322.GB15143@infradead.org>
References: <20070521105118.955425052@de.ibm.com> <20070521110108.214724333@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070521110108.214724333@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, May 21, 2007 at 12:51:19PM +0200, Martin Schwidefsky wrote:
> From: Cornelia Huck <cornelia.huck@de.ibm.com>
> 
> - read_dev_chars()/read_conf_data() are deprecated. Don't document them, but
>   advise to issue the channel program from the driver itself.

What's the reason these function aren't just removed?  They're just unused
bloat right now.
