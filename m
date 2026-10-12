Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB2248CD70;
	Mon, 12 Oct 2026 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814904; cv=none; b=WmYHT/mVoKIuh2+di++eH9VRLBwTnLrRLiFbnAnrRY7PXm4kCRZxtlv4h9f3xstjtxdGJ0wNHiPmaoLi6siLcEgbxEmxm1v7po3gXBnC2OWrDtwPgqhKyphozrUto0GNb4Bgmr0fMapnFs9+DHmkV39jpF/15ALDgn2y/mDksHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814904; c=relaxed/simple;
	bh=6o1ohStyaYOsKepU3wFhRWizJqpFqA+VCFP1TNcxAUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ScEiZqaI47oAemCG5HtO0CkKWcRwmkinVaC7F4XYyg2xPcJIdXEFNPGQruJMuliukbBn3aNF14SmbnhDCgDHqiJJ0EbWOWCBMO+5fmnTGPyj3GtB1rXfPlX3VrV9Vw+5LqLV0LGfi+zmNzndU2rsQzBQs+PqZEArB1KQvrAmNW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NcHIjzTe; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NcHIjzTe"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEBEv182461;
	Mon, 12 Oct 2026 14:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CafniZ
	faM3HEgbOkOl9xe/8YRz6D3PCq9IaMspmIMvs=; b=NcHIjzTeJ1ySCZMOJyBeDQ
	Xa/2Mwza1+7qMQx0M5v2j17A62igxgmrUTAERRN2tEt8H77quLNWxGQ++WbsFulZ
	PzsBaaNTLIXrhmq6OkT+7kbHda+iFe4cAHYIxp45q5fZZZW2ENESiC7a5ehh23zd
	cvVT1AXM9AC/cQ5pteEHy6wPCByW4IcZb+tNn5iYyKqt/EU1xTsLJhdKrTb0eblO
	whqdNHmbk1OIRj5SkRALKBYKVdexqVr5jMAeWiqKA/y1K/s93gszM9XaU1cse6r7
	diYAWzQ6noiP8i2n43xev4vJqcx+rx4r0q14cb3gwdMuT1f13r4+2O+lUTXtmjBA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv39arv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:21:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC55Mn1238617;
	Mon, 12 Oct 2026 14:21:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppnp4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:21:41 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CELcns31326480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:21:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA17A20043;
	Mon, 12 Oct 2026 14:21:37 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67D6D2005A;
	Mon, 12 Oct 2026 14:21:37 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.157.242])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:21:37 +0000 (GMT)
Message-ID: <a2262be2-966f-4a96-b7ee-048c31601710@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:21:37 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/32] s390/mm/pfault: Convert inline assembly to
 EX_TABLE_INSN
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland
 <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
References: <20261001103247.1989111-1-hca@linux.ibm.com>
 <20261001103247.1989111-16-hca@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20261001103247.1989111-16-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9oX7maMn8q4_XoCJWZ0sNkRBhDvWQgnI
X-Proofpoint-ORIG-GUID: 9oX7maMn8q4_XoCJWZ0sNkRBhDvWQgnI
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6accecf6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=Xd7Fr9RBzWlSPAaGVCQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX6KbBM8sW2XD8
 BKe0Mb1whyd+Q9udAvwgAikVw7dZVcXF+j3hIfmrtshsLnrjDZkzCxRKQmTUkgiU9crzJ54wyuO
 A1cViMyyF6s5CipYp1wTRqcNSDMOF1Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX5vltw8DngUu+
 XvU63vrDM/6KrnZ3NJe4aJqAOblwVthr7UNAT05uu+g45l52I3jFmBG8zYNNL2YSiwuMfFhW+Px
 sFjdwDtLNt0BKzOlc8tfRIqqZ5+GVRf7uwSKJCL3HCWb47GB5QX4YXsgmIee5lK6ROBERFAjst+
 6QtxC4p/b/s4zunPvLNJzzueXyETJfPmMAjoUOdYAh8A/JNH5Qft+lw2EryNu/mUzwBc/XAagT/
 WrzJPDgNZxoGGZGUbbbQPgiPRk1mzkVc7q6HS8nX6l22x6POk0jBkHwxqCx6LE3vJwaJvc0/ddR
 /hYtXBY2q/9bdjlGyn7MmjDmE4VJUDusMZYVj795dt3Uk3eAZlfz9U9VfQ5knxd46gkOC4mibRi
 ayQQBGM7iY+pQjUa2BUk8QpBo9sqiElabPl/zsItGLKI49h9NqObvsATynfnfqLqQFirSgIsOcy
 C5SAqFRj6kKCtupL3xA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056



On 10/1/26 12:32, Heiko Carstens wrote:
> Convert all pfault exception table entries to use EX_TABLE_INSN.
> With EX_TABLE_INSN entries always point to the faulting instruction,
> so nopr padding is no longer needed and removed.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>   arch/s390/mm/pfault.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

