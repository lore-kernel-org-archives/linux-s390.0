Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2709C185931
	for <linux-s390@vger.kernel.org>; Fri, 20 Sep 2024 17:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726854466; cv=none; b=TuHvCwLw5eO4DKaEJi8Y0jH4qdF07ccsGnJ1hbFT0WZUhjrw4D8ISmOCnaf7twuwo+7qE+4DGNHbc5SO6pXGxhC0BQzSVg9bP3JtXPj0H2Q7YSoerHe8x84KnuDbKLbxfs0w9rVu1bkGfQ3+B/JvTh+fJ1vTSlyD2pDiSxlLQWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726854466; c=relaxed/simple;
	bh=y/0LqhkUFKLFvvmv5O0BARy04KbRdOL/9eO4QczoFTA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lIiHBhNOVnyoOVCqIxgCMZqe/dQBd4jfHvnNfurQpX5vZmRgd50KreW+HYS9D2JPpkslqRT0UKKk9U63NVXAIKXWB9Igv+PZQidwFDyHoVw7f1mbqyLLG7Wqfcy4U2dKR+GrKAOpOSBqARLU6dTIq9WY7ABwRYtGoW0xsjccnTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tbLBnRAJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tbLBnRAJ"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ddcb412e3bso40891007b3.0
        for <linux-s390@vger.kernel.org>; Fri, 20 Sep 2024 10:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726854464; x=1727459264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MVX2p+TpOgKO2VD1T0Sjf0Y9xYKj+teBBRpgO6spktE=;
        b=tbLBnRAJHPshGsbInwfUuXZfYYAOckppiLO/EqIeZ2kgDZYohCA5Hp6jb+bq2r4N+1
         gGYgrq51fin4OhPJzTWjG/idVxnfssuR7giV5rKdEYLjekhyWk//AW24oZbJ1637y5g1
         QOTBRtJw/7/qufGXC8pGDCWNQXehLvtmEVRCK4rAvMYIPoG39xWVbNxmbKCJRyT48haR
         5xpcT8ThtqdIBBkNaWqKP+BU7xH9lzjcWekmm2O3Dcr1l5VwwvsgDvPdTdr584+qbjXQ
         5g0/Eg+YdjMrid44pIMxlOhiE5SyLPTV/0mDabTolAMlpyxkRFpvX8Qb844TlWt8LJPO
         vZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726854464; x=1727459264;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MVX2p+TpOgKO2VD1T0Sjf0Y9xYKj+teBBRpgO6spktE=;
        b=gp1llSdYAjpsG/CQMUF0XAKBNHZHrHeiUB3//0Dvi+8Jwhfg6sDuWhIVfZObP2viBd
         rxN2GKISn3QEiTDqBQfm3guU6QfQLSyHoiHvNlirtNld8Btc5kIW+xahRqnQzB/jHxNB
         zErK092FMM9ukK0xNZWzxaMPBNtSNut66DzZa3FLHr8AsNkGGjdNr2FtRxGV+X1Nu2YK
         NZaCOBgMbGlmTK64voGvmFMBkYUjiC40pqYcXmgYadnCdVMu/LTdGOhEO7t26GF4o2hS
         FwbjPlZTSk4KQDopfSlFZ3OmlFnQ33GlUYGuFoYpi6P+oQ9n5/hQ60kr9NYbQUowXmrU
         KxAg==
X-Forwarded-Encrypted: i=1; AJvYcCVHzqOz6A5j6OUNDSTDNDJSItx2EeUBjq1tQ+SBf58Lp8cLL0YhvTfH3PI5U0KaGU/lrgcFnQSlkdiF@vger.kernel.org
X-Gm-Message-State: AOJu0YzdOr0/OEWuGDyqMH1g1L+Dki+0us9R8WaiQjjUETafmfoC9Sdw
	YtI/w1w4W4lJL3gYc1YnRrnJVu1oeGbBKyIj2VbJZF7AkT/3BAZdebfv2EtXdCQ47kIvNlwy4W0
	MrS4UzVVnca9bMuPs549DJw==
X-Google-Smtp-Source: AGHT+IGdaBc0VukQd5fL8Bpn3emPCz2aUl7uHxwZYGGbbf8J5W3JOUJuoVEqVbJQELPzn/Ev3AqsKyGRg/+CmYTS0w==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a25:abd0:0:b0:e1a:44fa:f09 with SMTP
 id 3f1490d57ef6-e2250c2162amr2899276.2.1726854464128; Fri, 20 Sep 2024
 10:47:44 -0700 (PDT)
Date: Fri, 20 Sep 2024 17:47:35 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240920174740.781614-1-coltonlewis@google.com>
Subject: [PATCH v5 0/5] Correct perf sampling with Guest VMs
From: Colton Lewis <coltonlewis@google.com>
To: kvm@vger.kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>, Sean Christopherson <seanjc@google.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Will Deacon <will@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"

v5:
* Correct the same compilation failure on s390
  This time I made sure to download all the cross-toolchains of all
  architectures touched and compiled once for each arch.

v4:
https://lore.kernel.org/kvm/20240919190750.4163977-1-coltonlewis@google.com/

v3:
https://lore.kernel.org/kvm/20240912205133.4171576-1-coltonlewis@google.com/

v2:
https://lore.kernel.org/kvm/20240911222433.3415301-1-coltonlewis@google.com/

v1:
https://lore.kernel.org/kvm/20240904204133.1442132-1-coltonlewis@google.com/

This series cleans up perf recording around guest events and improves
the accuracy of the resulting perf reports.

Perf was incorrectly counting any PMU overflow interrupt that occurred
while a VCPU was loaded as a guest event even when the events were not
truely guest events. This lead to much less accurate and useful perf
recordings.

See as an example the below reports of `perf record
dirty_log_perf_test -m 2 -v 4` before and after the series on ARM64.

Without series:

Samples: 15K of event 'instructions', Event count (approx.): 31830580924
Overhead  Command          Shared Object        Symbol
  54.54%  dirty_log_perf_  dirty_log_perf_test  [.] run_test
   5.39%  dirty_log_perf_  dirty_log_perf_test  [.] vcpu_worker
   0.89%  dirty_log_perf_  [kernel.vmlinux]     [k] release_pages
   0.70%  dirty_log_perf_  [kernel.vmlinux]     [k] free_pcppages_bulk
   0.62%  dirty_log_perf_  dirty_log_perf_test  [.] userspace_mem_region_find
   0.49%  dirty_log_perf_  dirty_log_perf_test  [.] sparsebit_is_set
   0.46%  dirty_log_perf_  dirty_log_perf_test  [.] _virt_pg_map
   0.46%  dirty_log_perf_  dirty_log_perf_test  [.] node_add
   0.37%  dirty_log_perf_  dirty_log_perf_test  [.] node_reduce
   0.35%  dirty_log_perf_  [kernel.vmlinux]     [k] free_unref_page_commit
   0.33%  dirty_log_perf_  [kernel.vmlinux]     [k] __kvm_pgtable_walk
   0.31%  dirty_log_perf_  [kernel.vmlinux]     [k] stage2_attr_walker
   0.29%  dirty_log_perf_  [kernel.vmlinux]     [k] unmap_page_range
   0.29%  dirty_log_perf_  dirty_log_perf_test  [.] test_assert
   0.26%  dirty_log_perf_  [kernel.vmlinux]     [k] __mod_memcg_lruvec_state
   0.24%  dirty_log_perf_  [kernel.vmlinux]     [k] kvm_s2_put_page

With series:

Samples: 15K of event 'instructions', Event count (approx.): 31830580924
Samples: 15K of event 'instructions', Event count (approx.): 30898031385
Overhead  Command          Shared Object        Symbol
  54.05%  dirty_log_perf_  dirty_log_perf_test  [.] run_test
   5.48%  dirty_log_perf_  [kernel.kallsyms]    [k] kvm_arch_vcpu_ioctl_run
   4.70%  dirty_log_perf_  dirty_log_perf_test  [.] vcpu_worker
   3.11%  dirty_log_perf_  [kernel.kallsyms]    [k] kvm_handle_guest_abort
   2.24%  dirty_log_perf_  [kernel.kallsyms]    [k] up_read
   1.98%  dirty_log_perf_  [kernel.kallsyms]    [k] __kvm_tlb_flush_vmid_ipa_nsh
   1.97%  dirty_log_perf_  [kernel.kallsyms]    [k] __pi_clear_page
   1.30%  dirty_log_perf_  [kernel.kallsyms]    [k] down_read
   1.13%  dirty_log_perf_  [kernel.kallsyms]    [k] release_pages
   1.12%  dirty_log_perf_  [kernel.kallsyms]    [k] __kvm_pgtable_walk
   1.08%  dirty_log_perf_  [kernel.kallsyms]    [k] folio_batch_move_lru
   1.06%  dirty_log_perf_  [kernel.kallsyms]    [k] __srcu_read_lock
   1.03%  dirty_log_perf_  [kernel.kallsyms]    [k] get_page_from_freelist
   1.01%  dirty_log_perf_  [kernel.kallsyms]    [k] __pte_offset_map_lock
   0.82%  dirty_log_perf_  [kernel.kallsyms]    [k] handle_mm_fault
   0.74%  dirty_log_perf_  [kernel.kallsyms]    [k] mas_state_walk

Colton Lewis (5):
  arm: perf: Drop unused functions
  perf: Hoist perf_instruction_pointer() and perf_misc_flags()
  powerpc: perf: Use perf_arch_instruction_pointer()
  x86: perf: Refactor misc flag assignments
  perf: Correct perf sampling with guest VMs

 arch/arm/include/asm/perf_event.h            |  7 ---
 arch/arm/kernel/perf_callchain.c             | 17 -------
 arch/arm64/include/asm/perf_event.h          |  4 --
 arch/arm64/kernel/perf_callchain.c           | 28 ------------
 arch/powerpc/include/asm/perf_event_server.h |  6 +--
 arch/powerpc/perf/callchain.c                |  2 +-
 arch/powerpc/perf/callchain_32.c             |  2 +-
 arch/powerpc/perf/callchain_64.c             |  2 +-
 arch/powerpc/perf/core-book3s.c              |  4 +-
 arch/s390/include/asm/perf_event.h           |  6 +--
 arch/s390/kernel/perf_event.c                |  4 +-
 arch/x86/events/core.c                       | 47 +++++++++++---------
 arch/x86/include/asm/perf_event.h            | 12 ++---
 include/linux/perf_event.h                   | 26 +++++++++--
 kernel/events/core.c                         | 27 ++++++++++-
 15 files changed, 95 insertions(+), 99 deletions(-)


base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
--
2.46.0.792.g87dc391469-goog
