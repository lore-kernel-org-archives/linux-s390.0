Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A105F4334D9;
	Fri, 25 Sep 2026 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790328915; cv=none; b=taxtk2J+cqIO0FbccIumaBXeEJfu8tfVpG/lEzlNLuQuB5/xSTwYiv8/2SEuG0wuKMH+41UAHEE6tM6b6vzTLZNx5sNaAnySetCctHzN64Lfracv5joDtg5HWOqNWA+EQnMJhZhK1/FIe5X8RNfL5OoLcwOUwe9B/RkLc95o67I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790328915; c=relaxed/simple;
	bh=NvPM4KCHNRUUmYJoS0Lks/JErSTtZZzhPOFblcOYE24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iTy8zbFqw09F10GR7rMAVw3HdM227kVZ3b0lQ7LB4X92IIeqxIBgi+5EKWuxAps1PD5NwdII9ZjAyXV3zIUBfKgE0ECIQ3jc/vR1RcLN4O1GqnW2GeDnO/4GyfTC/NQQXXJahJ7wL8MKRhWhiy4vTblojWx9hMXxvhSkr3IPKfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qJNWOy8V; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qJNWOy8V"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4a8ek3083607;
	Fri, 25 Sep 2026 09:35:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AzqpFQ
	59UWc/vLtUIvSxuw5VZVoFaJ100Eu1q1e5xx0=; b=qJNWOy8V2F6QnRU8xJsxnI
	Ag3TbbkJ7Kdc8JuiysGUxMu8RDnBJjv0sw/tkmGQt7vAJLAlbZaaTxwLsCrgWens
	/s3iW0uJFWoIq9rVWbT0RTSfvMB+V9LPjdXbAeipUDIoAaRzCBBmQ1Oxhqseb3MU
	b3kmWo/2SQW7Ezr8iGfiWallAOg0Tu7DJsbEQT2HzQ8sqPXOB8egI78KuPnF/pEN
	6LKQczU5qwnErt62Y/e1Ak3eJfx97RQsleiQhX7/nk5qFjXQ5smBiezC7EuRXv+h
	xYRFQRU6suf3aJoqDR8cmPQV1Ebrp+1t4rtWLDvwE6SlbG3j5eit+esWujN42aQA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqw9cd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 09:35:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4lUYD1959486;
	Fri, 25 Sep 2026 09:35:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7ee2wc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 09:35:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68P9Z7dA47055234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 09:35:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D26220040;
	Fri, 25 Sep 2026 09:35:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3787F2004B;
	Fri, 25 Sep 2026 09:35:07 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 09:35:07 +0000 (GMT)
Message-ID: <5c2c6589-f9c3-45ee-ba1f-9d22b1b47122@linux.ibm.com>
Date: Fri, 25 Sep 2026 11:35:07 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] KVM: s390: Kick PV cpus at the right time for
 service irqs
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org, pasic@linux.ibm.com
References: <20260820121546.24694-1-frankja@linux.ibm.com>
 <20260820121546.24694-3-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260820121546.24694-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab64050 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=2RzByGtBRGyDpTDcgcIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX3mColtsDPGva
 gZcbjcJzOXIkEiO3JV9PXXqfPTcAZfZodktd43Hmta+KBsDlMmIyMtmsyhAL0e5cR0zngc0pW9N
 bB+ocfv9LQgoXxSZvxNDX4gpuu0yqqFeyuNkeFFBXj3uDlMfC8lGtNTjD8ymZTD156xA3RyPGXS
 5884JoH7crSlgUgvY9ZxnVrrbZSB1M4wKE4WhzQSMFXlqiNt/bfseBIkVHQ1iQpgvsxZy4dcfSd
 N2EO+2ew9klWh32rFZkDvt3RJWtjHccSzW5COM6SuVa3VNu9cor3bkXg5GbECm/ri/WdQiDKV4B
 tmFVJvNZz+yU+DCfTViBe12gEJvChrR5z4/omPRaTe0DPYiI60Va315ablPSRutEe3pUe+MgL56
 xjOOrDGA82Qqu8FMhpZVFgI3zglZGBNaoskIQzZDRcxbRl+Atm/KR0V5kL7L9Xh/chCjk8Pb/4J
 bh2Q8i5WMrxfGVHc4lA==
X-Proofpoint-ORIG-GUID: wRCeby14GyfzRw0ah6bxSprXgAXD1GyR
X-Proofpoint-GUID: wRCeby14GyfzRw0ah6bxSprXgAXD1GyR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzNiBTYWx0ZWRfX3oawFOu/D+dx
 rjVrMtpm7aWpj3FkX5QxOI6YlfOONKOl3UY5tZWaEbxa3QkWDhp2PsrNPnfbYQKhr90pRm4C5/b
 gVLNiUEwHIvh6o+dIYPstDEYp8fgjDY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250036

Am 20.08.26 um 14:12 schrieb Janosch Frank:
> Service call handling is a two stage process for PV vms. First we
> receive the secure instruction intercept and then the secure
> instruction notification intercept.
> 
> The secure instruction intercept (104) is analogous to the non-pv
> instruction intercept (4) with the difference that we're not allowed
> to inject an IRQ when re-entering SIE. We have to wait for the
> notification intercept (108) which tells us that we're allowed to
> inject.
> 
> Unfortunately we never considered this difference and hence the IRQ
> injection code will try to inject on the secure instruction intercept
> where service IRQs are masked.


> 
> It's time to move injection to the instruction notification and skip
> injection on the instruction interception path.

The injection itself (setting the pending bit) already happens in
handle_pv_sclp(). This patch moves the kick and we should change that
in the commit message.


> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>

Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
