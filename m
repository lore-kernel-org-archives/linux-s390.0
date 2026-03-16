Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B8231A21;
	Mon, 16 Mar 2026 12:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773664308; cv=none; b=i7gJYNFKF9ogPkmZihFe5FzXw2mFK/WNOzVDDEhjUGRXeY/G6LF/sq63CMXPP5dyIzLXV4k5JbRlNnNYTB8zrvU8IZrUoxZ77LuWjq8EjX2MchkJuQ9bbvYHIkDwRvTvmCrWutnOeBKFb4o0tTwowxpBcu8dPEMuxbdRjmu8Soo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773664308; c=relaxed/simple;
	bh=1Bpphy/JTA4cBUuBI58HXbksDU3xwLcApxUmoCJ81S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jeoSncbUQRxqJ5pR+xmxJw+wK49tLNXv8IMBzG8EuXfkKuCPh0KyPo08LZpUC8U+/C2d8MSvlS3ki9IQc4KlgseJlMJ6MsVCfPTLiqibnBaYdI6AHIWuh4diWuVEUTLo+k2HbJmfqDO4a1kY7bJip7UB2/zoaCT99Bm39zHheV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CvlyjxDa; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CvlyjxDa"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FJKl7q578436;
	Mon, 16 Mar 2026 12:31:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SnuLtd
	+6vEezJWVbxvDh43TbQh2seJWnA/KWBZNVIV4=; b=CvlyjxDaB3xn3RHSo2J8sZ
	lEHeCtfG5Ks48BK8XfLWB4wr3XivDnV6xMCCvhM/TIxcFZfYbyLpKQwiXLuEGbSm
	I6BvgaIeV6NnQeKURYAArYFaQ9M0B3dbFnvgCLI36+82Rv0s1cd77ZsqlcrZuvV2
	BosB1vWPmb9jQkdnQ//OAizC3vQ4qe6U/xNw/j+6ADD+LbiAP+ehbmXcarzNNnY5
	Yr/qaZL0HuKQaZE7wepZje84njjGpOnVFmecFSujCmEYDEtu4fQxk51BuoCJpU7X
	CLHHto6iYMicV9B+C3y/MSZL/E1wHAWMQeBUo+SLKA85yeafB+loW1lRwaRrR+Xw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hqnma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 12:31:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GAptGF028713;
	Mon, 16 Mar 2026 12:31:42 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk4r0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 12:31:42 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GCVc7G60162382
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 12:31:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A30A620043;
	Mon, 16 Mar 2026 12:31:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 301B02004B;
	Mon, 16 Mar 2026 12:31:38 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 12:31:38 +0000 (GMT)
Message-ID: <0c937dbc-f484-4bc8-84c9-3ac6318ee848@linux.ibm.com>
Date: Mon, 16 Mar 2026 13:31:37 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC] KVM: s390: vsie: Avoid injecting machine check on
 signal
To: Heiko Carstens <hca@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390
 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260316103934.13368-1-borntraeger@linux.ibm.com>
 <20260316115618.17080B45-hca@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260316115618.17080B45-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4sZwYKgbQzHD7r-G3x5Rk5yV-7mmmcnA
X-Proofpoint-ORIG-GUID: 4sZwYKgbQzHD7r-G3x5Rk5yV-7mmmcnA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5MyBTYWx0ZWRfXwhqt01oTRWgJ
 nPtSuOc4v+wDefEoYvQGc6Go0f+6Apq0Y67bwPDHrHVhDhoHSL+TX2BtHEhpvhi6/93fSXIznN/
 Cn7GDXbskZEkCmk/7bwhPvYkG6W8x/1m0oqRquayMV1fhfm5ToDnFFmp3N6Bb6godk/H9CiYZDa
 dAYww2sPgVjBZF37qX0YnWD40mXG9+I70PEpQd8RY7yLzX6eJHLKYJ/6v7gZpvArKAcG0Ao16yO
 uO1mpIVg751L7wloLJRwt4SAO71R3Ww4QDcJ+KQdiHdxZ7FCdQ/r+o0x24yKEkpt9uOEfcPRtz2
 P78LKfQItbHvXLSHou3NdagniOqk7fWmR8bJPJGeDRXMpRBGo68l0DgMtsEq7CGbNAb5Ei2F01D
 O8UixhG64ikPXA4dm8M0T8GJURbhLWA0t39qGANPkUesXW65WZrkc647pD+mgYhGLmFsKNsvY/P
 AvORUMUVTnLSntG0I9A==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b7f82f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=Y8ddW9ozLV9HiWZwOf0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160093


Am 16.03.26 um 12:56 schrieb Heiko Carstens:
> On Mon, Mar 16, 2026 at 11:39:34AM +0100, Christian Borntraeger wrote:
>> The recent XFER_TO_GUEST_WORK change resulted in a situation, where the
>> vsie code would interpret a signal during work as a machine check during
>> SIE as both use the EINTR return code.
>>
>> Fixes: 2bd1337a1295e ("KVM: s390: Use generic VIRT_XFER_TO_GUEST_WORK functions")
>> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
>> ---
>>   arch/s390/kvm/vsie.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> ...
> 
>> -	if (rc == -EINTR) {
>> +	if (!skipped && rc == -EINTR) {
>>   		kvm_s390_reinject_machine_check(vcpu, &vsie_page->mcck_info);
>>   		return 0;
> 
> As far as I can tell __SF_SIE_REASON is only used for passing -EINTR in case
> of a machine check, otherwise it is unused (== zero)?
> 
> So the KVM_EXIT* codes don't work instead of -EINTR, since those are uapi, and
> there is nothing that would match a machine check anyway. However I would
> still propose to pass some unique positive number back via the stackframe
> instead of some random negative error number which means nothing.
> 
> That is: change the machine check handler to pass e.g.
> 
> #define KVM_S390_SIE_EXIT_MCCK 1
> 
> 		*((long *)(regs->gprs[15] + __SF_SIE_REASON)) = KVM_S390_SIE_EXIT_MCCK;
> 
> Which would make it much more obvious what happens, and which would also avoid
> such strange bugs.

Hnmm just send this, but I realized that the problem is in fact that the vsie code
has

                         local_irq_enable();
--->                    rc = kvm_xfer_to_guest_mode_handle_work(vcpu);
                         if (rc)
                                 goto skip_sie;
                         goto xfer_to_guest_mode_check;
                 }
                 guest_timing_enter_irqoff();
--->            rc = kvm_s390_enter_exit_sie(scb_s, vcpu->run->s.regs.gprs, sg->asce.val);
                 guest_timing_exit_irqoff();


So we also need to look at potential returns from kvm_xfer_to_guest_mode_handle_work or
actually do the split here in this function to not overload rc.


