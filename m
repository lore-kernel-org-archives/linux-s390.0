Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C631E265CC2;
	Mon, 16 Mar 2026 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662462; cv=none; b=RDA0SBhAaPihFPntJRxzLqKOlq/9zSDJ3WORdf+6OStzjZ6pCjxjI5eeQNoeCTY4rbFT7wNNVaEuI21WPm31B9f0kGwODWwkaqFr68ceKzCg43oUQ3WmbEaO+V6bGGg4+tozNC061TW4qeIc3fFnRDFfd8NbAaXIY22QWPkZMHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662462; c=relaxed/simple;
	bh=ox4bWpPZYu5Gv//Ddk0oZaa2evN3zxJfSY635ognz5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I71QgD2Um7i1B5n0anNTPq4f6xQpO0HkXyT7YU7hTYkEZemAA44lvhgP7Es9UHJh0Fo7rWzyI0zJWhp2AaMYrRGEtuLsbVmRTc8CMzgdl0YoDaWDF4C/JhuuSl7uYzzXrPWDPTn1p3txvU7AC/GDuWG/ZSH3AiqrPrSG1GpfGCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=baG1GBNi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="baG1GBNi"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FCtJT4150222;
	Mon, 16 Mar 2026 12:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=s0ZdSF
	2QoI4cCWXcUjfk7+DdqZhF6Q6/rZ4FOsx69kM=; b=baG1GBNiTcb8mJEwBHRiqf
	MI+PhCoyX1GQRfvQ+1ILBKeJ6FelH5pWbDYr5WjmJjukxNSyB+dsOQrVdngHl9hG
	8qKwvF34jGmDxXAcfcCfveWvE4H6Qxi8xD0SWqwQjWN4rdIJdFydx7H5bksh9l9d
	mPOpz4dDurt6L2zpNo6OkYXylbhROzgvJW0lMpD/kL7hZf2EatQQAGmK5qEmIPey
	7GVYXHznejIH6yisSwOIqBGyWVX0fyjOzKRSeIxG1sBQGmC8BbyvUc5gTUnBD6Kx
	p5eIYnkAJyLKgCw15l0nclvPowONrUYY+QtZWAYg/g0UfEpPKSaVV+Nol6Vf2HOA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64fqkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 12:00:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GB6XYU032327;
	Mon, 16 Mar 2026 12:00:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jmhms-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 12:00:50 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GC0ktE52363610
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 12:00:47 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DCA5920040;
	Mon, 16 Mar 2026 12:00:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83E4F2004B;
	Mon, 16 Mar 2026 12:00:46 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 12:00:46 +0000 (GMT)
Message-ID: <a56d85d6-0e2a-4fb3-ae7c-a7ce4f121fd4@linux.ibm.com>
Date: Mon, 16 Mar 2026 13:00:46 +0100
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
X-Proofpoint-ORIG-GUID: pxvx8xYm--ZvdmtcaL1GTnPKroK5iFrx
X-Proofpoint-GUID: pxvx8xYm--ZvdmtcaL1GTnPKroK5iFrx
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b7f0f3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=EfE3EK5EhESzuKWg8UQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4OSBTYWx0ZWRfX1Aj7FhWAEjFZ
 xSpRQO83ax6orvctNq6+NxKHyeOHsRMxw/crz0DgGiofAVg2z/+rfOlJTOUxoM3OpbiY6cj4OMx
 J4PVG19IiKBs/CkCa5uKI/SyvT593CSrgOmbJVc4laJdP6zQGIgkHtJk9GrPRMFr4O/KaxV2iVL
 oL+zP/3D95f7qBJKjHZeyYDWy456v1Nwg0IIj7c7CNbub9JmG2TW0R/ncAXv9Lwr8NmfOIzOtY9
 kcvxDYf2d/mbdAOLnCPiURpOo/iymeYIWGSBZGBCFSS1DyY2fp6BnvuN7iRWeq188GXGKLZFKzE
 flHdiWQs3pxsiy42guXMpt586FYhgd0AGZUh7RqHzF4ziQJWmLyJKMJbFjMFOFBn+dsQ4g08bJ4
 nkWnUZXt0vU++844M/kWTe0uoY66nD26Htlu12TyiLJRDeEF+YHJCUPzDQdZ3VkLPjJQJz5HY5e
 MNkOAce8RsGpIWVyJUg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160089

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

Yes, this was just a minimal "try to fix and get feedback" and thus an RFC. Will have
a look on your proposal.
