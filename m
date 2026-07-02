Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C201B30D412;
	Thu,  2 Jul 2026 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005864; cv=none; b=olELbZqdJpiaGpD+Jh5DOuPolx9/HllbVuHI4c/0h5YkG/bs06nHVC8Ed0yk/F6bb413mxERw8L+3nEk3r5qh6sSCFeMN0GpppKewARJfo7RX7IMOt1/p0hL2RECID54SslVWw1TPkCRyay3B5whU7wuz/D6gOUEqXcBLKMUhAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005864; c=relaxed/simple;
	bh=TNOxLLhwsmzPof6SvMF0wwMGCtP/uMowH5SVXC5i2nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc1Du6Ds7GMTENoZ3H5FquFvam3NEjF9d5OKk3pQr7KUsmtvC01dLA/wh+3x80/jQQgJO2duy3RColEMIwj1AY13Xo65YdApKEW8MH97lXnjQfNaFsoCGmNQPA4lOoDayBiviKfqgCh+thjLJapP+xZLjXLRK97seegcGhU39lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m+3onnXp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m+3onnXp"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 662EIZwT4016115;
	Thu, 2 Jul 2026 15:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=y0fzjllHb3uQSLHm8
	Y+guXbs3J+IJj0RXbVIaQQ32N8=; b=m+3onnXpi8se6GxVm0D6WJuwCWkdx0dK3
	xnbE2JGgwKcC0yKGU2ikM5VmCr8ZQecyHHGoK8hzEGYOwwQv6sGJ+c00ywYQ7wmK
	hL7UiBHra50X+uzlVq3pKibfHwhBiTL7xcgtkjcPDRYXjFgpXEO+BCCoAFgeUuDG
	SQxhQ3zHGmBf2yuFO242sRrg4puttG8HjRi3Dx/dplH14ijejVqw2UEwdDMjwtvf
	giw/ddx7uwHbDpS3Runtaqsr1uxoWXna9g0aT0awETFWFFb9ye4a+YhsTDkmNWhj
	NJadHmNvMqj5fuUY0lo5czvdkwf0ZCbiAxL+/HxGnG31DO1fV8DAA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qaa9rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 662FJiNe010734;
	Thu, 2 Jul 2026 15:24:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhymb1t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jul 2026 15:24:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 662FODwn50201034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jul 2026 15:24:13 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7073A2004D;
	Thu,  2 Jul 2026 15:24:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74B5520040;
	Thu,  2 Jul 2026 15:24:12 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.87.55])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jul 2026 15:24:12 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 5/8] KVM: s390: Fix race in __do_essa()
Date: Thu,  2 Jul 2026 17:24:03 +0200
Message-ID: <20260702152406.204782-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260702152406.204782-1-imbrenda@linux.ibm.com>
References: <20260702152406.204782-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX5uPS6l/8somG
 wO/qkx4pFjgeislYq7+GoF3yuq367laATHoHUyTVkjYZbmVpIeiZ95bg04OGX83fie6mlz27BrG
 CJW02FeH+5Jxg/AH/U5mMbBpKyfYyYDsN6VgdflW4tGcOb3kIpYFh40/66Heo9Z3mMMpcWAiiyZ
 LtnXvS4e98Rhv5m3I0PrF5SiyCO3TQ6/NduPlLxmK7wZx3gYV1G5RT+BhLHcsaFIXQdh3Leu8TO
 9ogYAHvnfKeAbjstor9qYS9pNR1FicPNSGFi+gRIGsRXSW9s1JpFSd/BWhbrT/Vb3xaqx2A6xmb
 0fhd6NEoUOKOpJ+4Qw+hqJB7hKqfU8HoZ9qWnwmnN3D0D2n+HE4gUPu7nar5ZlgGWZ26T/x+2b1
 BzfGM3wMQGD7UmgAVIQvC6uLdx1VIiMxyMLO2ABIZDLbTcLt6pb/eOhU1K/WxMSvCSsVG2086LV
 ljee2uSEYbgyL/0RrQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDE2MCBTYWx0ZWRfX/pMc4WjH4vZI
 8aFN8NL9Fa8LiryVBbkxXQAkI9CO4cPzj6Ecw8WuReKbg5nZqnIrMZq5RFVziDao3hngEjREEqe
 H7a6KZske29ZY+hsEi0FVa7kngJzMoU=
X-Proofpoint-GUID: of2fOAy8MyWEmUlLKZcuXIPudkMQa1H8
X-Proofpoint-ORIG-GUID: of2fOAy8MyWEmUlLKZcuXIPudkMQa1H8
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a4682a4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=SEIsQiIyKFAhYTenhQEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607020160

An unlikely race between __do_essa() and kvm_s390_vm_start_migration(),
kvm_s390_vm_stop_migration(), or dat_get_cmma() was possible.

Fix by locking kvm->slots_lock. Since this is not a hot path, the
overhead of an additional mutex is negligible.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index ad0ddc433a73..b0f3a47b1829 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -1260,8 +1260,9 @@ static int handle_essa(struct kvm_vcpu *vcpu)
 		/* Retry the ESSA instruction */
 		kvm_s390_retry_instr(vcpu);
 	} else {
-		scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
-			i = __do_essa(vcpu, orc);
+		scoped_guard(mutex, &vcpu->kvm->slots_lock)
+			scoped_guard(read_lock, &vcpu->kvm->mmu_lock)
+				i = __do_essa(vcpu, orc);
 		if (i < 0)
 			return i;
 		/* Account for the possible extra cbrl entry */
-- 
2.55.0

