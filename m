Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E6320CBE;
	Thu, 13 Aug 2026 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612448; cv=none; b=KHV6ku4XVIxI3szqXhhC2wqhuVm15as/byMSRgGjH3Cv91EbvpiPMlsFNWvQmfcgWJDeqr/VLOsngxjhwoUvRKuJeKzQrY5xWNtKmfrYrc9I52k1BtAGyEtVJ25RTOfwJURBNEPJ7RzfRwSLPX6yuOcwcf2lNc8lamzneUdlz/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612448; c=relaxed/simple;
	bh=h7qtTXObv9L5vYCuuZsxrO7Xm5oJlsWetDdqMc2HouM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YhpJGUIwmj7PhG3fCbVJhstd8RZFozVq0kwXtHUJMnsw9WmssODyjlfGxKkHD5lg+wetCbEu3IcVasys4JvFOWmAgiTOL9NNOnJQkL3osDf6Db98ZLX9z2Igzm+qC+tGaDqpD1M8d21LaOZtnNg2FKYUB8thjlWJOsRfsUOaKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jb9o2WF4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jb9o2WF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673031F00A3A;
	Thu, 13 Aug 2026 09:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786612447;
	bh=zhJmZaJPWu2tGQu9cD5mC0NR8f5AZSYCs6/SZ99TC3M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Jb9o2WF4mJul7AfKWjZXxrn422eNlwV0OpD+YUFGaeWd6bV48nwOVrU7hqdRUi+C+
	 MMx4opwElstv+v12Jm6nH90+reZr0lst/MhRIUedGK2xlbjCtlG9nXCuqjcbRYusO8
	 X1lS+eSvLFUyqG9RQZpJPU1Dn9c9K3lMzwNnYQ/HvtF3Gfeh48zxH+XBa6Fb5Yyvvh
	 hFmFH9g0W6IrqIJjg8vT3CnEkPq+B4NO/K7RPYK//Xj76c4UIu2t6NY3pE/WZCVSVx
	 oHcTVrUCMzfVvoO0ByHsO9gTDpn6yo+uhhMAdcX6QxDcfH1IvdyynOvdpX89zJO1SY
	 LEmdUB6XPzQKw==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [RFC PATCH] dma: swiotlb: Size shared default pools for memory
 encryption
In-Reply-To: <an2EoONjyp570tvB@arm.com>
References: <20260811134056.756015-1-aneesh.kumar@kernel.org>
 <anxEc8EHmJQywVI5@arm.com> <yq5ajypvioks.fsf@kernel.org>
 <anysnQFVTO_RAYxp@arm.com> <yq5aecg2io0u.fsf@kernel.org>
 <an2EoONjyp570tvB@arm.com>
Date: Thu, 13 Aug 2026 14:43:53 +0530
Message-ID: <yq5abjb6idri.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Catalin Marinas <catalin.marinas@arm.com> writes:

>> >> > BTW, why does arm64 report CC_ATTR_MEM_ENCRYPT instead of the GUEST
>> >> > option in realms?
>> 
>> This is getting fixed in  
>> https://lore.kernel.org/all/20260701054926.825925-9-aneesh.kumar@kernel.org/
>
> You might want to bring this early together with the swiotlb adjustment
> here.
>

That is already part of dma -next tree.

-aneesh
