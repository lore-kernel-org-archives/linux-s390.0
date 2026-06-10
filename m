Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05EE347532;
	Wed, 10 Jun 2026 16:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781110378; cv=none; b=Klf4HLutOpEbn+YKS4ioeOvmLol7VHouiPSa2787wg/QZWBTId1EdIrRRm/0o+aYq7AxcboZ9+oO84OsZZJzaPivbdjq0/7Eud4jXz3n9XOTUsjoFbnz+ORq6VuFfOLtJj9Hx5t6t1SJVFeMid3oI5gQeNJFZpg9JLhs/PaXEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781110378; c=relaxed/simple;
	bh=FDLy1BGQO+w9DStrNektS2alXBoWqeTa1GWUcs6Szow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M8DM866+4zUnkIeoEbqhAoLhbYv1gS0S+idtKvEQxMMU7fDSKyC6AATns6Xq8M2l8CCq0zxrEmxFjhTd8Xnu0LKKWtfS3e6kzQ+SizUuvQ8cnAjz7a5wSi8raFuOA7ushvmvX8GSW4nC2ffpWGhyyaEZO7b999Gfwl87AsiPBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ogW9Frp3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ogW9Frp3"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AAm29f139779;
	Wed, 10 Jun 2026 16:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=b6mCg6pnc58br7ZYF
	XzXHqfVSwYRPg2iIm7vCGixyXQ=; b=ogW9Frp3rqiru77o8ocxd13tgE7WO70mw
	yzIVudaw80CYbxQlhmfDzyJTkh/0Mjf5ZBmoh/fZXz4gOCQ3r13I/cpabU4ZF94/
	V1NNpMR6m51TSlUue4fbbD/k0qSzDUSDHCZA5oQORjYUci4297BvuWRx812HuT83
	seAlIUE0bFJQWx1LToj+gg72wSUrn2vHZj7IUsqGZgPOeh/L6ClkKdcMOG9JLKDd
	RSDrxO9egZi6DKLuriK7w3TbLWll+uDGgL2Z2vlY3Om1yjbu4UkYyTwdk8vXUiHx
	n19O0ZDCuR4d3SilbdRkm0hSrbxFKROwun3luT+VJVRmdyVQNaAIA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb2426xb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 16:52:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AGnZdU005253;
	Wed, 10 Jun 2026 16:52:53 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en03g7at8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 16:52:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AGqlXi49545712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 16:52:48 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D933E20040;
	Wed, 10 Jun 2026 16:52:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B31E12004E;
	Wed, 10 Jun 2026 16:52:47 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 16:52:47 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        borntraeger@de.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        seiden@linux.ibm.com, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v2 1/5] KVM: s390: Silence potential warnings in _gmap_crstep_xchg_atomic()
Date: Wed, 10 Jun 2026 18:52:43 +0200
Message-ID: <20260610165247.238366-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610165247.238366-1-imbrenda@linux.ibm.com>
References: <20260610165247.238366-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=b4uCJNGx c=1 sm=1 tr=0 ts=6a299666 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=4xVTsJvn8g-7h_O1kUwA:9
X-Proofpoint-ORIG-GUID: uBp-dXJYal7OgHg0irvFhcxjWAnEmyjU
X-Proofpoint-GUID: uBp-dXJYal7OgHg0irvFhcxjWAnEmyjU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE1NiBTYWx0ZWRfX487m+DaG8ps8
 A9EeAA2eaZxsvRYzpk+8KE9uMrVU3JfZzWAhxZ+KwFZ6KAvCMP7eSDDQgE5mH5IvxQLMGchxPmF
 +sH7llaFbvlXk54JDBB/E7fIeCSC5OP872NSmkEg5ogn1DLE3OubOygsuyjKD+p7OGqGBmLT8O8
 J2ombDsCEHxPpwNvgcyh42UWbVEBHgXnTgKaqs7/nbivPp4hP2HakAjeL3D/7jpyv8Unug+o+70
 1BpH1+18lAZ1B2XsYeMrYf/cFpJZUvbnoTzlu5V+jeFIpDNe8W3dpsQ/yUFevyzbrOp/FjrLZit
 Yne4zQmX/dSF0+MJpYa0py0DJaDBos0QNSfYR/bTzhqGlRs1CE+6NI5AHCtvQIPmRclYRHQZ/Zy
 T6dJsZYSXFqfE3WVOZkldqcxcEdPOVXdiLluklsOAWJ3G3IxTuq4RG1lB0mJCMApHpyLLnPG/JV
 bWtd+ecFhkbqP1k6sAg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100156

While dat_crstep_xchg_atomic() is marked as __must_check, in this
particular case the return value should be ignored.

Silence potential compiler warnings with a pointless check, and add a
comment to explain the situation.

Fixes: d1adc098ce08 ("KVM: s390: Fix _gmap_crstep_xchg_atomic()")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
CC: stable@vger.kernel.org # 7.1
---
 arch/s390/kvm/gmap.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
index 5374f21aaf8d..20881e3ce9d8 100644
--- a/arch/s390/kvm/gmap.h
+++ b/arch/s390/kvm/gmap.h
@@ -279,7 +279,16 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
 			gmap_handle_vsie_unshadow_event(gmap, gfn);
 		else
 			_gmap_handle_vsie_unshadow_event(gmap, gfn);
-		dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce);
+		if (!dat_crstep_xchg_atomic(crstep, oldcrste, newcrste, gfn, gmap->asce))
+			return false;
+		/*
+		 * Return false even if the swap was successful, as it only
+		 * indicates that the best effort clearing of the vsie_notif
+		 * bit was successful. The caller will have to try again
+		 * regardless, since the desired value has not been set.
+		 * This pointless check is needed to silence a potential
+		 * __must_check warning.
+		 */
 		return false;
 	}
 	if (!oldcrste.s.fc1.d && newcrste.s.fc1.d && !newcrste.s.fc1.s)
-- 
2.54.0

