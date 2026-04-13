Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D51735C181;
	Mon, 13 Apr 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077276; cv=none; b=m+bZm+ATTNV+wYpevIB3FfMh8mr5zZB6zYjmP0sAx5xb2DpvHAxgU87TtBuF30veJ+7R8zi1XmpDbNoajg7NuV9MPAWTyvNsQuMAyaN2xWwA9h7ufLPyrszz6oVLovG9TOp6AxuzCvxGnTn+dXhqjSogA5Y2Oy4IOdlAY8EISWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077276; c=relaxed/simple;
	bh=y0qoCisTagIcI6MZZ16jFMttuurGn+IfVywEckWwJuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjvKjyjG+SlePb7z2+kHYGHX9i88eUgagEqrbEeXsGWSdKXYpmBB/vJ03b/gUBceFzoNvIAKUPP/FCscrWcgLbNsLbGFa4ZzkosYqHNNPx2lvDQLr4WUkcGtGn4fvgULFf93WIvxAm5WcSvqzt5aR4ku3FlUlWvVbeH0CoWl4GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KGh1s+cr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KGh1s+cr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DASmiE2124758;
	Mon, 13 Apr 2026 10:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PvAVOhD9oTKVuij4X
	3vU4y2LymiFySVB1pWQ59LBjzE=; b=KGh1s+crenxtOqkrsFFsAxtm1/UjIYTY3
	QedOYmXnq/j72ukTYj+WsPrzmurI7MNsG4JXYdDd2EN5hzzZcNyaXmcaB0XSAHBH
	/arrsqLeYv6uz6byWr3jozg4lHxNY9vCjLe/G/QuY607cTWeRWPnWkzkhpuRE4DY
	mibRG4DYDjhn2teaDEmqBOm5T6dxdOYl878YpsyJqzEHTHi/EYnqnzQO/nJYycG7
	RKbdKtLrUPbEVdgChHkzuxqrzGSef78OBMWzZlmMF5/PvX9PRzgfeBJTKcQMoXIj
	9YEYFK0ZBswqrRIWx95sAmlQnCYNBmo8kVtU/OXR2vPHEmF8n9sJw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdyqq6ra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D93jxu004180;
	Mon, 13 Apr 2026 10:47:49 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k4q68-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DAljaG50200906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 10:47:45 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B6B092004E;
	Mon, 13 Apr 2026 10:47:45 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 478DB20040;
	Mon, 13 Apr 2026 10:47:45 +0000 (GMT)
Received: from li-9fd7f64c-3205-11b2-a85c-df942b00d78d.ibm.com.com (unknown [9.111.7.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 10:47:45 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        borntraeger@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        Eric Farman <farman@linux.ibm.com>
Subject: [GIT PULL 01/12] KVM: s390: only deliver service interrupt with payload
Date: Mon, 13 Apr 2026 12:46:29 +0200
Message-ID: <20260413104721.203024-2-frankja@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=ErTiaycA c=1 sm=1 tr=0 ts=69dcc9d6 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=25EaFSAiIRNNOV5pwi0A:9
X-Proofpoint-ORIG-GUID: 5cIj9FsJmB9fIwi7kLhybBNODRUMBP5u
X-Proofpoint-GUID: 5cIj9FsJmB9fIwi7kLhybBNODRUMBP5u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwNiBTYWx0ZWRfXx6tOj3qWAyaa
 U94rqYzXamOqcTEmYoSmRXx2V5/yilDDQEPKr+gxS50LUzRmbYgD7lB0z+1vqbkPFEj5Tp+G4DP
 kUs3b04gvECdYuiPsvzudP707G4UGWEqwA/lLwD7DBQMO8Jcjwp77vMoBnTP/ZV0VSoxkK9YlYX
 c3MJ5WR74Fj93ouEKmxxRVgreUBFta8hmNIxNOlVqI4n07H1mM3Z49cbIk7SznAiFd1M3CNxSgC
 ulG2TdQS7TDD0dbGx68anbo0Z8RRLy5T9qGu72RvoPTkzs/vNtqRCWsr0VajJrmXwXN9vG5x6EI
 TB/idotJNYIMIJjT2GOsKOVirPx6Zczag70DPznr4Yz+qf4/6N3M9f4lu9n3vyfCm4xqBcNEvK8
 ekA/ZAQIzKZ22K1LATNNVzEHxz+sX+LCU0dsGYqNnUElbTgJVP28X4pW2TOSnRX8FhGfoOgx9c2
 FNL/aiIvie/TvQQyI6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130106

From: Eric Farman <farman@linux.ibm.com>

Routine __inject_service() may set both the SERVICE and SERVICE_EV
pending bits, and in the case of a pure service event the corresponding
trip through __deliver_service_ev() will clear the SERVICE_EV bit only.
This necessitates an additional trip through __deliver_service() for
the other pending interrupt bit, however it is possible that the
external interrupt parameters are zero and there is nothing to be
delivered to the guest.

To avoid sending empty data to the guest, let's only write out the SCLP
data when there is something for the guest to do, otherwise bail out.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 18932a65ca68..dd0413387a9e 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -956,6 +956,9 @@ static int __must_check __deliver_service(struct kvm_vcpu *vcpu)
 		set_bit(IRQ_PEND_EXT_SERVICE, &fi->masked_irqs);
 	spin_unlock(&fi->lock);
 
+	if (!ext.ext_params)
+		return 0;
+
 	VCPU_EVENT(vcpu, 4, "deliver: sclp parameter 0x%x",
 		   ext.ext_params);
 	vcpu->stat.deliver_service_signal++;
-- 
2.53.0

