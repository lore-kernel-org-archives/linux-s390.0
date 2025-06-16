Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59441684B4;
	Mon, 16 Jun 2025 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750041023; cv=none; b=pRvr3x3elkE42vyuTDYYLV+ScXEoU0+aUE2Vb772z+b7IE8L5u8vJzvQ9N1nf5bqQ27vvkP13p7TyPytOU039XOrfj+phoy1plgLSZFQpzviVSiialOFdfe54gHgUrbq9yaxK/jBo5GedkuTeZ7ORgQiP2OidfAfPr64JA3sG6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750041023; c=relaxed/simple;
	bh=d99D5Krm7mKYs6va4kUf7uKaI9HolviebMCYWhi1034=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rdaZhYkc+3Zjj6HIphX1gJS46WhYctnBzwD0GyrT12oTucYP6DPun4c1PZ4xwYJCgfhOrNnIUESTjc5sZrhidMwSxYgOmrObK/cPW7TlqJhRzoqvX1Ay3QoO574fD1C2bUbso8a5djIB2oLLDS5xP33ONnvARXQpH2uXdprEQt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DQLERJrq; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DQLERJrq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750041008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KIW9tIcYwbZjo1QxGJ4orrM2LqJaaYmiNgbtFxQwPmQ=;
	b=DQLERJrqrvBj5++7xzFmkax2EMVbQ54JQjD5+/QkLzlYUxXiMJXoo9LOzD4hkSs0gixMYm
	MAOIUR2fQUfrS39XTVuZHhg5c7hsbu+xwNboPoXChPtHGm32av53FS3O0bZQ75nDdol/qY
	oO2vcvxwFZ+0FwH6uU3jO52/MwioTP8=
From: Hao Ge <hao.ge@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Hao Ge <hao.ge@linux.dev>,
	Hao Ge <gehao@kylinos.cn>
Subject: [PATCH v3 0/2] mm: Restrict the static definition of the per-CPU variable _shared_alloc_tag to s390 and alpha architectures only
Date: Mon, 16 Jun 2025 10:29:16 +0800
Message-Id: <cover.1750040317.git.gehao@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Hao Ge <gehao@kylinos.cn>

Recently discovered this entry while checking kallsyms on ARM64:
ffff800083e509c0 D _shared_alloc_tag

If ARCH_NEEDS_WEAK_PER_CPU is not defined((it is only defined for
s390 and alpha architectures),there's no need to statically define
the percpu variable _shared_alloc_tag. As the number of CPUs
increases,the wasted memory will grow correspondingly.

Therefore,we need to implement isolation for this purpose.

However,currently ARCH_NEEDS_WEAK_PER_CPU is a #define and
is enclosed within the #if defined(MODULE) conditional block.

When building the core kernel code for s390 or alpha architectures,
ARCH_NEEDS_WEAK_PER_CPU remains undefined (as it is gated
by #if defined(MODULE)). However,when building modules for these
architectures,the macro is explicitly defined.

Therefore,we need to make ARCH_NEEDS_WEAK_PER_CPU a Kconfig option.
And replace all instances of ARCH_NEEDS_WEAK_PER_CPU in the kernel
code with MODULE_NEEDS_WEAK_PER_CPU,MODULE_NEEDS_WEAK_PER_CPU might
be a more accurate description,because it was only needed for modules.
Then,when defining the percpu variable _shared_alloc_tag,wrap it with the
CONFIG_ARCH_NEEDS_WEAK_PER_CPU condition.

The following version can be regarded as the most original version:
https://lore.kernel.org/all/20250529073537.563107-1-hao.ge@linux.dev/
But unfortunately,it caused build errors on s390.
Based on Suren's guidance and suggestions,
I've refined it into this patch series.
Many thanks to Suren for his patient instruction.

Verify:
     1. On Arm64:
        nm vmlinux | grep "_shared_alloc_tag",no output is returned.
     2. On S390:
        Compile tested.
        nm vmlinux | grep "_shared_alloc_tag"
        00000000015605b4 r __crc__shared_alloc_tag
        0000000001585fef r __kstrtab__shared_alloc_tag
        0000000001586897 r __kstrtabns__shared_alloc_tag
        00000000014f6548 r __ksymtab__shared_alloc_tag
        0000000001a8fa28 D _shared_alloc_tag
        nm net/ceph/libceph.ko | grep "_shared"
        U _shared_alloc_tag
     3. On alpha
        Compile tested.
        nm vmlinux | grep "_shared_alloc_tag"
        fffffc0000b080fa r __kstrtab__shared_alloc_tag
        fffffc0000b07ee7 r __kstrtabns__shared_alloc_tag
        fffffc0000adee98 r __ksymtab__shared_alloc_tag
        fffffc0000b83d38 D _shared_alloc_tag
        nm crypto/cryptomgr.ko | grep "_share"
        U _shared_alloc_tag

v3:
    Suren pointed out that patches 1-2 can be merged into a single patch
    in version 2. And the commit message for patch 3 can be made more
    concise.Make corresponding modifications based on the pointed-out
    issues and update the corresponding commit message.

v2:
    Heiko pointed out that when defining MODULE_NEEDS_WEAK_PER_CPU,
    the CONFIG_ARCH_NEEDS_WEAK_PER_CPU condition in the v1 version
    should be removed,as it is always true for s390 and alpha
    architectures.And He also pointed out that patches 2-4 need to
    be merged into one patch. Modify the code according to the suggestions
    and update the corresponding commit message.

Hao Ge (2):
  mm: Optimize the ARCH_NEEDS_WEAK_PER_CPU logic for s390/alpha
    architectures
  mm/alloc_tag: add the CONFIG_ARCH_NEEDS_WEAK_PER_CPU macro when
    statically defining the percpu variable _shared_alloc_tag

 arch/alpha/Kconfig              | 1 +
 arch/alpha/include/asm/percpu.h | 2 +-
 arch/s390/Kconfig               | 1 +
 arch/s390/include/asm/percpu.h  | 2 +-
 include/linux/alloc_tag.h       | 6 +++---
 include/linux/percpu-defs.h     | 4 ++--
 lib/alloc_tag.c                 | 2 ++
 mm/Kconfig                      | 4 ++++
 8 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.25.1

