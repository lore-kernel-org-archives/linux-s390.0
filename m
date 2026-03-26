Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DB5332601;
	Thu, 26 Mar 2026 09:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774518323; cv=none; b=XmIs7tRY5YR76NStiXx3qRjvuyJb8tsLelgphU+7lrXRz6WfluLTA7AVPvJ7Fx9mwChA301HPDe9A7WWNSL3eNnnlZ/++A23caMAHQx1CUQE/5412y2Kvqj3FoZojX0p2hiKOR2bHaiVYTZv8C7b8kAmxgQkHhHfBMZ7PpUTFpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774518323; c=relaxed/simple;
	bh=TXavQmditDcULWBo+TMqg29LHIz3DuaBaE5h7WTspzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYSNNMty3TeBBkmSA78K4DhOobQplWMNEEP6VeKumMr8YFVeBFPQOFT8uJzSy+ZbUlZjKKrkgpSTnvg4H519Uk3KXnRZBeLtyw+O+ZP80ijCHEDPt9mehEqzPN8OUkcdwd/21QQ4dhW96800uKq25lI2TR04IzeykQOdLrw5vSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NB594t/L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NB594t/L"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62Q062Ul4120967;
	Thu, 26 Mar 2026 09:45:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0cqoHg
	iMDNhlRxp2Fswbacf4miV9djeYye+ItQmP1mM=; b=NB594t/Lz0SkWD5ewAeGFY
	Li2SRrMWoSw5CH8u5VrYqikt3mL/KtisZaWctZ3VQeQud+jSmqzRlvI++6epwRmz
	JJespp1UVTS3CnqwE1Fw/KJYIVNrqa5bKOGHeYR9b6qlcAfnOK0Bs07Y56otAkLJ
	rQNxiHP3dW46ofxh36xxjn3v2AXaQN6Q96UA5g3Z5I7dlUb0+i01ohGA8Gqbo1Ao
	UWcg1OlclnMU0US/1qnQTkkREKY3ymv4ffiQduxks1vAfA5pvT3FG9j5qi/QThmg
	Nzq1Auu9SCRsioSGGWTtOELotAaCy7ucdlDR2ZeInKZOAj4jieOcTyXkcQqG/kiw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa4j0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 09:45:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62Q7QcUL012203;
	Thu, 26 Mar 2026 09:45:18 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vka5rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 09:45:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62Q9jEZs51052958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 09:45:14 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF62520043;
	Thu, 26 Mar 2026 09:45:14 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21F9E20040;
	Thu, 26 Mar 2026 09:45:14 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 09:45:14 +0000 (GMT)
Message-ID: <d3e51eb4-4cc3-4a6f-8b5f-69d8586aefd2@de.ibm.com>
Date: Thu, 26 Mar 2026 10:45:13 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] KVM: s390: Correctly handle guest mappings
 without struct page
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        frankja@linux.ibm.com, nrb@linux.ibm.com, seiden@linux.ibm.com,
        gra@linux.ibm.com, schlameuss@linux.ibm.com, hca@linux.ibm.com,
        david@kernel.org
References: <20260325171311.182210-1-imbrenda@linux.ibm.com>
 <20260325171311.182210-6-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260325171311.182210-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XgO5iikObiz3Kq_cQ-qCJ28mBR_lUFrf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDA2NyBTYWx0ZWRfX2X70alRl6N4C
 QJ7IjgT3vidpl0d5l4k6PeCPliVnp6UwXGDXucfUJv3GxxILs0dTrQYl4L81BzDdv67WGgETlUA
 SaerR7+dRFGG5I2vvQlM2SwvZriUIOikdkFAbKFTirrlB13VZHxrz5rpOovuk3511NEIt1rJeCd
 eLDvDAKJ2hQXwu5TFp8Y+Almfrrl3p7D1hnPrVNzpe7lYPWjvC5X4ZmhNfGS1SHT0KmXp9l3XiW
 XvgcLlFAmhJFo/3NA+3lm+hpyciPKbNj/3roalzlV3ryemr78+FoGAT5hdzqfdVIDIDAcgfGpDr
 BGDAjSGbLoaHL5q195KzSP5QhhH94OxZbhz0VcQcjhGlTDek2/MMht/eIJl14FbVdHm/UXjJQ/H
 GOEmX/VOgmZNMVSP1gjsHJQkqsdHeshZkmD5JO5rM4QbZvtV0BEVh/JjCOs11G5bjbU213ws0Bl
 GVRM9rNowho8LNB24Uw==
X-Proofpoint-GUID: XgO5iikObiz3Kq_cQ-qCJ28mBR_lUFrf
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c5002f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=01WDIeCSy4eeRB9P3R8A:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_02,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260067



Am 25.03.26 um 18:13 schrieb Claudio Imbrenda:
> Introduce a new special softbit for large pages, like already presend
> for normal pages, and use it to mark guest mappings that do not have
> struct pages.
> 
> Whenever a leaf DAT entry becomes dirty, check the special softbit and
> only call SetPageDirty() if there is an actual struct page.
> 
> Move the logic to mark pages dirty inside _gmap_ptep_xchg() and
> _gmap_crstep_xchg_atomic(), to avoid needlessly duplicating the code.



> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functions")
> Fixes: a2c17f9270cc ("KVM: s390: New gmap code")

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/dat.h  | 12 ++++++------
>   arch/s390/kvm/gmap.c |  5 +----
>   arch/s390/kvm/gmap.h |  4 ++++
>   3 files changed, 11 insertions(+), 10 deletions(-)
[..]
