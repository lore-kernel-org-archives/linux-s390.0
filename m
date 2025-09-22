Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F658488;
	Mon, 22 Sep 2025 21:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575759; cv=none; b=IOI78EvWvDH9OfTnbBNtVJyYYZEsiZVLfz/NXIrk+NNznWzCslrJPisN6SARZwKaBJF4gG73GNS3w55JM3wBUOyQkM5uh63eye5etkaI7qOn46eWOb2k9Fm2l3D6uHEJ+26+3x9fEgj5S90vBNFCrcQVylahYoOolTpZJ+wnJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575759; c=relaxed/simple;
	bh=0f+HU8rkmCYG1sZJYp9ZwwL80qLFO7q25NMxY/lGCOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mUTlckwtm5UFTu0scBSritYTe9heVsSBS4xuC2jXPdlCFWCBRELj+cFNSYXT3FAWgfu0NV+I2Xpk0wIf+4JVtT+aNo5I4y1P2AolXd/cmihQ+wDO544fftj4aJh4hnHHT+N5FYxG9IQHo9QAERHpd/RrXEVk2B0JS/rZU4+yp8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQ0ssFa1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQ0ssFa1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56374C4CEF0;
	Mon, 22 Sep 2025 21:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758575759;
	bh=0f+HU8rkmCYG1sZJYp9ZwwL80qLFO7q25NMxY/lGCOs=;
	h=From:Date:Subject:To:Cc:From;
	b=RQ0ssFa1PbHhvxJtOZjrPqqNUH3K0ywAA5aQp6Rei5OeaSNxUtcqXnMsbUcA+q1MY
	 ZrEavVzTVO3StP72tm+3XBViqUxJYRrtkfGrJ4wcQrec6YTwR2Nn5f/+luxwJG4ZR8
	 uyxC7Z4xQyzel/cxEWVTr40CBa9GkKOqzYY1VheD3dSOUTNaKrc8Pucca+sVNOZPaJ
	 MUm0dvvNCS1Doo4NKEL8y/1C543UDOxQXX+XdFNH5+T69BJanfR9QfEsZLP3os/oc+
	 FiruQXP6OQNMFvxElq8AJ+OjjLgc+0x2yrPOqvj92dPp7A7O+LlMLyjqv3wiQz1fSC
	 2fTohxLLHkcyQ==
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 22 Sep 2025 14:15:50 -0700
Subject: [PATCH 6.6 ONLY] s390/cpum_cf: Fix uninitialized warning after
 backport of ce971233242b
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250922-6-6-s390-cpum_cf-fix-uninit-err-v1-1-5183aa9af417@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIW80WgC/x2NQQrCQAxFrzJkbSSd0rH1DKJrERFJU83CaclYE
 UrvbpC3evD4f4EiplJgHxYw+WjRMbtUmwD8vOeHoPbuECk21MWIySl1R8jT/LrxgIN+cc6a9Y1
 ihlRRu0tc903L4CuTiRf/hwukbQqn4+EM13X9AfbJf+17AAAA
X-Change-ID: 20250922-6-6-s390-cpum_cf-fix-uninit-err-010876c3d58c
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, linux-s390@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2822; i=nathan@kernel.org;
 h=from:subject:message-id; bh=0f+HU8rkmCYG1sZJYp9ZwwL80qLFO7q25NMxY/lGCOs=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDBkX9/RWd6w68DZiw5199rtjbl8pkGze42/C1L71p8erj
 sMVUkcNO0pZGMS4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBEHgoz/I+7rsrYZsjwUGkz
 k+B1U9OaRVrr57Dcyp30WCDTKHrq33CG/75CajyTk57N5FGecf7AU9nWd68lHMqWrd9skFm3oKN
 BhAkA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Upstream commit ce971233242b ("s390/cpum_cf: Deny all sampling events by
counter PMU"), backported to 6.6 as commit d660c8d8142e ("s390/cpum_cf:
Deny all sampling events by counter PMU"), implicitly depends on the
unconditional initialization of err to -ENOENT added by upstream
commit aa1ac98268cd ("s390/cpumf: Fix double free on error in
cpumf_pmu_event_init()"). The latter change is missing from 6.6,
resulting in an instance of -Wuninitialized, which is fairly obvious
from looking at the actual diff.

  arch/s390/kernel/perf_cpum_cf.c:858:10: warning: variable 'err' is uninitialized when used here [-Wuninitialized]
    858 |                 return err;
        |                        ^~~

Commit aa1ac98268cd ("s390/cpumf: Fix double free on error in
cpumf_pmu_event_init()") depends on commit c70ca298036c ("perf/core:
Simplify the perf_event_alloc() error path"), which is a part of a much
larger series unsuitable for stable.

Extract the unconditional initialization of err to -ENOENT from
commit aa1ac98268cd ("s390/cpumf: Fix double free on error in
cpumf_pmu_event_init()") and apply it to 6.6 as a standalone change to
resolve the warning.

Fixes: d660c8d8142e ("s390/cpum_cf: Deny all sampling events by counter PMU")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
This was reported on 6.1 and the offending commit was dropped but 6.6
suffered from the same issue (I am surprised LKFT's testing caught it in
the 6.1 case but not 6.6...):

https://lore.kernel.org/CADYN=9Li3gHMJ+weE0khMBmpS1Wcj-XaUeaUZg2Nxdz0qY9sdg@mail.gmail.com/

As it is already released, I figured I would just submit a fixup patch,
which could also be used to fix the issue in 6.1.
---
 arch/s390/kernel/perf_cpum_cf.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 771e1cb17540..e590b4c09625 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -852,7 +852,7 @@ static int cpumf_pmu_event_type(struct perf_event *event)
 static int cpumf_pmu_event_init(struct perf_event *event)
 {
 	unsigned int type = event->attr.type;
-	int err;
+	int err = -ENOENT;
 
 	if (is_sampling_event(event))	/* No sampling support */
 		return err;
@@ -861,8 +861,6 @@ static int cpumf_pmu_event_init(struct perf_event *event)
 	else if (event->pmu->type == type)
 		/* Registered as unknown PMU */
 		err = __hw_perf_event_init(event, cpumf_pmu_event_type(event));
-	else
-		return -ENOENT;
 
 	if (unlikely(err) && event->destroy)
 		event->destroy(event);

---
base-commit: af1544b5d072514b219695b0a9fba0b1e0d5e289
change-id: 20250922-6-6-s390-cpum_cf-fix-uninit-err-010876c3d58c

Best regards,
--  
Nathan Chancellor <nathan@kernel.org>

