Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD28A317153;
	Tue, 23 Jun 2026 15:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228825; cv=none; b=ALxO3vxd0UouIOiYzqmqRSadNpGdDOxkg/Y1AcFYLg26StWWpDvt+tYX8hFT56aeIcfmVgOvjR2kfm+9PoZnw1+0S7aWj9NbSPOGg0qWaliZjlPP2FIl0lAg6ks81uax7RtYtiuSWRkoIPOP7Vmt4VNmCLf/r13HDOr6pi/hzIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228825; c=relaxed/simple;
	bh=iilyN/XdzzmzC2BPMd1sUsSiPTCD6WgAI8AIn5E10DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWano2tJsK/WbR8oGQ2DrsML9KgMaaaDZxHRa5CAhtLqHkfM2b9I9EjTmN0I+4GCAqsnVcstl5l9kxjVWApThvtd9wvPCIgOdhq9YtG2eJvI9MVygp718m7nUMMcOU1kc32g9sJuy3PU9OQvHc55w6Zy4M1iHZCNmk6w6Xlvdws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CWqfaR54; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CWqfaR54"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmTYu1805407;
	Tue, 23 Jun 2026 15:33:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iCKeneeUC+/w5qyC0
	Z+7Raw7sHukH2h8vH++xh4wDzc=; b=CWqfaR54laLZGLiKTZQY6CFuKm+dalJy4
	CTNVmgQco52tZaJi+LolGWvci6ybZ5RII/SNUZ9Y2B09YpkEwnDSvXvdwX6eYGMJ
	DyalMhljltonQ4VVBdJ2oFpAVqQQsPaA8APpXHz/eXrJ9z471UcabJCYCuhzWJgv
	3BqF9n3Y0kwHkxzdxUzGjjs5BtrBFoXZD7kEYXOue8LMWiywtGuSc0p915f28VSy
	kG4p3yT5dmTh5xk2etuPRecV6DNIRV5mFXkmORzWD1wI1oHiKd/9aWMZSX8BrI5z
	e2S8w8DILoSxWnl/OM40NrWK0gK9QkcWseUq/QddXSon7j6vLz6lA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9gfc86-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NFJnr4007052;
	Tue, 23 Jun 2026 15:33:36 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phbxt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NFXWVk41615710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 15:33:32 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0ABA20040;
	Tue, 23 Jun 2026 15:33:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 848D420043;
	Tue, 23 Jun 2026 15:33:32 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 15:33:32 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v6 05/10] KVM: s390: Fix handle_{sske,pfmf} under memory pressure
Date: Tue, 23 Jun 2026 17:33:26 +0200
Message-ID: <20260623153331.233784-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623153331.233784-1-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3aa751 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=tAqH__8HQhgemv6Xi3YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX1y280jeeHpFo
 1kDwOpmvS60IH+TFSIEBlqyim71i4KkymQMuWAEbQVhvBzIVgngoWvRdnZPyxQHlBxJVsaqIApp
 rj+9ldJWzrZ0frA2yVEGqMV9aT3Q0azhFneJz3UGddEclP02FTRmO7nggBbeQLLm6EIqYDns5IB
 1ZHbqtHLVXcha6k1A8MDoDlKNoqj5viaMPTaFbm+X5d9WV73MIbkddUsswbciULsurYmviSXmEQ
 1e4+fErKhTYrVS+X2FzsiLEGwMUFEV3MJyPweK41N4sZxGE3OI12D+6KAOfr7bmvufAd0XSTBLT
 ZBQ5L+YBTXkT0XrF2koAZ2qC4xdL7e8levINPjctoj59IZJ2h39HWDGOzVYMtRABAm7IUEJHMF3
 /LBwV4BwHuZiiy0uAfsgAl2+sVHbYQ==
X-Proofpoint-GUID: 5D9gkzzF4OqJZhTYWYodYTh6Ks5_30SD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfXyK+cbsGYTErq
 UmrDp3NDF7emJOvD+bmUkQxqopna5LplcmXg4ZnQuaccLg6lnrqnRRVovENIZIDHPCYVRXeJu09
 jM03N3uRYbmK/ajHomh8nAkwBjGnhuk=
X-Proofpoint-ORIG-GUID: 5D9gkzzF4OqJZhTYWYodYTh6Ks5_30SD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606230126

Under heavy memory pressure, handle_sske() and handle_pfmf() might
cause an endless loop if the mmu cache runs empty, the atomic
allocations fail, and the top-up function also fails. While quite
unlikely, that scenario is not impossible.

Fix the issue by not ignoring the return value of
kvm_s390_mmu_cache_topup(), and appropriately returning an error code
in case of failure.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 447ec7ed423d..9bc6fd02ff77 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -366,7 +366,9 @@ static int handle_sske(struct kvm_vcpu *vcpu)
 		if (rc > 1)
 			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		if (rc == -ENOMEM) {
-			kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+			rc = kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+			if (rc)
+				return rc;
 			continue;
 		}
 		if (rc < 0)
@@ -1122,7 +1124,9 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 			if (rc > 1)
 				return kvm_s390_inject_program_int(vcpu, rc);
 			if (rc == -ENOMEM) {
-				kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+				rc = kvm_s390_mmu_cache_topup(vcpu->arch.mc);
+				if (rc)
+					return rc;
 				continue;
 			}
 			if (rc < 0)
-- 
2.54.0

