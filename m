Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DA2392C5A;
	Mon, 13 Apr 2026 10:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077277; cv=none; b=baBfHucx8hUvzmgByL9N3kcvkzBZBq/a6L7+YwIJmu+oFoIiZOe6VTbSjVmydI+wkzA6uykVrv6hz6V1J4XkCPtgV246bAw7Gyd22yU2q7IQbdfaK15HmCbbdMpuiiC9j21uPX1LpPqzvP3AvJWjyOhRSpuuGdfEp/gWRxFPVSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077277; c=relaxed/simple;
	bh=B9QRSJ09jOX2GXROlFd7b/+IUbp4wTxf9OveRnXC7+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwXkEmsuK13+PsNHkTvnjOU66m2kzAlxRHzaetJPCiFShrWySiAFDPxsfXd5ID+Evm0Goq6819KBdTC68A3B/Cfw/nuJ5ELwzXyqAjUViVdEVpVfDW71bjJLy8JnWYdeWkNmshKJxWlxVg/O16fOQxSyjnZw77qovduGTjz4Vio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c6NiEUP8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c6NiEUP8"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63D9mVDD2068455;
	Mon, 13 Apr 2026 10:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LNNpmv8yOhbUtIQXV
	Y9zw8nnEaxt+UxWO4eIy/wm/hQ=; b=c6NiEUP8drjR5Q4yegHZe4pUEsqHVavsJ
	IRaBXG3TBLO/fLHuHrWFGrxZrufUnPkzxjNPMEXDVYbglyBDBLoueTVLsTAalnR0
	SXQak4bDgNDOD/lTpzTis7IKuP4q5kjEA+78KlyL85EYXFrNwjpC0gJR68DH4Wvq
	bSYNslF/XNN2hfEDjNJli43rceR9e0FUrSzWlBRz+nvBu5v51mSrEOmsSPmZ70kb
	2+frEHxom03OQwbf85R9vr8+VZhUVeQ+oYe3ctmaNmKNAjQZybPnKSqfRr/lQH3N
	m/ysxTj5VRfmUaMJVvylaC7js2C2HyduoYoQVjpQKcTp4sBfPdQCQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfdyqq6rf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63D7teIA031191;
	Mon, 13 Apr 2026 10:47:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10y4wgp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 10:47:51 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DAllgu59703700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 10:47:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69DD420043;
	Mon, 13 Apr 2026 10:47:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E210C20040;
	Mon, 13 Apr 2026 10:47:46 +0000 (GMT)
Received: from li-9fd7f64c-3205-11b2-a85c-df942b00d78d.ibm.com.com (unknown [9.111.7.85])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 10:47:46 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        borntraeger@linux.ibm.com, cohuck@redhat.com,
        linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        Eric Farman <farman@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [GIT PULL 04/12] KVM: s390: vsie: Disable some bits when in ESA mode
Date: Mon, 13 Apr 2026 12:46:32 +0200
Message-ID: <20260413104721.203024-5-frankja@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=ErTiaycA c=1 sm=1 tr=0 ts=69dcc9d8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=hR3koBuu2k_ba2zxy-8A:9
X-Proofpoint-ORIG-GUID: hOqptBfHJR64GKG396Njcvw1dKul_jKX
X-Proofpoint-GUID: hOqptBfHJR64GKG396Njcvw1dKul_jKX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEwNiBTYWx0ZWRfXzBh7M7pP7csq
 7+hGygK23MvoYft2XtFdqUjEyi+zUEh52mT41R+vlsVmKInLCU70Ro9XjYRNhRplMLcdsmAyYAQ
 FeRDGet3irLtrVa1dvwWpi40IW//3eviPvQ2ZEm/h7NA6v6E+0MVnohE4YoLkUifq0/8IPDwErd
 Jt+lWsXDn9GFMWP8n4OfMIj8iuvk5VbswGDAIhFK2xj4ZtuH5P6PbeSKNuouauTFw4WVt6UDm1v
 OFwRh579cb8A2QeRk7Zvqy2TYs8b5dhMzKelpcMvhsxz4IhprbYcTps+oSEUhw9ErYtKIqc8jzO
 P3S7aumdZeIOzlBmXPQIpqCZ+7powSr/9KaMOm+3Kv5OcWCfPDJd4LGVBaUNfk1ZSVTBeeZSATT
 ng4rd9UBwBN4NZDD2ZbK9lGTwEirlGFdze3Dluw756hDzBYb1lz2AooH0P02WMSsTmD4XHx+TsZ
 ICLCJeEt5BWAj3Raq+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 phishscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130106

From: Eric Farman <farman@linux.ibm.com>

In the event that a nested guest is put in ESA mode,
ensure that some bits are scrubbed from the shadow SCB.

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/vsie.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index aa43c6848217..2ce406861d22 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -387,6 +387,17 @@ static int shadow_crycb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	return 0;
 }
 
+static void shadow_esa(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+
+	/* Ensure these bits are indeed turned off */
+	scb_s->eca &= ~ECA_VX;
+	scb_s->ecb &= ~(ECB_GS | ECB_TE);
+	scb_s->ecb3 &= ~ECB3_RI;
+	scb_s->ecd &= ~ECD_HOSTREGMGMT;
+}
+
 /* shadow (round up/down) the ibc to avoid validity icpt */
 static void prepare_ibc(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 {
@@ -590,6 +601,9 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	scb_s->hpid = HPID_VSIE;
 	scb_s->cpnc = scb_o->cpnc;
 
+	if (!(atomic_read(&scb_s->cpuflags) & CPUSTAT_ZARCH))
+		shadow_esa(vcpu, vsie_page);
+
 	prepare_ibc(vcpu, vsie_page);
 	rc = shadow_crycb(vcpu, vsie_page);
 out:
-- 
2.53.0

