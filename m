Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDDC3090C6;
	Mon, 13 Apr 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077277; cv=none; b=WqGVW1nw6Ol8SyrtknexGBBNxyms46ber8kIftYZdWvc7p8+roZip8v37XlLMwOJFXGoAhrmNg5Ujo6Azqi93jZ5OqBnMpnlqOFMeLhFG59LFVQRySwHBxPiadsEtpbZv6GP+0SaBXynIkUT/Z+lQbxcLz08TRvvVFmaLBEKouM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077277; c=relaxed/simple;
	bh=xSekhLkvHaQlwo1ocrIfSQQzadDzQ5pa8Oh+oL7O+nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VRsAHW24klVIxUgt3R1eUXwmLSU4jJcATXLRB9GIRHI32IJ54Ps1pw3qGPUZ3xcrynKDWQGiUMOPlbQi8CnVu3VRaHdqbL1WW+MwcNqHuc5tMD8OL7MlNixL05zUZntPGFolb2ClrYSkJlmpZeG9HF8Y7dUX8u38Az3J6RmjrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l2R280gy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l2R280gy"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63CLPUIB3155838;
	Mon, 13 Apr 2026 10:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QACN+kRhzKyhXJdOc
	2SYoJgKKdiDpMYQlH2B+c5iUSc=; b=l2R280gyq6++MZK1wuTWLoX5HHB1PXnhA
	UZ+D9zUsX8xPtfpWkbIJo0bgcJTcUoJ98Wsqn7T22TXsf3rkhoTGVkho9jJtF+Oh
	vfHR4THfSrRcshwmjteE+oC8hErlLSSexDEBGAprBE7Q4FoKGn4duGNhIa4FxOBK
	RhR8MZDOUXBxgjV+vMwXGlhYRDuUb43DNqkBwRNGcNDqBFck+LXUoHo9ENFzO7NE
	4V/i60ypdWlMZj161tH75viZrEvH9OUdiiJvRfj4+5Szri91rwnoHiZFL7oh91Gr
	+PqTW6y5ipqsacFwQAHdCQlPUgLgizfwpgM74rV5a10KCGrpLpqhw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfbqkf42h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D85fgO031240;
	Mon, 13 Apr 2026 10:47:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10y4wgn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:50 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DAlkoq51315000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 10:47:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD35C2004B;
	Mon, 13 Apr 2026 10:47:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5717F20040;
	Mon, 13 Apr 2026 10:47:46 +0000 (GMT)
Received: from li-9fd7f64c-3205-11b2-a85c-df942b00d78d.ibm.com.com (unknown [9.111.7.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 10:47:46 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        borntraeger@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        Eric Farman <farman@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [GIT PULL 03/12] KVM: s390: vsie: Allow non-zarch guests
Date: Mon, 13 Apr 2026 12:46:31 +0200
Message-ID: <20260413104721.203024-4-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413104721.203024-1-frankja@linux.ibm.com>
References: <20260413104721.203024-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I+9Vgtgg c=1 sm=1 tr=0 ts=69dcc9d7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=TcF5ixnfVCNIaZDrkBwA:9
X-Proofpoint-GUID: aXQN9WUJf9XIzjg2C3aw1d0k1Vg-ryQu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwMSBTYWx0ZWRfXxiZ58atboIxp
 0jMEcpEqStOs2Nj2WgoLgFQUT/mJOCe61tqGkQNtNnuXBdG7ZfhBiJHl6mPBNvrljtJMgFbDvJZ
 Q6B7W6oEleFXhitj5L8iIad7cra+WnM5FuAdpLMsgvk4UvB2Rpt4k4b/QDJEEPiRjfB3hJgjae4
 V+M29g0+hPM+gI/1DojA2Y5yZsg3M5JKRU4qiGdVnNLp0ZkZuy06ZDo3g7FOJ64Sm85SJrL8HMt
 z/HbHAtDfPkcWpZGWIw60ow6qo3nUVgbrdIcNXQstU+wbINghIvVpQZ84h9zc0l1NwausF/iyCf
 JyRo5KnZ43uzzP+IFOLdDj2/261Cou6Hm2JIBqPSeWf/cre7ywxXDGIvLmssd/k+uT7hIwG2/eo
 /osW/1cIVikJd0L/tgTWesdL+o/p3rODggdlGHwy/sDM2hm0QKBlwqskyxB+jQr2A6qba8HbONf
 cSzB4tx+PXZjP/RvXsg==
X-Proofpoint-ORIG-GUID: aXQN9WUJf9XIzjg2C3aw1d0k1Vg-ryQu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_02,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130101

From: Eric Farman <farman@linux.ibm.com>

Linux/KVM runs in z/Architecture-only mode. Although z/Architecture
is built upon a long history of hardware refinements, any other
CPU mode is not permitted.

Allow a userspace to explicitly enable the use of ESA mode for
nested guests, otherwise usage will be rejected.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/kvm/vsie.c             | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 64a50f0862aa..b58faad8a7ce 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -656,6 +656,7 @@ struct kvm_arch {
 	int user_stsi;
 	int user_instr0;
 	int user_operexec;
+	int allow_vsie_esamode;
 	struct s390_io_adapter *adapters[MAX_S390_IO_ADAPTERS];
 	wait_queue_head_t ipte_wq;
 	int ipte_lock_count;
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index d249b10044eb..aa43c6848217 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -125,8 +125,8 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
 	int newflags, cpuflags = atomic_read(&scb_o->cpuflags);
 
-	/* we don't allow ESA/390 guests */
-	if (!(cpuflags & CPUSTAT_ZARCH))
+	/* we don't allow ESA/390 guests unless explicitly enabled */
+	if (!(cpuflags & CPUSTAT_ZARCH) && !vcpu->kvm->arch.allow_vsie_esamode)
 		return set_validity_icpt(scb_s, 0x0001U);
 
 	if (cpuflags & (CPUSTAT_RRF | CPUSTAT_MCDS))
@@ -135,7 +135,9 @@ static int prepare_cpuflags(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		return set_validity_icpt(scb_s, 0x0007U);
 
 	/* intervention requests will be set later */
-	newflags = CPUSTAT_ZARCH;
+	newflags = 0;
+	if (cpuflags & CPUSTAT_ZARCH)
+		newflags = CPUSTAT_ZARCH;
 	if (cpuflags & CPUSTAT_GED && test_kvm_facility(vcpu->kvm, 8))
 		newflags |= CPUSTAT_GED;
 	if (cpuflags & CPUSTAT_GED2 && test_kvm_facility(vcpu->kvm, 78)) {
-- 
2.53.0

