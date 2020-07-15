Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgGOGs5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 15 Jul 2020 02:48:57 -0400
Date: Wed, 15 Jul 2020 07:48:54 +0100
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/2] s390/dasd: fix inability to use DASD with DIAG driver
Message-ID: <20200715064854.GA5409@infradead.org>
References: <20200714200327.40927-1-sth@linux.ibm.com>
 <20200714200327.40927-2-sth@linux.ibm.com>
 <c368fa07-4a7d-3eae-6143-a2db298c204e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c368fa07-4a7d-3eae-6143-a2db298c204e@kernel.dk>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>, linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

On Tue, Jul 14, 2020 at 02:12:27PM -0600, Jens Axboe wrote:
> Just curious, any reason this isn't just using bio_alloc()?

The dasd_diag_bio doesn't seem to have anything to do with the
block layer struct bio..
