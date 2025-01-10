Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342A520FAA7
	for <linux-s390@vger.kernel.org>; Fri, 10 Jan 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517560; cv=none; b=S2zJLqfn/B9dEjWYhHKYVc3gsRksk/CXX+AzfeFVRZW2xrg4G8MT5+S6ymTomUuDf+vfNiVVBsKi/l9uquwT6aXQPkjE7+5VhqgNJoHPcs7DkBUgqDQsPMfa/Unt2ZaZnLmLABjXc43LvZrmvLBLQ4+QX6TYqyvGxmW+c+CC9tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517560; c=relaxed/simple;
	bh=1Nk/7LREUzWn06GVCKgwTqOsLkSYpHQZDnABmWtHRmY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XxaLeQP56+jWJiE8I98dY0pKbp3eNy74PtbpZ8/hhRxh3EJANzOdWhGflH84KCZiqKzgtv7dFwu45E5Pu75zPJwDAIYLLiuPYssrxe2ck4vVX2+qIHMhZUjuGdni3UmubmT26n7vfJ/+bW9u0v566mc8c0ini2BWbBPlkljnjd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C754F1477;
	Fri, 10 Jan 2025 05:59:45 -0800 (PST)
Received: from localhost.localdomain (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DDD93F59E;
	Fri, 10 Jan 2025 05:59:15 -0800 (PST)
From: Alexandru Elisei <alexandru.elisei@arm.com>
To: andrew.jones@linux.dev,
	eric.auger@redhat.com,
	lvivier@redhat.com,
	thuth@redhat.com,
	frankja@linux.ibm.com,
	imbrenda@linux.ibm.com,
	nrb@linux.ibm.com,
	david@redhat.com,
	pbonzini@redhat.com
Cc: kvmarm@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	kvm-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	vladimir.murzin@arm.com
Subject: [kvm-unit-tests PATCH v1 0/5] arm64: Change the default --processor to max
Date: Fri, 10 Jan 2025 13:58:43 +0000
Message-ID: <20250110135848.35465-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(CC'ing everyone from MAINTAINERS because I'm touching configure)

Vladimir sent a test for MTE [1], which didn't work on the default -cpu
model, cortex-a57, because that CPU didn't implement MTE. There were two
options to get it working:

1. Add -cpu max to the extra_params unittest parameter.
2. Make the default value for the configure --processor option 'max'.

We decided that the second option was preferable, so here it is.

The first patch might look unrelated, but when I was writing the function
to select the default processor based on the architecture I noticed that
for arm64, $arch is first equal to aarch64, then it gets changed to arm64.
My first instinct was to have it be arm64 from the start, but then I
realized that, despite the help text, --arch=aarch64 has been supported
ever since arm64 was added to kvm-unit-tests. So I decided that it might
more prudent to go with it and document it.

[1] https://lore.kernel.org/all/20241212103447.34593-1-vladimir.murzin@arm.com/

Alexandru Elisei (5):
  configure: Document that the architecture name 'aarch64' is also
    supported
  configure: Display the default processor for arm and arm64
  arm64: Implement the ./configure --processor option
  arm/arm64: Add support for --processor=max
  configure: arm64: Make 'max' the default for --processor

 arm/Makefile.arm    |  1 -
 arm/Makefile.common |  3 +++
 configure           | 35 ++++++++++++++++++++++++++---------
 3 files changed, 29 insertions(+), 10 deletions(-)


base-commit: 0ed2cdf3c80ee803b9150898e687e77e4d6f5db2
-- 
2.47.1

