Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Christoph Hellwig <hch@lst.de>
Subject: stop using ioctl_by_bdev in the s390 DASD driver
Date: Tue, 21 Apr 2020 08:12:23 +0200
Message-Id: <20200421061226.33731-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Jens Axboe <axboe@kernel.dk>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Jens and DASD maintainers,

can you take a look at this series, which stops the DASD driver from
issuing ioctls from kernel space, in preparation of removing
ioctl_by_bdev.  I don't really like the new s390-only method, but short
of forcing the dasd driver to be built into the kernel I can't think of
anything better.  But maybe the s390 maintainers are fine with forcing
the DASD driver to be built in, in which case we could go down that
route?
