Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB5E14AD28;
	Wed, 28 Feb 2024 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709127467; cv=none; b=ftoxCFJo9+Z7MIXyJfWyBjrdZVHqpxddIk7SSZO6H9+YwcePf3H/+FCUCMTaLXhzccP+Xpg2xgH3Jt/qBrVfVBR+z0gztxYOAgGcfaddkDn1d3hW+QyyDtND2rWd47PVJZPVgjv+Y0ox16d+gr5sMFzPN/ekKtbATkIcOQsQ4DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709127467; c=relaxed/simple;
	bh=JqGXMBq65op/Qy+EG55J1oz2oqP+4iUCbKK6PZPtyl4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gviYoBYajHuIGyiGZEpoXG1eCp4bcOjRAS/UFyX/Y61FiJ4Pet5vaahhBn+cuXUmr2OPZCHYHfU5yKvVmFH3WuX6zddlSzMQo+HVPvXSxWs1hx1Exk0H73DsgHC/J9X25UTuHbzJQoruPzSDVEY3jvQXcn+NEfqLdsChw5OHaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y4X1sYUm; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y4X1sYUm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=lVNPAPGA+h0o4cxvL3oDHWUn97g5358seVc2XljryYA=; b=y4X1sYUmA5xuKw1cSQ25jpReou
	ggXikQlGWhTLx8sbDkB37hyr6rii3fbF1f9gG472Tq1b9EO+r8ec/SwzbN5WqzeG+BH1XUYCW4hVz
	yjMXdxNc8wlzdJYZVJX9JRdYhyvbbBHvxMExZatPYxfsSY5EBBn5XLJgaWDQ7r0NpHEUpo8W+DolN
	ZDRz4H2WqQ0Lq9EIcPB22wZoI1CmdWnKehDjHyrb0K61VR/ZPrvcSSB+hTks6nUvZbf1l82MI97yv
	pYxb4FgXJyU8jjfz0AMMyFBkqPX/tWaUqcELAOnwq3XnnlUlu332b4wbJA9VmRavujC7voAw7aMZA
	11UWJXmQ==;
Received: from [12.229.247.3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfK80-00000009V8V-2bcU;
	Wed, 28 Feb 2024 13:37:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: convert dasd to the atomic queue limits update API v2
Date: Wed, 28 Feb 2024 05:37:39 -0800
Message-Id: <20240228133742.806274-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi dasd maintainers,

this series against the block/for-6.9 tree converts dasd to the new atomic
queue limits update API.  It is compile tested only as I don't have any
s390 hardware.  If this is fine with you it would be great to merge it
through Jens' tree with your ACKs

Changes since v1:

 - rename the max_transfer method to max_sectors
 - shift the max_sectors value to the correct unit in all disciplines

Diffstat:
 dasd.c       |   74 ++++++++++++++++++++++++++++++++++++-----------------------
 dasd_diag.c  |   22 ++---------------
 dasd_eckd.c  |   29 ++++-------------------
 dasd_fba.c   |   33 +++-----------------------
 dasd_genhd.c |   13 +++++++++-
 dasd_int.h   |    6 +---
 6 files changed, 73 insertions(+), 104 deletions(-)
