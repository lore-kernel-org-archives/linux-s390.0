Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C77A3B14D2;
	Mon, 13 Jul 2026 08:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931423; cv=none; b=br8AoCnUl+ttkvzvmvZQNLWrN+4A/ZlkIQY+CU+UWAEausMyKZfVwoKDF347tBuV/7XX67lWNoJHtQwQj2th2OTS+dzC6LU9Z0AIRd+D9/is/XAwRYZhtQzyMIubR2pRRoJhXG7uiCBnBRCk6RFytklUkdUbf3uxSP6MvOuVwM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931423; c=relaxed/simple;
	bh=8NRqUBqlwi38q4sGKQS40yiYdwUccU125s1nzL1FBlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jHuK4MiClckAZOAOKwFEpD0VS7l8tbhrwytNAydzgn6UOvoIMlduaTFMpL5CuduXkTGcDJkFaA3alaIxl2yjfyMZ4+kjeZGtGvq2Dic21cdCJhy8nN586CczJDYNjaha4Yu6O+5hwGEeG1pNHc6VXvgTQq/cod/WFQOXgQ0OJKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YIz6yRET; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YIz6yRET"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6fpr51668564;
	Mon, 13 Jul 2026 08:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=40ev2TFx5NMfd9QUL
	2Ykf21oZa0xKJK+TE7Dd+42cVs=; b=YIz6yRET0xBEZYChhYo8g0r2tQ5+og4fa
	zpNwya+rdE+VAxy/idJSPLb34TD9A2/XcygsQ4Y3VB00YbTBqbn6BOwXc/a7+Hql
	YrFP+KPSVeKDZS4oBvaMasNgb6JT66k3VzQ1Tua54wwjrZq209S6eYA7IGx36yzH
	Ah6dlPMOEWodkftnjkiRsa0R1CJY0NhjXRLg6VAkoedUX/0DQ0sHLKlSVMmt5ghb
	Vo37QWO5zkZ06aO762Z9E/UCluCcEns23WjCzsNuSGnYo1X1jTwhY6eBftNqLZOr
	1S/BkhtTp3W++CY8x5Javajk/HPl2PMLSGk3/6EjrR93nimPGbTig==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbexwf90q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:30:18 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66D8JYwh019112;
	Mon, 13 Jul 2026 08:30:17 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxvga6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 08:30:17 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66D8UFrl51577342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 08:30:15 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BA8E58076;
	Mon, 13 Jul 2026 08:30:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B3F858065;
	Mon, 13 Jul 2026 08:30:12 +0000 (GMT)
Received: from li-d98989cc-2c66-11b2-a85c-93ab83b7dd53.ehn-de.ibm.com (unknown [9.224.77.173])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 08:30:11 +0000 (GMT)
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
Subject: [GIT PULL 1/5] KVM: s390: pci: Fix GISC refcount leak on AIF enable failure
Date: Mon, 13 Jul 2026 10:30:03 +0200
Message-ID: <20260713083007.65863-2-borntraeger@de.ibm.com>
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
X-Proofpoint-GUID: tiVklw9TEH_rD0QGpJHvQuKsR4uFRkLt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfX8mV4fU8vbE5K
 0zZwEZ+sqL86U6k3t3DLCAgZmxyIyY77LcGi5xmb7iVWnPR13ZRFsppZvdKYvC8+Pu3N3hyDF13
 CXJ+e/Mq2aPSh2kt2iVSYHnfXFBISemgNC69Ep0rwfjGRBbr9tWWl5LEHJWHj9Xq6ExEv/BtO1M
 4EwBGeq+hY2LyQJ5H0u5I0JnDgVp/cJXnnMYPl5Ay3lGFkSWdUzmhEt00bzs7jzQ4LTaHTMvdVU
 hKVQD0OAZLeWfDxjKzb0Bb2C7U8UmNzC9cO76pt13BpN13RAKxXoYlQIwUwAKqo2GhNuIWJy6W7
 4WZN9dbstsasIdmgddwodMV2LtzZOQ+g/SissXSa/lkONSQXO5sKEiUmVsj1XtcDhMeoD/IJ2+p
 ufCeuNf6advyx2eF0MJs0oFxb/uOTxrOAGqbCZIhSVbSqyiQjggCluup/qh9CeBpLZQj4KN7aOr
 0Mby5kQWBFQnsuMlp3g==
X-Authority-Analysis: v=2.4 cv=XJoAjwhE c=1 sm=1 tr=0 ts=6a54a21a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Byx-y9mGAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=XiBTJgwI74MO822DETgA:9
X-Proofpoint-ORIG-GUID: tiVklw9TEH_rD0QGpJHvQuKsR4uFRkLt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA4NCBTYWx0ZWRfX/S+U++tuwdzt
 wMoj+PIyQC0RkBO7wrtq5oMHXmFaDJ6tktDMOdxnUeE1sbIWUSvCj2yfJN34o19GeNqj8WvQptW
 r75iSQoLYgfXLJ+Ke3sdljf9CjQBlvg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130084

From: Haoxiang Li <haoxiang_li2024@163.com>

kvm_s390_gisc_register() registers the guest ISC before pinning
the guest interrupt forwarding pages and allocating the AISB bit.
If any of the later setup steps fails, the function unwinds the
pinned pages and other local state, but does not unregister the
GISC reference. Add the missing kvm_s390_gisc_unregister() to the
error unwind path.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Acked-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260624061910.2794734-1-haoxiang_li2024@163.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 5b075c38998e3..686113be05309 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -328,6 +328,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 unpin1:
 	unpin_user_page(aibv_page);
 out:
+	kvm_s390_gisc_unregister(kvm, fib->fmt0.isc);
 	return rc;
 }
 
-- 
2.55.0

