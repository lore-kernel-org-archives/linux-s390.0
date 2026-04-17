Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1717A25F98A;
	Fri, 17 Apr 2026 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776439699; cv=none; b=mNYsqXO7NaXAHDp+b6EJBeU5YlAM+cKFU0tPOr2iFrpT4FicSUuHMbTFrVbIo+PiVj15wfqc8JSodKVdC/OYNN22eQz0rSW/Vi6mEcEszADRDShIyceuOrhsqdhvwvfR8E6uD+i3NfLiWjlHkfg1EHqrzlyROkC5GSonbOkkcO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776439699; c=relaxed/simple;
	bh=aXy5JjnSwqguG5nktilGWbZedgJN9UGWvbjIIrlU2nY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=MYOxzkFYn0XXWpoN5l4xiLc6KxI8mIsWPDu/TUNf1wVNIEgN+CjxoOPQCLEbGzqcObtVJeXcdYimxV2m0VuDMmk0EvgNgRaRCDCLvUrtstU/VMASe/1quFYtGFfz2SejBaM4ZplNc07vEcF67HN5n/juW6rm+YELwQB1qS0Krzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d7J0a619; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d7J0a619"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63H78DIU1859895;
	Fri, 17 Apr 2026 15:28:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=VFzeFJ
	uIkKIp3SeyqMMS4+pHyUQpgW08tzQ3y3xb9CU=; b=d7J0a619RSBp1159i86m3K
	jKplTbodrwCm85RMYkoHxUtNcjj0XlsXkCsodMcHjFqMIh58Yu2eexgbn7qKF4Cw
	8DKZjzG8eAC70u6/u2WAGaclIiiTX0UjB2Bz013PFQos9zujoV3TPUkhHmQ4nmtW
	dUuK7IqH03QcU9COwlvbfIkemFawCSKW/LH2CJEAKIDgA/QuQC0ag+Hvqz0vMmsf
	8RPCJYAL7dzJG0Ma6KMzO5EyQ6Uw7+KHOAvAAKgjHCUkC2aMDejyzrRxbShsWGWa
	o9N3eLTdMx5PhuziBOtVV8RTqHfvJ9IDLQtxyvzwGdmZEfzR2+zF7ktNnC/5uZhQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89pt03q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 15:28:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63HFLkM4015158;
	Fri, 17 Apr 2026 15:28:12 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg0msyxfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Apr 2026 15:28:12 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63HFS9m716777526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Apr 2026 15:28:09 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BF5120043;
	Fri, 17 Apr 2026 15:28:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3C6F20040;
	Fri, 17 Apr 2026 15:28:08 +0000 (GMT)
Received: from darkmoore (unknown [9.111.93.164])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Apr 2026 15:28:08 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Apr 2026 17:28:03 +0200
Message-Id: <DHVJB8HIEM2P.IEP85VEWA4KA@linux.ibm.com>
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
In-Reply-To: <DHTP3011DZ4W.3HVEWE0UNIYTY@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KTVN4C8DMphCI6tPcT0lQEMP_YSN069Y
X-Proofpoint-ORIG-GUID: KTVN4C8DMphCI6tPcT0lQEMP_YSN069Y
X-Authority-Analysis: v=2.4 cv=WbE8rUhX c=1 sm=1 tr=0 ts=69e2518d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=tJOKU2hpgvvjnv-4FUEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDE1NCBTYWx0ZWRfX6ZW7atqH0neq
 t7xYIDBVvkiwjhZb1YJmqa71RxM3vdFDRA0/UdXt9uxlbBzRGtVY3CWTU09E2PpXvAz9TIALL/B
 uZqfc/ExcYvpO7NDDed5I1PaTFCjSlz5ADfBUQ/oQOVTvFs/h7jGx8SRR0jaNuTIZHWlwpL5LyR
 hu5wJwOol06IjJYq4qdl/Px2Ie8MwVJBigOBaSq1ITZnFMB4YAsj9PGKA42da+Qkyw5NveEP2mj
 uejXhLMKzIGdT+iggtt50ic0JL7IWAW+4/r/wl7bY5uzfwq1X5ltSXCB29DUeckwm0Xi88ND7GY
 wrj7o4N/oA4dfl8Z96LDgSwC+mhFAWBYy+ewiA5ynHKuSfLPSHzKVntJEnI8kJQHrGoGXGjdFg9
 0uNHf9t/r/yr1VQRb76bDV0nkeDy3YGHH3jsgajOeKD9fe9IhewakcB/xIfCGrnhvfZUpDjjufi
 NOsmBKD/Zp1FS6JJ1Zg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1011
 phishscore=0 impostorscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170154

On Wed Apr 15, 2026 at 1:34 PM CEST, Nico Boehr wrote:
> On Tue Mar 24, 2026 at 4:28 PM CET, Christoph Schlameuss wrote:
> [...]
>> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
>> index d624872cba608fcbbd0c482a25f091fe19475a43..77b2a5ec00d68ec7ee82da29=
5f2f31c539b5c00c 100644
>> --- a/lib/s390x/sclp.c
>> +++ b/lib/s390x/sclp.c
> [...]
>>  	if (read_info->offset_cpu <=3D 134)
>>  		return;
>>  	sclp_facilities.has_diag318 =3D read_info->byte_134_diag318;
>> +
>> +	if (read_info->offset_cpu <=3D 139)
>> +		return;
>> +	sclp_facilities.has_astfleie2 =3D sclp_feat_check(139, SCLP_FEAT_139_B=
IT_ASTFLEIE2);
>
> Help me understand which case is the odd one, the diag318 one where we ac=
cess
> read_info directly or this one where we use sclp_feat_check()?
>
> Or is there a particular reason to do it this way that I didn't see?

Both methods will read from the location read_info is pointing to. Which
actually is pointing to _read_info, which is a 2 page buffer. The actual sc=
lp
info is read into _read_info dependent on facility 140 as either 1 or 2 pag=
es.

So the data will then in either case be there in _read_info, either from th=
e 2
page sclp read or as zeros behind the 1 page sclp read.
As for byte_134_diag318 in struct ReadInfo I dont think there is a golden w=
ay.
Without fac140 byte_134_diag318 does not exist but is in the struct. And wi=
th
fac140 and using sclp_feat_check we are reaching behind struct ReadInfo int=
o
_read_info.
Both not optimal.

In the end the difference is if we go the extra mile and define all the fea=
ture
bits in struct ReadInfo or just use sclp_feat_check to check the bit direct=
ly.
Simply because I think clp_facilities_setup looks cleaner that way and it i=
s
easier to add more feature bits.
I agree that we should use the same method for all high feature bits.

So I propose to add another patch here to use sclp_feat_check directly for
diag318 as well. And also remove byte_134_diag318 from struct ReadInfo.


Cheers,

Christoph

