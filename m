Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D283418368;
	Wed, 23 Sep 2026 11:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790164476; cv=none; b=s0QADjcU+EJW35MwsA+6eHmt33AysNrowoHeQ/ioz9se7MOoCq3emobQf/+WiKzwSVqkVACJzaC8DcPnGd/IHK82dtqql8h1V58K9RBY46Zb/tsMnCZjwHc4m+pS2LKxbF0osPLiTyX3e4gMaU3eCSCNsXlau261ziKB+tdve2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790164476; c=relaxed/simple;
	bh=0eGTbs6x27XREkZpzKfnORk5U8lGQn+JYKSKUEUomoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o4G2bJ5T51QbqHKcytUCIFydPrWJtMf7aGO9+IZvyl/sXZQlQp1hZG5+ZsptcV4rh/awk37IRzy58d//8z298alfodv4XAHJ6RJ147AKSvm5cmUsghvu/ABP36AI5HGhc7yTIOlzht3bvGksXIWIlwNH2fmKG0/OUiEdRM5np40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OY42hrbe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OY42hrbe"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8ZqcN2909163;
	Wed, 23 Sep 2026 11:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=26r4SM
	ToBij/IPJMTKDm/KMpsEv8oG0bFsklwQjE7MA=; b=OY42hrbeAk5xNe+aPYZLni
	oNLXtfo/zd5BUn45oSUWTAUdCVRu/G75wqJqypfvq4loQBTms4+oWfNgba0oOIRH
	T/q+015ifNlVJ5atcuy31Ga1F6iNORD45+6XzwRR/8wvxsdQHaKSS3D6zu7mYhu+
	dCaux1QRopLLPhWK2f2XFSTF+ucrYDJZTJksDsb/AucyMGoLReP+8Fxj6XwzAdyI
	UMNUC3KGzDx2IKMwrmsIG4uHzEBpicwV6Wlz3bvyhOPAERcUbOPZXtXohe2D96cD
	vJY7oKrBw/HFQYDoQSOr4hx+5X2D3fRQ1+mY2MOdUCWTnScCLdfgvIzOSUYKHN/Q
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2k1e3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 11:54:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8II4K2891810;
	Wed, 23 Sep 2026 11:54:20 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkgqrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 11:54:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NBsG3K51183930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 11:54:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A835F20043;
	Wed, 23 Sep 2026 11:54:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4AD3D20040;
	Wed, 23 Sep 2026 11:54:16 +0000 (GMT)
Received: from [9.111.80.133] (unknown [9.111.80.133])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 11:54:16 +0000 (GMT)
Message-ID: <14552c47-8b20-41a6-a194-5aee626251de@linux.ibm.com>
Date: Wed, 23 Sep 2026 13:54:16 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 08/21] KVM: s390: vsie: Create helpers to alloc and
 free vsie_pages
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-8-f39806eaae37@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260918-vsie-sigpi-v7-8-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: K2Umxa-fYc-Aa0JIeVvmlqMThBPqM8fb
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab3bded cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=aDvQcrh6NMht_m6PRzgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0NiBTYWx0ZWRfXwlF+0QADd3p1
 MU7ktL829zaI0VvOaj49drvCv26dMazWNL8rc+hIp3cpRvu6UnAYmINSVoGjSlPe+LJVvJVrNLg
 SWsgSadWG+m6hdYg0NfiZf+6RCxK3/8zjReXbr6XLBm7nqZ1VzDpY3BA2bPqpqIodc30CVlWGif
 aE4uG7NV+jlfHR1cZHeE0z875THFkeP13CZc9YHxU1ZgR3I1mXs9RL8BltLUS6WR0nSN91pY31b
 a2yq0dDBdsN9CXdwvBR+PIM4HUyyo6o2rAE5tlHZjSqh0vYgkePetl8Vg1u0RCK3AIXHpvNMkRG
 WitTzZ330u4CwiYOU7oRnM+UVQ5MRy6unHdFSYFzeUZ1oizJWnpKq3YfsO2kDVci04ohZ7j+5WC
 R1ByxToGqy4mYLe8b54eezRXkAM4mOMVDra0ECvRsRt69m9CVZkKsq70p3cQJFqNc7J3nDzqCzJ
 UUnaCs5d9a5ZPoCn3BA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0NiBTYWx0ZWRfX/94lJeDtd19m
 okNWkzQgnMUDzemzmqrPIn9kobQ0sFSD90iY+SDvIFk3SOpjSUay87NEb9eLALDyo3MVgTeG6vX
 oQSMVaTkCWA/XiDa85qYJLG1skRr+lo=
X-Proofpoint-GUID: FbfqH2gh3htGFTgrUpxgYhsOG6E7kB1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230046

On 9/18/26 5:09 PM, Christoph Schlameuss wrote:
> Encapsulate allocation of struct vsie_page and free into its own methods
> to allow this from multiple code paths.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   arch/s390/kvm/s390/vsie.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index afc2e56fcabf..e7005bade757 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
> @@ -1502,6 +1502,24 @@ static void put_vsie_page(struct vsie_page *vsie_page)
>   	clear_bit(VSIE_PAGE_IN_USE, &vsie_page->flags);
>   }
>   
> +static void free_vsie_page(struct vsie_page *vsie_page)
> +{
> +	free_page((unsigned long)vsie_page);
> +}
> +
> +static struct vsie_page *alloc_vsie_page(struct kvm *kvm)
> +{
> +	struct vsie_page *vsie_page;
> +
> +	vsie_page = (struct vsie_page *)__get_free_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO | GFP_DMA);
> +	if (!vsie_page)
> +		return vsie_page;
> +
> +	/* Mark it as invalid until it resides in the tree. */
> +	vsie_page->scb_gpa = ULONG_MAX;

I'd appreciate a properly named constant in favor of the comment being 
repeated. This has been a thorn in my side for a while now.

#define VSIE_PAGE_INV ULONG_MAX

> +	return vsie_page;
> +}
> +
>   /*
>    * Get or create a vsie page for a scb address.
>    *
> @@ -1537,7 +1555,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
>   
>   	mutex_lock(&kvm->arch.vsie.mutex);
>   	if (kvm->arch.vsie.page_count < nr_vcpus) {
> -		vsie_page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT | __GFP_ZERO | GFP_DMA);

Can't we go the kzalloc route like Mike did for the other page 
allocations? Maybe we can then also get rid of the free function that 
you're introducing?

https://lore.kernel.org/kvm/20260906-s390-kvm-v2-0-2cf6434e6646@kernel.org/

> +		vsie_page = alloc_vsie_page(kvm);
>   		if (!vsie_page) {
>   			mutex_unlock(&kvm->arch.vsie.mutex);
>   			return ERR_PTR(-ENOMEM);
> @@ -1557,9 +1575,9 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
>   		if (vsie_page->scb_gpa != ULONG_MAX)
>   			radix_tree_delete(&kvm->arch.vsie.addr_to_page,
>   					  vsie_page->scb_gpa >> SCB_ALIGNMENT_SHIFT);


