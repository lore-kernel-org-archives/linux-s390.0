Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5324F3B8D78;
	Sat, 10 Oct 2026 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791626853; cv=none; b=WtYSu+DJVz9dgcloEJPRe2An8pXysUdjp3pd2z1hjVDYpn7XCfF2FFcgNMTj8AM8jKVtczV1l2Bk93xbiuprQf8MElvxSttxClaEEoZNK/CzyZpseOeK2rbMGFtBNdeUAOnVvevT4w60mXlHFqYRD81avDgbM37XF1t3WDykM/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791626853; c=relaxed/simple;
	bh=D7S2L30ialSsc3ylDJSIHW6xjUCGuwq2Qlozmd+ubSc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LNBcM6mnwnx5hFHH8Q5OOEAVIUsK0Q4x1ChSxluMVx1ZKFjlmVUK2S/KlKzMhehN7ZJ7U2KqzaKaRPyZoebUrDBrmIObOreDFB+Hb78ug5PWVwRcompLAanda/3BnDgQWlPVqxGR0ENcOVGwTHmRT7Td/aUPCdEgVXfNLWT48gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=d48qZgmD; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="d48qZgmD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:From:Subject:To:
	Content-Type; bh=A4y04JzxldO260/+1JjQhaM7OPWp1qTRLmXAqMl3EHU=;
	b=d48qZgmD7kERcBnmME6e5d/+8X02i3aRnMPZ51by6aY+s0Mvxn6UmORGNrc14P
	GAs5qG3Cxdpp6rmfM/ardD0xQCs5jKmZ0tHvp4pcDtdiSY6HGwsdQxO5Q6OoPBVc
	qqu8kyMskMLqVaioNR3Z/WkUbk96NKBcA0a25t7oXN4SY=
Message-ID: <e550befe-8399-4349-8b67-6a01367db165@126.com>
Date: Sat, 10 Oct 2026 18:04:47 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Song Chen <chensong_2000@126.com>
Subject: Re: [RFC PATCH v2 0/3] btrfs: add error injection support for
 checksum verification
To: dsterba@suse.cz
Cc: arnd@arndb.de, kees@kernel.org, clm@fb.com, dsterba@suse.com,
 linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
 guoren@kernel.org, kernel@xen0n.name, maddy@linux.ibm.com,
 mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, gor@linux.ibm.com,
 borntraeger@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 jpoimboe@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260724021229.47302-1-chensong_2000@126.com>
 <20260907161330.GX9053@suse.cz>
Content-Language: en-US
In-Reply-To: <20260907161330.GX9053@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PikvCgDnz_jADcpqUfIkBQ--.28557S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zw47Cw4xCFWkWw15Kr1kAFb_yoW8trW5pr
	W8C3s3WrWrJrWxArsaya4Fv34Fkrs5W34UJFnrG34Ik3s3Za4kta1kK348u3W7ur48Gw17
	Z3WDKr4kWr1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDvtAUUUUU=
X-CM-SenderInfo: xfkh02prqjsjqqqqqiyswou0bp/xtbBsgLAQGrKDcJ3nQAA31

Hi David,

If no maintainer else sees it and comments, i'm going to send a new 
patch, only keep btrfs part and withdraw rest, and take care of sashiko 
comments as well.

Please still find it, many thanks.

Best regards,

Song



在 2026/9/8 00:13, David Sterba 写道:
> On Fri, Jul 24, 2026 at 10:12:26AM +0800, Song Chen wrote:
>> This patchset adds fault injection support for btrfs_data_csum_ok,
>> enabling controlled simulation of checksum mismatches to test btrfs
>> silent data corruption detection and reporting paths.
>>
>> The first patch extends the error injection framework with a new type,
>> EI_ETYPE_FALSE, which allows bool-returning functions to be overridden
>> with a false return value directly.
>>
>> The second patch marks btrfs_data_csum_ok with ALLOW_ERROR_INJECTION
>> using this new type.
>>
>> The third patch adds a parent field to fei_attr to allow fault injection
>> on a function only when called from a specific parent function.
>>
>> Song Chen (3):
>>    error-injection: Introduce EI_ETYPE_FALSE for fail_function
>>    btrfs: Allow error injection on btrfs_data_csum_ok
>>    error-injection: Introduce parent in fei_attr
> 
> I'm going through my mailbox and found this. No objections to add the
> injection point to btrfs, but the rest is generic fault injection code
> so I can't take it via btrfs tree without acks.
> 
> There are some sashiko comments (as replies in the thread [1]) and there
> have been some changes to btrfs code too so the patchset needs a
> refresh.
> 
> I see maintainers in CC, if somebody could please let us know how to
> proceed.
> 
> [1] https://lore.kernel.org/all/20260724021229.47302-1-chensong_2000@126.com/
> 
>>   arch/arm/lib/error-inject.c           |  6 ++
>>   arch/arm64/lib/error-inject.c         |  6 ++
>>   arch/csky/lib/error-inject.c          |  6 ++
>>   arch/loongarch/lib/error-inject.c     |  6 ++
>>   arch/powerpc/lib/error-inject.c       |  6 ++
>>   arch/riscv/lib/error-inject.c         |  6 ++
>>   arch/s390/lib/error-inject.c          |  6 ++
>>   arch/x86/lib/error-inject.c           |  6 ++
>>   fs/btrfs/inode.c                      |  1 +
>>   include/asm-generic/error-injection.h |  6 ++
>>   kernel/fail_function.c                | 98 ++++++++++++++++++++++++++-
>>   11 files changed, 152 insertions(+), 1 deletion(-)
> 


