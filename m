Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7722A3E6DCF;
	Mon, 16 Mar 2026 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773687239; cv=none; b=cS1phWALByhlZKSrsACU3Lvyhuqx6UV3ixcvJLPGTIfF7mUPr/WwrQbKuj6kvvmOOf2SaE2OBOsbi8kE0YJjpb+W10hym2FX04WGob1292XCotkWJs4rhC3uf4+mJOvWohj58EoVX7/+N/JvjmgBiBWBA+osKKbijOptQgRfiWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773687239; c=relaxed/simple;
	bh=srU5Hu8NcVgm6yXTyXkM9Dk1mgG48Ju1FZPLRWLTqQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soYgkDgHEisWgUz7okjhTrHU0DuCgZ2iBGa72BL3YsTZCdSGubxGuliJSh56VXh42//Mw58Gbfw+XCK2d8IWZD2g8W9mAStttH3xnmF/lrs8itLA585HcvcjDc50bwf7w4OH4PyGDbIf+8jfaZOg3XrOIsmFcE/pleuXtu9EdnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YHU9lqjU; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YHU9lqjU"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G5RYwk2722906;
	Mon, 16 Mar 2026 18:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R04HyA
	yo/n1vUsMJ9dtxXNyq0xtRxIt6DewHhNy4DdA=; b=YHU9lqjUmMBYftU9WGfWsa
	e2X6HZJq5TOnfTHM7t6eG7U5l8O135faKkir++bpv/nM+MjSYWHiYSkyTSlsjpp7
	b84+tsZ9He49spsXFmszMZikAzLUzDQsh3me0QiGRq6d96dSeNdPYOiif5LhzpY5
	+j1Z6V0yIuDoYMQyQgeLU0SbNxFMmexvKbKjIavloDP0pGDMHgbIHhgGEnTf3ao+
	GOjc1r+CPGyYQZaRMamQePBfzWOPx0XG0wc1nSgn3QJPFEgzMeUIeEg/3XhhLVrq
	dySMPxm2jwXm/xX2hBGkyHr83yUBFPqXOVAgjhyVfcbsfZ2/Xe5pCjeXnY09XwYA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyau8w3p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:53:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GEjF43004581;
	Mon, 16 Mar 2026 18:53:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s6344-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 18:53:55 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GIrpwh17170704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 18:53:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E4082004B;
	Mon, 16 Mar 2026 18:53:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 40B2520040;
	Mon, 16 Mar 2026 18:53:51 +0000 (GMT)
Received: from [9.87.135.243] (unknown [9.87.135.243])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 18:53:51 +0000 (GMT)
Message-ID: <c60fcad9-af38-415d-bd75-24599118c8a1@linux.ibm.com>
Date: Mon, 16 Mar 2026 19:53:50 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 04/10] KVM: s390: kvm_s390_real_to_abs() should return gpa_t
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, imbrenda@linux.ibm.com, akrowiak@linux.ibm.com
References: <20260316180310.17765-1-frankja@linux.ibm.com>
 <20260316180310.17765-5-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260316180310.17765-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE0OCBTYWx0ZWRfXzt5Jiqx8Ciw7
 gD0FR7RfD/R7CABv8+v6MZrwMOpZ67ESenIEOQJeE9eEbfmNlPp479xubPB0zrxuYpapwghsSvx
 qcWwPmSTbGuJ02lhFPTXVbeBhYiJsU2m3Y9ke3KGH2soobxrfGpeTHlGc4l0IS3KuvyEyJeOMxR
 vUfAzU8B1RrnMId0FQl5oP+8XXRoo37AJxP6KLOMKWbjXJwT/alzpCEtx1IOXKk+2dO7tv7j+NF
 y8nVggB4cO+XcUpUTpguYqScREhdneIy4Xo/SWVm2SFaBkojXNbeI5CLUNYn2MdPqxWpYHsmVPG
 13nqealr9K+7TfrLzPaEYjP7gLtyFGp4EK9KFHblWAwHlR51/GoM3gVMy6TsHuLbyWqxs/ntYdr
 KLbX/u54TJ4864e4jlz9w66WxpZHcq5Z/KGKpr0uYPRtPSrvFnmLYeSuRYnQpZZGKfjxj3bSr2r
 QarFiF989NDtpis7ggA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b851c4 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=EZ-i2jIsG0ggvIwOWekA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: zxVL_WVs3q-7OE14SoEpfJ5IS3sE1kT5
X-Proofpoint-GUID: zxVL_WVs3q-7OE14SoEpfJ5IS3sE1kT5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160148



Am 16.03.26 um 17:23 schrieb Janosch Frank:
> An absolute address is definitely guest physical.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>

