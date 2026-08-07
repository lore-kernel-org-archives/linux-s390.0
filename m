Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79946C851
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786105918; cv=none; b=AZ74+WyyayZfQqYLVEEvTZLhl67zBqXBl4mchtmUBauAgZR2dydMjLEkbExHGlBdIYxRgaTH9aSN+tjU12tsI/3V5Rgo7cScYhsIzh1x7WjDD6dYA9j0g4Ltvoq7jkiPYrkQFpEP2gdkjKo4lp9FqijBSnOALf2ycYYmwC5wfEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786105918; c=relaxed/simple;
	bh=sLACOqU38PEUwsw0tD55Emgg43aFxqR7hu+vqf9oRto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hKpbwDFTYUd+PwzkI0S2LoxA7/ySbsXlSOvojih9JDQipsGX5WYy61kqN4Nui5gHvjReTWcGhBJMufBNBsXRoRIn7ujlDO4FXXirVpNo9mjM0VnEniNTRR3kMok+CzETaTU5+3LtVMUk+fJOeh4DkUZFFjlkCjyFi7eiBUotg/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gEYoQpUJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gEYoQpUJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HhK94133737
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 12:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KIkGsM
	1srFrnKk9L7eTo5mh/nr793kN3IXDba7LsXKg=; b=gEYoQpUJg350QxKRHOzt6D
	9VvIhb/sBZqmYHvlPAXWtC5DzigU3pLvDctiDveUTLYAGVGdhLMgmfrfFvDZKM8u
	xF7FHdclW7QZFf/si6cSH1Ip0SGI9A7hrQEFqL95r0Sh09Fj8SvYjLv9QRw5vxdK
	rnY+eKv8yZR8kYrlSiVNl6Qgsdf0lRZ0jXSFvTz/S2ayTdh/ejHxuvL9G8qaIBqh
	UN4CFw0/IXYbhEnQQasMSaUwv3uaTr/U3hj7zG0Bkd4MZITpYJy9pXhxUqSgvFBd
	lz/AK2WdNSh1uV3Jmugy29VKGRRbo4zrGcgdxyesp0x5ElDTm9leqLBXAYijxAsQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy043uc3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 12:31:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677CQGxu015097
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 12:31:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhqjmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 12:31:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677CVeVg49414510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 12:31:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D34720043;
	Fri,  7 Aug 2026 12:31:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D28032004B;
	Fri,  7 Aug 2026 12:31:39 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 12:31:39 +0000 (GMT)
Message-ID: <a1c31364-0828-47c8-828d-012ae0f5d6ae@linux.ibm.com>
Date: Fri, 7 Aug 2026 14:31:39 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] s390: Enable CONTEXT_ANALYSIS for cio and virtio
To: Heiko Carstens <hca@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
References: <20260806153849.2622576-1-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260806153849.2622576-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA5NSBTYWx0ZWRfX7IE44+diyPmW
 HfmrBpDJNq0uI484F2rhU/IbmWC/qyGuggOg4r0fz8bce8Xn6BNE4/uNgBHxu8VCfmxIC4sybbB
 2V5pFC79x4LXK8VsGQ0Drbw0mNVzr6figqnRF+JrM2tqMSUBRhTYxY+y41VoYu0vOUH3eXOunyy
 6OwocjMXVPIDD3ik/1lPUQ9o79dpoZ9KzdpxKs6uWR/h0mzo8oI5Ml62V76w8ekz+9iDtY7UoXg
 AfyYHLbEoynKwcatmjP4VMtpgzGIwLUfZwfKwkzKXM8YhsvmKVeKZqzoC8wsK+TC1h5O54si8sV
 G4PoJViR07HCjdpHSf9bw0jl1WslgpxgPS7ZHpA5RJOK0boeFDdHP7zZqXJ6GCtRk9Cxb2HosCa
 /MgoxZgKIYE8B9tObuBjmElQZlLeCyu/6kmFanHKZUy0J4Tv/lg634lJHhLAW/Ih86EiHLQuAdb
 NAMRrYZXmQ1QHloKgQw==
X-Proofpoint-ORIG-GUID: pXSXA4nOdwdIjS_YLMPsWg5Fht7Kxbzo
X-Proofpoint-GUID: pXSXA4nOdwdIjS_YLMPsWg5Fht7Kxbzo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA5NSBTYWx0ZWRfXwVWica9l/DDm
 uFFKjYQnok9J1nSxxrlG/LPjndkstMfa2zJ73hx6JovuFSTlpSj6oSELZ6h/DfnEPLlALAcYU/v
 uaP82o3eFB7RDmw3kk9C02E52sftc+8=
X-Authority-Analysis: v=2.4 cv=WLpPmHsR c=1 sm=1 tr=0 ts=6a75d031 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=V0iI-RycjD_1OnvpXFgA:9
 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070095


Am 06.08.26 um 17:38 schrieb Heiko Carstens:
> Enable CONTEXT_ANALYSYS for cio and virtio.
> 
> Static code checking for acquiring and releasing locks used to be done
> with sparse. That was removed with [1] and replaced with a clang based
> approach [2]. The new approach requires that each subsystem needs to be
> explicitly enabled for checking.
> 
> Do that for cio and virtio. Add a __must_hold() attribute to
> vfio_ccw_sch_quiesce() to address the only valid warning.
> 
> Then enable CONTEXT_ANALYSIS for both cio and virtio.
> 
> Christian, Claudio, Janosch, I think it would make most sense if this
> goes via kvms390.

applied with the small ";" fixup and scheduled for next.
Thanks you.
