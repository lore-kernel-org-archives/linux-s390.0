Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05B439B4A3;
	Tue,  1 Sep 2026 02:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788230927; cv=none; b=gBCboPMdcluAlMLwQJKnjuZVVtJe+WGY+TK5GsfiYifYDLlTddYc24q+4Eujx4Iqr3QONN3iJG/umPshdzrb+bHQ02SYpsWRF/VtTYcoxVcoalghQOWuwntjd2XXzfu7vggd81BiKJWoZFuL1tUvXb7X7BMrF/gXsnczg8MUB+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788230927; c=relaxed/simple;
	bh=it2TzzIDYTIEJor+n+hAx7Y9VTg7srHvqDHPINLC58w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDkRlmWBpS5U5jKg4zrJWBeDuEkeqH9qxWqI9sds8MG3FF3P0CuWeSlIv+8t9M/Jvf5v1BUZngswWb4SC4zmGUSvhgO0OsgMWYQLeEYiISaV7mZ9FYj/4GBcOLcR/dP2CmiimtLIDFm7wIuookHFqGPqmDnsqRAdbExty1Iy4qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=usDt8rhj; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="usDt8rhj"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4CD931692;
	Mon, 31 Aug 2026 19:48:28 -0700 (PDT)
Received: from localhost (a085714.arm.com [10.164.19.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5150C3F882;
	Mon, 31 Aug 2026 19:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1788230912; bh=it2TzzIDYTIEJor+n+hAx7Y9VTg7srHvqDHPINLC58w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=usDt8rhjPTPyhurOvXc8PdfuSoWH0nYsX72TOilRCeK51T4CARGkosyhwrLBvxyhc
	 l9WrmE/Q4V575jMJywI4lXro08Z3FihKyE+sAH5OZKnsGdk8N6U5ibobJVe6+qJK5R
	 M+KgzpkQ/xqu4+mMb5mvQGSArMljTWloMojjfQx4=
Date: Tue, 1 Sep 2026 08:18:28 +0530
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, samuel.holland@sifive.com, 
	David Hildenbrand <david@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] mm: Drop pxd_ERROR()
Message-ID: <44crgg3r7p2d26blmgq2ewqan3anfhdo73zxe52rvpcjsdhdvd@xztk7osntzhf>
References: <20260831054331.625505-1-anshuman.khandual@arm.com>
 <20260831185519.66c6e6e83ce62d0fd9aee945@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831185519.66c6e6e83ce62d0fd9aee945@linux-foundation.org>

On Mon, Aug 31, 2026 at 06:55:19PM -0700, Andrew Morton wrote:
> On Mon, 31 Aug 2026 11:13:22 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
> > pxd_ERROR() macros have been provided by all platforms, which are very much
> > identical and can be dropped off completely if these pgtable printing could
> > be moved to callers in generic MM aka all pxd_clear_bad().
> > 
> > But first cleanups and re-organizations are required in some platforms that
> > are using these macros internally. Afterwards [pte|pmd|pud|p4d|pgd]_ERROR()
> > macros have been completely dropped from the entire tree.
> 
> All was going nicely until...
> 
> > This series is based on v7.3-rc1 after the following patch and has also been
> > built tested on multiple platforms.
> 
> *what* following patch???

The dependency patch has already been merged upstream.

092836fedd82 (mm: standardize printing for pgtable entries)

Please ignore this.

> 
> Oh well, I'll queue it all up and shall hope for the arch maintainer
> acks to roll in.  Please.

Thanks !
