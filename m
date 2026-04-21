Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81229B764;
	Tue, 21 Apr 2026 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776573; cv=none; b=XR56/51pthwEYTwQytHDJLDT8tHJx9lK4saShgKD0LQCFSYlnOhyUWTDkk++9hX1sdixrdON8qMxdJ3snNnlCNPQ2lnktSGM1mDoYm49pB2UYSNy8uw6El8k13NPbFSGys+PcP/VpKpuRIv6gDYe+lphRyk7JuSMf6sNoUawwWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776573; c=relaxed/simple;
	bh=N1P/eUBzoypeOnL7Rq+3liA4hQX97RAcHxnIDxm3R4g=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=HcdtwD0gq+UgOdiOLzBNY+eF5Uyu8kC6zJlRTS+Hr4x5RNGCap5OcjbhJF7/mR4HMk0vGAXqoH+4D0iOJmrWaUslD2p/HNZF0kf4CqXWfpvYwk2CCYLGl4GABZRhElLibC21sWwYLydiP0oHVptQXxA/k6+TMpm2n53Y5N4Ov1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GhSl06Vj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GhSl06Vj"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LCjoM21928261;
	Tue, 21 Apr 2026 13:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oqz2AO
	FtHdkajzDCdasNfOcc6NTwqLRN0XbyVhDLVLE=; b=GhSl06VjTpo0xiP0i9HchZ
	h1mQs4fRQMXOR1+SOGsZsANhHoDQh0wP2VbICs9+MgL2d0iJENwJA0PgEIOpwP04
	T5CV+uPDs2H81kK0AzL2vVBT4lurUOWl0oLu1UiSCRKoH7e6OkD0874JpQXQ9R5A
	jBNFDjXwvChNm2deiBR3z4bq+NJIZcDjUBFl6W9teSO9xY/FjSGshyLOgHE0/VhR
	nOojxcxtBgrmcEd2i1w67GgfMx/HPHMm/26zDlKmOFer9mv0++yGpiKtHebUAqj8
	h+AYz9EpEg0EE6kGQsuKW23yMMYqPtuwSZzO5IpbIRke+7nsDCchOYDoxBIrKc6A
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2nf4cfr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 13:02:47 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LCoL7J017244;
	Tue, 21 Apr 2026 13:02:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmpgg8kuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 13:02:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LD2h5Q16908674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 13:02:43 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 619BC2005A;
	Tue, 21 Apr 2026 13:02:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BA7020043;
	Tue, 21 Apr 2026 13:02:43 +0000 (GMT)
Received: from darkmoore (unknown [9.52.198.32])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 13:02:43 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 15:02:38 +0200
Message-Id: <DHYUQ2I34W1D.3LDVQUZ8PVGLV@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>,
        "David Hildenbrand" <david@kernel.org>,
        "Thomas
 Huth" <thuth@redhat.com>, <kvm@vger.kernel.org>,
        "Nina Schoetterl-Glausch"
 <nsg@linux.ibm.com>
To: "Nico Boehr" <nrb@linux.ibm.com>,
        "Christoph Schlameuss"
 <schlameuss@linux.ibm.com>,
        <linux-s390@vger.kernel.org>
Subject: Re: [kvm-unit-tests PATCH v2 4/5] s390x: sclp: Add detection of
 alternate STFLE facilities
X-Mailer: aerc 0.21.0
References: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
 <20260324-vsie-stfle-fac-v2-4-5e52be2e4081@linux.ibm.com>
 <DHTP3011DZ4W.3HVEWE0UNIYTY@linux.ibm.com>
 <DHVJB8HIEM2P.IEP85VEWA4KA@linux.ibm.com>
 <DHYUI1FNUDZF.2K5O1SY030GKJ@linux.ibm.com>
In-Reply-To: <DHYUI1FNUDZF.2K5O1SY030GKJ@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 08Htu_XeFwL__lseLilipKcTbwUWLVH9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEyNyBTYWx0ZWRfX8xqSSPb6VgIQ
 Aexc3yCUqwwYS00uIJv/axZuTPragexFkKZsru/l1Wrxlm8RbCZVN3RCEIaJMFNAo9K8U+qb7Gh
 9XZcf1StE3+N+4nougpKFH0YUOU/bsg8rvgL+L/utXPYVD3cQg/rodALqkTdOv0lmsr+liGrVnA
 b1oXDda7I/8CfQYM38wMrX3QPk9m2R20s4J6ie4jeFQXFdovrFwa6/NhjS6A/pzNGg88lQdrNbi
 kZKupXopaKO1Fo8+5t/EPX8Mv0AlImEt/lbY90++sRS69zUp9jO+EkHC7pmkcMc8a42RlPt1ged
 8XroOOvbXgG1ORwpGWRmJ8BJ0BKO+1Oxc2X9NBYogYrYopObQVwQX72n8GSCz4abxnlA1odXc8B
 JX3obXye3YpKsW6PTFNC2kg4MEm1ZBoW7EpM5pI/FdttPTHVRhZQh3BiFNPyXapfzJR/h9mUlJV
 3yyoW24itWdu+tl7yCw==
X-Proofpoint-GUID: 08Htu_XeFwL__lseLilipKcTbwUWLVH9
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e77578 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=lUl8bi-omi4jmjdlXH0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210127

On Tue Apr 21, 2026 at 2:52 PM CEST, Nico Boehr wrote:
> On Fri Apr 17, 2026 at 5:28 PM CEST, Christoph Schlameuss wrote:
>> On Wed Apr 15, 2026 at 1:34 PM CEST, Nico Boehr wrote:
>>> On Tue Mar 24, 2026 at 4:28 PM CET, Christoph Schlameuss wrote:
>>> [...]
>>>> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
>>>> index d624872cba608fcbbd0c482a25f091fe19475a43..77b2a5ec00d68ec7ee82da=
295f2f31c539b5c00c 100644
>>>> --- a/lib/s390x/sclp.c
>>>> +++ b/lib/s390x/sclp.c
>>> [...]
>>>>  	if (read_info->offset_cpu <=3D 134)
>>>>  		return;
>>>>  	sclp_facilities.has_diag318 =3D read_info->byte_134_diag318;
>>>> +
>>>> +	if (read_info->offset_cpu <=3D 139)
>>>> +		return;
>>>> +	sclp_facilities.has_astfleie2 =3D sclp_feat_check(139, SCLP_FEAT_139=
_BIT_ASTFLEIE2);
>>>
>>> Help me understand which case is the odd one, the diag318 one where we =
access
>>> read_info directly or this one where we use sclp_feat_check()?
>>>
>>> Or is there a particular reason to do it this way that I didn't see?
>>
>> Both methods will read from the location read_info is pointing to. Which
>> actually is pointing to _read_info, which is a 2 page buffer. The actual=
 sclp
>> info is read into _read_info dependent on facility 140 as either 1 or 2 =
pages.
>>
>> So the data will then in either case be there in _read_info, either from=
 the 2
>> page sclp read or as zeros behind the 1 page sclp read.
>> As for byte_134_diag318 in struct ReadInfo I dont think there is a golde=
n way.
>> Without fac140 byte_134_diag318 does not exist but is in the struct. And=
 with
>> fac140 and using sclp_feat_check we are reaching behind struct ReadInfo =
into
>> _read_info.
>> Both not optimal.
>>
>> In the end the difference is if we go the extra mile and define all the =
feature
>> bits in struct ReadInfo or just use sclp_feat_check to check the bit dir=
ectly.
>> Simply because I think clp_facilities_setup looks cleaner that way and i=
t is
>> easier to add more feature bits.
>> I agree that we should use the same method for all high feature bits.
>>
>> So I propose to add another patch here to use sclp_feat_check directly f=
or
>> diag318 as well. And also remove byte_134_diag318 from struct ReadInfo.
>
> Thank you, makes sense to me. Do you want to take this as part of this se=
ries or
> should I send a patch you can base your series on?

I did include my proposal in the v3 I sent earlier today.
