Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981328;
	b=CaFhevcI6Vfi20e5P01PJQx3amMB9DJf9vkxteWKm0UEzHAQMNJiH6IMhZ4u4ErNW088
	 bAJqCd7ILmu2twOglVMtDd+Igl1W4d8jnY9KyDogODHCyYpBmVW4KfqA6yR6hmxydGQJ7
	 FTNCI+Q86bPiChg55M8b2URuegzceO5c9GGr48ZMjNZ2jsPlKdpgRHOHR1CIMfOKb71lU
	 NA1ttHbDCre+8XS0UaQAhDHWsIs+YmECVcLHep/8nFlXSsqxywta7cQuOSIWF5A3zZbe+
	 OjCeZWRHy3y9vDVzAhCjeXo0+WXSKfkFBsa2mevT7niMQry2t7xOJ2AFkzUW2U3GX5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981328;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=X63IZzZheOdrg6qDJSPKMNQvpa1xKEbFz3i9APvG6ho=;
	b=WytJJa8ckrE5Gkf3DH2uqfoOOVIUBoblhm15r7Ran0mqLex36PpUL8l5US/r5lAH5ded
	 W/4V1vz4n0NkZqJKCYTthObIacVeUOPqbHaYep4E9T1ury+wHhq2kVYpzFIJMSQn2HPla
	 KJSUGkuhIlqNXVfHLFKh2VsRPHb7YMwTIzhctPLe7sjjPN9IY5R4kk6m1eaw6CDKiRv3P
	 Kbt+Bc5P/AJO5DiQ29NtBlkmr29IkrJhDVP3TZVcsnM59xfl6wjkk59m4lg+a89FSs6G5
	 sDOahelSuJ7HFdc913P9mpEiTrws8i4qJrvuHBA2RTitpRK3BoOuezHBlzdtTEOnhfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fpAY2ft2;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC2F606D80E;
	Fri,  6 Nov 2026 16:08:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADC2F606D80E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fpAY2ft2
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEEdZ1544351;
	Fri, 6 Nov 2026 16:08:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=X63IZz
	ZheOdrg6qDJSPKMNQvpa1xKEbFz3i9APvG6ho=; b=fpAY2ft2FtxPoRiObry+DD
	lGC7fKq+yhpW4dJ8LHW80LnMX70QdeREV4oFosjX3ldoorq3kk6f8uXcywbyS3Sx
	s8LBHR0LlUC8C0cE3IDiyvJ6268fhgLQ/w5XELPWd4XS/4+jMAjb7oMizoPhGofk
	2RGstIp44Zz4/OJTEZdoP+4Y89ARGrfejGONHCvhf+414PHJx731PEQI5YOPxeGK
	L3mYvBP7QlDGMVma7ctBw7qgsJbjX4zJ9GcLP9Ist+8bGngota1C8T2DQMIvcmEO
	3cstg0kneABRPe6GILZDm+tQs2sqtPlA7b51hsF60PaqIKa2Gx6eFo1KWKuzV6gQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rbwf0a-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:24 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4vxf3617218;
	Fri, 6 Nov 2026 16:08:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7ukcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8JlY16646642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A4F9220063;
	Fri,  6 Nov 2026 16:08:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49C2E2004B;
	Fri,  6 Nov 2026 16:08:19 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:19 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:47 +0100
Subject: [PATCH v3 14/23] KVM: s390: arm64: Verify machine feature set
 before loading
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-sysreg-v3-14-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vCRx0Qew_klhVdlZSfdhXdccJwNGYSA5
X-Proofpoint-GUID: vCRx0Qew_klhVdlZSfdhXdccJwNGYSA5
X-Authority-Analysis: v=2.4 cv=MqLHeGae c=1 sm=1 tr=0 ts=6aedfb78 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=AT7rqknK4rqI55-KZpcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfXwecC2Xi9Vb0M
 VQGX/7EekuaLRKidMa/iXpj08xzymqIGdCzNZvuCaGUcMI9gxA8PE9mf0gNNpic95PWBMLaKSpG
 dzzC4GA3GIt6ndpI7vhWNXHDAJO60YY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX5f3P/jzU+mx5
 kk1fxbMy7CoWhH/XoOLpPet8DUOss2cnqIcnsuxpEqsqB6JBiS9VzHe90drDsgahLkUGfPKrTC7
 nh6mftJSTj3J8qbj/XGnAbiUtHLaMymHnjlupZ/kJBDCY6LM2zTWZEkMl5Pl6cAPhXVE8UWxDth
 91P9N+alQxVrN7BCP5GbzhV0Ho7p3lW4ihQSBhIdvVA2JgKZrTdSgqMGElrAPiF54tLgdJ02/Ax
 Qnj/n7V2ZCzFyzHMCcOsUq+r0DKlPfD2umo6qTUGvdJdYEceN5BDbPRUU9fS216gkDKg9elKzGs
 PVqcZ9R80MLiNguf7swYmIguZnUjm4rwmy8/xAKX+VbtPNQ0ARd496OAPZegxiXQgrpvnG9awbq
 rNpcvhZDI31hm4gwGCEAV/oAEshv6BI9luZrzWjFv6ya/x+az1Grb0jPCG5L2beyvzUFw6uTLgf
 MIvMnUZdHRl8nc2VNpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062

Arm guests on s390 need more than the Arm Execution Facility alone. In
addition, the PTFF time conversion functions are required. In addition
the guest mapping relies on EDAT2 for large pages.

Verify that these features are present before loading the kvm_arm64
module. Every machine having the aef facility present should also
support those. Print an error message if this is not the case.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/kvm/arm64/arm.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
index 62c2b45599b9..3af0b47b8377 100644
--- a/arch/s390/kvm/arm64/arm.c
+++ b/arch/s390/kvm/arm64/arm.c
@@ -741,9 +741,28 @@ long kvm_arch_vcpu_unlocked_ioctl(struct file *filp, unsigned int ioctl,
 	return -ENOIOCTLCMD;
 }
 
+static bool __init machine_supports_arm64_kvm(void)
+{
+	if (!sclp.has_aef || !aef_usable()) {
+		pr_info("ARM Execution Facility not available\n");
+		return false;
+	}
+
+	if (!ptff_query(PTFF_QAGTO) || !ptff_query(PTFF_QAGPT)) {
+		pr_err("No ARM time conversion functions available (unexpected machine feature set)\n");
+		return false;
+	}
+	if (!cpu_has_edat2()) {
+		pr_err("No EDAT2 facility available (unexpected machine feature set)\n");
+		return false;
+	}
+
+	return true;
+}
+
 static int __init kvm_s390_arm64_init(void)
 {
-	if (!sclp.has_aef || !aef_usable())
+	if (!machine_supports_arm64_kvm())
 		return -ENODEV;
 
 	kvm_init_qaaf();

-- 
2.56.0

