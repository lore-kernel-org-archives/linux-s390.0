Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [BUG] Regression introduced with "block: split bios to max
 possible length"
References: <56A0F1CA.4010303@linux.vnet.ibm.com>
From: Jens Axboe <axboe@fb.com>
Message-ID: <56A14EE4.1020008@fb.com>
Date: Thu, 21 Jan 2016 14:34:28 -0700
MIME-Version: 1.0
In-Reply-To: <56A0F1CA.4010303@linux.vnet.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stefan Haberland <sth@linux.vnet.ibm.com>, keith.busch@intel.com, torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 01/21/2016 07:57 AM, Stefan Haberland wrote:
> Hi,
>
> unfortunately commit e36f62042880 "block: split bios to maxpossible length"
> breaks the DASD driver on s390.  We expect the block requests to be
> multiple
> of 4k in size. With the patch applied I see the requests split up in
> multiple
> of 512 byte and therefore the requests get rejected and lots of I/Os fail.

Sigh, that's definitely a bug. I'll take a look at it and see if I can 
get a tested fix in for 4.5-rc1. If not, we'll revert it, again.


-- 
Jens Axboe
