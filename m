Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1583737F010;
	Tue, 11 Aug 2026 18:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786473845; cv=none; b=MwMQd3yVF8fLsyj6FnEgaVSxpkRgXm70JLoyNc2c4Ll/EocAgF2ipcwFEPcV9YGajBsdFcLVPstbAGe2bRs68O5sQqIJQxT7b/jxoTtt2s3kHRdvbDTWwNlfV0mnOWpkRvA+8T4dO7u5p2hs3y3Za00XbmHOjNsrVQcyHaUw2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786473845; c=relaxed/simple;
	bh=t7LQz+NXpuUjMAQMy9r/sy8XRbnOC4NPbwuc6164idc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mNjbZT3XssdOAVQqWPry1dovCo8sY+rdB8JzBlKLNAXjpC+aezvkoSeuAKiWnvEJWwwz7owWChG9gUdQxpOkcDX60eNj7l/CT3+Oici6qVYRalweZPOaq+f5CTHQmuxGYyST7+CB3bHcTFcumeIQ5m3GYVKc1dfzVWr1ygWHpqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O7fMMoLZ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O7fMMoLZ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BGVTta889197;
	Tue, 11 Aug 2026 18:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=t7LQz+
	NXpuUjMAQMy9r/sy8XRbnOC4NPbwuc6164idc=; b=O7fMMoLZ0ZYl/oGbsLUI7t
	D+6Bn0e8PXravfrIwKlqRfw8R3GupUtVqMtFSRH8schSvfFvU0VUkRu6Y33QhU5n
	cE0cR5wWYt6B0GDyTRdo7deTQYDX2VfZCsNHgagk+XTyBK24g8SQDJV4mzGDuDtd
	gqPI+Hb/KRIa2SaVLFGDOToNirw06nbi64JrVR3qUWTz1j3yube0d73CypPp0Rt/
	GJsShhDVTdXtS/fKvYonSsxmyCZaEXgI4L/U1UMFYnCfpQh4Uhqpx0cWs5ly5UhD
	JQc979sZSMmTYZYg/ZXsju5LfiKGskogycbeSp2MJ3tSTd0ZX4ZII5G7bFn3D1ag
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9egjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:43:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BIfGCe024444;
	Tue, 11 Aug 2026 18:43:34 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w2cyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 18:43:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BIhXda47055160
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 18:43:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 296C358052;
	Tue, 11 Aug 2026 18:43:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2567558056;
	Tue, 11 Aug 2026 18:43:32 +0000 (GMT)
Received: from [9.61.58.252] (unknown [9.61.58.252])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Aug 2026 18:43:32 +0000 (GMT)
Message-ID: <6bdacd0c-572e-405a-a378-663f13edc154@linux.ibm.com>
Date: Tue, 11 Aug 2026 14:43:31 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] s390/vfio-ap: Fix required lock not held during
 display of sysfs status attribute
To: Matthew Rosato <mjrosato@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        stable@vger.kernel.org
References: <20260810192257.1208410-1-akrowiak@linux.ibm.com>
 <20260810192257.1208410-8-akrowiak@linux.ibm.com>
 <5d755e25-be9d-4227-b06c-63563fcce0b5@linux.ibm.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <5d755e25-be9d-4227-b06c-63563fcce0b5@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5dK9bfIx5FEzaNtlF8kZDiQd0Gm7QmEw
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7b6d58 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=8gt7DvUvnbPXcpqzDXYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfX+oYbvsoOjRea
 bPFtkg+13P3p3siufY6vRQTC2MWuBsYaXMXHYKKk5zl5F50DSL6bt0ok6kUI3fJZCCr2Jh+2xQK
 p/ycct9mnBwSFqXZ8HP6iaZe8vyok06chIq37pzOkTWJnKZCGxxsL1mXt3hHoChG56d6k/RJdsM
 8xPiDhRfmw1fGwb+xtiKxZR/UjaCfx48MtDXZQTdY3AcyoFWfwR6zUlrKl4dGU7UJ6m/4S7ABfj
 hSU1T0qXl42ItDhtWFe1pfvo1vG7PZjJUFjPvr9H240FlI2b33jzw965HKcinP5Ip3VY1z0qJ9R
 MFOIkhL6sx3JU0GlGrhSnFkn4/X8LNRazJnVxl2ou9h0nw821Mw859Ecp0b6X8OazfMriHiveSM
 BlAP3YfsK81XqMOnWEq2mcVncR5etzWIt2YfDaheqcTfyJ/0n9r/J5MKySvgZWpTLcPtsvp5pFd
 9iX9NGy+XS9XMcD30LQ==
X-Proofpoint-ORIG-GUID: 5dK9bfIx5FEzaNtlF8kZDiQd0Gm7QmEw
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NSBTYWx0ZWRfXzgScLTJlGGLO
 ftHAlQ8OfQoj1cTfpFllx3yJWaZFp+azpBIyovFpAHd0A5KWYEDLmbN7bUYQhLKuIRNhByc7gqx
 MCaHRwIbDFcKqEfKVmy4ZMpL04g84R0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110155



On 8/11/26 2:03 PM, Matthew Rosato wrote:
> On 8/10/26 3:22 PM, Anthony Krowiak wrote:
>> The status_show function that supports display of the status attribute of
>> the devices in /sys/bus/ap/devices calls the vfio_ap_mdev_for_queue
>> function which iterates the matrix_dev->mdev_list to find the object
>> representing the queue device whose status is to be displayed. In order to
>> traverse this list, the matrix_dev->guests_lock mutex must be held which is
>> not the case.
>>
>> To fix this, the guests_lock mutex is taken prior to taking the
>> matrix_dev->mdevs_lock mutex in the status_show function. It is taken
>> there rather than the vfio_ap_mdev_for_queue function - where it is
>> needed - because it must be taken prior to the mdevs_lock mutex in order to
>> adhere to the proper locking order and prevent a lockdep splat; also
>> because the mdevs_lock is needed there to access fields within
>> the matrix_mdev object in that function.
>>
>> Fixes: f139862b92cf ("s390/vfio-ap: add status attribute to AP queue device's sysfs dir")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> Please see my comment on patch 3.

See my response to your comment on patch 3:)


