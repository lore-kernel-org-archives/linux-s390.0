Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716C122759D
	for <linux-s390@vger.kernel.org>; Thu, 19 Dec 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625378; cv=none; b=apyMMLJLPOWFYW+eBedQ4MdMmEO3hftZ2a51ay2wjtqvBjuJTPcLDsT4aS1jXvMLEE1jLNswLTJwccP0mnpDjWGkhf2xfDE5lY/6wlkQGoBViv9z5EG5mvukamA0BEFvIX9lLNzPfbZ4ywNmmFsDldvibFHSB/LIYXIlKj+EIzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625378; c=relaxed/simple;
	bh=d9sovfrfk+XgyFky+mf1z39ui6rrAV5rbgWHyIgoVbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qZlJxvv5MXqNZlmebFVkhoviF5x3ahLMlqyPHhIiB4Sbw0toCaJm6OTxJqDK0ocFIW8VolRaTvFaAWICpNMZys8KT9iK+Ov+DiEeRg9BN6if2+N4erf4XTDGozJuihPez9YMdQ1ucN9cQhJKojPtNcvXXQY/1fxy2Z6N2jIXmmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZKNloQmm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZKNloQmm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=zpdurc7hXiWty+z2UpxEWEMLZuI+HucYbCrpLvVwsYc=; b=ZKNloQmmnUwMnKrhp484s8w74Z
	9YRfYWBvtnmqNtQ1JdZWvI/J1/Viy0F4gctzZFTyM0gfJOHBUksHhnhwG8TuNGEr9GGMtfTerWlM6
	W1EwTUGQQaFECxhIhGkQDK5y3AQ/e3CVPo5DGn201hJxR2KmfjEpIEH4HDXCjIgoFHdDmLPbvuUPz
	he74VFlGQKuD8Tnn8cf7yvA8iQEH66LOXCYLh8/g16WwWk1civjfp/CILBFNDbDx8Y2ZavPVz/eZ+
	xc8f+vTww1QmxxpEkS9qDaAxHOP37RvgHRQSMiHJfn0NxcFPweaFjo+zSDeZ02+m+m2uY+4GTUGMe
	HrXCJM8g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOJIb-00000004Ijp-3Lny;
	Thu, 19 Dec 2024 16:22:54 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org
Subject: [PATCH 0/2] s390: Remove uses of page->index
Date: Thu, 19 Dec 2024 16:22:48 +0000
Message-ID: <20241219162252.1025317-1-willy@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two patches compile ... I can promise nothing more than that.

David suggested to me that the gmap code really should be using ptdesc,
and I think I agree with him.  The vsie code looks quite different
and probably shouldn't be using a ptdesc, but we can use page->private
instead of page->index.  It's not yet clear to me if we'll ever manage
to get rid of page->private.

Matthew Wilcox (Oracle) (2):
  s390: Convert gmap code to use ptdesc
  s390: Convert vsie code to use page->private

 arch/s390/kvm/vsie.c |   6 +-
 arch/s390/mm/gmap.c  | 181 +++++++++++++++++++++----------------------
 2 files changed, 92 insertions(+), 95 deletions(-)

-- 
2.45.2

