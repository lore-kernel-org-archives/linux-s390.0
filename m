Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41F6390214;
	Wed,  7 Oct 2026 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362420; cv=none; b=DSW11ecpgcFKau8+LEn5w9DMJZOdqCBwPjqXg0U9BZUFHiTsS1wHPExIuzrMHMujZM6JbCrZJ3XrK6zkAE29IBdJCasxrmQ8OHtCaQJO+tXMa1oypKiXwwGw2hVwjvhMvERfYhzWpklsDg/t4/ZY5VERRm73amqIxo9/2VoWmcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362420; c=relaxed/simple;
	bh=PEVNK36szflynYRiFtJ8DSGqU/SUWUfhYjJ+ybQJOCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nCiT211s44qWzmING0O+rGRwuZBw5xmv/EHM03+QGHiN9bSVtkHQHIr4dxS0JbcqlNV2aRn2dtn4+to0HO8dU1eRACKmsFecNfw7Fn50f6tOpKbtq94xNt/uaEUBgdacqOFJind/YGi2habyy0AnzX80nok07NR4f05HfVv1f70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kb06nAOc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kb06nAOc"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69785t1D2036290;
	Wed, 7 Oct 2026 08:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ebMsP4e/AQ9DE+FcFrKyYmmWVKqe0JTWnM5KIJRIO
	Ng=; b=kb06nAOcok2STGKhQ+u8PD8aqwPPHqzhbTt7LlqDZ7IySNIsDqHVk1WvM
	Q/fqqMOCmTGYA62l0ElZTYsU7WrMRWaN7Ht7ZaH3XucMol5937gUQt34fzeufmTY
	DYLGWKL5FNhq5+18Ew7+zJQwTOLzTeJnhdqZdiiTpWD5WUibgCwzRdUeqR3QjwoF
	X+kQmGamwDSheixb2fFLuB2EIBSyRGeS2tnSZn2q1F1pfKJtwNz879X0Oh5/T3cg
	tM+MZOaQC/U6+pcsMmj5j0eFRXaUDS0sjlYlM/wCXqmn7PzVSwsNgaKekgPSG/63
	i2YUjsFpIdkUgtYPZNjyxOstnUeng==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74vhdr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 08:40:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6977lVYa317047;
	Wed, 7 Oct 2026 08:40:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3trr9y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 08:40:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6978e1FG46465492
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 08:40:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F8442004E;
	Wed,  7 Oct 2026 08:40:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B91E320040;
	Wed,  7 Oct 2026 08:40:00 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed,  7 Oct 2026 08:40:00 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 56341)
	id 93996160E2A; Wed, 07 Oct 2026 10:40:00 +0200 (CEST)
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
To: mcgrof@kernel.org, petr.pavlu@suse.com, da.gomez@kernel.org,
        samitolvanen@google.com, atomlin@atomlin.com
Cc: linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, pasic@linux.ibm.com,
        =wintera@linux.ibm.com, Mahanta Jambigi <mjambigi@linux.ibm.com>
Subject: [PATCH] module: drain external refs before freeing a failed-init module
Date: Wed,  7 Oct 2026 10:39:56 +0200
Message-ID: <20261007083956.2488796-1-mjambigi@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: cA-hoxSmlQctmK6pgx3RulaMIQivw5QE
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzNCBTYWx0ZWRfX+dOC4PhozQ+m
 CwhOyINgjOw+jQCsy7G8Ctkj2kkWg+p9Saa4EU3sT5nta3i3NEl6JziHaDUlw08fTPVEMAX+2pn
 kXFr/JsaBdf76zh02RysomwIliRbQzY=
X-Proofpoint-GUID: S11_yxpFfkzfoZeSiWiwHkWZPnSHjAOl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzNCBTYWx0ZWRfX2v+/kIf9sPXS
 4iEEwpmA1SrzxKvW32qkxING4DNX5ZNMF+/yLc2/vUlwOd+n+WnKsuhVcIqXeOOGdskTvybD+J2
 EIu5NoP4eQJMbYf1eE7tFxcQveQavbuI6fL40mQ5UVad0vJGzm2qRPb0CDCKtEohwPvMJsPLuNa
 b4BzsU5MzEUluw5FaHY7Hp7v0Tw+wGO31f2kK1xCiT0jGTIPlDWDTjq3sdCnjpU5LTFIpzCYwrb
 ZMXcktFkL30jo4uLiwUxODcIiQwC5RqvyjcxcaCUhi/o28K1GAplsLsvCE/MzYRHV7ECaQi2Mof
 sExCsH4am1oGknD1lRJriyMhNYheMr+qvfiNA6Mm0EvgMHGinhSfHhC1SRty33zSvw7XyD+GOLO
 7IolCJMLJei0czOKP5XyOGdB136xpdRZtgEj9nE47BaVWn2KjcSffiB5IAn49XxRZGiUkNukjpL
 PHXX5lRvtkb1wbKiOuw==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac6056a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=HH9Xvdc2fvVvpujcZ5oA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070034

When a module's __init makes it externally reachable (e.g. by registering=
 a
protocol family or a bus driver) and a later __init step fails, do_init_m=
odule()
frees the module while callers that entered through that interface and ca=
lled
try_module_get() may still be executing module text.

The normal unload path in try_stop_module() refuses to proceed while
module_refcount() is non-zero. The init-failure path has no such check an=
d races
to free_module() immediately after synchronize_rcu().

Fix it by waiting for all external references to drain before calling
free_module(). Add a per-module struct completion refs_gone inside the ex=
isting
CONFIG_MODULE_UNLOAD block that is initialised in module_unload_init() an=
d
completed from module_put() when refcnt drops back to MODULE_REF_BASE and=
 the
module state is MODULE_STATE_GOING. The fail: path calls wait_for_complet=
ion()
(guarded by the same #ifdef) after dropping the loader's own reference,
replacing the previous implicit assumption that no external refs exist at=
 that
point.

Also move wake_up_all(&module_wq) to before the drain so that concurrent =
loaders
blocked in module_patient_check_exists() are unblocked immediately once
MODULE_STATE_GOING is visible, rather than after the drain completes.

Fixes: 1fb9341ac348 ("module: put modules in list much earlier.")
Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
---
Link: https://lore.kernel.org/all/5dc1fe2b-289e-4786-b9e9-e181dda8d4e9@li=
nux.ibm.com/
      [RFC] module: init-failure path can free a module with live
      try_module_get() users

 include/linux/module.h |  2 ++
 kernel/module/main.c   | 33 +++++++++++++++++++++++++++-----
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 96cc98568eea..0dee2ed02a2d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -562,6 +562,8 @@ struct module {
 	void (*exit)(void);

 	atomic_t refcnt;
+	/* Completed when refcnt drops to MODULE_REF_BASE on init failure. */
+	struct completion refs_gone;
 #endif

 #ifdef CONFIG_CONSTRUCTORS
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c1b34dc1e89a..655c693bd8e2 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -655,6 +655,7 @@ static int module_unload_init(struct module *mod)
 	 * refcnt =3D=3D 0 means module is going.
 	 */
 	atomic_set(&mod->refcnt, MODULE_REF_BASE);
+	init_completion(&mod->refs_gone);

 	INIT_LIST_HEAD(&mod->source_list);
 	INIT_LIST_HEAD(&mod->target_list);
@@ -956,6 +957,14 @@ void module_put(struct module *module)
 		ret =3D atomic_dec_if_positive(&module->refcnt);
 		WARN_ON(ret < 0);	/* Failed to put refcount */
 		trace_module_put(module, _RET_IP_);
+		/*
+		 * If refcnt just dropped to MODULE_REF_BASE and the module is going
+		 * away due to an init failure, all external references are gone. Wake
+		 * any thread waiting in the init-failure drain path.
+		 */
+		if (ret =3D=3D MODULE_REF_BASE &&
+		    module->state =3D=3D MODULE_STATE_GOING)
+			complete(&module->refs_gone);
 	}
 }
 EXPORT_SYMBOL(module_put);
@@ -3206,16 +3214,36 @@ static noinline int do_init_module(struct module =
*mod)
 fail_free_freeinit:
 	kfree(freeinit);
 fail:
-	/* Try to protect us from buggy refcounters. */
 	mod->state =3D MODULE_STATE_GOING;
 	synchronize_rcu();
+
+	/*
+	 * Unblock concurrent loaders waiting in module_patient_check_exists() =
on
+	 * module_wq. finished_loading() returns true once state is GOING, so t=
hey
+	 * can now proceed. Do this before the drain below so a failed init del=
ays
+	 * only this task, not every other loader that raced to load the same
+	 * module.
+	 */
+	wake_up_all(&module_wq);
+
+	/* Drop the loader's own reference taken in module_unload_init(). */
 	module_put(mod);
+
+#ifdef CONFIG_MODULE_UNLOAD
+	/*
+	 * Wait for all external references taken before MODULE_STATE_GOING bec=
ame
+	 * visible to be released. module_put() completes refs_gone when refcnt
+	 * drops to MODULE_REF_BASE. The hung-task detector will catch any modu=
le
+	 * whose error path leaks a reference.
+	 */
+	wait_for_completion(&mod->refs_gone);
+#endif
+
 	blocking_notifier_call_chain(&module_notify_list,
 				     MODULE_STATE_GOING, mod);
 	klp_module_going(mod);
 	ftrace_release_mod(mod);
 	free_module(mod);
-	wake_up_all(&module_wq);

 	return ret;
 }
--=20
2.43.7
