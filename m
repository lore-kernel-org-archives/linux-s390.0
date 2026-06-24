Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF463A6F1B
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782288657; cv=none; b=b4TGofMt8O7FxFD8vkIx6xeU6kvaof0puYXGZk9fACwZzbBp7+rsvAts5iNtyN9Ii8YIhNmXCcPzfhqvw7M+qkL8t6ANu67ThIeu/ZufwAu+9ZMdZGrvoJgX3DuytBCmGN/yRtQ6fwZynai1sqKj7aY9Rsu/FqfUvZN+Rp42qSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782288657; c=relaxed/simple;
	bh=klaQrGi+lKlZCPxdoaRW04F3GCJlepYIhpAuKrCn6C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1HtNEbYrBi4K1R0VZSNc1qlnt75eKHuzCc1NGOlj72/+3MBmt0/xgqAblGBXezVrsXlKWh+Y8Lu7/YZf7Ewrw2lpu+kHf8OIXe+tV6q7zSlM5tHbudB+pUvy6AxdXx9/mUKF2YSW6tiBRh4HhDFcSxt6bv/adYp1F0S5aWt2fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Kq5MO6BW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Kq5MO6BW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O6IIIg076000;
	Wed, 24 Jun 2026 08:10:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TjOC3cL2hISdMojeb
	IahSrQAzFHFbkIJj3Q5tona3mE=; b=Kq5MO6BW0QwMB6bAsRJxloXK6Vi6Xs9AI
	h3kd/J2iLp9+brquh6gATNLC7tMGcgE9cG7TiRXmGzsJynUq4YYHg1UmQnwnp/a7
	Uy5xZt8i0y8fvESgpaDkpFXHi6n6ypFYTVif0DirRK93h0StBrsB2MimhS+qOiq5
	V8IaBuEPboICDIn6PypypaItuwe2rlIhpqkHfdn7Ou9ls7haa6ynWTx5+2Ow/kse
	JWs5Upe1Rlhj4H223EeZp/2+QQBSx8fmcSkDAsgkSPW0GlZ5OzN7zhRFs+zHwpiH
	8VDbGaI6ZoPuQ0K7LL04rJYMzpL51F+q9asFSD7VjHafIfoa3XDTQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4k26t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65O84eSx005607;
	Wed, 24 Jun 2026 08:10:35 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k7kar-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 08:10:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65O8AUF142729814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 08:10:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B23F32004E;
	Wed, 24 Jun 2026 08:10:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 750562004F;
	Wed, 24 Jun 2026 08:10:30 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.224.92.54])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 08:10:30 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: [PATCH v8 01/18] target/s390x: Fix wrong address handling in address loops
Date: Wed, 24 Jun 2026 10:09:58 +0200
Message-ID: <20260624081029.23815-2-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624081029.23815-1-freude@linux.ibm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfX9gyS40veVLBM
 DNKIp74ZAF612pEMMz4q3RHhUJz25hNGiGNtjWZEUt8lIywCEAVaBxD/r59VIym6ALwipPhGrio
 xVXs2T2t5zAstNx4qTvncOrwL75H8gY=
X-Proofpoint-ORIG-GUID: WAlpJsy-yh3o9f6kNly9OSGeTQGF9Vpb
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3b90fc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=nuIt1skNlyxysNKS0h8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA2MyBTYWx0ZWRfXx6bHvedeAeNY
 pYQhNpz/urscPLoJ3AruR5lyeI6MJyoduee1fvnmfGm3uqEPRmgp0oybeU7p3ZG2rHrolOnglpx
 s9g203wkypSckX9o2Mgq9XJh/Sx+y1j0NCi8ZYABg8/GUJHgQfu6IJ7VoNeXGv0ba2j+j48+WkP
 yRmj/OZ855u5T44hsXrNHhYeVJTTcVSCYzWTmnD2DCAeAedQzBAkY/joIOap9NT+UIKe0dH0NfI
 0OogZfMfVz7jRFh9XKu6FFDrapN6IefQugwGkPCTqbhN07FBTRhpz+dSpbgNKwVCNARFaW/4G1u
 xgXiktmmAxwygIjckV4SGj5l6+GAEhnov3Iv66jdKskpv48prxBbAPO2ObxOJRyVLvhbxEJ4o5T
 SStlTDrftQ8bxsKjoH9TePQ4cK5auH6/f+Oq9Px/+6MsSU9XO/clX2bI5wqcNtWDlxye6UzBqf/
 BgQ3HICW+orVNK8/1Vw==
X-Proofpoint-GUID: WAlpJsy-yh3o9f6kNly9OSGeTQGF9Vpb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606240063

With the introduction of the address wrapping function
wrap_address() the result can't be used to walk the
source address any more. So introduce a new local variable
to hold the wrapped address to avoid mixing source and
wrapped address value.

Fixes: fcc2699d41 ("target/s390x: Have MSA helper pass a mmu_idx argument")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
---
 target/s390x/tcg/crypto_helper.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
index ae392bce0e..29ad2aff43 100644
--- a/target/s390x/tcg/crypto_helper.c
+++ b/target/s390x/tcg/crypto_helper.c
@@ -126,8 +126,8 @@ static void sha512_read_icv(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
     for (int i = 0; i < 8; i++, addr += 8) {
-        addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
+        uint64_t _addr = wrap_address(env, addr);
+        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
     }
 }
 
@@ -137,8 +137,8 @@ static void sha512_write_ocv(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
     for (int i = 0; i < 8; i++, addr += 8) {
-        addr = wrap_address(env, addr);
-        cpu_stq_mmu(env, addr, a[i], oi, ra);
+        uint64_t _addr = wrap_address(env, addr);
+        cpu_stq_mmu(env, _addr, a[i], oi, ra);
     }
 }
 
@@ -148,8 +148,8 @@ static void sha512_read_block(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_BE | MO_64 | MO_UNALN, mmu_idx);
 
     for (int i = 0; i < 16; i++, addr += 8) {
-        addr = wrap_address(env, addr);
-        a[i] = cpu_ldq_mmu(env, addr, oi, ra);
+        uint64_t _addr = wrap_address(env, addr);
+        a[i] = cpu_ldq_mmu(env, _addr, oi, ra);
     }
 }
 
@@ -159,8 +159,8 @@ static void sha512_read_mbl_be64(CPUS390XState *env, const int mmu_idx,
     const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
 
     for (int i = 0; i < 16; i++, addr += 1) {
-        addr = wrap_address(env, addr);
-        a[i] = cpu_ldb_mmu(env, addr, oi, ra);
+        uint64_t _addr = wrap_address(env, addr);
+        a[i] = cpu_ldb_mmu(env, _addr, oi, ra);
     }
 }
 
-- 
2.43.0

