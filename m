Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AB913CFB7
	for <linux-s390@vger.kernel.org>; Tue,  3 Sep 2024 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374394; cv=none; b=fYNk49iHOIUCVajP3w1gyKSU1r6x1fZPt7nr/MltvB/JoeyCS6eCi4kfYS/kU7WzNXl1l3mbdy6+kzVxH5Gi+bG6thcA+Mhks3zelP88zlUEa3M25gqd2a3oOVR0FQVc+dac0FVEO/d/3OCYbeSXbWvnGJ16hwPg8lu7bATFrxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374394; c=relaxed/simple;
	bh=Q0jpZSdEq9UcPqSQtw8ICs4EGrluGAh7nPySsNoe7Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s5shR9+Z9JSi347iKCuKViikMnCpETq5Qhp1iZEhx6T6vVyqMXFLzuQ0xvFOQa69tDCYcN0E1gYBY6rp6XC3HvsuSUM+EDXy+jiormq6dtHiLhBRLrUNC9cEBeQ0rrqRFXW5P6eLdUmkHrlKe8B/Ta+XLYC0CF15gHvJ1CUOrVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qfQPriaM; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qfQPriaM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725374389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UoipvRa1rIlz02HbMk6/9TovCElSsYtUx+SlrCp58mM=;
	b=qfQPriaMG7F97zrrYRPeqmNAzZ2Fya7Tx/pPdqSt1GFpgUddaebwTjEIgXnEVgMXx9UAtj
	rtPDaZ3L84KS7pDp3kSEy4UmxXJrOBaUpqQG+3GKMvtaQHOHJev9H/ASPyhRExHSXUPKri
	ElCIqPlGyfKU0+3NNWojOHfKeSuUQwM=
From: Andrew Jones <andrew.jones@linux.dev>
To: kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com,
	thuth@redhat.com,
	lvivier@redhat.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	nrb@linux.ibm.com,
	atishp@rivosinc.com,
	cade.richard@berkeley.edu,
	jamestiotio@gmail.com
Subject: [kvm-unit-tests PATCH 0/2] configure: Support CONFIG_* extension
Date: Tue,  3 Sep 2024 16:39:47 +0200
Message-ID: <20240903143946.834864-4-andrew.jones@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

riscv already wants to change NR_CPUS sometimes, so a CONFIG_NR_CPUS,
which can be changed at compile time, would be helpful. We could just
provide support for that with the configure command line, but other
configurations will eventually come along (there are already two more
in another riscv branch). Add support for extending config.h with a
manually provided config.h-type file and also add support for using it
for CONFIG_NR_CPUS for riscv.

Andrew Jones (2):
  configure: Introduce add-config
  riscv: Make NR_CPUS configurable

 configure             | 17 ++++++++++++++++-
 lib/riscv/asm/setup.h |  3 ++-
 2 files changed, 18 insertions(+), 2 deletions(-)

-- 
2.46.0

