Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AED257448;
	Mon, 24 Mar 2025 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830094; cv=none; b=PmK+h8hV4NpnV4eYQcGmm3p7Rn+9+lB+ncnrTDANqeNQ4FXoLPDfpemXJUL88qtzMcMXenqedzaJpgEqcqsHRVbCuNw+FUKnIUSlA60k/+mmOoZX5jmZPwMYFFfSfOV6oBwS4Bf6KqqKb3yzLOfngyhnjKSaLdXm7C1OtQWbznA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830094; c=relaxed/simple;
	bh=cqMO73am4Bc9cZMTcysm5XHve1x61DpjXMsSPTeDOXs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kcCM6sBldGyeKP3H6ciNlroZJnQQFqN/Yu3Rsd/hZbG52pjtzMT9K09doWLQVakeET3j/LiZJnLK10UxqXUnZ8BWYlKvE8ZA42i6hIyaw0X6sXQouUhbi1f/HtfogcB9hNCfLjnGL4XgQpSPX3DpqQkS+y98ifxPlpYagNwSUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F7oC7x30; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F7oC7x30"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52O9qBGA011754;
	Mon, 24 Mar 2025 15:28:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6KBh66XSYbfoHzXoObK9YPJS8KJVf8KWJEG4ORUaa
	v4=; b=F7oC7x306wEqvSZ6SJJ+CcaM6HPJ7r3NqP1FCliTF0iyXHA8w/lqDZI5P
	N2ri/vfml9OHeEdtbCQh8HoWLL+jwEK9MRaPK1tNM6zQYNXGGj13tlncGm+g601t
	JzeR9/ZG5RbLLlb2zvbG0PgNwGijn2MRRySMTlczFTXF8vGWNIocPF2OZzgJP4AG
	2+f9T9mZkh1AwAc0JOUxvVxntgV5d86PgZzCFxFQG7ofAQ4yuQDbWkhXfUBEeH4o
	vZrGPeVn0SNRLO8eoF0A8AHodxuZJzCEom+QjxJcjJ3iAJX/UMtbBrKMv/X32f9a
	gWuVEkwS9f+/PUqCaEEnzeeBE6Khg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jsh04cc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 15:28:08 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52OF4j3f011715;
	Mon, 24 Mar 2025 15:28:08 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jsh04cc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 15:28:08 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52ODEI7W009737;
	Mon, 24 Mar 2025 15:28:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkemgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 15:28:07 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52OFS4YW9175464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 15:28:04 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D3DD20049;
	Mon, 24 Mar 2025 15:28:04 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0569620040;
	Mon, 24 Mar 2025 15:28:04 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 15:28:03 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org,
        irogers@google.com, james.clark@linaro.org
Cc: agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] perf trace: Fix wrong size to bpf_map__update_elem call
Date: Mon, 24 Mar 2025 16:27:56 +0100
Message-ID: <20250324152756.3879571-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tVYJXf0O80kRZA_uEUXg36habZPJSido
X-Proofpoint-GUID: UgLw_rgWeC3n3kF4SmRo3CF77DFCAdyX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=979 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240112

In linux-next
commit c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t")
causes the perf tests 100 126 to fail on s390:

Output before:
 # ./perf test 100
 100: perf trace BTF general tests         : FAILED!
 #

The root cause is the change from int to int16_t for the
cpu maps. The size of the CPU key value pair changes from
four bytes to two bytes. However a two byte key size is
not supported for bpf_map__update_elem().
Note: validate_map_op() in libbpf.c emits warning
 libbpf: map '__augmented_syscalls__': \
	 unexpected key size 2 provided, expected 4
when key size is set to int16_t.

Therefore change to variable size back to 4 bytes for
invocation of bpf_map__update_elem().

Output after:
 # ./perf test 100
 100: perf trace BTF general tests         : Ok
 #

Fixes: c760174401f6 ("perf cpumap: Reduce cpu size from int to int16_t")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
---
 tools/perf/builtin-trace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 092c5f6404ba..464c97a11852 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4375,10 +4375,12 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		 * CPU the bpf-output event's file descriptor.
 		 */
 		perf_cpu_map__for_each_cpu(cpu, i, trace->syscalls.events.bpf_output->core.cpus) {
+			int mycpu = cpu.cpu;
+
 			bpf_map__update_elem(trace->skel->maps.__augmented_syscalls__,
-					&cpu.cpu, sizeof(int),
+					&mycpu, sizeof(int),
 					xyarray__entry(trace->syscalls.events.bpf_output->core.fd,
-						       cpu.cpu, 0),
+						       mycpu, 0),
 					sizeof(__u32), BPF_ANY);
 		}
 	}
-- 
2.48.1

