Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9799839E178;
	Thu, 16 Apr 2026 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776335079; cv=none; b=LRBNQS4y/7qMO/k6qWX3c1r374eZptjlabqcEQvpH/eNu8M7GsKtYaYPm9yvr5bcffaHBbcFD944AbU2GeNgMII8zQLH9N4nG5cDPaAvZvaNtErpvwM30BSXbNblFpuvwNFNiJFrvXnC6M3o7LfSffGhSqL/che4KetxhxL2DGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776335079; c=relaxed/simple;
	bh=K0s6VDdJp73R3JU53NEaANR/704aQmQ63FW+199HHJg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=HUFZQNgxG21t9gYXgzKRaGO0Lbnh84FHCNh68NhdJbLxE2KIu1NxkmCY7hqFiz3NDbJnOoxfR4S3iAcm867Wl18qRMkuBDKH2P5shRNiSB3WjYVO7vZKXGoUKFVflIuf5Zt60EFnARgC+eD17EqBs41lQL2q28V3bNy5+aX1JVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KmN+L4jv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KmN+L4jv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G5gjfS1602772;
	Thu, 16 Apr 2026 10:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UgqI22
	nP91mbgyVNKWo1zsENpcPnH6yqo0FFc/vRcWw=; b=KmN+L4jvCeK2gaV2f4fY1K
	zb6iDWDcI9aozqNd9YqPjQP1sUU6Jd75lu6MRK6Sd3b8krS2JCiEs039Xgk7MRBZ
	YDF3obWQyAaCZIppfETRoRfpvbjzv2m9cOW4nYG3LSqCwxVsFvKwrA3P6tX7l2ZK
	XrQ020aYIIPMIu5LgwwuqeWwQ7TuFxX7cqcGkAR+HGvItKyweCk+O9bJs4TLw++n
	ZviRR9yhcyUEKTyQ6KcQye/+XuzZxbmWiT6Rv5DHrhVvjvfNngsk3im9MwBkRmUs
	E1XuDNxb+kKT9WbEw7PWJ5/QpNBHrrttH5iia3gMvfntGC738nthIiSJk1JeZMXA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89nmvuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 10:24:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63G7nlEN003305;
	Thu, 16 Apr 2026 10:24:35 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh940ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 10:24:35 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GAOVED31130210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 10:24:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CB6120043;
	Thu, 16 Apr 2026 10:24:31 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AE702004B;
	Thu, 16 Apr 2026 10:24:30 +0000 (GMT)
Received: from t14-nrb (unknown [9.111.37.231])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 10:24:30 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 12:24:29 +0200
Message-Id: <DHUI89JRQHI5.1VWXLD3VX2JUI@linux.ibm.com>
Cc: <linux-s390@vger.kernel.org>, <imbrenda@linux.ibm.com>,
        <borntraeger@linux.ibm.com>
Subject: Re: [kvm-unit-tests 3/5] lib: s390x: sie: Free guest memory on
 destroy
From: "Nico Boehr" <nrb@linux.ibm.com>
To: "Janosch Frank" <frankja@linux.ibm.com>, "Nico Boehr"
 <nrb@linux.ibm.com>,
        <kvm@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260415085145.91197-1-frankja@linux.ibm.com>
 <20260415085145.91197-4-frankja@linux.ibm.com>
 <DHTSMVSISIZM.3MS0YLDBLMB09@linux.ibm.com>
 <624c8a3f-2a09-4257-9b0c-2b64e60e52a1@linux.ibm.com>
In-Reply-To: <624c8a3f-2a09-4257-9b0c-2b64e60e52a1@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n95IhM4DC-sSfdpEpiHstu9ztukyc_0A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDA5NyBTYWx0ZWRfXzVHZQH+ccvoX
 aQq0gz8icUKeZhtENHmeJqBEyxUdgs41cFhaN+ISzjNjvqQNg3LzPWTHjwI1LrEVoVfwpwsHgJA
 90bCTnUHLodY1BZsDWuSsrusP6MafI32DcZBWxCU3cEKOO7BfIAoDLWVra6uS01Ozx5i23FKxqQ
 VE2CUwMN4uGMLwi06edNvKobhaLdaItCgBEG0sA5zDWuxm9dMFut+kA/Os7iV4WBGz8+cVH8jFu
 ORB1M2ZMnEa+Gu7pL1hZamEjRnH79bbs3w+iYEQ7I4S0p5lrPXidybMh7Tve0j4Lr3VYshFVUEZ
 38u4NhIOy6y80QpHIcfDxLFj+Tq4B1CiKKMjVtmbnBesGsyEJMlqLO1u1s317smv79iJGkCJSeD
 /+n9HaXs+J2sA5bZB7avGrRmd31jS9X3mFJxGrdWXyCAvpqZUTuMJKHk7lM3hGBhvT+IdgETHg1
 H1WyAHAuCMMLq6Iyb/A==
X-Proofpoint-ORIG-GUID: n95IhM4DC-sSfdpEpiHstu9ztukyc_0A
X-Authority-Analysis: v=2.4 cv=FY4HAp+6 c=1 sm=1 tr=0 ts=69e0b8e4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VlMMnRzqynEzNeI3tdkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_02,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160097

On Thu Apr 16, 2026 at 10:03 AM CEST, Janosch Frank wrote:
> On 4/15/26 16:21, Nico Boehr wrote:
>> On Wed Apr 15, 2026 at 10:45 AM CEST, Janosch Frank wrote:
>>> We never freed the memory that the sie library allocates as the guest
>>> ram on destruction of the VM. Most tests reuse the VM or just leak the
>>> memory since the standard allocation is one megabyte and tests only
>>> use single digit numbers of VMs.
>>>
>>> It's time to add automatic freeing to the sie library when a VM is
>>> destroyed.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>   lib/s390x/sie.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
>>> index a49c45c7..758ead77 100644
>>> --- a/lib/s390x/sie.c
>>> +++ b/lib/s390x/sie.c
>>> @@ -192,4 +192,5 @@ void sie_guest_destroy(struct vm *vm)
>>>   	free_page(vm->sblk);
>>>   	if (vm->sblk->ecb2 & ECB2_ESCA)
>>>   		free_page(vm->sca);
>>> +	free_pages((void *)virt_to_pte_phys(get_page_root(), vm->guest_mem));
>>>   }
>>=20
>> Is there a particular reason why we have a two-step process of calling
>> sie_guest_alloc() for memory allocation
>> and then
>> sie_guest_create() for initializing the sie_block etc
>>=20
>> but
>> sie_guest_destroy()
>> cleans up both?
>>=20
>
> Historical reasons I guess.
> There've been a lot of changes to the SIE lib over the years, snippet=20
> support itself isn't that consistent but it's currently good enough.
> s390x/sie.c is the only direct user of the allocation and even that=20
> usage looks like it could be converted.

Yeah, I am a bit concerned about the intermixed dependencies and concerns
between the two. Especially having free_pages() here even when the guest ma=
y
(theoretically) have been allocated with something other than sie_guest_all=
oc().
It would be an error that's kind of hard to spot in a review since it's not
obvious that sie_guest_destroy() pairs with sie_guest_alloc() AND
sie_guest_create().

Would this be an option:
- add small function sie_guest_free() which frees only guest memory to sie =
lib
  this would be the counterpart to sie_guest_alloc()
- add function snippet_destroy_guest()
  which calls sie_guest_destroy() and sie_guest_free()
  this would be the counterpart to snippet_setup_guest()

Then this pairs nicely as follows for the SIE lib:
sie_guest_alloc() - sie_guest_free()
sie_guest_create() - sie_guest_destroy()

And the higher level snippet operations:
snippet_setup_guest() - snippet_destroy_guest()
