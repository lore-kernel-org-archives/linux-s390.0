Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178012EA732;
	Thu, 23 Jul 2026 21:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842967; cv=none; b=jDAIC+mQyHv4H9OfD0wuj2JqK3qO3S1deb8bK7pXNvlMNMp+W/bFXNaJHo/eTmeXEcVt+qKA1lNuzpoWq8deunNYROs9k116lgsfRy7tBXaCaOGDXF8571mZnvYFexTjK32MByv9f7mbZfSSOQgJTd9jbOp+kxrqlQEPB/WZpjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842967; c=relaxed/simple;
	bh=iuRvN4f5fD+MRUOtBmLPBXpzck15qPcI3i9xmfJDBfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L48CadLqJS3Yzq5oyerARgZ3vPDDphKzSme9pY3aCqi4+zl/fGLsGT+9ZxD868RfIq3RpupkwHFcHqrYMDshjUrTUNFcQl1/ijwQ0UoMii2JusvBltcuMXLDaiexhNi9RQdANtIOGRnGdmdDSWkWMN9MbSCXG4ZdGmRZmvmsSkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i/KLvQfQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i/KLvQfQ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66NLgGa04191674;
	Thu, 23 Jul 2026 21:42:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kzwhkD
	6Y0z4Y3bOcpzduura0PV1gPBjr/2e1/zAaxpo=; b=i/KLvQfQaUGRFpg8twnHJZ
	znGoC+jRqFHx+H/tMQA5tkPAC1YAriOZ7o89BH3y9g87/n0x/dil02JaVowcZiuy
	J+CcoqxkDaYiJfe1MyrGSBqFOrl+Zgem+TSaguprQXqTBaO7r8b2k2W/lZYzSgUq
	839+Um8uEWfZP+Bw98C/ASPKPHpcJQoIvjYrJvG6sh6bVYNPlFXKqvl8tj7oXMLd
	2AqFVWZ3i4y8yT3GDGoOGKgxNojMZjIuGObFskOywV/w3TwEwUjTubZt7ys4o1gf
	bxWXJIbe+vvCAfNMyMQ3d1ngcMPAO5zf1lMn93b7yOjkrOJ++OruQoE0jA2/4KSw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ahh4gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 21:42:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NLblBP029566;
	Thu, 23 Jul 2026 21:42:42 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqeb5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Jul 2026 21:42:42 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NLgf1L24248876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 21:42:41 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AE6F58059;
	Thu, 23 Jul 2026 21:42:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D033D58053;
	Thu, 23 Jul 2026 21:42:39 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Jul 2026 21:42:39 +0000 (GMT)
Message-ID: <f5daeaab-9301-482d-bf42-fc75f51ffbe5@linux.ibm.com>
Date: Thu, 23 Jul 2026 17:42:39 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: s390: Fall back to short-term pinning in MAP
 ioctl
To: JAEHOON KIM <jhkim@linux.ibm.com>, borntraeger@linux.ibm.com,
        frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com
Cc: david@kernel.org, svens@linux.ibm.com, freimuth@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260723181017.1220552-1-jhkim@linux.ibm.com>
 <69c50fa5-66ca-4d09-8ba8-8918287d662b@linux.ibm.com>
 <360e03e0-ae62-4c86-bda3-a728c36635eb@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <360e03e0-ae62-4c86-bda3-a728c36635eb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EVhy3PMpWPy-_X4jPwa0Aw68E3_qlXir
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIxMSBTYWx0ZWRfX18Znp1u5Qee2
 fh65sK1EQXCdIlcoUZfWHXkCjqtFD70PGR/HIUCnErPAN7cIsK5jieuD6e5Noo9X+NAdO+IeYlg
 8Rbb+N8kK45FTGzT2/97noNfu6D88vPrMF23k/eTHBNCZGQygL6F6uEM00j87bDXFI8uoH0LuBS
 4Gt3fAPnS2dP3xSO2512fNTk26fvgokjkEt4Bwvg+taa3RkFBL3oHpVtOWtczbUCMGk8FfacAog
 +CL05MPRPhOPB/e6KR7G8/pXzIYXhJCu1VeuPwh/D8c9wYFYe18I47MnbZOtxT2NrcRqxjPoTj7
 D7GYs40tfkRmtNspv1WMEi/fmpjIeyM0nEpBJeytQvMralmjshijpY8/yLY4+ZUQw+iI/5b6GT1
 2I6S1cdvHSbrNdXnw+0rnZrjHKPE1XuzMpvJSJ8/sRpnreQdJjn1OjqDd+1xl8SHsbhT+fI+OxK
 WKl+fBmURVJmJQNyhbA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIxMSBTYWx0ZWRfX/QNhsyv/RPWc
 8UlhqX6TyH4nqR4NNbxLUC2RU8WCQqLUEtR7Z0r2us2Z7j1/y/uuM4zSfCPXK48WJAuYrf6EzJV
 9FivgAynCtUg9+TbXP3CnbCFGBqeBo4=
X-Proofpoint-GUID: EVhy3PMpWPy-_X4jPwa0Aw68E3_qlXir
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a628ad3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=vm22FW_E-aqYrXyxS4YA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230211


>>> Fixes: adcd5b3e758b ("KVM: s390: Add map/unmap ioctl and clean
>>> mappings post-guest")
>> cc stable?
> 
> Thanks for your feedback.
> 
> Since the fixed commit first landed in v7.2-rc1, I don't think this
> needs to be
> CC'd to stable.

Ah right, good point.  Forgot it landed in -rc1.

> 
> The Fixes: tag should reference the mainline commit c9a5688380865b
> instead of
> adcd5b3e758b, which is from the development branch.
> 
> I'll update it in the next version.

Good catch, thanks.  I just double-checked and yes c9a568838086 is the
one you want.

