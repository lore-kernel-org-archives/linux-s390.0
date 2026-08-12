Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24236224D6;
	Wed, 12 Aug 2026 18:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786559549; cv=none; b=ciWGwlXh51+5pcDabglzZL0NdPWmGWnTNHhvhfhBYFy9yivK6cXYzGL1JFIh0joxB5CUJypwwK2raGxIWE6ohPg3ob1vYWFEt/q82f98OIi9+fjHZvRLRghlYdFC4WOedpr+W2YO16Bnv4318xDjM9ISnYwH0y07LakkxewIYGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786559549; c=relaxed/simple;
	bh=rFmjLrtfYacXlaTBDxSf9fZfxnESnF6ZN2dsd80w7wE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAOFtpYrk6xSxDKijZNweQ7u+IqwSga374JRtjhQGIkxRnC1e6UJn2nFSPGhVmIc93YWYN1qx440J9aGl3Uhg3Q2GDhC8DaGQFBRq7tnFWD6nbxz08Lpn0WOx6dJP1SZ1lPxvIEeR4rAbzpeYj/yKtUNfuEFeunp8+Ks78lvjgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=En+T51bO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="En+T51bO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CH1a7T3994381;
	Wed, 12 Aug 2026 18:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=okFdoI
	S6XfSDlDB0pniyw0cE1iD4IxLcZ4kFa7I2rqw=; b=En+T51bOZbP0Qd1B7JlRin
	yh7LcbUVlRIh5KT8JTatMTQr7te5HmB/kmCB27dh5+ORgJ+CiCnzErtbWhh6ZjwV
	5Ptme75FDRls1N+NmI+A55b3+eKWMcvWtj8tcRQAfVTqcoxI2BIomzcXmeQTv4J0
	LELCtYjIlagSEIrILya1AMFMLfl7cE5ISy9C7i3mb6kLeFHXY0F1Cl/R5Ca/YQHN
	UpPmcwHJwkqVbpKrvjwM+AsCr+YRuhY5JqfJyPra1ZzHqUJ1G68Oyg5sNsr/RAnx
	VO15EhmSegr6k5DmqgrBwkc3TowtUoUpd7N8wEqLejWNnMQnypn5kpL4Fq5rXtwQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp336bc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 18:32:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CIQLRh013188;
	Wed, 12 Aug 2026 18:32:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq7k28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 18:32:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CIW3uR32178558
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 18:32:03 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C0B520049;
	Wed, 12 Aug 2026 18:32:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EDF220040;
	Wed, 12 Aug 2026 18:32:02 +0000 (GMT)
Received: from [9.87.128.143] (unknown [9.87.128.143])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 18:32:02 +0000 (GMT)
Message-ID: <724c04bd-f725-4409-82e5-94a63a1900f9@linux.ibm.com>
Date: Wed, 12 Aug 2026 20:32:01 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 16/33] KVM: s390: Move s390 kvm code into a
 subdirectory
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
 <20260812153631.3376090-17-seiden@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-17-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7cbc28 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=EQfAt2u_B7ro7Q8_flIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZPB-Rpz1g85S4Jmrnn_4co1oTvG4phtp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE0OSBTYWx0ZWRfXyGHWSaRDCrf4
 AZp0vtL1TrYNuvchrUO9tbOWFZokEWvcXW1WlQlvj737oRFfV1VVv1YOFS3g/Jhnuk4clCWRy9s
 REcnCY5k74pB+mCfC4kQV3YL+dUYTHR+sL2EsWYkuNTZyiUa6vsXWIF8txLU9YA+PF2tZYGBtGc
 LoMNsClAGHe2za4mt9FuKbQBXRjrztYhP0uVKPDlTK1nTMQdfBTx/cAV6CGnAOnnU70VBrHjVaL
 PMb+4pnzJ9+I4Z+z3e2cPlWNwWFEJfGjBUWQJ27n7Ft5tWgM5Rx294v4Qi1C191St6wwEZ3nJ4d
 syw1uUDSwsbv+5Oj4hlwUZYg1hMZh6DkYefRXzKMczdhC6W07EDIzqH3HHMDMpfotJpRLe1j7TQ
 Vv0F3eUKa1gx5va7E/+Tg1zTseACdrOgxQlJG30vPKQVtkIKV0TWuz+eeZe8eCPmcQYsqMDTXjo
 KYplnBrkSvK4/0Bzyfg==
X-Proofpoint-ORIG-GUID: OjY3KTKN4jMyaBFleawkpmY6CEwNrlvP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE0OSBTYWx0ZWRfX8Ad9dcnOPQdH
 W50K+MUu6F0m/J7zH0FtDcdiHHIfWKyUNz5o3Wpi4QssWiCiboVUpu7wgFfggFGq1ANOjAtg6IU
 2TPEJqNmX4uzkYoVJLEqFod8yrIbsyU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120149

Am 12.08.26 um 17:36 schrieb Steffen Eiden:
> Move all the code required to run s390 KVM guests on s390 to a s390
> subdirectory. Move gmap related code into a gmap directory to later
> share gmap code between KVM implementations.
> 
> Update S390 VFIO-PCI MAINTAINERS filepath.
> 
> No functional change.
> 
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>


