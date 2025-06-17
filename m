Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384EC28C2C7
	for <linux-s390@vger.kernel.org>; Tue, 17 Jun 2025 07:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750144318; cv=none; b=uHh/IP47YZKmsz44fvnwwIo+yW2yaD+I2ApvH5hlz2UdsXcIm318UlCK0faCYVTlDxIZSxtyAm70xvmOPuoDOGcReSzHzX8Awnr7Bhi+a20xmv4pvujsOXc4PdGY19qwl24bDrGx/ZHAHKelvnKMhMsXuLbYVI7w8wXgE6qKOTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750144318; c=relaxed/simple;
	bh=YIu7ey9UODrhg8Ytmf4JRWtiWxqFnsjtrEgZ0wi8w8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NkYeurLeI2Z0dg+Dj0warEUinMyiuyccEv3pavol0K+73ZBKpj4OZywFW1bdS+Makjiy+sQ5Zz36vJPufCeRUqeKcCjr/R9p0cOhPv6dPiiKDkLT20zeYEn2R1rhVacUQ8u+6zT1FjIEPFGmtMe76xAyCaqwQYG0y6kn1Qyz1+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=umkYV1WU; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="umkYV1WU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750144312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=wi3cd5Kmrpjh06Tdyw4IbO6I5Ww4NWJ5Q/peG+jrHlo=;
	b=umkYV1WUksMByRsQKfhalBwWGC437/K/+eHfu1cbDr88+Xev/LaD2iGn79M1O8mRqsCPM1
	JrqMFFZUyzA+hH/MLX6OmcDvyctYw3t/+msnKjrkZpmuKKK/OuN6PqyAPWvuD22/5epesl
	ebpF13mDAPWpp3jsiuy90tVQxHSzZt4=
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
Subject: [PATCH v5 0/1] mm: Restrict _shared_alloc_tag static definition to CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU
Date: Tue, 17 Jun 2025 15:10:51 +0800
Message-Id: <cover.1750143986.git.gehao@kylinos.cn>
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

If ARCH_NEEDS_WEAK_PER_CPU is not defined(it is only defined for
s390 and alpha architectures), there's no need to statically define
the percpu variable _shared_alloc_tag.

Therefore, we need to implement isolation for this purpose.

However, currently ARCH_NEEDS_WEAK_PER_CPU is a #define and
is enclosed within the #if defined(MODULE) conditional block.

When building the core kernel code for s390 or alpha architectures,
ARCH_NEEDS_WEAK_PER_CPU remains undefined (as it is gated
by #if defined(MODULE)). However, when building modules for these
architectures, the macro is explicitly defined.

Therefore, we remove all instances of ARCH_NEEDS_WEAK_PER_CPU from
the code and introduced CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU to
replace the relevant logic. We can now conditionally define the perpcu
variable _shared_alloc_tag based on CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU.
This allows architectures (such as s390/alpha) that require weak
definitions for percpu variables in modules to include the definition,
while others can omit it via compile-time exclusion.

The following version can be regarded as the most original version:
https://lore.kernel.org/all/20250529073537.563107-1-hao.ge@linux.dev/
But unfortunately, it caused build errors on s390.
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

v5: Regarding the omission of defined(MODULE) in alloc_tag.h where
    only #ifdef CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU was used,
    I apologize for this error.
    Please find version 5 attached to address this issue.

v4:
   Merge previous patches into a single patch.
   Remove all instances of ARCH_MODULE_NEEDS_WEAK_PER_CPU from v3
   and use CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU to
   replace the relevant logic.
   Replace CONFIG_ARCH_NEEDS_WEAK_PER_CPU with
   CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU in v3, as weak percpu support
   is only required for modules ,making the name more
   semantically accurate.
   David, Mike, Matthew, Kent, Heiko and Suren have all
   provided valuable input. Thanks for this.

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
    and update the corresponding commit message

Hao Ge (1):
  mm/percpu: Conditionally define _shared_alloc_tag via
    CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU

 arch/alpha/Kconfig              | 1 +
 arch/alpha/include/asm/percpu.h | 5 ++---
 arch/s390/Kconfig               | 1 +
 arch/s390/include/asm/percpu.h  | 5 ++---
 include/linux/alloc_tag.h       | 6 +++---
 include/linux/percpu-defs.h     | 7 ++++---
 lib/alloc_tag.c                 | 2 ++
 mm/Kconfig                      | 7 +++++++
 8 files changed, 22 insertions(+), 12 deletions(-)

-- 
2.25.1

