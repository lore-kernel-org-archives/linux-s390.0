Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9354D7D2B;
	Mon, 28 Sep 2026 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604129; cv=none; b=NxEMDR0AZmI3OLonxHhW+B8CPpQwzt5fLMfjy4wsK00kSUGrx5rDsC6JW4DN3D1kDlEo/Yq4TcXvJHROvsM2C/LZolATqkyugHJVhkCzfoRy31aqmtfmfVIj0DdrzZ16LocjlAHSXaLfwAhjEZyjrgqsd4qww6FYO5NETRitCdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604129; c=relaxed/simple;
	bh=dwo/7H/kyhi0uqLDFZ+V6WuX3qFrA95uTlT7TB0bQAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3MtkKrhLyIWOI03Zmaj7lyZNhL+J4nsejPJhURNQEGBt9OcY7hV2r2xwROdLQxCFuVFu3G9596aeS0gVRViy5uVMMeI5GOYprV47NJSOP1gtJ8Www+ifUMwKPHI/PlfvWED81oe7ghKR7FVF72JVSwf0AkbjyqLWjpXeebcQJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=esd5N1Bf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="esd5N1Bf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE0191A00;
	Mon, 28 Sep 2026 07:02:02 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D07553F763;
	Mon, 28 Sep 2026 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790604126; bh=dwo/7H/kyhi0uqLDFZ+V6WuX3qFrA95uTlT7TB0bQAw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=esd5N1BfIIQNpSfmKiQ8/X/si2jjCe9j7kFqvk5pDRCJbYqVAaa/BzG+il33yoQiu
	 gD3wfFgldRJdnX9IZCA7ERxg2luZhTD7fV2h0NxReAHYEJJgkU76N3RyhoRebVuFF6
	 PghZ4XYDlQcRIPX0I6Uwa4hEcTspI4Ja0zUedWF0=
Date: Mon, 28 Sep 2026 15:01:59 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Grapentin <gra@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Friedrich Welter <fritz@linux.ibm.com>,
	Fuad Tabba <tabba@google.com>, Gautam Gala <ggala@linux.ibm.com>,
	Hariharan Mari <hari55@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Joey Gouly <joey.gouly@arm.com>, Marc Zyngier <maz@kernel.org>,
	Nico Boehr <nrb@linux.ibm.com>,
	Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
	Oliver Upton <oupton@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v8 11/29] arm64: ptrace: Use constants for compat
 register numbers
Message-ID: <arpzV-ylRwdqdNSE@arm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-12-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918133107.1042730-12-seiden@linux.ibm.com>

On Fri, Sep 18, 2026 at 03:30:48PM +0200, Steffen Eiden wrote:
> Define an enum to determine the register number for the mapping from
> AArch32 and AArch64 registers. This allows for a more flexible use of
> the register mappings.
> 
> Reviewed-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
