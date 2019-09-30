Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:37843 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730780AbfI3O4O (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Sep 2019 10:56:14 -0400
Date: Mon, 30 Sep 2019 16:56:07 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/1] s390/cio: fix virtio-ccw DMA without PV
Message-ID: <20190930145607.GA18163@lst.de>
References: <20190930135310.26148-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930135310.26148-1-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>

The code looks fine, but I still very much disagree with the workaround
comments.  The different mask for allocations vs streaming mappings is
exactly how the DMA API is intended to work.
