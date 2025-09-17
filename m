Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4440733EE1D
	for <linux-s390@vger.kernel.org>; Wed, 17 Sep 2025 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123549; cv=none; b=T8Dp8IdxNols0VR/WOKQ8+cGKmFfwd0HFeZWbWKM/sVG+628i+TFOjKeUbA6r0187aaw5htlMaBkMrywRYA4pVUjN5Hu0MbaajtEBpJfZ3fOw/EhLzeftoyjfX6MhJtfBTKXhZdKimmedvShiinSvJcAXRWVTer5hOJbzuBOkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123549; c=relaxed/simple;
	bh=a5bjwpxTd5MlEjoX9iDb8/uKmhaNxN8A6oQz06XSmCA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GGBMcTIrxRnnEmhM/ZDUMrc0YwqOS/UUzsBZ9GmMUcpFfNZ4TGTB5BWB3dsHGG5mPKfjbV6pAQPGVcK/dc+6lSFdeqNldRDEfPqj9BKlHru5h/wziHXbKhCA0bcLEFLoNOYyi/wTGkNa8AD3THKP2PCl+l3Lu11EFs9t8pUvWcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XyAkhkYv; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XyAkhkYv"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3ece1102998so575962f8f.2
        for <linux-s390@vger.kernel.org>; Wed, 17 Sep 2025 08:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758123545; x=1758728345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8OKQ5EvS5a+gZrJZA4QsnhZJV/o36dNUgSjCog+ZmUE=;
        b=XyAkhkYvKt++cfqrIJpNAvvui705g6zQqxUJTWBzxGpSnn/y+dlIf6GwVRXL6XPXmQ
         vdUeYeF6Uwr5WknfzIfD1DGjUDkbd4Anr9FFL2kMKG1tkBWSmaRzUUSxX83ZwrG0N2G1
         oRGlLcTh16zt7iEm2f0IsAuyPYDcYV3NDB+4mm1yX6KpM+EM24n1C+abOmmNILettiyy
         hTC/89aYdfRbBMWjlwR/jKaIE6LnF4oOJ+dgRqfzgSW59LycSl5ncjfAw0E/lDTjbBma
         mbJtl+GHzz2yV6PYVSrGdYHIkrBIB/TzjswQqbkTwVKyLvVSiMK6opweK+md71IlzdZE
         F8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123545; x=1758728345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8OKQ5EvS5a+gZrJZA4QsnhZJV/o36dNUgSjCog+ZmUE=;
        b=Nw1raQKjX4bLNUsh3Kgh1IFkaG/4rjVMBEiD6rDREUKsgVDh3sQ3SWcVPhDyMOVg2w
         JKFR7wHynsjvip63uJyfRM2qkV3tSjbw8E/BYYgj7sIc7CkWiflpaxIQ+ZlW9pG/+aSG
         XjeEQH+stK6o8Wow/S0BHMntcv2VZRa/AEgvtN9wBa0N0/+4XeLA36PLKNbavONyPjfF
         0e+pirRYgX/Xhk5jk9NYuqlKqjofoP7wlBzNQLunebtIRSW95ocZaeuYp/ifU1R6fFbW
         o+zyiHalb35t+/7z9lRLuCoKWFZ+ROSK3l39QlmUaR5VlDzATKBgwvIa+BuRovhToB4I
         GeLg==
X-Forwarded-Encrypted: i=1; AJvYcCWlvMAvZPksH9dJ6Of1o6UJePCBPGl6UimhJJDR8N1LlKjWhAVgEENiomzJprNdnAWMTlKtbN/mlKif@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/t+MYHE4io1YhkehpAES49Q1ba9nvxsrsCtqzMHol8+4EHq7Q
	0SleuGUhjRjskp9P3hoDvrevP1zXYpVjenp856E6mDgHEaaDOuC9l/b6YmU6/5rn5nw=
X-Gm-Gg: ASbGncvBZfEI5G7lbyHsCQGZ3P3w/vQEWF5QyjbVmrKgdYZ1sWVRD6mgfToia6msooy
	9pjF8qgi7QKsoc5eHWpjyU9QTCN0KFoR/V+79zbg/VAXxekG8xMaj7dFRLIvvpN4I6Xt6bm+6Fj
	1svobc9ffP6myc254SuPOAI1X+7cEmWuRDTCv7529hgkWw/MpaKsMnbbdmq9FXE45Td79xkIBpo
	jyLQIeyalLGsPPVk7GCuEGL/pn7XSPYgCoXHFUsWUOuXSL9BPSKqVg8VkWRghfhmWFR06VXfRE/
	1bnb5WL8Y6hDe5vFLcgtx+9fruGDTHsiEaWoyNsZ8QdOo2/tg/jiefzoP9Unj8VMv560uNR+NRo
	YZ2W12y8q5ttQtiGCKvsa4tGKNEsstrydybW4+vAK5cuK7Fs=
X-Google-Smtp-Source: AGHT+IHd7Kvdz/BCcMgbB466Jm/wCp1kzuvdKItEQjhl+8bjCb3QTRXBD5wNHBIkLdVzt5FZxRnMjg==
X-Received: by 2002:a05:6000:2511:b0:3e7:64c8:2dd6 with SMTP id ffacd0b85a97d-3ecdfa0b8dcmr1981118f8f.29.1758123545284;
        Wed, 17 Sep 2025 08:39:05 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e774a3fb5bsm23208319f8f.58.2025.09.17.08.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:39:04 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH v2 0/3] s390: replace wq users and add WQ_PERCPU to alloc_workqueue() users
Date: Wed, 17 Sep 2025 17:38:56 +0200
Message-ID: <20250917153859.363593-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi!

Below is a summary of a discussion about the Workqueue API and cpu isolation
considerations. Details and more information are available here:

        "workqueue: Always use wq_select_unbound_cpu() for WORK_CPU_UNBOUND."
        https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/

=== Current situation: problems ===

Let's consider a nohz_full system with isolated CPUs: wq_unbound_cpumask is
set to the housekeeping CPUs, for !WQ_UNBOUND the local CPU is selected.

This leads to different scenarios if a work item is scheduled on an isolated
CPU where "delay" value is 0 or greater then 0:
        schedule_delayed_work(, 0);

This will be handled by __queue_work() that will queue the work item on the
current local (isolated) CPU, while:

        schedule_delayed_work(, 1);

Will move the timer on an housekeeping CPU, and schedule the work there.

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

=== Plan and future plans ===

This patchset is the first stone on a refactoring needed in order to
address the points aforementioned; it will have a positive impact also
on the cpu isolation, in the long term, moving away percpu workqueue in
favor to an unbound model.

These are the main steps:
1)  API refactoring (that this patch is introducing)
    -   Make more clear and uniform the system wq names, both per-cpu and
        unbound. This to avoid any possible confusion on what should be
        used.

    -   Introduction of WQ_PERCPU: this flag is the complement of WQ_UNBOUND,
        introduced in this patchset and used on all the callers that are not
        currently using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a future release cycle.

        Most users don't need to be per-cpu, because they don't have
        locality requirements, because of that, a next future step will be
        make "unbound" the default behavior.

2)  Check who really needs to be per-cpu
    -   Remove the WQ_PERCPU flag when is not strictly required.

3)  Add a new API (prefer local cpu)
    -   There are users that don't require a local execution, like mentioned
        above; despite that, local execution yeld to performance gain.

        This new API will prefer the local execution, without requiring it.

=== Introduced Changes by this series ===

1) [P 1] add WQ_PERCPU to remaining alloc_workqueue() users

        Every alloc_workqueue() caller should use one among WQ_PERCPU or
        WQ_UNBOUND. WQ_PERCPU has been added to every user that is not
		actually using WQ_UNBOUND.

        WQ_UNBOUND will be removed in a next release cycle.

2) [P 2] Replace use of system_wq

        system_wq is a per-CPU workqueue, but his name is not clear.

        Because of that, system_wq has been renamed in system_percpu_wq.

3) [P 3] Replace use of system_wq with system_dfl_wq
			(arch/s390/kernel/hiperdispatch.c)

		 system_wq is a per-cpu wq but hiperdispatch users does not benefit
		 from it. This has been changed with system_dfl_wq (the new unbound wq).

Thanks!

---
Changes in v2:
- New in the series, 2/3: arch/s390/kernel/hiperdispatch.c does not benefit from
  system_wq: this has been converted directly to system_unbound_wq.
- the others system_wq users are converted to system_percpu_wq in patch 3/3


Marco Crivellari (3):
  drivers/s390: WQ_PERCPU added to alloc_workqueue users
  s390/diag324: replace use of system_wq with system_percpu_wq
  s390: replace use of system_wq with system_dfl_wq

 arch/s390/kernel/diag/diag324.c  | 4 ++--
 arch/s390/kernel/hiperdispatch.c | 2 +-
 drivers/s390/char/tape_3590.c    | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.51.0

