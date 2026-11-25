Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620762;
	b=RgQI66FVnckuK6RPzzwWWSWL+GDDPERgNn+d46F0PbEQeGJ0zrjVIRAoZ3m7MyeFMOoj
	 7Z0K+mk31/gtbq3+voIjtbdr5KY6uf05hrIBBcjRyH7KHzdI/e1SWlvz90YT7Mma8ihtk
	 8nJ+fKsZDwpzxHc8ESsvADv7WM1fGxpew6rlMrXU+yy2lsRN/YDF4PfvLM/TxGommdqga
	 oU156vVMJWpMK5IxfmzEQvVxgGHpIALlzIyVXyfpuGSWePn6464ziTt0tsiTP3C/SGvbT
	 Yy5sTWPq6fTII0FzQ+2oAyn8VMXfT+OXnt2nCBeuwV6S8nRrhLoDj6IivlR3437EdGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620762;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4pcbxCQpHnjfej2Pb47u9IiTlMLuBD74I8/PGaiLL2I=;
	b=AA2c5rV+Orz5InR96pKVS4NfN2pviaBvwJ3dPLaFp1q8+eUzJESuwxwAYfjMZ45Vf2a1
	 9B3npSh3hMeNtmsIKnTduS0zikvbg56GZ00OfdOCyyP3QeBfBaMW85oGyR1MlXIEhA8he
	 R/afurKt2cdInGeWLh2ImYGUl3USN/pwbGVAq6MIenNMS8tzRmqYz39LOx8ux/wP1/+X3
	 OP0T6/vEwbu0jZ/B6iS+Lj7bJZFL+fUwyspku2SPBLKd+QBv94FBCQnghuirAi6510/3C
	 aLgch+tDMmSuNWfelbAcSAIRCudLwA7aTbgYm+RgizKQcFnf6NB1KfJVaeR4UUqq8Og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CK972qqv;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D8A606A31E;
	Wed, 25 Nov 2026 15:32:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33D8A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=CK972qqv
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEYlFA1602794;
	Wed, 25 Nov 2026 15:32:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4pcbxCQpHnjfej2Pb47u9IiTlMLuBD
	74I8/PGaiLL2I=; b=CK972qqvhHaY9mSoR1fN6G12TGcYlVYcYEqAT1Aq/e3IWS
	ynI51DF7ld+ExOkn3RxrUa3gwcTO/KPC+LvPA6JpviEQonFriIk6eUoJMLb1drBM
	ulMi25ezUrAp5fgiIe7fY8jfUDx7jyzgHAkPro0eAR+DO/Eo/oWnj3xvAE6A21uq
	sYsUZjJHvCyoJrFHVqjWue1xS7jDF2z08QQc4+2LKY4rwvI+ebxCTvS9156cZhCg
	cfABEgBfK8vjmHfhYx2gSHmz4R5Fbs42JXlbRBIgeev8obpElC8/7WTgdqnxvcpg
	IODY/dyS0kiO2FeMY/kd7yZZJsXQKgeToTdmjONQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkn59d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 15:32:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6APEKXYX918513;
	Wed, 25 Nov 2026 15:32:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j5dcuuv8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 15:32:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6APFW3SR47251732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Nov 2026 15:32:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABE732004B;
	Wed, 25 Nov 2026 15:32:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5167D20043;
	Wed, 25 Nov 2026 15:32:03 +0000 (GMT)
Received: from osiris (unknown [9.68.29.29])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 25 Nov 2026 15:32:03 +0000 (GMT)
Date: Wed, 25 Nov 2026 16:32:02 +0100
From: Steffen Eiden <seiden@linux.ibm.com>
To: Joey Gouly <joey.gouly@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Fuad Tabba <fuad.tabba@linux.dev>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH v3 03/23] arm64: sysreg: Convert OSLSR to automatic
 register generation
Message-ID: <20261125153202.117976-B-seiden@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-3-75e95980fb10@linux.ibm.com>
 <awbuY0mETtZ_mQh3@e143914.arm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awbuY0mETtZ_mQh3@e143914.arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX/NUMUPbHtYAt
 SBqPklk9AkJR3xQscWUb+f0DjxT6kV/kKyzTYS5sjH9ZUCJKAnevQu5lvkNmNh+mx00OUGUbkWv
 jjuibY0pkEKt11siKIMCPZBdMM7+kh87ZffPZTmOE+1PW1vJEFHSe9Pfr75pGwpU7SnJXK5D/fu
 Q6+6mflTmzly5fnjhelCX+ItgipPuvYH3MQVR9zJSeHPDz1rYtwO//md7N1hUElXhKmJmIImyKv
 hu7y/Qi6rk11KeIp3TsafWBK7TS1cItcezbca1z1MtwFvcu3WAKG1zGdSyB9uAC+ztihTfPcNeN
 Qmiiz5zhivgKFBWqy+ulxfuQ6SGFfRMPScr37x6z+08KJYZjxqxdCYnPFnTi4zUHCIf7Hluzgdz
 vseauTpOvxUOR56QY+uk4nNORRVOu97Z5QLioztStQoE+elhWx2xPbXw/pcIxQsZWLYTMitYBaH
 QVyQsynlLGhvzytPSIw==
X-Proofpoint-ORIG-GUID: CDsbJr9gK51GZkzZX73S5vFuDg4Ga37W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA2MCBTYWx0ZWRfX5OJB27YFMq71
 CL5nVKK5wn9aXa8dxUuOKVGJmZI2slPpKyMf+o5SEBSifgf+gSzy0to5MSBMpx3qm0etWUh0Tj6
 4U3lgNkIfqMEYbQ1Ic+dIShZjB1aEQU=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b06ff78 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=7CQSdrXTAAAA:8 a=kDbVKrEIACoO4ZT2jxoA:9 a=CjuIK1q_8ugA:10
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: CDsbJr9gK51GZkzZX73S5vFuDg4Ga37W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250060

On Wed, Nov 25, 2026 at 02:19:15PM +0000, Joey Gouly wrote:
> Hi,
> 
> On Fri, Nov 06, 2026 at 05:07:36PM +0100, Steffen Eiden wrote:
> > Convert OSLSR to automatic register generation as per DDI0601. As
> > OSLSR_OLSM is a composite field using bit 0 and bit 3 the combined
> > values are still defined manually. While at it rename
> > OSLSR_EL1_OSLM_IMPLEMENTED to OSLSR_EL1_OSLM_IMP to be consistent with
> > the rest of the system register values.
> > 
> > No functional changes.
> > 
> > Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> > Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> 
> Need to do the Sashiko suggestion, it does fail to build.
>

Will do. I'll update the tools copy as well. Thanks for the reminder.


> Reviewed-by: Joey Gouly <joey.gouly@arm.com>
> 
> Thanks,
> Joey


Thank you, 

	Steffen

