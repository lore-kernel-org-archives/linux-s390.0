Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684BE215033
	for <linux-s390@vger.kernel.org>; Thu,  7 Nov 2024 19:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006266; cv=none; b=H4NJIekd4cGtFhHibQdEmCFU7yNEWplbOKGP8PhXBASGSHmFh1qnFjibLDXbe0xLNX6z9B0ndcdCz/sDuDMmL17tbradGm62ve2bsn+FeJc71HpmOt0Q3nFu3L9f994uViOFc/4zl6WFRMafHb4+TpT6FvOkzoIWmM2B+PmA0A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006266; c=relaxed/simple;
	bh=rH+0U/U8QuJjNW02LPfeGGz9R6pA7ntPpm1SvusvDpE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=uYvIjDT/eX2EdLGZRWq0SrAoCLPVhoqqQzTysjDIbhHgLUB7j45f9DA7M66xZWmlDTrM978zulkcAdozndoUORRXm8MzBhsOWprHqK3bC2VhDmdimU7bZsA20hvbqTYiIVsd2WgJgibOx3KoT9On44e0K5GtdTEtIfXKNJwXv6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c/RRTibV; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c/RRTibV"
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3a6b7974696so16666195ab.1
        for <linux-s390@vger.kernel.org>; Thu, 07 Nov 2024 11:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731006263; x=1731611063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=307d+oKSDEQceCQxX9m+tC9eleFe8W0Ggi8DlXu2swQ=;
        b=c/RRTibVQaVzNzQrAwxE4Znu7PlIxLgW1UVR7YLRCpWehSWa6liJuGhKi9e7fGoaQJ
         D5hv8C4gr3mp7Xr0W26VyViOr4AfaPJXAV6DhYDXFBVEaEhmhyTIJqwzDlwTyhdXWb2Q
         QE7BI/oHeY97MhqpyGk2/0nDGNW/X9UZsZ8xNW4Dg0ZgwQzWcHkqmKMFt6bgvMuDmV1N
         vhnQNTwOMEsy1Eyppv6VIpmqYq9g4QSKPWpMrQc+6pWrhSO5gZNzIjpnyoc6JTOJ2NOq
         eAOXRjUeXJIqxna1lKP0zzYYZX1i/Ayli+9DriOFLkkPlhOKXZuemA4DFP3VH8Z83kHy
         hm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731006263; x=1731611063;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=307d+oKSDEQceCQxX9m+tC9eleFe8W0Ggi8DlXu2swQ=;
        b=VEEI4brMz3VsDlBtbBs8HTv06YTMDDNO/TUZ1nNnc9a2gWnY5pDFQeqx/fdp4sB5An
         yA2IjPm0I5CI4cl5VmDO5EXYMvpFGAYY/+kaUAqoGnzjvMP0OmfbWPAF4PZ1lwljh7Qv
         W3qtHH2vnZ/0m1Noh6/qYn1d87m8Lmx1ZanyC6x+Fyft3OWQO/5P5pMHuvQpwCFkuhAA
         gYpEzDA4mkYONaHxc7MuPd1UuXBUozf7+AR/b1PXZAJoYIjSAzR1HJDvvLbt996HuQFA
         F44Q4QfXomm5vukOkzfNKOAB0dXZM3+4wN5wia6slsmRPw+iXQnbkgj8CY2VKkR1JMLb
         VIPA==
X-Forwarded-Encrypted: i=1; AJvYcCUnRrsD71dcX8FttfSNhfaiv7hiOqGo99owzZplX3WzcKDNc5AuyjCagpJ/L6/U0RIT6i0W7HcuHGwa@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqk91LSZ7OJ0o/b892BQvvcirqQN94Vd1oFw3eU68BQ/3nQZ3H
	DjSDU1ByA9Vk10Mywce2ulOs4kLE7xl57lE67g6I/6egR/tLy2Rw6EHjcU75Roau+VZfpoROTSC
	Z7iEPG/w86rpEwAGnk8tl4A==
X-Google-Smtp-Source: AGHT+IEEjTpPYQzMBAhybW04MdjW8AF86rC0c7OtK7AUjaSX9oKv312D06txGG3KDB2dLThYbB5SuJMvIMPM40vk7Q==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6e02:1d88:b0:3a6:be9e:fb56 with
 SMTP id e9e14a558f8ab-3a6f1a44701mr21665ab.3.1731006263567; Thu, 07 Nov 2024
 11:04:23 -0800 (PST)
Date: Thu,  7 Nov 2024 19:03:31 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241107190336.2963882-1-coltonlewis@google.com>
Subject: [PATCH v7 0/5] Correct perf sampling with Guest VMs
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

v7:
* Refactor th misc_flags check in patch 4 and 5 for more clarity

v6:
https://lore.kernel.org/all/20241105195603.2317483-1-coltonlewis@google.com/

v5:
https://lore.kernel.org/all/20240920174740.781614-1-coltonlewis@google.com/

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
 arch/x86/events/core.c                       | 48 ++++++++++++--------
 arch/x86/include/asm/perf_event.h            | 12 +++--
 include/linux/perf_event.h                   | 26 +++++++++--
 kernel/events/core.c                         | 27 ++++++++++-
 15 files changed, 96 insertions(+), 99 deletions(-)


base-commit: 59b723cd2adbac2a34fc8e12c74ae26ae45bf230
--
2.47.0.277.g8800431eea-goog
