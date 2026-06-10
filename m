Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C73FFD;
	Wed, 10 Jun 2026 11:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781090648; cv=none; b=XFAeDgFjkDWMW9rRplcF8BpP+VJkfqVaShOiTg2NpZoM14Se28mqqohuXMv/DFe+88avaKXmyUHZNydb81hv2TCNTO56GCflMZ3NI4W4aVd4+7CVsbuND0EbSY1KZnxgdq9nGUjwjfrkEEaOqcrZD8ZMh1Yv3bK3GBhQ+rKcFhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781090648; c=relaxed/simple;
	bh=pUpRXCJeYDureFfDynMd3TzKzqYVMIXcM5TirXI1gp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QT59qxTH1SpQ3ThnbbYyDL1zGkCQBdEtQ5TNRRvJUTh3nDVwPdacHN6UbU3kFY8eWN5jEunAusmyuyy/O661QfiOprUat/y+G2k0s0/G006uV4Lhdv+Rl5k8GHuYsD0kcdIGRGTeibaQ8ms2Lrn62hsM1bSonSSo8tD68+zfrVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sgf24A2f; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sgf24A2f"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A91q3t089638;
	Wed, 10 Jun 2026 11:23:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=dBG+f+IsuyekbzMiS39ZCnJJO4H44X1SWNb6nWfT2
	6A=; b=sgf24A2flu36vQjksGAMBl8WNcE+TkxDWNNlhXXS+KecF1Pyvbd3OPQYE
	NEg+et2dzOCj2XyM6MrSHqWIMLwm4ExJX7F5UCgN4GMKJC+rr4NSVHuy6MOk2+dY
	zIiLldicz6HvDE+TRPb+TWEfRpeEc25pjxz7ph3FIQvrC7h8/YHjhmEoZSirPf/j
	AKlAqemDr4SsDXwf8+xUzhi74Qbxgx1GoyxkkR/90q2KWb2n/nC/oJYICV8aK9kM
	fNvJC+7EnAwrdnv+hrnAeT8Z3P7xWWtyqHDk02B+b4enlbqlaLv4FfTITy80tjrR
	7cOhJA1KO4AcJrsk1xxkzqvBwmSQA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4em8yj0kmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 11:23:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ABJgCL030290;
	Wed, 10 Jun 2026 11:23:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w6g9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 11:23:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65ABNkbC45941022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 11:23:46 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 959C420040;
	Wed, 10 Jun 2026 11:23:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62E5020043;
	Wed, 10 Jun 2026 11:23:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 11:23:46 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-s390@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Jens Remus <jremus@linux.ibm.com>, Jan Polensky <japo@linux.ibm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH] perf build: Do not duplicate CFLAGS in Python extension builds
Date: Wed, 10 Jun 2026 13:23:43 +0200
Message-ID: <20260610112344.1550111-1-jremus@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEwNiBTYWx0ZWRfX9Mbs9daEhf+q
 bL9DUbLLaQD+cLDyo1Hz5NYpksjOa7AWD5+4EZwDAe5Mm48Q3rN3tZKtvrVjksh+WRSvXYQUHqD
 Dwq3O/lqdGljwsvKHMIJJJb+6h8A6rdrcl5YQB2V5M4uB1xgidN7qTVn4QXkc9J43ujpIslj5pz
 lzFZlXJV9BCg62FftfIBClG4YHpi7y1AckoBYw0Td493F95iK5Tf3L3DDDdLXdzZyREiSt16cPN
 28uPiA73xFXdOoxDV0/O8U3tqnuLDz7R/CACKBOrSSffprIzLSUwF5bWnxZMwK25e4BTKQdKYIa
 cd7I9NF/2euX/jkMZIpz+G+UATgjqmxdHTP+FCicimh8OSThY4R9gbKBmDE2ZtKsBbEuN77mxDh
 FApNd3Xceh6BFDQFIUBlQZY/kDQAUyYEz74IjaY/RwxoR8RLeBx1h1pp/jtkq7IXqS/hO0BQo7K
 Ms0qinW8a+DQPh+RyYw==
X-Authority-Analysis: v=2.4 cv=HvFG3UTS c=1 sm=1 tr=0 ts=6a294947 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=kE5x8IjORJKvRFKnvmUA:9
X-Proofpoint-ORIG-GUID: SCwZbRCyN-P3QowVNWjgEM4eBZA67Mst
X-Proofpoint-GUID: DV0mwfYpUEAxSJViffKDNAl9PFvLosqR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 lowpriorityscore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100106

setuptools already uses CFLAGS.  Passing CFLAGS with additional flags as
extra compile arguments causes CFLAGS to effectively get passed twice:

$ make -C tools/perf V=1 JOBS=1
...
building 'perf' extension
gcc [CFLAGS] -fPIC -Iutil/include -I/usr/include/python3.14 \
  -c /root/linux/tools/perf/util/python.c \
  -o python_ext_build/tmp/root/linux/tools/perf/util/python.o \
  [CFLAGS] \
  -fno-strict-aliasing -Wno-write-strings -Wno-unused-parameter \
  -Wno-redundant-decls -Wno-cast-function-type \
  -Wno-declaration-after-statement

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    This patch applies on top of the perf-tools-next tree:
    
      git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git  master
    
    Note that my "[PATCH v2] perf build: Respect V=1 for Python extension
    builds" [1] needs to be applied to actually observe the Python extension
    build command and output with V=1.
    
    [1]: https://lore.kernel.org/all/20260608160613.3153795-1-jremus@linux.ibm.com/

 tools/perf/util/setup.py | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index b65b1792ca05..a0ce76624a23 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -74,18 +74,17 @@ class install_lib(_install_lib):
         self.build_dir = build_lib
 
 
-cflags = getenv('CFLAGS', '').split()
 # switch off several checks (need to be at the end of cflags list)
-cflags += ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
+extra_cflags = ['-fno-strict-aliasing', '-Wno-write-strings', '-Wno-unused-parameter', '-Wno-redundant-decls' ]
 if cc_is_clang:
-    cflags += ["-Wno-unused-command-line-argument" ]
+    extra_cflags += ["-Wno-unused-command-line-argument" ]
     if clang_has_option("-Wno-cast-function-type-mismatch"):
-        cflags += ["-Wno-cast-function-type-mismatch" ]
+        extra_cflags += ["-Wno-cast-function-type-mismatch" ]
 else:
-    cflags += ['-Wno-cast-function-type' ]
+    extra_cflags += ['-Wno-cast-function-type' ]
 
 # The python headers have mixed code with declarations (decls after asserts, for instance)
-cflags += [ "-Wno-declaration-after-statement" ]
+extra_cflags += [ "-Wno-declaration-after-statement" ]
 
 src_perf  = f'{srctree}/tools/perf'
 build_lib = getenv('PYTHON_EXTBUILD_LIB')
@@ -94,7 +93,7 @@ build_tmp = getenv('PYTHON_EXTBUILD_TMP')
 perf = Extension('perf',
                  sources = [ src_perf + '/util/python.c' ],
 		         include_dirs = ['util/include'],
-		         extra_compile_args = cflags,
+		         extra_compile_args = extra_cflags,
                  )
 
 setup(name='perf',
-- 
2.53.0

