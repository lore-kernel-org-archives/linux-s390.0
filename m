Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70754BD79E;
	Mon, 28 Sep 2026 14:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790604103; cv=none; b=qnmOlBd/LPZKXDuml+zFb8gdN1PurCecrbZOShO0UYlwrx7KPCAIPQFgO44S8GVh6g1AmFjGugMsZgo+srw31oz4mdMEI+N97P4uqvE3tukRFypby6W377Yx1n3UMwLP29ZPHIiWnc0NgT+/q49OMwmkM9ZrGXP/OAqNmFI4c8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790604103; c=relaxed/simple;
	bh=fBXa/ueasdImeVBDgfgjheoJKCMPY8NCaFV/SF8dFPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od5f716yias9uqULVJe2yWHEouJUySsbBcfn6LCvzAdwGT2cmA5pah9a+fbGV67TEZlqI9m1pJvtVHAiC0Px2Ueulcqm1kSNNaIrZsPJkK2aKNIOQd+bSf0mNn6oM7d6ze988ysiUmokN9x++1gzQpKXiQHILB24Hz0e8Nf/oCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Vg4/TIsX; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Vg4/TIsX"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 993441655;
	Mon, 28 Sep 2026 07:01:37 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 638F33F763;
	Mon, 28 Sep 2026 07:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790604101; bh=fBXa/ueasdImeVBDgfgjheoJKCMPY8NCaFV/SF8dFPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vg4/TIsX2zSBY/VJqTduNFc8Zkia1nMyF7g2IbT/uVMxbgf5qc4QgCPb4GrrFBkHk
	 JX+sp1wpJUJiRu+nL4m88fjnJNEGuVXrPNUy/Gl1Jyh8GtyJhLEWtfZZbwlffcIy5H
	 Jpptuh7ALbAdmfYXzqllwFwA60Vv/MokQ/6iTL/Y=
Date: Mon, 28 Sep 2026 15:01:26 +0100
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
Subject: Re: [PATCH v8 10/29] arm64: Use proper include variant
Message-ID: <arpzNmXfjqlKbQHh@arm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-11-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918133107.1042730-11-seiden@linux.ibm.com>

On Fri, Sep 18, 2026 at 03:30:47PM +0200, Steffen Eiden wrote:
> Use <> for including the sysreg header as it is not discoverable from
> the current directory.
> 
> Fixes: c07d8017bceb ("arm64/sysreg: Enable automatic generation of system register definitions")
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
