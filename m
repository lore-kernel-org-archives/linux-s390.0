Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596410;
	b=wVlJceT6h7XODGikSSSOmZ3k5ycd1U8p+PTXE5+X+ys1opOlkIoHSnAYM6+1+aCU67VD
	 c+A20tO80zdWwgJME+G94NaDSMC/xG3KJiMBfKO/m/hc05eWWXGQk04IfpTqHulRsQfSJ
	 s354FLbyeQmi11tRblVeCJwWVlzb397alJbD+mJVoe4RglUvQRaKGYJhmjOnqTsFyC5B0
	 zAb9iZa1fsdhDavIv+sTV9kHJRIKte2l14DA3Lm5GCQLuBvTuxIhpSLqIc64yg67eE1Sq
	 tHuAkfIIEVHz6XeRW28LjtrgxFNPTqRel6BqYC7AHT1Xb/bWNpIS/to6ET8JPN8ZLqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596410;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=+2lqXoxbcTGbpqi5YkiRhwq1uO/E+YCynWayZ3OE3fk=;
	b=DLsKr9TIxyXnXas1yRRrydbWgU7ICdHzYq0KYyQhgA3pn46txekfi7Thqjhx7eBCXOQc
	 vo5d0MnkVaOY+Ii4oSoBQLOF7EFGVBErHX5v1MbPvi5ISo57Jd53sJMTNJ8RALchIQVAl
	 0G7TsL+q4xStndFryrM1DJowlhEWswoZmhAQm3IbLCdh7giVwcarM+2Ncm2n5ZrK0FmMU
	 LPPbXbSidDy/gZLIAIeUt2iIOpnnaPpcMsC8Lqni+si2yD/jl0WulloqmBhKBdtUN/16v
	 L/wC8/Jc+UlJJKacT6xYZ+LoCeEAtFPVfnHoW4u6daAtlFDgYZ22YaXWrOLQrJr6mJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcZYmCrb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66299606A337;
	Fri, 13 Nov 2026 19:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gcZYmCrb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB51F1F000C4;
	Fri, 13 Nov 2026 19:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794596410;
	bh=+2lqXoxbcTGbpqi5YkiRhwq1uO/E+YCynWayZ3OE3fk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=gcZYmCrb/XakcrNd58e3ddXkD36SjuOB0rbEEBXmvH785qkb9J2/KK9BHMjqhPOdD
	 7sQkDObyATbGUuhcqKqGrEXCUiXVpdyfzVyO9YQLKKG/6aTVob2pgTNO1IuNaj6/dG
	 APTwnMbRMSLtHHT7Y4dXM8O0DsNemxBY2KlH3MRjlmE8oQzAEkzRLGJMWHIIkVtuWZ
	 uYUZPIsbhVuPx6iD5A4ScPvtRe3uQlffpuhazLJ3BF7hTUDanfv7K1hsChy+q6Vdo7
	 dSv4aGisHzzgaPOOwGrgGIt7wf0it+6ZKnZlcXBv5vbzxzUPz4LxcfeF9nN+6E4uS/
	 6x5mu1VMCiK/Q==
Message-ID: <2ff19317-8da9-4014-be04-27fc218b8eea@kernel.org>
Date: Fri, 13 Nov 2026 20:00:02 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] KVM: don't zap secondary MMU on permission upgrade
To: =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>, kvm@vger.kernel.org,
 linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-riscv@lists.infradead.org, seanjc@google.com, pbonzini@redhat.com,
 akpm@linux-foundation.org, peterx@redhat.com, ljs@kernel.org,
 imbrenda@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
References: <20261112142039.907090-2-clopez@suse.de>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261112142039.907090-2-clopez@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/12/26 15:20, Carlos López wrote:
> Stop KVM from zapping its mappings on permission upgrades on x86 and
> s390, as these keep the PFNs unchanged and revoke no access. KVM faults
> in the new permissions on demand, so dropping mappings early gains
> nothing.
> 
> To do so, add an MMU notifier flag that marks an
> MMU_NOTIFY_PROTECTION_VMA invalidation as a strict permission upgrade.
> For the flag to be accurate, change_protection() keeps writable entries
> writable on such changes. A few cases where it needlessly makes or
> leaves entries read-only are fixed along the way.
> 
> Background
> ==========
> 
> change_protection() pairs every protection change with an
> MMU_NOTIFY_PROTECTION_VMA invalidation, and KVM zaps its SPTEs in
> response, as it cannot tell whether permissions widened or narrowed.
> This is costly, e.g. during a QEMU background snapshot, which uses
> uffd-wp to write-protect guest RAM and unprotects each page once it is
> saved. Every unprotect then makes the guest refault memory it could
> already access.
> 
> Secondary MMUs that share the CPU page tables (e.g. ARM SMMU,
> IOMMU/ATS) can keep read-only entries in their TLBs that a fault does
> not flush, so they are already notified of permission upgrades on the
> CPU TLB flush path [1]. KVM keeps its own page tables and faults in
> permissions on demand, so it needs no notification, as Sean noted when
> that signalling was first proposed [2].
> 
> Series overview
> ===============
> 
> Patches 1-4 fix cases where change_protection() needlessly makes or
> leaves entries read-only, so that the next write to them faults. They
> only affect performance and can be picked up independently.

We generally don't add performance improvements without clear motivation and
data to back it up.

MM is currently busy with more important stuff, so best to keep your changes to
a bare minimum.

-- 
Cheers,

David
