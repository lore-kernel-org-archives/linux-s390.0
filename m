Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96B239282F;
	Mon, 16 Mar 2026 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662191; cv=none; b=GKeFm3CPKGkA9nz0MVvHPhTj4YNCeooeWcA/ANu1HTTj7s7imzKHHkVvYnwcFzfipW2BKGU5rx4SGe4+CgJKMbqGNwdr5/AzXHOIzBnQMlcCtaQq/kLo9MuGfkA88/nrcrpL+t7h0MhXNMTRPOB/wRHHkJQA75IjC3+r4d/1t2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662191; c=relaxed/simple;
	bh=v+FGNGnOXfL/yITFl97Q2NXUmtPRWDiqgeNkakkFsvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIYgJEHT8vdGsMqId++VwtYOwHsMa1cxGoE8XWAKPL2++yVF/Wtvhp6b2JXjMlLcYeebHrmErYIk3U2MO3zpN50MbWTEXqgmOl+sILmWxSsTqghzaiLga/ePDQWJd+aKVpixrtvYXJg2E26+zLNDsYjHKBCkLxKfCLowqsL+nro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gy/qGID+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gy/qGID+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GABFwT3402882;
	Mon, 16 Mar 2026 11:56:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=J3afw7jbhCThzn3i/LjsCSqTnEVwDB
	sC8JbjGT1lEts=; b=Gy/qGID+oPk45U63InJma0V5LFH8rXZjIJLeylz9TVnQlT
	gh6WREHvNm1v5evHIs3V04q/oo7PXXEJ+vVKGOs4C3MvNU3QAxb5d8Uht3rVYJb5
	8vABVNKEanFjIA84WnQJK5FoJHU/7Vvfpa6XhTbA1YIzYpdtzxDtImUHh5NDRX1L
	y8YOeVBxcdKkwNXLFckRuHKd894o9RG/Bjg1FgeGgcThBkbZPzYrFbSleIev7m/i
	JH1YvfS4beH0Kt1EOsS1nRXY5VF5u1Z72+KsFON9yjtNBgmraZn3H0AOjQ4o2178
	myN9Aclh38fyok6seNF15PSf3waEtukArU2/AYTA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyau7986-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 11:56:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GBO9nA032404;
	Mon, 16 Mar 2026 11:56:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7jmh44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 11:56:24 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GBuKxD30212538
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 11:56:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D90C2004D;
	Mon, 16 Mar 2026 11:56:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C77C720049;
	Mon, 16 Mar 2026 11:56:19 +0000 (GMT)
Received: from osiris (unknown [9.87.141.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 16 Mar 2026 11:56:19 +0000 (GMT)
Date: Mon, 16 Mar 2026 12:56:18 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH/RFC] KVM: s390: vsie: Avoid injecting machine check on
 signal
Message-ID: <20260316115618.17080B45-hca@linux.ibm.com>
References: <20260316103934.13368-1-borntraeger@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316103934.13368-1-borntraeger@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4OSBTYWx0ZWRfX1M1Xw+wlKZww
 1CniPRBXLds4GYmwAxyCLiegN1f7XiKiXFpSVMMAoMZ6z5IUELVlnu53no/GIida1cFkWf1vQxB
 Sl4NWc0MIu4vwJJTYwz3a03aiOiXR0ikghaKvA+4KCrQdzGLo0s8dVTSfN91DLc/jveKgaUu4oH
 SLiv43vgrDTJoN6kP+BR+MniuuO2ek4A21LvuVoeXX0fjaJyRblpDZT7GcvPArM8xjkUCTeScak
 qC7WSCICGOC34v06beDo1FTTnpb6n+OZABxdrT05v9qzzvqDKwEX9KZIOQ3Ax/pbwf3hTRSPruh
 NV5tb+W6VKXdih0iKx3obYASlVcW8m3hoKnTZGO1qff0fF+fwXLH6iz3Slpi9zYxvXgCirYSt4G
 hgPk99XDC5a8Oma9lS76OVJxV/c8wZh89CqE5Js/SWeD5xFuVif4XwZNHSOeZeYryM6WKPoBKwM
 ZKNv/H+lUOx0PPdZOKA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b7efe9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=v_eQMfJJpqUdI5PqWLMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: UxzKBkraGr6uDmCj981DFaQ8RI0g8PwR
X-Proofpoint-GUID: UxzKBkraGr6uDmCj981DFaQ8RI0g8PwR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160089

On Mon, Mar 16, 2026 at 11:39:34AM +0100, Christian Borntraeger wrote:
> The recent XFER_TO_GUEST_WORK change resulted in a situation, where the
> vsie code would interpret a signal during work as a machine check during
> SIE as both use the EINTR return code.
> 
> Fixes: 2bd1337a1295e ("KVM: s390: Use generic VIRT_XFER_TO_GUEST_WORK functions")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
>  arch/s390/kvm/vsie.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

...

> -	if (rc == -EINTR) {
> +	if (!skipped && rc == -EINTR) {
>  		kvm_s390_reinject_machine_check(vcpu, &vsie_page->mcck_info);
>  		return 0;

As far as I can tell __SF_SIE_REASON is only used for passing -EINTR in case
of a machine check, otherwise it is unused (== zero)?

So the KVM_EXIT* codes don't work instead of -EINTR, since those are uapi, and
there is nothing that would match a machine check anyway. However I would
still propose to pass some unique positive number back via the stackframe
instead of some random negative error number which means nothing.

That is: change the machine check handler to pass e.g.

#define KVM_S390_SIE_EXIT_MCCK 1

		*((long *)(regs->gprs[15] + __SF_SIE_REASON)) = KVM_S390_SIE_EXIT_MCCK;

Which would make it much more obvious what happens, and which would also avoid
such strange bugs.

Just my 0.02.
