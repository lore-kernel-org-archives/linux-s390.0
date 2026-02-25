Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925D33D6684;
	Wed, 25 Feb 2026 16:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772035516; cv=none; b=Saxo/BB82zRzNI9XVIraNz25fK291aHjzc2LRiCrUEkhhvGHFUQ46nzAfLZwNYI68Vyrrl67rLjsO2qXfPr4fhgq2n9I9QH1L84r21GEiS/YxarzWuYFfKhBUFSITZZYx+aRIc1Rt+7x9NtrNopTD852kvZfMSXcNC53UrOEg9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772035516; c=relaxed/simple;
	bh=Wb4+OYiHbkjuIn5JLgl6T58HF+0Y864UwNeZyZxUpGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=shY9NpjHJHKrbXJ8jy+JpQgfSZ+y5b6t8SZdpzYeIskN8z0TA2h6RMgh8y2KgX2oFkPPY3VQSXcAK7wpwP1ewg4MbwaSlFfj8lkziFZzLe+O4QO9xWzV7UGSFg65P4PwrkTda70go7Y0vZ3mfjdeWZTjvmv5AnaeSCWcgBpQ3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qF/LIFJ2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qF/LIFJ2"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61P7S8Jb1314639;
	Wed, 25 Feb 2026 16:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:sender:subject:to; s=pp1; bh=z6BhN75UKL8ucUNVEPHgW0oI2XOhM4MrBI
	blXGgx4UA=; b=qF/LIFJ20Nd9C95FyyC+fQ6x2e8zDNI9vze4cA8GKUT7H2P8Uw
	UcTSWQdk5S9N76f7YVZ/e4q8InkchFj8ap5ymGxGFhzcTkV/JNmCo2t1g/R0LB47
	aJcaO8IAbdAtXY9n2qwmmcTPV6gExsMtiOmw80dF3TD7K6OD/UluDNz9V0H+X7Gb
	jJ8EfZEs9rjkI3z0t/3f2/ZJ7e1K4gbpu2p3jf6zZYfCCmtqwGcjT+MnnzbpwDZn
	3zS54n9qX31z/z+oZYDbRb0diO4CO5WA0XiremOjd/oxSAi1j9M/7mqaFrdKkvmg
	7ivag1SANhiP2mYfLgxPFYT2V2/iyxvMIhdw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf47214e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 16:05:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61PG1ltS015962;
	Wed, 25 Feb 2026 16:05:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cfq1sp4fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Feb 2026 16:05:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61PG58lR29688298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 16:05:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 731A820043;
	Wed, 25 Feb 2026 16:05:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63A0D20040;
	Wed, 25 Feb 2026 16:05:08 +0000 (GMT)
Received: from p1gen4-pw042f0m (unknown [9.52.223.163])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 25 Feb 2026 16:05:08 +0000 (GMT)
Received: from bblock by p1gen4-pw042f0m with local (Exim 4.99.1)
	(envelope-from <bblock@linux.ibm.com>)
	id 1vvHNs-00000001L4l-0SGl;
	Wed, 25 Feb 2026 17:05:08 +0100
From: Benjamin Block <bblock@linux.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH] debugobjects: Allow to configure the amount of pre-allocated objects
Date: Wed, 25 Feb 2026 17:05:08 +0100
Message-ID: <70f06193b3c3581802710ebcef74671e50c4c979.1772035270.git.bblock@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: IBM Deutschland Research & Development GmbH, https://www.ibm.com/privacy, Vors. Aufs.-R.: Wolfgang Wendt, Geschäftsführung: David Faller. Sitz der Ges.: Ehningen, Registergericht: AmtsG Stuttgart, HRB 243294
Content-Transfer-Encoding: 8bit
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -l-nV8_25ywPOq_XM7pumGKaY2-_pr4A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE1MCBTYWx0ZWRfX8ZpL6T0TOmaB
 DLal+NB6tLsUBx9BvzTqMHXgmlrBDwnME1CvrCk60HcURq62vGCBn/LtC2aZw13cn9HXW8Jc2Fn
 2Bm7dpw+YDc14EddLHwMmZMB7LmRJzwHgCvzWrA4ngvyLVgNenMUUX1/wy6o9Aq1cksn/c1a2Cc
 +cB1+oOwYE3LYXpes58uC6tNq9moqqOuuoch4w7stfc61SyuFETY/Ca7jALY9Vs3sajV9goPCDu
 CzAwf0wH6tL4P0Y06hphNf7HVu2iCy+u6nllpxnNzdJZYvPXTfZuQx9EoDSMTawmUoFJ1OX9rsz
 KPp1yF1hCJdxQyAXZ3P5p2Ihh9PlVop60/l6ibkahp5iMJJVWNE7miZ3Jqf3bZAEdIjgRdB9fcU
 YWxxRplLQbfyF0LpTmII6kO4N/q2g+PsrB0K6w0mlhaBIL1pFZNyIuZVmF1RZmr7KO9Ic1J+iMO
 Gyf89pURzJKgKn8ZL8g==
X-Authority-Analysis: v=2.4 cv=R7wO2NRX c=1 sm=1 tr=0 ts=699f1db7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=zIxLjuM9KegLyq19elwA:9
X-Proofpoint-GUID: -l-nV8_25ywPOq_XM7pumGKaY2-_pr4A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_02,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602250150

To debug object operations a certain amount of metadata has to be kept
per object that is tracked. During boot a static amount of pre-
allocated objects is set aside to be used for this task until such a
time a dynamic allocator can be used. Once a dynamic allocator can be
used an initial amount of objects is pre-allocated to be used when
needed.

So far the amount of such initially statically, and later dynamically
pre-allocated objects is set fixed at `64 * 16 = 1024`. But depending on
the system this might not be enough during boot, when only the static
amount of pre-allocated objects is used; and once this happens ODEBUG
disables itself permanently.

On s390 it has been observed, that even with 16384 such pre-allocated
objects ODEBUG would still be disabled during boot.

Similarly to other debug features like KMEMLEAK add a Kconfig option
CONFIG_DEBUG_OBJECTS_POOL_SIZE_SHIFT that allows to increase the amount
of pre-allocated objects (in both the static and later dynamic cases).
Use it as exponential, rather than linear value to allow for head-room
to grow into once set in a configuration.

The calculation is done as such:
    N_OBJECTS = 2^DEBUG_OBJECTS_POOL_SIZE_SHIFT * N_BATCH

By default it is set to 6, so the actual amount is unchanged, unless
the new options is changed:
    N_OBJECTS = 2^6 * 16
    N_OBJECTS = 1024

For the previously mentioned observations on s390 it was necessary to
increase the option to 11 in order to have enough space during boot.

Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 lib/Kconfig.debug  | 32 ++++++++++++++++++++++++++++++++
 lib/debugobjects.c | 15 +++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 318df4c75454..c6afc5b03572 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -811,6 +811,38 @@ config DEBUG_OBJECTS_PERCPU_COUNTER
 	  percpu counter routines to track the life time of percpu counter
 	  objects and validate the percpu counter operations.
 
+config DEBUG_OBJECTS_POOL_SIZE_SHIFT
+	int "Metadata objects pool size"
+	depends on DEBUG_OBJECTS
+	range 0 21
+	default 6
+	help
+	  To debug object operations a certain amount of metadata has to be
+	  kept per object that is tracked. During boot a static amount of pre-
+	  allocated objects is set aside to be used for this task until such a
+	  time a dynamic allocator can be used. Once a dynamic allocator can be
+	  used an initial amount of objects is pre-allocated to be used when
+	  needed.
+
+	  This option sets the amount of both: the amount of initially
+	  statically allocated objects; and later the amount of dynamically
+	  pre-allocated objects. It is used as exponent to the power of 2,
+	  multiplied by the batch size used to set how many objects are move
+	  between pools at once.
+
+	  For example, when left at the default of 6:
+	      N_OBJECTS = 2^DEBUG_OBJECTS_POOL_SIZE_SHIFT * N_BATCH
+	      N_OBJECTS = 2^6 * 16
+	      N_OBJECTS = 1024
+	  By increasing the option by 1, you double the amount of objects.
+
+	  An indication that you need to increase this option is that during
+	  boot you see messages like this:
+	      ODEBUG: Out of memory. ODEBUG disabled
+
+	  If in doubt, leave the default.
+
+
 config DEBUG_OBJECTS_ENABLE_DEFAULT
 	int "debug_objects bootup default value (0-1)"
 	range 0 1
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 89a1d6745dc2..20e93d0074fa 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -22,11 +22,18 @@
 #define ODEBUG_HASH_BITS	14
 #define ODEBUG_HASH_SIZE	(1 << ODEBUG_HASH_BITS)
 
-/* Must be power of two */
+/*
+ * Must be power of two.
+ * Please change Kconfig help text of DEBUG_OBJECTS_POOL_SIZE_SHIFT when
+ * changed.
+ */
 #define ODEBUG_BATCH_SIZE	16
 
+#define ODEBUG_POOL_SHIFT	CONFIG_DEBUG_OBJECTS_POOL_SIZE_SHIFT
+static_assert(ODEBUG_POOL_SHIFT >= 0);
+
 /* Initial values. Must all be a multiple of batch size */
-#define ODEBUG_POOL_SIZE	(64 * ODEBUG_BATCH_SIZE)
+#define ODEBUG_POOL_SIZE	((1 << ODEBUG_POOL_SHIFT) * ODEBUG_BATCH_SIZE)
 #define ODEBUG_POOL_MIN_LEVEL	(ODEBUG_POOL_SIZE / 4)
 
 #define ODEBUG_POOL_PERCPU_SIZE	(8 * ODEBUG_BATCH_SIZE)
@@ -569,6 +576,10 @@ static void debug_objects_oom(void)
 	struct debug_bucket *db = obj_hash;
 	HLIST_HEAD(freelist);
 
+	/*
+	 * Please change Kconfig help text of DEBUG_OBJECTS_POOL_SIZE_SHIFT
+	 * when changed.
+	 */
 	pr_warn("Out of memory. ODEBUG disabled\n");
 
 	for (int i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
-- 
2.53.0

