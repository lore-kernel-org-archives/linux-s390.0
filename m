Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F4C5477E;
	Fri, 24 Apr 2026 05:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777007004; cv=none; b=DMAdBXlPKwE+D8Op7VL40U6ZODm9wCNr2EyrCoZksSh6axJgYPt1N8RPTtrUN8o5x2bvyVOPBpczxZXzHx/GZWVzKhPi/oG3/dAhmeAWTk8LNCml3dlUT+MTsNrtlycX83vDJbdrXJg7wvdr8cNKmk2BCsf4a2geNiRbteBCoQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777007004; c=relaxed/simple;
	bh=57H4gANWDMAmt9deBhVyAfxC3itsNV6V+s8eADe2NOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kanKyiMhssDbxDkNAUpMJTrEBZwX2jMVbOkiytxZMNE/ycs34eU5qidD3vnYNRFAlLpe+F3Gf422YuDUgrrWLbxn/JcfQu3cJt0OAkMwdwHs5k1G3eIJP/EsUxCgJPzez5Br0TtUPdMn+Mv7xoXqqlEt5zVoChZmJNyFScgKtUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sojw9rLS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sojw9rLS"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63NIYDYK3107496;
	Fri, 24 Apr 2026 05:03:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=I9eGPf
	6zLKqBoMQknTPdetZAYdwFTfVyWh7vjSqEfbQ=; b=sojw9rLSsu4UlBm6QE2neg
	/he7MeW1q29fkBY0IS+phwpyC6hBnhedTuA9FfMOZMJ6bcGYHBadJygyhFuhqgsS
	i4/NeEMLmYhv7/LW1BZKiv6K7gQSnLBfTq1UroIWGD+moMhIYQtlrUTIG/gvFiV4
	EcD+PU0D2Zq3FK50B1S58nYFHjEYpBgXncjTW/Cg/jBgaclzdWmMDm7uDxqRNyJa
	XbaWRf+fdl3hc1LsztHKN3mwukQV8Tp4zGe6cd1ERuu4SKeQQn6PpDo8NOu8feqz
	Dt5IK7PKV0B93F2sZlaRfSfhrA9zOZ9neKDqJECfvfIViZP3T4aR46zKq2J/j3zQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu6kdmj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 05:03:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63O4ZVfX029119;
	Fri, 24 Apr 2026 05:03:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dpjky1f3v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Apr 2026 05:03:13 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63O53CR032637582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Apr 2026 05:03:12 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F13C5807C;
	Fri, 24 Apr 2026 05:03:12 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB68758084;
	Fri, 24 Apr 2026 05:03:06 +0000 (GMT)
Received: from [9.124.217.59] (unknown [9.124.217.59])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Apr 2026 05:03:06 +0000 (GMT)
Message-ID: <473b85ad-215e-4395-acbe-e1f674de7855@linux.ibm.com>
Date: Fri, 24 Apr 2026 10:33:03 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Documentation: net/smc: correct old value of
 smcr_max_recv_wr
To: Alexandra Winter <wintera@linux.ibm.com>, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alibuda@linux.alibaba.com,
        dust.li@linux.alibaba.com, sidraya@linux.ibm.com, wenjia@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
        guwen@linux.alibaba.com, netdev@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260422085159.459678-1-mjambigi@linux.ibm.com>
 <b095898f-96b9-4211-aa99-58cfd5d4e538@linux.ibm.com>
Content-Language: en-US
From: Mahanta Jambigi <mjambigi@linux.ibm.com>
In-Reply-To: <b095898f-96b9-4211-aa99-58cfd5d4e538@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDA0MCBTYWx0ZWRfX2yfKjcd1QBLY
 /7aI+tmVRCeT5RdEURTFW5GvhkINiOWdm/cYlJtWWu7OmNyShi7y7SPkWvLogXmVeJ23optMgsy
 +kaKdJGSdWlxkh3tang5VULGOXbGFo/Bc3D9iOTloLZHQSkpU7VhYnmAnKkPPXq9ZFHpX7gN2qT
 hXUd8gRMlCpbF4ZDEahh3aKKsh7xuGYgb8TrPjBdZCl5EODH5EnpV08wVEm61uXG9fhkPI2FSvb
 apV87FWxLDKktYCCdo8emUGBn/LCVgYF4qfwJp4ne9D5omrDrTKp2JNFglGaTBWKuArJ+gqX7tO
 abACEKhPz3bMQHOnNV/DS7dhWh3d8Upsdk9hHxkLXLPjN2AZN0UJgTYMLZ2SEB7ITp4Gi93uw+3
 L2F/YD2QBUEIYtVJ+sKwJ+0lQvMNdQ90OXV6YFwopvTUDAbFW0gJWO6lkcnGFEfdQ2t6tw6ZbJo
 wJi7KqPMM5TeasbuceA==
X-Proofpoint-ORIG-GUID: fa8-GKUUkPuvbM16_TZBVQX_zpgmduPf
X-Proofpoint-GUID: yg4oFcU_8zA6ENyTbzlEZ4ffAN_0PTLI
X-Authority-Analysis: v=2.4 cv=BYfoFLt2 c=1 sm=1 tr=0 ts=69eaf993 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=Q623sgFOHVwvUY2QT94A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240040



On 22/04/26 5:38 pm, Alexandra Winter wrote:
> net-next is closed!
> 
> On 22.04.26 10:51, Mahanta Jambigi wrote:
>> The smc-sysctl.rst documentation incorrectly stated that the previous
>> hardcoded maximum number of WR buffers on the receive path (smcr_max_recv_wr)
>> was 16. The correct historical value used before the introduction of the sysctl
>> control was 48. Update the documentation to reflect the accurate default value.
> 
> s/default/historical/
> or remove the last sentence

I'll replace default with historical in v2.
