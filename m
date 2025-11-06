Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A435929B766;
	Thu,  6 Nov 2025 16:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445363; cv=none; b=fH7d57Cjdbs0b37EPYR5yNB+JMCNATyTtybqAGs0Qu6DPlOOzaeWnMJ6mLdGIUYFFt26NjjzFixlg+y1g3z4/YnZZsmSXeeCB2mkNlc7qjOSAgHam/ttmyeYf/R7S/Nr2cgqElz4g2dCUr+cBWvyowThWqIiF+/CBf4YhKB8z7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445363; c=relaxed/simple;
	bh=le8s+SKjFk49lpjMHJc2z9xNR0Zo6xQpZLP7JA/g9mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pXiVg3SSYdTte4SrVYWQYAnC+mqfrc+/fcJPQU4BCbnyootjGGKVSCj3VpipOjGNiEs4ef+S3pQugqB0bWW2B9NRP6A7rSi6475DnoQPp/6GHdBCfrqbuQKKFXRTB3Yw+jdUumwR8Wj+J7tLXI/BUzSUwDf0dWIAsArMdr00IEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Zh8XAC1V; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Zh8XAC1V"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A67KHRN023521;
	Thu, 6 Nov 2025 16:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VjZfltUSwZHxE+uDU
	dhq3CJlPnh5lohyju6CeAaqcrc=; b=Zh8XAC1Vits+JI9gf6x+CHzO1+0XGCDCp
	3KuWEq4Z4ahDNljtGdbqv0bvdAoQQziVtUXzepuHoJAG4jfs1x0oKG7WJNMV3xLv
	OM1rQqZM5ZlTVEwzWvmVFInm0ZVPIyt60HDiPeonL8htNsjFecm63ST4Bfn4VQFp
	wYMidBovOdeH9Ig+ygJZIIQTMaxXovabJLNXZhmi+a+EYzFBPX5oF6Q33JhPsNv6
	ybiNE8f709M6jvkP62DwYXB+Z7jZR2pkSuCC9quCGNrUpngyHUZozOAzgXDC2vz2
	H3b5qZecDzAQ1XkXCutJ7BvYqdZlK/0ndUnx60Kj6aIwTc+De3ghA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q986sk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 16:09:12 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A6FxXs0008061;
	Thu, 6 Nov 2025 16:09:12 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59q986sg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 16:09:12 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6EwLJB025557;
	Thu, 6 Nov 2025 16:09:11 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a5vhsxh26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 16:09:10 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A6G97qS51249586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Nov 2025 16:09:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 468EE20040;
	Thu,  6 Nov 2025 16:09:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6459120043;
	Thu,  6 Nov 2025 16:09:06 +0000 (GMT)
Received: from li-26e6d1cc-3485-11b2-a85c-83dbc1845c5e.ibm.com.com (unknown [9.111.24.158])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Nov 2025 16:09:06 +0000 (GMT)
From: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
To: Alexander Potapenko <glider@google.com>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
Subject: [PATCH 1/2] instrumented.h: Add function instrument_write_after
Date: Thu,  6 Nov 2025 17:08:46 +0100
Message-ID: <20251106160845.1334274-4-aleksei.nikiforov@linux.ibm.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20251106160845.1334274-2-aleksei.nikiforov@linux.ibm.com>
References: <20251106160845.1334274-2-aleksei.nikiforov@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=StmdKfO0 c=1 sm=1 tr=0 ts=690cc828 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=KOBABV2IKOkdypTAImUA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: wsqpo0y6lQa7s9mUgKxY6TctUwToHVni
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAxOCBTYWx0ZWRfX7jgjMaG+XyZ8
 mThr2JYAcbWr0jgLh7hdJxD6YOimrAM+XG5dJiU0u4CPphdKdoI7caEJL71U/VpnjotTaZtOnbd
 OcJg9y1xzEnJD+Ehkgrp/+e7d6B/l4RUwFbplfBctghdzgVEFdn+ZjfHnVLWkOpZCoYPeBlVjsA
 UDpfU90jbCNps5+SnuacrBu8RsktfOxDycQidVkiOPOKJR8emqoKBiG4x3cix3ytROGpbJHdaxX
 nJvWGhbiWr6n+zsh3DjqhIxyKwbdxzg5aJG1jHTRy5bC2jjbLexTu4Mmv24mAoQQ1tERVkwtPvD
 bNo7Q4iQr9Cg8DvV+DWYcBNBD2GwjpfwlmykT1WdjoatAzkaddngjw4I1ybTFOiE74ZyJoEPIV/
 EuS2J9r3JLpENr1OdNdyGp+G8o8ypQ==
X-Proofpoint-GUID: RQXdUhJfyyG6VwdC6vI3fgqe0m3GUW_M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010018

clang generates call to __msan_instrument_asm_store with size calculated
based on inline asm constraints. It looks like there's no way to properly
write constraint for var-size memory write and make clang generate
__msan_instrument_asm_store call based on runtime-obtained size.

Implement instrument_write_after similar to instrument_write and
instrument_copy_from_user_after to manually fix kmsan behaviour
in such cases.

Signed-off-by: Aleksei Nikiforov <aleksei.nikiforov@linux.ibm.com>
---
 include/linux/instrumented.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/instrumented.h b/include/linux/instrumented.h
index 711a1f0d1a73..a498d914a8b0 100644
--- a/include/linux/instrumented.h
+++ b/include/linux/instrumented.h
@@ -41,6 +41,20 @@ static __always_inline void instrument_write(const volatile void *v, size_t size
 	kcsan_check_write(v, size);
 }
 
+/**
+ * instrument_write_after - instrument regular write access
+ * @v: address of access
+ * @size: size of access
+ *
+ * Instrument a regular write access. The instrumentation should be inserted
+ * after the actual write happens.
+ */
+static __always_inline void instrument_write_after(const volatile void *v,
+						   size_t size)
+{
+	kmsan_unpoison_memory((const void *)v, size);
+}
+
 /**
  * instrument_read_write - instrument regular read-write access
  * @v: address of access
-- 
2.43.7

