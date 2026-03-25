Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4756C3FD14F;
	Wed, 25 Mar 2026 17:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460688; cv=none; b=N85rqHkSqA7GqCUqx4raSdMJP56UjvTCS6uKjOr+FQyFfciFdqyti2l5ut4RJcb773rQaZ3HqQrf/6x7yXz9zfOq9BhVavQ4BqyE+rjky2m17zgxZTA3NJ+0IRfBY362zicQSKaWapfeNtpA56giCRV3MOQVnQdq84F9Ko2CPtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460688; c=relaxed/simple;
	bh=xz4XURIsb1lFxB4B+J69dzmmoOh+gKxBX+5bhRGUkHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qMTGbqwTSZFJ5VzH2tbyobrha/Mk5nODJbQhT90ETDT02Q6p8Fqeqh+EjO+AHYkitjaaQTmWbu8CePWtMktr+YKFGcsVCWUrUpah41lxuJmriWCt+ktemWrq4OwB+UwFl0R206Z+G+oi4EFWPi7mVyt05hOdTWeiFrlyYlUNFD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=C5M1l342; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="C5M1l342"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PD3U9Z486107;
	Wed, 25 Mar 2026 17:44:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PIRsI4
	eEuL4DxNUdYM6zo0yJeIOE14ABy221HyWKDvw=; b=C5M1l342MuKmHDBzq8nFOB
	vHgk4S6R2zIbvrcTz1LF7u9ZR0K56lA7mfoHAQ7XVPMgjYTkuGOZv1nMqDBc+N6y
	jnf70gVGkgi/Cc6/zR4sVDe7YtpO+Wr0Ai8SEWgauy0KusQghrWeuhY+Mc8DAkcN
	DKYFidm+gVxcJS6GLgue96YeFflctRjlzuRXz/1hJeNjcW8O7f9RbgB7v3CpoFvX
	ffSzZwe3YAyT5G0tMAScDwz+iGu3dt1dJBHhNLmMKktDKrlg4h2STu/giIKwhepw
	GuLlBC2S+7srWnnn2uzMKl9ithRg34LDLOxK2ktVdgSidWLx8O+mq6YLPiJWqD5A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kumrw7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:44:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PF50SD031631;
	Wed, 25 Mar 2026 17:44:32 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsyqe2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 17:44:32 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PHiUU429229668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 17:44:30 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6143B5805B;
	Wed, 25 Mar 2026 17:44:30 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B62458058;
	Wed, 25 Mar 2026 17:44:29 +0000 (GMT)
Received: from [9.61.243.197] (unknown [9.61.243.197])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 17:44:28 +0000 (GMT)
Message-ID: <64a0373e-a20d-4890-b2f7-c6e2f9d279af@linux.ibm.com>
Date: Wed, 25 Mar 2026 10:44:28 -0700
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 2/9] s390/pci: Add architecture specific resource/bus
 address translation
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-s390@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        alex@shazbot.org, kbusch@kernel.org, clg@redhat.com,
        stable@vger.kernel.org, schnelle@linux.ibm.com, mjrosato@linux.ibm.com
References: <20260324230641.GA1162880@bhelgaas>
 <328a79ef-7b73-582f-f36b-5139ff04e24d@linux.intel.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <328a79ef-7b73-582f-f36b-5139ff04e24d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TlfwTHPCASCXXYzxyoSoW4oxqjy2u9B9
X-Proofpoint-ORIG-GUID: TlfwTHPCASCXXYzxyoSoW4oxqjy2u9B9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDEyNSBTYWx0ZWRfXwkR086dKHMas
 0LiDAUIGqMpKNdL5N5ZUeVEEt9VVoVHQsxQ3EX+J8DjiY8B3flRuT6/BGAkDcozt8pjOlVLtF6B
 TdaOfWFq1ma6y09hVWpmUhLazicdV5wFDAIH94pRQgUrBFJ6uyVV4qf6eql8506LsaBvhk7rjTl
 DngazpUEEdMEIs1YrQj9FK3VrLPD5765PmVT/r05nUjjrvAf4WbauNbLzIVjg2vT1G3sVYuQXV9
 FxIJo29K8wAxMTMftDS9uFXT5iE6BzQqG4uCayNU8HPqA4hngQOzSt6nUVRunnRn0TvbTKHH0jM
 SanllJ3Nkxz7CGDqtdpRR4YuegNZ5ZmTYaqFc75Q0+XS9tYvM1BS/IMBhVicGwdq5x0KJ4rKs0r
 2uog2PrApcjhyq5yd8Y05LgRYFj2FbKuMuB3aYns62sN/nnBc5rBDeQOYXdvhjFynN2eJIYvNBw
 bBkeWd5H3T97YIx0x3A==
X-Authority-Analysis: v=2.4 cv=KbXfcAYD c=1 sm=1 tr=0 ts=69c41f00 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=YtWjIhaGdMQ7bBwzLDoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250125


On 3/25/2026 4:58 AM, Ilpo Järvinen wrote:
> On Tue, 24 Mar 2026, Bjorn Helgaas wrote:
>
>> [+cc Ilpo just for awareness; I assume there's nothing Linux can
>> actually *do* with s390 PCI resources?]
> I'm somewhat aware they've this speciality (and besides that, I'm
> waiting for this change in order to proceed with the series to detect
> which resources are properly setup when we enumerate them which got
> reverted earlier).
>
> An additional thought related to this, there's IORESOURCE_PCI_FIXED
> results in skipping most of the resource fitting and assignment code, so
> if nothing really should touch these resources, perhaps that flag might be
> of some help.

I need to look into IORESOURCE_PCI_FIXED. Looking at briefly I think it 
may work for pci_restore_bars(), though need to check other callers of 
pcibios_resource_to_bus() to see if they will overwrite the BARs. But 
for now will remove this patch as part of this series and send it out as 
a separate patch.

Thanks

Farhan


>
