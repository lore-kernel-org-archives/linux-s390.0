Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025353ED113;
	Mon, 11 May 2026 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778508339; cv=none; b=nVMI4ZMD9DCuAEwf73AWLBA9MRNCUfOcMfyEs/HzHM6RfXpumUuHWFE+orDfcufRJWNqRVAVVPtqSFtHpr9/UWbbib5NQ8J46PM7fJ7FoPy4pWGhjUenuCQZg+1vuloIFJoUJHk46d1asz396uMPb8ANB7M+4WEM31nHWThNyLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778508339; c=relaxed/simple;
	bh=Pm3OKX4tz/hPsvUcluc/wv11pQMYSvwTXUM7a7WxgtA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qasZ6SdpO0VHxkXooAZtOKiQ3ei8doU8PfydTQudOUWJV7MZJlEH8gsMZ7XZDYElX9bBCw7vzfanGkpQgpnu2jHH5279E8/O8EXhDnF/INraamHM3cljw+XL52TpdEBOHcpkgWhCPEqges6y1go+nW6uoH1S83ROrwcvXS7I1nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pk8OvGhJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pk8OvGhJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6323FC2BCB0;
	Mon, 11 May 2026 14:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778508338;
	bh=Pm3OKX4tz/hPsvUcluc/wv11pQMYSvwTXUM7a7WxgtA=;
	h=From:Subject:Date:To:Cc:From;
	b=pk8OvGhJq7glmUYSBkvjdGMP8W1PwVrj/Ni3Vl6ybhzKWT6REW5dAxr3KJL8Qww30
	 E588cfZ6DoBozhyhGn/5G6YQ/IWBF4Ds5JmK12mdtVf7FtP+6eg2pqtKxcgjkhacEt
	 7XoKR6PdHITxP1Lz63lzWXchEtWTiDthd8atbcP2GojB3NkRaoidqNmLH0XqLjqQt5
	 /xaOsOTS2ojBPwKvIW2lNWBCpaI3QT00m1Z5Rh5VuZKvNEnIcaO8wH3zOE3YvebS4z
	 Wjw3Jmmdw/vmHqR3GEnYlW3qe3zPpguwb7OJlJ2b4ie1RJEWM0QSsUDcjsm1zHmNUd
	 K+7av9Ttx/5rw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Subject: [PATCH 0/8] mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE (Part 1)
Date: Mon, 11 May 2026 16:05:28 +0200
Message-Id: <20260511-bootmem_info_prep-v1-0-3fb0be6fc688@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACniAWoC/x2MQQqAIBAAvyJ7TlChjL4SIWpr7SEVjQiivycdZ
 2DmgYqFsMLEHih4UaUUG8iOgd9t3JDT2hiUUIPopeQupfPAw1AMyeSCmbvgBWrbu1EjtK7JQPf
 /nJf3/QA9mHRTYwAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, Mike Rapoport <rppt@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-s390@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.13.0

We want to remove CONFIG_HAVE_BOOTMEM_INFO_NODE. As a first step,
let's limit the remaining harm to x86 and core code, removing
sparc, ppc and s390 leftovers, starting the stepwise removal by removing
and simplifying some code.

Once a related x86 vmemmap fix [1] is in, we can merge part 2 that will
remove CONFIG_HAVE_BOOTMEM_INFO_NODE entirely.

Tested on x86-64 with hugetlb vmemmap optimization in combination with
KMEMLEAK, making sure that the problem reported in dd0ff4d12dd2 ("bootmem:
remove the vmemmap pages from kmemleak in put_page_bootmem") does not
reappear -- hoping I managed to trigger the original problem.

Heavily cross-compiled, but let's let build bots run on it for a bit.

[1] https://lore.kernel.org/r/20260429-vmemmap-v2-1-8dfcacffd877@kernel.org 

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
David Hildenbrand (Arm) (8):
      sparc/mm: remove register_page_bootmem_info()
      mm/bootmem_info: drop initialization of page->lru
      mm/bootmem_info: stop using PG_private
      mm/bootmem_info: remove call to kmemleak_free_part_phys()
      mm/bootmem_info: stop marking the pgdat as NODE_INFO
      mm/bootmem_info: stop marking mem_section_usage as MIX_SECTION_INFO
      s390/mm: use free_reserved_page() in vmem_free_pages()
      powerpc/mm: remove CONFIG_HAVE_BOOTMEM_INFO_NODE

 arch/powerpc/mm/init_64.c    |  8 --------
 arch/s390/mm/vmem.c          |  3 +--
 arch/sparc/mm/init_64.c      | 20 --------------------
 include/linux/bootmem_info.h |  1 -
 mm/Kconfig                   |  2 +-
 mm/bootmem_info.c            | 25 ++-----------------------
 6 files changed, 4 insertions(+), 55 deletions(-)

---

base-commit: e9dd96806dbc2d50a66770b6a86962bd5d601153

change-id: 20260511-bootmem_info_prep-bfc0e7a5b87e

--

Cheers,

David

