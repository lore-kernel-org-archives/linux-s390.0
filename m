Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601973;
	b=w6iMaZeFYwlRcQM9WZLNTb1u6a1p4VRn4kE6321jWizwsf78AgZ/ZUFAqNOGKQStCCek
	 BBB4sLOxT1NynZpwvlA1XzZaaM1a0LcBkPCFeYUXkH4gLr43PEUcISR5iEaxRJ5NcoPuv
	 bdI/yucr60lKx43D5SMIfwVUYuyr1SRnW7Wx8WLoG8F+E9v0jw0tBJB00AzzwFnQ0x3vW
	 jQVvCOsBDHgARTiVONZlxPOVmV0O7IYudxxM9IR0Lo+UI0281WvpkoL84vAzaRHsYIw6a
	 CRoxgv+RbVpKeE2GBIGGRDV5LsaGmClNf3iXGX06W/D1hPHHTssFWW+WLGlXRqPAIXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601973;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=7kGyvkK08X7x1lT2uCcH0FMHoas2jrbCjIylRbFLUhU=;
	b=sNquF25DMR342eB7ZnIpadPz5V3n4xzSr4zOPbHsp3d2KzsWje9Xp0aQmXAA5f7OZmec
	 k7bsXRNlmx/2/8g0LamaKfJH4hZsEi8+5CUJdCnag1xibFfHO/lHzjfrkL1ChWbQK4QlX
	 pnrjaCSFkJ/HMBEtLpJ/xCbh4B+wFx0ocNENKMK6+PZ9HGVWFVw49jH9wPnKyApymBGO5
	 ItDidPpJX3lFXezxHruOVjZoTvjZrOXgvGD3BIrxupy9cnZSzjx8Hvd1pOFxogVF2jMqM
	 T+9gfOcts9MOXCqnhq6ls5J/ybaN7BkL/pLf0IwQAkPL1mLNnbvvgs/bHls3dbjCjzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2pk+jG4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFE8606A331;
	Fri, 13 Nov 2026 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2pk+jG4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6156C1F000C4;
	Fri, 13 Nov 2026 20:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794601973;
	bh=7kGyvkK08X7x1lT2uCcH0FMHoas2jrbCjIylRbFLUhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F2pk+jG4qUvodejQG38Pf9aLunFm0mGPRbuZwJxDgkyHq7jOf+NJX1i/vtDIatCPf
	 Cw2NBFZtuONe4xwLRjLZQQviA5lPwdhtGZgKNvrguufJykmq95BoxszydeILAPgPWB
	 vNYGqGq/D5E7LWSO7AagLb34uHE8769m3fs97xzHZdS4tb5IGuw3M1rwA86XR+4fYP
	 NwnwwvzQ8Je8HFhReph9Hnq5uE+AvFEGZUEhJZEdJyfr8Qsjv9d1/ZC0SGtQqk5A2f
	 p5qcpnnvksMjDPjc48+mt9oxd18LnMfhIY366tkaJk/nfQW8WEw1Ut6/id++D3wz6D
	 fQqI4bWU6FDPA==
Date: Fri, 13 Nov 2026 20:32:46 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Carlos =?utf-8?B?TMOzcGV6?= <clopez@suse.de>, kvm@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-riscv@lists.infradead.org, seanjc@google.com, pbonzini@redhat.com, 
	akpm@linux-foundation.org, peterx@redhat.com, imbrenda@linux.ibm.com, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v3 0/9] KVM: don't zap secondary MMU on permission upgrade
Message-ID: <avdzWA5nrPLoIztq@gremlin>
References: <20261112142039.907090-2-clopez@suse.de>
 <2ff19317-8da9-4014-be04-27fc218b8eea@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ff19317-8da9-4014-be04-27fc218b8eea@kernel.org>

On Fri, Nov 13, 2026 at 08:00:02PM +0100, David Hildenbrand (Arm) wrote:
> On 11/12/26 15:20, Carlos López wrote:
> We generally don't add performance improvements without clear motivation and
> data to back it up.
>
> MM is currently busy with more important stuff, so best to keep your changes to
> a bare minimum.

I'm sorry after what I've seen from this series I'm pretty convinced it'd need a
whole bunch of revisions, and we just don't have time for this kind of thing
this cycle.

This is v3 and I already want to NAK it...

--
Cheers, Lorenzo
