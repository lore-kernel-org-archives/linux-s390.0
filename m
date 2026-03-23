Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E211282F04;
	Mon, 23 Mar 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774280214; cv=none; b=dU+edAkxrjAzByVC4yAEHq+H9TR6UqN+e+SDN0Jzrx7MEBruNzPuofQHS0vOac8P8a+B8KSOPPkoAtfge7uYMltSv3NAzYd8hPFTAurN8YUv9PS8v74n0iMBEKP7FDVlONfwz6eVjWZIyPJK9TGHSiZuqm998oYCgCpIRvswaWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774280214; c=relaxed/simple;
	bh=cGrlbURrVimoHzdQ+R66wr2VTHKUoXiluc/uctQM+k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iw5NZXadTm9c8AycGnhfa3t15je9AOQCbCBxCXji+qVJDK682notuim3SXdIjekL6zJ8HjLZdE8Eln4n5iO6de8wzH/vphVWPT1+PYpnqHgQL5pDX7B3VZvR3WXGRWMgv57vAVl2u2qDz+ZPVu97sz4lDZU//P5FnfFmDbvwew0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o1iiwOBq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o1iiwOBq"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NBANiA4035479;
	Mon, 23 Mar 2026 15:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qgfSrGE6+3voBrKlD
	hWDJpTC40oGPQLMuyqXLlRti8A=; b=o1iiwOBqJGF2NQllxwC2fw3qmu5T8UgmA
	P1at40y4q2jBXZuZ60S/m0frujU0bbgC9+vsJoBgNji7rWUMuye272ZJIQYqmpEz
	MfOeGmoVYmeWVpsPTgRAWYScIYC7RDTzhDEiwTZvHITRUpuDxzmkOV5j6NeU0Elo
	Rsed5f/x1J44h0aKc+ACNLgpsbJHOuYelRIp5zwFM38DOu3XUatMzAptcmi7BG7O
	ma0TJQQB3AV/Ii/MPSEPHiWjikRElWeBumRTxFe3InqwRhcEuqn+yrnqwv5NtNCK
	zHzP0lw+WJYVvHObkGtc+Zv5bG1/RrH0dS/k3uJw/pnYjFOyLh5aQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxq7j1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 15:36:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62NDUT7r011789;
	Mon, 23 Mar 2026 15:36:51 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vjwqu6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Mar 2026 15:36:51 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62NFalfv47251872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Mar 2026 15:36:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD22320040;
	Mon, 23 Mar 2026 15:36:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2A1A2004B;
	Mon, 23 Mar 2026 15:36:47 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Mar 2026 15:36:47 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com
Subject: [PATCH 1/2] KVM: s390: Fix lpsw/e breaking event handling
Date: Mon, 23 Mar 2026 15:35:22 +0000
Message-ID: <20260323153637.3683-2-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260323153637.3683-1-frankja@linux.ibm.com>
References: <20260323153637.3683-1-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _s3LazY0hEuJ72t65GCHO2_GS_vtjQat
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfX5zU/n2YxXNjd
 RZB271m9ZKOSzgmgP/bpvT/n9PzUBtMG66ZWNjf42T0ikDUPZYIr40cjd6fWURqduU6Z7BMJSX1
 V2eXm99H4LWpz+eNxREHTLQNlB+McSUGs0r5ZtonnkblPwCp/K+iy/PEg30wr6MFr3n8p5fw9dh
 2LNQ9v6lhLDVfKTvnfPjseyBd6Va/aFK4NHzPe2oZ692zHPldqaXQGWWuHvQtf77vZ3oiQ7edj3
 1FOejwQgDvDYFP6Eu3g38r21BABaPnuyPCrUECSgSe5sMoAPMvFlEteatOLsxfyxjQ9HxXp3Gas
 BLvcW+B7IvZruFFysSLcAGdtl57t47jQWEXG4Ondk9TBPXj7MOe6ewKpwORcFNX4DqGQZMd3slP
 uWMaO/VuQ+h3AyH+6dPrt+83edpEb2ruzd2mcFwt3QthsT2DOnf7/ZkVXgQVGumCW4T7YXSeMoD
 TZPfIfq7CmnCmi3MLxA==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c15e14 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=DrbGolfmOjewO6_yJogA:9
X-Proofpoint-GUID: _s3LazY0hEuJ72t65GCHO2_GS_vtjQat
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230118

LPSW and LPSWE need to set the gbea on completion but currently don't.
Time to fix this up.

LPSWEY was designed to not set the bear.

Fixes: 48a3e950f4cee ("KVM: s390: Add support for machine checks.")
Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/priv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index a3250ad83a8e..cc0553da14cb 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -714,12 +714,13 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 {
 	psw_t *gpsw = &vcpu->arch.sie_block->gpsw;
 	psw32_t new_psw;
-	u64 addr;
+	u64 addr, iaddr;
 	int rc;
 	u8 ar;
 
 	vcpu->stat.instruction_lpsw++;
 
+	iaddr = gpsw->addr - kvm_s390_get_ilen(vcpu);
 	if (gpsw->mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
@@ -737,18 +738,20 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
 	gpsw->addr = new_psw.addr & ~PSW32_ADDR_AMODE;
 	if (!is_valid_psw(gpsw))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+	vcpu->arch.sie_block->gbea = iaddr;
 	return 0;
 }
 
 static int handle_lpswe(struct kvm_vcpu *vcpu)
 {
 	psw_t new_psw;
-	u64 addr;
+	u64 addr, iaddr;
 	int rc;
 	u8 ar;
 
 	vcpu->stat.instruction_lpswe++;
 
+	iaddr = vcpu->arch.sie_block->gpsw.addr - kvm_s390_get_ilen(vcpu);
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
 		return kvm_s390_inject_program_int(vcpu, PGM_PRIVILEGED_OP);
 
@@ -761,6 +764,7 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 	vcpu->arch.sie_block->gpsw = new_psw;
 	if (!is_valid_psw(&vcpu->arch.sie_block->gpsw))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
+	vcpu->arch.sie_block->gbea = iaddr;
 	return 0;
 }
 
-- 
2.51.0

