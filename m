Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB8421F17;
	Fri, 22 May 2026 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459205; cv=none; b=TJd7Xu4C8rnYbCe5uQK+JF2jYzl2LkO2iH6s5FhqCYd+jPUq5i0YfJBBYLf1wBwFGg4PJiuZKEPihzl8OX4Fovnoj6TTb609yjtNBXh9HK979QR87v3Brwa/d3Enm0nSLTLBCVYnvP+fPeC/qLKIB2TPNdhGWnJi8SC5d6dblXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459205; c=relaxed/simple;
	bh=ef2UwNRzcG9g0NK5tazYND828j/yLBssvJDK5Gg5Xh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nBO0JXK9AG6eVzkQh89WjA8fsGeHWYDBJNQHgSn5okanb6y2b5BNZMyUqoLpmX6gWyjK2uW9l8zbvMPQqC/tv4EE06W/7cQBkAfDB1bwloYEAXJ+zRn/r7O1SflO1kzeO+8mRIXbUHiRp2ez8b2AGlfsdovoYJ+N+E3DUTyyBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MhLbLbNZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MhLbLbNZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M10OUN1495915;
	Fri, 22 May 2026 14:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yJkTWInv7qo7a8PXK
	hXr59zNL9lUcDPJGpABn4QlEu8=; b=MhLbLbNZY6mDWgSSvVKm7k5HhlzF1F9+w
	oC8+5Vt9gzEL0Y4ZyJl7eFtz7FIyJsYkHs7RGHcWcwHdeaWMY3QL9vib7lIYbiUi
	I0ELoeaMr3hcmenHkCL4WSZVhrhrwrFnXhPz3Wm/WyMHyjEfoweYACyLONDmvaIF
	jphtjGwCFCfDfgoQpnLJjiWVFMYQIULnL+A3cwMdcfbI4lvUdSyqCPmuNNQhyHSn
	/8ze/6bkoWsLVxiXTsYQOgCiLdYBmGwAmJIcbrcsi0YkowEDHcwZZO1gA7OlJHjI
	KVB8HXx/hwWtnEqypg29IZQARNXLmkyUp0fNaqlG8way2l/JHKz5A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9ycegt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64ME97De024233;
	Fri, 22 May 2026 14:13:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e739w9anu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MED0Rt12321152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 14:13:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF1ED20040;
	Fri, 22 May 2026 14:12:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF14F2004B;
	Fri, 22 May 2026 14:12:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 14:12:59 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        David Laight <david.laight.linux@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 8/8] s390/percpu: Remove one and two byte this_cpu operation implementation
Date: Fri, 22 May 2026 16:12:57 +0200
Message-ID: <20260522141257.303617-9-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522141257.303617-1-hca@linux.ibm.com>
References: <20260522141257.303617-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0MSBTYWx0ZWRfXywCMk8UAfnHd
 TKV3gkAelVAsbfJDaZ+qpS044q6Kk8TRRrMCsWE9o72VCEqXS+wT9pwzuEbLusIxokGTQp2clBz
 yDWkHIg4XW/2lbd7W384ki28jhOTGYwqcB9SwOZvRe89JLy4xkavsvkHFHwu7S2FxrQz/hDq6BZ
 msFLS4qpF5sFnZUBUbAD5lQuXW0dcwr9UjsZDWiQg6kkvWtKkchW+zndVqZlYIOTbj6fOF8dD3R
 B8qQ2yBjkDbbkM4L8rnoj8AbtivMFHgktNesTkuwmJrLgvtYvyaRWiA+kyh4jazcyT5xh/TfmwF
 yHEKrS06wwWR9d2EU5IcbDD4gEBkYoeacl4PKvEUW1SIgiObA8eV9xm+bS4NoFFm5FRyz8rck1X
 jFUUfIVOLF5olE4vh4mU2yuey55z+rTeKaY4HiRy08kg+FUE9TFg4eL+rKuutvUcAcAadnyTRfN
 jw1gKNDKb3W+I7y9vog==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a106471 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=e14ZIUwkndthOOMI8LgA:9
X-Proofpoint-ORIG-GUID: Ksoz4cUCdVxI9OWnSKG4VMSTod0Wb3RN
X-Proofpoint-GUID: K2Uig8D3PdNIaOZBGvLxbumqG5vNR92G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220141

There are no one and two byte this_cpu operations within the kernel
(defconfig). However even if there would be, the s390 implementation, which
uses a cmpxchg loop, generates a very large code sequence due to the lack
of native one and two byte cmpxchg instructions.

Remove the s390 implementation and use the generic implementation.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 667b165b4c0e..5c0c061dbd10 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -51,15 +51,6 @@
 	new__;								\
 })
 
-#define this_cpu_add_1(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, +)
-#define this_cpu_add_2(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, +)
-#define this_cpu_add_return_1(pcp, val) arch_this_cpu_to_op_simple(pcp, val, +)
-#define this_cpu_add_return_2(pcp, val) arch_this_cpu_to_op_simple(pcp, val, +)
-#define this_cpu_and_1(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, &)
-#define this_cpu_and_2(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, &)
-#define this_cpu_or_1(pcp, val)		arch_this_cpu_to_op_simple(pcp, val, |)
-#define this_cpu_or_2(pcp, val)		arch_this_cpu_to_op_simple(pcp, val, |)
-
 /*
  * Macros to be used for percpu code section based on atomic instructions.
  *
@@ -321,8 +312,6 @@ do {									\
 	ret__;								\
 })
 
-#define this_cpu_cmpxchg_1(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
-#define this_cpu_cmpxchg_2(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 #define this_cpu_cmpxchg_4(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 #define this_cpu_cmpxchg_8(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval)
 
@@ -353,8 +342,6 @@ do {									\
 	ret__;								\
 })
 
-#define this_cpu_xchg_1(pcp, nval) arch_this_cpu_xchg(pcp, nval)
-#define this_cpu_xchg_2(pcp, nval) arch_this_cpu_xchg(pcp, nval)
 #define this_cpu_xchg_4(pcp, nval) arch_this_cpu_xchg(pcp, nval)
 #define this_cpu_xchg_8(pcp, nval) arch_this_cpu_xchg(pcp, nval)
 
-- 
2.51.0

