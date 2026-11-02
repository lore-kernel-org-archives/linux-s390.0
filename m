Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.221
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626160;
	b=hq72xGeXETWTW1Fk0Xg36JSbqS1bU35imyBQCYwchrDspY030nIlFg6ZSUOETfe93u0a
	 jcvFe1vYyW7iQpHjI4XkhwNQXaPm6/uW/g1QOXmyvB+mMO0PVMJwsoBdFZOyRHk0UiJB9
	 sDa7VoRTuA+t551OS9C4f3c0wL4GQlO9YCsbU5TRERkVqEUiUX9flI3nBBM1wskllSI6X
	 zHWPwPeTS6NWGdDuUhpSQ+ZP1WwRow5JlrFWev0Y8sCWab3IGFfOWgDz6V+GNP5QhILfZ
	 L5BSG6weDjZJQCjHE/bV8KhZiBgtOjOc4oTvbkPd/euUczaOb/97Wl/KHnzwQuoz8YA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626160;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OHnx1MWHnNS05Fb0GSs5HhOjNANQI9agb14wDojH6MY=;
	b=d7FwUKUQLSPk3zarjzoWSOuD0IAIWF81qEm/fFRMFYiQuWIwXzhWSir9AMn3fZIoLyii
	 KHSewaewml1iRB2Wp/zyqidg1D4bqo3riz8fdq/MPECJH2E0zoJwVknu8x0VsZqb/mhAO
	 KRU2m6Uc9hTVlKPrMgMS48+7k/jdmGOPhR/gtSNBVJZxeCqMv4YvMPrgfh3K81jp7+Uj3
	 S6faVmelDiDFv6JcKRZGH4JHPVmImXtywWfLAm19hDVJ+ViwbzanfPurY0GvvqBiLAyEK
	 ZyeW/PFQWp3DRjGkQhnOAU83gcLDN8cRdeOkC2UvbALxaynYd/KAxWPBDHCQ1YpCt/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WnbDgX2C;
	arc=none smtp.remote-ip=91.218.175.221
Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74258606A332
	for <linux-s390@vger.kernel.org>; Mon,  2 Nov 2026 13:29:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74258606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WnbDgX2C
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KyHJ47bSIgeXP+kKXIy59s7ywWqOI47F3ePHg/aPldo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793626156; v=1; x=1794230956;
 b=WnbDgX2CJal+tGHK4IOZRa3i/XR/cZoUYAE/mf4c/TpsYnoIPm3AAvAsWKRYO4EJ/p6eXQcG
 eGk9Wsyp2sHcipSCom5x9DApbq/7+YBKdIkZ8ujC2zmuwUviebf8RydVTdBVBQCkosdqXFm8+d3
 1MGaysJVBw2Sqb0nmrTuhjpo=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 02021b5d7b6d5952;
	Mon, 02 Nov 2026 13:29:16 +0000
X-Mizu-Trace-ID: 02021b5d7b6d5952
X-Migadu-Flow: FLOW_OUT
From: xu.xin@linux.dev
To: xu.xin@linux.dev
Cc: acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alexander.shishkin@linux.intel.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	borntraeger@linux.ibm.com,
	byungchul@sk.com,
	chengming.zhou@linux.dev,
	david@kernel.org,
	dev.jain@arm.com,
	gerald.schaefer@linux.ibm.com,
	gor@linux.ibm.com,
	gourry@gourry.net,
	harry@kernel.org,
	hca@linux.ibm.com,
	irogers@google.com,
	james.clark@linaro.org,
	jannh@google.com,
	jolsa@kernel.org,
	joshua.hahnjy@gmail.com,
	kas@kernel.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	ljs@kernel.org,
	mark.rutland@arm.com,
	matthew.brost@intel.com,
	mhiramat@kernel.org,
	mhocko@suse.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	nico.pache@linux.dev,
	oleg@redhat.com,
	peterz@infradead.org,
	riel@surriel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com,
	surenb@google.com,
	svens@linux.ibm.com,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	xialonglong2025@163.com
Subject: [PATCH v2 1/4] mm/pagewalk: delete the unused member
Date: Mon,  2 Nov 2026 21:28:44 +0800
Message-Id: <20261102132844.301730-1-xu.xin@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102132416.300084-1-xu.xin@linux.dev>
References: <20261102132416.300084-1-xu.xin@linux.dev>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xu Xin <xu.xin@linux.dev>

The 'vma' member of struct folio_walk has never been used since it was
introduced by commit aa39ca6940f1a ("mm/pagewalk: introduce
folio_walk_start() + folio_walk_end()").

The VMA is always passed to folio_walk_start() as a separate argument,
and neither folio_walk_start() nor folio_walk_end() ever reads or writes
fw->vma. I audited all the current users of struct folio_walk (the
callers of folio_walk_start()) and none of them assign to or read the
member, so it is safe to remove.

Signed-off-by: Xu Xin <xu.xin@linux.dev>
---
 include/linux/pagewalk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/pagewalk.h b/include/linux/pagewalk.h
index b41d7265c01b..1c397be0d092 100644
--- a/include/linux/pagewalk.h
+++ b/include/linux/pagewalk.h
@@ -183,7 +183,6 @@ struct folio_walk {
 		pmd_t pmd;
 	};
 	/* private */
-	struct vm_area_struct *vma;
 	spinlock_t *ptl;
 };
 
-- 
2.34.1

