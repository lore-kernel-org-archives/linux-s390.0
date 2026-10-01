Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FE34A49A3;
	Thu,  1 Oct 2026 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790856026; cv=none; b=JiF597Q/F8l+gwGb1SBM8cH3a8wswfIBmGHu2hyZwMCF7KigHevsosjLEBJyUhotfLL1Y18fODwDvePMdTGieny3/1ztQWFmg4ylQrZLsLSKX3iFS3dSqa3D219zxTM3LcVI4xKIXlYJ7k0CBzuu8i/LF9T5hCiIkK9zLMSnXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790856026; c=relaxed/simple;
	bh=jqIT6DVawj3x+vExN2MkirPVedmho48+v3Oefpvf3zo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vx4zZpcVlyKMP620Ex61OWMhtNH5fzMP3KeMQUjqwEzR+/CBK2zGkKMiNcQse7aUSJbQHSsRyYCZe2Lbhma61Fo0a+UvioVFT/Ay6CwoS1t0k27aaRd6m3/FoXgVREFKJnxPVhrTjuZSp3mVw74vtwsNLdgL8Safa5/n8SRPZyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WkEwzIuL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WkEwzIuL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175Wsx3446178;
	Thu, 1 Oct 2026 11:59:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+Mii9s
	LmXrX3tIGdggGiKFBAZ1UeTVJr1Z+7cys3DVA=; b=WkEwzIuLwMYEbxKmvorusc
	ACXSy6L13F5feGFY79IkykrYX98fLLANLUn93KGnsVmwH55tbMBIdvm7QG5LEHQO
	ljJnbyIDazBmedddPujIJCS5Sv/8boYB3LYbeMc7QKTwbKz/RBSQ/dLv9Q5uX5kx
	OBiTQsyBKf9pQ/7G80JCVkk2ahRfA5E+bpQb65aWjR9oA9m9rd/RAI9TeBSBNexL
	GrC14t1gGJv/6kqpF6Q+pF8Bj/xJ+yI1ZVvcjpGxAVdp/ZNzpBae84jclStoTrF3
	OEHsyMqcifHSgou0PC8ZmgeTIYOyw09mId2w6SBFkC0zFDRt0JnsT7+8bDF40JhQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrjxqq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:59:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 691BUsWM561208;
	Thu, 1 Oct 2026 11:59:54 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e8v99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 11:59:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691Bxo8A52298178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 11:59:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C73362004B;
	Thu,  1 Oct 2026 11:59:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 338D620040;
	Thu,  1 Oct 2026 11:59:50 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 11:59:50 +0000 (GMT)
Message-ID: <0c5fe5c2-4ab8-4d1f-a36a-84a8fd136160@linux.ibm.com>
Date: Thu, 1 Oct 2026 13:59:49 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/6] KVM/vfio: Use file-based reference counting for
 KVM
To: Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex@shazbot.org>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Steffen Eiden <seiden@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>
References: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260928-vfio-v4-0-e32e226d5932@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0NiBTYWx0ZWRfX9wizbY2YQrSY
 p4R9W9fU5AO8DzhZF24ezRqd5puW9dPDdp4jIddUN7HurOQrWjZKrlaGtYl/rsVv7tRhHtU0ZNx
 ZHyJ/ndMRlUFHeLOkjB4CQK9TSEW/kInjONtm3WOXCS4yuWfrMZMqSq+dEjnFhgytKK+iP378zC
 MyU9K2y8G/nZQO+5j2sNJqXbsh2AhC/kRPMcov+cRPHV/EQg6NPlPt0aX+qSb6axkRe2B3yYjYA
 w+jIOvG6Yep/90D6jCf4OdCiUjoeTUSDISCvKfGvVVTKhKrM4HyWhBRx3GSVkshPMlHU+h/fD8O
 OraQOkn/pq+8lyt9i0TLmWh9TjjJP98khLkW6BRjxSYu73XQ2RfAy1vv3HulXMVPS+FJQXfBtRQ
 P5pDo5msuBTlmgNFBXHKuIyPCIUhLlprVPKJlEvGFHj0yikmZJ7M1rMuRMb2TMYRwUjhkEOq+ZI
 4lRxa85UNw50hvxroew==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abe4b3b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=MxQh8XTz93SDlfTJ_6gA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ciblmQP3G39WiYi525DIXaHGW_DgMlVC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0NiBTYWx0ZWRfX/+7z1MBCt6Rq
 iF6KMy0QoXQwXcof4uwUVkxPDlBkG0I3VmAT2NwLXXhs1OY9DgjI+FrWadNnqDcBpasNAtXysH+
 tIUNfhF/yBTBKzHjdatiz0NRX++/7Fw=
X-Proofpoint-GUID: ZCCVuExlKT4JYX-TrbuWiqUmpXqmipoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010046



Am 28.09.26 um 15:07 schrieb Steffen Eiden:
> This series switches the KVM-VFIO interface and external consumers over to
> standard file-based reference counting, eliminating all external KVM symbol
> exports.
> 

Paolo, Alex,

I assume this will go over one of your tree? If you want, I can also create a topic branch
for you to pick if you prefer that.

Christian


[...]
