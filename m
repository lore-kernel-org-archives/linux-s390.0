Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36DA214813
	for <linux-s390@vger.kernel.org>; Sun,  3 May 2026 00:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777767792; cv=none; b=nFaSpoeD1xAcFs61nXrrPAkfzghpj4dl+gccRsTVxmLuYMw0jJoDyfDBr1MUKDGGVBrxdU3ko0MnyfI2NpjWf9VKPRgniZwVjtfpmo8epR6CXxZNNepb5vqP2Rf1xKEOzso6eUuZn8Gwz2eEWW9mV3do7p5FEDkTVbnHj7VIKL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777767792; c=relaxed/simple;
	bh=AU7EKzo/kXrsAjfgR40n40MqM3yvsMJ1cD4bHl4i3uU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sk+k6c7lsb6n/atZGA3Djn9+aq/4mCzYmar/Bomrzq6HHq6kJLQhC52mnEBErdq5d0A34zYUtO5gud+e/ja5Im/w9uj1GmEYISYGWTlojJCIzlhKwbX7AQdNXLy9IqnWYhzpG0SPXeiaJyApQDHqIupT0/xNahYGhe41Cgfmcgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vT6C4J10; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vT6C4J10"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dbf4f678eso16486194c88.0
        for <linux-s390@vger.kernel.org>; Sat, 02 May 2026 17:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777767785; x=1778372585; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mje3fRK1Ca3WEYFTmWriS1ZD47KIvC5apYOlB73RA4c=;
        b=vT6C4J10HPbUjs0bkIL076r272onB7owiR2QoBkiuSqR+dNTQDR+qrFQNbWxXTq79I
         RYJy07r803GihksM6UlqxPRpqOZTjZjnxRY8gdIO4bHSpc3nDAhucfzSnCer1TzNpitu
         Qs+DLPrPiO91LkXMWSQPBTlh2+99nddaorovVe3Mu+vi8RaQ8BbQ26GWzstXsGp2Af2x
         CFOc1m7GbQWnSJ/bSq231hR7lqiBSGzXVFtDUFZyVx29I+NTAscJ+SlCPB5z7juy0AZB
         LqVw1YQR9j4T0rrwe9KloahPdPmkjeDak1IrMftf6LwsWM/3PgnJi4u+2eisQRXjnMNc
         BW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777767785; x=1778372585;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mje3fRK1Ca3WEYFTmWriS1ZD47KIvC5apYOlB73RA4c=;
        b=XAVMF4dps0L1B2IF+XUei0KyOvxWrtXfthlRuWpXO34lEXo6fBOU68C91jb2qJCOWx
         iQDrbGMkTXQ7AVrKiT6jMplHkCnwbs5+7vLnXj1WpqAx0eDKbGAeCTiVWrN0m9k7gRzb
         LKinj41upINDL0lE1PTVyZNEwPRNQfLzK1gCVSnX5fYOK2CXR/qeIwAG76azC/yOTKtr
         5PfwSg5qQRSQoH9vStyD/VmBZUET8u/faXwWexkWmirS/6K7MORpBkW+GO5P4Gqkbetm
         zEm07ZBqrJs/qYEuBkqp5gtuwmh5oiNa0Fc9vBqCCILJwyc8i00a2jDiP3v6VDrWl4oq
         TU6w==
X-Forwarded-Encrypted: i=1; AFNElJ8UdfkCt2++AkWdCcWFPdSI+1qMRcm8iEzW9ArG0EG6uLJaCn/CQUIVKg78HVwoRXknxIhsoJB4jN8V@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1nf9iJPhy5EFRYBj4paqP2mfg7PMThgKGXuAblzOHf4PpFV99
	hH+gY5FMEJ6AscEnDT+mBZcq1eKvBgYi6mqKoPQPoEOdGVduXAtm1ZmVjCpBgm6XC3qjBL4OpVb
	s3GipbyDjYA==
X-Received: from dlbsv4.prod.google.com ([2002:a05:7022:3a04:b0:12d:b86f:f7a6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fe05:b0:12d:b28e:75b1
 with SMTP id a92af1059eb24-12dfd81a89fmr1953500c88.22.1777767784628; Sat, 02
 May 2026 17:23:04 -0700 (PDT)
Date: Sat,  2 May 2026 17:22:36 -0700
In-Reply-To: <20260503002248.1040791-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260502065935.291960-1-irogers@google.com> <20260503002248.1040791-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503002248.1040791-7-irogers@google.com>
Subject: [PATCH v9 06/18] perf symbol: Avoid use of machine__is
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org, 
	tmricht@linux.ibm.com
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com, 
	jameshongleiwang@126.com, japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-s390@vger.kernel.org, 
	sumanthk@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Switch to using the ELF machine from the dso or running machine rather
than the machine perf_env arch that may fall back on EM_HOST. This
also avoids potentially imprecise string comparisons.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index fcaeeddbbb6b..a4b1f837a5a5 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -851,6 +851,23 @@ static int maps__split_kallsyms_for_kcore(struct maps *kmaps, struct dso *dso)
 	return count;
 }
 
+static uint16_t machine_or_dso_e_machine(struct machine *machine, struct dso *dso)
+{
+	uint16_t e_machine = EM_NONE;
+	/* DSO should be most accurate */
+	if (dso)
+		e_machine = dso__e_machine(dso, machine, /*e_flags=*/NULL);
+
+	if (e_machine != EM_NONE)
+		return e_machine;
+
+	/* Check the global environment next. */
+	if (machine && machine->env && machine->env->e_machine != EM_NONE)
+		return machine->env->e_machine;
+
+	return perf_env__e_machine(machine ? machine->env : NULL, /*e_flags=*/NULL);
+}
+
 /*
  * Split the symbols into maps, making sure there are no overlaps, i.e. the
  * kernel range is broken in several maps, named [kernel].N, as we don't have
@@ -866,14 +883,13 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 	struct rb_root_cached *root = dso__symbols(dso);
 	struct rb_node *next = rb_first_cached(root);
 	int kernel_range = 0;
-	bool x86_64;
+	uint16_t e_machine = EM_NONE;
 
 	if (!kmaps)
 		return -1;
 
 	machine = maps__machine(kmaps);
-
-	x86_64 = machine__is(machine, "x86_64");
+	e_machine = machine_or_dso_e_machine(machine, dso);
 
 	while (next) {
 		char *module;
@@ -925,7 +941,7 @@ static int maps__split_kallsyms(struct maps *kmaps, struct dso *dso, u64 delta,
 			 */
 			pos->start = map__map_ip(curr_map, pos->start);
 			pos->end   = map__map_ip(curr_map, pos->end);
-		} else if (x86_64 && is_entry_trampoline(pos->name)) {
+		} else if (e_machine == EM_X86_64 && is_entry_trampoline(pos->name)) {
 			/*
 			 * These symbols are not needed anymore since the
 			 * trampoline maps refer to the text section and it's
@@ -1428,7 +1444,7 @@ static int dso__load_kcore(struct dso *dso, struct map *map,
 		free(new_node);
 	}
 
-	if (machine__is(machine, "x86_64")) {
+	if (machine_or_dso_e_machine(machine, dso) == EM_X86_64) {
 		u64 addr;
 
 		/*
@@ -1716,7 +1732,7 @@ int dso__load(struct dso *dso, struct map *map)
 			ret = dso__load_guest_kernel_sym(dso, map);
 
 		machine = maps__machine(map__kmaps(map));
-		if (machine__is(machine, "x86_64"))
+		if (machine_or_dso_e_machine(machine, dso) == EM_X86_64)
 			machine__map_x86_64_entry_trampolines(machine, dso);
 		goto out;
 	}
-- 
2.54.0.545.g6539524ca2-goog

