Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C2033B6F9;
	Wed, 12 Aug 2026 18:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786561011; cv=none; b=LIO6kGUS0Zq7VXpgQUhmT8b4jy9x6n2LrhE05W8uC1MTF5nwfMI96bOSF8jHoBgMN64MiA0VxuQOFN+MAv0ofP+VCzT56rAvvZke4xf0DF+JTjhV2rhkR4DtSR+q3j7y/WUQUVKt9OwugxLsCdd22MHd67IclYJ1TbFCFjHHy0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786561011; c=relaxed/simple;
	bh=2yz2LQcLk2Xh3wL+fFiN2cToL0iydk+aOywafwZT36Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDlu7MmgQu7MEYt8mONKvEBFx55Fj5L8L2rjoSCHkqrLa/DCo+dcMfmtnK5Ils7ElMV+N/WuxF2Zxn3VZHLVsz+PHaeLp4dZdTn7D1vCUk/HVGUO/I0BbSNwcZYGwC5EIb5fWiyzmRVg6WjNWX7KXBdWNF35Q1Nr3Bwa5gI962I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YWR+QIg8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YWR+QIg8"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1Qg22217775;
	Wed, 12 Aug 2026 18:56:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=geDdAO
	rkEIjFBmw1c2PkP0M8XFpwTV5Lmb5iIdw7VT4=; b=YWR+QIg81n9ov4exYlLZrJ
	OyeVbVf7QYlNtOk4UQHTNFy90TNvur3xx0EULNHhrLgvP8UZCbvqYpNHN2HfuwxA
	qNHLe8fkhMBOSGH2Yfsv0auWxz4SaKX8aPJupfFNPrDxR9NRjqFF9hvUmO63186B
	aGls+9uW+EXZmOmIutQr9sNbda9XBncln0SOyN1KPqjCFmPE/d7Mc3vI+LMN/h8+
	ZIv+OJG2CsT9zxvDBmoq3OgLWCrx67Aj4eSM0AfbSiWJMWNqB8OOCJEmxQmsrbk1
	wO94RHD8XF8xZPGQwSHRGqHhqo+12Y7Qj32B9ANv50jVTRebVaW3Nz5QNu8qJUmw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk045dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 18:56:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CIuGcE026288;
	Wed, 12 Aug 2026 18:56:38 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy7anc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 18:56:38 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CIucdS19923498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 18:56:38 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9EE058056;
	Wed, 12 Aug 2026 18:56:37 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D864358060;
	Wed, 12 Aug 2026 18:56:36 +0000 (GMT)
Received: from [9.61.74.89] (unknown [9.61.74.89])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 18:56:36 +0000 (GMT)
Message-ID: <4d1e8394-70a5-430f-b16c-f52e58ad54ec@linux.ibm.com>
Date: Wed, 12 Aug 2026 14:56:36 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] s390/vfio-ap: Fix NULL deref in status_show()
 during queue probe
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260812170945.738351-1-akrowiak@linux.ibm.com>
 <20260812170945.738351-9-akrowiak@linux.ibm.com>
 <ee819372-edee-445a-8373-138040c51a28@linux.ibm.com>
 <a6627241-c96f-4e06-8f97-64738abb19ad@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <a6627241-c96f-4e06-8f97-64738abb19ad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0OSBTYWx0ZWRfX4xkq/we64vMe
 lfunhgfD14w04ajTfntMyH68IImEqjE70DKG3IAt1J2G06WkwlYlT+BUHbgwUeY1fDGXG4r07f3
 OmlPMPwXJ4HdtZ+vLlpQvtJT2JiSVTnqvxyCFnVT606HCccu6NpT8u4q7YEEVmtXfnQOOBzQi9r
 PmNL0P3qAG1J5WhG1pkRTgccRsDGMPnmEeJY+lx8EYL+iJjwvHUJBblc2DmYg/35bI8aE3zURB+
 UiAgRyqY93a5Jd/APGH4puyO/zEmXFZrrlLdyGCFEYc1Iyk40puVW9uKZ0YB9pLacNGnJX2GitV
 puYS+VW1x2DdYU6dwrKlSTsQxGwm+5AOP+Iir+qLaK7q1rv1sV0zep1TQYB1blgd/OkCQboUpDg
 TUQ+fDRTqy+Tcpb6Gcc5WiTlnR4bAdmisLDLXrE+RKZFmNe8uqmBn1e4E86E1wn51bAVhbuIUmS
 TZg39b1EBKnv7ns45yg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE0OSBTYWx0ZWRfX1V0xayfI6P46
 hlV70itawGRD+lLKRi+ugmIko5BfRZ8Oq3arT6e3qEFt4k+1MvOfvuxJfupsZBtJT26A8+j0bhE
 448CnegXC2VS7+zzpGWW9UjawuW73RM=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7cc1e7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=TdqRf4wA226MdiaKlisA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: z_oYvXrLonTpvwTTrzunTsZnjeF9xBmL
X-Proofpoint-ORIG-GUID: z_oYvXrLonTpvwTTrzunTsZnjeF9xBmL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120149


>>
>> Do you think adding an additional NULL check against dev_get_drvdata()
>> in status_show() and treating the NULL case like the other error
>> conditions would be enough to cover that window?
> 
> It would cover that window, but that function does not return any error, so
> we'd have to decide what makes the most sense between the following
> three values, or create new one to indicate we don't know the status.
> 
> AP_QUEUE_ASSIGNED
> AP_QUEUE_UNASSIGNED
> AP_QUEUE_IN_USE
> 

If there's no drvdata then it can't be assigned, right?  So maybe
AP_QUEUE_UNASSIGNED?  Unless you can think of a reason it would not work?
