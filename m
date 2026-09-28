Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AAF4E50CA;
	Mon, 28 Sep 2026 15:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790608121; cv=none; b=hMVtKm6mfdiwkY25YBmg7xgHZhcxaIadB7CGsn05y4Ry+J+00Epmnh8lofd7CXbdVVA7cMlg1ML05GKnby2iL4msC8y1eakjlu7t45fN2Pgv3q5mV2D5LfDIZ4/mwQQ1nmzw/rF2YyVpchGBsSUdJXCZsVg/66GaoyKsmEgdPFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790608121; c=relaxed/simple;
	bh=3VZr6MDWsDpzNsxFdLUEyGm21yc/UVToMdFZiG+TJog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5VsO/I1Gjk0zYSFTVSDH5WIwA20LB350OLDu+MvoR8OxlS1JGHMeeuvyctFmleNgT63mvV98Ez4bYhcfx5B9MXgmMRnsxkamEUHE+xf83Vi/1uUXryHlUzxsZLZUMLOD3pxnbl3sZEC7I1oRrOOGODMDkT2pwi9GOrnLh/VCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=cNy/ix7N; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="cNy/ix7N"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 194AD1655;
	Mon, 28 Sep 2026 08:08:35 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A4E23F763;
	Mon, 28 Sep 2026 08:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790608118; bh=3VZr6MDWsDpzNsxFdLUEyGm21yc/UVToMdFZiG+TJog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNy/ix7NniUBTAB0Lh+OcuWewevCXUiS6DxpuII7eOhS2jmCdDqzSQSu9YcEocwIC
	 ojumWGLgfcdpqKF8XxT/0B0Y30tqMXHaGhdhCi2qIHP4guq0dJfTPCk/vFHyTSy3u/
	 87DomGIsze/VZw2kZTmBENQBzk5/hZPbOS3KDZSU=
Date: Mon, 28 Sep 2026 16:08:27 +0100
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
Subject: Re: [PATCH v8 12/29] arm64: sysreg: Convert SPSR_ELx to automatic
 register generation
Message-ID: <arqC65oRDWQ6GdXb@arm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-13-seiden@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918133107.1042730-13-seiden@linux.ibm.com>

On Fri, Sep 18, 2026 at 03:30:49PM +0200, Steffen Eiden wrote:
> Convert SPSR_EL{1, 2, 12} to automatic register generation as per
> DDIO616 2026-06. No functional change.

What's this document? DDI0616 is the SME spec (also s/DDIO/DDI0/ -
replace letter O with zero). Maybe use DDI0601 (system registers spec)
or the Arm ARM, DDI0487.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
