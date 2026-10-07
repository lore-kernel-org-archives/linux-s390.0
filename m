Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0C247D454;
	Wed,  7 Oct 2026 19:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791402145; cv=none; b=MNvNhVZPKb7owggGUDlXjY74M97dkVgzshp3Jbin9S73qURq4eXyF8+huVK2/89eonGiTt8L4GeA5rkTTLZohKw/8vAfG4f1T6V8DZLcdESDSf6jrRm3bCSO/L32X5R5ErKqFa08tS2INaW1D3kwf3l2VRR2fEQU8tfb9ERaeaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791402145; c=relaxed/simple;
	bh=n47OzpwVnKMmzgYhLxaai5DyGsXjV8OoPxKpEXyI0d4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDAbrfSJrOOwcU/ymt4Y8wbWMA0AxbQgs3FrNMRIZjKUYRs8VZ1egCtHjKpg6ZbWGZSZ7AqVKMPzN7hLWcvOURSx6xrktsw3vdyWIC5mZq7hwusmIX5m1pQKiaeVULgHzPHdMNHt+5nB7FZGn7NBJGdUK69RugCnFa9IByr9QDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JDHs9JvI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JDHs9JvI"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697IZXvd2078170;
	Wed, 7 Oct 2026 19:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gUXtr1
	hZNl0XvBj6rUEtr6liOsrV/6rwrVDCslRPg6o=; b=JDHs9JvIpt7gljOCLUvk2X
	pu8EVt4U1TIb085vJ+Cw8tVqnsvuM7S5w2kEvbTB9UWHk+wAQGM5O4Gy2H2oq6Py
	CYsnYS2bTZ0L/8vOfVzmqOgk+pRoopsFTCSTUYwaZtjZj6z4MI+P4OrhHz9T7upg
	voMWUcN4kFCZYwFEgDiQtQ+U8qP7GkmU4LDGzu+Gm1gvq5bW4CwhG1FLRc38OVlb
	qfLAXrJf205EhIcPNg3uXdY37kY1xaRPdb+SiaDHZCZPeyZXq8+ifBW9GHXXjW8z
	mx47HfsgL0gccxggfEWekEP1cy9SRnPW7+/n6lIekMMg5LSMvu7dT5TYwPDEr1hQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4g6pc8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 19:42:17 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697IHYt62245356;
	Wed, 7 Oct 2026 19:42:16 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5mdbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 19:42:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697JgFmh31195770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 19:42:15 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9B3B58059;
	Wed,  7 Oct 2026 19:42:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1076D58063;
	Wed,  7 Oct 2026 19:42:14 +0000 (GMT)
Received: from [9.61.89.182] (unknown [9.61.89.182])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 19:42:13 +0000 (GMT)
Message-ID: <be89f54f-c2fc-419b-8415-d4dfcc57a58e@linux.ibm.com>
Date: Wed, 7 Oct 2026 15:42:13 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/15] s390/vfio-ap: Transition device migration state
 to STOP
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-12-akrowiak@linux.ibm.com>
 <971d827a-c342-461c-8c05-929b02df6807@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <971d827a-c342-461c-8c05-929b02df6807@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac6a099 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=lWXgboQppWcC2sr743cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3OCBTYWx0ZWRfXwNA2Juu147E/
 kUXYKDZSe4AZREtY6TGMwPnJpr2k7Kb7kRid83eufOVDlc+9Ut4fuLAhMNTeXKThRNrAQ5I42y5
 TnXyJOalspoVoHO0R3rXBjcVXQHD3Hq+fB8LfnEF3YViXPXfo1n1XdAQTw9LRnNMky84r7eL54m
 2ZuhGPm1QeNZ+3gfOd7Ucx9YkDo/AcdhG2SRCJUcU99lypGtRRJQCfLFEw/okND3qnfGHbSCi6J
 VmgiLCqujDb3d+7IOZdDHgiPLjtCz9J+5bAmxHRGHCy5u9iCo9/BhagcFoQBp/KiEQXaRpk5DeV
 0deaZcU+wVvTIPSrnjpum2fTA2b5wFhdxNqNDcJcjWxXdUmfrcgTyFbMaR1CFxwp3jzYiwsc0DS
 W88FHZtVNSeRFjnc9fY0jIik6uuoUYe+XQ/Le+fSSO6yN/sL50gFpWFVx22kAHD1SKm0klMYtq3
 Vzd3Z7O0waaMjC1wCPw==
X-Proofpoint-GUID: fNmcIuWw-mSBrP0fJ8-TPFmpNAW0zNyK
X-Proofpoint-ORIG-GUID: fNmcIuWw-mSBrP0fJ8-TPFmpNAW0zNyK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3OCBTYWx0ZWRfX50fmFZegkqe9
 Kftl1uf0u3dRVqthR4+1LizN3SCGlQ0qO8/MxywFZXD5Iu2h65/E6w/fk6vS5z4QOOz2XPk56MZ
 We2tioDtSevT72P9vFRDmnwSjEvf6NI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070078



On 8/20/26 8:43 AM, Jason J. Herne wrote:
>
>
> On 8/7/26 6:18 PM, Anthony Krowiak wrote:
>> Typically at this point, interrupt processing for the device, DMA and 
>> other
>> changes to the device's external state must be prohibited. For VFIO AP,
>> there is no physical DMA device virtualized by the vfio-ap device . It
>> merely manages the guest's AP configuration that identifies the devices
>> passed through to the guest, but does not have access to any of them. 
>> Those
>> AP devices are passed through and controlled exclusively by the SIE 
>> program
>
> SIE is an instruction, not a program. It might be clearer to say:
> pass-through AP devices are controlled by the hardware.

The SIE control block is used to pass through the AP devices via the 
CRYCB which
I assume is processed by the SIE instruction. After that, vfio_ap has 
nothing to do
with the AP devices other than to handle interrupt enable/disable when the
PQAP(AQIC) instruction is intercepted. The vfio_ap driver does not 
manage I/O
between the guest and device memory like other devices using VFIO to 
pass them
through. It's sole purpose in life is to manage the AP configuration for 
the guest
to which an mdev is attached.

I'll make a change to this comment.

>
>
> I'm not sure there is much benefit to having this as a separate patch 
> at all. You could simply roll this into the patch where this logic is 
> originally constructed and skip this patch entirely.

Already addressed with response to 12/15 review comment you made.

>
>
>> used to start the guest. There  only thing to do at this point is return
>> NULL to the caller since the file streams and associated data will get
>> cleaned up as a result of the VFIO migration framework releasing the 
>> files.
>>
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_migration.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c 
>> b/drivers/s390/crypto/vfio_ap_migration.c
>> index 4dd7373c3d9d..30160e3ddded 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -1511,12 +1511,17 @@ vfio_ap_transition_to_state(struct 
>> ap_matrix_mdev *matrix_mdev,
>>           return filp;
>>       }
>>   +    /*
>> +     * Terminates the data transfer session of the vfio-ap device state
>> +     * between the source and target hosts. Since the vfio-ap device 
>> does
>> +     * not virtualize a DMA device, there is no internal device 
>> state to
>> +     * incorporate into the vfio-ap device on the target.
>> +     */
>>       if ((cur_state == VFIO_DEVICE_STATE_RESUMING &&
>>            new_state == VFIO_DEVICE_STATE_STOP) ||
>>           (cur_state == VFIO_DEVICE_STATE_STOP_COPY &&
>>            new_state == VFIO_DEVICE_STATE_STOP)) {
>> -        /* TODO */
>> -        return ERR_PTR(-EOPNOTSUPP);
>> +        return NULL;
>>       }
>>         if ((cur_state == VFIO_DEVICE_STATE_STOP &&
>

