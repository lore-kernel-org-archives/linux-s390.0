Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCBC4E36CF;
	Mon, 28 Sep 2026 15:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608294; cv=none; b=uUG9fGwlQhf/Aa/U+/JDOM6Ob0Tb+jzRW1aFd0JIq3q6FKBh8GHtJ05ykC1797xBkO5nXYVWFsjzS+TADRX/CKsH/QoXudInvqfjncy8vWxv+HetYwcCpQx7lF+W60yEXsOpkj+cuu7k+b2Qq/5bubOA2PP7yOPO8bqqOUJFRNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608294; c=relaxed/simple;
	bh=Hc6ZuvaXlauagEGx+TDoCIpa+OmpCGHn1bAN2lvRNK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovnyFUsa7+sN8cKpnFqOiyImwXhYb8zGCEGlCyTU328yRbrGhv7yxdIbng1FbAto4D35z+/dIuTpMGDUAj8wze2WtO8CVNbBMHTOa2dP4C5ss+4ciJCvtnulTWlJm09fbXIfI8CnKuGiU4kW4m3WzVl6BfrcJw1nPZnaat8L1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Q/rdgTRw; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Q/rdgTRw"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FF571758;
	Mon, 28 Sep 2026 08:11:28 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AADD03F763;
	Mon, 28 Sep 2026 08:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790608291; bh=Hc6ZuvaXlauagEGx+TDoCIpa+OmpCGHn1bAN2lvRNK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q/rdgTRw0IwSGfaXeojr45nvCaK8teKmg2S6xpipCML0NkCzlkKSs1gFhpwfzSluc
	 DBb73c42I6LDgDbqy9l2zkhq0f8wdYDcqsp/Qe2+FU3nu9Eyhmx9PLKz6SnqQoNjbf
	 waSikuiYa0PdFkLkD6u5zq/WbdEOeOhKgHxI1tgo=
Date: Mon, 28 Sep 2026 16:11:23 +0100
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
Subject: Re: [PATCH v8 15/29] arm64: Prepare sharing arm64 headers with s390
Message-ID: <arqDm9EGd7-rqvWp@arm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-16-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918133107.1042730-16-seiden@linux.ibm.com>

On Fri, Sep 18, 2026 at 03:30:52PM +0200, Steffen Eiden wrote:
> Prepare the sharing of arm64 headers with s390 by moving definitions
> inside headers to reduce the number of shared markers. Clean up includes
> to further streamline the sharing of headers.
> 
> No functional change.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
