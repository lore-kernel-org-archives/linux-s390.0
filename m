Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DE142FCDA;
	Fri, 31 Jul 2026 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502919; cv=none; b=T4k75yXmLMpPs0BODQG5d4PGWB5bdvytLgBQE/T+GFq2aYH1yeHxvbmH6x/NQDyrqzPFkChiL3LtuvuXRyBiUilwO5UVsLUIs63Y1u29+nocwslmSlQl/FSDQADePTC9iq+49EMq9LQ8oI8ZOsaKw99Hu7DBWX6ib2YU70uF+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502919; c=relaxed/simple;
	bh=HOanDrvD+bLZnZeY7pEyreY/JBB5XIzF0GbLYIxmYn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pi4k3A/shevOAV1Y920le4VvrVx2L+njkIS1fPm6M3XfhdQjZ+mvOzGWAwbNF36GIQ/c7v/pBH6XglviLHkjwwj1krmxQsSHPDIRH7LznHup4MX/IhLpVq12bu4oxdW7P3kHtc+6PuNKeiLPzgHgnvoikV0OOHE/940u+iY1Nmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HgeVr6FD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HgeVr6FD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VBm8ih1791335;
	Fri, 31 Jul 2026 13:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rwemp1JR72yGC96fZ
	c2lb5FsV7ftYuKoDvMVFB/ovOA=; b=HgeVr6FDDkghgPYelTmZ57FlHERwiViPn
	Jb1asdBq181JD6pUSkDtDEPJB5AcTEsoK/M+EKVSA8ZDMauJniEASDm+DJ5sv64E
	KMgSJI8TMGdyK3l/eoDhzp1A8a7UV1b+BLJcMDo7JtlNEbcrpsAoaOWCiV77Sm3n
	afWJUxhxASEzke5cyiveOh4NrRu+Z4BADu13Zm/SMgWbN626Pw2LbOqrI+nKNirF
	OjnrwA8OIct6zCGrKs1tQfAgIzLJjLnzyrZE/s0vNVpSZCLt6kAklaDLVZ3W7HaI
	WzCw3cwn+Hz1cUajRhlLlEQwIMGeTNhcao2OWYKmdil/UZvvXqNHA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwdc2wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VCuHTu021733;
	Fri, 31 Jul 2026 13:01:55 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwg2vh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 13:01:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VD1mLH35651918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 13:01:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B53982004D;
	Fri, 31 Jul 2026 13:01:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF5CD20043;
	Fri, 31 Jul 2026 13:01:47 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.4.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 13:01:47 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v7 09/14] KVM: s390: ucontrol: Add missing locking around gmap_remove_child()
Date: Fri, 31 Jul 2026 15:01:33 +0200
Message-ID: <20260731130138.173983-10-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731130138.173983-1-imbrenda@linux.ibm.com>
References: <20260731130138.173983-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 89UZAXg0My2e4y2hwZYM7Ct1mkTdP5gt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX84eeBWxJnw9a
 xTNkDYoSvhIUEu+kIBXTc2lvZGOKu3CPjf53fRzJfBNg4yCU3GR2RHWtdlwBs0HErK+l7flSVVk
 Bbvr+5DGATXpifm2bQe5u8R0vXYb2kM=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6c9cc3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=qtdt0r206yBj_IGTItsA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA5NiBTYWx0ZWRfX4RMjfq2FcWc7
 mg4P26m/xes9Vxdeqd/MNS8VgRH8QnRDpUk2VykapB/oeQc515VS8ybJM5NCTTCwIA6rzNGbS/7
 U0fMIkHlJcKWuigkUc6RaNGqJ/9UzojRYOSa6KuI96L/xi/UEAjx4AvX/U8QiWuD+p+quIBe2iQ
 YxNO4r/3P08B/jEv3akapeEYVUCZD+55qpCS4FrcnqV+7D9SzGPDaskv9x2Lk6GGdqpnNPFWcdn
 ctTC4hoi+WKQh57GqeThukbj9yMAcDzQUqAiEeP4cnRI0yylQbqjcusA/0VzF8SqWWCK8SVcfqu
 lEby3GWAhaP4KZNAaqz3HV2WaE37A+jXDoK8hCjYWd3KgXhrAYKUR2+yb3Cw/tISrYwqfQzNQ9f
 n8sgBNCLQhNKVo6LFSRj2OdKT0WNhI9K1agP/74B6vz50/Kxn2BgHd5l4X+eXvuE8ZgAMAQCZ97
 X46jO+61yR7L2y+bLxA==
X-Proofpoint-GUID: 89UZAXg0My2e4y2hwZYM7Ct1mkTdP5gt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_04,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310096

gmap_remove_child() needs to be called while holding the children_lock
of the parent gmap. This was not the case in the error handling path of
kvm_arch_vcpu_create() for UCONTROL guests.

Fix by adding the missing lock.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ba811f0673d1..2741ca323ede 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3875,7 +3875,9 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 
 out_ucontrol_uninit:
 	if (kvm_is_ucontrol(vcpu->kvm)) {
+		spin_lock(&vcpu->kvm->arch.gmap->children_lock);
 		gmap_remove_child(vcpu->arch.gmap);
+		spin_unlock(&vcpu->kvm->arch.gmap->children_lock);
 		vcpu->arch.gmap = gmap_put(vcpu->arch.gmap);
 	}
 out_free_sie_block:
-- 
2.55.0

