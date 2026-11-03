Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745923;
	b=2icyiVr1n9iDf2jquLZX3uMYqI4mwzaXzkBjUGjCi1cl5Gb5V6UdxCG0DBCH+6d0lIcc
	 KYy3bSLqvEpwNk9sJqIBRiK/hZFa+ZImOlnGCVAp44VWkZnvgy37cp+A9FeM8U8qc1FvB
	 FZW5sHccMYHqrf7RgO/yKAgEypvh5zeA5VSz1hsJU7myN/k1OnowOHRF24cCYKr+/9eX4
	 caXAfayvhuQYFOIKb9T4WfUofBZQLM5i3HaylW/grPw9MaL3mg0a8AZ1aCJnAlCUdxTkY
	 IgoqESHHtGE/YrEl+QdqtFEXMCYdo/L1SgZm8LvKlsTWVF50X344XXzWtO50RpaqWWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745923;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=/GO2ExICahF7BId12law/TW5FYBAReP12IVhUOS5pJg=;
	b=p0WL8EHkc2r63tVsaAL+C1GDpVkGkCSakDYA9uLRw0KjSQYX8/CQjFEw44EZ+M8lks7S
	 ViANDAkyxUY30A+qYJ9u1HBIFBYuZHk5C5FQK/01ZeQaKSIyg5Qi+qylGcES5KWKYRu0n
	 RyO9V7394+mUyR6Pu7r/omyS8w19cPYrPTUC6L4uymZgnPI3BAw7nOYK29lrpcrIosMXC
	 rHXPjXgweggbzr/lTlGvf9Xsnr0C26fAoS++bqK4huFbT3YL+U1qDXymlDrEKfI4i/cKU
	 P8ITKhmYr0+TJ3TxVfK4lo9d39z5I979FhPScBDGSpubnZrGdjHMSUZkatQwiLJqiFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EaHGzLNS;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C51606A329;
	Tue,  3 Nov 2026 22:45:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16C51606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=EaHGzLNS
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3Licp91361207;
	Tue, 3 Nov 2026 22:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/GO2Ex
	ICahF7BId12law/TW5FYBAReP12IVhUOS5pJg=; b=EaHGzLNS48ceBLvv5Sq3Tf
	c/Tiv3nb2e8bcMsJ9d5V3fKmjnMY5GuthfZkkOfyamr8OgnY/T/aolqqqVH9yBTR
	IgKX2HrM6ik9Va+Tcd02xpsPOZGVxQMqLBDooKNwBjY6PGSiOvgsdYF0THB1w9Kd
	JYyie8CJuG77C0suLCtIlCYpZEv81HIIIzkLWdA4lwfNAL4+ixvFPyP4BA5Md/Gw
	h+QUplE6PdYCSWdIHoJFK/Ec6WbE8JcedVnZsoPb8CDA1l4LV80T/MqPtNkLgZmK
	mzLX38tsLnOgKaGkIDrRYx6otvgJReRfgjtimG/skauVAOmN4LOBRZmbAcD2PWTg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80srs5v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 22:45:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3LMdKq3061459;
	Tue, 3 Nov 2026 22:45:19 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqcrcbd9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 22:45:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3MjHaE18874960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 22:45:18 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D425A58054;
	Tue,  3 Nov 2026 22:45:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 465145805D;
	Tue,  3 Nov 2026 22:45:16 +0000 (GMT)
Received: from [9.61.96.67] (unknown [9.61.96.67])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 22:45:16 +0000 (GMT)
Message-ID: <bfac1711-65a2-40ec-8506-790661351530@linux.ibm.com>
Date: Tue, 3 Nov 2026 17:45:15 -0500
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 5/5] vfio-pci/zdev: Add VFIO FMB device features
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Omar Elghoul <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, frankja@linux.ibm.com, imbrenda@linux.ibm.com
References: <20261103150114.68873-1-oelghoul@linux.ibm.com>
 <20261103150114.68873-6-oelghoul@linux.ibm.com>
 <15fbeb951c380ba6a200651d6ff69b783c96a375.camel@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <15fbeb951c380ba6a200651d6ff69b783c96a375.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eQOide1Nl49tr_hewoghzcQktMMQdVdC
X-Proofpoint-ORIG-GUID: eQOide1Nl49tr_hewoghzcQktMMQdVdC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA5MCBTYWx0ZWRfXxIIcUsO4Xe64
 WpHb9oAyqT0tf7Q6FoZoQyu4h/Bb520VTlbU92RM8pCj1qA5Zgqy8wlWRc80tfZ+XFWBwjoc4jD
 zVEY22wqpijjlBdrqukYAl7eMpxo28FX4BpPRunTb8/AKUyciaNNewGy7iBNkrnBXGqMQhbFr7E
 Btt/vUmrU/CjcyPEwCR8XmwDdoaXqXCOMUUsi+HOBmP7tVM11Gg4oJzUXhoxhtIehXzabLlQ/uJ
 JNu/0SPuR+1R1fcWI8vWspJgd4oU9uu9R9rBvf/4jSycJVWwbrNgb4CQ2IpSYrOwaUbaWStvHzY
 JGJH/sUCLJd9jejv4nGRpotfWFHVkAfAWiL83Tg8IaY1SDOOSydF6wrroBlq/j92aSLlcIeORer
 EKknDLg9MH5L55jemp5goRH5bHdFdcG6O2GmiDDsr0+YUTf622cgPFXef61g0cXzRcljbCJcgyY
 ESYAqpEfnywdiZJOBcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA5MCBTYWx0ZWRfX7TuInsBj410L
 lnVrZ6IT5Go31JGZ7A3cIHe4U02TnaFJDx/fhcWTTe/CFPVxptRNuBfBPOJM4elmefwQBN3AwDe
 WVEiEf8gCd7RjfXbA68W8GI/HktQOo4=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6aea6400 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=r1p2_3pzAAAA:8 a=F7dn7BFMEDAEK2aV7o8A:9 a=QEXdDO2ut3YA:10
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030090

On 11/3/26 4:08 PM, Niklas Schnelle wrote:
> On Tue, 2026-11-03 at 10:01 -0500, Omar Elghoul wrote:
>> Introduce new VFIO features for zPCI devices to provide FMB passthrough to
>> userspace.
>>
>> Allow the user to enable or disable the FMB using the SET-only feature
>> VFIO_DEVICE_FEATURE_ZPCI_FMB_ENABLE. Likewise allow the user to read the
>> latest FMB using the GET-only feature VFIO_DEVICE_FEATURE_ZPCI_FMB_READ
>> in the case when the FMB is enabled.
>>
>> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
>> Acked-by: Alex Williamson <alex@shazbot.org>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
