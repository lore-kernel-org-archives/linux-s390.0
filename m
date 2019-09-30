Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:38336 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727508AbfI3QLB (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Sep 2019 12:11:01 -0400
Date: Mon, 30 Sep 2019 18:10:57 +0200
From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 1/1] s390/cio: fix virtio-ccw DMA without PV
Message-ID: <20190930161057.GA32237@lst.de>
References: <20190930153803.7958-1-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930153803.7958-1-pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.ibm.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
