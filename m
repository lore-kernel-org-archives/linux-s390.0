Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-io1-f54.google.com ([209.85.166.54]:41303 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfKNOI6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 14 Nov 2019 09:08:58 -0500
Received: by mail-io1-f54.google.com with SMTP id r144so6882704iod.8
        for <linux-s390@vger.kernel.org>; Thu, 14 Nov 2019 06:08:57 -0800 (PST)
Subject: Re: disk revalidation cleanups and fixlets
References: <20191106151439.30056-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <e994fc4b-cc72-c2db-cc2c-754a0aa03057@kernel.dk>
Date: Thu, 14 Nov 2019 07:08:55 -0700
MIME-Version: 1.0
In-Reply-To: <20191106151439.30056-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org

On 11/6/19 8:14 AM, Christoph Hellwig wrote:
> Hi Jens and Jan,
> 
> this series takes the disk size change detection and revalidations
> from Jan a step further and fully integrate the code path for
> partitioned vs non-partitioned devices.  It also fixes up a few
> bits where we have unintentionally differing behavior.
> 

Were you going to re-send this on top of the other stuff for 5.5?
If so, should probably get queued up...

-- 
Jens Axboe
