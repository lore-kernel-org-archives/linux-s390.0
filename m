Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C102721ADD7
	for <linux-s390@vger.kernel.org>; Mon, 13 Jan 2025 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763446; cv=none; b=QQoUqHM8/tOpX87n4Qc+3TMmc7R4o8TCPVU2/1YHrdtYqqmqqMKh95pk4vicIvmJEWL5PU4kjuC4E5g5PBmfoE1r0Hjh5H2QAvx5bXoGvrPZXLkzUAT1Q5ZwwaXPRsI86UgDzo8NLQ+O9JPjLVhe08zDIt05BDyai9HrlVBEHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763446; c=relaxed/simple;
	bh=515zETJoHIbSRyv7lF/l85HLG1TVpBQuDX1nN1fObTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bV/22DmKrrWFGvLOg9/pb0/hd28qa/RWbLQpHHQzoqgsiRIWndEvk/DcPJX9Apd8lP8+5IIiaN2AxDCaZkL2O6wnPFY/jIjY9wK/HzacUv1Hs9JYV/N3VjrgGMnUdxJOShDzt/6C9wka5WxMN6h6c7tfpwGT+CG9qFQEQq5uqgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D9A51424;
	Mon, 13 Jan 2025 02:17:52 -0800 (PST)
Received: from [10.1.28.144] (e121487-lin.cambridge.arm.com [10.1.28.144])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23D0E3F66E;
	Mon, 13 Jan 2025 02:17:20 -0800 (PST)
Message-ID: <44d60dff-ab73-4d10-9110-c5c2ddebadf6@arm.com>
Date: Mon, 13 Jan 2025 10:17:18 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [kvm-unit-tests PATCH v1 0/5] arm64: Change the default
 --processor to max
To: Alexandru Elisei <alexandru.elisei@arm.com>, andrew.jones@linux.dev,
 eric.auger@redhat.com, lvivier@redhat.com, thuth@redhat.com,
 frankja@linux.ibm.com, imbrenda@linux.ibm.com, nrb@linux.ibm.com,
 david@redhat.com, pbonzini@redhat.com
Cc: kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
 kvm-riscv@lists.infradead.org, linux-s390@vger.kernel.org
References: <20250110135848.35465-1-alexandru.elisei@arm.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <20250110135848.35465-1-alexandru.elisei@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/25 13:58, Alexandru Elisei wrote:
> (CC'ing everyone from MAINTAINERS because I'm touching configure)
> 
> Vladimir sent a test for MTE [1], which didn't work on the default -cpu
> model, cortex-a57, because that CPU didn't implement MTE. There were two
> options to get it working:
> 
> 1. Add -cpu max to the extra_params unittest parameter.
> 2. Make the default value for the configure --processor option 'max'.
> 
> We decided that the second option was preferable, so here it is.
> 
> The first patch might look unrelated, but when I was writing the function
> to select the default processor based on the architecture I noticed that
> for arm64, $arch is first equal to aarch64, then it gets changed to arm64.
> My first instinct was to have it be arm64 from the start, but then I
> realized that, despite the help text, --arch=aarch64 has been supported
> ever since arm64 was added to kvm-unit-tests. So I decided that it might
> more prudent to go with it and document it.
> 
> [1] https://lore.kernel.org/all/20241212103447.34593-1-vladimir.murzin@arm.com/
> 

Thanks Alex! That removes extra hassle of setting up -cpu to match required
feature. My MTE test continue working fine and require one less configuration
option - undeniable improvement in user experience!

FWIW:
Tested-by: Vladimir Murzin <vladimir.murzin@arm.com> # arm64

Vladimir

> Alexandru Elisei (5):
>   configure: Document that the architecture name 'aarch64' is also
>     supported
>   configure: Display the default processor for arm and arm64
>   arm64: Implement the ./configure --processor option
>   arm/arm64: Add support for --processor=max
>   configure: arm64: Make 'max' the default for --processor
> 
>  arm/Makefile.arm    |  1 -
>  arm/Makefile.common |  3 +++
>  configure           | 35 ++++++++++++++++++++++++++---------
>  3 files changed, 29 insertions(+), 10 deletions(-)
> 
> 
> base-commit: 0ed2cdf3c80ee803b9150898e687e77e4d6f5db2
> -- 2.47.1
> 

