Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4093F0ABA;
	Fri,  8 May 2026 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251817; cv=none; b=Uo1uf8DCxHsSdr2vocFLsejC29SBEZ066m+rPD468PeD1JmMnbilOzejmlbTbAd8tJeVKo9QvQJgx1l2LBXXYLk/NA0Hl9AOxqmbudax/kHO+k0wBnzo5olanVmpnqcunbsk4q3z3Jve3hnDtpezl5rY+wqQHXFCQrPOM2y+75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251817; c=relaxed/simple;
	bh=NxjnDOLQdTD8kjfb8cTfMB64tdE5xq06GfcPAQnB8oI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKGEXMk/yyfaLxereZMVwWBEzE5ig91f33QhVrk3wukRBec9CabiBYalgZEiplkZ3XpMTVpJIZQZwJqrphP9lxlG6Rv8rbeRHS0wE828+A4ccSySk9TOE60ekrF77y87uCvvrPm2zVTepYWra17PLRr9EiImWp5/LC/7SS8UtEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qqgxiLqC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qqgxiLqC"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 648EmYhe3486157;
	Fri, 8 May 2026 14:50:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O4DT2R
	ZcqHereuROhB0xcE5TxgMsQaUcQz/aqdGBuTo=; b=qqgxiLqCGyDT0VtQw1NNmD
	1jgH+LT1YmiD3lJRZX3eS+0+f56Sq1/A/bk3WHF1FOVVW8UMf5C3E8ewWLh3N3Dw
	7y16chsgG0PDPvsps1HkmkpCF1usHZZue07UmBqY9TwL0MUajIHdJ6Je+IF55bsc
	PDvhHBXs0t/Ynkihf/MtqjgECCBj71I2SR6furAob6ghG7rvQahO8DY/nKztGSPU
	es70RirtQgqCtHKIki8F+9tWweu3W0tNHZm5AUSwBQmeiE58f9nFTKkKZKcPDPBG
	xlZJBcmQRO9TU+KsV8lFhonB36i3oZG05V0ygBZkfejNGxsJ62yTNfeR0Dj2Ll8A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xy2tum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 14:50:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 648EdWDk000596;
	Fri, 8 May 2026 14:50:11 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yrbqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 14:50:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 648Eo84L42991914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 14:50:08 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AAB020049;
	Fri,  8 May 2026 14:50:08 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB18920040;
	Fri,  8 May 2026 14:50:07 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 14:50:07 +0000 (GMT)
Message-ID: <30406106-f64c-4cb7-8496-1006cffa8bc8@linux.ibm.com>
Date: Fri, 8 May 2026 16:50:07 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] KVM: s390: Toggle operation exception for
 userspace
To: Eric Farman <farman@linux.ibm.com>, Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20260507200836.3500368-1-farman@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260507200836.3500368-1-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE1MCBTYWx0ZWRfXy/Sm16uwNJAv
 0MK4GqrA9RsBunP/dShCKGyjzsTgEnuPH9kATwUXlHDbmPr6hrynm6+avOWdRfjmrtphdR9/DQ6
 +cbr2/Z0P7JA0tF6W7XnfoOqhHJ/NUpqPq2g5Pe3dJEoAmiF6rkiKpmyD9RKBllzVVIhJOrA+Hh
 tnlwT76o5z+8r3y+LkFOW68dKhJR2mGbTwWKpgrLsXpLo09yUX8W3vyItuLmGL55zVj8FIQe2Mj
 WYA0yuQCMdtNe8fucnaZ56YqQrWWvtmNpma3ZwsRJuuJ8wfn7ri/jDBOKtA4WdKZjGozG39NSvc
 AcFqYodS6fqXmwEQ/+88Je49d6lkXM9Gwp9E/8T0PkFupSX2VIWQd9Ny8CqEGqAAfyF5gwK6ayL
 QHpCno3x48ihItq6v5H9/hlJ1/KMYQZIPgAmWNpwp9WQkkZXSdL3HotPI2P/OuYdp+NMxwAl2Mn
 gSzx4oMFUUJPZ3FCPNg==
X-Proofpoint-ORIG-GUID: _c5H-Jf8xpp83FAVvKmhzDg7g3OnE6fd
X-Proofpoint-GUID: _c5H-Jf8xpp83FAVvKmhzDg7g3OnE6fd
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fdf824 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=IANEE5CLunT1K2rsnZcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605080150

Am 07.05.26 um 22:08 schrieb Eric Farman:
> Claudio, et al,
> 
> Here's an update to the USER_OPEREXEC patch I'd sent the other day.
> Besides the addition of Claudio's r-b (thank you!), Patch 1 is identical.
> 
> Patch 2 contains a couple of new selftests. As it stands, they all run
> with patch 1 applied, but I put the failing test at the end for if
> Patch 1 is missing.
> 
> Patch 3 is unrelated, but is a minor typo I stumbled on yesterday while
> looking at this. It seems small enough that a second `git send-email`
> command seems unnecessary. :)
> 
> Eric Farman (3):
>    KVM: s390: Toggle operation exception for userspace
>    KVM: s390: selftests: Extended user_operexec tests
>    KVM: s390: Fix typo in UCONTROL documentation
> 
>   Documentation/virt/kvm/api.rst                |   2 +-
>   arch/s390/kvm/kvm-s390.c                      |   3 +-
>   .../selftests/kvm/include/s390/facility.h     |   6 +
>   .../selftests/kvm/s390/user_operexec.c        | 110 ++++++++++++++++++
>   4 files changed, 119 insertions(+), 2 deletions(-)

I applied this series internally and queued for CI.

