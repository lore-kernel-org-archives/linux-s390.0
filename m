Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758342EEE84;
	Tue, 14 Jul 2026 09:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022775; cv=none; b=QspkuFtDsjtdHV8KGrvZoTXQBh/NOYHTlA7Y2PMehQ/tKTQlL2+4iqIwDVaNtCHwpeMfhifjnY5INQqAcNGHbIRObrhb9xqOmkKPTyLJKqfG9LhSkqAWAEkXhj2qHn5b0pmwYOuktKFS6sSwo8W+hzXbt6ePmWU95pjqgkpwqFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022775; c=relaxed/simple;
	bh=+C5nG+xtG3hyYyQwRUQFGYH75JNuc0Lk0Ty5BqRmWNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AymuyDWOXrviGZYGVVxKgscTERLocRmlcAkOir5atcyDxHPnqybNa6MpqrZkyhFMlmbK6X8rWbntL+TetTXqu3WWNaLX2qOWo3+y9FVWBoPTRQEJoc0ounLNnKRg2PbB7Y4MPQJwkh/jUmeG+Ao1bHv6AmnHjsxjM0EUdf8tBKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgSMxxsh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgSMxxsh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232391F00A3A;
	Tue, 14 Jul 2026 09:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784022760;
	bh=+C5nG+xtG3hyYyQwRUQFGYH75JNuc0Lk0Ty5BqRmWNU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZgSMxxsh1Lu8MR5Z6WZ7OI+nq6F3YqTn9IBm2AINDs8o2Z/nh/SpZWcv4glu+VhPe
	 cXy87Qxg3XbvgFKPnL50ydX2ZmeXZ+Y2m0e04PAZRMRDiI7yd819Ia6OkzoYI4l8hi
	 bQ5nmUAEKOPB1JNlOSIgfbjVYFEy/Nt7TJrcZZrSwXI52rztJjb2qGdZlVK+Mik1C2
	 MqZlsgx86ioBdN1tVdskpyUDQ5X3kf6HF+H7N5Qp+yw+MWEZGk2dutdazlT0Q42W8G
	 2WBALzw60ZoYjzJMEjfOp8k80iBpzrMV5Er054iRnji2EAX6IYZOtyYaIq4WMAy0e3
	 LsRNlLUiQVPTA==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v7 00/22] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
In-Reply-To: <cd5d0504-1592-4b48-89ea-1efe8aa57968@samsung.com>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <CGME20260707080628eucas1p13fa8a57e60ef5dd3ec651e19e42af0a1@eucas1p1.samsung.com>
 <yq5av7argr65.fsf@kernel.org>
 <fc804746-4fb8-4ea9-997f-a4cae9ba8c14@samsung.com>
 <20260713194323.GC3133966@ziepe.ca>
 <cd5d0504-1592-4b48-89ea-1efe8aa57968@samsung.com>
Date: Tue, 14 Jul 2026 15:22:27 +0530
Message-ID: <yq5aldbdnbj8.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marek Szyprowski <m.szyprowski@samsung.com> writes:

> On 13.07.2026 21:43, Jason Gunthorpe wrote:
>> On Tue, Jul 07, 2026 at 03:03:48PM +0200, Marek Szyprowski wrote:
>>> I'm fine with merging on top of=C2=A0the topic branch and I assume that=
 this
>>> patchset is mature enough to give it a try in linux-next, but first I
>>> would like to get a review or at least acks from others with good CC
>>> knowledge or experience.
>> I think it is good to go from a CC perspective, there are still some
>> more items to fix up (like the MMIO) but I'd rather they be followups
>> at this point.
>
> Great. Aneesh, any chance You could send v8 with the remaining items
> fixed till end of this week? I will be happy to push it to
> dma-mapping-for-next for testing in linux-next asap.
>

Sure. You need this rebased on top of the pKVM changes, right?
Otherwise, we'll end up with conflicts when you do the final pull
request.

-aneesh
