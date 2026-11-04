Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779289;
	b=3eh1YQjJCTM4m/L+hpS3XixYJHhYPTYR8Bo50Q+h7qFMPAnF/wiSDqJe2EXKMkJ5QHnF
	 9Co6GptKbwzjdAFYKUGMzM1VdlcYSDxRJmWqtUJ1nJCHBV7Yi7tntch/QC+Bkvwho7lrL
	 uwqpL7u8BFZg2rA0zN9QB5pOf/BX3vEn0mP3+EoeNwita/6MlDLy8ZMITJ4OJihde65rD
	 QTT4L2dJtw9WTMKJg53v92DLxumGtJKG1iaLOqpmD2d5ny5MEp7CqOuoogdaXnaCCOA3f
	 GbL1bQrhxrfE9YtoYV9l1k0sLprp/6TCphk2yIB6KRTFumsfgCd5ov3xYOdD9x+7MHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779289;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7IFQdpAf7OiitZImAANAKPDNqhgDnVNsLXAOXkHGUhY=;
	b=GX3uydkat92/ePtpN/wsoi8J+e5gg7KO0VXNdrrrkGfizYUNJUDzP3y36hAIrWh1ULSu
	 PhVfo8MCBqVQzJWHSbXnuR/h0E0gdl92sXoHwWbQIzdGw561vaqia7+zAqjtoRXnNHurM
	 Di0D7gCC2HJR1t7Ys5Ch9u1hxpTPgIPm35EJY/F43xhPO1SGD8ueZmcKEr4ZiZRjphvO/
	 8e5E8wJahQl0OYo6QupFmo6L1FEwQATZWu7phfTDyDUaKmNpkHBJ2HMm73wibKU8nisxT
	 JGYRh6//JQHNQwWwDuxRvyQbufqfucXsbPJgalfO3zzHeFg8QPuvZWijCYx6I055Yfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RDGoImBX;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4EA606A336;
	Wed,  4 Nov 2026 08:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC4EA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=RDGoImBX
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A40kGaY2170072;
	Wed, 4 Nov 2026 08:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7IFQdpAf7OiitZImAANAKPDNqhgDnV
	NsLXAOXkHGUhY=; b=RDGoImBXg7GNC9l5W7vcoWZ4pyR39sltLsNhE4LPx0SOrS
	9LTVMgms9v4X8hIe5Cx+5LIvuzTXnhc4rv1pjTTvgKEXXGpDbVnHJ6ZFgznXieYF
	oWk/JHMB9f7WsJViMXqLIjUPlQ0RhapNhYnz9WoCXx2NU7Or1pAs1wLdlHH/+gNb
	2FS1flfKzppgoRs6pucFIX8fInSRraiAn9/QrxEaMW1AE0NLOJ1CrJxlyJ+jFFP+
	fNUKg83B/nraek/4AHM7JvdznltZ/KSWNGCA+i3s3fw5oCmolUWE4WONunYrENN2
	UmqrolibqDfGDAIajCicM+jC4dk/p5DoQuYbZtuQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn6rdabs3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:01:26 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A45N7DM3382714;
	Wed, 4 Nov 2026 08:01:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqf0gcjdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:01:25 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A481LLm44302768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Nov 2026 08:01:21 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B893D2004B;
	Wed,  4 Nov 2026 08:01:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8769320040;
	Wed,  4 Nov 2026 08:01:21 +0000 (GMT)
Received: from osiris (unknown [9.68.29.29])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  4 Nov 2026 08:01:21 +0000 (GMT)
Date: Wed, 4 Nov 2026 09:01:20 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Andreas Grapentin <gra@linux.ibm.com>
Cc: Marc Zyngier <maz@kernel.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] KVM: s390: arm64: Declare enum vcpu_sysreg
Message-ID: <20261104080120.8132-B-seiden@linux.ibm.com>
References: <20261103-s390_arm64_kvm_fixups-v1-0-21c36fedd878@linux.ibm.com>
 <20261103-s390_arm64_kvm_fixups-v1-2-21c36fedd878@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-s390_arm64_kvm_fixups-v1-2-21c36fedd878@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JV1bS4pmc1iBQA7fsJXTnEoBQ52S07w3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDAzMCBTYWx0ZWRfX2JOMDBG+Yabt
 oMS/P2s9/yRDM297jH3tp/w8Rl3naZep+7ZNKWb7T6BCJjEE5to9+kna5xs5V/uwmdK45dYgBZQ
 iJFwVIEhdBIztM5yRGEiTCb3BGDBU7LaN9ryxh3K3vSD52qgagWoaOZySxJVmXkBH435DAvNHE+
 Ecy53NMyyu+nEWufsvIH+2HDk7fGpNX1Wm0Y18hbl6kF8wSN3g1tfmytQzajRnFDXKPSChnYjJF
 Ym/HkWxyhLVfrhsbWpedldj6n0GMK6SW8C5selZA3RoNnP92gHzOPKHTaV5FMJ/yC0S8iLNODec
 /q2Ipgq2fn01MV48hSW/kaqWtk83rQZ4Bjf9Jcnra9BsUgsA1KSSPZtWG/hbCJ+geDau6jYXara
 OZHW2a4u5GHkXDXQgA4rGUBag5zUhiLyqf/d0ZC2N0dBO8eJv0UQRAXit/1eFDkQzcH7r3xITa8
 VzGIz3A8ejKR3G8qyqA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDAzMCBTYWx0ZWRfX0DyaQaongFAV
 og4FGPigIg90dswws43Ea9gaXf43Qg1O389tvaX2Glt7Etcgiqo0ccErGhaQlJOrDHZqEPr2HmP
 93p50jWQpxmgaIfWG34FOskAqVNGZYA=
X-Authority-Analysis: v=2.4 cv=QK391QLL c=1 sm=1 tr=0 ts=6aeae656 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=OBRyGL2bl_8etBElKT0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: JV1bS4pmc1iBQA7fsJXTnEoBQ52S07w3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_01,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040030

On Tue, Nov 03, 2026 at 05:37:03PM +0100, Andreas Grapentin wrote:
> Forward-declare enum vcpu_sysreg in kvm_host_arm64.h. This should have
> been included in the first iteration of the header, since we will need
> it to talk about system registers.
> 
> Since the definition of enum vcpu_sysreg is not shared yet, and not used
> on the s390 side, this should not cause any functional changes.
> 
> Fixes: e6c329180d1d ("KVM: s390: arm64: Introduce host definitions")
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>

