Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98F112E5B;
	Mon, 23 Sep 2024 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727073453; cv=none; b=aPLKXGSMcLkIsL5gkA8LTclI89/sJCmnNR3RtSQCvSjeizk0uG/VLhax5LSY8NekQcN+AurtxhpGoWgIRovJw8N73N4EfgPfqBjjpcm9qc6PlLKjDSR6IUKxmk5CnDsLuM1OAwq0O4ICAC1OTPX0TwCl2zDoreJG2KPYfG72mLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727073453; c=relaxed/simple;
	bh=YU5IHHmdIwhRVsCe/Ns40p8QPGMWO6o0pZ2uibjaigM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q/DSl2TTvaIVwDLJb3AkP3UzOqtAC5okA276b84SzpNSCfHBPbX/qKRcmAjhOVw6wnqIR5apy2grVg3sRVv08aXzY93vkvutT40GGfRHgK//JiOArsx7gF3h7MMM0OlQVY3AhHIPjdpHPGBmoSyrUahbaqaYLawzGGjYsffqjdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihmIBQ+z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihmIBQ+z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874E1C4CEC4;
	Mon, 23 Sep 2024 06:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727073451;
	bh=YU5IHHmdIwhRVsCe/Ns40p8QPGMWO6o0pZ2uibjaigM=;
	h=From:To:Cc:Subject:Date:From;
	b=ihmIBQ+zGDDXAyKxoZWjS7S63fCG7SqoU0IcFRn7pV3iCPR6CScg4eMUtrGrstZKu
	 54no9xbdAL4wzBtbf9pDq6wB5nWIjuuLQcTlr3DMWCNDqS78Z1LJ3m0lTqEKk5Hi6x
	 c8htul2IhYQOltrFn85mNzcrRG68GC/HUUf4+fzySgIPBUyHdi6X2kXc5mEyPtnzm+
	 QMmhdhLqPvtpaCMrlhDgPO/YcMzqNtH4mgz4hZ7ZafJqyBfhoRrkXSgjfoA4X07q2B
	 sxkKbSQDlUaaDYCBRYKiCYGj01K+MpkyJLWom4Brw6ITnhpBaJPZi5X2aGrOnUL9qL
	 FDo0V3YvzpouQ==
From: Mike Rapoport <rppt@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org
Subject: memblock: updates for 6.12-rc1
Date: Mon, 23 Sep 2024 09:37:07 +0300
Message-ID: <20240923063707.40017-1-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit de9c2c66ad8e787abec7c9d7eff4f8c3cdd28aed:

  Linux 6.11-rc2 (2024-08-04 13:50:53 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock tags/memblock-v6.12-rc1

for you to fetch changes up to cb088e38aab4c7e9ce711c18c66e851c8f4227bb:

  s390/mm: get estimated free pages by memblock api (2024-08-11 19:19:07 +0300)

----------------------------------------------------------------
memblock: updates for 6.12-rc1

* new memblock_estimated_nr_free_pages() helper to replace totalram_pages()
  which is less accurate when CONFIG_DEFERRED_STRUCT_PAGE_INIT is set
* fixes for memblock tests

----------------------------------------------------------------
Wei Yang (11):
      memblock tests: include memory_hotplug.h in mmzone.h as kernel dose
      memblock tests: include export.h in linkage.h as kernel dose
      tools/testing: abstract two init.h into common include directory
      memblock test: fix implicit declaration of function 'virt_to_phys'
      memblock test: add the definition of __setup()
      memblock test: fix implicit declaration of function 'memparse'
      memblock test: fix implicit declaration of function 'isspace'
      memblock test: fix implicit declaration of function 'strscpy'
      mm/memblock: introduce a new helper memblock_estimated_nr_free_pages()
      kernel/fork.c: get estimated free pages by memblock api
      s390/mm: get estimated free pages by memblock api

 arch/s390/mm/init.c                              |  2 +-
 include/linux/memblock.h                         |  1 +
 kernel/fork.c                                    |  2 +-
 mm/memblock.c                                    | 17 ++++++++
 tools/include/linux/compiler.h                   |  4 --
 tools/{testing/memblock => include}/linux/init.h | 19 ++++++---
 tools/include/linux/linkage.h                    |  2 +
 tools/include/linux/mm.h                         |  6 +++
 tools/include/linux/pfn.h                        |  1 +
 tools/include/linux/string.h                     |  3 ++
 tools/lib/cmdline.c                              | 53 ++++++++++++++++++++++++
 tools/testing/memblock/Makefile                  |  2 +-
 tools/testing/memblock/linux/kernel.h            |  2 +
 tools/testing/memblock/linux/mmzone.h            |  1 +
 tools/testing/radix-tree/linux/init.h            |  2 -
 tools/testing/radix-tree/maple.c                 |  2 +-
 16 files changed, 104 insertions(+), 15 deletions(-)
 rename tools/{testing/memblock => include}/linux/init.h (76%)
 create mode 100644 tools/lib/cmdline.c
 delete mode 100644 tools/testing/radix-tree/linux/init.h
