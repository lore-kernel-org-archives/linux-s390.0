Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2720C394464;
	Fri, 22 May 2026 13:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779455384; cv=none; b=RKZc7rgWje19J7CRnQDm7ofiIiu2POj3CMmWK8/tX9BEmbW93hNo203MHo7cOceQpgwLIhopv1uMazKt+40b08X6s2M1CQVI3vRE9Ykol3tHe5mFCRhWvYImyZxbupsR6qCliRhzoJSiU9VhHIiAR3EJ2a6+F1MWEfMWtrEa1WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779455384; c=relaxed/simple;
	bh=EQj1Rbpw/H3Oe/sDGMgX6onZ6xyYKXcG7QBzM5CpJi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cknFlQCXbtWgV06Vf25CzTaBWK82U5l8Jq5xupEU/hypJ31Qpgg6t9cQEGASFxuv7t2hJTjnHmaSBlIZFsxlnsJD+O2/yh1Ue84cXzf4+SSqz8rWpGSfMKCBVaXm/pgACXSB9tQoRT8depW521R44SjuLGdPqOchaL7kBgQUqoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pyFlsOsI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pyFlsOsI"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=EQj1Rbpw/H3Oe/sDGMgX6onZ6xyYKXcG7QBzM5CpJi0=; b=pyFlsOsI1W2H+d/c1dR87cu4A1
	nbk3QdhQ5igmGpectY46XehGUF3atPk8mqBTiAMYhp+RVUaHnf7U7vngJ2F4UAUNwxrJuFWL2uqdB
	d/WzjoEOMMz3D7k6H05YXwgJRsOWxWdJDddNXfpSrUVVgHRj5tJE6frgLHjiVX5xx+Bd6y6rK5bDz
	BjnT1OR4KHVpKXlgod+qjgxUoNjEidgt2I4IkCQEqjwx8IU2B9gxtaWWSot0M7QRZv1MxzvStf58r
	evpBrKrXC124rfJ3AuHL6Tt3FC+WRpKb7tjf8+PbXNt3tbgW/GZM31sgXDj/od4TakCYHwR3VUGW7
	FSgIl7pw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQPd1-0000000A7eI-1OCp;
	Fri, 22 May 2026 13:09:27 +0000
Date: Fri, 22 May 2026 14:09:27 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Barry Song (Xiaomi)" <baohua@kernel.org>
Cc: akpm@linux-foundation.org, bhe@redhat.com, chentao@kylinos.cn,
	chrisl@kernel.org, david@kernel.org, jack@suse.cz,
	kasong@tencent.com, kunwu.chan@gmail.com, liam@infradead.org,
	lianux.mm@gmail.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, liyangouwen1@oppo.com,
	ljs@kernel.org, loongarch@lists.linux.dev, mhocko@suse.com,
	nphamcs@gmail.com, nzzhao@126.com, pfalcato@suse.de,
	rppt@kernel.org, shikemeng@huaweicloud.com, surenb@google.com,
	vbabka@kernel.org, wanglian@kylinos.cn, youngjun.park@lge.com
Subject: Re: [PATCH v2 0/5] mm: reduce mmap_lock contention and improve page
 fault performance
Message-ID: <ahBVh4NM2uoyhPNm@casper.infradead.org>
References: <ag4kj84EcKqamdB-@casper.infradead.org>
 <20260522023305.98223-1-baohua@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522023305.98223-1-baohua@kernel.org>

On Fri, May 22, 2026 at 10:33:05AM +0800, Barry Song (Xiaomi) wrote:
> need to touch `filemap.c` at all (probably because you are already
> maintaining `filemap.c` perfectly):

I'm going to give you one chance to apologise for that.
