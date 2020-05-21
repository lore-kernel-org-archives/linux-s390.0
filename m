Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v4 0/2] s390/dasd: remove ioctl_by_bdev from DASD driver
References: <20200519142259.102279-1-sth@linux.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3889844e-20eb-6b33-6bbd-109d11b0a71e@kernel.dk>
Date: Thu, 21 May 2020 08:22:48 -0600
MIME-Version: 1.0
In-Reply-To: <20200519142259.102279-1-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>, hch@lst.de
Cc: hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com

On 5/19/20 8:22 AM, Stefan Haberland wrote:
> Hi Christoph,
> 
> here are the patches again. Reviewed and tested internally with DASD as
> well as DASD labeled virtblk devices.
> So if you agree with the two patches I have no objection against an
> inclusion.

Applied for 5.8, with Christoph's removal patch as well.

-- 
Jens Axboe
