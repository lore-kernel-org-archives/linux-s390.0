Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C661B81B6;
	Mon,  9 Sep 2024 12:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725886187; cv=none; b=ePReR1EB1goIMgKOqU9pT+e5GIXYPYrQbYTcxMFRU26c4kC4ZYzF+yrwh4OekyIR2A35sI2r2uj9q9IcFXU8BvQ8EjkVbu0Gxf4LctnoiSeio7Rb/KHJOl+DQt9nQ3+tPt9kIfK77lw+Gsug3PPEQTekg406aEPG5bXdhgH20kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725886187; c=relaxed/simple;
	bh=rsV/D5Iax9mR3YMxeIoRf5kDzlBXjxnzlxbSb+zIKbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I5vG6LFPaXi2vU/NCOX3vAxq7aCj2QzZRWxl/DA/LveVUmgz6Obca7OoPOXai+yz3xnA6+dIe+WaO7y2uJuS2dVd2e0dpY/lJCZeD1diSDMSEEgqvysuFhyQFUo8rWK2+FifgEJBNdW/GcvpOeGqcNtBY5HJGrpDL6X5dycaAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J/mKy7c/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J/mKy7c/"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489CceRm014671;
	Mon, 9 Sep 2024 12:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=O
	/a5ZHuunPO6XGWQOGbtxfTXMRt0vWNdU6EEjgFO/F0=; b=J/mKy7c/K6po+t1q6
	HRAZEBWBDNsnq6WyZA4jUxTXhhGb6KdL98LVMz+umH3zIJ9gtI/sx3jwu2V/y+Hn
	aJC0nWPV/BRIzFEJ2grPOYTfbx9iFUNfQXQPwKB/ZSPlSaYAFawQvcwtWFMSXD9+
	Z+F6Pz0kOrFGJdBjex+dFV016c9CP3M2thVmzzkuxfUyNqs+UHyGBwJpLhVJ5FXF
	zkO1RwIdJuW64ZNFFOsEpDlWoIEegEBUZPW3LHeqz4HFBbLRP4Xlycbrpt1UkP2o
	XPf9l52Tz+UAGomNnkyWo1QujSf7ru4V1hpL/8BGjDaG2Tc6RaZcS4/S7QVl0CDH
	evM2g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gefy9sf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 12:49:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 489BK6pS019847;
	Mon, 9 Sep 2024 12:49:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25ppfjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Sep 2024 12:49:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 489CncA731654428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Sep 2024 12:49:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A9622004D;
	Mon,  9 Sep 2024 12:49:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AF132004B;
	Mon,  9 Sep 2024 12:49:38 +0000 (GMT)
Received: from [9.152.224.192] (unknown [9.152.224.192])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Sep 2024 12:49:38 +0000 (GMT)
Message-ID: <54224e8e-9b9e-4bc4-a6c1-f8392de6f889@de.ibm.com>
Date: Mon, 9 Sep 2024 14:49:38 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/vfio-ap: Driver feature advertisement
To: Heiko Carstens <hca@linux.ibm.com>,
        "Jason J. Herne"
 <jjherne@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        akrowiak@linux.ibm.com, agordeev@linux.ibm.com, gor@linux.ibm.com
References: <20240905124351.14594-1-jjherne@linux.ibm.com>
 <20240906104540.9510-F-hca@linux.ibm.com>
 <d5911cd9-0365-47e8-91e4-f55317b8040b@linux.ibm.com>
 <20240909124159.11471-B-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20240909124159.11471-B-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: W2cmA4pXMbr65crPZQNJIqGWmJtZqMIr
X-Proofpoint-ORIG-GUID: W2cmA4pXMbr65crPZQNJIqGWmJtZqMIr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-09_04,2024-09-09_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=800 priorityscore=1501
 adultscore=0 clxscore=1011 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409090101

Am 09.09.24 um 14:41 schrieb Heiko Carstens:
> On Mon, Sep 09, 2024 at 08:02:17AM -0400, Jason J. Herne wrote:
>> On 9/6/24 6:45 AM, Heiko Carstens wrote:
>>> On Thu, Sep 05, 2024 at 08:43:51AM -0400, Jason J. Herne wrote:
>>>> Advertise features of the driver for the benefit of automated tooling
>>>> like Libvirt and mdevctl.
>>>>
>>>> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
>>>> Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>>>> ---
>>>>    Documentation/arch/s390/vfio-ap.rst | 34 +++++++++++++++++++++++++++++
>>>>    drivers/s390/crypto/vfio_ap_drv.c   | 13 +++++++++++
>>>>    2 files changed, 47 insertions(+)
>>>
>>> Via which tree should this go upstream?
>>>
>> I'm not 100% sure. Would s390 next be appropriate?
> 
> Well that's up to you to decide; no objection from my side.

I think as long as we do not touch vfio internals (then we need to talk
to Alex) or kvm internals the s390 tree is a good default tree for
vfio-ap, so lets do that here.
