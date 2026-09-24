Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCAD47143D;
	Thu, 24 Sep 2026 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790249554; cv=none; b=CeMG3lm8d+JYDip+LGyK2dEy9o+71W2FikwEorfXOzA7qagjThhNSVEyxkeFVkZeRY0O4PYQhka0sTZ7q88amaIiB3gPfZ62wr6gryzvMPq6NLgPgq4lSDqGw/dMkytemOaL/LtKy7bGJ53Ann4fOIdmP6ECRXPN2kkOiuP7oQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790249554; c=relaxed/simple;
	bh=UjE3VK3mwNMPeS6UwemiwW2OZK9FhUpbf7clt4mI3p8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Cc:To:Subject:
	 References:In-Reply-To; b=JLRMtkXxulkmnZKFwN+dtfhqT2G4FC4kdbW75iIMgKrlANKh1+AeV4lJ88nIY1dlaFgYzoFdckjz5+yvGpwJpXf/vlIKhQjWauUoDoFYp/dYFjx8C9fq2e18kEHba0c6+flLLta7H7lrGJhhZH2jQIh7uvX/EqOdoVLjfQz+ovk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ORVzJNZY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ORVzJNZY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68O5brrH1179979;
	Thu, 24 Sep 2026 11:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vvrvEB
	P7yRHGEHdwu1SXSug+UxCecF+8PDKLe2ytAfg=; b=ORVzJNZYeu8MnSl/dCLpqL
	mT8XoDx6Z2tmwL8BzonPq+6vk+cWdQMNfOTxt14cP/oGzZJll11+/CrWQvAynAc9
	w7hnplvNYouoL3HVwPvGsoaHzvzXxaYfwNhPSxYDAjVI2xkll3gSt+Wc9aIxq9Hj
	EtatkC5xmVTwFZFaQz37sSFfq7vp6cAa97yFcR1dYg1MwhRMSB+pD3SK/qWn/y8h
	sAUu8ds2zi9fPz7NCJskK/zK+GxsYpVUssd98mVUgSK9FMpXu2qbCt1Rcp+tS/Ux
	isMjIN1uAK/MstnlsMDlOgLSqkMtuBuOnVb+bloRc3VSnWSRD6pdZT22EnFrDlew
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1r1uv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 11:32:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OA57UN212369;
	Thu, 24 Sep 2026 11:32:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7e9ng7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 11:32:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OBWH9A41484794
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 11:32:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6864920043;
	Thu, 24 Sep 2026 11:32:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5153B20040;
	Thu, 24 Sep 2026 11:32:17 +0000 (GMT)
Received: from darkmoore (unknown [9.224.78.25])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 11:32:17 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 24 Sep 2026 13:32:12 +0200
Message-Id: <DLNIHTBTMVCN.63H29I8Y56E2@linux.ibm.com>
From: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>,
        "Christian Borntraeger"
 <borntraeger@linux.ibm.com>,
        "Claudio Imbrenda" <imbrenda@linux.ibm.com>,
        "David Hildenbrand" <david@kernel.org>,
        "Eric Farman"
 <farman@linux.ibm.com>,
        "Heiko Carstens" <hca@linux.ibm.com>,
        "Nico Boehr"
 <nrb@linux.ibm.com>,
        "Sven Schnelle" <svens@linux.ibm.com>,
        "Vasily Gorbik"
 <gor@linux.ibm.com>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        "Shuah Khan"
 <shuah@kernel.org>,
        "Sean Christopherson" <seanjc@google.com>
To: "Janosch Frank" <frankja@linux.ibm.com>,
        "Christoph Schlameuss"
 <schlameuss@linux.ibm.com>,
        <kvm@vger.kernel.org>, <linux-s390@vger.kernel.org>
Subject: Re: [PATCH v7 08/21] KVM: s390: vsie: Create helpers to alloc and
 free vsie_pages
X-Mailer: aerc 0.22.0
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-8-f39806eaae37@linux.ibm.com>
 <14552c47-8b20-41a6-a194-5aee626251de@linux.ibm.com>
In-Reply-To: <14552c47-8b20-41a6-a194-5aee626251de@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FHRKVITGtxA2GqPvyf20-RfGb_IYiDgt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX2gBirj7eSXMH
 8BFP4xouQ86Id1rlmhAVjwubIcglUX9xMySs3KSk0xn1wdwA1qvJcIR3qP/uHwnam71gRqyheW2
 tNS9IlAq61GFTWhTDTHT7ojyDzCFD+xIWCfGwvBJWHE/boCG0JIiMAwhiyrlFeSYTEEjdKIxagP
 xjRBSxLrKrPfGgfYMMjUC5zJSruAHqo979C+tGGAbzI5C/zQoIT8eiomZ7paV165++6ZJ5CjsbN
 lQDu7m73bAeaQ4S4yS7Lirb/u4GZM7X1VCjxMX70hbkKmoW3DB6d/XZYDBQlvyZ1torg3E+TR1N
 jx8gPIMwQyD5EFJSq6dMeEXPjoUfG/fgnlyTCBns4i7CejLQSJNCsM5TjtD4/uFGhADpG04j2LE
 iGaG48wzCn9rTSK7ybdgiiZPTxqZvCAulhcpwvzRX/eAuslRdvfT6AHxaTQTK3OTc5lkB6eOW+7
 Gg4A0CpLFo6qg3mADMA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab50a46 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=txTgCb6B7qFG2BPPUQIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA0NiBTYWx0ZWRfX9DH3+Kj6bSlt
 wcEo7GVaWGuWmysFDtpKoKYgaEhGoAWWL7yY6jRFe0mSl7oa/Wca3aktvjK/Vp2FNhHT22jBIRQ
 bOA2VNgMd1Hjl1c8Aliw2OHZPQSnfzM=
X-Proofpoint-GUID: TIc-0JM8Vq8rUlY02IH_u476Vi9W2Hfr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240046

On Wed Sep 23, 2026 at 1:54 PM CEST, Janosch Frank wrote:
> On 9/18/26 5:09 PM, Christoph Schlameuss wrote:
>> Encapsulate allocation of struct vsie_page and free into its own methods
>> to allow this from multiple code paths.
>>=20
>> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
>> ---
>>   arch/s390/kvm/s390/vsie.c | 26 ++++++++++++++++++++++----
>>   1 file changed, 22 insertions(+), 4 deletions(-)
>>=20
>> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
>> index afc2e56fcabf..e7005bade757 100644
>> --- a/arch/s390/kvm/s390/vsie.c
>> +++ b/arch/s390/kvm/s390/vsie.c
>> @@ -1502,6 +1502,24 @@ static void put_vsie_page(struct vsie_page *vsie_=
page)
>>   	clear_bit(VSIE_PAGE_IN_USE, &vsie_page->flags);
>>   }
>>  =20
>> +static void free_vsie_page(struct vsie_page *vsie_page)
>> +{
>> +	free_page((unsigned long)vsie_page);
>> +}
>> +
>> +static struct vsie_page *alloc_vsie_page(struct kvm *kvm)
>> +{
>> +	struct vsie_page *vsie_page;
>> +
>> +	vsie_page =3D (struct vsie_page *)__get_free_page(GFP_KERNEL_ACCOUNT |=
 __GFP_ZERO | GFP_DMA);
>> +	if (!vsie_page)
>> +		return vsie_page;
>> +
>> +	/* Mark it as invalid until it resides in the tree. */
>> +	vsie_page->scb_gpa =3D ULONG_MAX;
>
> I'd appreciate a properly named constant in favor of the comment being=20
> repeated. This has been a thorn in my side for a while now.
>
> #define VSIE_PAGE_INV ULONG_MAX
>

Yes, I like it. Makes it easier to grasp directly without the comments.

>> +	return vsie_page;
>> +}
>> +
>>   /*
>>    * Get or create a vsie page for a scb address.
>>    *
>> @@ -1537,7 +1555,7 @@ static struct vsie_page *get_vsie_page(struct kvm =
*kvm, unsigned long addr)
>>  =20
>>   	mutex_lock(&kvm->arch.vsie.mutex);
>>   	if (kvm->arch.vsie.page_count < nr_vcpus) {
>> -		vsie_page =3D (void *)__get_free_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO=
 | GFP_DMA);
>
> Can't we go the kzalloc route like Mike did for the other page=20
> allocations? Maybe we can then also get rid of the free function that=20
> you're introducing?
>
> https://lore.kernel.org/kvm/20260906-s390-kvm-v2-0-2cf6434e6646@kernel.or=
g/
>

Sure, I do not see a reason not to as long as kzalloc() guarantees the page
alignment (which it does).
Will do the same for the vsie_sca allocation in the other patch (which then
should also be guaranteed to be page aligned continuous memory).

>> +		vsie_page =3D alloc_vsie_page(kvm);
>>   		if (!vsie_page) {
>>   			mutex_unlock(&kvm->arch.vsie.mutex);
>>   			return ERR_PTR(-ENOMEM);
>> @@ -1557,9 +1575,9 @@ static struct vsie_page *get_vsie_page(struct kvm =
*kvm, unsigned long addr)
>>   		if (vsie_page->scb_gpa !=3D ULONG_MAX)
>>   			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
>>   					  vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);


