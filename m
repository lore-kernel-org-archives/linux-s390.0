Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF7B387378;
	Mon, 24 Aug 2026 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787556473; cv=none; b=dwAl40H5B2/ejpltOqQJBNbvAh8hB5catfRFV82cOrMoP5biT9Hwm48FkFfU3MreX7QDCXlWnNNwMq4D2FpHtIopeEf6Pt0wQ+04ZznXW0RFRk6mkXqVRa0wnaq45kTbC6XdjNopE6NrPNTRfujBqAkMJ0i6dnS0dt4ZvKt3cds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787556473; c=relaxed/simple;
	bh=vyhOknni/uREA5s020eIPcwYgvoPFbIV6bT5YWB1Ot0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=XcKCRuiKmG7x1JdZp/yaVnTJ4i+YjMO9qbMgBtw11MmXjMNYg9d8GMJl+8HDye7ytbHijGNokmVzP8UiD/AVU2bzXoLpcsQb1a72AhJ+Q09hm7ZE0V8xvHbyy1emtxT/egaIuZhqwre60V4SudRFCDFtrDntJ7s6nqAkCoVNqzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LisqMsMw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LisqMsMw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62AFC1F00A3A;
	Mon, 24 Aug 2026 07:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787556471;
	bh=TDmng5bNiE+YiLBp1dwqj9DRhmUVXQIS/lif+VRO/fE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=LisqMsMwto/kBuZ7gdbcgEJrUKMCvB31iYajSaP8VSdLEt16BVkX4Oh7MmltHH6/x
	 lgJMQ/bHIDKxJx2zSKHsCi53faclUGyXrEjtwgO9HglPDbBjmzSGM601uHETfiupKK
	 k9L2jhdovk2XzuRexJe8lI2Ja3+L6F1zhgtZeR57y04iBM9ZTxAg8R4/0hzvBRU/1n
	 j/yQ64IOrcqDTuW2xREKaopx2MCLiJJbnIajCPVW+gYaQ/oYq0qHnMHsDEPBeQlGIk
	 UAUiHCdZACNNtFoUCqb60H6mqsfCFPiGb92umTHv0AOcuZ/mH0PdZQm1D5ksQY3O+D
	 A0IEUUHfnBZfg==
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC V3 1/8] mm: Make ptrval_to_str() generally available
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
 linux-kernel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>
In-Reply-To: <20260818040041.1891769-2-anshuman.khandual@arm.com>
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-2-anshuman.khandual@arm.com>
Date: Mon, 24 Aug 2026 10:27:34 +0300
Message-Id: <178755645423.3606540.12945780031100652573.b4-review@b4>
X-Mailer: b4 0.17-dev

> Move ptrval_to_str() inside a header thus making the helper more generally
> available for new users which are being added later. While here, also move
> another related string size macro PTVAL_STR_MAX inside the header as well.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

I agree with David, include/linux/pgtable.h is better.

Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

-- 
Sincerely yours,
Mike.

