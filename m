Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
Subject: Re: [PATCH] s390/dasd: fix build warning in dasd_eckd_build_cp_raw
References: <20190509100314.19152-1-ming.lei@redhat.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <37bda439-1c86-0fb7-31c5-cf6be6625546@kernel.dk>
Date: Thu, 9 May 2019 08:10:32 -0600
MIME-Version: 1.0
In-Reply-To: <20190509100314.19152-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-block/>
List-Post: <mailto:linux-block@vger.kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 5/9/19 4:03 AM, Ming Lei wrote:
> Commit 72deb455b5ec619f ("block: remove CONFIG_LBDAF") changes
> sector_t to u64 unconditionaly, so apply '%llu' for print
> sector_t variable.

Applied, thanks Ming.

-- 
Jens Axboe
