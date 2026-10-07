Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D377A4D7950;
	Wed,  7 Oct 2026 19:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401320; cv=none; b=nOOsdMbSowoCDFSDNujwtsnBprwnOQbL5j2qg+QavUUV7h49ieuXVvOpAki4vfKLOXJDVKzC60+Qp0wRHclochg5Tfx4DdyT7MQY++ghVb7chmZpLEADVekup/wh3JGTeRuMbKKhMTuaNELUo4LpRhWEMySeLVOR7mCpjykY774=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401320; c=relaxed/simple;
	bh=71vo2jjzcOL+V5enHzqEG4+BeyCGaRVAjj1ZkjrHpVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VI6yTm6lz4WlUGwl/46BuAj8tCsiH41RNB4iT2JQADQo6+Gbt69dhC9JdJti7ZLYCvE8tmeH7rGpFFXzgLDMcncklQFrI9G5ZeTXHxBztxGbGu/dHSdaBQDPES8O7O3o6Y4/XPVxQWdh0yIBCUdmBlrcwCyMOw1I0Avj6h0Qclk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ciNFnLzN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ciNFnLzN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697IZWJb3153088;
	Wed, 7 Oct 2026 19:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=BeQ8or
	IWhaDfoy54B8h56dzMLwkRrjRpmhD9C2qlKe8=; b=ciNFnLzN5JhFt7Ir9XUQrU
	guoNuQgHitl/crFt6Nbs+d0bdnl2TXiJd/Kjf5hHc8YY3FRvmq2B+jY2np0Vd+o8
	EddqrD8ZBrF2s73LuoFkqoQy7Ns8g3xj+lD1cdWW64wpc0T1t4TCvN/ixt2/uHkD
	e5SaRdVhL5EiE91/YiC7W+maOTipdYxEMsg1Ol0YAl+WExzjt3n+m0HZoqgc+nqk
	WAaXPocLlna7oKvSXxRMQrv6ZNTTL1hr1l0CBVakHiDKEDX4Q51eDVp5r68qcGzr
	DwUbie3v4Fb4mFyo3c3bfleorx75+EIGu7+rTwpHK3/pRj5Z6xn6JlHew1sen/PQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jxw2n-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 19:28:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697IHWWr2307797;
	Wed, 7 Oct 2026 19:28:33 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhh02a2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 19:28:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697JSVre22348444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 19:28:32 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B93DD58055;
	Wed,  7 Oct 2026 19:28:31 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CE815804B;
	Wed,  7 Oct 2026 19:28:30 +0000 (GMT)
Received: from [9.61.89.182] (unknown [9.61.89.182])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 19:28:29 +0000 (GMT)
Message-ID: <1c8aa018-1342-48e5-8896-6d18667e5b12@linux.ibm.com>
Date: Wed, 7 Oct 2026 15:28:29 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/15] s390/vfio-ap: Transition device migration state
 from STOP to RUNNING and vice versa
To: "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-13-akrowiak@linux.ibm.com>
 <8fcac646-b33c-44e2-90db-b517419f8f76@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <8fcac646-b33c-44e2-90db-b517419f8f76@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6Y9cS8qFSGLhzCfiKXz0B-SOMZ3VBOd7
X-Proofpoint-GUID: 6Y9cS8qFSGLhzCfiKXz0B-SOMZ3VBOd7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA3NiBTYWx0ZWRfX1RXZMe1eIbT+
 W18d+6wv3sZWOJKX49sfpcKRIDCG+y4w5cgp1UqDhpzW0BcZPxHOXs5aCBUQ3F6Bcpygy48CFI8
 0TF2uQJew/UNJmKhO/uDfKu4HHC5ioY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA3NiBTYWx0ZWRfX19IsLFXJ8BKZ
 xi/BC6W4OTtMirAuhNNMIO/ya2B84xR4jm713Awedo6nUIt7sw+/igwvGCT2Pc5fIRghft71DKQ
 hVZ9QlZgntnmOGKq1Uw3qlmrT2TlTKoqjI5+IeDSfTwLdJjBMZsDFL/Io05S7MbuFl0Z4HgZLha
 hHiKJa/VawG5nRJlPi/SVK/EsPigsP6HQtHce7KaAkryr8Y77WkLYQ1vIjt3taZAdcjKCIZA2UM
 USqKnL++PQzlsHm7ogH4P+TY5oGU4uSmJg3t6fbp0ktC4nMoJNPwyTtbm4u4Knb2UDHn7lfx9WX
 8MhViKUvTW0tA1XSur4iMX2emWFvzoIWVDlsM23Ds4LqhyB8/P3IPI0pJBiM7Q0RbyJZq99rjRs
 u7+HRTlghmCWdZNNtW9MiFUbr7SJT/GCqWdEemwdyQSe5gBYbeL/ng/wrJH5EiTSame2lXwQFV6
 IV8UJ+M1aYPKAqB6lsA==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac69d61 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=QXbWHM80TDR-pc_dJdcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_06,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070076



On 8/20/26 8:45 AM, Jason J. Herne wrote:
> On 8/7/26 6:18 PM, Anthony Krowiak wrote:
>> The transition from STOP to RUNNING and vice versa indicates that
>> the vfio device is operating normally and migration is not
>> currently taking place. In this case, just set the new state.
>>
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/vfio_ap_migration.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/vfio_ap_migration.c 
>> b/drivers/s390/crypto/vfio_ap_migration.c
>> index 30160e3ddded..24955f70e13e 100644
>> --- a/drivers/s390/crypto/vfio_ap_migration.c
>> +++ b/drivers/s390/crypto/vfio_ap_migration.c
>> @@ -1524,12 +1524,17 @@ vfio_ap_transition_to_state(struct 
>> ap_matrix_mdev *matrix_mdev,
>>           return NULL;
>>       }
>>   +    /*
>> +     * These states indicate migration has either not been initiated or
>> +     * has completed and the vfio-ap device is operating normally. 
>> Since the
>> +     * vfio-ap device does not virtualize a DMA device, there is no 
>> internal
>> +     * device state to incorporate into the vfio-ap device on the 
>> target.
>> +     */
>>       if ((cur_state == VFIO_DEVICE_STATE_STOP &&
>>            new_state == VFIO_DEVICE_STATE_RUNNING) ||
>>           (cur_state == VFIO_DEVICE_STATE_RUNNING &&
>>            new_state == VFIO_DEVICE_STATE_STOP)) {
>> -        /* TODO */
>> -        return ERR_PTR(-EOPNOTSUPP);
>> +        return NULL;
>>       }
>>         /* vfio_mig_get_next_state() does not use arcs other than the 
>> above */
>
> I'd argue to integrate this one into the earlier patch and drop this one.

It's a reasonable argument so I'll make it happen.

