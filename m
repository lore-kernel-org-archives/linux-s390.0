Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7FA3AA1A7;
	Mon, 13 Jul 2026 08:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931430; cv=none; b=XxluTAAp/LzMzjduaaPtQ2LAN1RO7ufuXN+AxcQeDntP7TieTYWtN2MI7rWfM3/uFvL9p0c0Bfv31ALX8gKdM9MOsXLwezJx2l+4vO8E0ioB+SwFHWvdjb6JSyTkFjtgScwqsgcCnurouG1v/Elp7yTRBNq5gEhHEp/A2xskZ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931430; c=relaxed/simple;
	bh=9DaKLi+WvEV6W0A0YCzDqe0wLvHX6tuvgyPzA6jrZMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qWciN2tRITdqIkW7oKWRQvXo11eODiUGpXE9Hamii++aOwpnuzEqV8XIb8fWIvwEAw7zVOFiF+9XUyIYtrEXSXAX8URwcDimg1H5MoYEltpMcoLB9I2tvYA0dVn7nIpfz5BsIemADpyqsYPP0Hu1nnhGd1qz12Hvteev3CZVNVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ppG/U6Br; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ppG/U6Br"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D7vHkl006641;
	Mon, 13 Jul 2026 08:30:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FIVQ7IrtufYrmgJ7M
	LxRbiA9DWCoa4n91v+DQVm/0+s=; b=ppG/U6BrcXGpm456Rj2IVrRYOEDSnzCiS
	OziE/CQWew7DSCgoJv8iNxCeM6azsVdECb2FwMCsCwZgTzYgbppwTfoqId9mpZFl
	7jcGilwzOvcMjRDMpigHeM9g1Fz4zxVjGSd2DUlTIWO31/2UfmgCAFX31uF2vxzV
	6PAn7+4bhHKUHS4rgJ0k3gp8VVCJ5sOirendfMwzfPlBUmxQ+N0XSG7lUgrZgLYK
	u6OiEFdV0ZX9o7HZ0m2O5hmGKUjoJEZ6WK5TKIU63KCJxgAXATaDHbX4rAWYySUg
	qmi2XhdijwntcFHjQp7G8qycKraRGBjXvbv8mW+/PyeGoOwKfjtTg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33055n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:30:25 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D8JkUF010626;
	Mon, 13 Jul 2026 08:30:24 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cg4jju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:30:24 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D8UNCX9503470
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 08:30:23 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8770C58080;
	Mon, 13 Jul 2026 08:30:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3444E5806A;
	Mon, 13 Jul 2026 08:30:19 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ehn-de.ibm.com (unknown [9.224.77.173])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 08:30:18 +0000 (GMT)
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [GIT PULL 3/5] KVM: s390: Fix dat_crste_walk_range() early return
Date: Mon, 13 Jul 2026 10:30:05 +0200
Message-ID: <20260713083007.65863-4-borntraeger@de.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713083007.65863-1-borntraeger@de.ibm.com>
References: <20260713083007.65863-1-borntraeger@de.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfX+EH11TyU7Xx7
 OYqZvaAoBvupPGw4nGwxkq+LvzvFyZfq7/gLdg3QPvHrF+8wVv6/vcLebSf8i3bUUrdSMAw75Mz
 8oWsUOl6SwOM9+MorVl/JRFx6w9GJ0g=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a54a221 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=rMBDsGxj1jqsR9YKdtkA:9
X-Proofpoint-GUID: yYBWYRK4MYsUfX3NbkyK4TxpuSTMOYyy
X-Proofpoint-ORIG-GUID: yYBWYRK4MYsUfX3NbkyK4TxpuSTMOYyy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfX5UiBqMaXsf09
 B5eIcuWCKiao0AuxFdQChDb5GSFGDKo27zTnhNcvyg2f9uPLv43zhJ/EFGCNVz9c3adRsYrEK2/
 B12HDvrUszjC9AEQ2dlPQf0qAcSMY4vLYgdC5s+Pa0NEXbi2XMYhm0jV89oi5ZCbhWT49pxRm7Q
 OX7v36nlAJ5e0rfX+rJ6g8LViFQXjsG+iOpQRMtsTZf36oyXRlGBkZmyu9VJItRXqGtAECHBIGg
 bjelJ2+VKnKf7M8wJYFVCRdlVgn04jPMkZsAEnkVFrTfEuzUTPZIIL6+rq9aoSSUzEsIyVojxI6
 s5J4kxTokixqNO+l30nhoib6Uf+PLLUrrS7S8jRF2kxHzQkPyfmjJMeVGNRH6V42tIQl26L49PE
 5OYmLjSVKNlZKYCtRjJo1H5F998CTNn7h6zAZMhRnpWFQRoAJjMWFwWZslqgYBEtU/B8HNDxo0g
 aMYby/pqnSH8NmDPflg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130084

From: Claudio Imbrenda <imbrenda@linux.ibm.com>

If a walk entry handler for a lower level returns a value,
dat_crste_walk_range() will not return immediately, but instead loop
again and move to the next entry.

This means that some entries are potentially skipped, and early return
is ignored. Skipped entries might lead to all kinds of issues, given
that the caller expects them to not be skipped. Early return is often
used to interrupt a walk when a rescheduling is needed; if it is
ignored it can lead to stalls.

Fix by breaking from the loop immediately if the walk to a lower level
returned non-zero.

Fixes: 2db149a0a6c5 ("KVM: s390: KVM page table management functions: walks")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 5f1960ec982d0..ed4259d176295 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -570,6 +570,8 @@ static long dat_crste_walk_range(gfn_t start, gfn_t end, struct crst_table *tabl
 			else if (walk->ops->pte_entry)
 				rc = dat_pte_walk_range(max(start, cur), min(end, next),
 							dereference_pmd(crste.pmd), walk);
+			if (rc)
+				break;
 		}
 	}
 	return rc;
-- 
2.55.0

