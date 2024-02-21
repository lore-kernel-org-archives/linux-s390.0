Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCE24F885;
	Wed, 21 Feb 2024 12:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708520083; cv=none; b=Ksp5ha/TG2VS4viCrKezJHw7mggSfwixSGkxYrVxss0vy/BvR1SIuzOD4iSFM9CYWS5baCt96y/feD7pkV5TMXXgATp62ZCN2L+Wu8lQBkEANo6wWV1fEB60XcRJ1KXpm5aixLiAjDhoO9yAw4WV0Le0PxlyPMfht14LA/DDJqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708520083; c=relaxed/simple;
	bh=xMuaRQmi8mF5oJ4sAY/kcWGv06Rgret1C6NYbGFH4kQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SsWNbMnLi35S91BQOoQ9CqjzBhRHWwwdTpLcSJBD3iDDm8xQ9aKGt4ORjUNi19vk4cONa5Eajh5omNCkjRYKaunmIaXc2J6qPAgcwGulyO0dY0nEPfFJdUdHV/P23QX73vSucX5PBtZfiUcuqRxW1KXHXfCZKQzU+MkENz2FgqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KZvckHvZ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KZvckHvZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=yvYGHSzCWCkwzgThPl2l4RB3q5bq4w0D/LjLU6sE6rg=; b=KZvckHvZIb82JdXju4HoA3vnzl
	ddQLo7tEfWsD9aGqBiMC5Q/2E5r/GlCha0pytswGp4TbbuJFZox/v4vl1fTi1atIzzUgIt5xyWHgu
	Y3D7PZ98onDicgZXjDISBaQ+JE5Ema21uCXlFkbvmO5gckR/vK6lLh2rWEH6HGO1620mqv5OnauKi
	0dA/mzFx+hgaBZDV/yHK5+n5/eBkf6XYj3wlexyAMKbxWqat81UAtdSBHs059N16lqL14qL9h0P8A
	ogrg8traOX/utjeOJCHlbDSNCxSMgwTPqFkbjbgW0crMS1MQ5VdJoaMykX6AJAZnrO0w6bSUyvfAu
	YOgaXx3w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rcm7U-00000000vJL-35Sw;
	Wed, 21 Feb 2024 12:54:41 +0000
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
Subject: convert dasd to the atomic queue limits update API
Date: Wed, 21 Feb 2024 13:54:35 +0100
Message-Id: <20240221125438.3609762-1-hch@lst.de>
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
s390 hardware.

Diffstat:
 dasd.c       |   74 ++++++++++++++++++++++++++++++++++++-----------------------
 dasd_diag.c  |   22 ++---------------
 dasd_eckd.c  |   29 ++++-------------------
 dasd_fba.c   |   33 +++-----------------------
 dasd_genhd.c |   13 +++++++++-
 dasd_int.h   |    6 +---
 6 files changed, 73 insertions(+), 104 deletions(-)
