Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789456;
	b=V1fmLabadDLddfWjqKbOLAX/Wg9am9/3br7uWnPYLFaLYEKKwEz+kkUBuUi7fKVJmA+q
	 eXpoJE5ntIkYDQ22F4WSI89opfotiOf5jeJaFHzXNq5/uK9heEZnixquIy9Symvd0g8YS
	 PI84m/4plRchFVTOqfdLgfTud5j7R5srUP0F2hfPVwzuAgdk1HWMkQtZ8DmKPe6yWEJak
	 e4vHMFpUIsj9iEWQCYqJrX7Yy6Cc5NFXMrZlXRcGOdSoCmgF6vTVDKRRZobtxPtImOINY
	 NxjP5UZ9fksA14gRh0Hx3KqYvvw06lwH0kEcWUhYFkkmVp5lJAXgvw2m6zzavP9F1bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789456;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=0Gg4zuT6AiBWh3LG4JIbuUEdqH1HS3sIw9Cgmfy/DQ4=;
	b=ikXSObVRKteGBLRe3UG7Ns6Ct7zuyDfwuxz2K/WIbcDcJ5KstQC7PKdCKc1ktsTHoA/M
	 vLBp89da/YTEkK9p07ksPqHM/JvOhPKbuV/AZTQ9S9z8v2+daWbW09guUMfNw4k0XgEZ8
	 pGuQJtN5etjXmkmYSTWgGxYhV4gcB+rpkUoXIp9PhXSXyQyvlxf4utotd7hJwjvDfIaCa
	 hEydNGtpVFDmg6iZUxS+kmd8yvlG8jIM0yUZeQ1ittOB3I0zXjmTrdnWtunXTRYzAu8mS
	 jHhY/qNkprjlFIvoFjlQ1nte/Wek/+uc164xBrFMyuDJyv6EZIySuZpJQo91vABfdkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=prxjRVIu;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048DC606B1B3;
	Fri, 27 Nov 2026 14:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 048DC606B1B3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=prxjRVIu
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE52722012307;
	Fri, 27 Nov 2026 14:23:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0Gg4zu
	T6AiBWh3LG4JIbuUEdqH1HS3sIw9Cgmfy/DQ4=; b=prxjRVIuZO5d+GfYvhKEVr
	1DFNCDulWiijZ6VNpLnqN84QFqSzPip82o3pvQrhnKjZKRmgY+2IEUsaDbTxqZcc
	OFz+Nw69M9b0xMnuKmjkNH9cle9tTgLB9I2NBmu0ITYqY43sK+3IWWz4+0aPmoPA
	6ElxWOZ4TZApQZAZNiA1DZumgEXKrNa4AMAbm+ELbfPvaFv9hr5UoFaniCT7sdvd
	fGkrn2bM+jI26XH3vg6a2rkHB65jmHWlRBvOGf024StYaBbNVri8A+cZsM6o+JTO
	ifq+nBFLe6vsO9sOfr8gk6EJdpRWiVHW5u1kCtUYFaZp/+JMgSEsKELIIwUNUe9w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4w8j7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:34 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4IY7861624;
	Fri, 27 Nov 2026 14:23:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6mjg4d7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENOIu36700526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFB812004F;
	Fri, 27 Nov 2026 14:23:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C3642006B;
	Fri, 27 Nov 2026 14:23:21 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:21 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:19 +0100
Subject: [PATCH v4 16/25] KVM: s390: arm64: Verify machine feature set
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
Message-Id: <20261127-sysreg-v4-16-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX5Fsg3NObXB5R
 H7nalzylBRVIMrlKvZ17y6A+YDTIpsrrsEEZFpjrkNv7szbj3asBRAYzuLb/3g9+Df6EImnnd59
 MKH/XgwdxWJNdR2eABeSgIUIZGlbAJg=
X-Proofpoint-GUID: tqW4AcI5kuv2-X-FhJX6bKnX57uio5Nm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX3fnsg/co5dd1
 RQbODBmbbuup+ESqPwjQrAMxQfwggEVvJmIPpH+wM44DsfiOIi3RXDYLhDThQjMPekODZE+3fnk
 MVqdSkUBXVk+1RVqcZCa6WO1LcEZDJ6slNrRihf96jMR/8Utf0ALsIsfnq33EbmMBX45Nmf4Zro
 nE+b41rC57NMeJ3sCPis+LtnTrwZ7JznA6PydU7btOCRCBVfizkjqSG8Rq1SY/Egrfz/CGuLmlP
 B3GgNC2xEdGPwR/tswy0U1UKEpfETn4WO3q4YAFi8Y20WTr9mv3L97UagBcu5fi1GNAYc0RHJL/
 seZe2yx8kB6k9xO6Ez8yC/8crlf0hBRiHrQFZ/DS308xia2w7VceuLpnykls2fWMHp52dfu+RyI
 G70x3D6HPNpoUAugkxnO+KG+39aTnbSJkTt+gMRPHkpR9irt5b+JCOW/8V2ote1CBzAQ8bzA5En
 Ns+QQX82FsFNv4uXPLA==
X-Proofpoint-ORIG-GUID: tqW4AcI5kuv2-X-FhJX6bKnX57uio5Nm
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b099266 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=AT7rqknK4rqI55-KZpcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

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
2.56.1

