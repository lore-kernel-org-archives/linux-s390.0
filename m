Return-Path: <hch@lst.de>
Date: Thu, 11 Jan 2018 18:46:54 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
	virtio-blk (also 4.12 stable)
Message-ID: <20180111174654.GA10280@lst.de>
References: <92ef1aae-90b5-f14f-390e-bfab97899431@de.ibm.com> <419d8565-9cbe-16ac-3d5d-5945098694bc@de.ibm.com> <20171127155409.GA6937@lst.de> <d0f39408-b697-8d1a-2cce-b833cb8fa118@de.ibm.com> <20171204162108.GA12482@lst.de> <5ab91c56-b117-f4fa-3049-a4f8a5493155@de.ibm.com> <20171206232924.GA16584@lst.de> <0520e469-563b-486c-9ab8-00d8944ffa9d@linux.vnet.ibm.com> <04aff6c6-5c04-a2b5-e886-b747cb51f39e@de.ibm.com> <20180111091318.GA13969@ming.t460p>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180111091318.GA13969@ming.t460p>
List-Archive: <https://lore.kernel.org/linux-block/>
List-Post: <mailto:linux-block@vger.kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Stefan Haberland <sth@linux.vnet.ibm.com>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Bart Van Assche <Bart.VanAssche@wdc.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Thanks for looking into this Ming, I had missed it in the my current
work overload.  Can you send the updated series to Jens?
