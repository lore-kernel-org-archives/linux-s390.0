Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792591967;
	b=ZJomfP5g7BmChULmJKEPZJWL6C7WfpiFVl7KksicpcXvJEfmwCgdfkqi2BofBD0EOsiP
	 6pAeTpp3bSxvBUj/66RyHvnXCkEIT1J347wcQjlKYwSmwIBO7/Ict/2RjtK/kGHP7l8j3
	 gOvjOIGQXVUMhlbHVHUDe27TPjR2RM7h9PC0TJX+5A5yuIWzTc5cjyXBIuq0yPPKFzX1Y
	 w9JF0ZIfhqO9sYipVQWPpZXMEBr5FFHuN0md6QH4u1tjC53DWrBaJDxM4scainn9ZJuhn
	 iALlLrCOwCkry4ouBTNS/GEEiu0SITsfkzK2DenHkHeDVIo0iPuIa3raWfMi/gPn81g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792591967;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=n59qWlIxs7y37IelBhq2ntyzZue83vbhd7EcjKnkdc4=;
	b=kvEbrVuNmI24DGY5aojvpogJWorW78i+rVrz/N8eP+8sv/woJ/Ht7vVBkQF0mpjuO8DM
	 5AldbAqZ5xcRSDD93o95peD8cDZohZHTA7irqnlJ/8Qmf6Xo0+4AJ0bJFGnzMdDlPj/aY
	 u16j+N0600HKSAb+4llDvkEb19hg9iqIPm77Ig0NEhbrff/N/PxodIVqvP6PB7sHlHYD0
	 nctrJTVYYtbdu17hIQ9ro6W/ZC3AOxjcz4AF5yyEMLAbZmufq935Qzm0aj1CWnLyhnQdT
	 iw+h9CsONfA9wj1wWrO2kLU8r5iVoRyHeTJ8TKaVCPE5Cp1psmyzLOKnnbZYYtvfkPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LpHqN9OP;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF58606A31E
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 14:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CF58606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=LpHqN9OP
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBiaJK1092571
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 14:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=n59qWl
	Ixs7y37IelBhq2ntyzZue83vbhd7EcjKnkdc4=; b=LpHqN9OP/3BpVp92+r58KJ
	MwgCFN9DKIrPdiick8KrjMACu7Ks8bYbKSTKAlyeZRALzCe3DiQJUDurwcZWO4tr
	ZsSL+fsks3X1cRO4KhIw7b2ttstBYdsHHE9aLEckUZuclPSDA2vdTU5FjeQdpPeU
	KLMx1cMIUR057eLSAu8pGXlJW3h8nf3P1xb5p0CGPzx53XIG8bhr1KKKhdLgBZuE
	dD9hftXACzO2XX+j85uzBYgao302QzJPF4Zrp/nlym0VscDkhDenOuozW1E3wHLA
	kA3GLEYDIJkMJw7bL+HmBexPYJZgxKpZ19QzGh4uQusiDiNLqKGivN1uCjocXsHQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw5a17gv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 14:12:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69LBnvaj2998793
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 14:12:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bs5hsk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 14:12:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69LECepl51773806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2026 14:12:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A72320049;
	Wed, 21 Oct 2026 14:12:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DE6220040;
	Wed, 21 Oct 2026 14:12:40 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Oct 2026 14:12:40 +0000 (GMT)
Message-ID: <64aee74d-a628-436a-8155-48fc3cf41a56@linux.ibm.com>
Date: Wed, 21 Oct 2026 16:12:39 +0200
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
Subject: Re: [PATCH 3/3] s390/diag: Add diag204 IOCTL to diag misc device
To: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>, linux-s390@vger.kernel.org
References: <20261021-diag204ioctl-v1-0-25645b97bf4e@linux.ibm.com>
 <20261021-diag204ioctl-v1-3-25645b97bf4e@linux.ibm.com>
 <atjFxOoK4GbbfZmh@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <atjFxOoK4GbbfZmh@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA1NCBTYWx0ZWRfX/6+wjt8x/heF
 h9erb8WjH2+4m/NIqzHhEfQDGIO4cUAQCK2NxqlVJYMqju2xZgyvdgIIGqHa2+SA6QvX4wYAa/H
 /I7XVuJynW7+yt/CtL2bTARrc1bUBxAvfX6WSGOD+YV+9KLAvP70lDrhtRLW/K6YwL8h1+IoOTd
 iPhWUPltgrAMBs1h2pq8YqnZnXGLIYZ60OFEPuHVnipaJZXRyf3CnINuKHWLIKI163s4SEnWqqw
 WtFkWhuGcNjixbKkwlhghVpzx19QGjioRGTQEWW4lmI7tC5TUdALb5YFqY25ZmVqnvDpawjHfBR
 H1yoSMS4iny/BPxgv13/A6Pz7PHvUG/1qOtnGirtgpcNpJyVql9DmbeCxtPm3eBzaiWGfHIdzoi
 UVrUH/bhaGJcMK8rwsuCZnYdMgPgj3I12Nl3Px14Y+jhaZxrsa1ovJj+nweiEkym7a98/ksf+9o
 aBjdakS2ZU0xFsNIXaQ==
X-Proofpoint-ORIG-GUID: Pt2L0Ct44pzdAP_qot4X2Tst3v7y6bVS
X-Proofpoint-GUID: Pt2L0Ct44pzdAP_qot4X2Tst3v7y6bVS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA1NCBTYWx0ZWRfX1QtIPnQD/16a
 cNnnMEqu2NW6xoSScTlkFHVkX3eWycyuJIYUT6OCjZ3A1tFnPzhjrmzUloV+TV/JW/tfq2oBo+i
 XCINQEBkQ9bWSUn9Q23s+9Z+gKJj35Q=
X-Authority-Analysis: v=2.4 cv=ZfSIpcVA c=1 sm=1 tr=0 ts=6ad8c85c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=V5kmTLyOG0YdflYEcagA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_03,2026-10-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210054

On 21/10/2026 16:01, Hendrik Brueckner wrote:
> On Wed, Oct 21, 2026 at 12:28:10PM +0200, Mete Durlu wrote:
>> Add IOCTL implementation necessary to fetch diag204 data from the new
>> diag misc device under /dev.
>>
>> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
>> ---
>>   arch/s390/include/uapi/asm/diag.h  |  8 +++++++
>>   arch/s390/kernel/diag/diag204.c    | 43 ++++++++++++++++++++++++++++++++++++++
>>   arch/s390/kernel/diag/diag_ioctl.h |  3 +++
>>   arch/s390/kernel/diag/diag_misc.c  | 10 +++++++++
>>   4 files changed, 64 insertions(+)
> 
> [...]
> 
>> index efffe02ea02e..ac263baf8d08 100644
>> --- a/arch/s390/kernel/diag/diag_misc.c
>> +++ b/arch/s390/kernel/diag/diag_misc.c
>> @@ -35,6 +35,16 @@ static long diag_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>>   	case DIAG310_GET_MEMTOPBUF:
>>   		rc = diag310_memtop_buf(arg);
>>   		break;
>> +	case DIAG204_GET_LEN:
>> +		rc = -EPERM;
>> +		if (capable(CAP_SYS_ADMIN))
>> +			rc = diag204_len(arg);
>> +		break;
>> +	case DIAG204_GET_BUF:
>> +		rc = -EPERM;
>> +		if (capable(CAP_SYS_ADMIN))
> 
> Why do you restrict this to sys_admin cap? I think that access control could
> be better managed through mode and ownership of the /dev/diag device.

I don't know about other diag codes and I wanted to just preserve the
current authorization level for diag204. If you think the /dev/diag
ownership is a better solution, I wouldn't go against it.

> Assuming that I like to run a service collecting information from diag204
> would require to run with sys_admin capability (almost root authority).
> 
> On a /dev/diag, allowing root and group to access the device would allow
> a service to run with regular and respective group privileges to access it
> (w/o cap sys admin).
> 
> We should revisit the device .mode = 0444 setting and prefer using
> 0440 to prohibit other users and restricting access to root/group ownership
> only.
> 
Sounds like a separate one liner patch involving just
arch/s390/kernel/diag/diag_misc.c
