Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2BF39A049;
	Wed, 25 Mar 2026 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774428602; cv=none; b=KZK7aKsV3dpht7RieSf2V+RnmkW4BiGDWQkRtEfgwwoPTMNNm1NVD6BOsoqJtRz1zoKg/XezhfgFY45oLfvjwo1D29HXjkNxhpSycRG9JSwlBX+uesn/Ldd4K+hUNUGxtJMIRhitvkTMUs5dAxCL5QmwbHKpqXwmQGCX//0vxrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774428602; c=relaxed/simple;
	bh=MhPf69GU83kHXH6p8NcEGQWKz8h88iglzINS0wnJxZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HekSB8vh6T7WJ+Dc1MJnfC9beEN00/AUN5FUeh7dQ0z6aETL1pFwGdsVBynEtVjvww3EHW0aVo5biHf95JvD7Uls2lWxn9bgarb1dA/+9Y/wJ+641N1nfwSabUUWkKqOhyBSb7PKBTvwKY+cQ9suZEeQKqgfLrcoOeib328f8qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mThQoHcZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mThQoHcZ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P81GSc3317009;
	Wed, 25 Mar 2026 08:50:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B63LRN
	G1rTU+g2jzug/yvzEys9jr+igSEa1eIpCLpuo=; b=mThQoHcZAp2lyWBDdvc42F
	KXS8RxYNDyi4+ZgDuRFbddRJFnNP4XY860x+I4ULZxK+pLnbpO+4lpTosPSLEcz3
	L17DeYbBbO44Bc78gaQTXhf7jKeZIz+RgglzVWSAAApGgOvmtsCpYG2DEseHaXL6
	SFrChvJkffuuda7CPj2v9t0jsliVSM+sGFUyj/QOKPOAjfchVpt8FuMiAI/C5Cab
	I4aWlfHwscz2BOvq4cjZzX7Hg9deH48l6oZ3Og0ISYCxkZ8qFaSPDvNc0fQpE11q
	nhGDbicdROAiDerbQH1luLWPCR3A1e9aVVT2dMulVKF+foUVpNg/WRIOJK2nMiyg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky06qb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 08:49:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62P5nQNf031631;
	Wed, 25 Mar 2026 08:49:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nswvec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 08:49:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62P8ntqK45416840
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 08:49:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D1332004B;
	Wed, 25 Mar 2026 08:49:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD6EB20043;
	Wed, 25 Mar 2026 08:49:54 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 08:49:54 +0000 (GMT)
Message-ID: <446104ba-f8a4-4f4b-9b00-72cf5209d7e7@linux.ibm.com>
Date: Wed, 25 Mar 2026 09:49:54 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] KVM: s390: selftests: Add load psw bear test
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com
References: <20260323153637.3683-1-frankja@linux.ibm.com>
 <20260323153637.3683-3-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260323153637.3683-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA2MiBTYWx0ZWRfX0S3NH9Wd1sd5
 AevQpyU/cv7vwG/Q2fBa2qjtURvevb+Dps4BCTHAawmckPlzI84TBLHhdkQH/QpFglXsSzYmb+5
 4yam7A+wUZbH/skMrWGp2zMGSfAofNbMLep/z8JitCS0hQDKikCOq6VR8ttK4I8Z/DzUFVQS/1h
 jbE15ojQCMeSpCbjDsy/gb4JUdnpD1aptvk+/5lRI4h3LBRjg0u2Z5lf+/26xIi/Hc4p0uEE8L6
 Eg/XHXl4p850QjK1MAJcKQgqIC0rT0p5Qxyp1thUnoRubzo96xl2+OTg8poH99PMjRjIY0WtAY4
 5sK1DL8F6cU17HrGJnZ0tm+Pz5mkW/mwnwViPFns1PPN8wmZFR0aVEqLrXyxScdTgtusMfuo1iP
 fxlPCb/WjK3ytaQV+D3faXrLFiZLuxTIDWzE9rNsdYkvcYjHimCB4Q8JvtzMkY1f4r8dbG+qppA
 31cIlGJHajzMDBAiCRA==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c3a1b7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=L6jm01SqShaukWVU-_cA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: In0JNE5WGvSbQCI7HR19ZrOuwl3K3l92
X-Proofpoint-GUID: In0JNE5WGvSbQCI7HR19ZrOuwl3K3l92
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250062



Am 23.03.26 um 16:35 schrieb Janosch Frank:
> The bear is set for lpsw and lpswe but not for lpswey.
> 
> Load PSW and all of its variants are only emulated by KVM if there's a
> pending machine check. Therefore the tests inject those but never open
> the masks to receive them.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>



Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
