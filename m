Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:45127 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731360AbhAYSOl (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 Jan 2021 13:14:41 -0500
Date: Mon, 25 Jan 2021 19:13:49 +0100
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 05/10] block: do not reassig ->bi_bdev when partition
 remapping
Message-ID: <20210125181349.GA14432@lst.de>
References: <20210124100241.1167849-1-hch@lst.de> <20210124100241.1167849-6-hch@lst.de> <dfdff48c-c263-8e7c-cb52-28e7bee00c45@kernel.dk> <20210125175528.GA13451@lst.de> <2b600368-96fa-7caf-f05b-321de616f7c9@kernel.dk> <13667b22-029b-d7be-02da-96fce22cfd8f@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13667b22-029b-d7be-02da-96fce22cfd8f@kernel.dk>
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Tejun Heo <tj@kernel.org>, Coly Li <colyli@suse.de>, Song Liu <song@kernel.org>, device-mapper development <dm-devel@redhat.com>, linux-bcache <linux-bcache@vger.kernel.org>, "open list:SOFTWARE RAID (Multiple Disks) SUPPORT" <linux-raid@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linux-block <linux-block@vger.kernel.org>

On Mon, Jan 25, 2021 at 11:03:24AM -0700, Jens Axboe wrote:
> Partition table entries are not in disk order.

And the issue shows up with the series just up to the this patch,
without any later patches?
