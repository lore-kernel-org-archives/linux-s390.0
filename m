Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFC333B499
	for <linux-s390@vger.kernel.org>; Wed, 17 Sep 2025 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123551; cv=none; b=PAZNyOrNXVfC7IPOyPGNfjReesx4znnbVUAuF7RYWKaputVM9e14cDO1o8/3aFldWtLWr/K1Po/suy/S+QDWykJLim0s25/b5muf2DRJynRYhIzjDrSieldaLcKIjukh9To1NnEbkwIt5Pc43Pi44ew47IknXy0nNhmM2QHM10g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123551; c=relaxed/simple;
	bh=PFpgUHub9Fmrzg3KWGWHTh2JxvycLlcMGTk6OArN/BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lvgIWSkYbQdhqbVRKvubJ295JnPoY0YhpTkeNQ/cJStIy1xd2fgQWk3gDljmc7laaII6zd8etPEkCkkLrc651QNCy+5p4TxA4Zas13cTvWm6XnFkihmmcVfVH4fP54rNfkCWJ2ivK0unA5TwZ0R4YeRwlRa6XdbQgZ/VlCJ86B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FMWpqQNR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FMWpqQNR"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ed20bdfdffso299187f8f.2
        for <linux-s390@vger.kernel.org>; Wed, 17 Sep 2025 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758123547; x=1758728347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ugO1a/jnTXgfFN8ZtCaUDxIdkHkZGhM95Bkr0uu7zSk=;
        b=FMWpqQNRw1flZ8OPXoYkB4mcVE60DDpesxCaq8U7p1UszGFufAuXoDiuXgtVs1EncV
         37o2Q6b3k6s/rulDZX9SIodBuDWPr+n7Hkyi6SZfhMCP6nVYf1Z8jEoGkpQ/LX5Fydbc
         DHKMr0FzqVqDVdSnMlRSHhhZuLCYxhyHPEsr25cfX78yKZe0s12oDo5TgKwUXOzcizx4
         oJAP3BWHa0vc4aQ8tXPeUJC9I5lRBimFC36a7+EOs68SKVBvnsfgyMoKY8yQEv2dG0tU
         pVlNQTkiDs17U3pwJkQX4olokxnWiicg4LR30Xc196S8KBfO08v657Pu0Mr3z+8Hhlwo
         wxfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123547; x=1758728347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugO1a/jnTXgfFN8ZtCaUDxIdkHkZGhM95Bkr0uu7zSk=;
        b=OhWdlEsujh5v6NSKI2e7sLxdUGOlfHG0toKAYnVhwl+nV7A1OQBXjnzjf6qS6zEaX8
         GJZPZXNcd94c+JsQCCxlmRTpl3ctdWPImbgDIzHtUCIpBUZBC6iRkditIXnRupvJFKQ4
         CHc5EJRsw6ho/+slsiA2LH/R/WD09beu01Qnl/HaAAdCqqlJ/PvJijhStHnHmHUZ5MUj
         p8QiG6XHGu+AmG28T7yFIdlvgGipO4wRramkI/XrynWhxojEDJDcs5gGIoLtc5eOoQwy
         dzY+udszGnG8IvmsuEqTqwKRjI5DNWSR+oKVlaIYdaaspJMVU4ih0cFpk0u1/4KscP/t
         C1ag==
X-Forwarded-Encrypted: i=1; AJvYcCXf5plOhgVlhFAIXeWHeubgAKEtENZtoH8YaHvMSmO710Y7W8enMhq+bjhPtWiYppdIGduLdnaaS6LL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx16sMeAkI+GXXx7bGHiZ7PWjF+DiakJHBfjYG/twZhkWayGce/
	xEnwFhIfxPA9nBhmjf2C/igbaepbQf9R+5FI7R8Q9+4/iWLHfrOWH+SOFhqqxXxvUDw=
X-Gm-Gg: ASbGncsjNAH951mrGyImnz35BeQ7ttPHqW8PB02vLPNxyAO2ds1SPNCh8E54F8QsocH
	TGbYfWk5Msht/UbxcxMygsxFqOPa+zWMHec8KI3+DspZSJhI4MA7jTnEtcF0WJXoeDyohih0lUv
	tsseHvXLabzoD+MEwUTSuA3VaaIYcIox8No2LMFFivCP4s9tBfxVv9UtCnDAq24zqNvEjFE0V/L
	scDXnJd33zyP+aBEMN1Fo3CSh8x0EKpqQMD6PkBxzYOmUbm6hdIe0fHcqSdPF2Jw+OPO4JuMa3v
	nWKB2vbmfSuZ++xC7R7cUdv97/ANJhjI4JqSKcKd8Ev0LTTVRESTf1oYxWJjjiUj3I11mb2VaNi
	YFVilM8QkB59ojtO9/njsMODIgPYKBERmRCRy3qktWhLvip8=
X-Google-Smtp-Source: AGHT+IHD0ub/VA5RULYt1DM+OOxESsrSpInjb6TmYIn+FbY5msblQCDfU0OY3if9oubO64NJi4LszA==
X-Received: by 2002:a05:6000:40c8:b0:3d2:9cbf:5b73 with SMTP id ffacd0b85a97d-3ecdf9b5961mr2081818f8f.6.1758123547162;
        Wed, 17 Sep 2025 08:39:07 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e774a3fb5bsm23208319f8f.58.2025.09.17.08.39.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:39:06 -0700 (PDT)
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
Subject: [PATCH v2 2/3] s390/diag324: replace use of system_wq with system_percpu_wq
Date: Wed, 17 Sep 2025 17:38:58 +0200
Message-ID: <20250917153859.363593-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917153859.363593-1-marco.crivellari@suse.com>
References: <20250917153859.363593-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by renaming system_wq to system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 arch/s390/kernel/diag/diag324.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/diag/diag324.c b/arch/s390/kernel/diag/diag324.c
index 7fa4c0b7eb6c..f0a8b4841fb9 100644
--- a/arch/s390/kernel/diag/diag324.c
+++ b/arch/s390/kernel/diag/diag324.c
@@ -116,7 +116,7 @@ static void pibwork_handler(struct work_struct *work)
 	mutex_lock(&pibmutex);
 	timedout = ktime_add_ns(data->expire, PIBWORK_DELAY);
 	if (ktime_before(ktime_get(), timedout)) {
-		mod_delayed_work(system_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
+		mod_delayed_work(system_percpu_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
 		goto out;
 	}
 	vfree(data->pib);
@@ -174,7 +174,7 @@ long diag324_pibbuf(unsigned long arg)
 		pib_update(data);
 		data->sequence++;
 		data->expire = ktime_add_ns(ktime_get(), tod_to_ns(data->pib->intv));
-		mod_delayed_work(system_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
+		mod_delayed_work(system_percpu_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
 		first = false;
 	}
 	rc = data->rc;
-- 
2.51.0

