Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DFE30E0EF;
	Tue, 21 Apr 2026 12:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776775940; cv=none; b=B96IOwsLYnWyyRIEsYOJd3tjJ/opY2WAoiWSl+tpUQc8CmjnwjxLLLN2awQ5jE1q7VQapiJ56L4sdhRS0e/Ov7aTWyHRWZBpxRNjQID91olsgyBAcJel0Ev+pk6HiIJodXXGkTNZ1TLL94rYKYNxAhd/OCPoYWs9PgoR2e42UO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776775940; c=relaxed/simple;
	bh=afxfuBhErYQMVwA35UR65Id9aa8cZgGs5iOcJYwU7cc=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=SwRYJ83SufmZpMT52/ABlbjwLeoxJhbym01O0rjNYkq/mZHzssF/qqADKrUI8il61pABTRNrSPWX0vxJD4S9eVMify4w32CVUR3asy2jHbCZGUnhgLvgGKoNi/rBtAqgyfNctIDz+iiEpkXMBBZIp3c/jfZlpO/MXQTSAVPAtAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OjOVgEc5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OjOVgEc5"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63KJgWoa1926145;
	Tue, 21 Apr 2026 12:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4cbEEl
	LUi+POfQbIlHB0LGlNuZOxEcc4WtjmUruYbxA=; b=OjOVgEc5JvgTAAis7ZKv4D
	jq0Ye6swFP6VC0M4NTRjLL8vn2IUsx+OHhO15S4XNdkmQRWCYrxT7VUnv7xCksJM
	H/uEUYA0zzyQh3mI1w8ZVKYLPenSXfobHyZNYhvbMIrwaRIdv56fY7ym3Lwr5IKA
	MoQW9k79HFoanh18qlVjVoV9q6mxLHNVYlvkgcC1rzDFBwETUEnZRoFvPknr48gQ
	RBzyLVStueZubnRwD68KaXHsM2tdiRDp/gBUGV4MgSV+gyFZDgoX60N4J3LZxx81
	JRft0I+3RehLa9vXC+Tk0BE5/Elgs6E1b9Zi+2/DbJ9LyMCrX0jkou5SPGZpbGQQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2nf4ayn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 12:52:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LCZGr1017797;
	Tue, 21 Apr 2026 12:52:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmmnvru65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 12:52:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LCq9mD43909448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 12:52:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CCE520040;
	Tue, 21 Apr 2026 12:52:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35EF12004B;
	Tue, 21 Apr 2026 12:52:09 +0000 (GMT)
Received: from t14-nrb (unknown [9.111.84.218])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 12:52:09 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 14:52:08 +0200
Message-Id: <DHYUI1FNUDZF.2K5O1SY030GKJ@linux.ibm.com>
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>,
        "Nico Boehr"
 <nrb@linux.ibm.com>, <linux-s390@vger.kernel.org>
Cc: "Janosch Frank" <frankja@linux.ibm.com>,
        "Claudio Imbrenda"
 <imbrenda@linux.ibm.com>,
        "David Hildenbrand" <david@kernel.org>,
        "Thomas
 Huth" <thuth@redhat.com>, <kvm@vger.kernel.org>,
        "Nina Schoetterl-Glausch"
 <nsg@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v2 4/5] s390x: sclp: Add detection of
 alternate STFLE facilities
From: "Nico Boehr" <nrb@linux.ibm.com>
X-Mailer: aerc 0.21.0
References: <20260324-vsie-stfle-fac-v2-0-5e52be2e4081@linux.ibm.com>
 <20260324-vsie-stfle-fac-v2-4-5e52be2e4081@linux.ibm.com>
 <DHTP3011DZ4W.3HVEWE0UNIYTY@linux.ibm.com>
 <DHVJB8HIEM2P.IEP85VEWA4KA@linux.ibm.com>
In-Reply-To: <DHVJB8HIEM2P.IEP85VEWA4KA@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SACq-V7iJVK_76f4Ix4gZCU2JLvVooiy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDEyNyBTYWx0ZWRfX1jYYXLVg/FYF
 NFilfBNqS7WKgG1KtN+Cil64hVcLq3a+HtyMaUiMs/W6Dfo86HmEM7Gf/OoUiTZ1RJ3YUadIGNI
 pWg/FvV+u/E6Ur6SdpasrlaV4Ypbn8CVUKka6p5HZRPvb+zgCokLw3/IcgBlrdyB5uuTNBSz86O
 e6pe22zX/C05E4V4K6Arw6D65AFymRUInyhCIXh4R5+/4NsfiA61GA0JCfSFGP456IwVXNCvt4O
 jJtE1mF2IOdrp1wzKl3DwDAlO7e7GUuF9vNmw+MzOExbnQEESROV/8sz2Kzadoe2Q8u1esdzRmb
 uOhsmfokK1c1SSmew4Y9DNgUro7bA0tNEQFkaw1bSOJNBta9KLuXuFIBP0m/OdpyeN0FWqw17Kh
 TbUd3jGTemHy/qGEni0iKuBWmu9E39q4whUUCl52NXKf6m7KDIaUPhHfM2Qld8JXh0Tzch1H9+1
 QyS28LEWptVR82IId1w==
X-Proofpoint-GUID: SACq-V7iJVK_76f4Ix4gZCU2JLvVooiy
X-Authority-Analysis: v=2.4 cv=B7iJFutM c=1 sm=1 tr=0 ts=69e772fe cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=JDlLnzAmX2ppTn9s91sA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_02,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210127

On Fri Apr 17, 2026 at 5:28 PM CEST, Christoph Schlameuss wrote:
> On Wed Apr 15, 2026 at 1:34 PM CEST, Nico Boehr wrote:
>> On Tue Mar 24, 2026 at 4:28 PM CET, Christoph Schlameuss wrote:
>> [...]
>>> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
>>> index d624872cba608fcbbd0c482a25f091fe19475a43..77b2a5ec00d68ec7ee82da2=
95f2f31c539b5c00c 100644
>>> --- a/lib/s390x/sclp.c
>>> +++ b/lib/s390x/sclp.c
>> [...]
>>>  	if (read_info->offset_cpu <=3D 134)
>>>  		return;
>>>  	sclp_facilities.has_diag318 =3D read_info->byte_134_diag318;
>>> +
>>> +	if (read_info->offset_cpu <=3D 139)
>>> +		return;
>>> +	sclp_facilities.has_astfleie2 =3D sclp_feat_check(139, SCLP_FEAT_139_=
BIT_ASTFLEIE2);
>>
>> Help me understand which case is the odd one, the diag318 one where we a=
ccess
>> read_info directly or this one where we use sclp_feat_check()?
>>
>> Or is there a particular reason to do it this way that I didn't see?
>
> Both methods will read from the location read_info is pointing to. Which
> actually is pointing to _read_info, which is a 2 page buffer. The actual =
sclp
> info is read into _read_info dependent on facility 140 as either 1 or 2 p=
ages.
>
> So the data will then in either case be there in _read_info, either from =
the 2
> page sclp read or as zeros behind the 1 page sclp read.
> As for byte_134_diag318 in struct ReadInfo I dont think there is a golden=
 way.
> Without fac140 byte_134_diag318 does not exist but is in the struct. And =
with
> fac140 and using sclp_feat_check we are reaching behind struct ReadInfo i=
nto
> _read_info.
> Both not optimal.
>
> In the end the difference is if we go the extra mile and define all the f=
eature
> bits in struct ReadInfo or just use sclp_feat_check to check the bit dire=
ctly.
> Simply because I think clp_facilities_setup looks cleaner that way and it=
 is
> easier to add more feature bits.
> I agree that we should use the same method for all high feature bits.
>
> So I propose to add another patch here to use sclp_feat_check directly fo=
r
> diag318 as well. And also remove byte_134_diag318 from struct ReadInfo.

Thank you, makes sense to me. Do you want to take this as part of this seri=
es or
should I send a patch you can base your series on?
