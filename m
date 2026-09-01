Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37871191F91
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273640; cv=none; b=dHmYCkwDfD7kSrVvsXa+WNEdTOODOBmNrwV4etT85vgWIWkyGYZoobS/OqqTysyR7l8OnVNVjQa/4zI35Itt4r4I0YYBChQTT1/FhibPWgsgnMU+kFYpWwWJNqN02NK5XSRAoxQnkfqG/ue+xKN23PSPrNBoCNJ8d7D6FkgtTjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273640; c=relaxed/simple;
	bh=/ORZ3jdKVVxOWI0p7cjCosiBbFeP6JDYkNidqdAG06o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rs/jcgPBs+YqardDX0f8Xk/IiSck5uftwIIB4juLoN0W/50SXplLfITYmHL8PEs3Q2p4SDOUzzMHLF+raw5DcNWHE3hJsO3elOyAQAX/nTghQro5gDTNY/YvBypUFnalmaFfMp3u4L0q5Lei+DoUQ6HbbWZAemc9EXk8GPBlgNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qRKlVZFO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qRKlVZFO"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681EVk7j1510755
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 14:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=k4P06EWohSNkBWD9oR19d8riSGtz
	RIkDN0PVn1Fvzqg=; b=qRKlVZFOQbHdXv0gQqkDrs6IBDQKhx0EBorVJ0NUrfUQ
	dxM1OPBSH6XDrUd2i33DUuSPMKM6MHzEQZXLkew6qfiGMeK552L7z4/CPkpIfSXm
	Wnpv4dsR34yKn2wKMqwKueVn2Hc5RXg/LdQqVP0m7vD10mUz40IbYqaes855FrNr
	5yRJ1glgpr5lNAEAKB4ewQXKW6PClrOZbjLuD0rqbc1V+bbzXD4LJNDTHZUW1eGd
	NjQpMlhoPVzHhFP0tCXZOsmBDZgYZzYMl7vjM9sNvlD80D2thRadw0aFMfu44IGM
	NEYT6lHu0jVLFmfUfeyIRg3CmU08e4+X8XJ0BqlA4A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t84p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 14:40:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 681EQG36014272
	for <linux-s390@vger.kernel.org>; Tue, 1 Sep 2026 14:40:37 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbygc1k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 01 Sep 2026 14:40:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 681EeXOY45678902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 14:40:33 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 353E920043;
	Tue,  1 Sep 2026 14:40:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BEF620040;
	Tue,  1 Sep 2026 14:40:33 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 14:40:32 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Tue, 01 Sep 2026 16:40:26 +0200
Subject: [PATCH] s390/topology: Enable ASYM_PACKING to establish cpu
 priority
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-s390_sd_flags-v1-1-6755ba191d5a@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDC2ND3WJjS4P44pT4tJzE9GLdVBOTpGRTQ8s0S2MjJaCegqLUtMwKsHn
 RsbW1AHQN6vpfAAAA
X-Change-ID: 20260831-s390_sd_flags-e44bc519f932
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a96e3e5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=8NN5ffrl5VWzh4IbXNkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyOSBTYWx0ZWRfXx9hbW4GSATl5
 p3/YJe0vebHqc2BiwuVBrN41gl1sBdDdWhqPjEIEg5occUGtRDmg6RrWo3HJzK8biZS4i4+PKT4
 MGIdyurdTHajtZRGrj1g9moIfJ/IY2Q=
X-Proofpoint-ORIG-GUID: wiT_QGY2UYGYOANhV_dA46vgKjPknrp7
X-Proofpoint-GUID: wiT_QGY2UYGYOANhV_dA46vgKjPknrp7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyOSBTYWx0ZWRfX4G6FLb/ZHnEy
 fNKq8w4vcDtNdsZiYBzwQ3Yvf2N/AOX/9T2K5t9Q8neyDbJGYPN1lG29qlIufA3dS3WXQ/yirbM
 dpk8QWNOILxgKmvXtTE8b1kwKKre/E05xqojLzcvsCuDZr/kcfCK8tmWL4RLB1NSUQLdNBygpmD
 ouhnYkM5p0f9aScvEPyrnek8aff1m7hJM3oW1N/EJ119UnizziPRHD9y1pebKK+xNrSNpiSXdhO
 60gS702ruCe+P+3Y2XogIR0ZUgS5DZnMAZi8ROwL5HeK1Bm+wMDnrAS/kciYrcAEU6mlrF3wKuX
 JK/+ixkMO2m+2XMCsPmYW8BiQ4enWV+/pPEcM3DnFsJFZaKFsHcoO5LgzJW6Y4WXGsVz5Dpgigv
 tE3smSHWf089uqaVKhIPJP8wBV9ws4Bfo+n1sPiWwTUOtBGR83548xoGfBk+0OGhcIVH4zerCpW
 0DHodgjXilnWp8vZw0w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010129

On s390 LPARs the hypervisor assigns varying CPU runtime capacities
under vertical polarization, making CPUs unequal. Add SD_ASYM_PACKING
into topology level flag callbacks so the scheduler keeps busier
scheduling groups packed onto higher-capacity CPUs.
Implement arch_asym_cpu_priority() using smp_cpu_get_capacity() as
the decision factor. Subtract the CPU number so that the CPUs with
lower ids are prioritized.

Only enabled on LPAR level as other guest levels either do not have
vertical polarization (which causes asymmetric CPUs), or machine backed
topology.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
Under vertical polarization, LPAR cpus get different capacities assgined
to them by the underlying hypervisor. This creates an asymmetric
configuration where the scheduler should prefer packing work onto
higher capacity CPUs rather than spreading it uniformly.

Introduces arch_asym_cpu_priority() backed by smp_cpu_get_capacity()
so the scheduler has a per-CPU priority signal. Add SD_ASYM_PACKING 
to topology levels, enabling asym_packing load balancing.

Note: I initially started working to add both SD_ASYM_PACKING and
SD_SHARE_LLC to multiple topology levels but now I discovered that there
are still a bit more that I am unsure about how cache is being managed
by kernel so I am sticking to adding SD_ASYM_PACKING only for now.
Wether to introduce SD_SHARE_LLC flag to more topology levels is left
for future work.

Benchmark Results:
----------------------------------------------------------------------
I ran experiements with different combination of flags on different
topology levels. On an LPAR with 24 COREs spanning multiple DCMs
(BOOKS);

CPU NODE DRAWER BOOK SOCKET CORE POLARIZATION
  0    0      0    0      0    0 vert-high
  1    0      0    0      0    0 vert-high
  2    0      0    0      0    1 vert-high
  3    0      0    0      0    1 vert-high
  4    0      0    0      0    2 vert-medium
  5    0      0    0      0    2 vert-medium
  6    0      0    0      0    3 vert-low
  7    0      0    0      0    3 vert-low
  8    0      0    0      0    4 vert-low
  9    0      0    0      0    4 vert-low
 10    0      0    0      0    5 vert-low
 11    0      0    0      0    5 vert-low
 12    0      0    0      1    6 vert-low
 13    0      0    0      1    6 vert-low
 14    0      0    0      1    7 vert-low
 15    0      0    0      1    7 vert-low
 16    0      0    0      1    8 vert-low
 17    0      0    0      1    8 vert-low
 18    0      0    0      1    9 vert-low
 19    0      0    0      1    9 vert-low
 20    0      0    0      1   10 vert-low
 21    0      0    0      1   10 vert-low
 22    0      0    0      1   11 vert-low
 23    0      0    0      1   11 vert-low
 24    0      0    1      2   12 vert-low
 25    0      0    1      2   12 vert-low
 26    0      0    1      2   13 vert-low
 27    0      0    1      2   13 vert-low
 28    0      0    1      2   14 vert-low
 29    0      0    1      2   14 vert-low
 30    0      0    1      3   15 vert-low
 31    0      0    1      3   15 vert-low
 32    0      0    1      3   16 vert-low
 33    0      0    1      3   16 vert-low
 34    0      0    1      3   17 vert-low
 35    0      0    1      3   17 vert-low
 36    0      0    2      4   18 vert-low
 37    0      0    2      4   18 vert-low
 38    0      0    2      4   19 vert-low
 39    0      0    2      4   19 vert-low
 40    0      0    2      4   20 vert-low
 41    0      0    2      4   20 vert-low
 42    0      0    2      5   21 vert-low
 43    0      0    2      5   21 vert-low
 44    0      0    2      5   22 vert-low
 45    0      0    2      5   22 vert-low
 46    0      0    2      5   23 vert-low
 47    0      0    2      5   23 vert-low

Overall the results from different benchmarks are all positive;

baseline : mc flags -> SD_SHARE_LLC
           others   -> 0

mc_all   : mc flags -> SD_ASYM_PACKING | SD_SHARE_LLC
           others   -> 0

set_all  : mc flags     -> SD_ASYM_PACKING | SD_SHARE_LLC
           book flags   -> SD_ASYM_PACKING | SD_SHARE_LLC
           drawer flags -> SD_ASYM_PACKING | SD_SHARE_LLC

book_asym: mc flags     -> SD_ASYM_PACKING | SD_SHARE_LLC
           book flags   -> SD_ASYM_PACKING
           others       -> 0

patch    : mc flags     -> SD_ASYM_PACKING | SD_SHARE_LLC
           book flags   -> SD_ASYM_PACKING
           drawer       -> SD_ASYM_PACKING

Hackbench
======================================================================

$ hackbench -T -p -l $loops -f $fd -g $g

group/fd  baseline  mc_all set_all book_asym   patch
--------  --------  ------  ------ ---------  ------
  g1 fd1     2.020  +22.7%   +6.4%    +45.3%  +10.3%
  g1 fd2     4.719  -16.6%  -18.6%    -22.6%  -20.7%
  g1 fd4     6.703   -1.5%  -19.1%    -21.6%  -14.9%
  g1 fd8     8.001   -0.5%   -8.5%     -9.3%  -14.3%
  g2 fd1     1.516  -17.5%   -9.4%    -31.7%  -31.9%
  g2 fd2     6.590  -11.6%  -29.9%    -32.4%  -26.9%
  g2 fd4     8.245  -14.1%  -24.4%    -23.4%  -23.9%
  g2 fd8     8.827   -3.0%   +1.5%     +1.0%   -4.1%
  g4 fd1*    0.566  +10.2%   +6.4%     -1.8%  +33.9%
  g4 fd2     3.077  -10.8%  -20.6%    -20.2%  -14.9%
  g4 fd4     8.822  -16.7%  -17.4%    -18.3%   -9.9%
  g4 fd8    11.078   -1.8%  -14.6%    -14.8%   +1.9%
  g8 fd1     0.540  -13.1%  -34.8%    -39.3%  -20.9%
  g8 fd2     1.718   -6.2%  -14.8%    -15.0%   -4.4%
  g8 fd4     4.732   -0.6%  -11.6%    -11.3%   -1.5%
  g8 fd8    18.278   -2.8%   -7.3%     -8.0%   -4.0%

Results are in seconds of completion, lower is better
* "4 groups 1 file descriptor" case run for too short of and amount of
  time causing inaccurate results. Repeated individual runs with longer
  runtimes show positive impact of patched kernels.

Stress-ng
=====================================================================
Repeated stress-ng experiments from 6 stressors with an increment of
6 after each run until $(nproc) stressors. Metrics is bogo-ops higher is
better.

$ stress-ng -M --matrix-3d $cpu --matrix-3d-method mult --timeout 10

cpu     baseline       mc_all     set_all   book_asym       patch
-----------------------------------------------------------------
   6    110059.00    -0.2053%    -0.5579%    -0.5161%    -0.4425%
  12    218074.00    -0.2164%     -1.554%     -1.122%     -1.554%
  18    303547.00    +0.0602%     +6.943%     +7.037%     +6.532% 
  24    370629.00    -0.6416%     +12.17%     +12.13%     +4.945%
  30    426237.00    +0.4155%    +0.8521%     +1.031%    +0.2311%
  36    426766.00     -1.336%    -0.5235%    -0.1186%    -0.0314%
  42    424059.00     -1.558%    -0.6162%    -0.5308%     -1.294%
  48    416659.00     -1.363%    -0.3108%    -0.6797%     -1.244%

$ stress-ng -M --vm $cpu --vm-bytes 128M --timeout 10

cpu       baseline     mc_all   set_all   book_asym     patch
-------------------------------------------------------------
  6     4257228.00     -1.39%   +5.296%     +4.911%  -0.5117%
  12    8630030.00    +1.375%   -3.333%    0.03611%   -3.967%
  18   12137905.00     +6.66%   +6.756%     -2.597%   +9.711%
  24   15610271.00   -0.5227%   -5.556%    +0.8526%  -0.6858%
  30   18481251.00    -6.841%    -6.63%     +1.429%   -6.102%
  36   19837178.00   -0.7821%   +1.292%    -0.9471%   +1.121%
  42   20220039.00    +1.137%   +9.447%    +0.2035%   +9.083%
  48   23093876.00    -0.255%   -1.515%     -1.032%  -0.7902%

$ stress-ng -M --mmapfork $cpu --mmapfork-bytes 128M --timeout 10

cpu     baseline   mc_all    set_all   book_asym      patch
-----------------------------------------------------------
  6     3355.00   +8.346%    +9.538%     +15.86%    +14.22%
  12    5883.00   +6.612%    +6.986%     +12.99%    +11.68% 
  18    8045.00   +4.214%    +6.986%     +6.439%    +7.744%
  24    9682.00    +3.47%    +5.206%     +5.412%    +8.056%
  30   10889.00   +3.958%   +0.8173%     +3.049%    +4.656%
  36   12070.00  -0.3148%     -2.61%     +2.005%    +1.939%
  42   12792.00  +0.7739%    +1.845%     +2.955%   +0.8521%
  48   13609.00   -1.367%     +1.19%     +0.316%    +4.321%

OpenBlas
=====================================================================
Openblas testcase is a series of matrix operations with different
sizes of matrices. The distribution of the measurements is important to
notice in these results. (Unit: FLOPS/s)

Metrics      baseline       mc_all      set_all     book_asym         patch
---------------------------------------------------------------------------
 Mean      66.07 MF/s   72.26 MF/s   82.33 MF/s    79.83 MF/s    82.87 MF/s
 Median     1.66 MF/s   18.19 MF/s   38.12 MF/s   30.56 MFs/s    42.64 MF/s
 Min       36.39 KF/s   50.99 KF/s   77.50 KF/s   41.84 KFs/s    34.07 KF/s
 Max      831.80 MF/s  832.73 MF/s  828.87 MF/s  858.38 MFs/s   842.45 MF/s

Percentile      baseline       mc_all       set_all    book_asym        patch
---------------------------------------------------------------- ------------
 25th pct    717.60 KF/s  642.21 KF/s    17.93 MF/s   15.33 MF/s   23.99 MF/s
 50th pct      1.66 MF/s   18.19 MF/s    38.12 MF/s   30.56 MF/s   42.64 MF/s
 75th pct     79.16 MF/s   98.09 MF/s    94.34 MF/s   95.89 MF/s   77.97 MF/s
 90th pct    219.63 MF/s  210.93 MF/s   214.10 MF/s  212.97 MF/s  209.31 MF/s
 99th pct    477.66 MF/s  494.59 MF/s   520.22 MF/s  491.37 MF/s  524.82 MF/s

The results are similar when hiperdispatch is modifying the cpu
capacities and when capacities stay the same.
---
 arch/s390/kernel/topology.c | 34 +++++++++++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 1377c6f3f670..6d4b7be029c3 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -527,11 +527,39 @@ static const struct cpumask *tl_drawer_mask(struct sched_domain_topology_level *
 	return &cpu_topology[cpu].drawer_mask;
 }
 
+static int s390_core_flags(void)
+{
+	int flags = cpu_core_flags();
+
+	if (machine_is_lpar())
+		flags |= SD_ASYM_PACKING;
+	return flags;
+}
+
+static int s390_book_flags(void)
+{
+	if (machine_is_lpar())
+		return SD_ASYM_PACKING;
+	return 0;
+}
+
+static int s390_drawer_flags(void)
+{
+	if (machine_is_lpar())
+		return SD_ASYM_PACKING;
+	return 0;
+}
+
+int arch_asym_cpu_priority(int cpu)
+{
+	return smp_cpu_get_capacity(cpu) - cpu;
+}
+
 static struct sched_domain_topology_level s390_topology[] = {
 	SDTL_INIT(tl_smt_mask, cpu_smt_flags, SMT),
-	SDTL_INIT(tl_mc_mask, cpu_core_flags, MC),
-	SDTL_INIT(tl_book_mask, NULL, BOOK),
-	SDTL_INIT(tl_drawer_mask, NULL, DRAWER),
+	SDTL_INIT(tl_mc_mask, s390_core_flags, MC),
+	SDTL_INIT(tl_book_mask, s390_book_flags, BOOK),
+	SDTL_INIT(tl_drawer_mask, s390_drawer_flags, DRAWER),
 	SDTL_INIT(tl_pkg_mask, NULL, PKG),
 	{ NULL, },
 };

---
base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
change-id: 20260831-s390_sd_flags-e44bc519f932

Best regards,
-- 
Mete Durlu <meted@linux.ibm.com>

