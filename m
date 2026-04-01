Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96252236453;
	Wed,  1 Apr 2026 06:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775025661; cv=none; b=Bc2X7OBtCLBfrBJS3dfwbgoa+25DZXof/76gPyK2mQnLjl21tF2VBUrBIG+/cpv4o9Blmbgqn+DMT87SV69ieYP4osL/gRGd72/D07la3bRVijS8zOP3QR13Xvr4QC/2/wkTVXJmO1NuF8sMx5c4z3lJFU1by0pKlM3+T9okCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775025661; c=relaxed/simple;
	bh=VgXkGleDE56iSrBxGzNVVdauyZJL7F52DcNWnYxkVE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IyiUcWKVtezOA/AtqZvsZrvY5dB4YXSw+sytpp+0uuR/W6FQvnPnA4CLpqO3jFkYT7Pj1Tz1tC1tPINJREhxB6z6K45OxnFtJvjf6imJMqmBQQFKhLujOwvl3NnBgCpEov43u4BtFz0684Jn9NNlYSFnITN5/2L0+mkskPWTmQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u4rW82cC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u4rW82cC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BZNsADTQStJfW08+sJ/qM9ChA0IzjA/RfogwGKzNOLo=; b=u4rW82cC6dKAzZAz19GxXu1DJh
	LHqjSE9VVZckS5MZ1TmBK7hVs4oLe/Za5atTcu4lzVHFpiUTVN0JtNsM392xxpjEMjExHJURh4wzz
	9DX0zvDoNZR4Rxs0vsxiAmfbKNwpkKS99lzXPfK4NYrSvlppwJ9xKfuWWtbH8m0lkdjwjU9D2715t
	VE6JHzoFVqnfkfmHWcDHndWGsE2fP5I1jhWTxlsyKJPzAipHvZO76FJ6IBc6weSz2LUfGGKDZ0YoJ
	L0XTWuJVR9XQ/fUaqi/G6883ah4V61tCT94N7eUllccUxnJ5ovLRTl/PO2oysgZ2BhasgibCNdLxJ
	YoDqH+4w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7pFw-0000000E7jK-11HD;
	Wed, 01 Apr 2026 06:40:48 +0000
Date: Tue, 31 Mar 2026 23:40:48 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, kvm@vger.kernel.org,
	linux-s390@vger.kernel.org
Subject: Re: [PATCH v1 0/4] KVM: s390: Permit ESA mode guests in VSIE
Message-ID: <acy98BMq0BoqWPn3@infradead.org>
References: <20260401020915.1339228-1-farman@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401020915.1339228-1-farman@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Apr 01, 2026 at 04:09:11AM +0200, Eric Farman wrote:
> Hi Hendrik, Janosch, et al,
> 
> Attached is a small series to allow ESA-mode guests in s390 VSIE.
> It continues to expect that z/Architecture is the default,
> unless opted in by userspace.
> 
> I look forward to your thoughts; thanks!

What is the use case for this?  Migrating existin VMs from 31-bit hosts
to 64-bit hosts?

