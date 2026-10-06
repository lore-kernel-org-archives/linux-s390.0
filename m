Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F2C3E7BA9
	for <linux-s390@vger.kernel.org>; Tue,  6 Oct 2026 11:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791285207; cv=none; b=ryM0oBpdE0os0GURf3ZVH4jreKk12mYN8jS2q+uXAWssaENmREHTd99RG/drxhGXB17LfCV+Pz5VIvlloMdlcX+6rrKvIH6JEU1kopcAWwaGKolfspvA9On449dYj2Luurq/IOJmcfgEQLtOjj3M0uyKqOaLt4zg3yTn6DWR0Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791285207; c=relaxed/simple;
	bh=kGYuW6cfD0AFYva/syju1ZZTabivr4p3q1MCXvy+S0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFs1dKbcgFxpOTe6mPyr50w7Ydbmaj619J6rD3mFd/mRqd/s5uIG1lDzI8zMmw9gP6H41V57ydJmtqjf3fqI/+px7LAZQqvqRQaIs8D82T92tNaQvkuA752rm6wU1Qy39F7PSyXVwK7D2P2nCWWwtdmUDiNJSQSoWqibqz9MqLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JqzUFjtQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JqzUFjtQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696A5SHG1603445
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 11:13:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Riyg3s2D/12CmaFJk
	8OYOYcPa8t8WJp/1te/rR8oAPc=; b=JqzUFjtQPJm9fjcxHv+BOtIYpR3n0mVL+
	pEU2ANNQaDGKsqV4sSygWXLv4XPZhoHZR9XSUs7Lc6YklQ07/UexjTXcyw8DFJ3p
	6bDxemhZuHjWHHsmBtu78pcsIMEMp+ZMUmCxkQtZ/3vXl2C/zjjHhQZO5jQnkMjB
	KVaBJdtCsMno3v+L4zuy5t4dO8qCFWmUjRBt00DNZ3QOh8vJpP8UJ7apy84PPTUI
	BgY0469+5qzCPKEgQ42s+lwVS3Z21aHEX0spRZ+oNWnDQyGd1XGD0ojeVkHwTJyn
	RQR/2KFrtg6n97i9wfTiur3fIw657fJd37lIXSrsX/zvSZthvEv7A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scrfju2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 11:13:23 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696A6Jjv129446
	for <linux-s390@vger.kernel.org>; Tue, 6 Oct 2026 11:13:23 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pstka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 06 Oct 2026 11:13:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696BDJYV28508526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 11:13:19 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2567A20040;
	Tue,  6 Oct 2026 11:13:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB9232004B;
	Tue,  6 Oct 2026 11:13:18 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 11:13:18 +0000 (GMT)
From: Sumanth Korikkar <sumanthk@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Jan Polensky <japo@linux.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>
Cc: sumanthk@linux.ibm.com
Subject: [PATCH 1/2] s390/cpum_cf: Check session mask before cpu offline
Date: Tue,  6 Oct 2026 13:13:03 +0200
Message-ID: <20261006111304.4023017-2-sumanthk@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006111304.4023017-1-sumanthk@linux.ibm.com>
References: <20261006111304.4023017-1-sumanthk@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0NCBTYWx0ZWRfX1Wg9ZhDxferM
 MfsBC2Q3YgqQyU3gx/V40KpwAgk59+2nQ/pVg/FVJoQFFD3aYAUn6Xd3PCuYDbTXxLkMHp52W4l
 doZrh7wq5S8kxmUM3W7oIJ/weFobAc8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0NCBTYWx0ZWRfX19tU06Zw0jxQ
 MdwducdYo4d7I5Xu3phjFOUOqtif8Q0hRYNOvnWCR0RbcMDbCbQpOuAy4jTdp18VnFbcBwg+Lh4
 sQpFZI8PmnouEULDn7YCWuZSkSq822ngcmKbjasbhcunTXwWQ/uJYnxWGsCKdEGTOiYXD3uVFdK
 rLxn/MJhfsKvn7RlGRQWELqZSgPjMrrkv4JbvTna8zR/2kaQmsp9/2fyCzoLacsCGBkIX533fP3
 Pqi0owGEE8G2K3eOQaHZyzukYceNSwcMq+sqvi0IPM9ShyS2Q/NWuRvwGtD/l5tKw5cQtsM2U7j
 Szew+tb0CuQ4faHheHgjYAhjJao/yaY/VI9eGCMu07m5q4f1HXy/b3Pu4Ik2Xw9kWpomAoMy5ns
 xILctWLQR5Yl+tORC6bf/YaBewHANmmQb3dObjYOYwaqWzCYyojmSTIHAsaaSAXU9771v4iVh7Z
 hXyi+vV8zJb9Q0Ivocg==
X-Proofpoint-GUID: tpZGs-RSuaUWXjzTnhC3FzmVfqkLhkgQ
X-Proofpoint-ORIG-GUID: tpZGs-RSuaUWXjzTnhC3FzmVfqkLhkgQ
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac4d7d3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=Safxvh1Hf70OtjidsRMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060044

cfset_offline_cpu() stops counter sets for every active session without
checking whether the outgoing cpu belongs to the session mask.

For example, run an hwctr session on cpu0 and a cpu bound perf event on
cpu1:

lshwc -l 9999 -i 5 0:b
perf stat -C 1 -e cpum_cf/CPU_CYCLES/ sleep 120
chcpu -d 1
chcpu -e 1

Although the hwctr session does not include cpu1, cfset_offline_cpu()
decrements its counter set reference count. The subsequent perf teardown
decrements it again, causing it to underflow.

The perf event keeps the percpu state alive across hotplug. When cpu1
comes online, the hwctr session is started there and the reference count
moves from -1 to 0. Stopping the hwctr session then decrements it to -1
again, so the zero triggered counter set disable path is skipped.

Check the session mask before stopping counter sets on the outgoing cpu.
This prevents the unmatched decrement and the resulting reference count
underflow.

Fixes: a029a4eab39e ("s390/cpumf: Allow concurrent access for CPU Measurement Counter Facility")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: stable@vger.kernel.org # v5.14+
Signed-off-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 arch/s390/kernel/perf_cpum_cf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 69fa303cd479..1d63dc3b0ab9 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -1797,6 +1797,9 @@ static int cfset_offline_cpu(unsigned int cpu)
 
 	if (!list_empty(&cfset_session.head)) {
 		list_for_each_entry(rp, &cfset_session.head, node) {
+			if (!cpumask_test_cpu(cpu, &rp->mask))
+				continue;
+
 			p.sets = rp->ctrset;
 			cfset_ioctl_off(&p);
 			cpumask_clear_cpu(cpu, &rp->mask);
-- 
2.53.0

