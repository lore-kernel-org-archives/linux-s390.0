Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9272246C855;
	Thu,  8 Oct 2026 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448302; cv=none; b=FkIEDQhGBRGdC1+7k5IAkIg8/lChsdwPCD/JrXoC0LePINr6KCcIvGRAafeM5kSRA/+vYXfIs33kqd5T2tgKtWEkBK7LaM7rCO08HsFRkpO3cbhUtfKS1fPaJ6tdEdn9BNNNQ327HoxnbiXPG+CRpOHpb+WzOU/kOm9sf/0NuoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448302; c=relaxed/simple;
	bh=1HLOkeEih66TiJr9kLA854CTEm2xbjpoGk5OKoiDs9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EBFHGFlfVu/gnww/OJRJSedJNuweHGw61R4MKR7j8gHj1cnRmb36yuxruQYlwziWpcxu4cMVqrFucKYocvMmvUd+w0DOmJ0uQ7ww8iNUSeQvvVAVfoJoVhPw5AXQwO5ty6wstvnXQAh3sVADY/diUv5K2yGZUaFKjSk1wExnyJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GRK4doEm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GRK4doEm"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987akQ0733361;
	Thu, 8 Oct 2026 08:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mFUGja
	bUeqPYTpM4X7umWbwgtoWE4iaZci6j5b0zaGY=; b=GRK4doEmgDsqoPyq0ls0B5
	u0BMdG76kg8Ow1aAdcgPmQC2gPP3FaQtcfNS0wNXAjKyCxjB6vlL5kUvxJRvdHDH
	lz1uUG8D1AUS8BURGo8xw0FFCoV6r22+CEC97p7XUtchA4eOoIID+GLcmSovSiL2
	8NIWUCDPTvVPe7bcnrYVwMja6stVPXCmzwfHy7JBmhNfConnE0aHWb955Dt5qoOG
	zuzJqz7X0fMXG7N7hUmSSbqzSQnM6UTbMeBtf9OlXIUes+AtM8URYIXKqSTp1WgJ
	Xm63QH96eZioNc6B8V0Mf+Hr7/xQ0KbS2xDvDkqPZPWhTH5ywAmEEo8/S8OUKF8A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvj6ra-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 08:31:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6987IXxN3107263;
	Thu, 8 Oct 2026 08:31:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h58ek6jsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 08:31:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6988VHGR55706024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 08:31:19 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A13F2005A;
	Thu,  8 Oct 2026 08:31:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB8062004F;
	Thu,  8 Oct 2026 08:31:16 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 08:31:16 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Thu, 08 Oct 2026 10:30:48 +0200
Subject: [PATCH RFC 2/2] s390/topology: Enable SCHED_IDLE_SMT_PRIO
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-hiperdispatchfix-v1-2-73fe41081070@linux.ibm.com>
References: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
In-Reply-To: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Andrea Righi <arighi@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: j5YWq-EPwzi9JWXtTV_xVcXe3IylvXP0
X-Proofpoint-ORIG-GUID: ifzNgXMnbZBTFeg1wUxRilWHnYJm5mFZ
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac754db cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=9csfG863fjXLTZWW9NgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfX9U+VeGYGgsb+
 9QoJa1yFf5ve5nnUlZ8n+OZ9G8MkLyMVwJC2U2lgU+fGFAuIB3r628LS3aBVdDwmmgR2MHoKVI1
 nOA3LsS6GRSq96naaKPHKgTHATfbJJ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfXzIBUAT/Dvt8f
 L6JxfK0K58dteS8ikQSNd4XW1L90wuq+qyK9j0YbQgwHPlYjJb5TMrnMat1hpxD8rEDR299+ecK
 AG2iEgQuG4C0JFYpCSddrkjvFppzx/ialPcw4TGqdWU3yjbRGPneIXP2PgWQyUYSYouL0YY5Qu3
 tNT255pkyLZrZroSVh6INPbqZjQCixttpCNJ5XSFYK0lPK46MyIgzcWJBic1mGEw9L/PD3mOSBF
 P6Jqxd22r+obA5PRtngGl6vmPEwdm3iKhQvD3aD5Uobp3jo5P3HVP9ZkMT7MkO8NoYzSC5FRGT1
 Ch7PEhTW8ym0/ueW7Zcd451AMfTzhskij/P/msxptA4BC1h719jwaDjGmsT+tKAHRTEyRfzsB3u
 53tvQO7N19e1EghrIZPp0lPUTgmxx3g9MDRG8Gn/y12Gm832Qxd4bL7f+tDlv4MCy8T09iGx74A
 AtzHdLs9hgCNhUshErA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080032

On s390, vertical polarization configuration assigns CPUs different
polarization values and capacities. These capacities represent the
virtual runtime being assigned to the shared CPUs by the underlying
hypervisor. Consequently running load on high capacity cores, even if
the SMT sibling (SMT=2 on s390) of a given core is busy is more
favorable compared to a fully idle low capacity CPU.

Implement arch_needs_idle_smt_prio() to enable the sched_idle_smt_prio
static branch when the machine has hardware backed topology.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/s390/Kconfig                | 1 +
 arch/s390/include/asm/topology.h | 5 +++++
 arch/s390/kernel/topology.c      | 9 +++++++++
 3 files changed, 15 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 4b51bc6e8948..bd6c826a24af 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -564,6 +564,7 @@ config NODES_SHIFT
 config SCHED_TOPOLOGY
 	def_bool y
 	prompt "Topology scheduler support"
+	select ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO
 	select ARCH_SUPPORTS_SCHED_SMT
 	select ARCH_SUPPORTS_SCHED_MC
 	select SCHED_SMT
diff --git a/arch/s390/include/asm/topology.h b/arch/s390/include/asm/topology.h
index 44110847342a..f0f5477565db 100644
--- a/arch/s390/include/asm/topology.h
+++ b/arch/s390/include/asm/topology.h
@@ -49,6 +49,11 @@ void update_cpu_masks(void);
 void topology_expect_change(void);
 const struct cpumask *cpu_coregroup_mask(int cpu);
 
+#ifdef CONFIG_SCHED_IDLE_SMT_PRIO
+#define arch_needs_idle_smt_prio arch_needs_idle_smt_prio
+bool arch_needs_idle_smt_prio(void);
+#endif
+
 #else /* CONFIG_SCHED_TOPOLOGY */
 
 static inline void topology_init_early(void) { }
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 42fc0294f543..6f28e2f1afec 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -344,6 +344,15 @@ int arch_update_cpu_topology(void)
 	return rc;
 }
 
+#ifdef CONFIG_SCHED_IDLE_SMT_PRIO
+bool arch_needs_idle_smt_prio(void)
+{
+	if (topology_mode != TOPOLOGY_MODE_HW)
+		return false;
+	return true;
+}
+#endif
+
 static void topology_work_fn(struct work_struct *work)
 {
 	rebuild_sched_domains();

-- 
2.55.0

