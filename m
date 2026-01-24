Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E08233721
	for <linux-s390@vger.kernel.org>; Sat, 24 Jan 2026 05:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769233321; cv=none; b=ZuBrcpBFqBEMJRnETfYsFMtbQAfLkikOMRSOeAzsMbiJ8Y381Wt2arnUXd5d7H/hfqoR7jJBNVX8a+tIAl4jyuv8D/ohI84lFj7TMvY05+aHAH+I6S+eD2yKDRVX+ahzl1VUq0Wk30p4yw7uR5ADGTNP6QoRoVzoqg0RdjM+HzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769233321; c=relaxed/simple;
	bh=Trz4KH7SRRsjp59mbGLum+zU8PGBK7l1ETvVZeOaQ7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uyjeA5Bijx5/EhX6Fao5fpLam9IaIGmJ8WcbtWfmZiNCGzmV4xmUOYz4118zRShg05BboW1wGhdfKUf/QS5ODVAMht17U1CkZgLq48hBSlYRS7bWLgizp/2dWXwSHtesrV8LFUjCs5jbu4720ocMrKIWniEQZ/e+ia6CEJ+aqYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bf6YIIUa; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bf6YIIUa"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29efd139227so20780685ad.1
        for <linux-s390@vger.kernel.org>; Fri, 23 Jan 2026 21:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769233319; x=1769838119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=V3JkJCi/BPVR8+u1DbgLowMn18CQEBQmlg70z/avGY0=;
        b=Bf6YIIUaau5WazQ7DDFPUF+2MNbinN++jKk6Scz0hdnPbhm5+B1tS5SxdzlWU3toeM
         XWYvLOW6RcQxDZlvEzCgEx3FIbVirLmsEg1tmM2BUPyZnavuNcwmSjfB96EdovpLB+FK
         NwOfzktDrnzam92VlUTtgRR8KyfNk21TMYJX+UFod3ky16l2OXwHZzWCSSCqR7vWQNn0
         dBTSw7lxEQntWgUUgYO33RgMKQK2zjCI1MKhs6JnGzSpdYxE8tRyemR4mchi1qpMM5Vr
         fWLq4V4bD3Cm8Nky/IZC2BAJmcCygygVOjprPb4tLIa7ebfRGKCFhOc1CPCuUMDKn23s
         9YIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769233319; x=1769838119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3JkJCi/BPVR8+u1DbgLowMn18CQEBQmlg70z/avGY0=;
        b=j9rGU2VzXgZrBkhOGbavO5s/Vgvtxj0B3it7Ze2y+fsc+5tW1j7Uby9gEOHO75+dxM
         Hv98K1HuKvtkbYQFZtTV4sXNJP2H7P0Hp0gEUT+HODaZJdIkmUWmt2X7ZJS9dZf4FQup
         mQ9L4asYuhtuBc6P08NBZVGSLAx+9qM+UaVi8LkT5sGcPLgzEsXj5nughrB4n1tLXWhh
         Sf/4/+AOBhykMVk+ynp8Lj0DXDpMPM0n3EtxzA0VR8jWj6ZNFIT1mkxqN5cjMWaxEAn0
         u2WOOzQcBo3v26KHS9FNWN8FX4JcqhGzN1Wh337fuLWjgeWcgvYEb5Sedy1EySWUr/hZ
         unLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWpSrLJdmvKqg2f/9OIwVvrT3130YlW8ABuAjdT3Cu7cOTkHLP3Mp5UKQv+GmHQLfjebZLNI28wWMW@vger.kernel.org
X-Gm-Message-State: AOJu0YzuU+TH6iz5GORZ6PoRD8iyICybuF4xz9056sLs2UogtVOqEekQ
	sSTDJ9gMMA6jrxlqbQfAnvLtQm/BgGlbt5I1bQQgZsPA+98pTvBaED9c
X-Gm-Gg: AZuq6aKSDVYfsoKbpa76a+akg3cz9ey9APw94qx/jfddJKK2Xf33oZa+yl7Cm9eUVS8
	gyBc7KHvkeIuBnK6f6R5QxMVQNMfVLb+FAMOkZUKXlYQ8mhkp0r1QeJLr3FgISa7SWKyZcSrTss
	kU9mN8ZeV907F2VRGaNj088kl6bOxL+ezPAZN1ke8bv/YPTgFxptiuFx2YuiQtFC96EwPmuPl52
	ycF5UEmWnaF4UPtj6jPozCsVq5IqZWpnIGiidjXoU09KC+RQ8SSN/feitEiNDoFryxwmioaSgwS
	ZG2g0kZf2I5lmDnM+uNv9h2HzAE/PylDHH8iQ+DMCTCMBd16NfCnK+FNr89piyMnW2y9Rbk5yqE
	dGN19emuLxLKjSdvc5Bips2waEOC4v3t6nll4QlZ4ireWGh4K8OWSZNCralnog1BTnPF2ZY0jH0
	fkzKyb6QHOL9FitbzuqGBHnQyHuG7IWYefXmXld7M0n8LGprEuT5+IJjFrVxF72lA7bLYJn9Tr
X-Received: by 2002:a17:902:da8d:b0:2a7:bd4e:db92 with SMTP id d9443c01a7336-2a7fe75599dmr47829875ad.53.1769233318702;
        Fri, 23 Jan 2026 21:41:58 -0800 (PST)
Received: from kirchou-macbookpro2.roam.corp.google.com ([2001:268:99e8:2043:d1af:8ab1:2bc:1f3b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a802fb134csm34085495ad.87.2026.01.23.21.41.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jan 2026 21:41:57 -0800 (PST)
Sender: kir <610548@gmail.com>
From: Kir Chou <note351@hotmail.com>
To: akpm@linux-foundation.org
Cc: davidgow@google.com,
	geert@linux-m68k.org,
	visitorckw@gmail.com,
	brendan.higgins@linux.dev,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Kir Chou <note351@hotmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-s390@vger.kernel.org (open list:S390 ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list),
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
Subject: [PATCH] lib/random32: convert selftest to KUnit
Date: Sat, 24 Jan 2026 14:41:33 +0900
Message-ID: <20260124054134.71369-1-note351@hotmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch converts the existing prandom selftest (lib/random32.c) to use
the KUnit framework (lib/tests/random32_kunit.c). Unlike typical KUnit
tests, this file is directly #included into lib/random32.c.

Only the file name "random32_kunit.c" keeps random32, "prandom" is used
for all other places for aligning with the API semantics and avoiding
confusion with the cryptographically secure random.c,

The new test:
- Removes the legacy CONFIG_RANDOM32_SELFTEST.
- Adds CONFIG_PRANDOM_KUNIT_TEST (defaulting to KUNIT_ALL_TESTS).
- Moves the test logic to lib/tests/random32_kunit.c.
- Updates arch/s390/configs/debug_defconfig to use the new KUnit symbol.

This commit is verified by `./tools/testing/kunit/kunit.py run`
with the .kunit/.kunitconfig:

```
CONFIG_KUNIT=y
CONFIG_PRANDOM_KUNIT_TEST=y
```

Signed-off-by: Kir Chou <note351@hotmail.com>
---
 arch/s390/configs/debug_defconfig |   2 +-
 lib/Kconfig.debug                 |  12 +++
 lib/random32.c                    | 173 +----------------------------
 lib/tests/random32_kunit.c        | 174 ++++++++++++++++++++++++++++++
 4 files changed, 189 insertions(+), 172 deletions(-)
 create mode 100644 lib/tests/random32_kunit.c

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 0713914b2..6e8e3772c 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -827,7 +827,7 @@ CONFIG_CRYPTO_KRB5=m
 CONFIG_CRYPTO_KRB5_SELFTESTS=y
 CONFIG_CORDIC=m
 CONFIG_TRACE_MMIO_ACCESS=y
-CONFIG_RANDOM32_SELFTEST=y
+CONFIG_PRANDOM_KUNIT_TEST=y
 CONFIG_XZ_DEC_MICROLZMA=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=0
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ba36939fd..b4df466c2 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3354,6 +3354,18 @@ config PRIME_NUMBERS_KUNIT_TEST
 
 	  If unsure, say N
 
+config PRANDOM_KUNIT_TEST
+	tristate "KUnit test for prandom" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Enable this option to test the prandom functions at runtime.
+
+	  This test suite verifies the correctness of the pseudo-random number
+	  generator across various scenarios, including edge cases.
+
+	  If unsure, say N
+
 endif # RUNTIME_TESTING_MENU
 
 config ARCH_USE_MEMTEST
diff --git a/lib/random32.c b/lib/random32.c
index 24e7acd93..0aab36792 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -126,175 +126,6 @@ void prandom_seed_full_state(struct rnd_state __percpu *pcpu_state)
 }
 EXPORT_SYMBOL(prandom_seed_full_state);
 
-#ifdef CONFIG_RANDOM32_SELFTEST
-static struct prandom_test1 {
-	u32 seed;
-	u32 result;
-} test1[] = {
-	{ 1U, 3484351685U },
-	{ 2U, 2623130059U },
-	{ 3U, 3125133893U },
-	{ 4U,  984847254U },
-};
-
-static struct prandom_test2 {
-	u32 seed;
-	u32 iteration;
-	u32 result;
-} test2[] = {
-	/* Test cases against taus113 from GSL library. */
-	{  931557656U, 959U, 2975593782U },
-	{ 1339693295U, 876U, 3887776532U },
-	{ 1545556285U, 961U, 1615538833U },
-	{  601730776U, 723U, 1776162651U },
-	{ 1027516047U, 687U,  511983079U },
-	{  416526298U, 700U,  916156552U },
-	{ 1395522032U, 652U, 2222063676U },
-	{  366221443U, 617U, 2992857763U },
-	{ 1539836965U, 714U, 3783265725U },
-	{  556206671U, 994U,  799626459U },
-	{  684907218U, 799U,  367789491U },
-	{ 2121230701U, 931U, 2115467001U },
-	{ 1668516451U, 644U, 3620590685U },
-	{  768046066U, 883U, 2034077390U },
-	{ 1989159136U, 833U, 1195767305U },
-	{  536585145U, 996U, 3577259204U },
-	{ 1008129373U, 642U, 1478080776U },
-	{ 1740775604U, 939U, 1264980372U },
-	{ 1967883163U, 508U,   10734624U },
-	{ 1923019697U, 730U, 3821419629U },
-	{  442079932U, 560U, 3440032343U },
-	{ 1961302714U, 845U,  841962572U },
-	{ 2030205964U, 962U, 1325144227U },
-	{ 1160407529U, 507U,  240940858U },
-	{  635482502U, 779U, 4200489746U },
-	{ 1252788931U, 699U,  867195434U },
-	{ 1961817131U, 719U,  668237657U },
-	{ 1071468216U, 983U,  917876630U },
-	{ 1281848367U, 932U, 1003100039U },
-	{  582537119U, 780U, 1127273778U },
-	{ 1973672777U, 853U, 1071368872U },
-	{ 1896756996U, 762U, 1127851055U },
-	{  847917054U, 500U, 1717499075U },
-	{ 1240520510U, 951U, 2849576657U },
-	{ 1685071682U, 567U, 1961810396U },
-	{ 1516232129U, 557U,    3173877U },
-	{ 1208118903U, 612U, 1613145022U },
-	{ 1817269927U, 693U, 4279122573U },
-	{ 1510091701U, 717U,  638191229U },
-	{  365916850U, 807U,  600424314U },
-	{  399324359U, 702U, 1803598116U },
-	{ 1318480274U, 779U, 2074237022U },
-	{  697758115U, 840U, 1483639402U },
-	{ 1696507773U, 840U,  577415447U },
-	{ 2081979121U, 981U, 3041486449U },
-	{  955646687U, 742U, 3846494357U },
-	{ 1250683506U, 749U,  836419859U },
-	{  595003102U, 534U,  366794109U },
-	{   47485338U, 558U, 3521120834U },
-	{  619433479U, 610U, 3991783875U },
-	{  704096520U, 518U, 4139493852U },
-	{ 1712224984U, 606U, 2393312003U },
-	{ 1318233152U, 922U, 3880361134U },
-	{  855572992U, 761U, 1472974787U },
-	{   64721421U, 703U,  683860550U },
-	{  678931758U, 840U,  380616043U },
-	{  692711973U, 778U, 1382361947U },
-	{  677703619U, 530U, 2826914161U },
-	{   92393223U, 586U, 1522128471U },
-	{ 1222592920U, 743U, 3466726667U },
-	{  358288986U, 695U, 1091956998U },
-	{ 1935056945U, 958U,  514864477U },
-	{  735675993U, 990U, 1294239989U },
-	{ 1560089402U, 897U, 2238551287U },
-	{   70616361U, 829U,   22483098U },
-	{  368234700U, 731U, 2913875084U },
-	{   20221190U, 879U, 1564152970U },
-	{  539444654U, 682U, 1835141259U },
-	{ 1314987297U, 840U, 1801114136U },
-	{ 2019295544U, 645U, 3286438930U },
-	{  469023838U, 716U, 1637918202U },
-	{ 1843754496U, 653U, 2562092152U },
-	{  400672036U, 809U, 4264212785U },
-	{  404722249U, 965U, 2704116999U },
-	{  600702209U, 758U,  584979986U },
-	{  519953954U, 667U, 2574436237U },
-	{ 1658071126U, 694U, 2214569490U },
-	{  420480037U, 749U, 3430010866U },
-	{  690103647U, 969U, 3700758083U },
-	{ 1029424799U, 937U, 3787746841U },
-	{ 2012608669U, 506U, 3362628973U },
-	{ 1535432887U, 998U,   42610943U },
-	{ 1330635533U, 857U, 3040806504U },
-	{ 1223800550U, 539U, 3954229517U },
-	{ 1322411537U, 680U, 3223250324U },
-	{ 1877847898U, 945U, 2915147143U },
-	{ 1646356099U, 874U,  965988280U },
-	{  805687536U, 744U, 4032277920U },
-	{ 1948093210U, 633U, 1346597684U },
-	{  392609744U, 783U, 1636083295U },
-	{  690241304U, 770U, 1201031298U },
-	{ 1360302965U, 696U, 1665394461U },
-	{ 1220090946U, 780U, 1316922812U },
-	{  447092251U, 500U, 3438743375U },
-	{ 1613868791U, 592U,  828546883U },
-	{  523430951U, 548U, 2552392304U },
-	{  726692899U, 810U, 1656872867U },
-	{ 1364340021U, 836U, 3710513486U },
-	{ 1986257729U, 931U,  935013962U },
-	{  407983964U, 921U,  728767059U },
-};
-
-static void prandom_state_selftest_seed(struct rnd_state *state, u32 seed)
-{
-#define LCG(x)	 ((x) * 69069U)	/* super-duper LCG */
-	state->s1 = __seed(LCG(seed),        2U);
-	state->s2 = __seed(LCG(state->s1),   8U);
-	state->s3 = __seed(LCG(state->s2),  16U);
-	state->s4 = __seed(LCG(state->s3), 128U);
-}
-
-static int __init prandom_state_selftest(void)
-{
-	int i, j, errors = 0, runs = 0;
-	bool error = false;
-
-	for (i = 0; i < ARRAY_SIZE(test1); i++) {
-		struct rnd_state state;
-
-		prandom_state_selftest_seed(&state, test1[i].seed);
-		prandom_warmup(&state);
-
-		if (test1[i].result != prandom_u32_state(&state))
-			error = true;
-	}
-
-	if (error)
-		pr_warn("prandom: seed boundary self test failed\n");
-	else
-		pr_info("prandom: seed boundary self test passed\n");
-
-	for (i = 0; i < ARRAY_SIZE(test2); i++) {
-		struct rnd_state state;
-
-		prandom_state_selftest_seed(&state, test2[i].seed);
-		prandom_warmup(&state);
-
-		for (j = 0; j < test2[i].iteration - 1; j++)
-			prandom_u32_state(&state);
-
-		if (test2[i].result != prandom_u32_state(&state))
-			errors++;
-
-		runs++;
-		cond_resched();
-	}
-
-	if (errors)
-		pr_warn("prandom: %d/%d self tests failed\n", errors, runs);
-	else
-		pr_info("prandom: %d self tests passed\n", runs);
-	return 0;
-}
-core_initcall(prandom_state_selftest);
+#ifdef CONFIG_PRANDOM_KUNIT_TEST
+#include "tests/random32_kunit.c"
 #endif
diff --git a/lib/tests/random32_kunit.c b/lib/tests/random32_kunit.c
new file mode 100644
index 000000000..ee50205b8
--- /dev/null
+++ b/lib/tests/random32_kunit.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for random32 functions.
+ */
+
+#include <kunit/test.h>
+
+static struct prandom_test1 {
+	u32 seed;
+	u32 result;
+} test1[] = {
+	{ 1U, 3484351685U },
+	{ 2U, 2623130059U },
+	{ 3U, 3125133893U },
+	{ 4U,  984847254U },
+};
+
+static struct prandom_test2 {
+	u32 seed;
+	u32 iteration;
+	u32 result;
+} test2[] = {
+	/* Test cases against taus113 from GSL library. */
+	{  931557656U, 959U, 2975593782U },
+	{ 1339693295U, 876U, 3887776532U },
+	{ 1545556285U, 961U, 1615538833U },
+	{  601730776U, 723U, 1776162651U },
+	{ 1027516047U, 687U,  511983079U },
+	{  416526298U, 700U,  916156552U },
+	{ 1395522032U, 652U, 2222063676U },
+	{  366221443U, 617U, 2992857763U },
+	{ 1539836965U, 714U, 3783265725U },
+	{  556206671U, 994U,  799626459U },
+	{  684907218U, 799U,  367789491U },
+	{ 2121230701U, 931U, 2115467001U },
+	{ 1668516451U, 644U, 3620590685U },
+	{  768046066U, 883U, 2034077390U },
+	{ 1989159136U, 833U, 1195767305U },
+	{  536585145U, 996U, 3577259204U },
+	{ 1008129373U, 642U, 1478080776U },
+	{ 1740775604U, 939U, 1264980372U },
+	{ 1967883163U, 508U,   10734624U },
+	{ 1923019697U, 730U, 3821419629U },
+	{  442079932U, 560U, 3440032343U },
+	{ 1961302714U, 845U,  841962572U },
+	{ 2030205964U, 962U, 1325144227U },
+	{ 1160407529U, 507U,  240940858U },
+	{  635482502U, 779U, 4200489746U },
+	{ 1252788931U, 699U,  867195434U },
+	{ 1961817131U, 719U,  668237657U },
+	{ 1071468216U, 983U,  917876630U },
+	{ 1281848367U, 932U, 1003100039U },
+	{  582537119U, 780U, 1127273778U },
+	{ 1973672777U, 853U, 1071368872U },
+	{ 1896756996U, 762U, 1127851055U },
+	{  847917054U, 500U, 1717499075U },
+	{ 1240520510U, 951U, 2849576657U },
+	{ 1685071682U, 567U, 1961810396U },
+	{ 1516232129U, 557U,    3173877U },
+	{ 1208118903U, 612U, 1613145022U },
+	{ 1817269927U, 693U, 4279122573U },
+	{ 1510091701U, 717U,  638191229U },
+	{  365916850U, 807U,  600424314U },
+	{  399324359U, 702U, 1803598116U },
+	{ 1318480274U, 779U, 2074237022U },
+	{  697758115U, 840U, 1483639402U },
+	{ 1696507773U, 840U,  577415447U },
+	{ 2081979121U, 981U, 3041486449U },
+	{  955646687U, 742U, 3846494357U },
+	{ 1250683506U, 749U,  836419859U },
+	{  595003102U, 534U,  366794109U },
+	{   47485338U, 558U, 3521120834U },
+	{  619433479U, 610U, 3991783875U },
+	{  704096520U, 518U, 4139493852U },
+	{ 1712224984U, 606U, 2393312003U },
+	{ 1318233152U, 922U, 3880361134U },
+	{  855572992U, 761U, 1472974787U },
+	{   64721421U, 703U,  683860550U },
+	{  678931758U, 840U,  380616043U },
+	{  692711973U, 778U, 1382361947U },
+	{  677703619U, 530U, 2826914161U },
+	{   92393223U, 586U, 1522128471U },
+	{ 1222592920U, 743U, 3466726667U },
+	{  358288986U, 695U, 1091956998U },
+	{ 1935056945U, 958U,  514864477U },
+	{  735675993U, 990U, 1294239989U },
+	{ 1560089402U, 897U, 2238551287U },
+	{   70616361U, 829U,   22483098U },
+	{  368234700U, 731U, 2913875084U },
+	{   20221190U, 879U, 1564152970U },
+	{  539444654U, 682U, 1835141259U },
+	{ 1314987297U, 840U, 1801114136U },
+	{ 2019295544U, 645U, 3286438930U },
+	{  469023838U, 716U, 1637918202U },
+	{ 1843754496U, 653U, 2562092152U },
+	{  400672036U, 809U, 4264212785U },
+	{  404722249U, 965U, 2704116999U },
+	{  600702209U, 758U,  584979986U },
+	{  519953954U, 667U, 2574436237U },
+	{ 1658071126U, 694U, 2214569490U },
+	{  420480037U, 749U, 3430010866U },
+	{  690103647U, 969U, 3700758083U },
+	{ 1029424799U, 937U, 3787746841U },
+	{ 2012608669U, 506U, 3362628973U },
+	{ 1535432887U, 998U,   42610943U },
+	{ 1330635533U, 857U, 3040806504U },
+	{ 1223800550U, 539U, 3954229517U },
+	{ 1322411537U, 680U, 3223250324U },
+	{ 1877847898U, 945U, 2915147143U },
+	{ 1646356099U, 874U,  965988280U },
+	{  805687536U, 744U, 4032277920U },
+	{ 1948093210U, 633U, 1346597684U },
+	{  392609744U, 783U, 1636083295U },
+	{  690241304U, 770U, 1201031298U },
+	{ 1360302965U, 696U, 1665394461U },
+	{ 1220090946U, 780U, 1316922812U },
+	{  447092251U, 500U, 3438743375U },
+	{ 1613868791U, 592U,  828546883U },
+	{  523430951U, 548U, 2552392304U },
+	{  726692899U, 810U, 1656872867U },
+	{ 1364340021U, 836U, 3710513486U },
+	{ 1986257729U, 931U,  935013962U },
+	{  407983964U, 921U,  728767059U },
+};
+
+static void prandom_state_test_seed(struct rnd_state *state, u32 seed)
+{
+#define LCG(x)	 ((x) * 69069U)	/* super-duper LCG */
+	state->s1 = __seed(LCG(seed),        2U);
+	state->s2 = __seed(LCG(state->s1),   8U);
+	state->s3 = __seed(LCG(state->s2),  16U);
+	state->s4 = __seed(LCG(state->s3), 128U);
+}
+
+static void test_prandom_seed_boundary(struct kunit *test)
+{
+	int i;
+	struct rnd_state state;
+
+	for (i = 0; i < ARRAY_SIZE(test1); i++) {
+		prandom_state_test_seed(&state, test1[i].seed);
+		prandom_warmup(&state);
+		KUNIT_EXPECT_EQ(test, test1[i].result, prandom_u32_state(&state));
+	}
+}
+
+static void test_prandom_taus113(struct kunit *test)
+{
+	int i, j;
+	struct rnd_state state;
+
+	for (i = 0; i < ARRAY_SIZE(test2); i++) {
+		prandom_state_test_seed(&state, test2[i].seed);
+		prandom_warmup(&state);
+
+		for (j = 0; j < test2[i].iteration - 1; j++)
+			prandom_u32_state(&state);
+
+		KUNIT_EXPECT_EQ(test, test2[i].result, prandom_u32_state(&state));
+	}
+}
+
+static struct kunit_case prandom_test_cases[] = {
+	KUNIT_CASE(test_prandom_seed_boundary),
+	KUNIT_CASE(test_prandom_taus113),
+	{}
+};
+
+static struct kunit_suite prandom_test_suite = {
+	.name = "prandom",
+	.test_cases = prandom_test_cases,
+};
+
+kunit_test_suite(prandom_test_suite);
-- 
2.52.0

