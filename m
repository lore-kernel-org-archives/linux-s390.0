Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EAFC395DA9;
	Wed, 10 Jun 2026 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781090724; cv=none; b=q284OjCk2y9OxK8B3BEFygqR56VwQ0ewqgKS++erndhOUoYdhWH4UTfyyJwd7amBggXCT+HzSGytBncio3LkyGYbclI5zeoc8Jw99FnK4/hAQr/s1ZfNGzf7JO5w4wou5BujJadIMhecOXl3tVf6pFZ+4QKRVat2AmVMDVEMwOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781090724; c=relaxed/simple;
	bh=FrslU7oly/1il64yqMWa4Lm/Dci+q3SZPo/pn/zQtxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYNOwh5MXLAKBJRGR2yBV14/j8v4e+/I/BJDV4nwW6p94Z/GPGwlQ7RFLurOUmtPHcPCWdYJ2V2k0taItUhtibsy2a0rubfPunOjmnGDKSejBJLOgONHYphs8cBgDwuoF59mxJ3rKfm/APNvBlCjocLCyoBw6yG6mRBeCzUEFsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ocblb4ts; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ocblb4ts"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AB87x83398572;
	Wed, 10 Jun 2026 11:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3SV+GlkW/0ngO00KYqyHWwGFetvfNkhQQfFgu9SSg
	as=; b=ocblb4tshdTpqOmcVd5IWywGss5yYoZvSw++ihoj9FMhQGxQk+4qvZJJY
	K9bcjjh9PbwXicMRhDwc7YOPFR5gwtJdEGlL3CSwkEvXt+ubrQomzRSDOcNw4C3u
	wIsepZ+YZV+r0iQmRJqHFRuhtDxL4siiuTRP8aNI8bpNSG4jv/x+zez6p9p1c7NQ
	TjoavkwC0/nsA8+Wqq6uMuPINM77GrFi8+aLvqrpqnRUzL0pSstQS9AdcxuPf3fv
	xUilmvXR7g4ZmKYS0BWrELewyGNyYQEEpM8uYTKEUYjWkUrFzW301LJxqRUJFwyE
	+dmazr2oDOkVY+RQdnz4QTuTMSukw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qrsav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 11:25:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ABJcf6013368;
	Wed, 10 Jun 2026 11:25:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g66ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 11:25:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65ABP20x30212610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 11:25:02 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0EA220043;
	Wed, 10 Jun 2026 11:25:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A564A20040;
	Wed, 10 Jun 2026 11:25:01 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 11:25:01 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Cc: Jens Remus <jremus@linux.ibm.com>, Jan Polensky <japo@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH] perf s390: Fix TEXTREL in Python extension by compiling as PIC
Date: Wed, 10 Jun 2026 13:24:51 +0200
Message-ID: <20260610112451.1553054-1-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a294993 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Q_CO2TND4s4ZintWIbEA:9
X-Proofpoint-GUID: IpP5FWr3dqTNlUcSbSGXYywjgaJ0ZU2U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEwNiBTYWx0ZWRfX6ZaolGzwO4i0
 oYSz9wAzRCsaVDQ39ov6sgji2V/Y090Za03NzbJS/Sj7i91qMiPxBHmKTwNsIaDb6advw2JTUOF
 qQUT1+O94FcJTol9OyngeGaZuEL75wQScS1EKZlhJj/PeTHwWJ6Rs6tQ25P4bGTZhmWVxdOXZT6
 zqPCoe6kC0g4Dzxs+Cc4SdC3XRIreZX7G+U5ErFTW7J6Gij+Pkt4b0K2lXeQqwswKZt2+PZbX9+
 aagTy5moUqUCuo60eRDt9T+hUTGWvXvZ0kDW9QUvEs62/R0d4LlJomj3HIP2QeywdvKjaQ+pzbf
 IPqzAK8Qew3SWuryorYVfjVMHcqlggc4biZlpArphD9YhIiAIyen7yTC3Gy7LoVJ/qM/mKdTwMz
 nfGELBkdgiXGbIQbbWQoPq2zJxuWVc/11CkyZDFgNeNy20ylpwzQLPK8S59hsf7DfXHPBoFWDMf
 5iCUQOlL9Ae9JimJhDw==
X-Proofpoint-ORIG-GUID: ri4xy9gy99bw3ADijFeiaHYyqEe8hw-E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100106

On s390 the Python extension build fails as follows when using a linker
that is configured to treat text relocations (TEXTREL) in shared
libraries as error by default:

  GEN     python/perf.cpython-314-s390x-linux-gnu.so
/usr/bin/ld.bfd: error: read-only segment has dynamic relocations

This occurrs because util/llvm-c-helpers.o is erroneously built from
util/llvm-c-helpers.cpp without compiler option -fPIC but linked into
the shared library (via libperf-util.a(perf-util-in.o)).

On s390, object files must be compiled as position-indepedent code (PIC)
in order to be linked into shared libraries.  Commit a9a3f1d18a6c ("perf
s390: Always build with -fPIC") added compiler option -fPIC to CFLAGS
for s390, which is used in C compiles.  Add -fPIC to CXXFLAGS for s390
as well, so that it is also used in C++ compiles.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    This patch applies on top of the perf-tools-next tree:
    
      git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git  master
    
    Note that this resolves the issue discussed in thread "[PATCH 1/1] perf
    build: Fix Python extension build with GCC 16 hardening":
    https://lore.kernel.org/all/ahV2XGx_6h7upuc3@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com/T/

 tools/perf/Makefile.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 333ddd0e4bd8..33f90968c8a9 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -109,6 +109,7 @@ endif
 
 ifeq ($(ARCH),s390)
   CFLAGS += -fPIC
+  CXXFLAGS += -fPIC
 endif
 
 ifeq ($(ARCH),mips)
-- 
2.53.0

