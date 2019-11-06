Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:60354 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727824AbfKFPOn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 10:14:43 -0500
From: Christoph Hellwig <hch@lst.de>
Subject: disk revalidation cleanups and fixlets
Date: Wed,  6 Nov 2019 16:14:34 +0100
Message-Id: <20191106151439.30056-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>
Cc: linux-block@vger.kernel.org, linux-s390@vger.kernel.org

Hi Jens and Jan,

this series takes the disk size change detection and revalidations
from Jan a step further and fully integrate the code path for
partitioned vs non-partitioned devices.  It also fixes up a few
bits where we have unintentionally differing behavior.
