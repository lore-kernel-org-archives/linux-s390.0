Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD230E0F1;
	Tue, 31 Mar 2026 19:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774985375; cv=none; b=tZj3AaV99WOPEDqAFE9KZJWqA0/II4MrlFA3TL4LdpH0mittGZgbQmSwhTiDcniYYTVb7M25GyMtNAvCVgjEZMKeoD4/OpuJYz8eaK77l/Jk5cCYLOAqQpX4TTumAlaJeIAMmER3oBu0BxK4inD7KfcPH8t8rjOKHsVh+6qxVqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774985375; c=relaxed/simple;
	bh=bBjparJefBrhyEWN7TfOR6QfHGCO1i4wg0xfspVx1+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VejlouTPMX4XF+CVmw0ld+d8UgG66AZDrF4Q2/8OTh1NOpQvsF7E+5W2GDEbFcszS8cE7rlI/V16EM3GYE02hNULtuhCnCFCMqTf1Rfvi8eDfA4Vi6kKTQamK9Vtzj8LBCpbKOQqhOd19Pvg2VkiqzAC9AMIq3OGMXEfYoLoYyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nLeObDhY; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nLeObDhY"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62VFGOID3113759;
	Tue, 31 Mar 2026 19:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Xp6Y8S
	lP6c4g3qeJVvXM51OiCH7ypgGQ+XA7elZ0B80=; b=nLeObDhYQ00v8o+BIOGfDn
	bq/+UNx7UltFxsL3lwFNRcXh+Cl2mMQN1Exjx8xV6sZq+jzfwo8Py7ofi5SFNcdu
	T5g5LEiKJlODJ+Bs3DZxP6iUl6DyvEhxjnvSWR7NFTpfSUAFPDsouVRjIbSy61b4
	54LDQ/TPGVABiIp9G/QcIUgvEu45pG8dyJzratxIrEwt6qYl4VCsoTEc+IRIVN5t
	ZFtyU0o17+kqO5ZWa81Yo1qx2HhQHt28c56h97dSKNHHyK1bIRno7pxl/KQRD3MW
	d7kD50uMUTtvU5vXj1Tj5h4onAKxyUpF+9saTl4t75q0tHTZ75B8Wj2o/kz5n6tg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnn1j3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 19:29:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62VFZqb2022210;
	Tue, 31 Mar 2026 19:29:27 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6tan2krj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Mar 2026 19:29:27 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62VJTPwN25887256
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 19:29:25 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A135658054;
	Tue, 31 Mar 2026 19:29:25 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 944F85804E;
	Tue, 31 Mar 2026 19:29:24 +0000 (GMT)
Received: from [9.61.9.136] (unknown [9.61.9.136])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Mar 2026 19:29:24 +0000 (GMT)
Message-ID: <e4baff4e-2663-4087-9dde-6cebb62f6882@linux.ibm.com>
Date: Tue, 31 Mar 2026 15:29:24 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 4/7] s390/pci: Store PCI error information for
 passthrough devices
To: Farhan Ali <alifm@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        kbusch@kernel.org, schnelle@linux.ibm.com
References: <20260330174011.1161-1-alifm@linux.ibm.com>
 <20260330174011.1161-5-alifm@linux.ibm.com>
 <8c080d9b-34f6-469c-8e53-c5d0a175556d@linux.ibm.com>
 <ec10fa8b-b499-4f06-9a7a-71cb6d76e03d@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <ec10fa8b-b499-4f06-9a7a-71cb6d76e03d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YIWMn8BWKHsM7TL4NWBoIuIVXe9q2s82
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cc2098 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=AU4VBfrfX5olrtCezKoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE4NiBTYWx0ZWRfXxSZVoSUq0aA0
 2nX3xcjnCtfrCBbZ88n9JiOW4F2GoGKu73uyhIJFMBfJTZcuXaDtlLnOZD2k5eYo9nQ0S+v+tM/
 6SvHaV3si3yslwxMxmxabvAzp4BCqyT+7S7z9c5L5SYoAbTpH8UnoTzrcxcHfmrz7tWMqwT8rtQ
 n84A7Zlc/V1nNVs3PpoNQmKQXy6uTgS4GrK731br/zAiBfJL6KFocICxo7sTurMTwp2A5CTdDPp
 5vPvXt8pfTvFCv9cPbFtp+vvwanraGSaQliWGMSL37rcWkkEmwdrZydKtHJMwcr01lQEpynMvwu
 EfyJDxNdg3OEJGYvwWi3sl53LArpSzXyuBIZ0Zrbkc3086hnqAEPA/HL9fjXD+mTN0DtO2ijV1Z
 9af3l49KVuFZTbDmyJyXjXAEwa1N3NQzM8FUxYVahfIy16CWqYXvAVEpkYFoGi3ntWUtzr4SVHs
 aQB6cN2ld9QTs8QxaoQ==
X-Proofpoint-ORIG-GUID: YIWMn8BWKHsM7TL4NWBoIuIVXe9q2s82
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_04,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310186

On 3/31/26 3:23 PM, Farhan Ali wrote:
>> Actually..  Could mediated_recovery just be part of the
>> zpci_ccdf_pending stucture?  AFAICT the bit basically controls whether
>> or not the zpci_ccdf_pending structure is used / has meaning.  You even
>> turn the bit off at the same time you memset(&zdev->pending_errs, 0) in
>> zpci_stop_mediated_recovery() -- though an explicit setting of
>> mediated_devices = false would still be nice for code clarity.
>>
>> Then the spinlock continues to protect only this structure.
> 
> You are right, the mediated_recovery flag drives the use of the
> zpci_ccdf_pending struct. IMHO keeping the flag helped me with code
> clarity and keeping the struct simple and not be tied with the flag. But
> if you (or anyone) feels strongly about it then I can add the flag to
> the zpci_ccdf_pending struct.
> 

FWIW I am fine with leaving it as-is as long as there is a clear comment
tying the bool to the mutex.

Thanks,
Matt
