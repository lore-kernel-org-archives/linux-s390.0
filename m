Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B21D30EF77;
	Mon, 24 Aug 2026 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556466; cv=none; b=mqWOOeaDdExeDi2jMqhdnaLKma8ExNC/Ty6vwIBMvAxsMFyq953NxkVVXhwAZdYLodMg6TyV6S/v2czOPAHreFpU3yubf4dcN9dhTNhCT8h5jfJ0+1GvX/8cxZ5X7jO+ZMdupZLXCVs7RgpkRik9h3w+gtaYBfaghzfHwOez/+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556466; c=relaxed/simple;
	bh=KfXzxN/sCr/F7pK2AdyGUYO5OQQU04dyr7yb+QQZaKI=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=PYyMCQf/X63XR8h67xJHxoL3YSwIU1JoEI6gUpk9VjAKRiGb8rdUoQtgmjXziCQs29ea6m4hVRSoMOJj5EcThtAogunVaAeDF+qgCyQL887RXBLZEMbQW8lc+17O2tIm9dJNzWuzrs9mA3fYxpzT5s9KlD3BhMZG+2uMtBafQZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hghfi3F3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hghfi3F3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B017B1F000E9;
	Mon, 24 Aug 2026 07:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787556464;
	bh=hpXldSP37oQmlhckItfAzwUOG6JobW41WzP0kSdLesI=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Hghfi3F3hhjgblfEVPUEEPHALjTTBAgKBK8MbewWtmMLpyrYB+8Jo29/224FAiShM
	 0SLcU5txHHDDVRBQmZbs0Km1ZqbqYphsVzR3okw73rVZzhWFSwmbPshMJk+4ij8Gwk
	 wBlW/tVqVoMXtxSb8VWH+7r37m/WC7KmAwdV5lxYZr50+jzu/iInwaVg4PoIgWPYV+
	 C5co0jxq4J2+miGm/bYP5+zECjtlCOUz+jUuPUU4mw1mdcjIPjf5Qqh658+sfYqF50
	 oCrhxE7AzAMSOiSyXc8TzEpXzk6qb68sZUnHfTQBzsRUMB6GzKuCnUN8V+wutnGyd3
	 qgVllw8rmVK3Q==
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC V3 0/8] mm: Drop pxd_ERROR()
From: Mike Rapoport <rppt@kernel.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260818040041.1891769-1-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
Date: Mon, 24 Aug 2026 10:27:34 +0300
Message-Id: <178755645423.3606540.14531883744138096395.b4-review@b4>
X-Mailer: b4 0.17-dev

On Tue, 18 Aug 2026 09:30:33 +0530, Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> mm: Drop pxd_ERROR()
> 
> pxd_ERROR() macros have been provided by all platforms, which are very much
> identical and can be dropped off completely if these pgtable printing could
> be moved to callers in generic MM aka all pxd_clear_bad().
> 
> But first cleanups and re-organizations are required in some platforms that
> are using these macros internally. Afterwards [pte|pmd|pud|p4d|pgd]_ERROR()
> macros have been completely dropped from the entire tree.
> 
> [...]

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

