Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C752E611E;
	Thu, 23 Apr 2026 04:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776920196; cv=none; b=KcHt9oQ+VgnJLFtl3Ev/QjG9wmjshAyxSq44q2n6xWEwcIwD4b+YEx8rr9Eqv2NglnML9lQZlGE/Ck+ApLZECmfVesAT+g1RdXoYZ4wtWJ0Ie1qP4gLF0STJCYddT2bBi7JUX2dHreNPLgt3pu5NOcKX9CdGxa6pp517j+qdSGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776920196; c=relaxed/simple;
	bh=S8e2CCUKDSrQQ8TIU8nsFAaFbZS9LQff4LEMVdIEKFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPcKgUkzfvdFx0MzvOQ//imRRXryjkemekKZNJ5pCByT/RNDXbzL5nF0Ma0gU9ELxyo55OSzoLSpPLO8tQbDzH+t/y0kJdVeWauhwHLWK5wyZtVgoXNqTmh2j7ZIJMPVUjnVilRvpeU55dmqiaN8B+cfaCBUZpgBl6AmvQPHOr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d4Um5M7K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d4Um5M7K"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63MGMGZj3107479;
	Thu, 23 Apr 2026 04:56:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=DDTk5m
	Z/P+v5/S3ffqlDqR5dglZUsRQ1RGJ8ip7xxok=; b=d4Um5M7Ku7xGcofO50DEWu
	gbppZKtLQPjhctsLj4hVQveB0TN5aA077g2OyZSv82UP49wsZlzHOpDyJV81xFXZ
	h+8xTWjnjBLoEzMEAAvYncQECCOGpUOKeOAWW4Jg0qQiGyzS0cS1UTHBMokWEDBU
	Qfr8JhlYF0is/cQBTfrwLAsEMQht1ZSi0mwY33/Ez2gX5PNAC+TDPB0SKW/fBDr/
	23wmaBtduqE8JFW7QbsvmFldi5c9++I0jT8YQsqTMaKkGP37GoX2nEgiidxwSPza
	6NzhZzBoPTjAIzyfYywbEMqnx8Dcb0TP/xe8zjT3dVDxjynorjc/ewF8BskiROZQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu6efe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 04:56:33 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63N4oKkH015581;
	Thu, 23 Apr 2026 04:56:33 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjky571x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 04:56:32 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63N4uTCs62456104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 04:56:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5E9F20049;
	Thu, 23 Apr 2026 04:56:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1899220040;
	Thu, 23 Apr 2026 04:56:28 +0000 (GMT)
Received: from [9.111.33.71] (unknown [9.111.33.71])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 23 Apr 2026 04:56:27 +0000 (GMT)
Message-ID: <24cbf2f9-1eab-4d67-99df-8b9b9109d4c2@linux.ibm.com>
Date: Thu, 23 Apr 2026 06:56:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] KVM: s390: move some facilities from
 FACILITIES_KVM_CPUMODEL to FACILITIES_KVM
To: KVM <kvm@vger.kernel.org>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390
 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20260401134254.259873-1-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260401134254.259873-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDA0MiBTYWx0ZWRfXx/S+2LyArb+8
 fyFeLLtiCG+xKjSJuk0KRGYZRX+6maJW3VncE4Pyp7W7uo2sihESLawRi0xd/Szd7KKK3YTduz0
 fq9w/CkbdjOr32dnSF57kqSV/GcU07o52Cr7WxJINK3yU8SKfMNiTjGle/NlrpPip4ujqS1EJcf
 GQdvZRCbLrzf1jNyJEf0znySTaLJxpP2oAijjsDwD8vtn/SWPMN6T+YyTvpGqMBBXTCOmBSmOw0
 DvxmSuTVxcJjXKVYdHebAx+f8n8a4gytiKELU2IfzFwGMJtsfDozYIs6Lo/X/3e32blYPjgCfzE
 3gQckgOFtCE3gd2AH8AzPPaMkqJrjrO4DcuYxkDdoRGxUUo9w73DWnwTLxrv7jOu8mK9rlEYIEZ
 z2ruBE5ejM75Bevp0QogdEHcWvhbAQ4D3croQX9LPieeOvgAET0Z2Na2NPo5hmr0jGbWS03pmIv
 dy6StHDIxd9WkifNx7w==
X-Proofpoint-ORIG-GUID: 20LQGrbGKsyiYswN42f1Bm4AXWvHw1v3
X-Proofpoint-GUID: 20LQGrbGKsyiYswN42f1Bm4AXWvHw1v3
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69e9a681 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=VcpiW9fZVuxtVhdJ86kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604230042

Am 01.04.26 um 15:42 schrieb Christian Borntraeger:
> Some facilities have been put into FACILITIES_KVM_CPUMODEL to be on the
> safe side with older VMMs. Unfortunately this has some unwanted side
> effects for VMMs without a CPU model (like kvm unit test) and IBC/VAL is
> not used in that case.
> 
> Ideally the guest visible STFLE bits, the behaviour when running
> interpreted (HW supported) and the behaviour when running emulated (kvm
> or qemu) should be in sync.
> 
> For LPSWEY this was not the case. STFLE.193 was off, but interpretion
> did work, emulation did not. As emulation only happened in rare cases
> (e.g. deliver a machine check) the result was inconsistency for the
> guest.
> Move beareh to FACILITIES_KVM to fix the inconsistency.
> 
> NNPA (facility 165) has no fencing and no KVM emulation. The instruction
> will work, despite STFLE.165 being off in the guest. Move also to
> FACILITIES_KVM.
> 
> Facility 170 (ineffective-nonconstrained-transaction facility) is an
> anti facility and should be passed along as well as KVM cannot simulate
> the missing function.
> 
> KVM also does not implement trapping for guest RDP and there is no
> additional hypervisor control. Move 194 to FACILITIES_KVM as well.
> 
> Facilities 196 and 197 (PAI) also do not have a hypervisor control and
> need to be passed on as well.
> 
> The PFCR is also not intercepted by KVM and needs to be moved (stfle.201).
> 
> The other facilities are fine (stfle, emulation, interpretion in sync):
> Both AP related features (12 and 15) require a userspace added AP via vfio.
> 156 etoken facility is fenced off for interpretion via ECD_ETOKENF so
> everything is in sync
> 
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Hendrik Brueckner <brueckner@linux.ibm.com>
> Cc: Janosch Frank <frankja@linux.ibm.com>
> ---
>   arch/s390/tools/gen_facilities.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

applied.

