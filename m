Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADCA3B8120;
	Tue, 11 Aug 2026 15:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786462674; cv=none; b=FGzTEEhjpBeb1/S25b43QwG0CrUzHErVC0L//xqLGzU4YU/7/wsWgy+ClL1Oz3phWgPhEEPwGEj4O0C0A0m7cSWuTdZ3rvXFxsBhDYQTwTH4ZKbevaBN0hdzOx56feO7bCTA1MwaPUgCTj/LchVq6JXbbxCrhA9BhnpYsPCSXIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786462674; c=relaxed/simple;
	bh=OKPru7/dMuGGEhIUoD0KaBLahzJ3+PBbVRgXpJFn7PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QD2L+uYpwk14mDAAC0McUHFhGoBXcjcSO77k4nyTsk1CxY07xIPW+XKi0BIbwvbuZarr0crLWiAjFek/AKbZ4LzVCTsaxgk3ahTkrJFxdJ9JG7d0YXOPl3mWWih8cDo5Vwax1i5Fw5nH+qc+fa47DQ1+UoO38mCbGQa+NWLh3FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qMpK38te; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qMpK38te"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX8OX3634526;
	Tue, 11 Aug 2026 15:37:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mevlro+i34UGmC8fK
	9eIxlOY/dbCs/DCgA+ohgsq0lo=; b=qMpK38teIYfkLunoRLBw7GbBqBhbAwdWW
	r75A6WVqgc8EowfhUe/SXZI3y8LIZBqeOamAbWQolmXf4tUOZ0y/VOWAXFBO4eG2
	gOHDgkFgEwH45rPI8Dwd9eyvgHbU6VZe77CkFTkA1ctDHB0QJLUuradP5QscH3Xm
	trP4es+cFLaRRqQ454B3nK/fJpy+Kgv0T2G+cP7mkG2OgJGlQxN88HAy9HSrdgoq
	87TPy0g0AkxRMdeB4T++a9sqBCSNmcNhM1OXC4oOvUIER/OhC3H//vOuVqkG/oFq
	jDEndvQAfGP6X2bJfRykyjKF01CbUuT+10c0/V0uf7i8fnxTItkBA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23pdr1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:37:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFQIq6010487;
	Tue, 11 Aug 2026 15:37:49 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy1atm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:37:49 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFbm1W25756332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:37:48 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8555458066;
	Tue, 11 Aug 2026 15:37:48 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88F3B58065;
	Tue, 11 Aug 2026 15:37:46 +0000 (GMT)
Received: from b35lp69.lnxne.boe (unknown [9.87.84.240])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:37:46 +0000 (GMT)
From: Christian Borntraeger <borntraeger@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 3/4] KVM: s390: pv: Fix rc/rrc offset for PVM_DUMP
Date: Tue, 11 Aug 2026 17:37:37 +0200
Message-ID: <20260811153738.206885-4-borntraeger@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811153738.206885-1-borntraeger@linux.ibm.com>
References: <20260811153738.206885-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7b41ce cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=JJk7vmz0-D1ayTbBKfYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX856AGH++rgIN
 r8Dk3v1H2QV1+WtDepoYwQPkXPLc49yR5tmcdUDkNXtvY1Xk76qvrsHfNmJAd6G5W+Zq0o+osj+
 ACY9ZRSS02ftX7+Ejczl3wuDS+/WH4wxpZ3wSUOXcKwMaSmCFTYlDHGaGEFbNm5romxS2cuUA5R
 PmLsp8ba3BwVdc0XqzsDp3JeUmf/Uarrv6wIejOl7g7NOcLUA8K36++bhSpLUzFgszLMugo9Vnr
 TDOcMSK2WJzoi2JJVIBs6+nXmryeJUZFW2eJhO92GsvEb9bsU+INmVP2of1UKrEciP54i2CkqEO
 kJrji9mOddm8GUYCv1S/nCyrUoUN7P7uEBjvaEO990JDJz1r0wanZmvb2lB0mFzai0WKaLeyzc8
 o9yAbM/IWb/GjvWlwMt1/iL+qAaXYdAHdG1FTAriAGmEhfYk6ihbYMUgmLUnimQMostiAKFLU7m
 rH8aLg6I6u5A1VkoIfg==
X-Proofpoint-ORIG-GUID: 4KBE-MbQYPEMKM0x-fb8TBIU8a8haV8B
X-Proofpoint-GUID: 4KBE-MbQYPEMKM0x-fb8TBIU8a8haV8B
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX2Lwlr9QRrNIj
 5aYGWnz5rObEVGfjvU7JT+tzbrpjhopOUElHJXgqkm3p3PI2HKyiNEe6BRKn7vui/BtmlCmO7H8
 vncaH5uLxyHoIKsV8xlD38uVE1Y0hAI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110130

The rc/rrc value is copied to the cmd location of the cmd in the kvm_pv_cmd
structure. Fix the offset.

Fixes: 8aba09588d2a ("KVM: s390: Add CPU dump functionality")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ea9bfb32d0f2..f3814dd60184 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -5734,7 +5734,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = kvm_s390_handle_pv_vcpu_dump(vcpu, &cmd);
 
 		/* Always copy over UV rc / rrc data */
-		if (copy_to_user((__u8 __user *)argp, &cmd.rc,
+		if (copy_to_user(argp + offsetof(struct kvm_pv_cmd, rc), &cmd.rc,
 				 sizeof(cmd.rc) + sizeof(cmd.rrc)))
 			r = -EFAULT;
 		break;
-- 
2.53.0

