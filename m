Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3095541A549;
	Fri,  4 Sep 2026 06:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502024; cv=none; b=IVv+hxVH5jhiQf61O3q5pQPRPWwocGp5VIzWThpRdp8btb6nDqZwUjQSt+5CNv9gV+o0SuiZEvlDDExI6sd+hifuEYWMY9F185I9/zuAv3lkhl9GyfAaNJbRu+5sNBaPUazve7kjOu36bLX5hDxQuXG2eKJrzA0MG1IOrPn2Clw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502024; c=relaxed/simple;
	bh=kp8gL2KIVJctctmAJpkwbGhNiYR5pqeH4TECZ7fjTl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZjxHOOgCTdwAAP18H7ECuK0JkK8n2bzsf6FqxHCvONS9J+Nj44+fHYxO/bKs1MCG32mNk+CN5a9f4rZK4bnX37LvsBTZvNif1HcXPRFFlsde1A7P24kaNWDiCf4KIhM1V7RuS141eHMeNh/8nu7zPRUu3quKaiOHCg+9/xJ0TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nzgw7R4f; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nzgw7R4f"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464Qdc936948;
	Fri, 4 Sep 2026 06:06:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iMyLjLIyAAm4RuXxN
	A2Wbyp777+wUq2SRDUtR5LqgsA=; b=Nzgw7R4faweD37+GAWrm79sLv8hq4n7Ol
	tgFWi1nPJS5XSOUsDRyz60xH4Kp0Chn7CmoRwmSmQDBnyKOMvMSYEkcz7LS/u73T
	AQfTmPeFqfX6/eg3UsMsGKmWkuEhuTly2WkxE3wXUGVfcy8BrMlpM3wvx+z9WaFa
	QB3Ygd6vjhEaU5kJfuwg284lW96MvCdoAVXeEHahmQq61u9L5ytajyYADLeMaEQl
	yoLuWdQfXMT9UGtro9nP0UTlMr9sGG4H1xvYsEgdiZdZzUVTa2sQLak/wPpT+Lfb
	Oe6COCTtzd5g07Osx+kINJp7JS3rTjTp8ikYA8qG+sOry13VzGSfg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx610r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6845uLtG023425;
	Fri, 4 Sep 2026 06:06:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyguasf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:06:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68466qOJ37880114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:06:52 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C10072004B;
	Fri,  4 Sep 2026 06:06:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5323520049;
	Fri,  4 Sep 2026 06:06:52 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.53.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  4 Sep 2026 06:06:52 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 08/11] KVM: s390: Fix race in _destroy_pages_crste()
Date: Fri,  4 Sep 2026 08:06:44 +0200
Message-ID: <20260904060647.562443-9-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904060647.562443-1-imbrenda@linux.ibm.com>
References: <20260904060647.562443-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9a6003 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=N6WJw_kgbt6RfBQfb4YA:9
X-Proofpoint-GUID: xCmi_KnKQxw3wN6lPpOun8O60xgg0pfi
X-Proofpoint-ORIG-GUID: xCmi_KnKQxw3wN6lPpOun8O60xgg0pfi
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXxHet7IYxTKGz
 fFjFlVbagVLaYsXYvDXtXSUwKCY4uZlfsbtRTrRqaAY/rM3/LGLA+8rESQ4ctUsUb/6PHom//8R
 7f/01O1fKEts5Mgk6lxQllQOJ7UA4cc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX9qOndnIfQQz5
 HJ2bzEHr1IlFopWpFgk2/U3CXdLgdLQp0D1iDKhF5qVICBqRGzR7n9+l5D6TMgUqfcxTET/Wfgz
 9kldgRvNjDScV10Zqt4MdZz1u9K8PTd2AvrAeEpNO9HwfMO7UVYAt9FOpApI9dijh6ga19BYNwY
 9V2G+odWtLXk5kZsRpqE8zOjzZTk23LrmkKdbYjjChfPtOX6O7nfcJXd8keSk6UyiccnMD5ttty
 q4RUPIBbFOKpJfMTqIjNd/B08HauJIqbrS9J8SAvWtcBeVmcktrdugaPRHE9WREDA/l/0eXhpT2
 vLzcbvOUP8XQgchJYzmHIKD15zn6dcxFn+VSAwrKrxH1qy/b2yY2A2CZvw7/1tshQm3ZnqJJAfS
 spe9/kqRkiX2w/4CLdl2Gy1y3G2ZA0vPc4dbko8aVZYQLCpDvQqfMlHKZCZQUDqivhER7sOxfch
 JsJjEdU1V9vVWrE91nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040054

Use READ_ONCE() in _destroy_pages_crste() to read the crste, avoid
dereferencing the pointer multiple times.

Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260828115439.145885-9-imbrenda@linux.ibm.com>
---
 arch/s390/kvm/gmap/gmap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gmap/gmap.c b/arch/s390/kvm/gmap/gmap.c
index 4968330e9553..3f3fa864cc36 100644
--- a/arch/s390/kvm/gmap/gmap.c
+++ b/arch/s390/kvm/gmap/gmap.c
@@ -994,11 +994,13 @@ static long _destroy_pages_pte(union pte *ptep, gfn_t gfn, gfn_t next, struct da
 static long _destroy_pages_crste(union crste *crstep, gfn_t gfn, gfn_t next, struct dat_walk *walk)
 {
 	phys_addr_t origin, cur, end;
+	union crste crste;
 
-	if (!crstep->h.fc || !crstep->s.fc1.pr)
+	crste = READ_ONCE(*crstep);
+	if (!crste.h.fc || !crste.s.fc1.pr)
 		return 0;
 
-	origin = crste_origin_large(*crstep);
+	origin = crste_origin_large(crste);
 	cur = ((max(gfn, walk->start) - gfn) << PAGE_SHIFT) + origin;
 	end = ((min(next, walk->end) - gfn) << PAGE_SHIFT) + origin;
 	for ( ; cur < end; cur += PAGE_SIZE)
-- 
2.55.0

