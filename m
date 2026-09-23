Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836EE49BD92;
	Wed, 23 Sep 2026 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167221; cv=none; b=hmgijv3ExG2aFHNxdHGVM8+fLMlOHOhnWjPoKAD+D91Up09pd9V+eyhBP6Pg74yvLcu2CHzPCaB9RV+c84WM5v5GTfITm51vVEOSKcJxkiRA5ENljBAjJI0rvUtiAEKwiKnmHvbTbVE+uXGhmkGYB6ZJYakk3SGPOC22YLzHEKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167221; c=relaxed/simple;
	bh=rJY8ge6rCZ9Q8pODTJ6F7OwUoTa9UdStelKSER073QQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3iowQPDivp0ZcgWeWfBrK9S6J90msn0W9TrfoswR8KD9AKqpqfQzGCasrPBTl1i9eoLRC2pNVD700IWTATqh+6X4k9STvDOx8ZbZQCA+oBQNygagrHaiH3rRnEwg0kfrS5L2SFTVk6XxmGWsDS9pkYyQcUMbPHGEeJiaPpyahs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EjCEfRu7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EjCEfRu7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N8Zscd1031451;
	Wed, 23 Sep 2026 12:40:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CPtNgf
	2ejJUELxCf3lAR9MsJWtYgjCZqIvaI4J0wC+8=; b=EjCEfRu7MHpQFJH3eMxfk9
	tAm5NfWvl+BBCkzwkiRjaKbKmwWWSqtnWnBElSzOnD3BhVJKJ0Lh+bpbpJV5aR7N
	eyX5HiXH+A+JvaltXQpPdtCz1GmgPWaDY1wo8O82r6n3gYlJtfKImQiGQbsmJEyO
	lPQVOwmULbqVEldvygSmXKaRnGcWXAlTfiQsVRKb9WjqaW/KYfQTyq0Ss/miCQMF
	0vlUHp59TPqHNHb/FgZjhln+dKKKJvq8KLgm2etgeM3th3w9rgsWpBopslcJQGWw
	ThmbaXNfKQBIQUj1e4IuTw2eRJ8/j5Tn+NX6dHRI09+lT9FcIO+yv3MlvusIfp0w
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1u84t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 12:40:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N95hlr005936;
	Wed, 23 Sep 2026 12:40:15 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu8rtfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 12:40:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68NCeArl31588674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 12:40:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D083C20043;
	Wed, 23 Sep 2026 12:40:10 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BC3820040;
	Wed, 23 Sep 2026 12:40:10 +0000 (GMT)
Received: from [9.111.80.133] (unknown [9.111.80.133])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 12:40:10 +0000 (GMT)
Message-ID: <5df0f9d6-6856-4b19-b5b8-a54aa23f2095@linux.ibm.com>
Date: Wed, 23 Sep 2026 14:40:10 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/21] KVM: s390: vsie: Replace radix_tree with xarray
 addr_to_page
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
 <20260918-vsie-sigpi-v7-9-f39806eaae37@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260918-vsie-sigpi-v7-9-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: mnh-KRU2lOsUcHdmtoMdPllIBLgladeP
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab3c8b0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=DponMWe7-xSqsNA-YoAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA1MCBTYWx0ZWRfX9I8LQ6wkk5XY
 qdPcgA+dp55YqqzKtM5aRHS+tszc3g4kraNIW+qA0+buia/AFsitTPsSrQhNt7xEny0s9meKA79
 ipqqZN+7yAvp4HGBtIjM12Zv19KNG7I=
X-Proofpoint-GUID: P3dycCgMYcO32UV5YkNXIeIEhBaEilBb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA1MCBTYWx0ZWRfX4VujMLD7MbHw
 gzYXPqjyuaCWkAjjYTNo5cP73wq64VuVZlmyIkx20JcdWKkhSVsrSLD15+2wGsfzbZ2Y4yShc8/
 O/41x1ntHQbZ2XizQ28pCSgPLrOA93T94c6THB+K8SMFIf+PleEwdffJIFXqB1fA8QmG53S7GqH
 c/bVnEZDmpl7h5bcA1MCKtNpb0dCx0FS1PGhfotqIr4p40cgQtJs7t/Wg+SKJOoo6yP/4mdB2da
 mihjROk198Rlw/UCMcg33ZHSTiE0FGE6qBsFoheZMGylDL/OqtKfHwiIho3Vmz2TzMM/C7CV7ZI
 qho2HzR+N0JIvAJny2wZt5bp1izjiibPJCUYFBp9517WmBAFcSUVFzs/6X61hFQ9MAj0cGPajKX
 utFg4B/aSVNmhtzJ2d2+41zyOS/t+ncghmwvWRMWCrj14wr7wvCq76jMHNlLctgeYBkwbdvEBXh
 55JLWsRSQJdplxegYBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230050

On 9/18/26 5:09 PM, Christoph Schlameuss wrote:
> The underlying implementation of radix_tree is xarray since v4.20.
> Changing to the xarray API directly relaxes some of the locking
> obligations and provides more symmetry with the next vsie changes in
> the series.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
