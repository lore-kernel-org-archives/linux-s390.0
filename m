Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E93372EF5;
	Fri,  8 May 2026 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778234743; cv=none; b=qQm7zhv72wUMii0LPt1GQbtegjwwhOtZ392odnnqFYMNrP4qu9C6aGaTH0kQM+OBMjBWw+INXKX7ecJ0kcId+GXpy2yg/bwkZdVt4e05fpIWJ0DUYj/MDlJ04xECKHJrnHjafMbp+jpFXjvDcxt2hzPCvhNj5AnqVJ9ywK68yWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778234743; c=relaxed/simple;
	bh=UXqCU8Y8hcrgXSeKbM9stuLA9Hu2AjBDAMGW2L5r9x4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPAIt5K8jFBgjvCb6koamTMZkIGpQsIUHt+6Dxy5Y2zHwVa3QPGiILFbYffo5ZHe1Vh53ZO4uoZ+nZ87HalQTGdZIm0I5v3yoBXTaTRXCPJr+YGQ4QtlkGJmEWSP9OSvQ23tv+Ah1ZULFH1o2DYZVbl0iMzovKN6xJN+SYLb/u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BiF5LfKv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BiF5LfKv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6486JaT0855288;
	Fri, 8 May 2026 10:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=v2kxWg
	QQfxfcR2viGI446t2gcsjmRhoJ3IQ1rt9LTyM=; b=BiF5LfKv5yHAO6THXBbcPK
	CFw0p63Zm1KOlyn3nM3XO4IYxnWdOUr30RIy76qL+dP52kA5VS1BmNb19z0SMTjA
	AOTSzK1za+HK2hx/VxTTe2XmeTy5ed6FZedk6kZWKUlSiv7YgASP0vJY1/dxAV6F
	w1a96WY65iPbVQk5VBYHioLoYtvuZEg6mpsflNGe9MznmNpNdfqnUBMiW1iJqKFK
	k91JYwonhL1wnMmupBAfrhSk/92sNqPYwMdmqAYImEtSg3JICvctCM72RenMiMiV
	tHyMwoK7yfycQ7hYVcQka7fca5h7EXn2pCLdf+xk9TpKKtx+floknIyDuvoiPORg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9v7u5ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 10:05:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6489sUie029089;
	Fri, 8 May 2026 10:05:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hfmtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 10:05:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648A5ZeS47382970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 10:05:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE2C720088;
	Fri,  8 May 2026 10:05:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A84720084;
	Fri,  8 May 2026 10:05:34 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 10:05:34 +0000 (GMT)
Message-ID: <4a49d3e2-774a-4b75-9b12-8710c4355b58@linux.ibm.com>
Date: Fri, 8 May 2026 12:05:34 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: s390: selftests: Extended user_operexec tests
To: Eric Farman <farman@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260507200836.3500368-1-farman@linux.ibm.com>
 <20260507200836.3500368-3-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260507200836.3500368-3-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA5OCBTYWx0ZWRfX4tpK3aSITAz9
 zbjxZXSrOgcQru+UFXLcKiTg604O5oIVec48k0zROf/IfODpOjRIU575rJrHm2vW8FIfJ75t3YY
 e7SzyD/D1vwAPniklrrN00Ec8E5QiS8iXfQSc77TXTrYalf/srXp3PqkznFT2KwPLRVbxtZ9/Tq
 6d8Gk+le5tuuHHpABzaWHaH5rEdzmm+60sGFSH8OSeaZ4BmlZO3o4iOi81zJk4XRdbvseg/OMAx
 3a6SPbte9NxpP3j+GPXfzi6SQRoGysecQEyDqCHgFdcFWg3qoO7auNDS8kEWyjBmP5pH9+Rec9V
 eRAtpBLv5y08dfjGlg0C3Tz/vvm5XJc34c4Wlo+o1TYdn1wXgOPmIsr3JFDNUqhFUv7caOeMM9L
 aJvsovkCw2Qua+XK9aMFqvJEaXwPwD1BurzmBxMoBzJgJOmBTGQfJWL9lszyRHxAYBPWVcxYrWn
 k09Dhm2cQsKrTGTJtMg==
X-Proofpoint-GUID: oSvnUalwE7X5unwSF3wEgNLoCG0avfpb
X-Proofpoint-ORIG-GUID: oSvnUalwE7X5unwSF3wEgNLoCG0avfpb
X-Authority-Analysis: v=2.4 cv=eu/vCIpX c=1 sm=1 tr=0 ts=69fdb573 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=eNiyezpbepxsKGXvb8YA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080098



Am 07.05.26 um 22:08 schrieb Eric Farman:
> There is a possibility that the user_operexec capability
> only works if facility bit 74 is enabled. This is now fixed,
> but add a selftest to demonstrate that.
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>

looks sane to me

Christian Borntraeger <borntraeger@linux.ibm.com>


