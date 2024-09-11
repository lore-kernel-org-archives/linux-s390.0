Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1631885A8
	for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2024 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726093513; cv=none; b=uF86COFNi1GCxz071b2d8EYX6apIcczJ0M+CG6Ylfy1XjotGo9Ee8oe0HRDci/7j59bix2SHUtE9qzH3ob8Ta3LUp7Bl/gjyabG+4JxoF/Z9+S6+x/KI3Y6eHohrJrAPrbGX4TpGnEoJV+/702WwjRGcwYyw/hpOeARz+44ZjK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726093513; c=relaxed/simple;
	bh=apDpA6syedftKsJ1hl/KzMx2AnXk35NohmXXBB9ax+I=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CZFzQtWNvK+JZiL9r/Yq6F0AmtLkbkw6zbFydBKt0Ssvbo4bbShME7vkaxw6zbiisdIpEn3L5TCZmwzM++8slKMOo9RIv/x81kyST2PX47XbSRpFjXfXy3q7J3tvghzzsotxLZy7Gj4zzTuFcUI9BOPpc+ifsX36zHlJazE8DF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HOy1YJRu; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HOy1YJRu"
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-3a05311890bso6841935ab.1
        for <linux-s390@vger.kernel.org>; Wed, 11 Sep 2024 15:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726093509; x=1726698309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T+nODGyulHWxs0JnvJus4UAc0zy0GDYGIyi7bhZj7WY=;
        b=HOy1YJRuzQW/LVF4I6oCukJ2FIc1dQVgT2CoPyp1gLaZ4q/lDZorR0SHgfAB2XhpaV
         3U8ZTLEOGuK5Vnrq4NFzCSiOBPaKIoILIRnHurwV8hp4bu86WhDzuthOCnkqBRnEI5FU
         LV+iJy5DwneWGhhEWN4y7iyQjc6HBRd0j7lwmChjkZwcMrApn8btIXdXnhBZIqCM7nZl
         dhYeXmsG9mWH9cCejrLj6HmC7XY1g9HWO87xzDSELebBh+qXM3I2jV/808E0DZyCkeBW
         mJeyG/sbH6rdvq7RsjttHqb0IOKL05krKgQQu3zbKohaLFdxs63u8/3alXdCveRxR2jH
         qYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726093509; x=1726698309;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T+nODGyulHWxs0JnvJus4UAc0zy0GDYGIyi7bhZj7WY=;
        b=Qy6wWc3ZoSoLX7KT8GnyZUJBlXb5J2LgQ5SkUv/xtiEgeUKyExmMBknZ6YP8WXBbN+
         IGzDX0sGiQL7ensPpFb0R27duHV+7+9nhHG4xSR/ehbDk79cQqhTA4oSwI/+P+o2rfYu
         YA71R/X+PwAvbrMALwD7GJ735P3gQNLUHhtUZ1uP1JED24/jjcsXr/SaHsd6fOyNPc4k
         BLt1mnoZ8e4OkGhcRNPlUeXIFGpFnnc811JohNg5A2b3YcvziaQKshfc7FxbYCHUuQuJ
         iJzmJqTcfTdvb4bIL92gcAyZJgMTn0/P20dcL/3t2+JFd209/A+8K19MYTHxlQsvhFMA
         uzdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVU3zyCiJ1ZqPfAkh1KQ9ljyAMn7fhSTEWE/OIzitXh1QybDSXOipOmnWPm36wHHDVQY8VGNUcsBid8@vger.kernel.org
X-Gm-Message-State: AOJu0YxTAhjlSYuD18JJLwn6/pr2o+zn4lsgoi5U+0MDFSk5gJBlh43y
	cOYdI7e5JCbOYGoKoHvZxOhqa1MihFuUqekE8E1NIO0WwCD0Pa2UBowChMoknlYeSz0yyZSGn24
	tyQXWe6hCFqpWp9PNcl7bXQ==
X-Google-Smtp-Source: AGHT+IGXXpOojFFO7Gu+zUTSei0211tStzLtWSxgCQLqddaqaDV88691OqMetcHXtFlM9KtKiGpFHXylg3PWPs5bQA==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6e02:2181:b0:3a0:80ae:71b6 with
 SMTP id e9e14a558f8ab-3a084976fe0mr327905ab.6.1726093509599; Wed, 11 Sep 2024
 15:25:09 -0700 (PDT)
Date: Wed, 11 Sep 2024 22:24:27 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
Message-ID: <20240911222433.3415301-1-coltonlewis@google.com>
Subject: [PATCH v2 0/5] Correct perf sampling with Guest VMs
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

v2:
  * Better explain commit messages
  * Fix incorrect type in patch 2
  * Fix missing argument in call to common_misc_flags() in patch 5
  * Rebase to 6.11-rc7 and include base commit in letter

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


base-commit: da3ea35007d0af457a0afc87e84fddaebc4e0b63
--
2.46.0.598.g6f2099f65c-goog
