Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:59708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728541AbgDNH3I (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Apr 2020 03:29:08 -0400
From: Christoph Hellwig <hch@lst.de>
Subject: more partition handling cleanups v2
Date: Tue, 14 Apr 2020 09:28:52 +0200
Message-Id: <20200414072902.324936-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-block@vger.kernel.org, linux-s390@vger.kernel.org

Hi Jens,

this series cleans up more lose ends in the partitioning code.  It also
removes a rather annoying use of ioctl_by_bdev in the s390 dasd driver.

Changes since v1:
 - fix a brown paperbag typo in blkpg_do_ioctl
 - fix a commit message typo
