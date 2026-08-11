Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74E125392A;
	Tue, 11 Aug 2026 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786463630; cv=none; b=UVXAMvweyqDGRJ4ed1p35YOxCu2wL53mk2zih+s02mEdeeza9VRJ1SuXcVB7B8YQdJMVMoOS1lvwbKd6AYMgBOC+6dSeL0LN50oMncndmZyMj46YV93ufxEGvzbGSVTDZ4ajE0dmDfwJOeWyMsI/SZBTtb2Lh/NvhPbob2dlsR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786463630; c=relaxed/simple;
	bh=grQ2k+Z7764O6Zh+3TYZ3mXF7+2RAMOFPi6sTQuhZOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QC0TbEdEUnPvN6rl8g2T41HwZqOcY/OfWDzD615xelwYjL6NvmeMKUlSqjvUWa366FeAnc7TJd6v7iNYwr0NT53qfIAcS+NITWzT+iQWW0baNk8q8JGGAUmDw6C/RICMmGlNSkfQiQiW3gHyQKdFaViUGoAACJ0VBKgvUmpxin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MR2HUg8J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MR2HUg8J"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDWVY6537676;
	Tue, 11 Aug 2026 15:53:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=grQ2k+
	Z7764O6Zh+3TYZ3mXF7+2RAMOFPi6sTQuhZOk=; b=MR2HUg8JHTsls+L33UYwYH
	MeBgbotE4Acmv5fPZW8PTMbDN3D83GzK1oFsoscx0gp7vcuSwquSi+mn1eH64ZtW
	5LEpS0DE/6XEncRZIQvD55C9dNF24pS0/xlq6doRrk1vYfiDUIYnQx2KEqJz+pvW
	fLrJM8O4E1odBJi2mi4661n0o/39prRuBnLHLE43RyIyWJ1Um2OKneBjFyPXLM10
	RDGWS2Greq8CJi6MU0Iy8Q0GpFle52vVJH+iN31bJ3r98SrS1eA4a7ziqJ/6OzYw
	VTl+zHKmGx1OryOIII/MpnJayadVh6gQIqJp1T7K12JgFMJ57QlUbs9UvaFgCJlA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9nter-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:53:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BFfcL4029658;
	Tue, 11 Aug 2026 15:53:37 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy1cun-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 15:53:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BFraje16122542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 15:53:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A4C058054;
	Tue, 11 Aug 2026 15:53:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5B0A58050;
	Tue, 11 Aug 2026 15:53:34 +0000 (GMT)
Received: from [9.61.146.44] (unknown [9.61.146.44])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 15:53:34 +0000 (GMT)
Message-ID: <33613f31-5e5e-4f5f-b1d6-5491459112c0@linux.ibm.com>
Date: Tue, 11 Aug 2026 11:53:34 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] s390/vfio-ap: Fix dereference matrix_mdev->kvm
 without checking for NULL
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-3-akrowiak@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260810192257.1208410-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfX+pnRg91h1ukL
 5YkDaZ0CiHlInWm+KLBAZOo5FZANYvjhQyCSloeCK6psUqUbGNphLlK2oyCYbmsoumwWtTppPiO
 tvjnWFw8lHofcvdDStNsw0egjSJ4PSVodD2+Oh5WCnRSZ3T2HWaPS+7hPQsWV+dwxlWNEWVEyAP
 51OsRQWtSv8wur1CDAaUqMbuaFqfbOOX4CBebIWwGbvQpsE3L8PProji3EGgf/fpuRbI7dpQrT8
 nE+qAOFmEvh+w42qDbzMZXhNL251QGmXgRLJgtW/EjK5KJUpyYrdlrwl9K274PeHUL4Q6n93Gtj
 BY4NAtwJDzG7KE3TR+1uu/22I0wnGhdRcBlpSUDjdSc0kQpMa2I7ZeEEzHIMZjvJXPt8sTLE/+l
 m3Iia8VKHSd1Km6+SWo9bMG834gatYpgKwZfcL6F/1fZIcKBBfk/4GVwxj+ZncsRWAMahULN0K8
 8UKDtLJkOm9eHyBomCg==
X-Proofpoint-ORIG-GUID: ppDUa8o7ET9MF19tF0t0vUUAIgkLWnsm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEzMCBTYWx0ZWRfXxPdrUvApL1Va
 M3pX6qGX2iOKRtRReA6l88AuhtOQiBaNOw+pGE1suIw9PwNgtjM7CoPz8U+PFOrcysOnxRj3Gwh
 4eeD56Ml8Kf7KgZrYVr8C25NpO9mvQU=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7b4582 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=sEJQHw-XGmbjtyPYZvMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ppDUa8o7ET9MF19tF0t0vUUAIgkLWnsm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110130

On 8/10/26 3:22 PM, Anthony Krowiak wrote:
> The ap_driver structure has two fields which are function pointers to
> callbacks:

...

> Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
