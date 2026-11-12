Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489945;
	b=nAWlruWguIUClAD06pr4QjWwP08dJ6CL96TRyiSdRFMHkVWSRD/e5ETy7kxPpnSRPoHF
	 9kO3opc/uAFd8PNfkw+QoNMAa0wKCRp9xxHOjxTzRvKYkcLmLHSuTL23Fc5KzXSK1Hhwc
	 ixNHzwQKn/2bHs5/JvepDrFYd65P5teNhn+xwRR9IZtUwLYSVm385v+i0+Ijs70AYg9rT
	 Ud+ZTJvkKB/92ZyZ/rjrI1ZrDK1ekUpTXqD79NYbkhI8MhrMT6kdw5Vq1ILgfQJAU8ZSq
	 pC5jRQ2D5Sy2a0vIqpB+rhzJYgAaLs+OjQdvHMkIw5umjpwVlrkNIUG3LnfH1ZVWx6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489945;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=cNcoAHu7FTp6aY8nOsRpj+j/XbB9If11dkNsmr5G/As=;
	b=R+03yHBXrN2RT3fHKPi0KdZfjdlKWCJ1lkwxDuF/YYLhEgG7yJ4n0ByTeONyAE26aPZs
	 QO80XKOpqaaZq+2dgYnnUX9gUVBuL0TKMlwWQwVD2fhbKqxse1q/Nn7+6SlVkoDJ7z9SF
	 7XrMmCMKZ4hgFh7Q3il1gwLpiqgTxObgJp5FwLqy3mxPyU0w9Ev8VaSpcY+gOD4u6HipZ
	 pVIEeZ63nMNq8UVLATeDAUygHFAsOQCff/uOKBi/WWkhA+nHVWQLyKX0HlDl58X5DeAUk
	 kno1TAJ7qs+qwJWrE4Cb1QnJKUYFhlWMP5x7QJvF3p6u2W8gH7VKdbWR/v5qow0u22w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=de.ibm.com;
	spf=pass smtp.mailfrom=de.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HX+9KrAR;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA75A606A327;
	Thu, 12 Nov 2026 13:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA75A606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HX+9KrAR
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ifNL2796514;
	Thu, 12 Nov 2026 13:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cNcoAH
	u7FTp6aY8nOsRpj+j/XbB9If11dkNsmr5G/As=; b=HX+9KrARYQBYgHkeDBg4hD
	V0D9HeNgtjjGLFN9BJJNwtXch/zKHpYebbDovRsCz7C8WtC3eOwnoF4TKktpD/Re
	voApLLE6JykbsmlfeHvcwX6QpmlCbjg99dEpZFYPPYH2A8yNOR5vySJFRsdVtJ6B
	If3qk9uK6kW3Z9t0XYHz1GlUHSKjN5NDRF/4Z63WiopAXW+KMNpUzBybm66A1WUq
	hnHll1mK39MiCvTsfM+HtjaHJ2vx52QED2slbIgo2pYJdRZ1SaqAPZtdzbAEpGAg
	H8dYbkAr+QMRUigWfRlfO6/+JXS9CQeZTq20hrgUy2ZNRAELcNX2TnfolPec54qw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdky5vy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 13:25:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ACD0Dp5106728;
	Thu, 12 Nov 2026 13:25:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hv4nt0hux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 13:25:40 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ACDPbU117301912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 13:25:37 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 156772006E;
	Thu, 12 Nov 2026 13:25:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C04020072;
	Thu, 12 Nov 2026 13:25:34 +0000 (GMT)
Received: from [9.111.75.87] (unknown [9.111.75.87])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 13:25:34 +0000 (GMT)
Message-ID: <ee7a1419-e7d3-49ca-ac1f-325dbde16d87@de.ibm.com>
Date: Thu, 12 Nov 2026 14:25:33 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] KVM: s390: vsie: Fix pinning using the wrong flag
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@kernel.org,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20261105153705.208516-1-imbrenda@linux.ibm.com>
 <20261105153705.208516-6-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20261105153705.208516-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af5be55 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=9Sq7UIcimCeLBsPmCeIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX6ng+hdtwnI8T
 2RM1xdH2hvotp/nZgCzLUlW/UZ7C8Jx1FN7FCk4TxeyZuv/TOpwaQRqtetPU0ml4a2sCV85dYsP
 G/vB7vlFXFxv8anRGi8+Y2Zk+LgMC84sQwbSp/kWnVWSbBrtYt1qqtsu9l5b5UNMzuDbMdSM4Mj
 T+adn5TGJsMO2j74WTHMYaGKkdaJMIZWTSfVkwxLcw15hkbBlIb7Qb3zMw/Fs6zQgxnEU+v1ARN
 MhIRePbuABTdDE35+k8/SKrO79by2+X27Kw8MMshDNFBE2Rl0z4NxSLsy4k7ZKArn129bSZ1MNO
 GYXDH2O1pTRJwXcVcr/HAkANEDguiqwMEMCaeEwFtQ3/4CKd5qfilP5aGxYqmDmQgs/xUMpff7L
 m2I7Zwbp0ZNfZ3PnQqnyXmQrcmI1nykEJtMdSEWf7DQq7A6Y1UaVYYiLdPujgTKs9aan2PuHuzx
 gAOc/wfDHcP3ISLG9ow==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDA1MiBTYWx0ZWRfX5OVlrIrDuzVm
 l9d0c5QbVt59n0HOP+5hGRSI8CcR3Q2JL0rqnZhf4zVWCBDicE9fUgaCVcb67KRgRVfFXAg7zZL
 Sb7fF55c0k4UEv2eCkH2eTFBPCIknZw=
X-Proofpoint-ORIG-GUID: 3_OCCltaU1blaOYDWH80YrRXrDAiYVt2
X-Proofpoint-GUID: 3_OCCltaU1blaOYDWH80YrRXrDAiYVt2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120052

Am 05.11.26 um 16:37 schrieb Claudio Imbrenda:
> When pinning guest memory using pin_blocks(), gfn_to_page() was used,
> which under the hood uses FOLL_GET, which is the wrong type of flag for
> memory that is accessed directly by hardware.
> 
> Fix by using kvm_vcpu_{,un}map(), which uses FOLL_PIN and is the
> correct thing to do.
> 
> While technically a bugfix, the previous behaviour can only lead to
> guest corruption in extremely convoluted test scenarios that cannot
> happen in real/production systems.
> 
> Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


> Cc: stable@vger.kernel.org #7.0+
> ---
>   arch/s390/kvm/s390/vsie.c | 133 ++++++++++++++------------------------
>   1 file changed, 47 insertions(+), 86 deletions(-)[..]
