Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045B5483BDE;
	Wed, 12 Aug 2026 18:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786558411; cv=none; b=pVI02sQcEu5LMHrJ2RYq5fXRy68KxewyX7QnDVt7HBIj8xPNZwvn9zvG8vHh1UYghJ84ykj8DFDHxRcooEEdZBLlgDQ/HJRhVfEc21sdwWJXMNe+EtJ5EWMrVt9TcwJLUyeK80CnVzrh7fAmMWa319r9wMOoQ9ttOAncU55CvdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786558411; c=relaxed/simple;
	bh=Lk2RrlDAtXzkQSpU4fqKVVauO1qmIi2Q7x/f5Bkt6Fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qsPGGe4OjR28UJyaxlhf9jktnV727ZUzntqBTJ9R0Y7O88luId3sf37WAG+O8F6e8UQ/WHxqNFuTuYrDB3jCXkneuronIJQbg/olEnfnQFUuSIc18s85mjV18GJY1RthdcKxFA4WgUFHSoTQZFPhJLG9KSR6cH19mQbPteyACeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YwNlw8fl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YwNlw8fl"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1Svw4040648;
	Wed, 12 Aug 2026 18:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JG39/F
	4KEfF7inLCq813KLTycRSDoXWv8uD9Shm+z+w=; b=YwNlw8fl7VP6ApJJ9JTOa+
	xGYnbMSSEBo7kGAKG6xasiEnCuJzvzAHYVxm6EFOx8JXzkHp1hU96EYEDzNMyt2E
	UdtdXO08Z3/9oAL1mQpb3jzja+rp7p6BI9E7W5vu+j9w1sifAQJfWKjTu8YWHkO3
	MAD/AzF8MuaajxbMsXJSSH3bXK2HDbcNiOqZTm8uvry2UoWq59vp9Cwz7PlDecQE
	nmxgLAU6P6YkhGBxDqhtJc/RpBV9Z5Q6suFbjQLGT5Q0TV/X3eUT7H3xJ+dCVGeJ
	81dtdg2Pe+okPkRXb8l0uITWwX7wHa5xKICZslrPTfEE5u3Dmf4YG1VCPpb/Jndw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9kx55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 18:13:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CIBNw6017516;
	Wed, 12 Aug 2026 18:13:03 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w7fff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 18:13:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CICxJl30343546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 18:12:59 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F09AD20049;
	Wed, 12 Aug 2026 18:12:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC28E20040;
	Wed, 12 Aug 2026 18:12:57 +0000 (GMT)
Received: from [9.87.128.143] (unknown [9.87.128.143])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 18:12:57 +0000 (GMT)
Message-ID: <4ed01037-4df6-49dd-ae2e-fdf83422916e@linux.ibm.com>
Date: Wed, 12 Aug 2026 20:12:57 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 15/33] KVM: s390: Move kvm_host definitions to
 kvm_host_s390
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-16-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-16-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: DsaBQ2h3naiO3Vo2oYkoKH1-T5s06xyZ
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7cb7b1 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=Vz5mpp0vxluPlbYFWZQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0NSBTYWx0ZWRfX5sG+8ghjFw9B
 3hGlAJaTVJO81fBbX4+2mVesHPIkDLCLDofnQdtRlEBNlPWhPfOTPbAUtdkuaEWpHPV5W1w/LQH
 bWm/lgB1guMgdtYhR03oqwrVM3tbEDfluvnS8PXg3WaJ7a9ybyTbMyLvfCU36QsnLN+73kR28at
 iuIwkWN7Jqf+QOo2YHfQeQc4HBrmpDu+MwnRkqIiRpj/b7Z1pa1io2s9qJ1BAas6Xx4eU1KAN5j
 z4mbMlvz0Mw7gUpdPbJbr3GGwJdxZoNWRGzfT8rnw2yCMuUhtV1ihHiZDmvmoIBkrBEyecEeDkb
 CHNXWADj/VqN6M2D0jwQ/iTQFgYTwE53Lf5JPMobIHSVkWmXjDeueAdodyA6LVwvAuJlfuPVGzc
 t46CtWyMxWnE5YD7t+/0eD2MNjSkgrhUrna9dq+w6yuDUi09pFzmiYXb/PMLDJVJtsY8A/GVjC6
 pLY+kC0knLoNeZKXftQ==
X-Proofpoint-ORIG-GUID: Fe3qyqHBNR55QIRDPbvdUnSJe2ysgWdj
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE0NSBTYWx0ZWRfXwfqwvJ0fRyi2
 o39pRT2WPS/wYglQns9+vs5SWaIYgpfre+b7y6PuoBJdUBlA7O+53GbxwpzLubT1gesiW1AIuai
 I3zrqUo0bmy1HyclBaATQIK8HBMk0tM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120145

Am 12.08.26 um 17:36 schrieb Steffen Eiden:
> Rename kvm_host.h to kvm_host_s390.h and kvm_host_types.h to
> kvm_host_s390_types.h to distinguish s390-specific KVM definitions
> from the generic kvm_host.h that will be used for shared definitions.
> 
> No functional change.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>



