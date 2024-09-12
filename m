Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E937113CFB7
	for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2024 20:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726174298; cv=none; b=jAbr34CtiJiZW51hqRmdc5/nr4/49MVs0hdiiA/GO92IXqEG4HSLywgnCGndk30ikCQLi+4QbF3RGxR2WJeg6IJ9yAnUYY3HXhnNXbV7Ap/yToShO4BGHagDb5CcpUab+kmstOyV1utF+R73n9uhnjDE2qn5kiZvgH5Jqm/CcNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726174298; c=relaxed/simple;
	bh=MNxtXrr9QPAqRF21OcqTy6lGILMNbXhqSs9zqcWQea0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XTuld3c6m+J7q/R4cnOmpdQm7bkm4gzfZVoptCqW+BbnQwBIxeHIipMefdVoVU8yn6m7clj3TFIQCcyjzZUj9ieok1XktDuEtCYHxGM8au/RTD3IETXygbmIRU+0IVBPc6+In2o0Mo+BlPwHeOEILHHAiBZjIOblN1htp3+PpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VZhkDORo; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VZhkDORo"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1a8de19f7aso2720798276.3
        for <linux-s390@vger.kernel.org>; Thu, 12 Sep 2024 13:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726174296; x=1726779096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h7GxOQtGez9zo05dGUGsUVNGDqEVne28eAH8BDc6VWA=;
        b=VZhkDORo5AK4m1kNYdk8m8H5E6Vt6h/9xc/hQDywRzXOEGrVGX14DUe6cqepXUesfz
         1BeJEjjkBmBFh5SMpQ+6bOSxmTS++yHC2ln9e9qiIKSesofnOx+Hsvfil9lqBO/mThDa
         qLgHF1XrcFgukzFr6HmOQdW09JqWeXXDZiJg81/Y2Nbc0PF4mIwFDHMpZbsq4wePoWQ8
         h/Otudu+0J/s6sxIGsnlcVCj8KunyAfJAKTfP906KJ+WUyGUkOAKVDo5r5ksT1RyHOdV
         VuFnIq7xnJZ46xIDuMi1O847f4oMxDQR1m4lYnNO1iQX9PdJIN+0ZRTm+TS0LIi0ABnz
         wZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726174296; x=1726779096;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h7GxOQtGez9zo05dGUGsUVNGDqEVne28eAH8BDc6VWA=;
        b=DXjl5pYg/SknmI/SHwhsjV4UNF18gB23lO5IKG+XaTuH4C4Na07tXsltF6ygksFAid
         WfxSsC/pf1MhO+ymiIvPj92hhLkT3b4HZJ58UCRk9wBBtwIKFccbgT0phEJVWevE13jt
         FDha3stMhAIlU6Ve/vkik878m7Vq3u+AbtyeVskha5blubXZilnSnJGmtA2A+8ZPSBVa
         OwwbGHOpFysS8TUemVMaejunIies9ixjEcSByNDanLCEpEoS5k4ojwYCPEzfQL6Jctlz
         jjxmU/0FzU7fcMof5bHP6YqozYKCeplRvzzFYKzvJVKiQndBaeaePhl/+s29DPNYEIXo
         tB9Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7FG81QU2F6HuriDPL+GsDJGYS5RuBraB/FPMQJ5gxCdIrHqsnDP8if3/H+ZUAy6lbi0PPCKYKs+HM@vger.kernel.org
X-Gm-Message-State: AOJu0Yz72fMbixsSENJuZJWyqP9h5tDDUVJjxzwYTTm98wvn2RK9LE15
	jyOHWixCFE+GiPcsgi3wQIVCCvrlNRM+ktqW2C2TLiyNaYP7n5MI4dmfxk2dxIz5pmLuRhpGiii
	ngE7ct3kGDhdY3lQlnrjtfQ==
X-Google-Smtp-Source: AGHT+IEKK4aKpKiP70M1q7RoK97ftYvX/6/8VPxfOowbkLjsgUfLaXZWPQb4Cz0o8Wq45udLHTwqEBExFDGaaK+o3A==
X-Received: from coltonlewis-kvm.c.googlers.com ([fda3:e722:ac3:cc00:11b:3898:ac11:fa18])
 (user=coltonlewis job=sendgmr) by 2002:a05:6902:1781:b0:e1a:6eac:3d0f with
 SMTP id 3f1490d57ef6-e1d9dc419efmr6874276.8.1726174295745; Thu, 12 Sep 2024
 13:51:35 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:51:28 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.662.g92d0881bb0-goog
Message-ID: <20240912205133.4171576-1-coltonlewis@google.com>
Subject: [PATCH v3 0/5] Correct perf sampling with Guest VMs
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

v3:
  * Clarify final commit message further
  * Remove an unused variable in perf_arch_misc_flags()

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
2.46.0.662.g92d0881bb0-goog
