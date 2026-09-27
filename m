Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DED92F532F;
	Sun, 27 Sep 2026 22:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549721; cv=none; b=p4vmPqswoSRq/kTmpyhsmxgjRRqD+/vNi4+RRRAS4W659wpEt1r4XbgMm+ZJ4WwTRdyjieDG62D98akB2e0v2/z19DoAttAMfZTCW5NUL/avQMGWDTC/disdNLBZqc2Dil6vE1QMIC7iuCSizt9/WJHjddl62DQpIgUIOTG41Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549721; c=relaxed/simple;
	bh=mC6/VZlfYhtXcePRRuT2KfGvn5KsIYXCXji30sfsqL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fy71Qd5qsEsd7sdzMRnYXenuZZAE1V3WxuLhHwytMKuAE3QF+3zkXdLvOdF/ucbDFczfWxUD0Bcjf1Mo6ErB5zLbxpUGj8OG0qKWrp9shJUBtAnLWGcHTlIA/aagiXjImN/UbMD4KzlmSO3uARW7VL7CHueuRX49itydyOwAQgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eIGI0kb8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eIGI0kb8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fonZKBEVnLUi3nmIxkkXaoCZILdYms0d8ZYuqeeaJBg=; b=eIGI0kb8JoQ6f59QATnKY4VWTy
	KlWA18PX6hX10BKhOmxNq0tGi3u1aRfvl4+RCRxnypG+Q3zub+tAGfPLahvJ7UxrqebG6Hw87AV+5
	pjJ5wII77N8SG6ISTZur4tDlzHyQJG/AruwRnBvYUL5h5vM1R4LIVih5MQuljHXPOD6svEMX0vt5w
	fN1uh3q8xkndWOy2mJeEInuuRC2htXs6SWKt9eP27BmPHjB6Elzy1vZxpqCT0Gl7etIkQcBpxUbK4
	n8v611VA11zwhLqKPmNANUdBBOafXd7NBkYlngO75KzUN/H3oVubmt74amemlxLWMaFpHJpsXr2/5
	Lk6vs5tg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAxlt-000000025TY-0cPK;
	Sun, 27 Sep 2026 22:55:01 +0000
Date: Sun, 27 Sep 2026 23:55:01 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Hongru Zhang <zhanghongru06@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, baohua@kernel.org,
	surenb@google.com, david@kernel.org, liam@infradead.org,
	mhocko@suse.com, rppt@kernel.org, shakeel.butt@linux.dev,
	vbabka@kernel.org, zhaonanzhe@xiaomi.com, linux@armlinux.org.uk,
	catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org, chenhuacai@kernel.org,
	kernel@xen0n.name, loongarch@lists.linux.dev, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org,
	linuxppc-dev@lists.ozlabs.org, pjw@kernel.org, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr,
	linux-riscv@lists.infradead.org, agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com,
	linux-s390@vger.kernel.org, dave.hansen@linux.intel.com,
	luto@kernel.org, peterz@infradead.org, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
	Hongru Zhang <zhanghongru@xiaomi.com>
Subject: Re: [PATCH v6] mm: retry page faults once under the per-VMA lock
Message-ID: <armexcXDiG8ryZd6@casper.infradead.org>
References: <20260911025613.1220845-1-zhanghongru@xiaomi.com>
 <arFYRAa-i7CIwmHL@gremlin>
 <arF-E3Nsw9ZliH0t@casper.infradead.org>
 <arI_w2wTfA00Mgy9@gremlin>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arI_w2wTfA00Mgy9@gremlin>

On Tue, Sep 22, 2026 at 09:55:23AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Mon, Sep 21, 2026 at 07:57:23PM +0100, Matthew Wilcox wrote:
> > more to say on this in two weeks at Plumbers.
> 
> I look forward to it :)

So while doing my slides, I realised that what we need to avoid doing
is (a) sleeping while holding the mmap_lock (b) returning RETRY while
holding the VMA lock

And that turns out to be as simple as this patch:

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dd09c438fa23..94ed2333f8d8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -723,6 +723,8 @@ enum {
  */
 static inline bool fault_flag_allow_retry_first(enum fault_flag flags)
 {
+	if (flags & FAULT_FLAG_VMA_LOCK)
+		return false;
 	return (flags & FAULT_FLAG_ALLOW_RETRY) &&
 	    (!(flags & FAULT_FLAG_TRIED));
 }

OK, this is a hack.  The function is spectacularly badly named, and
needs to be renamed before a patch can go upstream.  But this should
fix the contention on mmap_lock.

Could somebody try it?  I've verified it boots and runs some userspace
fine, but I don't have the workload to test the contention.
