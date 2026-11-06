Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793983824;
	b=gTqMXSXmFDF23YncJ9uGZJVw+42tvWlGibsBWHkbnXfkm5IeKQvZBbDpV5Irw08geqpX
	 Wdq6IN99JOi/+gIL+X9nkGIKpoVNbeOD/0vfxtZvNoAT1G05bdhNV+iVUzl6CtyTKJccn
	 sGceq37gzyYCboaTYrEjoDiYKcpYBrhTmHyDzNjLItadzeMqltyzJnMHmbd7ZWmegATv9
	 A/d+ZGB+gYKr42E0M2CkkV0plN/Bfocci0L/zOtG9vImVDBmENVm4yn60+V67b0iebkpl
	 dc/VmkLNjfgfXPnL3A3O0kVmD5mu05IvDKgqNLp6SKEwsFJrSlf/fnDag/Vuh2+F7GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793983824;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ejkwSS1eYzNNLLIk4Z9c/g9aJepUJSMNb6nZUIQJM/U=;
	b=gtJ/mtS7GTDcPRmNTmec16/F38I5OkxaRD78vkJhD+uHoQnFtFHYBq7EyXiHriRdhk/P
	 HD4Jh1zyxWSHyg9OcfZqbnTHZJ76NmD30Hp31toIQLem2AXNX6mtMo4tRGomE2WTs2mdQ
	 u3rJrf41Ddh5vwnRcN58suKJslZsOuAUmqfOjAojbmpod+AIqYFD4/SFhzcAWzWFrxwFS
	 y7oj+GC9PQE3HbGqY/GooiygOgFcgOduecFEtG1VCO95TzuGYCEaEm8+LPvvXaipQABIH
	 kVFD94rDOupgPel0WZe58xz1DY4VRpfQaU00rcz9nLfW1q9VBrG7aRmOjl4lQDGKf7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kOUDBg9t;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5BA606A334;
	Fri,  6 Nov 2026 16:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B5BA606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kOUDBg9t
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FE6Lc2711250;
	Fri, 6 Nov 2026 16:50:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ejkwSS1eYzNNLLIk4
	Z9c/g9aJepUJSMNb6nZUIQJM/U=; b=kOUDBg9tPVCFGQm+fc96xRzb0P1Df9YZD
	Oohd0R8XoBckKohboK1ZlGe6tc6vdP/CxgozuqO+9xN081KtIGdNTPotbnt4Q1v8
	/Uhe3DFi3Zxp4YXjepGzQEp5niK+sdNb0TTz8hHK6kOE59CZ/DjmOsBf1AuJnIzk
	ApKuPQlzWv/PBm9DjtsYPpXX+5iw2TK5sxwZgubSGMftkBzm5RyyeWDxJ2b7QNtB
	9z7rMAg1WbptzvWve4qO90Nq1LWS9XQki+GUWxlhiLEZ3BNFl4An/7CASd58JGwO
	pHAMuBx1ON0udgmzsjTPYwGE1Y/2O1zEG9lmKMYdJkX3TUhFx7PyA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r95xqq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:50:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4sxT3584920;
	Fri, 6 Nov 2026 16:50:19 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka72gvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:50:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6GoIBC15270438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:50:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 509135805A;
	Fri,  6 Nov 2026 16:50:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC9A458051;
	Fri,  6 Nov 2026 16:50:15 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:50:15 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>, Marc Zyngier <maz@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [GIT PULL 6/6] selftests: drivers/s390x: Select uvdevice tests using the target architecture
Date: Fri,  6 Nov 2026 17:49:58 +0100
Message-ID: <20261106164958.431978-7-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106164958.431978-1-borntraeger@linux.ibm.com>
References: <20261106164958.431978-1-borntraeger@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aee054c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=x_KbkSTR6PzcTiIBbCcA:9
X-Proofpoint-ORIG-GUID: Jg-wuwWgv97RTa5rbV8JckeQRtuTuTIG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfX9zeAtV9WERm5
 bzMXXBss/f2+AQGonELctlXpThuxoV9QOXWXi3TBW2aDUY/G4ygDlWNNtkMvC7jHzDX5ZH92riP
 nSc4zSleZVrMdLjLWbT+bGKZJgVceepzTNpU8LnBJKek5BF0LHn+AiPJxngPcDcdX6LqT43TXXV
 Ucl09KfF3QPALzlORT3ULZ2XCsM6S3Ya70SJ6R326RHy8EOvLrtOG5oCsNvKBI3YxU3LuDPsgiU
 wgRu9MQfh8yM9pdQWHeiF7aIQ8Z8c99A1+WmhXAUSXs2n2Y4nXqot13OSfK52zagTNyxfyKVcdy
 D4Ixg/uOYpm/cTjWHu2poIP+1U3MPcHH2dTzPHDna8TcquNKCurImUBq+OrQu/Li/AI9cq0JZYV
 tHm7AsdZqP3biswhNo+/RWS9L1nBm2+V/c3L1eJhgvfHRVvlnmzr1yM54FRAOCgRpczy2zVmWT1
 XUFySZAoP2yiGWVVZ4w==
X-Proofpoint-GUID: Jg-wuwWgv97RTa5rbV8JckeQRtuTuTIG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfX/mxGnyyLZUwT
 qDikpye8WtYRMhDjRZzFdEgJuX+LeqsuDlbfcXGvPomUKupKUVW6aIaC9P+7QWSQZ1FU51JyLEP
 p5uGvlO8uOJ3dzIg65zjDF0aozpISgQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060066

From: Sasha Levin <sashal@kernel.org>

The uvdevice Makefile decides whether to build its test from uname -m,
which describes the build host. A cross build for s390 on another host
therefore silently omits the test, while the non-s390 branch provides
no-op build and installation targets but no emit_tests target.

Select the test from the target ARCH when it is given and from the
host's SUBARCH otherwise, accepting both the s390 and s390x spellings,
and include lib.mk unconditionally so that other architectures build,
install and emit an empty runlist. ARCH itself is left unset so that a
native LLVM=1 build keeps using the compiler's native target.

Drop the include path derived from tools/arch/$(ARCH): the test only
needs asm/uvdevice.h from the installed kernel headers, and the path
does not exist for the s390x spelling.

Fixes: cbac924200b8 ("selftests: drivers/s390x: Add uvdevice tests")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 .../selftests/drivers/s390x/uvdevice/Makefile | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/drivers/s390x/uvdevice/Makefile b/tools/testing/selftests/drivers/s390x/uvdevice/Makefile
index 755d164384c46..586a9aa6fb158 100644
--- a/tools/testing/selftests/drivers/s390x/uvdevice/Makefile
+++ b/tools/testing/selftests/drivers/s390x/uvdevice/Makefile
@@ -1,20 +1,13 @@
 include ../../../../../build/Build.include
 
-UNAME_M := $(shell uname -m)
-
-ifneq ($(UNAME_M),s390x)
-nothing:
-.PHONY: all clean run_tests install
-.SILENT:
-else
+top_srcdir ?= ../../../../../..
+include $(top_srcdir)/scripts/subarch.include
+ARCH_PROCESSED := $(or $(ARCH),$(SUBARCH))
 
+ifneq (,$(filter s390 s390x,$(ARCH_PROCESSED)))
 TEST_GEN_PROGS := test_uvdevice
 
-top_srcdir ?= ../../../../../..
-LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
-
-CFLAGS += -Wall -Werror -static $(KHDR_INCLUDES) -I$(LINUX_TOOL_ARCH_INCLUDE)
+CFLAGS += -Wall -Werror -static $(KHDR_INCLUDES)
+endif
 
 include ../../../lib.mk
-
-endif
-- 
2.53.0

