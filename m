Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:53340 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgEHPxp (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 8 May 2020 11:53:45 -0400
Date: Fri, 8 May 2020 17:53:42 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 3/3] s390/dasd: remove ioctl_by_bdev calls
Message-ID: <20200508155342.GC4200@lst.de>
References: <20200508131455.55407-1-sth@linux.ibm.com> <20200508131455.55407-4-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508131455.55407-4-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>
Cc: hch@lst.de, axboe@kernel.dk, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, linux-kernel@vger.kernel.org, borntraeger@de.ibm.com

I think this should use symbol_get instead.
