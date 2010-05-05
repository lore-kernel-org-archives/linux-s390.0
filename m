Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 5 May 2010 08:16:20 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: deadline ALWAYS default for dasd devices(s390) ?
Message-ID: <20100505061620.GA2381@osiris.boeblingen.de.ibm.com>
References: <4BD58848.8090205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4BD58848.8090205@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Xose Vazquez Perez <xose.vazquez@gmail.com>, Stefan Weinhuber <wein@de.ibm.com>, Horst Hummel <Horst.Hummel@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 26, 2010 at 02:34:16PM +0200, Xose Vazquez Perez wrote:
> hi,
> 
> why is it FORCED ? bypassing a GLOBAL setting and also the kernel command line !!!
> 
> drivers/s390/block/dasd.c
> 
> /*
>  * Allocate and initialize request queue and default I/O scheduler.
>  */
> static int dasd_alloc_queue(struct dasd_block *block)
> {
> 	int rc;
> 
> 	block->request_queue = blk_init_queue(do_dasd_request,
> 					       &block->request_queue_lock);
> 	if (block->request_queue == NULL)
> 		return -ENOMEM;
> 
> 	block->request_queue->queuedata = block;
> 
> 	elevator_exit(block->request_queue->elevator);
> 	block->request_queue->elevator = NULL;
> 	rc = elevator_init(block->request_queue, "deadline");
> 	if (rc) {
> 		blk_cleanup_queue(block->request_queue);
> 		return rc;
> 	}
> 	return 0;
> }

Horst, Stefan W. or Stefan H. should be able to answer your question.
