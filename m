Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88033E5EDB;
	Thu, 16 Apr 2026 19:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368782; cv=none; b=s7sKZM3JelUGj7lDN+OTv0ItYsX++E51WEz0Wtd0+S4xXySN43xOIxOkxck3eHBpFk2UbOw74ByUHYwOiTE+Tr5uc5IeLeFXRYSParB2VjMDLVby8VZfuYi9Gmq7mhnMGmpGGv8B1pcopP8pi0LriUxdQwCerKZnobzeQTqb98w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368782; c=relaxed/simple;
	bh=Qba1/DjP9j79qrIt9eT9VQDE+xeBg3Br581eaDk5yeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9XLEe+T+dWVxigKkgxYjjOcVaw0TbdFFPkt5d54ulXYFtxfgRE8HAQtBOh/qnzZ60iyy4Nkog0Nc306v6wdi4XcPNDUt0NIGgWBoToOt1mclf/0oUSO8HLopNFyCBq280vwwMIIVSi042W+Ui9SAXm27SeU0sqfbtzw/ww6Nfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=COpryZYB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="COpryZYB"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63GGXk1c1804464;
	Thu, 16 Apr 2026 19:46:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jeeMek
	tUbRg+1j/crALkKcX0WXFTyPcngLtgBgNp4cg=; b=COpryZYBMHi4GUmb2PpMwv
	gphnmF5Vx74DeNSvXCDv6AGWPTUZaTzgfD62ZqmCXU45WjOdGmYowP2etozeMVPv
	j4GCG8Pdi5A8SUqVkBXL5nP+C+4CRIT+x0Ov6CFh3KqQ7BtwuQUeuinpIbwRHcds
	V7f1D6T/UI1aEFkwGg5tdU4d327/Q/bwRAAnOU/Kw6YGrSLlt/PI04fvdRxmIPyU
	wiBrd8gNRwe7qCbRTh9FNdcTDwQ+FBATgwogl+PZ7lj5FAEE+Z1TOGASRcbJ7b3M
	KtW6Fa+s9lxoyDPKzHfGvvKcEEgC/9ndIBN1HiMqysiixDNjeu8VaIZr+ReIK9Gg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89kebxf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 19:46:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GGhgQB003305;
	Thu, 16 Apr 2026 19:46:08 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh95ysr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 19:46:08 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GJk6t627591186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 19:46:06 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88DDB58060;
	Thu, 16 Apr 2026 19:46:06 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C724A5803F;
	Thu, 16 Apr 2026 19:46:04 +0000 (GMT)
Received: from [9.61.14.120] (unknown [9.61.14.120])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 19:46:04 +0000 (GMT)
Message-ID: <f029675e-7b96-4d51-bd79-595e322eb135@linux.ibm.com>
Date: Thu, 16 Apr 2026 15:46:04 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: s390: pci: fix GAIT table indexing due to
 double-scaling pointer arithmetic
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Junrui Luo <moonafterrain@outlook.com>,
        Janosch Frank
 <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>,
        stable@vger.kernel.org
References: <SYBPR01MB7881AB7449FEB6B58E4BA6F2AF222@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <b1f22f3a-398e-4ce6-8092-aff9c9aaaf9f@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <b1f22f3a-398e-4ce6-8092-aff9c9aaaf9f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: FjDpwNH6TNcSLYtiUeAExF17pJszz9JJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE4MyBTYWx0ZWRfX9tPOARV757G+
 VGxmXERci4B5Mq23Rfnut98UbO7gWe9u6bS04+ZjRp3Kk2M2erw48A/bj9ttAzQrVggMrBf8GwQ
 Y/P2tTEXGoRvaTVjyeGFZVyW889AkkoNiomXp9HLFL2KpRpYMObxUdwvk6VTKOAqXtiJO/Fetfq
 kVh/q25+FEmjC3q+mR2q2rMT7q+L4bb53cZVYrU6vJ9Q8i0MjFUGpFk+Xhq1XT1xg6pkQFw8Tia
 2mZa0YYmtwXPrArUgXuZsGBsBgzd/yJ/IuIuDG1e+ZpdcVZJ30tnkPXaTrFIKZD/QzjQMKMhSGd
 brfTz7TGf72XT0f/ObV3TEpOwjA6goSqAOHPpKGC10jdCE8ycHVF/t48vQr8kcImT/7w7sT4843
 aRfBeEGMuT15Y1GPZtuP4EkWeA44j9gdIagatWmUd6JkuhN5VEAVmDDRguL7ulNg5Bjn8byg64N
 NK27QdxSN2FMEPcLL1A==
X-Proofpoint-ORIG-GUID: PYdcw58jvlA0aP2oQbymL33tjU_nk0jF
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69e13c81 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=VnNF1IyMAAAA:8 a=9igQkyFze_wNDWW7dj4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160183

On 4/16/26 9:06 AM, Christian Borntraeger wrote:
> Am 15.04.26 um 11:26 schrieb Junrui Luo:
>> kvm_s390_pci_aif_enable(), kvm_s390_pci_aif_disable(), and
>> aen_host_forward() index the GAIT by manually multiplying the index
>> with sizeof(struct zpci_gaite).
>>
>> Since aift->gait is already a struct zpci_gaite pointer, this
>> double-scales the offset, accessing element aisb*16 instead of aisb.
>>
>> This causes out-of-bounds accesses when aisb >= 32 (with
>> ZPCI_NR_DEVICES=512)
>>
>> Fix by removing the erroneous sizeof multiplication.
>>
>> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/
>> disabling interrupt forwarding")
>> Fixes: 73f91b004321 ("KVM: s390: pci: enable host forwarding of
>> Adapter Event Notifications")
>> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> 
> looks good to me.
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> 
> Out of interest, was this found by static code checking or AI by any
> chance?
> 
> 
> 
> @Matt, can you test/review this as well?
> 

Thanks for the report and the fix.

I did some tracing to confirm the issue -- indeed, gaite is being
indexed by 256B instead of 16B.

Because the incorrect offset calculation was used consistently in all 3
spots, the expected gaite is always found; a problem only arises once we
attempt to access beyond the allocated number of pages for the gaite array.

When this can possibly happen is a factor of the configurable
CONFIG_PCI_NR_FUNCTIONS -- but yes, as the commit message alludes to,
the default for this is 512 which means once aisb reaches 32 * 256B we
would cross beyond the 2 contiguous 4K pages that would have been
allocated for 512 * 16B entries.

I also did some general regression testing with a mixture of ISM, mlx
and NVMe devices with this patch applied.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
