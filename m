Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7B84D134
	for <linux-s390@vger.kernel.org>; Fri, 22 Mar 2024 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123915; cv=none; b=Mb8M5sO0hFCkyzoY/Q/NIkgs5USnDgJMb0T5lAYoV2AOTaZAhmbagm6bdAOiw0zegWJXJN05P7ZLWewc1SnmswRFbPnRl/wQz77V56JixYTy7Kj9aw/Is2AXD36N6ccrZd3AmX6yJp8rRbOXvqfdnqjv+vdqlNZX9Ix7G+uCfo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123915; c=relaxed/simple;
	bh=olUVJdHtHs+XZRjFSam6sGHpeCcVeSFvF3M/yFU5I4U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Oj5tA+vDCGM49jO3F9dOqsxY+MyU0Ls5gUax2zbEHNzN02gcl5+Zxlmzt4ZSpcvcHOJcm3D8LASpbJ3BLyU/us63FvzybyOGNLZ4iE1rZGvLzB+4EzxUgBkoVrnFZlDXe3ynOiD0opkc3FkVtmS3KM10rkHcDOxI4J8HLmPCBBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NJkb8vOD; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NJkb8vOD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=xNj0ImorBPfZsPuJGPQBoHrX6ph4hN0PnXfk7d0MnFc=; b=NJkb8vOD4TarZ0XvqHoFsh1hvO
	KxrAhHTID4WFGLHqOsd+tr6V8i0vppaunpq2SUnZYo7i+KRxf7F6Ad6RNNEGE6EUDdSqmPGSxnMk7
	kN9M7VOBJjswMlHW33EYWfS9oP8yTYGXITS9ZKl7CdqeuyUzHp25VHnFpZcgTzNyHHtJj6hAnTRVF
	SiTT4EHJTMh57WGzZ8evIVI2uL8auSfDRy0PUmxzire2KC8BqdhO6WG8IuQdsSGzfSs5cyIuyN1FL
	EylgH7IayQSGaxGU/nqJMaHqE2fjXThjHBzh/OxanCQfcYetfyR2ZaYnfKdZ0D4EJbp8XC704L8wR
	V4pnCurw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnhUl-00000009lUt-1IbI;
	Fri, 22 Mar 2024 16:11:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org
Subject: [PATCH 0/2] Convert some gmap functions to use folios
Date: Fri, 22 Mar 2024 16:11:45 +0000
Message-ID: <20240322161149.2327518-1-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct page is going to lose its refcount (someday) and as part of
that page_ref_freeze() will go away.  s390's ultravisor is one of
the few remaining places that uses it, so convert it over to folios.
From previous interactions, I understand that ultravisor doesn't support
large folios, so this simply declines to make large folios secure.
I think you'd be better off splitting the folio if it is large, but
that's something I'd rather leave to someone who can test it.

These patches do have the effect of making this more efficient; we lose
at least five hidden calls to compound_head().

Matthew Wilcox (Oracle) (2):
  s390: Convert make_page_secure to use a folio
  s390: Convert gmap_make_secure to use a folio

 arch/s390/kernel/uv.c | 50 +++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 23 deletions(-)

-- 
2.43.0

