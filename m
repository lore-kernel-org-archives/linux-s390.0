Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7B52D781B;
	Mon, 31 Aug 2026 06:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788156555; cv=none; b=ZONrQkNYfBEHY3Q3nLGREMRL/UjBmQb1ykTd4YI1JWproJQXSutBdSHTSeAvjaflTSlH8ZfUp05KNG7bRjknR6SLyWoUfv9AH2IJrz8TvgM/ViRfIiMB7anMmO9cwoy8jbj9YMFcOv3MN1XWh5fHdB6Fv+laf+2sZXcJnVOY+gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788156555; c=relaxed/simple;
	bh=x0Wve0tk7PI7yTgtxuBro5h3JiXEez30Kv8RdIABwZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NZhzbcdLqXfnBAzyAN8ROHx7RFuMq2lB6myIb3a9ERZIW8X/GbnGqMNT3L0K8H76Bbp1b41VlLuSqtkcvGrBvVWfSXHr3xWt2ejUGo4QtD4PB/mWl+g9/N1Iq/BFQwpl9yuqRSHvsYf+gOjgPKeeV4BMVWHGPwaWlgO2EqnNTzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=hP9dSvh5; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="hP9dSvh5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=qoFo7+PxqjttbtK92O/ZZGktuuQcYVg2E/w5Dp6VQ88=; t=1788156551;
	x=1788761351; b=hP9dSvh5ptm6qi0+j1zFSypij5B5mGPtarMp/2ywPkHbKiVB38NAiQ/g27/g1
	CJoUL8PPCdkO89VW++aTIUiz3Q8dIeo1K3JS1QfOKiAAsfpBcOnu1We+ywC7wuk81gJFaKRhlT0Cw
	6sIMqhH/65sFDk+BGupeWkJYK6sp4KvDkzQyteaYv9nnzHo+RPdA8G3Ll3fV+ObVCGr4w3HAUBrSJ
	bLaaARHVq9GweBHz2MxpRngAjBe9dCjH6vmDX/+aZkwzMFs3wTzeWTYPe5PCZ59NoXfBNM7ZmD0LY
	Z1Bf2NQVpmXV1dqpWgz0PslmfUWSZqU/CuU5iJl7laV6SYjz1A==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.99)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1x0vCP-00000003S29-3Hzv; Mon, 31 Aug 2026 08:08:53 +0200
Received: from dynamic-002-242-195-014.2.242.pool.telefonica.de ([2.242.195.14] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.99)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1x0vCP-00000000yAZ-2A6t; Mon, 31 Aug 2026 08:08:53 +0200
Message-ID: <d766413f91cd778912f6af372d3d5429bac7765f.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/8] mm: Drop pxd_ERROR()
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: samuel.holland@sifive.com, David Hildenbrand <david@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes	 <ljs@kernel.org>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, Rich Felker	 <dalias@libc.org>, "James E.J.
 Bottomley"	 <James.Bottomley@HansenPartnership.com>, Helge Deller
 <deller@gmx.de>,  Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui
 <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 31 Aug 2026 08:08:52 +0200
In-Reply-To: <20260831054331.625505-1-anshuman.khandual@arm.com>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Anshuman,

On Mon, 2026-08-31 at 11:13 +0530, Anshuman Khandual wrote:
> pxd_ERROR() macros have been provided by all platforms, which are very mu=
ch
> identical and can be dropped off completely if these pgtable printing cou=
ld
> be moved to callers in generic MM aka all pxd_clear_bad().

If pxd_ERROR() macros are really all identical, why not provide a common de=
finiton
of that macro? I'm always a bit concerned about such changes as there is al=
ways
a risk to oversee arch-specific peculiarities.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
