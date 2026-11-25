Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601895;
	b=gAkUjwCLhd1i4RmvVak3DdlcGVJnOzVFNifWxECcFgSlCrN+HaxfxKPhUNij56A8i11U
	 9ECYBO6sieAsManoST1y5Rn7RVsTJ1DLb219pmoQi9xSJBc7vooFvDW/pErgTcrepGOTU
	 IgG2KF1RkqLEyUoI1Y2utR0cqed52RIzTacoWt02mYJmCyaLoRK9aoTtLa00MytlCTPY5
	 NPjjPjxNKsz4mrlZvudTXO7htcCvmZfKK9j5gY3sCaFgBQqu0wq1Av+Y2qF94RJ6XKcOx
	 pfQW/c6E0POwHVRGU/eG0IeT0KT5ljzG8ip42QQ/5FP65T++K9N0NdYS5ROR/2xgrtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601895;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=xc3rAzR3BKcwk+iPtix5gjzzdp58bNISxYadjqSQCdc=;
	b=b+vbJs9sDLY6uHdogqfsL5z4KD+eKxNmRMHgHHOcOuzIawsAlYOSUXEl8vMZ0gjly155
	 BhPG2vM3jl5yBjX2hLEHlDrJEZHWqPbCDsHY9FpctpRq/DGn388xXN/RdcZ6m94CIBoQb
	 Uqe36YuobkekNBLAEH3s+D9E3s+PEdD3u5pUH1srPiOwM9CkGw94RU8srCuxdn3R5tc1s
	 ret+TBSfE1Y2RLUKTyA/PZFtnDo8ImvaUiJ+8FeBj7WzgrH8goW1G//anEiO1bqluW3P6
	 w7dziKrnxfZnjrCTnQwbC5vIHr/07YbKKCOxapHJ3mH97OFjS8Uy8B3jwSlBHUDVgZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e5l6C8BE;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA719606A680;
	Wed, 25 Nov 2026 10:18:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA719606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=e5l6C8BE
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APA4fOu3596881;
	Wed, 25 Nov 2026 10:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=xc3rAzR3BKcwk+iPtix5gjzzdp58bN
	ISxYadjqSQCdc=; b=e5l6C8BEbchlivpmb9kum2JBy2D/eOCHML73iJS4V21PQ9
	r6QM6FVO19pS6aISA1iZiXC3Fb2R6scpnBGsqRcrRVrR8ei3r4r77Qt4l75Ph6WG
	bjRSf9X6fGdeFk9QUzki7jpCztBFpDsrc0OBVJG/2rxt4VUgVc2M0hMQjOpMFCr7
	1Wm/fWDSvb9YQkijTjjsdG9mRsGOcYNcUKt7K1/lELQ+NAqtT20Xx8yEtCBdmkXW
	IgmGJCk4SOVsEPHWI5jZ05mEbXN8nhkdq7igqj2WJK+dkDRG7LjDdpXNORUO+ibd
	Z/ioAc+n2sFCqIP5dUpz3jrF/bQs8zfcPRnB9zvw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34g3bvea-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 10:17:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9nJPO1684184;
	Wed, 25 Nov 2026 10:17:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j3q4he0jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 10:17:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APAHmvB49873302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 10:17:48 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E6F1820049;
	Wed, 25 Nov 2026 10:17:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9FF020040;
	Wed, 25 Nov 2026 10:17:47 +0000 (GMT)
Received: from osiris (unknown [9.68.29.29])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 25 Nov 2026 10:17:47 +0000 (GMT)
Date: Wed, 25 Nov 2026 11:17:46 +0100
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
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] KVM: s390: arm64: Stub kvm_vgic_put/load to prepare for
 kvm_vcpu_wfi
Message-ID: <20261125101746.19000-A-seiden@linux.ibm.com>
References: <20261125-kvm_vgic_stubs-v1-1-c53ca2c5959a@linux.ibm.com>
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
In-Reply-To: <20261125-kvm_vgic_stubs-v1-1-c53ca2c5959a@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SoQFe/O0 c=1 sm=1 tr=0 ts=6b06b5d1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=HJy76JGAcEhFZ7oN8NcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfXyY6p2prOExac
 YtqsVNZu6gVaGSv7Se5Zc5yDOapeoMdT2JZbdKd1S8/crsS3wsnLfJXfNe10QzK1dtyLULUcd07
 tSr/2gfj3hPypbnXUlkUYARLarcfMGE=
X-Proofpoint-ORIG-GUID: iNa-IUaiCdfjOkHlTS9e4wnHewJC0XHQ
X-Proofpoint-GUID: iNa-IUaiCdfjOkHlTS9e4wnHewJC0XHQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX7JcQ3y+bvA42
 mxTICBiTN4CCL4uPBkDxE71uyAJr47BYxp9ZpHzrWWrVoGzHyNtrepHAXNA2NgXu0Iss38ui+ks
 Xab9EISzqVuDX03n4l5oX3M624aafLlx2rWWNFz7vsR5GhGB5b4PV7M95Wc+JSe1EPQ2OQb+UJ8
 m1byeSuTyk6e6dlZDXpdOnV3cTeKDjCtDv3C76Ys9qaJVlKzRtsZLawGWZ2OTaqI60SE5PrCQmB
 TsvHcKLaTx5Pfq3txWtpbHvmTXp3GKqyqGRXU/kgsrCHtFVRXDwp2IZ9yGWX/tRyxzYIhv+duE2
 J0GVmjKou+xJz6llIWNIJDJNGQJZguLeg1DP2qRNDEhcyeoz9qNDeldfbWfj/365cH0Acx4UMUM
 xx1Wt4l3CsOhiImLxAXdAoDbScy/ErXkz8PeDWdGFEQwBLadMkypu7WmOynnE3f/ORIdeMZIST5
 D4GBVnmDkSFR0Xhiurg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250040

On Wed, Nov 25, 2026 at 11:12:15AM +0100, Andreas Grapentin wrote:
> In order to be able to share kvm_vcpu_wfi with arm, we need definitions
> for kvm_vgic_put and kvm_vgic_load. Add these as empty stubs now to
> reduce baggage in future series.
> 
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>

Reviewed-by: Steffen Eiden <seiden@linux.ibm.com>
 
